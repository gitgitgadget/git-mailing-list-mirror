Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B569C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35AA23AA1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbhAVTxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbhAVTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:42:25 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24880C06178B
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:41:36 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so7238269oij.10
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZey2qZ5TCh22d3S1fszQzRptp9SQ1JV4RNUpt1AT+U=;
        b=QU8QXRAOS/B/fKQJBiEBB52ON1FYSOTDMiRmcZh68fRD6H2I4t1es/m/zi5yjBqvvw
         n8d2g31v3i+BkaTU1cyZfyT77JV+mQoxUyiUb4YDEhHFDF+jJ6+i7wiujQISfAt2SnST
         7nosptsBPKBgET5g57nNknkg/qO/xyvdTU+zyMBymB/TD9fsqxmtqrjs/62Fhvzb1YZt
         s8ghXtfmWK5Ox5niMko/wRKDiH0Oiflg1ksi+vG8W+8EK+k5UhqgzRnkXzLbWvx2y+RQ
         S8niIETVsESweUFHxy3V+j4ci8wL6EIAhwLPMNFesN/uqWSiJj0de+PUHYED6buTR3XF
         GMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZey2qZ5TCh22d3S1fszQzRptp9SQ1JV4RNUpt1AT+U=;
        b=DS6TQZvnT8vXt2M3roYVPXd1mFrwIlyfEZJk9RDvDIK3P2phVdz/0IU8rJC4i+yjrI
         H/g6CRiE0MfwCoiSljVRD5r2FZromulJMuacT0P2PI2JobBhjK6AxiJRLMPCnlbeb/fR
         fttz+t5KSi0Hn/+EIeseR6fQia6BB2HV+s8ysZPmRNXnh0ltoD3DYuHcurDL7BmEXDPj
         pSjloL6geMvsY1rhBtuAgOwDu+EEjr4g18511vU8907azqIIDwTc1HM3iC03v88QlfK7
         3r9wIlq0ewpqlLhsynUqeZXVgV6HsxY9T3TVAuo++9jiUfJY7BTWqiTxi8pasw75G41y
         y2Ew==
X-Gm-Message-State: AOAM533EhPFivJ44KU1TAqfsxSe5tzGZF17t4MOOFl/xXzzqZ8QPsbPr
        +Ng9PdrGEtmJIK3knsPavdjEOVxne/Rb+GMkd8Q=
X-Google-Smtp-Source: ABdhPJyNSyWWLgAQvDiFUso0Fm2QqldtNbaJzSNGJY674J+g2NrfYmcrmxkAm17AcAU6SBpUs63xuJvG/MlHaWwDxAo=
X-Received: by 2002:aca:f157:: with SMTP id p84mr4321364oih.98.1611344495527;
 Fri, 22 Jan 2021 11:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-4-charvi077@gmail.com>
 <xmqqmtx3dq83.fsf@gitster.c.googlers.com> <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
 <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
In-Reply-To: <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 23 Jan 2021 01:11:24 +0530
Message-ID: <CAPSFM5eOEQFDAhTateUOJt5XHY8dG8QtfjcXc-XEEZtmPmiG0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 21 Jan 2021 at 20:51, Christian Couder
<christian.couder@gmail.com> wrote:
[...]
> > > > +     grep "extra para" commit >actual &&
> > >
> > > I can tell that you want the "extra para" to still remain, but how
> > > does the grep that is not anchored guarantee that?
> >
> > .. but now I think to remove this `grep -v "squash" commit` as also
> > discussed with Phillip earlier that in this test script we are not
> > checking for the commented commit message.
> >
> > > Perhaps look for
> > >
> > >         grep "^extra para" commit
> > >
> > > to ensure that you are not seeing a commented out but somehow failed
> > > to get stripspaced out?
> > >
> > I am not sure, what does failing to get stripspaced mean?
>
> I think this refers to:
>
> https://git-scm.com/docs/git-stripspace
>

Okay, thanks for referring and also here in this test script - so that
the test does not fail
due to stripspace, it is using the `test_line_count` function. Also I
agree with above
so maybe it is right to just replace with:

grep "^extra para" commit &&
grep "extra para" commit >actual &&

Thanks and Regards,
Charvi
