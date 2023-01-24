Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D71C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjAXOqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjAXOqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:46:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A927493
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:46:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so39548490ejb.9
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVrWc4dHJx6bYiaKYamDLeupzpWbfw1bdnA0zeoKagQ=;
        b=EfUMfg/nV0LwZyaZTxm8kt9Niq0PsYE08ARcZ68AuYcF1iGoYAXdZK9gHU8Sinzc5K
         ZwUwaLfsvgeY+xCyr5ZXAdqQCOGpo0LO3HRuQVkVqNRsewBlwsnr52jrCQh1iRgCTsM/
         NNMTnTl05ZnWbzN5X1ZD0iNaPXCdJq9s86JjWo0ZhohN6xoMtO82YkpNnKlxF9b3VKMI
         zcuQWmbXonLZGrVQOfPSDkO0g1zkWR4o99MlJPYVcUfj/S0kMJW1M9mkVAUdQlIbMCd0
         qXdQQdMqF1g04/PVtAzRXQeYoeLaEKnOXkEbNp9b804Rbk1ft3HJSkYZITYJHjBQ5TBR
         OZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVrWc4dHJx6bYiaKYamDLeupzpWbfw1bdnA0zeoKagQ=;
        b=S96VLmhXdvEymN9zlWu5hJJvCZvIEM4IKg+fwQcGLCZsIjFyFb+bfMNpdN88GapkeI
         VMENQvUtloQcmbXSpwbh9Rn6Ktp1qh90M1hUeAPE/EoQaOjdMS/njTFhFla7b6k9IG4/
         1OzrmDaTQfmfPwQnXAJO5zoQrnX7StZifHd+U3soY8jKHXTero6tFpKAHkmzhRa0uvYM
         4C3G8xKMH2PmFaBFxBHr3DNyAS7OZx5JZYnOfm+nuTgy/wMUhErfb0bJR6HVmbDWSFWs
         1Tbqei+DTo7siJ3L/h9a8qU4aQpwMI/joELnucHWLvUm3P3gE+yILtQ3+l9q8hpEjPhX
         rIdQ==
X-Gm-Message-State: AFqh2kp9XRsZNvEJaBPFUurZiY1f3cvchvnKJMmLHRCUN+Co2TmIHRZQ
        FONhpwhNxLb2q8IvWaqCCZ0=
X-Google-Smtp-Source: AMrXdXtKB/vnShjXO6T9s4N1yvqCeg20QioRbLZNaACwuYtYPs/T9j+NcBBK/YTtuH6oxkX0nxVLeg==
X-Received: by 2002:a17:906:eb05:b0:84c:7974:8a73 with SMTP id mb5-20020a170906eb0500b0084c79748a73mr28044643ejb.57.1674571606658;
        Tue, 24 Jan 2023 06:46:46 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id hs8-20020a1709073e8800b008727576e4ecsm999198ejc.117.2023.01.24.06.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:46:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a2810f20-c093-ba73-0fed-5d179e3e954b@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 14:46:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] sequencer: use the new hook API for the simpler
 "post-rewrite" call
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
 <patch-4.5-7a55c95f60f-20230123T170551Z-avarab@gmail.com>
In-Reply-To: <patch-4.5-7a55c95f60f-20230123T170551Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 23/01/2023 17:15, Ævar Arnfjörð Bjarmason wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> Change the invocation of the "post-rewrite" hook added in
> 795160457db (sequencer (rebase -i): run the post-rewrite hook, if
> needed, 2017-01-02) to use the new hook API.
> 
> This leaves the more complex "post-rewrite" invocation added in
> a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
> here in sequencer.c unconverted. That'll be done in a subsequent
> commit.

As a reader I'd find it more helpful to explain why the conversion isn't 
done here rather than leaving be to run "git show" to figure it out. If 
you re-roll perhaps we could replace the commit citation with something like

sequencer.c also contains an invocation of the "post-rewrite" hook in 
run_rewrite_hook() that is not converted as the hook API does not allow 
us to pass the hook input as a string yet.

Best Wishes

Phillip

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   sequencer.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 3e4a1972897..d8d59d05dd4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4834,8 +4834,7 @@ static int pick_commits(struct repository *r,
>   		if (!stat(rebase_path_rewritten_list(), &st) &&
>   				st.st_size > 0) {
>   			struct child_process child = CHILD_PROCESS_INIT;
> -			const char *post_rewrite_hook =
> -				find_hook("post-rewrite");
> +			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>   
>   			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
>   			child.git_cmd = 1;
> @@ -4845,18 +4844,9 @@ static int pick_commits(struct repository *r,
>   			/* we don't care if this copying failed */
>   			run_command(&child);
>   
> -			if (post_rewrite_hook) {
> -				struct child_process hook = CHILD_PROCESS_INIT;
> -
> -				hook.in = open(rebase_path_rewritten_list(),
> -					O_RDONLY);
> -				hook.stdout_to_stderr = 1;
> -				hook.trace2_hook_name = "post-rewrite";
> -				strvec_push(&hook.args, post_rewrite_hook);
> -				strvec_push(&hook.args, "rebase");
> -				/* we don't care if this hook failed */
> -				run_command(&hook);
> -			}
> +			hook_opt.path_to_stdin = rebase_path_rewritten_list();
> +			strvec_push(&hook_opt.args, "rebase");
> +			run_hooks_opt("post-rewrite", &hook_opt);
>   		}
>   		apply_autostash(rebase_path_autostash());
>   
