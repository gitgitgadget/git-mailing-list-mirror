Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D07C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605396124B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349723AbhDGIzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349753AbhDGIzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 04:55:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9041C061763
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 01:54:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mh7so16395178ejb.12
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uRIx2+gVEzRzd0q78vpTBLN3lKZwL60D70ntV2/5/+c=;
        b=IhsjO8+Fktz/h3VOCOfY75uUHAje4mIVxHoOHtIKAPm/92ZQ7M64jh3NanWHZbyvhc
         X+Ft6gpG8AUDYKzHaS8j3OWMkvd5EylEfaQZ2WjMH6hh/zaSuChzRBJW2uirR3/akN3S
         MCVQg150DTTg6002njrX4SjbccWU0agTsg00LVEBPPOoH7e9PwKKcsbVi4m9khUIsg6J
         zrUhn83dkwPVtp6mPP0WgkY0OHiYaJ/gKyy3Jt5XvMR5OXWhTd+0bYeq6XDY3Jsm71qk
         t0ibJlG3Zf+Gwr3x47mDOSJw0oaofTvlpEbiXbuBc1SaJ3x59Hx9kybV/vS0OhNy7yfq
         gLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uRIx2+gVEzRzd0q78vpTBLN3lKZwL60D70ntV2/5/+c=;
        b=saAsdJf/sgunNkSivdKA6UqpHJfn5ybaGsx9BZeBzth4v2VoXk37XGIjflBcLUPR8c
         zcVUZm1MO8KMfNOrZtCGMHysJTmZT8ffs4ikBqwGkW444FGybMJsbn78pWQVOABgc6fr
         tlCVkHvcLWF4DZjCxolN9w0fVj9tN1mQbO1zjoZfpFx2L49QzRpzuR/hQnGjAYVIrbu6
         ZwCJvAewIfGQeXVFb4XtAefBo5ucN45qy+EYFzcf0CkSKYQsrkyMR7NLwBkXihSB+xqi
         zxMOpf6rqGA8mxiRM36SoKXl9ZBXUVsySRLvqFTGcLpI9uz/P8KnK5+Q2NvZ4pJK9HtK
         WhiQ==
X-Gm-Message-State: AOAM533h3U/Dcql6dMjTpB71KW/WGrfZ2B2SeojaPtFfTHogH24TCh12
        a6MHm/qJbsTeYc7XH1FqBAs=
X-Google-Smtp-Source: ABdhPJzKVytApRtceNrj9Gt1y0Ausc9WenseCr17N2iQlrQm644Ci4mn6J1z2oiDD5C8Tyx0rf/CvQ==
X-Received: by 2002:a17:907:652:: with SMTP id wq18mr2511170ejb.14.1617785698428;
        Wed, 07 Apr 2021 01:54:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s9sm14535454edd.16.2021.04.07.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:54:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/5] test-tool: test refspec input/output
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <c8d1de06f84499f2f56b3a06df665630806f94ce.1617627856.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 10:54:57 +0200
Message-ID: <87lf9ujwym.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:

> +static const char * const refspec_usage[] = {
> +	N_("test-tool refspec [--fetch]"),
> +	NULL
> +};
> +
> +int cmd__refspec(int argc, const char **argv)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	int fetch = 0;
> +
> +	struct option refspec_options [] = {
> +		OPT_BOOL(0, "fetch", &fetch,
> +			 N_("enable the 'fetch' option for parsing refpecs")),
> +		OPT_END()
> +	};

I don't think we should waste translator time by marking these (or
anything else in t/helper) with N_()).

I see you probably copied this from elsewhere & we should probably fix
the existing ones, but no reason to add new ones...
