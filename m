From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Mon, 05 Sep 2005 11:33:12 -0700
Message-ID: <7v4q8z5pqv.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
	<20050903220355.GA1895@mars.ravnborg.org>
	<7v64thl248.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509041329340.23242@iabervon.org>
	<7vvf1gejjf.fsf@assigned-by-dhcp.cox.net> <431C6167.4070703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 20:37:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLpX-0006P1-MK
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVIESeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVIESeN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:34:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:18876 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932394AbVIESdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:33:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905183314.FMVH7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 14:33:14 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431C6167.4070703@zytor.com> (H. Peter Anvin's message of "Mon,
	05 Sep 2005 08:16:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8107>

"H. Peter Anvin" <hpa@zytor.com> writes:

> One question, of course, is if one should simply keep additional 
> metadata around to handle this sort of situations.  One could, for 
> example, keep a UUID for each file,...

If I am not mistaken, that is exactly what tla does.  It seems
to work well in practice and seem so simple (at least
superficially, I have not looked deeply into the issues involved
in keeping it sync with the contents and how to recover if the
user ever screws up, etc.), and I can see why people find it so
attractive.  I myself once did.

But previous argument by Linus made in a distant (in git
timescale) past is now ingrained in my brain: "the additional
metadata" recorded at the commit time can only help us what we
envisioned in the past when the tool to record that metadata was
written.  If we try to "track" by contents, we can do at least
the same (diff -M being able to tell renames is an example that
we can get away without having a UUID) and possibly better,
depending on how much effort we are willing to spend "drilling
down" when we actually need to know what happened at merge
time.  What I found most important in that argument by Linus is
that the "drilling down" algorithm can improve over time while
"the additional metadata" specification is cast in stone when a
commit is made.
