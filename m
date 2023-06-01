Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D0C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 16:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjFAQfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjFAQfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 12:35:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC73B186
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 09:35:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65299178ac5so82274b3a.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685637342; x=1688229342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Yo4uAKFJh5JYSm+nsckjQ/yzwcwVpmY10lEcCxKA18=;
        b=j1xmAAaHRVqnY56oEMZqdOw1qPfpo+MRNjNomcSBt2ye3xoJHr00/VCOBeBpo7Il0/
         AvA3ntMBtZvQiMTLZ8ctACG1Z7PFkovZ2V0n1+uSX5KPCMkQ715iAKe2mmTqV185o+Hh
         IWGHdM/m5mx0Vk62DTQ8Dkmipeaa/2gu1ZhYP45J0xp3XoJgb2Ez5hrXyvv6S+e6rhq0
         fRo6MX4GRlASKCmr1Ky7gRzPxgOuLVd5MhZ+o+L0zlyppZjGPIyPDKPLj7eVK8HjE0Q9
         8spmuaVz8yAYa8yd/E4HmC0NkeXJHz0lS7bwa+sj1gywp393NeDazRpgSXtBl8azBZME
         7yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637342; x=1688229342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yo4uAKFJh5JYSm+nsckjQ/yzwcwVpmY10lEcCxKA18=;
        b=UNM9tclS2S4BpaFZ/1PYPSHzi2vg3QjEahkv0xxjZIv7f8XnLCvAJbigXP8eqeOY0T
         BHXFlSPsS59DGaB2UZfGVtreHPQ/+VXBq3exbiEAYhJ1sZ9wisOiXAeLmele9XUQ8J4w
         tYRMlCVyaMCm0HjgQil+rgoMUFmK2OjATj0yIY5ZQYYjk2/q0PtLrk+sBPjKIx2Tpa8P
         pRQ6ylC+qQeVf5hwiNHb6+NuSSHK9t57aTxPFmBED7MbP0daYspbHHvWD0PCvsjEQqPy
         vlPHlekytVbMcOfiDqpC6ub0DQCT1nhylV+mCI4iFk7F/2DVQCqQeB+Y9ZdyaT4z8Bjh
         aNVQ==
X-Gm-Message-State: AC+VfDxzRRX+tHwB6CVQrHk+DGMqyUu4vbBaWNDwy4F8s3qPYBF2R0qy
        ElfeYvMr9wCdClJhjWgfPp9N
X-Google-Smtp-Source: ACHHUZ5DZEVigknvI9oJ3CniWgnA1WSJa9xx2Ph+p/ueEeLFLJ3mDLOOk1Y6C2C7ysXq392l8E4rrg==
X-Received: by 2002:a05:6a20:1583:b0:10d:b160:3d5f with SMTP id h3-20020a056a20158300b0010db1603d5fmr12390258pzj.38.1685637342251;
        Thu, 01 Jun 2023 09:35:42 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a23-20020a62e217000000b0062dba4e4706sm4767325pfi.191.2023.06.01.09.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:35:41 -0700 (PDT)
Message-ID: <49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com>
Date:   Thu, 1 Jun 2023 09:35:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] replace-objects: create wrapper around setting
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The 'read_replace_objects' constant is initialized by git_default_config
> (if core.useReplaceRefs is disabled) and within setup_git_env (if
> GIT_NO_REPLACE_OBJECTS) is set. To ensure that this variable cannot be
> set accidentally in other places, wrap it in a replace_refs_enabled()
> method.
> 
> This allows us to remove the global from being recognized outside of
> replace-objects.c.
> 
> Further, a future change will help prevent the variable from being read
> before it is initialized. Centralizing its access is an important first
> step.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  commit-graph.c   |  4 +---
>  environment.c    |  1 -
>  log-tree.c       |  2 +-
>  replace-object.c |  7 +++++++
>  replace-object.h | 15 ++++++++++++++-
>  5 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 43558b4d9b0..95873317bf7 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -203,14 +203,12 @@ static struct commit_graph *alloc_commit_graph(void)
>  	return g;
>  }
>  
> -extern int read_replace_refs;
> -
>  static int commit_graph_compatible(struct repository *r)
>  {
>  	if (!r->gitdir)
>  		return 0;
>  
> -	if (read_replace_refs) {
> +	if (replace_refs_enabled(r)) {
>  		prepare_replace_object(r);
>  		if (hashmap_get_size(&r->objects->replace_map->map))
>  			return 0;

This and the other 'read_replace_refs' -> 'replace_refs_enabled()'
replacements all look good. Although we're not using the 'struct repository'
argument yet, I see that it'll be used in patch 3 - adding the (unused) arg
here helps avoid the extra churn there.

> diff --git a/replace-object.c b/replace-object.c
> index ceec81c940c..cf91c3ba456 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -85,7 +85,14 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
>  	die(_("replace depth too high for object %s"), oid_to_hex(oid));
>  }
>  
> +static int read_replace_refs = 1;
> +
>  void disable_replace_refs(void)
>  {
>  	read_replace_refs = 0;
>  }
> +
> +int replace_refs_enabled(struct repository *r)
> +{
> +	return read_replace_refs;
> +}
> diff --git a/replace-object.h b/replace-object.h
> index 7786d4152b0..b141075023e 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
>  const struct object_id *do_lookup_replace_object(struct repository *r,
>  						 const struct object_id *oid);
>  
> +
> +/*
> + * Some commands disable replace-refs unconditionally, and otherwise each
> + * repository could alter the core.useReplaceRefs config value.
> + *
> + * Return 1 if and only if all of the following are true:
> + *
> + *  a. disable_replace_refs() has not been called.
> + *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
> + *  c. the given repository does not have core.useReplaceRefs=false.
> + */
> +int replace_refs_enabled(struct repository *r);

Since the purpose of this function is to access global state, would
'environment.[c|h]' be a more appropriate place for it (and
'disable_replace_refs()', for that matter)? There's also some precedent;
'set_shared_repository()' and 'get_shared_repository()' have a very similar
design to what you've added here.

