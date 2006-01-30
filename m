From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 11:25:19 -0800
Message-ID: <7v64o18qn4.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<43DDFF5C.30803@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 20:25:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3eeW-0008Iu-8K
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 20:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWA3TZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWA3TZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 14:25:25 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38084 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932380AbWA3TZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 14:25:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130192245.GLYW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 14:22:45 -0500
To: Simon Richter <Simon.Richter@hogyros.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15291>

Simon Richter <Simon.Richter@hogyros.de> writes:

>> - disallow fetching from this repo, and
>
> Why? It's perfectly acceptable to pull from an incomplete repo, as
> long as you don't care about the old history.

I agree.  As long as the cloned one can record itself as a
shallow one (and with what epochs), I do not see a reason to
forbid second generation clone from a shallow repository.

> Hrm, I think there should also be a way to shrink a repo and "forget"
> old history occasionally (obviously, use of that feature would be
> highly discouraged).

I do not think of a reason to discourage it, and I think you can
do the "forgetting" part with the current set of tools.  Choose
appropriate cauterizing points, set up info/grafts and running
"repack -a -d" would be sufficient.

> IMO, it may be a lot more robust to just have a list of "cutoff"
> object ids in .git/shallow instead of messing with grafts here, as
> adding or removing a line from that file is an easier thing to do for
> porcelain (or by hand) than rewriting the grafts file. Whether that
> list would be inclusive or exclusive would need to be decided still.

I would rather not to have .git/shallow nor .git/shallow_start.

Cauterizing is not any more special than other grafts entries.
If you have grafted historical kernel repository behind the
official kernel repository with 2.6.12-rc2 epoch, I do not think
of any reason to forbid people from cloning such with the
grafts.  
