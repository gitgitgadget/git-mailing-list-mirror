From: eschvoca <eschvoca@gmail.com>
Subject: Re: How do I clear the directory cache
Date: Fri, 21 Oct 2005 16:16:21 -0400
Message-ID: <2b05065b0510211316j632c461apbb6f2f162e5fc7ef@mail.gmail.com>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
	 <20051020085931.GW30889@pasky.or.cz>
	 <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
	 <7vmzl34ikl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 22:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET3Jh-0002OT-79
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 22:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVJUUQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 16:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVJUUQX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 16:16:23 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:11999 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965146AbVJUUQW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 16:16:22 -0400
Received: by qproxy.gmail.com with SMTP id m21so62784qbe
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 13:16:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LPXre/uopDC4YJ6NeeNrJtmeI2oPuUwVY+IZxNWkShFAiHVkurWVadSxBIRt2GsbYZDJmB+3ROhZfZq7X9Khp8KHiZ8EFg1xwi+wpJtXhC417GWzQ5NfJV7VrS6TS67MHYUGROinmpW6y1cDmtmksjb6BnK7A/c7laXuYLYa0Qw=
Received: by 10.64.183.2 with SMTP id g2mr2305901qbf;
        Fri, 21 Oct 2005 13:16:21 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Fri, 21 Oct 2005 13:16:21 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzl34ikl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10444>

On 10/21/05, Junio C Hamano <junkio@cox.net> wrote:
> eschvoca <eschvoca@gmail.com> writes:
>
> > Yes, ... is what I want (how do I do this with pure git?).
>
> How do you do *what* with pure git is something not clear to me,
> so let me try to rephrase you and see if I understood what you
> want correctly, in pure git terms:
>
>  0. Your last commit (.git/HEAD), your index file (.git/index)
>     and the files in your working tree are in sync to begin
>     with.
>
>  1. Then you do random changes in the working tree (add, modify,
>     remove) and do git-update-index on them without making a
>     commit.  If your index file is fully in sync with your
>     working tree, git-diff-files would say nothing after this.
>     If you did git-update-index on some but not all, then
>     git-diff-files would report unrecorded changes.
>
>  2. But you want to revert these changes to the index file.  By
>     "clearing the directory cache", you mean you want the index
>     file to have what it had in step 0, but you want to keep
>     what is on the filesystem intact.
>
> If that is what you want, then:
>
>         $ git-read-tree HEAD
>         $ git-update-index --refresh >/dev/null


Yes, this does exaclty what I want.  Thankyou.

> would reset the index to the tree recorded in your last commit.
> You can see that
>
>         $ git diff --name-status --cached HEAD
>
> does not report any difference between HEAD and your index, while
>
>         $ git diff --name-status
>
> shows the differences between your index and your working tree.
>
> HOWEVER, the index file does not record "intent to add", so you
> would not see files you added in step 1. mentioned in the output
> of the last command.
>
>
>
>
