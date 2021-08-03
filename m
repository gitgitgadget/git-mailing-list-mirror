Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36735C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCF060F70
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhHCVde (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhHCVdd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:33:33 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76838C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 14:33:21 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso10153343otq.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W58POYd2t5OMOvbgq1GgsT4j6EqFgpBlam8WHyTnF/U=;
        b=dPLVQw6+ib5afJy0V+KdzWezvwGH7gHvcLW/+++oD0ixPuH26DCgvOEbz0V5MH409O
         beejcxapc8451b7+ZHgVxjHupDaSYyUB9GlA0R3mEQ9EGuRvxdEZT33foqYsc/MuSMsz
         t0PIwM0ffTzEB/6RmeJkU/DZsQ/ny3gDkm2jVU9ZmLTY9pVyJC8B1ja+zAOaJO2Z2RWT
         wcIqyZyQkdocXrkIJm93ATdEGcGTW4PVuymt3AT1xQGkiyQ7Xjps0OHywuTORPO5rEG9
         CxT/u6rZcpfZ/aqKOgMgaZCbg68yxqhnVUPMdI6XKaaatBpxzlalJhy1nSAmNQzcTT07
         36uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W58POYd2t5OMOvbgq1GgsT4j6EqFgpBlam8WHyTnF/U=;
        b=lX1DVa5+Bmk7gOaBUHOicc1nXnPpdpuQ99T/lMSj+0r86UZ2F+Y90HbrzrBt4XrwqP
         lgbf8jc3qOQp4ZezeQj0cdD1Nt7SE3pgIt7ZcSefL9TlgcwTu0Vyb9ToxCXy0wj22Wg+
         cfdVh/9c+x2DYyg50evZyFT5w5ht/eYXhicksVqntPjSFWh714e400hgmE/TjZJmeVF7
         IP4aBkrsxAUvN19h6p+vfsiwaBwXd73zRuu0B5Y6wrA3Ya90aKKR57lInepct7/uSZV1
         CluOGg/C8efHb7Q+38HJGG+wPhjM/RdTQityG2MAK/JIBYWvSOm9Emdgj1hU8r3tqctV
         ccgw==
X-Gm-Message-State: AOAM533+bCaNxO5lFphW0jVS6yVOhkCdFoeJFbnvzjEHSBm1X7xNIgP9
        6hopXi65NdTdEPJ4IvuAl6SrUTYsGD5SYujnCbw=
X-Google-Smtp-Source: ABdhPJzkU1HEC3z6hwDQO72d5UVItNw5qmX9YH2DpuOvixF/Ybfrnld4BRuvUHp2NLDp3aKg6oW3OmgJc5V4mxEdg4g=
X-Received: by 2002:a05:6830:40c2:: with SMTP id h2mr16885505otu.56.1628026400807;
 Tue, 03 Aug 2021 14:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local> <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
 <YQmuT2ZYe1mzHBjI@nand.local>
In-Reply-To: <YQmuT2ZYe1mzHBjI@nand.local>
From:   Cameron Steffen <cam.steffen94@gmail.com>
Date:   Tue, 3 Aug 2021 16:33:09 -0500
Message-ID: <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
Subject: Re: git revert --continue --no-verify
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perhaps the issue then is that the pre-commit hook should not run for
`git revert --continue`? It does not run for `git revert`.

On Tue, Aug 3, 2021 at 4:00 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Aug 03, 2021 at 03:56:49PM -0500, Cameron Steffen wrote:
> > `--no-verify` is an argument typically used with `git commit` in order
> > to skip the pre-commit hook. Since the pre-commit hook also runs on
> > `git revert --continue`, I expected to be able to use `--no-verify`.
>
> No, `git revert` doesn't pass unknown options down to `git commit`.
>
> Thanks,
> Taylor
