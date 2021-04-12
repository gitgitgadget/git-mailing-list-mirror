Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B358C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AD26128E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhDLNTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhDLNTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 09:19:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2FC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:19:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so20234853ejr.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8J8XVDFvlp0Cntv5ilqYkw2roys2ViM1bMXCtPRhNsM=;
        b=ei1UO1QLXIDcc1q/JqeO7H4rpyKEG5MRvtbyf+XU/ontsVFgZ5R91JtM/DbAdxiOtS
         KjJvyFAtjoIU0gHKbEWY4Pk//neLTy1O0hrfiFlPtIlEHyHhUtE6TcgyyEJQ54STUyxx
         nwKfqOwODhPRFWLjMP4QffpWCqjeBtIGR/glSodxa+kshyCFmsU8Ut6goyZt2wWZdvNR
         OSmt34/j3/+BPrPb29Lz23wFjVjfHyLLJBJlVrxIqZX72oMOU/Un3dpVriENl1mh+SOy
         lnC533MDXJ2wWcA5Vrf4vMRFg6VkR3YIePv5GDRp8f/NkZTiWidOTXuJapCb3fDLxi7v
         uzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8J8XVDFvlp0Cntv5ilqYkw2roys2ViM1bMXCtPRhNsM=;
        b=TY4hoevkylhna/3/QmUI1I2IQgF8LKf7SPq1S1nqN49u/eAoiBRF/mKjZ9J1Td3Laf
         x4ytJnhGMNoF1naCf5mIIElKJWozPV77XDCg8LehiYeZqc7POkBuq4YSHdIEfSWw1VQI
         wyTNqYPrrh0hMdKsB0/IYNwO816q8XlWLneXusEmOwPFJ1ADBssSIlij9sjBUA7yxwv4
         F33VMtjcVPCXlCpspn+8XyKaPkYDkKkUpsELNpF023ceiaO2gD5HZAoRnE2WUH74rq4c
         M+PX7x+LaxwXFOOXZ2Wg7NuqEkksa5cpzSDrYStnyb3wVsnS3RYvYRs7TgA43U5BIQKf
         2VHQ==
X-Gm-Message-State: AOAM53087K5z9DFtQDCXOuT7x//GbOSbVanHsjE9Zu983BszAW8kxN2W
        V7WLJ1zp49DyTFCqOREdiICSRzCGOrLDSg==
X-Google-Smtp-Source: ABdhPJyXA2zzu8uaagDg0owB6FTP51joSIOWV0P4EaZvZ4XbQzLryHVJDTA5QBUab5HcyN0oOEIhRA==
X-Received: by 2002:a17:906:f42:: with SMTP id h2mr26644174ejj.317.1618233563058;
        Mon, 12 Apr 2021 06:19:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y21sm6824535edr.38.2021.04.12.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:19:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 04/22] test-lib functions: add --printf option to
 test_commit
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210216115801.4773-5-avarab@gmail.com> <xmqqh7ksb5j7.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqh7ksb5j7.fsf@gitster.g>
Date:   Mon, 12 Apr 2021 15:19:22 +0200
Message-ID: <87lf9nej39.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  test_expect_success 'can parse blob ending with CR' '
>> -	printf "[some]key =3D value\\r" >config &&
>> -	git add config &&
>> -	git commit -m CR &&
>> +	test_commit --printf CR config "[some]key =3D value\\r" &&
>
> OK, the first arg becomes the commit title, and the second one is
> used for the filename, and the next arg is the string given to
> printf, I guess.
>
>>  test_expect_success 'rerere forget (binary)' '
>>  	git checkout -f side &&
>> -	printf "a\0c" >binary &&
>> -	git commit -a -m binary &&
>> +	test_commit binary binary "a\0c" &&
>
> This lacks --printf.  Are we breaking the test but "test-must-fail"
> is hiding the breakage here?

Yes, well spotted. FWIW in splitting this out into another series I
fixed this bug in the re-roll:
https://lore.kernel.org/git/cover-00.16-00000000000-20210412T110456Z-avarab=
@gmail.com/T/#ma9ef67d8198c203adc05aab44f87aa753a3df993
