Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00CC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D532464E4A
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhB1Sqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhB1Squ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 13:46:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A0C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 10:46:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so24126353ejf.11
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xkJMlF/TfhcKBbMqiW+yjaB8Z+Qsk2yyfTDXABSCCqs=;
        b=CJvMJEtzkdexYf6RUCIOhzYiBAo3LnR7lu6NMzwRqzgenVuilPkKSxAuiZaoI46Dll
         LezK2D9NeT7IbFOw5UKNT/8fWTLZyzdMw+JBT8quVyWMQrAblqqZu1I5htHS6rtX5FaZ
         Zari4FBx6TxAdG2ZVYscv1lC8uD+OQu2vTp06hACViHM+MpdzsADUBpDlglDS61yaq3W
         s444uM2MvswNg/AFv2k9pp285hdFKUt7EuE6gyn2LKkQRiq0e1oWitHaDlhJQlDb0pOv
         tBtx7RsoXPgFRdEiMPev+UGHuYMdZ6hqH9V1mvQ5Mdj2BUAbFfxuR8VwRpBV2kFCzo40
         BvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xkJMlF/TfhcKBbMqiW+yjaB8Z+Qsk2yyfTDXABSCCqs=;
        b=Lv3mpGn8yja88ApyPr8Z+igeGvXYX+ED2wl3HQP9WxH+3q9Jd/SXMpqBa3OgfBU9vb
         wpcVSl0mlnKhkXyjYCy2ayABZm94uBhqNG5zxAIFc5rhqaOT+HILAK6gqBw6PqajFGtX
         iA6x/EudJ3AfQz6j8i8ZmQmdb05NIOCJPzg5dvbuEpRuilrjzUIPpSg/KRtP7WD1BI5z
         jFsHxOaPHlqAdax5ByaXKZ0/Ijx2UJMjf8NErTOagqCsWE2BYzp7oWXP4LdAVatMT6RV
         PCctfToKmDEnagRMfzX6pGZaV6tl3NuumGrCLXgyZBtfm6T574YSili2L9MgYogkELAB
         ziZQ==
X-Gm-Message-State: AOAM532zgJ4gS7sSU2MVKb+HBqrh0tQgzZc1zeFi8SmzRqPCgXpzuRRd
        nsSixoocc0d0eJ4mYsKAs78=
X-Google-Smtp-Source: ABdhPJwza16HJoITYJx21FpBL4g7y0uPPdGo1UCV8mgbxQJEwGJLlrJfOOKzyNfWErnaItWxMnATwQ==
X-Received: by 2002:a17:906:4c99:: with SMTP id q25mr13004470eju.111.1614537968851;
        Sun, 28 Feb 2021 10:46:08 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o4sm10856974ejj.45.2021.02.28.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 10:46:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-5-sandals@crustytoothpaste.net>
 <87h7lwl5mv.fsf@evledraar.gmail.com>
 <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
Date:   Sun, 28 Feb 2021 19:46:07 +0100
Message-ID: <87zgzojaj4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 28 2021, brian m. carlson wrote:

> On 2021-02-28 at 12:48:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Perhaps something like this instead:
>>=20
>>     The output of 'git archive' is guaranteed to be the same across
>>     versions of git, but the archive itself is not guaranteed to be
>>     bit-for-bit identical.
>>=20
>>     In practice the output of 'git archive' is relatively stable across
>>     git versions, but has changed in the past, and most likely will in
>>     the future.
>>=20
>>     Since the tar format provides multiple ways to encode the same
>>     output (ordering, headers, padding etc.) you should not rely on
>>     output being bit-for-bit identical across versions of git for
>>     e.g. GPG signing a SHA-256 hash of an archive generated with one
>>     version of git, and then expecting to be able to validate that GPG
>>     signature with a freshly generated archive made with same arguments
>>     on another version of git.
>
> I think something like this is good.  I'm a bit nervous about telling
> people that the output is relatively stable because that will likely
> push people in the direction that we don't want to encourage.  I might
> rephrase the first two paragraphs as so:
>
>   The output of 'git archive' is guaranteed to be the same across
>   versions of git, but the archive itself is not guaranteed to be
>   bit-for-bit identical.  The output of 'git archive' has changed
>   in the past, and most likely will in the future.
>
> I'm not very familiar with the zip format, but I assume that it also has
> features that allow equivalent but not bit-for-bit equal archives.
> Looking at Wikipedia leads me to believe that one could indeed create
> different archives just by either writing a Zip64 record or not, and if
> we store the SHA-1 revision ID in a comment, then we would also produce
> a different archive when using an equivalent SHA-256 repo.  And of
> course there's compression, which allows many different but equivalent
> serializations.  So we'd probably need to say the same thing about zip
> files as well.

Yes, I think your version is better, and we should have some wording so
it generalizes to the various output formats we support, perhaps further
noting that the "relatively stable" (if you want to keep a note of that)
only refers to our own output, not when we invoke gzip or zip.

I thought that "relatively stable" and "[when you extract it you get the
same thing]" were good to note, to say that e.g. GPG signing across
versions =3D bad, but if you e.g. offer downloadable archives with the
contents of tags, there's no reason to make your git version a part of a
cache key for the purposes of saving yourself CPU time when
(re-)generating them.
