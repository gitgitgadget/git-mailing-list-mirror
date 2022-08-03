Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB83C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 14:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiHCOa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiHCOaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 10:30:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B146470
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 07:30:24 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j11so13010961qvt.10
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xn8HXmsK0XMK01dHfMZWxkd2fqnfWK+0dzYGbuIBKQI=;
        b=gjyt3xtjza6VhoXK0idkTiDXR/IdR5V2BO+ifyfiED7EkADRLIqpTXE2D8r253iOF7
         Ywg3rJqVa7qOOgYBMMgr+0GM1DQ0/xi8yVaZanP5n7ebBy6okTbkUqYb259eNPMNJAxF
         5rnp7EaVcD3VSAFOqZQDnQjaWZYosYpWUdP1U+AXnFb3a/9bVEFy/Bn2d9W6RmDpRv/o
         bvLl97OrSde5eY7cn1HufkADwcI0O17Fo5cG7LywPAMM7g/eWC+FRdM+VfVkmcWwgJNe
         i5ERMl5V+3ny/rVjHXCZGgJ1INGYzfre/L1tHmVierY5U1tIo40QZQDDXdKtf6uIlL4M
         OwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xn8HXmsK0XMK01dHfMZWxkd2fqnfWK+0dzYGbuIBKQI=;
        b=32bZ05FSA8Qi8QyzN8SZrExOqU/Q2dzddojSgw7dbs5467DV7Trb3FFO3sprqw8OZ/
         Zxlw7irEv10ZCm6ZtwvEZBixDDun1XJJNcc/wTRqD5d/7ENiW3/9JXeI5itP5/pAx0DS
         ngeZzw4HSKNnSjaGli7z8lm1nkSPyyqjh9mnosqA5TivJTIpob4b/abCzQglYI5NviHd
         LklUWCOPVqEYT5fgUm4kIKfRluCop6SkJ3nWsb0oRPkI1PeOhLRNNrevSQvKzFRoBW8S
         6TlloL+uQuqGDUCvdo6ATwq5V+Z/xsxXg90Iz5cWng42hfQsTGDazyvtFnzqZaeIrYU4
         dfLg==
X-Gm-Message-State: ACgBeo2YbHq02mFp+LQN48xHW/8t2SVsah9pA1eUr/flAtJGm00YRCpW
        fMmoZL9a5v/Cs1bAVWx3jIIIX/Oz+4qy
X-Google-Smtp-Source: AA6agR4AccZXcS6d+hHrIQZo4WtRafhon5j+eklUv43SDYPLNP4gBhuI5qlx6ERODNAbAvwPZNtGeA==
X-Received: by 2002:a05:6214:e6c:b0:476:a4bd:2b95 with SMTP id jz12-20020a0562140e6c00b00476a4bd2b95mr11115875qvb.25.1659537023225;
        Wed, 03 Aug 2022 07:30:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d582:a76b:8dd3:e924? ([2600:1700:e72:80a0:d582:a76b:8dd3:e924])
        by smtp.gmail.com with ESMTPSA id bj33-20020a05620a192100b006b5a12eb838sm12258571qkb.31.2022.08.03.07.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:30:22 -0700 (PDT)
Message-ID: <1db0d83d-0239-5a5f-3390-822ee780172e@github.com>
Date:   Wed, 3 Aug 2022 10:30:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 6/7] mv: from in-cone to out-of-cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
 <d30a358e-c9f0-55fa-8c8b-37f0cb0d7eb3@github.com>
 <9a568923-0b2c-8c41-e774-bcf8e6e9d9ea@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9a568923-0b2c-8c41-e774-bcf8e6e9d9ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 7:50 AM, Shaoxuan Yuan wrote:
> On 7/20/2022 2:14 AM, Derrick Stolee wrote:
>>> -        if ((mode & SPARSE) &&
>>> -            (path_in_sparse_checkout(dst, &the_index))) {
>>> -            int dst_pos;
>>> +        if (ignore_sparse &&
>>> +            core_apply_sparse_checkout &&
>>> +            core_sparse_checkout_cone) {
>>>
>>> -            dst_pos = cache_name_pos(dst, strlen(dst));
>>> -            active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
>>> +            /* from out-of-cone to in-cone */
>>> +            if ((mode & SPARSE) &&
>>> +                path_in_sparse_checkout(dst, &the_index)) {
>>> +                int dst_pos = cache_name_pos(dst, strlen(dst));
>>> +                struct cache_entry *dst_ce = active_cache[dst_pos];
>>>
>>> -            if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
>>> -                die(_("cannot checkout %s"), active_cache[dst_pos]->name);
>>> +                dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
>>> +
>>> +                if (checkout_entry(dst_ce, &state, NULL, NULL))
>>> +                    die(_("cannot checkout %s"), dst_ce->name);
>>> +                continue;
>>> +            }
>>
>> Here, it helps to ignore whitespace changes. This out to in was already
>> handled by the existing implementation.
> 
> Yes, I think it would be better to let `diff` ignore the existing
> implementation. Are you suggesting the `-w` (--ignore-all-space) option
> of `diff`? I tried this option and it does not work. But another reason
> is that there *are* some changes that are different from the original
> out-to-in implementation, so even though it looks a bit messy, I think
> it makes sense.

I'm just making a note that I looked at this not in its patch form,
but as a commit diff where I could use the '-w' option to get a nice
view. It's not possible to do that in the patch.
 
>>> +            /* from in-cone to out-of-cone */
>>> +            if ((dst_mode & SKIP_WORKTREE_DIR) &&
>>
>> This is disjoint from the other case (because of !path_in_sparse_checkout()),
>> so maybe we could short-circuit with an "else if" here? You could put your
>> comments about the in-to-out or out-to-in inside the if blocks.
> 
> I tried an else-if but it does clutter the code a bit. I think I'll
> leave it as-is. Or do you mind show me a diff of your approach? To be
> honest, this disjoint here looks logically cleaner to me.

Here's the diff I had in mind:

--- >8 ---

diff --git a/builtin/mv.c b/builtin/mv.c
index df1f69f1a7..111aafb69a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -455,10 +455,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (ignore_sparse &&
 		    core_apply_sparse_checkout &&
 		    core_sparse_checkout_cone) {
-
-			/* from out-of-cone to in-cone */
 			if ((mode & SPARSE) &&
 			    path_in_sparse_checkout(dst, &the_index)) {
+				/* from out-of-cone to in-cone */
 				int dst_pos = cache_name_pos(dst, strlen(dst));
 				struct cache_entry *dst_ce = active_cache[dst_pos];
 
@@ -466,13 +465,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 				if (checkout_entry(dst_ce, &state, NULL, NULL))
 					die(_("cannot checkout %s"), dst_ce->name);
-				continue;
-			}
-
-			/* from in-cone to out-of-cone */
-			if ((dst_mode & SKIP_WORKTREE_DIR) &&
-			    !(mode & SPARSE) &&
-			    !path_in_sparse_checkout(dst, &the_index)) {
+			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
+				   !(mode & SPARSE) &&
+				   !path_in_sparse_checkout(dst, &the_index)) {
+				/* from in-cone to out-of-cone */
 				int dst_pos = cache_name_pos(dst, strlen(dst));
 				struct cache_entry *dst_ce = active_cache[dst_pos];
 				char *src_dir = dirname(xstrdup(src));

--- >8 ---

I agree with you that the whitespace breaking the two cases is nice,
but relying on that "continue;" to keep these cases disjoint is easy
to miss and I'd rather let the code be clearer about the cases.

Thanks,
-Stolee
