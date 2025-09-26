Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABB2F7ABA
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895968; cv=none; b=M211tBGRw03br1OdOK7g7tupOLtwtPDgxrvj9mT467Yl1GF/exAUGagFAeJFZmsPPxStytg98DBI7lPLlwsEhoFsKlMbtrtdZ/a28DHwkSnd1kKPjszRm9wJg0A+O5CwJA/9ND1it+nBUYZHwISYfvo+e6xHe4FSn8NAND9AReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895968; c=relaxed/simple;
	bh=3sKRbFLp6qB4L/ink0nv+8qGpu5BXPclWMBqzCa/u0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3gygN1Oy0Z92YPbB8L4dPuRN98uXOK4EGHTYFEej1AA8sXOGbU/s2hGXXI/TGR33bHRL79ddr01HFgIrkovAUVR63kXF6iDX926dR2v0fz1OjPBB8Bk5WO8v2VHy//wW9EhXNIPH+ljmykLVkciRFWKwhjH3vJoPvePAmx6lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwNFmyYS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwNFmyYS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso21559805e9.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758895965; x=1759500765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+2Ewv06o/lr9Do3qc/ffreVp2vNpbBEuBf0+1YbIGU=;
        b=MwNFmyYSnY0hEc58Bkz17j2mgOkZWmPDeofUcf2tFXAkNtHTYJSaHxZIerGsQ46QBe
         iIVbhP67roFKDaISH9A7IN5uR5LFvoxgJ6pDfS7oEY7hlVrAQ374dd0+noXS9n7xOXW4
         Yuy9MvmSGyl9xn8MmzNqS58t6tQ6TujqTQUiWdy0tHpegdD6wVG2aGTWtv363KINqzMH
         Bbw2DQcV8rEqRCrBn+K6yJNxgr2nDUTBorYRB6CcNHlQNGZ2hg5T/lcsGoNjpQqrRGIa
         RvFwRCOQmzSx9LIQ74hnz3XIsl25Z3+j6m2UIvHiV07uh6LAUnfii+cMdqly4rYS1EkO
         PaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895965; x=1759500765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+2Ewv06o/lr9Do3qc/ffreVp2vNpbBEuBf0+1YbIGU=;
        b=Z/dkCvAbwYpd9RLibRPx6WbJ80eNziKNAHzv5qZoRyexuqDXMv8jjkt5u4G92+1AQC
         ULh1BsqgpUYmnXqWcgIkYtN9Z8sc2sLaBR/1LROXQk1m3Q97lMhh05s/U3T27OoIaul0
         r5UaEgTZySPgQv1/FBiQh860fEu5wL/OPTgNh1aYN7NeWtqAokyVz4KkthXZiBerxKmz
         HPtgjv7eOeXIi0dzTNWEPDY/Yal0VPYWPzvV4R1Zbd7DrwGOA8vUy66WeyWFntoIjVYk
         51A3sAoTREP5NHX0fCCZX26wODjveFOSC4edM1P3+UwfEDt6RToWo779Xp3Z//geXG7i
         bmUg==
X-Forwarded-Encrypted: i=1; AJvYcCVtH6wt0Kpb6SxC8OaYbuhqlZiFreUU8QiFSuE6S/UlXYTkHGPb+F1IF6WdzOqAQzmhJB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjkge9IuBNxTNLTCCtM04dAtD05J2QGiLrKEPQI7M13lwO6Mzm
	OcKjksEF8LayKa8dK7XZRIlPGkwHWCAZDpidFbSWMm0rneSXDNoVjCLP
X-Gm-Gg: ASbGncuQ1yYS1jBODeOgaK1EmWipg2E/v6Y8aLkFEDoWDMe/IyBm5LJ7e4R69TwDfTR
	SR8k06XbeaZ7BQbJ4JynJtPJSy29TtBbIUuu6WlZu1LV1x46TlvM1iTYFaMh6GAGdxJdhIvDt0M
	OQg6NvzZuUFmpTdSKkumlZ9uJlV+JHHXrcjVsJTUAWmuzYqX+/X9hIEnPHgMijEuTctPAQvqs6H
	jZdOyFgdHC+b7ZVxzIKXS3iIk3k6qPUAQ70FyS2dkMfPACEdyX93kTQCnmiJsem7ZAqTPJuCUsp
	b973uXLcEsH/Bl1ZIxKxP6rjkxUxfVjO26EboUUpVRV6+tJTfEyRy6TEdJu7Sn/S2Tr9WPmMxIA
	iQLnG88FHt6QJMqba2qIKiCe8AsHJAIgtB9GPOdGshQ6hbHaBpMRShg0gY/W2KwfQkwXIrdIH65
	Ylu9SaOO3ggw==
X-Google-Smtp-Source: AGHT+IFY8sN75sCDI34k9pSfVVY5RxlrqY+2FZfSQUehCv0H+BL4PEAki3JSOZxZJq+3Xb68WBVqyg==
X-Received: by 2002:a5d:588d:0:b0:3e9:d9bd:5043 with SMTP id ffacd0b85a97d-40e3ab8747emr6862485f8f.0.1758895964455;
        Fri, 26 Sep 2025 07:12:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc9247e85sm7645290f8f.60.2025.09.26.07.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:12:44 -0700 (PDT)
Message-ID: <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
Date: Fri, 26 Sep 2025 15:12:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c to
 hook.h
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250925125352.1728840-4-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Adrian

Thanks for working on this, it would be really good to be able to run 
hooks in parallel.

On 25/09/2025 13:53, Adrian Ratiu wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
> 
> By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
> not needing to put together our own 'struct child_process'.

Right so instead we use the new api to feed an strbuf into the hook's 
stdin, sounds reasonable.

> The signal handling that's being removed by this commit now takes
> place in run-command.h:run_processes_parallel(), so it is OK to remove
> them here.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>   sequencer.c | 62 ++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 38 insertions(+), 24 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 9ae40a91b2..93cd6ab1f2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1298,32 +1298,46 @@ int update_head_with_reflog(const struct commit *old_head,
>   	return ret;
>   }
>   
> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct strbuf *to_pipe = hook_cb->options->feed_pipe_ctx;
> +	int ret;
> +
> +	if (!to_pipe || !to_pipe->len)
> +		return 1; /* nothing to feed */

Why are we running the hook if there is nothing to pass to it?

> +	ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len);

This will block until the hook has read all of the input. Unless the 
hook drains and closes stdin before it does anything else it will block 
the parallel execution of other hooks.

> +	if (ret < 0) {
> +		if (errno == EPIPE) {
> +			return 1; /* child closed pipe, nothing more to feed */
> +		}

Style: we don't use braces for single statement bodies.

> +		return ret;
> +	}
> +
> +	/* Reset the input buffer to avoid sending it again */
> +	strbuf_reset(to_pipe);

Shouldn't the return value do that?
> +	return ret;
> +}

The changes to run_rewrite_hook() look fine. I'm not sure whats 
happening in commit_post_rewrite() below though - am I missing something 
or have you just renamed "child" -> "notes_cp". If so I don't see what 
that has to do with using the new api.

Thanks

Phillip

>   void commit_post_rewrite(struct repository *r,
> @@ -5140,16 +5154,16 @@ static int pick_commits(struct repository *r,
>   		flush_rewritten_pending();
>   		if (!stat(rebase_path_rewritten_list(), &st) &&
>   				st.st_size > 0) {
> -			struct child_process child = CHILD_PROCESS_INIT;
> +			struct child_process notes_cp = CHILD_PROCESS_INIT;
>   			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>   
> -			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
> -			child.git_cmd = 1;
> -			strvec_push(&child.args, "notes");
> -			strvec_push(&child.args, "copy");
> -			strvec_push(&child.args, "--for-rewrite=rebase");
> +			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
> +			notes_cp.git_cmd = 1;
> +			strvec_push(&notes_cp.args, "notes");
> +			strvec_push(&notes_cp.args, "copy");
> +			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
>   			/* we don't care if this copying failed */
> -			run_command(&child);
> +			run_command(&notes_cp);
>   
>   			hook_opt.path_to_stdin = rebase_path_rewritten_list();
>   			strvec_push(&hook_opt.args, "rebase");

