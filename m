Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D367C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 03:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiC2DCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 23:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiC2DCl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 23:02:41 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CE1FE55C
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 20:00:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id hu11so13432010qvb.7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cypgQKKvSVRPsSERNxgDx1dZ2/f+oODMts46AyAVWc0=;
        b=SUFhUJ1RR0HaRjNCUL0ZzVw3Oc20jp8XZrT5ANElh2XUqy94x8gynl9xWAGRStlaCy
         deQclpI3uPu1Hdxg/36D5tKnG0XRqrdoN0Iyv2+x0lWW23S50BhFCL5t/vQ5TOjuP7Pd
         35L13Ldd/FDWAoYRgr4XmOwnpgM43t4QMskwfEVqj4vUMRjzB8JLPkJiJPAvcEQI51BG
         oi3zc6jE/QiQUexLWkLYoOXJkuUOhfXFUveSVwYnvB/QcdkpEIulIFt7aRvovRlSzl37
         xgffF6jo2+HkFyzkZROAzIjeFEjX1xwSos7NN7OO8tKlVsANz5mFoQ1tNIUnbG7Qv0F/
         IsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cypgQKKvSVRPsSERNxgDx1dZ2/f+oODMts46AyAVWc0=;
        b=5MJfzJSxkyvxCjKtb7zHJ7Yy9QaiFP1jMUqWetD9AwT/uMeeUFzyidGflfUb7VcUjm
         wCM8004Z1m3sRZIOXejgWZIuAOtdf4q2IjttxNTgFodhNchuiKQkPZT2Nak0U5pGjDvI
         xmRUxkpPawdXV4QRTFKho/8bcFvBxyuxTfjCRDS3qCcU1B0RDZZ3+Dhg+xmnC3/UHfVo
         a6felFpE52SoahW8HWQkYqVIhYxISA95kGpu3D+m5YBxEX+FToPIdn++XPET/xEtEixu
         PWkjGVwYp+nJqljfNrfCvDUHIulo7zmkbkxAa/V9uDgxrzm8lvvB2Tcz9b7AW1+KhYAB
         7DsQ==
X-Gm-Message-State: AOAM531fjrZYSO6HNbC2iGO7DjE4rMoc4qt0pcF2WG8mjM0nrTnBEGL3
        GrmpDcnGKw2Bmp6pBFo1k6k=
X-Google-Smtp-Source: ABdhPJwXuq0iAD8eDGXP7ifD1uub24k7eeub+geFQk5WvEGRhDoHxfmAETIO4efaFjTM6JgA4sGHFQ==
X-Received: by 2002:a05:6214:20ef:b0:441:3a9:40d8 with SMTP id 15-20020a05621420ef00b0044103a940d8mr23697402qvk.85.1648522856008;
        Mon, 28 Mar 2022 20:00:56 -0700 (PDT)
Received: from smtpclient.apple ([2601:184:4a7f:100:68a0:55fc:f729:cf38])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85842000000b002e1ec550506sm13697299qth.87.2022.03.28.20.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 20:00:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Desmond Preston <despreston@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/2] worktree: accept multiple paths
Date:   Mon, 28 Mar 2022 23:00:54 -0400
Message-Id: <48242777-6442-4A4D-BE76-1B9EF2F7175B@gmail.com>
References: <xmqq35j1zi7j.fsf@gitster.g>
Cc:     Des Preston via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqq35j1zi7j.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

k.=20

> On Mar 28, 2022, at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> =EF=BB=BF"Des Preston via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Des Preston <despreston@gmail.com>
>>=20
>> Update the worktree usage to show that the repair command can take
>> multiple paths.
>>=20
>> Signed-off-by: Des Preston <despreston@gmail.com>
>> ---
>> builtin/worktree.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 8682ff4c417..498975c1fd9 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -22,7 +22,7 @@ static const char * const worktree_usage[] =3D {
>>    N_("git worktree move <worktree> <new-path>"),
>>    N_("git worktree prune [<options>]"),
>>    N_("git worktree remove [<options>] <worktree>"),
>> -    N_("git worktree repair [<path>]"),
>> +    N_("git worktree repair [<path>...]"),
>=20
> The fact that this line was introduced in [PATCH 1/2] and then
> needed to immediately be corrected with this patch means the
> previous patch was suboptimal and this patch is "oops, the last one
> was bad and here is a band-aid fix-up".
>=20
> Let's not do so.  Instead, you are encouraged to pretend to be a
> more perfect developer who does not make unnecessary mistake ;-)
>=20
