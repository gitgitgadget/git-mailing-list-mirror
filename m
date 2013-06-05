From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Wed, 5 Jun 2013 09:45:52 -0500
Message-ID: <CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 16:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkEyM-0005Pr-NF
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 16:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab3FEOpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 10:45:54 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:38253 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab3FEOpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 10:45:54 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so1967442lbh.21
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5JzYoErQ0tw3zmfb7XzZOGdWibQzClTZiRbPaMdRqfM=;
        b=AlmxwLtH/p0LSoBWxsS8A8TStb+GRBK1DcKsedlcYYjd8kehWLlxsF/KTcHv4aQ7zg
         CkWcuI1MkTWeuzrJwAGo/wUx5GxlAh3gN2DMVeDLrlzYg3J6tey83VSDQ9d20DlMxDMF
         aPOdKWHJD0vbj3NGPmHKUsadifdvXKZg23B8ZFeDP+3rpjTSMv4BeD8yHixjv2eKwOKx
         0+oZJeCL0p25gcZXPg1obYFn0ZK6QmLE0sRsGraJKSr4pq92tZ6azvwg8q+It5lhHmt9
         5VATT45eycQ1UWxozM4qzoV4sfmxouvs55k1Q7G8yg9fVg32H6UOpDblvTudT8eIaC8P
         Ghqw==
X-Received: by 10.112.126.9 with SMTP id mu9mr15119217lbb.99.1370443552618;
 Wed, 05 Jun 2013 07:45:52 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 07:45:52 -0700 (PDT)
In-Reply-To: <7va9n52zjc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226450>

On Tue, Jun 4, 2013 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> I however do not know how much extra burden it would place to add
> dependencies to platform folks, so obviously the safer approach is 1
> at least in the immediate future.  My understanding is that msysgit
> folks are already having trouble with Python, and we do not want to
> go route #2 at least for now.  Having to ship a variant of Git with
> NO_PYTHON is already bad enough.  And that is why the option 1 above
> does not list Python as a possible candidate.

This rests on the assumption that Ruby would be as difficult to
distribute as Python, which might not be the case.

> As the maintainer, I've been thinking about closing contrib/ area
> for new stuff, and shrinking existing ones, either by moving stuff
> that are only useful within the context of Git to main part of the
> tree (e.g. "contrib/workdir" may move to a new directory "addons/",
> some of remote-helpers in contrib/ may move to "remote-helpers/",
> etc.), and removing others from contrib/, for this reason.  Of
> course, interested folks can take the last version of the removed
> ones and continue improving them as standalone projects.

This does make sense, however, I do think some parts of Git might be
more maintainable if they have their own Makefile (e.g. bash
completion), where it's clear where they should be installed by
default.

Either way, the user might want to do 'install-all' or
'install-addons', to install all these things, and I think a good rule
of thumb is that if we don't want 'install-all' to install certain
script (eventually), then that script probably doesn't belong in
'contrib' (or anywhere in Git).

> The rest is just a personal opinion.
>
> If we were looking at a compelling and sizeable web application that
> depends on Rails, it is very likely that it would not make much
> sense to rewrite it in other languages only to avoid a new language
> dependency on Ruby.
>
> But "related" is "read and extract some info out of text files,
> spawn a 'blame' (or two) based on that info, read to collect further
> info and summarize", for which Ruby does not especially shine
> compared to Perl, which is the language we already depend on.
> Because of this, I am moderately reluctant to add Ruby dependency
> only for this script.  Unless I know people who regularly give us
> high quality reviews, and those who support various platforms, are
> fine with it, that is.
>
> In the shorter term (read: up to 2.0), I am inclined to vote that we
> should go route #1 (i.e. rewrite in Perl once the design settles).

That might make sense for the shorter term, but in longer term I see
Perl as declining in favor of other languages. It's only a matter of
time before Ruby surpasses Perl in popularity, and soon enough new
contributors to the Git project will have problems trying to improve
Git because parts of it are written in a language they are not
familiar with, and have trouble learning (isn't that already
happening?).

The Ruby vs. Python is another question altogether, I could go into
detail about why I think Ruby is a better choice, but my point right
now is that Perl is not a good choice for the future.

-- 
Felipe Contreras
