Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BBC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJLNEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJLNEo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:04:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBC262E
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:04:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1196441wmb.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VPAonsJKe+P9tsDevc5hDXhMw8TaM2IRx8Lmitqgfzg=;
        b=Y/8x1bOP9xv4jbBogvQMbeQyRwQmBqJxlgoiYFv4gtREzKUZqTsff8agPv6lf+Szoy
         7PHprtVc64XA3XZhdijYYyylOy/O0F0juxVzeDw056ON2cpGTw55/S/2Nh8p+oABYihB
         JAkcH3eCvNLpECXoFUxkI6j5Ck/vxGLfrS+a86FDcFoF6xHyVbT6etkVtvZJgochrWh0
         d7t0kOjm8oe5M0wCNNh7TMu5t83oA679+XeetYOv9SBdDLA4pp6n5WoGzoph/gvhQtW2
         l0i9iMgFoh0uZVLoOjwi5mz/dtFodGWq26TXuwGrm/5q9VlHIFOL2iiZVTOAKPgWdFzs
         lRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPAonsJKe+P9tsDevc5hDXhMw8TaM2IRx8Lmitqgfzg=;
        b=iAasCdrFv/CRtYYK3mK53kGMybeNMLczkUTwLSGDiLfgD2gYEQTGPcH65NlVSQ1VYl
         6BprZmuvcHuzHO6HxB/YZiv61xxGawxG9jwNqx3okWHrN+dHO5cbLwbO18JWsblAP0lp
         KsX+HJT+utzxKm2O04ki7HQJfsIOdwU5u01XkXaIVmeuhmbkHDkTFcZsywyfyfxgvT4E
         W3Gpqh98BDOzZIBT09tw/u7cMQ+IorwrsIC3YkRhT2Umd9dkn7a70oYW111PFAepE4Wi
         7KuMTBuhn7xYfRcG5b3GBQ3ZYXhUOYDeIlnoSAfMT9z7MiPMzPQ7PRvRZkDyuhhpLiBW
         WYlQ==
X-Gm-Message-State: ACrzQf10SvNzPzatGomD+j0aFTIPKRq4U/oz0TJoVqTEcDbzvBTcfOcI
        BgPb3NKEhjYI2D0+qtjRm2w=
X-Google-Smtp-Source: AMsMyM6sRR0E+1f0pDQbExtOUJ3OZhX+/Dfv6Z9EUQTNDZvxZFYMLwvMcNzfajy5QEKVbI1G3X0BiA==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr2681805wmc.78.1665579877345;
        Wed, 12 Oct 2022 06:04:37 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id bt7-20020a056000080700b0022e62529888sm14145391wrb.67.2022.10.12.06.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:04:36 -0700 (PDT)
Message-ID: <ae08523f-13ac-d9aa-b787-f136a88b5804@gmail.com>
Date:   Wed, 12 Oct 2022 14:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 08/22] run-command.c: use C99 "for (TYPE VAR = ..."
 syntax where useful
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <patch-v2-08.22-279b0430c5d-20221012T084850Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v2-08.22-279b0430c5d-20221012T084850Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/10/2022 10:01, Ævar Arnfjörð Bjarmason wrote:
> Refactor code in run-command.c where the "i" iteration variable is
> being compared to an unsigned type, or where it's being shadowed.
> 
> In a subsequent commit the type of the "n" variable will be changed,
> this also helps to avoid some of the warnings we've had under
> "DEVOPTS=extra-all" since 8d133a4653a (strvec: use size_t to store nr
> and alloc, 2021-09-11).
> 
> Per the thread ending at [1] we already have this C99 syntax in the
> v2.38.0 release, per 6563706568b (CodingGuidelines: give deadline for
> "for (int i = 0; ...", 2022-03-30) we should re-visit the wider use of
> this syntax for November 2022, meaning within the window of v2.39.0.
> 
> As of writing it's earlier than that deadline and per [1] we want to
> "avoid open[ing] the floodgate and deliberately add more [this C99
> syntax]". But in this case the use of the syntax solves a real problem
> of conflating types, which we'd otherwise need to avoid by using
> differently named iteration variables (and the associated larger
> refactoring).
> 
> 1. https://lore.kernel.org/git/xmqqy1wgwkbj.fsf@gitster.g/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   run-command.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index bd45828fe2c..7b27e4de78d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -443,7 +443,6 @@ static char **prep_childenv(const char *const *deltaenv)
>   	struct string_list env = STRING_LIST_INIT_DUP;
>   	struct strbuf key = STRBUF_INIT;
>   	const char *const *p;
> -	int i;
>   
>   	/* Construct a sorted string list consisting of the current environ */
>   	for (p = (const char *const *) environ; p && *p; p++) {
> @@ -476,7 +475,7 @@ static char **prep_childenv(const char *const *deltaenv)
>   
>   	/* Create an array of 'char *' to be used as the childenv */
>   	ALLOC_ARRAY(childenv, env.nr + 1);
> -	for (i = 0; i < env.nr; i++)
> +	for (size_t i = 0; i < env.nr; i++)

In this case we're changing the type to avoid a signed/unsigned 
comparison. We could achieve this by just changing the type of i above.

>   		childenv[i] = env.items[i].util;
>   	childenv[env.nr] = NULL;
>   
> @@ -581,7 +580,6 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
>   {
>   	struct string_list envs = STRING_LIST_INIT_DUP;
>   	const char *const *e;
> -	int i;
>   	int printed_unset = 0;
>   
>   	/* Last one wins, see run-command.c:prep_childenv() for context */
> @@ -599,7 +597,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
>   	}
>   
>   	/* "unset X Y...;" */
> -	for (i = 0; i < envs.nr; i++) {
> +	for (size_t i = 0; i < envs.nr; i++) {

Ditto

>   		const char *var = envs.items[i].string;
>   		const char *val = envs.items[i].util;
>   
> @@ -616,7 +614,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
>   		strbuf_addch(dst, ';');
>   
>   	/* ... followed by "A=B C=D ..." */
> -	for (i = 0; i < envs.nr; i++) {
> +	for (size_t i = 0; i < envs.nr; i++) {

Ditto

>   		const char *var = envs.items[i].string;
>   		const char *val = envs.items[i].util;
>   		const char *oldval;
> @@ -1789,7 +1787,7 @@ void run_processes_parallel(int n,
>   			    task_finished_fn task_finished,
>   			    void *pp_cb)
>   {
> -	int i, code;
> +	int code;
>   	int output_timeout = 100;
>   	int spawn_cap = 4;
>   	int ungroup = run_processes_parallel_ungroup;
> @@ -1801,7 +1799,7 @@ void run_processes_parallel(int n,
>   	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
>   		ungroup);
>   	while (1) {
> -		for (i = 0;
> +		for (int i = 0;

Here we are moving the declaration to the loop.

Am I missing something, I don't understand how these changes match this 
description in the commit message

 > But in this case the use of the syntax solves a real problem
 > of conflating types, which we'd otherwise need to avoid by using
 > differently named iteration variables (and the associated larger
 > refactoring).

Where are the cases where we'd need differently named variables if we 
did not use this syntax. In each case we delete the old declaration.

While I can see the point in avoiding the signed/unsigned comparisons I 
don't think it is strictly related to the topic of this series.

Best Wishes

Phillip

>   		    i < spawn_cap && !pp.shutdown &&
>   		    pp.nr_processes < pp.max_processes;
>   		    i++) {

