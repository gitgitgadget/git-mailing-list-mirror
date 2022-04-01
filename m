Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3E4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348512AbiDAQEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351947AbiDAQCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:02:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063035AA56
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:29:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b19so4746433wrh.11
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R6AlyPGNhskBrz8NQ7TGSMSIHV+6VLkWZpkD9W89tB4=;
        b=NHq28yHB0a7rMWohGqFfgzF0sJjc+AONLQE7KIclffr0fxjG9QMpXE8SChMq3IPF0R
         UmfLQTt6HPb0pWcfFuXQQHreGM5WinBxtKzcpSWYEa1D6mAXumUdmU44DEj2KUuF4A2a
         HsWGy9zF6fK7jVJg2x0HEuS/69s1Ncp4I4O1qCuZq1i7jQTxud5bKqDOQskMKyYNg8Mw
         RrQqjKmOgGLMGO2iInOw+ZZABbicbz6eCVpY022Y+ZPGr+oSq5QeiF1NLVzHvK7YjDlg
         Wbduu2X2+QrL2lCXERF1uLTVmHurGpv0e9e9lbV9Z1gRgU0qVOWWxlHHdY7CVu6fyVvT
         Qnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R6AlyPGNhskBrz8NQ7TGSMSIHV+6VLkWZpkD9W89tB4=;
        b=h6kYc7T9YBdgvaZjyq+l35/m8fZmS6MucqpEaue8khATNGa4qtwN3SWmf3aAUpL7CU
         Dq4Gj0tNl+pCMcut71f/azAruPXcP5rU5y5OQ9uhY8tH91O7GIprCpxaj3Cv3a0bJx1U
         ujsGkhTX2eF6HLHpHClP9Lp2b/IxNksluxAcMJet5fK2XX1Y+p5lrw617edN+E5k9dAz
         8uTgXlzHe5C4N2h12jg3Ry5WFeOGQaH+83aZ+jPjKqpzhM3qonsC0imbi9EUASG5Nd7X
         cOsEnoftytio2qKm8Sm/ylMKDe+THOOChEHO0ZOUcyhZjxIOycGDlluYAco/Fm3SmZjX
         lXQQ==
X-Gm-Message-State: AOAM5314jyjgfMZFAldWcznnrOcb1uimYkddOdE97ysSYi1p43PMa1Wv
        cWS6wUVGZ7NB2u9bWiQI+rw=
X-Google-Smtp-Source: ABdhPJwIKtsIS/isOiaNn9KJuGpSJtXywLIUbLfL4ycsomQJzwIpHyKuzudal+WovRia6KbGUfu3OQ==
X-Received: by 2002:adf:82b2:0:b0:203:f34d:dff with SMTP id 47-20020adf82b2000000b00203f34d0dffmr8061199wrc.661.1648826984432;
        Fri, 01 Apr 2022 08:29:44 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d4051000000b00205a8bb9c18sm2261842wrp.67.2022.04.01.08.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:29:43 -0700 (PDT)
Message-ID: <9a487124-ef1e-0644-9585-174343555914@gmail.com>
Date:   Fri, 1 Apr 2022 16:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 10/27] stash: always have the owner of "stash_info"
 free it
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> Change the initialization of the "revision" member of "struct
> stash_info" to be initialized vi a macro, and more importantly that
> that initializing function be tasked to free it, usually via a "goto
> cleanup" pattern.
> 
> Despite the "revision" name (and the topic of the series containing
> this commit) the "stash info" has nothing to do with the "struct
> rev_info". I'm making this change because in the subsequent commit
> when we do want to free the "struct rev_info" via a "goto cleanup"
> pattern we'd otherwise free() uninitialized memory in some cases, as
> we only strbuf_init() the string in get_stash_info().
> 
> So while it's the smallest possible change, let's convert all users of
> this pattern in the file while we're at it.
> 
> A good follow-up to this change would be to change all the "ret = -1;
> goto done;" in this file to instead use a "goto cleanup", and
> initialize "int ret = -1" at the start of the relevant functions. That
> would allow us to drop a lot of needless brace verbosity on two-line
> "if" statements, but let's leave that alone for now.

You seem to have made this change here.

>[...]
> @@ -861,10 +863,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>   			strvec_push(&revision_args, argv[i]);
>   	}
>   
> -	ret = get_stash_info(&info, stash_args.nr, stash_args.v);
> -	strvec_clear(&stash_args);
> -	if (ret)
> -		return -1;
> +	if (get_stash_info(&info, stash_args.nr, stash_args.v))
> +		goto cleanup;
>   
>   	/*
>   	 * The config settings are applied only if there are not passed
> @@ -878,8 +878,8 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>   			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>   
>   		if (!show_stat && !show_patch) {
> -			free_stash_info(&info);
> -			return 0;
> +			ret = 0;
> +			goto cleanup;
>   		}
>   	}
>   
> @@ -912,8 +912,11 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>   	}
>   	log_tree_diff_flush(&rev);
>   
> +	ret = diff_result_code(&rev.diffopt, 0);;
> +cleanup:
> +	strvec_clear(&stash_args);

This seems to be fixing a leak that's not mentioned in the commit message.

>   	free_stash_info(&info);
> -	return diff_result_code(&rev.diffopt, 0);
> +	return ret;
>   }
>[...]
> @@ -1434,7 +1438,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   			 int keep_index, int patch_mode, int include_untracked, int only_staged)
>   {
>   	int ret = 0;
> -	struct stash_info info;
> +	struct stash_info info = STASH_INFO_INIT;

There doesn't seem to be a call to free_stash_info() in this function.

Best Wishes

Phillip
