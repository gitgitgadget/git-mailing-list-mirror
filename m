Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB94C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9136113D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhI0JPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhI0JPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 05:15:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F3C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:13:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so50478376wrb.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oPXjed6j+zF1Y6hSp6RmTZ0hOzdQQPsZs+3CeH6GqAY=;
        b=AydkW/i/t+z6TQZfi70fs1BNJCvYz/uBEcW8OIRdMNuLaO/ewMb9iQGGj65z8DBo5K
         LYU3u9J7gmiNgYAmPs1fQe2mMR4iRF06pqdr9aA+4dkrviSFDR+Uif9lo9Zt3C6M8QNv
         GusP4H/89ZjHv1Hf8ysB3T+1/4MGL5V/puY2lwsDupueMGlPvDY43Q4Gk1QtBync9Wfg
         ejo/sf7YIdJBt0eRAkhLiIwsPaVWWUC6KhS7RbBnaBwjT3yZ2Kl67YtTAAGiJPjC+3S+
         T2RYk6MpWbWtLIkC80pTX/wRM0sJnM5+Uevg+eaEdEPgyH8Xx16O1L+IM9Cigi20E4sC
         w3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oPXjed6j+zF1Y6hSp6RmTZ0hOzdQQPsZs+3CeH6GqAY=;
        b=ygdevmmuQ2W2IXIMljhBPboURuCb/pRaSRqXjyctHoqS40Xt/WlOTF4AYj0swWebkI
         PMZiEqeIka0Myw8xBhzloeOkhlYRsGOwUuscLARDZjfy185giYJZjMjRY8YTTav0/bXH
         FcRW0tfEPqGGU8uXfa9DbQtW2xXe7rxAp/LndONxSmxP4F0miB+Ic8F6IcbxOfk+Zlb4
         otsIXZ8m3vzAKrXAZnv1TVdO7xM2bsKKt7m2qk2aKzi0/TEv8zSvDQY9hLXbdcYuypkB
         tu/wPJ81DosGsoN9p/seooCxRY4+zessZTfF4Si/PvFL1rgf4bgyf16k0orQJBC/hRre
         P4mQ==
X-Gm-Message-State: AOAM533p7FUtxYNr6DXxBpJBTpvv4oEIYbY/wigo779drEK3hSjQuFiu
        zTeS5QhAekvSI+Ern9Wcvks=
X-Google-Smtp-Source: ABdhPJyrPui6dV63sZDgbgKapvQ1DFdWZvk1kp5ymAw5m3Ljkf+yqm5T2xXoFLdm3agogS2o8v0iGQ==
X-Received: by 2002:a05:600c:b41:: with SMTP id k1mr15039630wmr.4.1632734034167;
        Mon, 27 Sep 2021 02:13:54 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id g2sm16806460wrb.20.2021.09.27.02.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:13:53 -0700 (PDT)
Message-ID: <ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com>
Date:   Mon, 27 Sep 2021 10:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 27/09/2021 01:39, Ævar Arnfjörð Bjarmason wrote:
> Use the same pattern for cb_init() as the one established in the
> recent refactoring of other such patterns in
> 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
> macro, 2021-07-01).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   cbtree.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/cbtree.h b/cbtree.h
> index a04a312c3f5..dedbb8e2a45 100644
> --- a/cbtree.h
> +++ b/cbtree.h
> @@ -37,11 +37,12 @@ enum cb_next {
>   	CB_BREAK = 1
>   };
>   
> -#define CBTREE_INIT { .root = NULL }
> +#define CBTREE_INIT { 0 }
>   
>   static inline void cb_init(struct cb_tree *t)
>   {
> -	t->root = NULL;
> +	struct cb_tree blank = CBTREE_INIT;
> +	memcpy(t, &blank, sizeof(*t));
>   }

Slightly off topic but would this be a good site for a compound literal 
test balloon?

	*t = (struct cb_tree){ 0 };

Compound literals are in C99 and seem to have been supported by MSVC 
since 2013 [1].

Best Wishes

Phillip

[1] 
https://docs.microsoft.com/en-us/cpp/porting/visual-cpp-what-s-new-2003-through-2015?view=msvc-160#whats-new-for-c-in-visual-studio-2013

>   struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
> 
