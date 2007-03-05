From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 05 Mar 2007 13:10:30 -0800
Message-ID: <7v7itvxupl.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOKSg-0002wz-55
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 22:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbXCEVKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 16:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbXCEVKc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 16:10:32 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39002 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbXCEVKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 16:10:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305211030.JBFJ1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Mar 2007 16:10:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9AW1W00Q1kojtg0000000; Mon, 05 Mar 2007 16:10:30 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41487>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In case revs->limited == 1, the revision walker really reads
> everything into revs->commits. The behaviour introduced in
> c4025103fa does not behave correctly in that case.
>
> It used to say: everything which is _still_ in the pipeline
> must be a boundary commit.
>
> So, in the case that revs->limited == 1, filter out all commits
> which are not dangling, in effect marking only the dangling
> ones as boundary commits.

That's what I suggested initially but I think that is wrong.  We
should show only unshown immediate parents of shown commits at
that stage.
