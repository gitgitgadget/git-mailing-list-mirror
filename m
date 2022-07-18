Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0BC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiGRX2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiGRX2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 19:28:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440BD1DA
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:28:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 23so11976362pgc.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NmNiCc4Vf00wt/C9tZHRCBlk6en/kN5U3Q1zLeFynw=;
        b=BZKloP1b5/C6NIB4GdOFR5r+88TlgGPgw4uBhigRX9eFUJyLjyvs4ryTvKR76zqh4K
         XfcG52JKKpeb9ElVax0GQml0RJH5Rs7iTb+S0mKuEK4TQOU2+JXWb9i7p/1jjLzKHQP+
         gLPot3fZyZtJbGr5YggiioxB2CRXMjCFV3GTb1EtF237NWIJ48GFKLastSZ2H2YFKZCM
         bG4GJhW4Bqg8vnwt+GMcyQCohIoHjVCy4ZZUKcYutmDTnbIRgM6QlITtkAQy1JoCoEVX
         /UUgJAJJlFuyipjcG9l3H6RNzHb/gKlmDSkpQ0PkkSu8w5/+RA2frKSBE6K/Y3a+ZVRx
         OP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NmNiCc4Vf00wt/C9tZHRCBlk6en/kN5U3Q1zLeFynw=;
        b=U/96tvXSh/Or6wEU8WtAUW7RSlJ/u95EXMmzpXwo9I75ib43SuyfSZ4zTgR8qjki4V
         Wnxz44tz72v8QlvU7KXdOMqQT7Z2uXR5NRWgkAopvSJpojFmi4RPmZVZ0zx/GUBwuN7W
         VIfnkNeog1Wtcx7Jg0t4GutPkYDzsKFVMExn/QFDxuN4d4A5f8MHEj3E93ko2LqfNRx2
         Ltoh/HW4iez6OYgcy/+dkqPhdOmU40BT48yJw/XSFbDovWSc3uHXmsgEeUpisyiKhuRa
         KT1L4i/O7+Iw4Pu/Hmkm2UgI8ztJduk9noEXKQlHwPr962Z0Z1fQzo3esjJfPtAe/fY0
         nv6A==
X-Gm-Message-State: AJIora+fqin6x3Ys5NUvpOPMDewGPm2t3I0oW8CV4y3Kg4RRfe0UEKza
        IYknqCUr3eianPGJZkB75Fo=
X-Google-Smtp-Source: AGRyM1tH0WjnPWTGpEPeInswM7uZbCazHWYyUhr8uUTvABOctVzfbokvN5MAxGl1YjK6DzeLnhoaNw==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id y8-20020a056a00190800b005255dadcb1cmr30626804pfi.47.1658186925662;
        Mon, 18 Jul 2022 16:28:45 -0700 (PDT)
Received: from bkerin-Precision-7710 ([24.237.158.8])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016ce9b735dcsm4146684pln.40.2022.07.18.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 16:28:44 -0700 (PDT)
Received: from bkerin by bkerin-Precision-7710 with local (Exim 4.93)
        (envelope-from <bkerin@bkerin-precision-7710>)
        id 1oDaAN-000dOV-Ew; Mon, 18 Jul 2022 15:28:43 -0800
From:   Britton Leo Kerin <britton.kerin@gmail.com>
To:     gitster@pobox.com
Cc:     britton.kerin@gmail.com, git@vger.kernel.org, newren@gmail.com
Subject: Re: BUG: git-check-ignore documentation doesn't come close to describing what it really does
Date:   Mon, 18 Jul 2022 15:28:43 -0800
Message-Id: <20220718232843.151392-1-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqtu7lc587.fsf@gitster.g>
References: <xmqqtu7lc587.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
> > I suspect we're having an aliasing problem that you're not
> > recognizing.  "ignored" and "excluded" are used interchangeably, note
> > that patterns from the $GIT_DIR/info/exclude files and patterns from
> > the file pointed to by core.excludesFile are also lumped together with
> > the patterns from all the .gitignore files (see the gitignore manual
> > page).  Further, the internal code refers to them all as "excludes"
> > not as "ignores".
>
> All true.

I wasn't surprised that 'ignoread' and 'excluded' are used interchangably,
that's not the problem.

> > Yes, it outputs the paths that are excluded, as the documentation
> > said.  Perhaps there's a way to reword it to make this clearer?  I
> > don't think we can get rid of the alias given the fact that
> > $GIT_DIR/info/exclude and core.excludesFile are hard-coded and must be
> > kept for backward compatibility.  But suggestions to improve the
> > wording would be great.
> >
> > Maybe it'd be as simple as replacing "is excluded" with "matches an
> > ignore/exclude rule"?
>
> I smell a continuation of 7ec8125f (check-ignore: fix documentation
> and implementation to match, 2020-02-18), which appears in 2.26 and
> later (the way the negative entries in the ignore/exclude mechanism
> gets handled has changed in Git 2.26, and the documentation has been
> updated).
>
> "Is excluded" is perfectly fine, I think.  The first use of that
> verb in the documentation should be a bit more careful, e.g. "is
> excluded (aka ignored)" or something.

I think replacing with "matches an ignore/exclude rule" is prefereable since
that's what's actually going on.  It's still a bit unfortunate since the
ignore/exclude terms are potentially confusing in the presence of dont-ignore
(!) rules, but it seems likely that people running check-ignore are looking to
sort out something complicated and are probably aware of negative rules, and
anyway they get a ! to clue them in :)

Adding some explanation to the first use of "excluded" would in principle solve
the problem by itself and give licence to use the term however you want, but to
be honest I'm not sure I would have read that paragraph carefully enough to get
the idea.  It still seems better to me to use different language each time it
comes up in the page.

> >> IMO the behavior of git-check-ignore is the correct and useful
> >> behavior
> >
> > I'm with you here.
>
> Yup, with the old "huh?" fixed in Git 2.26 (which was there simply
> because check-ignore was not used to be a serious end-user facing
> program but was more of a debugging aid), I think the behaviour of
> the command we have today is what we want.
>
> >> and the documentation should simply be fixed
> >
> > Yes, I agree it's easy to misinterpret.  Would my suggested changes help?
> >
> >> to reflect the
> >> fact that it just lists matching entries rather than wrongly claiming
> >> that it returns the overall result of the ignore calculation.
> >
> > I think I understood where the problems were in the documentation that
> > could lead to misinterpretations in the other two cases you mentioned
> > earlier in your email, but I don't understand this one.  Even the
> > first sentence you quoted included the phrase that it could "output
> > the path", so I'm not sure where you think it claims that it'd return
> > the overall result of the ignore calculation.  Could you point out
> > what in the document led you to believe it was claiming this?  Maybe I
> > could suggest wording improvements for it as well.  Or maybe you have
> > some.
>
> It does return *the* matching entry that decided the path's fate.
>
>     $ (echo '/no-such-*'; echo '!/no-such-*') >>.git/info/exclude
>     $ git check-ignore -v no-such-directory; echo $?
>     .git/info/exclude:14:!/no-such-*	no-such-directory
>     0

Good point: it's not exactly a full query either.

If it would be welcome and hasn't already been done I could rewrite this page
to be clearer without adding or changing much.

Britton
