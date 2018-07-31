Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9C61F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeGaB4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 21:56:31 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:52349 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbeGaB4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 21:56:31 -0400
Received: by mail-vk0-f74.google.com with SMTP id t7-v6so6080206vke.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U8SsLCQ1NhFJa0VUmmDMCmNMxJ17OFxsh1vXG0AYQkE=;
        b=QQ3ojcW5c0IroNFHD4HKmc6lNXiaSA2hzqzoPIKiW6ybPcOO5HanOqSRwP2C/9hbE8
         liYf3zrMk/85FIWBz5QN2+2jOiBmvu1lXDw199vB+fral5H7yL9KZgdqE1wme6K+EMUY
         lTO1A5RQfH+2Mc6d56vA0N7AZTd2suEMDqnzlg+M6y+OfPENL0Tpl1OH/ZlU0JAjBajk
         hjlaHADEwYQXxj+J3iTPrbjz+7qwHMWuItCUJZ4m9RCqZopOE0OIh2HSKJmXSn6bDHbE
         SJJttYGpQRlRkEUtsvAlrT4NA0G6tQ23UtgPrRnHsPcnmvZ3xbe76heI+TcUu+EGrbqr
         WXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U8SsLCQ1NhFJa0VUmmDMCmNMxJ17OFxsh1vXG0AYQkE=;
        b=TBgOSqfEWA8uLpy4KIKFWZz9AOz5dvRCYOfdANRR+KzvQqjDgq5p4XlK9Ij+B2Tdzg
         iRdgEfVeQp81yMUXFtf8WKlRfcnmHX9Wki4xbGMivFx0361uvSmszhAQSAmRpI5Lw9Ew
         y4CZ8wm5LUeIDX6O07Uu9eUHERqHy2cRmU5YOzt8xC/TFGEewcvzUdF3qMMkjpkbuNUz
         emli0q8/FGlTILCyPDyn5evd6v+oC+tjxfY4StRw9aq431kQ7JlrCfp7jSauBHsJKWRM
         5kfnhGr1qDyiCEdKtnOAk4PP3SIhHupoqPxJVhQBzkByZKUEegOpepFvRR15ZL17et0o
         Mnjw==
X-Gm-Message-State: AOUpUlGuXq4eBlZFa8n/jzgOu5hzghBr22ip7iqh8Q4HrdWn5tyxz83c
        26bXC0XMtBjSir3j8teFcPORUK7Ge1nuROrWg46d
X-Google-Smtp-Source: AAOMgpe82n0FAfksWkh98XPKaRq0kKymYCo8Rk758ExEqBaIznQQ4i6nCsMUheu4vmvjATOM9PFaAwOdtmNjxAD4qWLF
X-Received: by 2002:ab0:5943:: with SMTP id o3-v6mr9239515uad.62.1532996341840;
 Mon, 30 Jul 2018 17:19:01 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:18:58 -0700
In-Reply-To: <20180730194731.220191-3-sbeller@google.com>
Message-Id: <20180731001858.122968-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180730194731.220191-3-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.322.g81f971752d
Subject: Re: [PATCH 2/2] refs: switch for_each_replace_ref back to use a ref_store
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     pclouds@gmail.com, bmwill@google.com, git@vger.kernel.org,
        mhagger@alum.mit.edu, stolee@gmail.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So let's go back to the clean API, just requiring a ref_store as an
> argument.

Here, you say that we want ref_store as an argument...

> -int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
> +int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(get_main_ref_store(r),
> +	return do_for_each_ref(get_main_ref_store(the_repository),
>  			       git_replace_ref_base, fn,
>  			       strlen(git_replace_ref_base),
>  			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);

...but there is no ref_store as an argument here - instead, the
repository argument is deleted with no replacement. I presume you meant
to replace it with a ref_store instead? (This will also fix the issue
that for_each_replace_ref only works on the_repository.)

Taking a step back, was there anything that prompted these patches?
Maybe at least the 2nd one should wait until we have a situation that
warrants it (for example, if we want to for_each_replace_ref(), but we
only have a ref_store, not a repository).
