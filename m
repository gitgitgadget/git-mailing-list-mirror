Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBD3C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 23:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFAXf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAXfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 19:35:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70BF2
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:35:53 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b024ab0c28so13329285ad.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685662553; x=1688254553;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+LbuiwLq1wL4Ty/jNANMqQBZFFdufTP29VPRokwCy94=;
        b=ZIdJG5irjRC5aQH1UODGLEz3tocPyWqaIBoM5zpAh7YaLYKBh7EW/10xgEUMt+gM/9
         lV/RMGrSnCnJ5U8tbApvQtsCJkvph4H6d1icnkvHJP4T89Zr1DTlFGqz9vQwRdqhMKUQ
         BuE393IVzF/WgljuZrEcySBwn48+Pf4MvOgSQHu8o8SCSjiMt9RBUw26K/xRVoyzFSH0
         mT9B4GTRwN7D9+TvaflM8DjmFkTQSObj6Ri0nwFMr/P15hw510AOn1KMlW1wHhxC/7cF
         CUf8FKBRg1RdfL8Vg+mermY5Hx2uairgJzfG/8tD1kH2dAlaPuRcvYrFFTSV0Zhzqc29
         hZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662553; x=1688254553;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LbuiwLq1wL4Ty/jNANMqQBZFFdufTP29VPRokwCy94=;
        b=Yi2slbORKvqwVbOs1EavNbpdul0nFDYX1QoSw69oxbkorAVUAKuSI4yRKJkwM9wUC7
         sRWZqGkk0wIsFr0KDvCbTvBr871hw+rMI4Swgmb+C4ndvGIvC3Xth7gDIaIbW483aghr
         SwTpj6Adsmi+Uc6+sesPLX9TmETzVtBkmkpXql23xu0P2r10YYYtYGhrBqSPIjM6RyRv
         RLhWB05iG7JN0adcoDOpQ/o73KyJlTBcLaB8+E+AxpvQVbZZEZRgfkB1GOVxYiggdNpJ
         pmVuaZMrivAH8f4gp6AQtWA0eBU4XxI7fjwx915VlVBGmm2+yyrw1+dAC3LHbIiA+pnv
         ChBA==
X-Gm-Message-State: AC+VfDw8/+8vI8nx7AR2xRVAFI4Xb0h8JaP6WEHrQtkkV4B8rOQXILiE
        WPGB8KyZgNmnFibgMri46BZgc6qOiV2kW0Nzc/es
X-Google-Smtp-Source: ACHHUZ63n8ygC6H/h1LVpoQ/biqfyFTLdDb7ahvZTjwxd5SnKa7rIRhwNowBfwhJNy/QEgmkOXPv77YXJUF4W/S+ywfc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:234d:b0:1ac:6a9e:82dc with
 SMTP id c13-20020a170903234d00b001ac6a9e82dcmr216099plh.11.1685662553185;
 Thu, 01 Jun 2023 16:35:53 -0700 (PDT)
Date:   Thu,  1 Jun 2023 16:35:50 -0700
In-Reply-To: <3760015d2c000c59d354bae872c431ee3266e9da.1685472134.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601233550.429921-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 09/14] config.c: provide kvi with CLI config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> plumb "kvi" so that we can replace
> nearly all calls to current_config_*(). (The exception is an edge case
> where trace2/*.c calls current_config_scope().

Probably clearer to say:

  plumb "kvi" so that we can remove all calls of
  current_config_scope() except from trace2/*.c (which will be handled in
  a later commit), and remove all other current_config_*() (the
  functions themselves and their calls).

> Plumbing "kvi" reveals a few places where we've been doing the wrong
> thing:
> 
> * git_config_parse_parameter() hasn't been setting config source
>   information, so plumb "kvi" there too.
> 
> * "git config --get-urlmatch --show-scope" iterates config to collect
>   values, but then attempts to display the scope after config iteration.
>   Fix this by copying the "kvi" arg in the collection phase so that it
>   can be read back later. This means that we can now support "git config
>   --get-urlmatch --show-origin" (we don't allow this combination of args
>   because of this bug), but that is left unchanged for now.
> 
> * "git config --default" doesn't have config source metadata when
>   displaying the default value. Fix this by treating the default value
>   as if it came from the command line (e.g. like we do with "git -c" or
>   "git config --file"), using kvi_from_param().
> 
> Signed-off-by: Glen Choo <chooglen@google.com>

Thanks for noticing and fixing these.

> +	memcpy(&matched->kvi, kvi, sizeof(struct key_value_info));

Can this just be

  matched->kvi = *kvi;

?

If not, for the sizeof, use *kvi as the argument instead of struct
key_value_info.
 
