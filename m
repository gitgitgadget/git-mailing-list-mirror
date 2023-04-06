Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B96CC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjDFNj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjDFNjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 09:39:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCA976F
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 06:39:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k12so9471954qvo.13
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHG4jeUv5wcUw/5Ov0dUmw116z+k+P3f0ikY/j9srHA=;
        b=TzJ51q3xpt2NBeiYICRYi18x5HIblyYRB56/90ewB7G9pvQnl/l1Es41UEI8S/mbYe
         P6GHj1TDWzDdnf324jBOcx0ruyJoHjZBfDMVwH6WyLHPL0Ur7CHxJzclmE/EGbtEiUlN
         uVTDgyTf+RY4zPvNfR0g5dbfY+adei57zRCD6neJ3a9KrXdUzaXY7nNHAL4aZBPrIRmS
         8OYSbJ3X5VW/q30VxR1wTDAWrhMPHuiGyVdgwtD/tNOqRGIEgIs32FImASbr2BdvINI8
         HGmjHRwXeV16+EpIoUUmkp3T4MPa3p5C/H8WGPRMZSXJo9fU2fB51RRVkNAAYf5TFyOW
         g2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHG4jeUv5wcUw/5Ov0dUmw116z+k+P3f0ikY/j9srHA=;
        b=S/lNI7r+97Ve+jR1L35C7D7cNH8p0K0mNuVS8bGxcC9Xcy+DQShajkn/YFkP7mS6Vg
         /lWKsZbNgP9X1L6NCH5g5KgORpSayF4vtIweXF+YdabOCr+ZArZN7Ua8ceGHbDtXC+Ma
         aJ82fpXxKWKs6W/kqEcg2HDZt+21VXelKVGx8WRxUUisi6wy9v+vqMNXfjz0fR6AYTNi
         YVTA4DvGeRJDd7+9G0xP8KDxNuU2UrwdOvRsxGhYbItj0sdGeUXizFIgQt8C0byXI0p2
         NRMIYP1Jy6/mYCbmEtP+M36ajLgqupv7TERd44aPL5yZcUk/ZE4ic8aCvecppovjJ6kH
         oyFw==
X-Gm-Message-State: AAQBX9fo5aY+cuhWwkiH2mEx+p+QS8LiUiREC9fE3k2yCRxUzBpoJ6tL
        IYPTLMHp2t0XXyydMjqodBHH6pknjG6iF2eaYxxh7u1UpeA=
X-Google-Smtp-Source: AKy350Z5c7XEECkeGZ6yZ/3bRWz1vgXrT0l6ZxLjSewl8PQDX5zhWKkhT1VUsRPntK8S9FLhI9nSIgEjyBevA+AplXA=
X-Received: by 2002:ad4:58b2:0:b0:56f:378:951 with SMTP id ea18-20020ad458b2000000b0056f03780951mr542261qvb.1.1680788382666;
 Thu, 06 Apr 2023 06:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> <xmqqttxvzbo8.fsf@gitster.g>
In-Reply-To: <xmqqttxvzbo8.fsf@gitster.g>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 6 Apr 2023 15:39:31 +0200
Message-ID: <CANgJU+U+xXsh9psd0z5Xjr+Se5QgdKkjQ7LUQ-PdUULSN3n4+g@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Eggert <eggert@cs.ucla.edu>, Carlo Arenas <carenas@gmail.com>,
        60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Apr 2023 at 21:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Paul Eggert <eggert@cs.ucla.edu> writes:
>
> > This is an evolving area. Git master is fiddling with flags and
> > options, and so is GNU grep master, and so is PCRE2, and there are
> > bugs. If you're running bleeding-edge versions of this code you'll get
> > different behavior than if you're running grep 3.8, pcregrep 8.45,
> > Perl 5.36, and git 2.39.2 (which is what Fedora 37 has).
> >
> > What I'm fearing is that we may evolve into mutually incompatible
> > interpretations of how Perl regular expressions deal with UTF-8
> > text. That'd be a recipe for confusion down the road.
>
> Nicely said.  My personal inclination is to let Perl folks decide
> and follow them (even though I am skeptical about the wisdom of
> letting '\d' match anything other than [0-9]), but even in Git
> circle there would be different opinions, so I am glad that the
> discussion is visible on the list to those who are intrested.


Perl matches Unicode text according to the rules specified by the
Unicode consortium. It is the reference implementation for Unicode
regular expression matching. Unicode specifies that \d match any digit
in any script that it supports. Thus \d matches far more codepoints
than \p{PosixDigit} or [0-9] would.  Be aware that Unicode contains
and separates numbers and digits, eg, \x{1EC9E} represents a Lakh,
which is used in many Indian languages for 100,000, but which is not
considered a *digit* for obvious reasons.

FWIW, someone mentioned [[:digit:]] which matches the same as \d does
on Unicode strings and under the /u matching flag for regexes in Perl.
Arguably this was a mistake, [[:digit:]] is a POSIX character class,
and POSIX doesn't support Unicode so it should have matched [0-9] or
\p{PosixDigit}. But historically \d and [[:digit:]] in Perl were the
same and when \d was extended to meet the Unicode specification
[[:digit:]] came along for the ride likely inadvertently, thus
\p{PosixDigit} is equivalent to [0-9], but \p{XPosixDigit} is
equivalent to \d and [[:digit:]].

I notice that other posts in this thread have moved the conversation
on, and covered most of the points I wanted to make here. However I
wanted to say that there seem to be two different issues here. The
first is "what semantics do i expect from my regular expressions",
Unicode or legacy-ASCII, mostly this relates to case-insensitive
matching, but things like \d also surface discrepancies. The second is
"what encodings does the regular expression engine understand".
Unfortunately on *nix there is no tradition of using BOM's to
distinguish the 6 different possible encodings of Unicode (UTF-8,
UTF-EBCDIC, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE), and there seems
to be some level of desire of matching with unicode semantics against
files that are not uniformly encoded in one of these formats.

So the question comes up, A) how do you tell the regular expression
engine what semantics you want and B) how does the regular expression
library identify the encoding in the file, and how does it handle
malformed content in that file. For instance if I have a file which
contains snippets of UTF8 encoded data, *and* snippets of data that is
illegal in UTF8, what should the regular expression engine do if it is
asked to do a case insensitive match against that file.

cheers,
yves
