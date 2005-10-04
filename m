From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 22:57:19 -0700
Message-ID: <7v1x31hlj4.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<200510031455.30187.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 07:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMfoF-0007sq-SC
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 07:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVJDF5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 01:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJDF5s
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 01:57:48 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:26571 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932361AbVJDF5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 01:57:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004055713.FCWJ776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 01:57:13 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200510031455.30187.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 3 Oct 2005 14:55:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9662>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> But why did we choose to make git-pull/git-push
> to accept a remote repository as first argument, and not a head/refspec
> in the first place? [Of course, this needs the remote repository be
> retrievable by head name: see branches/ files. And currently missing here is 
> the distinction between fetch and push direction].

I do not understand this comment.  I do not think you are just
talking about the syntax: 

        $ git-push <remote> <refspec1> <refspec2>...
    vs
        $ git-push' <refspec1> <refspec2>... <remote>

There must be something deeper you are talking about I am
missing.  The branches/ file allowed optionally specifying one
single refname (otherwise defaulting HEAD) since we tried to
become compatible with what Cogito did.

It appears that cg-push uses the same branches information for
pushing into remote, which is what I missed when I did
git-parse-remote --- we do not use this information to decide
the default ref to push into, and not to break expectations of
Cogito users we may need to fix this.  Is this what you are
discussing here?

> In the current state, it would be better to get rid of branches/
> parsing in GIT at all: By keeping it in, we force Cogito to keep the current
> format.

Hmph.  The intent was to keep people's existing Cogito derived
configuration working.
