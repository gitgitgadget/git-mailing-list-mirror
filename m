From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Tue, 13 Aug 2013 22:52:34 +1000
Message-ID: <CAH5451nxgpa4Q-BpwhD7yD6V6_LWBP=+oEDR3u0eGErSWNEBbQ@mail.gmail.com>
References: <20130809223758.GB7160@sigill.intra.peff.net> <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net> <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org> <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net> <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net> <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 13 14:53:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9E6B-0003h3-Mo
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 14:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab3HMMxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 08:53:15 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:45960 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab3HMMxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 08:53:15 -0400
Received: by mail-ve0-f176.google.com with SMTP id b10so1045882vea.35
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vY7R5MMWEpIgcg738QyDivnR0AZQF4yYwUb8o2fUoNA=;
        b=KyK5qoIT4IFJu5t2JDj1Y0JU0G4cMETuAlJ0324gPFeoVSKvMVV74ycKJ2g9gHBIIs
         1O6Lc6LHYIKZGAEsoxY7x6Zgv+eUOJvfWndvEsLQjJVwh5y9jWX3qoWm7VKSnJK6TQNJ
         dWpkq2kSb2WMEl7hd4B6blfhm0/usvKJKeluagHuJg3jj9Z7j75rgakhIGSuhbVggN/M
         aFuFGAT1S+jvdzeSUEE19a4JMPEM5DgbTn0zVk7LxBqFEXQWvyUnYP3PvPVVzQtKnldR
         Qf6EOnRvPqZVZplLNzF8VvdcedkLsbf52mHPFFDhQWhakLBGNA6oiTNqS9jPWRyB23MX
         d+3g==
X-Received: by 10.220.10.194 with SMTP id q2mr4294343vcq.2.1376398394195; Tue,
 13 Aug 2013 05:53:14 -0700 (PDT)
Received: by 10.220.195.133 with HTTP; Tue, 13 Aug 2013 05:52:34 -0700 (PDT)
In-Reply-To: <20130813114635.GA16506@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232223>

On 13 August 2013 21:46, Jeff King <peff@peff.net> wrote:

> Like I said, I do not have a particular use for it, but I don't think it
> would hurt anybody who does not use it. If you want to polish it up into
> a real patch with docs and tests, I don't mind.

I'll have a go at this.

> The only downside I can think of is that we might want to use the
> subsection in "include.SUBSECTION.*" for some other limiting conditions
> (e.g., "only include this config when running version >= X.Y", or even
> "include only when environment variable FOO is true").

It seems as though gitconfig doesn't have a standard way of dealing
with 'sub-subsections', which is essentially what this is trying to
implement.

It makes sense that there could be different 'modes' of includes.
These could be the ones you mentioned already, such as repo and env,
but could also be things like branch where the config changes
depending on which branch you are on. Ideally, multiple entries per
mode would be allowed.
Implementing all that initially would be overkill however if this sort
of functionality is desirable the ability to easily add new modes
would be a great boon down the track.

The four pieces of information we need to include are that this is an
include, the path to the include, the mode, and the mode specific
parameter. Your proposal is to allow the sub-subsection by
concatenating with a ":" like this

[include "<mode>:<mode-param>]
  path = <path>

Alternatively, we could allow chaining of subsections (couldn't find
any previous discussion on this) by adding whitespace between each
subsection. Seems like lots of potentially unnecessary work, but maybe
this has already been discussed or is the most appropriate way of
doing it.

$ git config --global include.repo./magic/.path ~/.gitconfig-magic

[include repo "/magic/"]
   path = .gitconfig-magic

We could also require a unique key that grouped the options together.
This seems like the easiest and most flexible method, and doesn't
require any 'special' considerations for the subsection. It would be
harder for a user to configure, and the concept of a mode seems less
intuitive.

$ git config --global include.magicrepos.mode repo
$ git config --global include.magicrepos.param /magic/
$ git config --global include.magicrepos.path ~/.gitconfig-magic

[include "magicrepos"]
  mode = repo
  param = "/magic/"
  path = ~/.gitconfig-magic

Of the three I probably think the subsection chaining is the nicest
overall, though your original "repo:" proposal seems to be the easiest
to implement.

Regards,

Andrew Ardill
