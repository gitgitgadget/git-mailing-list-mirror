Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67405C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510B0619F1
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhF1IKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhF1IKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 04:10:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF44C061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 01:07:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h17so24448009edw.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EVnko30tzb4fRA0jQZmzZayKAkV8he1qeBSiVZcUqlw=;
        b=IRx/Ztp8UYJnOpjjn8SZx+6+HaIuEmJtQTNKR8G82/2fDPC4Y3XvfCRMFW9pp1M4dC
         72ms3ANHNmxEXKikz6QyXLFpF2wpI6RcXHPvw2xLCiAkgxdPaYrTmpfePwUodS5AxNdl
         s7930YSlFhO6CKfE3uzHs/J15oos0RqKYhtMRRPCogxYrcASkAd//8PmJANo1nkB/pOe
         UjMTy79CGrCj3rQABOOUf5mwR3sxKkaTVxf4Si7ax69U7pJpY4wxZDyf130Dnu2tk7nt
         l5oqrx1WyzKWsTwf+MsTrSLIunCkZ5rIfxhdX+/ft1kS/VcIODRsjB3eX2id+Ytq32m6
         aL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EVnko30tzb4fRA0jQZmzZayKAkV8he1qeBSiVZcUqlw=;
        b=RaEijAvBM5B1BaAUqjpJNbuA3/K9/qPQWyERMkSlsNVdlduTvcW4suzZegl0c8hToM
         FGGSmEqM9cMqb5WpMhRycB4SERp7btS/7Qaj8rKeli6p51aWJorh+o3fMNX4PXKKUsT/
         yczQ2wWeKxFHCyyO2v8Z1CafKyL0hn+E0HxMBkmS2GMPal2uwwa81C2T6WXWcx2jzqVj
         XIjjvLPRVc53sobOIoAxiH+wR07/HfR2L8MNNyVN253lZHCPlMMrEar3UUTb5JhvJbfB
         /Zj8fO84GTFba/YteW6u418safQ9w3OraC/2PnFn95039ULRKWxXWTzc1f0r+Qpwlh4s
         NsRg==
X-Gm-Message-State: AOAM531tKxAz8U6/LZmlwDzwvdM0+CZJbbW9SXu3NkiFvh3bpuNBKb4o
        JZI5AVU42GlyH7XXpXP5njY=
X-Google-Smtp-Source: ABdhPJzA81dJzKag9G5t8iSITbQFEGbnudX+W4iZobLmTL9AMh4xO6wtcgV7vIEeDNNMzZ/QVMWZdQ==
X-Received: by 2002:a05:6402:31ac:: with SMTP id dj12mr31241731edb.382.1624867668068;
        Mon, 28 Jun 2021 01:07:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o5sm9149350edt.44.2021.06.28.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:07:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] receive-pack: skip connectivity checks on
 delete-only commands
Date:   Mon, 28 Jun 2021 10:06:09 +0200
References: <cover.1624858240.git.ps@pks.im>
 <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
 <87y2auwh1d.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <87y2auwh1d.fsf@evledraar.gmail.com>
Message-ID: <87v95ywgx8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jun 28 2021, Patrick Steinhardt wrote:
>
>> [[PGP Signed Part:Undecided]]
>> In the case where git-receive-pack(1) receives only commands which
>> delete references, then per technical specification the client MUST NOT
>> send a packfile. As a result, we know that no new objects have been
>> received, which makes it a moot point to check whether all received
>> objects are fully connected.
>
> Is it just per specification, or do we also have assertions/tests for
> what happens in that case?
>
>> [...]
>> The following tests were executed on linux.git and back up above
>> expectation:
>>
>> Test                                                  origin/master     =
      HEAD
>> ------------------------------------------------------------------------=
---------------------------------
>> 5400.4: empty receive-pack updated:new                178.36(428.22+164.=
36)   177.62(421.33+164.48) -0.4%
>> 5400.7: clone receive-pack updated:new                0.10(0.08+0.02)   =
      0.10(0.08+0.02) +0.0%
>> 5400.9: clone receive-pack updated:main               0.10(0.08+0.02)   =
      0.11(0.08+0.02) +10.0%
>> 5400.11: clone receive-pack main~10:main              0.15(0.11+0.04)   =
      0.15(0.10+0.05) +0.0%
>> 5400.13: clone receive-pack :main                     0.01(0.00+0.01)   =
      0.01(0.01+0.00) +0.0%
>> 5400.16: clone_bitmap receive-pack updated:new        0.10(0.07+0.02)   =
      0.09(0.06+0.02) -10.0%
>> 5400.18: clone_bitmap receive-pack updated:main       0.10(0.07+0.02)   =
      0.10(0.08+0.02) +0.0%
>> 5400.20: clone_bitmap receive-pack main~10:main       0.15(0.11+0.03)   =
      0.15(0.12+0.03) +0.0%
>> 5400.22: clone_bitmap receive-pack :main              0.02(0.01+0.01)   =
      0.01(0.00+0.00) -50.0%
>> 5400.25: extrarefs receive-pack updated:new           32.34(20.72+11.86)=
      32.56(20.82+11.95) +0.7%
>> 5400.27: extrarefs receive-pack updated:main          32.42(21.02+11.61)=
      32.52(20.64+12.10) +0.3%
>> 5400.29: extrarefs receive-pack main~10:main          32.53(20.74+12.01)=
      32.39(20.63+11.97) -0.4%
>> 5400.31: extrarefs receive-pack :main                 7.13(3.53+3.59)   =
      7.15(3.80+3.34) +0.3%
>> 5400.34: extrarefs_bitmap receive-pack updated:new    32.55(20.72+12.04)=
      32.65(20.68+12.18) +0.3%
>> 5400.36: extrarefs_bitmap receive-pack updated:main   32.50(20.90+11.86)=
      32.67(20.93+11.94) +0.5%
>> 5400.38: extrarefs_bitmap receive-pack main~10:main   32.43(20.88+11.75)=
      32.35(20.68+11.89) -0.2%
>> 5400.40: extrarefs_bitmap receive-pack :main          7.21(3.58+3.63)   =
      7.18(3.61+3.57) -0.4%
>
> We're doing less work so I'd expect to te be faster, but do these tests
> really back that up? From eyeballing these I can't find a line where the
> confidence intervals don't overlap, e.g. the +10% regresison is a
> .10->.11 "regression" with a [+-] 0.02 (so within the error bars) etc,
> ditto for the -50% improvement.
>
> Perhaps the error bars will reduce with a high GIT_PERF_REPEAT_COUNT, or
> the re-arrangement for keeping things hotter in cache that I suggested
> in 1/3.

Urgh, nevermind. Just after I sent this I re-read t/perf/README. I'd
somehow recalled that we'd emit error bars from it, but that's
Elapsed(User + System), not Time(.. + errorbar) as I thought, nevermind.
Still, numbers are such that I wonder if the differences are getting
lost in some noise...
