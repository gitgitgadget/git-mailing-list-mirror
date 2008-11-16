From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 resend] Documentation: user-manual: add information
 about "git help" at the beginning
Date: Sun, 16 Nov 2008 10:09:48 -0800
Message-ID: <7vej1b35lf.fsf@gitster.siamese.dyndns.org>
References: <20081116181001.97c45196.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1m5n-0006Uo-Tv
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYKPSKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYKPSKL
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:10:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYKPSKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:10:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE67D7E677;
	Sun, 16 Nov 2008 13:10:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3FFCD7E676; Sun,
 16 Nov 2008 13:09:54 -0500 (EST)
In-Reply-To: <20081116181001.97c45196.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 16 Nov 2008 18:10:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD936506-B409-11DD-9E60-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101147>

Christian Couder <chriscool@tuxfamily.org> writes:

> Talking about "git help" is useful because it has a few more
> features (like when using it without arguments or with "-a") and
> it may work on non unix like platforms.

First of all, I disagree with your idea to advocate "git help" as _the
first way_ to read the manual pages.  The way the current user manual is
organized is to help command line users, and _the_ way to get to the
manual is through the "man" command.  Yes, it is very nice of us to
provide them _other ways_ to get to them, but that is additional frill.
IOW, we _should not_ give impression that you have to use "git" (and "git
help") to get to the documentation.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 645d752..48f7189 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -17,13 +17,27 @@ People needing to do actual development will also want to read
>  
>  Further chapters cover more specialized topics.
>  
> -Comprehensive reference documentation is available through the man
> -pages.  For a command such as "git clone <repo>", just use
> +Comprehensive reference documentation is available through either the
> +linkgit:git-help[1] command or the man pages.  For a command such as
> +"git clone <repo>", you can use:
> +
> +------------------------------------------------
> +$ git help clone
> +------------------------------------------------
> +
> +or:
>  
>  ------------------------------------------------
>  $ man git-clone
>  ------------------------------------------------

I am not opposed to mentioning "git help" in the early part of the manual,
but for the above stated reason, I'd rather swap the above:

	... through the man pages, or linkgit:git-help[1] command.  For
	example, for the command "git clone <repo>", you can either use:

	------------
        $ man git-clone
        ------------

	or:

	------------
        $ git help clone
        ------------

This is a very early part of the user manual, and it would be a good idea
to tell the user about the presense of the comprehensive set of manual
pages.  I also think it is a good idea to tell them that they do not have
to use "man" but they can also use "git help", and hint that the "git
help" is a separate command (which is already done with the above
rewording).

However, this part troubles me heavily in a few ways:

> +linkgit:git-help[1] has a few more features and is self-documenting
> +using:

 - "A few more features" may be good in the commit log message for this
   change, but look out of place here.  What additional benefit are the
   readers of the user manual getting here?

   You already told them that a separate "git help" command is available,
   so they can learn how to use it by either "man git-help" or "git help
   help" if they are interested (and I do not think we need a separate
   example for that, after we've shown the use of these two ways for "git
   clone").

 - "self-documenting" is like saying git is self documenting, and/or there
   is a documentation.  Again, I find this an additional noise that does
   not help the readers very much.

It would probably be less objectionable if instead this part said
something like:

	With the latter, you can use the manual viewer of your choice; see
	linkgit:git-help[1] for more information.

which would be way more informative than "with a few more features" and
"self documenting", I think.  Notice that I said "with the _latter_" --
which is consistent to the order I think man/help should be mentioned in
the paragraph before this part.
