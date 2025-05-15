Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F428CF43
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303743; cv=none; b=OiG08lOzMeRTChAd8V1kcIw+d18hhKJtlHXtavIFQ20j/wjNg192Dx/ef97m+lg312Q1F//EHgJggJ6wPePwLcd2aaO9le2D8PP8YzqbUTQfA7NUqmpCLFPPgz9yYWSTkQDRICPpr0zSTaoIL/bqtKdJl3upAyMOFBmFv1HA5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303743; c=relaxed/simple;
	bh=QCnXr5B4fyMBz/pQUQeM1Nkx6xPEllLPnZNMv1DLb1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iq6r78SsIFzayjcFMfLqLmOq8qWc2QY+jLREXcI2mX+ge8ZdsqPXy/HBtD5SvbO41rvZxTZ0SHX4lyFqd1aeJXNV5hq3rHTApvi2oGKJzMjdupM/y3HwZiV/R6H5LPYIVQWyou8s53Lpo7xrC7macid5q/3m0/a/AiaOKthNuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngokxUgs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngokxUgs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so8101205e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747303739; x=1747908539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrUWBRyO/rQvWoH/mvV2+yU5XkDXQE1kahf/gU20A2M=;
        b=ngokxUgsM3LFtjuQO74nvd8rnuiGgpBuSf1KhLxmaAbuYuAxP3u67s7BTIv8wnuQP6
         vZiOqeBXD2VtQDhr/lv9go7yxpPb9FFnNxGE8k9CFgzJDtA6v9uUWeLA/RCvAyHzGDG+
         Fc4HWZyxQIpyGnjqOjKcDs3KwYVwZ9oczBavFr8kzRThBBzVqTyLAqqvVZ7CXT4tnPR1
         Vds/8is9zSK4QoPiErVReR8QjXMeULGvCxX6r3VnWZeJofP1dIl4j+tk2a85MOa6z5VT
         5pwa0t2DR4xHE4C7YmsnMp8KbR+2gD5fzUTk045uzhKEf6CAVqRrRFTWuOEDjOq9mwPv
         iHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747303739; x=1747908539;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrUWBRyO/rQvWoH/mvV2+yU5XkDXQE1kahf/gU20A2M=;
        b=arr8TMbwgGqXmpvPbaEvV8gVb2Rj9/s66Zva7DmfIDaBLRBA1pk7OS/aeXuD5fKAu2
         URMc7ngQUO491v1JYQDsElqU0UyzzF+nXnWm3InmTvyCWVpAmH07o/DTa/tznc2xtzim
         jVzjLSbgIMudetz9irbQbi8C38Wl2GEpbl7/2EjjhgDC6oOkwnsK/ZyUtCMSVlBOvAoC
         HdsBjZPPMpGIDGOz11+ewFTNu3uBGLZ2GSehOMjEqtFA273NIiA/6JkbvblRoDQ5dI5D
         XBdT+70VIpR0W3I1+Gvk3GKOyvrjXSbkv+hnlGFxGTe3KXERI3MESBqUp2+sqktjYgGW
         6WIg==
X-Forwarded-Encrypted: i=1; AJvYcCUjF9Ieadz6vPQUnRfHcWq1QegCayUPMUqb/lmOE5ULnQCRfg1bY4qewM17zjnAG82PuB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMBMwsMZT+kgUYw0YEe+WZBDHBkIZt72cmTLjXLVjbsGwhLRn
	7uxTmJmt2uP7Ihk6IFu6vgmnLlaFg4aKZH0g8QUc1ApAyhBomEAZgEbYEg==
X-Gm-Gg: ASbGncvHVBjNDq+AflJslALJioRVjR9ul/kuvv7pfrcCe2t/yeZW4fyIRsKr2poOH+r
	4bSAEA6Vb/CBB5KSVk0qLyYR/ZpSJO51JciSa6JPqS+cUXV1Xp7O3PoX5/O88MJBocuH80+286u
	5X4gMWaKaaCsJsvAY5RVqIifmSHWhoSgaY+ixc5veCNG6gPI1qSSUgwdzeXUYM/oZuSKyG1gBDN
	oSVhWxySbx2ZuYP3F+inOaIWy/jYmOwXhBH46xNjqwWvvFW+XngyvRUYiEPocRr8ZtWFS+tBOWz
	cmwZxbDn1BJuewlOKjGiVqkuaeeSPSVcx9+/vAqMYndbXAcV8xbU00P430mlc+79U/sNsBSbW9a
	w
X-Google-Smtp-Source: AGHT+IGnjvVPqO1PGvb5iDony9UwWtXxxraYhJnSnTeOhSDwyZ5WJrE6Tfy4RkivAnUAesclwYto7w==
X-Received: by 2002:a05:600c:1910:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-442f2107910mr70573785e9.17.1747303738819;
        Thu, 15 May 2025 03:08:58 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f6f9b309sm41897065e9.30.2025.05.15.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 03:08:58 -0700 (PDT)
Message-ID: <935822b9-33e5-457e-95a7-64058777b52a@gmail.com>
Date: Thu, 15 May 2025 11:08:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: fix memory leak if `update_squash_messages()`
 failed
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 13:44, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In sequencer.c:update_squash_messages, `repo_logmsg_reencode` returns
> either an allocated reencode string or commit buffer if no encode is
> needed. To free `repo_logmsg_reencode` result, `repo_unuse_commit_buffer`
> should be used. However, when encountering the error("unknown command..."),
> the absence of `repo_unuse_commit_buffer` results in a memory leak. I
> think we should add a `repo_unuse_commit_buffer` before return.

Looking at the code, if we reaching that call to error() is a 
programming error as we should only call update_squash_messages() if 
command is TODO_FIXUP or TODO_SQUASH so I think we'd be better to 
replace error(...) with BUG(...) which calls abort() which means we 
don't care if there is a leak or not.

Thanks

Phillip

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>      sequencer: fix memory leak if update_squash_messages() failed
>      
>      In sequencer.c:update_squash_messages, repo_logmsg_reencode returns
>      either an allocated reencode string or commit buffer if no encode is
>      needed. To free repo_logmsg_reencode result, repo_unuse_commit_buffer
>      should be used. However, when encountering the error("unknown
>      command..."), the absence of repo_unuse_commit_buffer results in a
>      memory leak. I think we should add a repo_unuse_commit_buffer before
>      return.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1964%2Fbrandb97%2Ffix-sequencer-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1964/brandb97/fix-sequencer-leak-v1
> Pull-Request: https://github.com/git/git/pull/1964
> 
>   sequencer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757e..f288a303eaa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2138,8 +2138,10 @@ static int update_squash_messages(struct repository *r,
>   		strbuf_addstr(&buf, "\n\n");
>   		strbuf_add_commented_lines(&buf, body, strlen(body),
>   					   comment_line_str);
> -	} else
> +	} else {
> +		repo_unuse_commit_buffer(r, commit, message);
>   		return error(_("unknown command: %d"), command);
> +	}
>   	repo_unuse_commit_buffer(r, commit, message);
>   
>   	if (!res)
> 
> base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75

