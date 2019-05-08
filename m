Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D190A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 14:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEHOWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 10:22:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35697 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEHOWL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 10:22:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so3305012qkl.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnKU/YF878uVYavuDR+PoQdu91NC93/ms2tnbX9F8f4=;
        b=O3gHfo++Fq2zkMksvlU8LFjY464oLd4b8lNLMR9OUTq2BhEna6eV2sfNOdlHotEe21
         liUGC4ptTfLJKejgJrOUiDyBAFw6ZX48few6QC27wzkPlYN94knYXa0AB+2uWiV9LvxK
         4rwgV/quhuXYzGLDJV+PIY73Msz0Y26Bch7Kck/xAtDaU7bKR5RB8pqxFaDw468D1uFo
         61W2OMwsttUvYG9huxbfTJUjDQzHLnNrkXe8auYSynSoFvN+Jsjf+UvG6OtAUjWTcxri
         uNyWYwHRq9QoAi9ViCJjQLQdi3fR0+LVMoGrsMX/QqIiG+hKDuabRv3w4C9g7i6lhbLz
         nj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnKU/YF878uVYavuDR+PoQdu91NC93/ms2tnbX9F8f4=;
        b=fH1a1LuCg0pyLbEv8EWtc7EzHURd8G5z6khWsTPT6WiGGzOXjsKsLFkBF0ELc6Y0lL
         qV0fFlqVMjWRkdDeXviSIgzJXzlgZa1HUKIfz8r3/94CBVjS00EvRFBG3HyE3BgXECid
         //sdZyXcM3Oj52OBoVLUlOSn26I9VCv+GADDdjse08QsYi13almEeZJ3WLzIDOb5Sg0R
         1tqlDQRZ0QJH9PeYs18x5ivPwRWiC6gFhbPXdo0mBTh8+f/BSuLs6GtcktI3kVihPWYV
         6YC0UUgZEpjh3BFK6cFbmqEVmbzAg9Zz9Yy7q0vFXu1v8f1FngcmeloxhrxGx/2TrCh8
         U6Jg==
X-Gm-Message-State: APjAAAVDEwKHfBQm+j/q/oPmT8KeX9Tg2D1H5uUh/JQJBdbCR9unKRyn
        2Hlaw+vRFi56AQfCWT0SThs=
X-Google-Smtp-Source: APXvYqyeWQWGvBJmFIbk3vgYLj0fBf2pgY1NUwjX6ihYO8ZFK68qFjkkzPzVHiR8B3jkkadHlIUF0g==
X-Received: by 2002:a37:73c3:: with SMTP id o186mr30016573qkc.71.1557325330717;
        Wed, 08 May 2019 07:22:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:243f:92bd:dfb0:fd97? ([2001:4898:8010:2:d73:92bd:dfb0:fd97])
        by smtp.gmail.com with ESMTPSA id f127sm11161603qkb.53.2019.05.08.07.22.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:22:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] midx: pass a repository pointer
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
References: <pull.182.git.gitgitgadget@gmail.com>
 <3b6324df4d26f47058a714abe47b9df7811c383e.1556554734.git.gitgitgadget@gmail.com>
 <xmqq8svimzrz.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1733843e-f0e4-0e25-468b-64727f6855d5@gmail.com>
Date:   Wed, 8 May 2019 10:22:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqq8svimzrz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2019 4:31 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Much of the multi-pack-index code focuses on the multi_pack_index
>> struct, and so we only pass a pointer to the current one. However,
>> we will insert a dependency on the packed_git linked list in a
>> future change, so we will need a repository reference. Inserting
>> these parameters is a significant enough change to split out.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
> 
> This is a good move in the loger term, but not a happy thing to do
> while your "expire" topic is still in flight, as the impact from
> updating the signature of prepare_midx_pack() and friends will break
> new callers in expire_midx_packs() etc.
> 
> I am tempted to queue this and eject ds/midx-expire-repack for now,
> while checking how that topic would look like when rebased on top of
> these two patches.  We'll see.

Sorry for the noise. I consider this series a higher priority, as it
fixes a problem with the feature in existing releases.

Thanks,
-Stolee
