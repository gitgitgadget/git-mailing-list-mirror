From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Find .pm files automatically (was Re: Fix git-svn tests for SVN
 1.7.5.)
Date: Tue, 17 Jul 2012 19:01:20 -0500
Message-ID: <20120718000120.GG25325@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005EFC5.8060105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 02:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrHiU-0005W0-SD
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 02:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2GRAB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 20:01:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35659 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2GRAB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 20:01:26 -0400
Received: by yenl2 with SMTP id l2so1035913yen.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VLikymiwp+MU02Mu16VS8gtwP84Tt6XNE5FfrV6gyJ0=;
        b=Li6AIboepSaME1e2zxbFvZERnKdSiZHls0X5JKhmuvJiTNqP/7IIhUpp7hNnih/1L2
         XGQ0XZmblMqMV9DRgMK7no6kzPbB3sqLiPepBXEQXgKASO6bF7c6r1U5o/5W1Azlmf+A
         RdeZu7QdYnM1WRjojBwPMr9J7LEVBHKfpaJaiRBUGHh1kqvAcVl/OO5tGgh4kjDo9qb/
         y473PbCI+E/Yo5Y1iViGq/8uqtCmgHvive5Ng6w8XR5Bth7GZn0JXAcOJn8yGP9lU91z
         onSxO5TK5xu5Hhvoz0qV8r1VFvcVtZ9dsJCaZ/4qpp7bugHbwoMlXD6aONmKtHItWGOl
         NeWg==
Received: by 10.50.160.202 with SMTP id xm10mr430107igb.10.1342569685530;
        Tue, 17 Jul 2012 17:01:25 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id gl1sm26792612igc.1.2012.07.17.17.01.24
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 17:01:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5005EFC5.8060105@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201637>

Hi,

Michael G Schwern wrote:

> Ok, here goes.
>
> First patch overhauls perl/Makefile.PL to make it easier to add .pm files,
> which I'm going to be doing a lot of.  Instead of having to manually add to
> the %pm hash, it scans for .pm files.

An excellent goal.

> It also moves Error.pm into a bundle directory.  This both makes it just
> another directory to scan (or not scan), but it also makes it possible to
> bundle additional modules in the future.  ExtUtils::MakeMaker uses this
> technique itself.

This is not so much "also" as "as an example to demonstrate the
technique", no?  I guess I'd prefer it to be in a separate patch, but
this way's fine, too.

[...]
> From 47a723a860cded6b16a716ea74c5bc029ee5b0ac Mon Sep 17 00:00:00 2001
> From: "Michael G. Schwern" <schwern@pobox.com>
> Date: Thu, 12 Jul 2012 00:05:38 -0700
> Subject: [PATCH 01/11] Make the process of adding a module less blecherous.
>
> * Scan for .pm files and build %pms rather than having to do it by hand.
> * Move the bundled Error into its own directory so we can bundle other modules.
>
> In addition...
> * Add all the .pm files to the all dependency in the alternative Makefile
> ---

You'll probably hate this.  Because we have a bunch of patches to
incorporate, I think it's worth spending the time to make that go as
smoothly as possible for later patches.

 - the "From 47a723..." line is for your mailer.  Please do not
   include it in the body of your message.

 - likewise for the From: and Date: lines which are redundant next to
   the corresponding fields in the mail header

 - comments that are useful for posterity, like 

	This patch overhauls perl/Makefile.PL to make it easier to add .pm files,
	which I'm going to be doing a lot of.  Instead of having to manually add to
	the %pm hash, it scans for .pm files.

   should go above the triple-dash marker, while comments that are
   less useful, like "Hi", go after the triple-dash.

 - using a different subject line for each patch makes the reader's
   life much easier, so please do use the subject lines from your
   commits in the mail header.

The git-format-patch(1) manpage has some instructions for using
Thunderbird to send patches, which should take care of all this
automatically.

If everything is right, then maintainers will love you because they
can save a bunch of your patches that look ready into a single mbox
and apply them all at once with "git am".

As Documentation/SubmittingPatches explains under "MUA specific
hints", you can test that a patch is being sent correctly by emailing
it to yourself, saving as an mbox, and trying to apply it with "git am
<path to mbox file>".  If the resulting commit is as expected, then
you've succeeded.

>  perl/Makefile                                     |  6 ++--
>  perl/Makefile.PL                                  | 42 +++++++++++++----------
>  perl/{private-Error.pm => bundles/Error/Error.pm} |  0
>  perl/bundles/README                               | 10 ++++++
>  4 files changed, 36 insertions(+), 22 deletions(-)
>  rename perl/{private-Error.pm => bundles/Error/Error.pm} (100%)
>  create mode 100644 perl/bundles/README

Ok, on to the patch proper.

> diff --git a/perl/Makefile b/perl/Makefile
> index 6ca7d47..4f25930 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -33,7 +33,7 @@ modules += Git/SVN/Prompt
>  modules += Git/SVN/Ra
> 
>  $(makfile): ../GIT-CFLAGS Makefile
> -	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
> +	echo all: bundles/Error/Error.pm $(modules) > $@

The word "bundles/" left me a little nervous, because I (ignorantly)
imagined that this might be some specialized facility like Python eggs
or Ruby gems.  Is the intent that this directory contains CPAN modules
we want to be able to depend on?  Is there really any intention of
having more of them than Error.pm?

Before this patch, in the default case (with MakeMaker), "make
install" wrote a manpage in <mandir>/man3/private-Error.3pm.  Does it
still do so after the patch?  Will people who have installation
scripts that expected that manpage have to change them, and if so, is
the new behavior better to make up for that effort?

[...]
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -2,11 +2,16 @@ use strict;
>  use warnings;
>  use ExtUtils::MakeMaker;
>  use Getopt::Long;
> +use File::Find;
> +
> +# Don't forget to update the perl/Makefile, too.
> +# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease

Now the reader will have no reason to be looking at this file, so
these comments are pretty much useless.  In an ideal world, "make
test" in the MakeMaker build would automatically "grep perl/Makefile"
to catch modules that are not listed there, but that can wait, I
imagine.

Alternatively, maybe there could be a perl/modules.list that both
makefiles read?  That way, if I drop in an unrelated .pm file for
reference while coding the build system would not be confused by
it, and since both build systems would use the same module list
there would be no risk of it falling out of date.

Thanks for some food for thought, and hope that helps,
Jonathan
