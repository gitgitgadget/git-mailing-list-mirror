Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A0C05027
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 03:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBMDkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 22:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMDko (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 22:40:44 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6724311141
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 19:40:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z1so12171393plg.6
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 19:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtgdpm/TEDDSo7DqLfjLRviZ/xwkPJDf/sk/xZIJAA8=;
        b=COVHRto41YKICJtUS4rhWJQMyEA84B7jfI0FfstV/DFiHWiY99mDC64JDGBXGB5i0R
         ZTXvQuB/I5QEhKOa2xERNT6vW1g6lPsATERdNkV5QuYH5LhDn/H45FVE+ov/K4y8bNRS
         slOUJZwMyFw2O2HwwiCKBPYJdkrpO4y8xzL0Rpqb3kUOzW6OIYl0qzhELVpj69pfmi30
         klhqdy7B+KutxIM2UdfKo3+5Dxk2muZeiAdKoKR58jTrb37z6+FnsvAporKD4gAzlEWX
         Ln8YQY/ea3+ulcKtcixf/eU9ArXOhoZr8nyKyr5PRGzpJR71tiY+yXorCX0eADSYLgnx
         AACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtgdpm/TEDDSo7DqLfjLRviZ/xwkPJDf/sk/xZIJAA8=;
        b=nzHJCXZx/SKblTB2XmvpmegFz6O7AgWj5NuxS+DT1acWxMKSUCIlZMmkmSSP6K3Wda
         ApVAY24geKRakW8QSdSqg6l/l6IOhKe29HGaVTHIiwGtgNta0bRJRIeDDqzFWArARLqP
         GfowGbYuVZSrROJQY6HJ1TbAUpziizOGQfuPc7EQ5nrl8KQYaaBC1RH0pa7p55MOojiV
         /2Gq4C0JbvHd3v/bMmz4U9tpn3HZ9KRHgFBtV1cblDSEXEbEkL/gNOJ6PrtPKPM7L8k3
         PHaoA96xmzldDEImTZHfAp6VOFeOJdGLkE+mlfRlVdmfxqIPqEKZnuVrzEt+kAxe3e+b
         bMEA==
X-Gm-Message-State: AO0yUKVA84ILHXoKND9sJGetOTGh698SBc+J/xH6L4k6LRZuVhGfmLZt
        crs0jNIFdS5MtNSl2rEAB/w=
X-Google-Smtp-Source: AK7set8oxxP9wvmw4psz5/euNaFmCRNobmMMXsF4ZklApWg7xii1o0CLywztBD4zi/n+eHGojJ0lHg==
X-Received: by 2002:a05:6a21:3392:b0:bf:5d4e:1328 with SMTP id yy18-20020a056a21339200b000bf5d4e1328mr16902667pzb.25.1676259574306;
        Sun, 12 Feb 2023 19:39:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s1-20020a63dc01000000b004fab4455748sm6342747pgg.75.2023.02.12.19.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 19:39:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] test-ctype: test isascii
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
        <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de>
        <xmqqr0uwdlvh.fsf@gitster.g>
        <70f4042a-df30-26e5-55bd-b349cc02c416@web.de>
Date:   Sun, 12 Feb 2023 19:39:32 -0800
Message-ID: <xmqqttzqcjyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 11.02.23 um 20:48 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Test the character classifier added by c2e9364a06 (cleanup: add
>>> isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
>>> special treatment, as our string-based tester can't find it with
>>> strcmp(3).  Allow NUL to be given as the first character in a class
>>> specification string.  This has the downside of no longer supporting
>>> the empty string, but that's OK since we are not interested in testing
>>> character classes with no members.
>>
>> I wonder how effective a test we can have by checking a table we use
>> in production (i.e. ctype.c::sane_ctype[]) against another table we
>> use only for testing (i.e. string literals in test-ctype.c), but
>> that is not something new in this series.
>
> What aspect is left uncovered?
>
> Or do you mean that the production table should be made trivially
> readable to avoid having to test at all?

Much closer to the latter but not quite.

Both tables are not all that transparent, and it feels that the
protection by the tests largely depends on the fact that it is less
likely for us to make the same mistake in two "not so crystal clear"
tables for the same byte.

> ... but parsing commit messages and blob
> payloads should perhaps better be done with locale-aware versions
> with multi-byte character support.

Yes, that does make sense but it is orthogonal to what sane_ctype
wants to address, I would think.
