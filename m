Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A86C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D311A20722
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heNAYN2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHBQUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHBQUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 12:20:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39167C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 09:20:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so32067509wrw.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1pFc14e16szg5ifqYLL7SmN/hVQRUUfv94maloOFAxI=;
        b=heNAYN2GgergDcfhP9oXwxAfGh0UQe2/Zvke0onhAsGdER+QGqsaGUlJCstKzFqxkR
         wp0pWlnSCsXt+YBGu7vxAvj9vJAheaAnrfvx9Yevxv0r9qMNGhBRvRl1qZNIm09e6y6F
         C0GQOx69QM5uwDsQ4c2ocxGqYMTwFG4aDVDyKMt2I7a0LlFUdyLY4cPx0YcYl58kX7Is
         akGt4nioD7mvWcxUMChUX7R5zfZwcXwr9E32r30/HKvOVttQGdaDMVebc223piSZrDnG
         Q1hWV9OKDokILp6z5XJo1+WPsg4eHaF8A1sR1NCz4XhtoyuNhBr6ICx7zorrOLP8/aVP
         Jnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1pFc14e16szg5ifqYLL7SmN/hVQRUUfv94maloOFAxI=;
        b=cYfSR6HsqRk4ZGQdG9eXlsDyu6iPh2Nnh+Ra4itXz0V6UZVYZvEyt2JzKp5exwm/cJ
         SaMU/1H1HLbqftOnmZo1dvXXP55gNqW4TMsoMRrkdkzpOha37THWTwThuitAKfbd7XrX
         ma5gysxgH7i5fwCr6FEsqmPM9paZ5SFLKJCfC0S55b6cuT0phHd3t2z/IPS9Tsmts/Ez
         pPUtfGskm711qpMJGCrTJV35TM4z5g04E9nXkpkp9N7i81XEgd65HXh3tXwOGcS/oPLd
         PFBg8E0EAihZYF2LQkmMkP52S26nzPN9OfCis5imOrb7vV5RqT8CPOiBUcV50Qw9zBj3
         63gg==
X-Gm-Message-State: AOAM532+C6OM6noFogybC1m8AJa9eAni4KhIv+CjZdV5osHpUK7P6JOM
        /OeWyVF+GyM57dNDs7/tOdjXAVbsNjVRMjUeKgQ=
X-Google-Smtp-Source: ABdhPJxPsSGSiHHP4KiFxwokus5DpGFZ5Dry5NXnHcct047FJVDT9V/sRWgO8rArpZZVbPuBugok2XbOvyO0Z0sM2wc=
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr10865636wrx.50.1596385224005;
 Sun, 02 Aug 2020 09:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200801220611.10453-1-martin.agren@gmail.com>
 <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com>
 <CAPx1GvcD80MfjZLiKBrH8BgsvVToZ90C057gk7b4BUzbLMNu2A@mail.gmail.com> <CAN0heSoYAJkZVG7_TPTo3Osz+FuR__AY5Ykc8OSwzARTotfwcQ@mail.gmail.com>
In-Reply-To: <CAN0heSoYAJkZVG7_TPTo3Osz+FuR__AY5Ykc8OSwzARTotfwcQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 2 Aug 2020 09:20:13 -0700
Message-ID: <CAPx1GvdZNeuQqmYm8G62Zr02k=B5GK69xPw84WnvMCeJU7_amQ@mail.gmail.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 7:35 AM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
> No worries! Thanks for having a look at the patch. Is there anything
> that could be done to make this clearer in the commit message? (I find it
> quite awkward to discuss quoting: will the reader understand which
> quoting is part of my own formatting of the message vs which is part of
> the quoting issue I want to get across!?)

This is indeed a problem...

Perhaps something along these lines (generic boilerplate
for any single-quote fixes, that should be adjusted for the
actual fix):

    In the test scripts, the recommended style is, e.g.:

        test_expect_success 'name' '
            multi-line test
            goes here
        '

    When using this style, any single quote in the multi-line
    test section is actually closing the lone single quotes
    that surround it.  To avoid confusion, minimize and/or
    eliminate the use of single quotes here.

Chris
