From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Sun, 17 Jul 2005 22:44:08 -0700
Message-ID: <7vackkekif.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<m18y06pphg.fsf@ebiederm.dsl.xmission.com>
	<7vy8869ryi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0507161815100.15383@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 07:44:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuOQN-0002Xe-LC
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 07:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGRFoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 01:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVGRFoM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 01:44:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41461 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261522AbVGRFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 01:44:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718054408.SLGK19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 01:44:08 -0400
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0507161815100.15383@qynat.qvtvafvgr.pbz> (David Lang's message of "Sat, 16 Jul 2005 18:18:24 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> a very common one will be prople who want to setup a cron job to
> update their local tree nightly, in this case having a pre-generated
> pack file with each day's updates will save a significant amount of
> processing power.
>
> would it make sense to have it do something along the lines of sending
> the day;s pack file plus a small number of individual object (even if
> the pack file will partially duplicate object the puller already has)

I think that would be a reasonable thing to do.  The server for
anonymous puller, git-daemon, may need some extending.  As
people criticised, git-upload-pack/git-fetch-pack protocol being
not easily extensible, we would end up doing another protocol,
though, that's OK.

Fortunately [*1*], git-daemon itself is written to be extensible
if you are willing to introduce a totally new protocol driver,
so if this on-demand pack generation turns out to be too much
a resource hog, we have a reasonably easy way out.


[Footnote]

*1* We are fortunate but that is not by dumb luck.  When he did
daemon.c::execute(), Linus must have thought things through.
