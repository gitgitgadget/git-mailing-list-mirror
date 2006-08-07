From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Mon, 07 Aug 2006 12:37:34 -0700
Message-ID: <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 21:37:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAux-0007zH-6y
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHGThg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWHGThg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:37:36 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6643 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932244AbWHGThf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 15:37:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807193735.EYPX2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 15:37:35 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608071626.52655.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 7 Aug 2006 16:26:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25032>

Jakub Narebski <jnareb@gmail.com> writes:

> This RFC is about better naming of subroutines in gitweb. The patch was
> generated on top of 'next' (7c7e45d0cc0f482aeb19ecb0b56e9e7b65472c56)
> using embedded gitweb-rename.sh script.

> Subroutines name guideline:
> * git_ prefix for subroutines related to git commands,
>   or to gitweb actions
> * git_get_ prefix for subroutines calling git command
>   and returning some output
> * git_read_ prefix for subroutines directly accessing git
>   repository files

 - (I am not complaining or objecting yet -- this is just an
   observation. ) The distinction between git_get_foo and
   git_read_foo is an implementation detail.  The latter could
   signal that the implementation bypasses the published
   interface but depends on the implementation detail of the
   low-level git, so it might be a good idea, but on the other
   hand the only instance is git_read_info_refs which reads from
   .git/info/refs -- and its format is part of the published
   interface -- so I am not so sure this distinction is worth
   it.  And certainly we would not want to rely too heavily on
   the current implementation of the low-level git, so we
   obviously do not want to add more git_read_foo's needlessly,
   which makes me feel even less sure if we would want
   git_read_foo...

> * parse_ prefix for subroutines parsing some text, or reading and
>   parsing some text into hash or list
> * format_ prefix for subroutines formatting/post-processing some
>   HTML/text fragment
> * _get_ infix for subroutines which return result
> * _print_ infix for subroutines which print fragment of output
> * _body suffix for subroutines which outputs main part (body)
>   of related action
> * _nav suffix for subroutines related to navigation bars
> * _div suffix for subroutines returning or ptinting div element

 - All of these sound sane. 

> How should subroutines be named? Do you agree with proposal, or not?

I suspect that the list may disagree with some minor details on
the naming guidelines but I hope that everybody would in
principle be in favor of this.

> Is such renaming usefull?

If we are to have many more fixes and clean-ups on gitweb,
readable and consistent names would be very helpful.

The problem is when.  If we are going to apply this, we need to
pick a point of time when not many patches on gitweb are in
flight; otherwise I'd end up asking people to resend using new
names.
