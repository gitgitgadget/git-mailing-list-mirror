Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF06C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiF3MDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF3MDk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 08:03:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028E19005
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 05:03:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e2so26273831edv.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BRNmqfZuCfdEgnPMTUl26a6IoBCQnrggO7l9MC+tSm8=;
        b=W8EhW8ndqz/BgSROztIW2ipujdaLb27XDDg9tsWMXJY/s7IHNQA7ZAjfK7QPZGEm24
         vBINqBgjQvFfO3U3kh1FD8ASzHav2XYJ82C+yrCkAQdPXgCL8QmnaBFsblaQB2Sm87Li
         WpnaBJ8Tfu5MXuq4fZkq2nP1mew9xezOH+atmlmG1mSNrg0BLHXa4J0ZkVcFjn8jl9f0
         7TDCBYgbNSJJlTrfigWZFESnKhvjwFz/lO2pipd5JpJbg5hrZ/A5FvOEGh4f4BNFTsxa
         f5+a1VWs5L3m/z194BVN/rHal/v5BIk8CDRUDXlNqaLP+FHxYdCuqtAuXxBgJOrvIGj2
         +CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BRNmqfZuCfdEgnPMTUl26a6IoBCQnrggO7l9MC+tSm8=;
        b=C/mJMcg1Gse/MX9jUTZ2t+NDaS2lkHKPpRhir8Ciw/EeJNLYzJKRXsnl1eyYCVQHk4
         /G35V+dsIqutv2KjVaCQK0KsdxXyCdNTrAebR3faQmj8HHx4jNOJi/fYBqdJDxqqlY9w
         RIO146ySyyYcjeXIkCtVnzCovSlg5Egk1Ph6Z1lNyx9zgezvH/XmQOjmKD3HKELD/rKJ
         m8IUVZoN2stb+EBt2lmq3IazAdN9flbnH/xj0Fn7zucP0ntmeZRGOxXpEvvE/npPP0ha
         FQxtGVcyHaHssoSQN1yEGq6mMcCGK5336wDQLKcBbVq/CgWgWSHyVG2W72UpxJQoTblz
         pPmA==
X-Gm-Message-State: AJIora81/H13E7hpf3DNMVZPCkMVHuFCvyR6RSxdp/fQaRrInzmJD7t0
        NW4XuJRj0eKkcBtyXL3qhgc=
X-Google-Smtp-Source: AGRyM1uJ6lmBh9M8nUSKW8MkaYD1+TFTJhheEGyvKyCdwxnV4uxY7c6iPvJfVrTcv7+izJn6lXxbBg==
X-Received: by 2002:a05:6402:11d1:b0:435:d76d:f985 with SMTP id j17-20020a05640211d100b00435d76df985mr10990744edw.8.1656590617077;
        Thu, 30 Jun 2022 05:03:37 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id t23-20020a170906609700b006fed062c68esm9089535ejj.182.2022.06.30.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:03:36 -0700 (PDT)
Message-ID: <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
Date:   Thu, 30 Jun 2022 13:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/06/2022 11:54, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>> the rest of the codebase but returns −1 on allocation failure to
>> accommodate other users of libxdiff such as libgit2.
> 
> Urm, does it? I just skimmed this, so maybe I missed something, but I
> don't see where you changed the definition of xdl_malloc(),
> xdl_realloc() etc.

XDL_ALLOC_GROW is defined as

+/*
+ * Ensure array p can accommodate at least nr elements, growing the
+ * array and updating alloc (which is the number of allocated
+ * elements) as necessary. Frees p and returns -1 on failure, returns
+ * 0 on success
+ */
+#define XDL_ALLOC_GROW(p, nr, alloc)	\
+	(-!((nr) <= (alloc) ||		\
+	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
+

so it returns -1 if xdl_alloc_grow_helper() returns NULL, which it does 
if there is an allocation failure or the multiplication overflows.

> And those are defined as:
> 
> 	#define xdl_malloc(x) xmalloc(x)
> 	#define xdl_free(ptr) free(ptr)
> 	#define xdl_realloc(ptr,x) xrealloc(ptr,x)
> 
> And for e.g. xmalloc() we do:
> 
>          return do_xmalloc(size, 0);
> 
> Where that 0=gently, i.e. we'll die() instead of error(), the xrealloc()
> then has no "gently" option.
>
> Is the (pretty glaring, if that's the case) unstated assumption here
> that this doesn't in fact return -1 on allocation failure, but you're
> expected to replace the underlying xmalloc() with an implementation that
> does?

I'm not relying on the return value of xrealloc() in the macro

> If so I'm doubly confused by this, since you're providing alternatives
> to e.g.:
> 
> 	#define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
> 
> So if that's the plan why would we need an XDL_ALLOC_ARRAY(), can't you
> just check that it returns non-NULL?
 >
> That's not possible with our current xmalloc(), but ditto for this
> series, and apparently the compiler isn't smart enough to yell at you
> about that...
> 
> I wondered if we were just missing the returns_nonnull attribute, but
> playing around with it I couldn't get GCC at least to warn about
> checking xmalloc()'s return value for non-NULL.

I'm not quite sure what you're saying in these last three paragraphs

Best Wishes

Phillip

