Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E513C81B
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808743; cv=none; b=eAAg0iUiQ/Hfe8Dm2BD2BrralGX7Vg8LTvLpXJXuYIJOs4ARZ/xvHzIy49tTwfTSjqH0EjzRX8p6G2bMPkSDi67Rvh3vPld1E8N1/QYRQpFXVXsYCL3x1xb+v5X6UyDoAMdFGg8MfoiZk6D+y0wHxY8+wPDy2agG/iCHSI1Ue0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808743; c=relaxed/simple;
	bh=fLGqLRzgZ9vh4JWEAYV/wjNpZbTI6KIdQHzzSc+pom8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZy4teoV5H94PjNIqMqU9Ro6k+J+R6++6sZu3yeYncGsyG1Bk0Sl148aYQDnH15wGXkYyyZAd5dYgLFLuMyYw0lssgo3be8VLgkZu6HHLqRmyupZ2Agh8NPMH0prDs1zMmvikMDtXNxmYseiuGJ1mv2KEHRDMuPUL3fpNzythxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq3SAhKJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq3SAhKJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39143200ddaso2359122f8f.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808739; x=1743413539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUO9VY5jKJWhaoM3wzfdzT19iA4coJu6vs/etDToPY8=;
        b=eq3SAhKJjEsAXFxDSBTJSFBBv87WbVQ45Zi6lB0vZ8DIeBjZDNaoDkVblRLcDkVXNp
         jf6apcHA/3SYUgHnfPNX8tneIQvxrOahEVamW4WRrTjXHPPVKTA+wZsj3Yzt0JVl2G0O
         t5kWnA979eIOFMO4MKHUoQPcf5ubkH+/7tbKGJkqAXIEpRAtwtG5OEJeXNhph0B5zuV0
         AdAQ6TwMVR2UnOj4fMBY7B6M9kQ+UFTnXHBXex5mAOpA4n7QeAHkYkU2KCe49aRNBwEn
         zXllNHB0Fp/qzPi4eiq7IAMcUT5fashAE/mii1T5E/YDTqGAHecWu33/CYL+CmhKziVV
         G6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808739; x=1743413539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUO9VY5jKJWhaoM3wzfdzT19iA4coJu6vs/etDToPY8=;
        b=Pfi2ei7j8ZCoZj1ttmmwFxl64qeXIkT8OQTCisUADWBBgI+ALmToIoHoQDerDW/5FM
         S+hht/khJkuhYcCNyiVtnAmmnzsfqf6wSqdnum8xhyXe3w08Cc1XR5eKx0/CO5rY38cV
         OIE0BPLlHd+ZEh1xDXlYwtHzmub2d6mQ0Um8xA5pTcN6/2sPWBBwTR6N2VMkC1qFG+yU
         zqrOAIz7pBLDWcTgOnh+99ig2tJRipT719+opNFFDKEGvyoM8Vru65ImrP4mLXScZ/JF
         jQC0/ExsBAdZpoYaMdlagBBT85dKxfakJrFzvg/xcq7Y55IuP2x5sINEPqxg9uHGQ37I
         1SZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+cPE64dbb4fsigBw7YpdHYvfeK8flo/seu59CpfvYakmVB+1X3pAK2u/vX1djmPZgpRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZxQCxCm16lhxoYhTPe6KB2xOYzEaoXCLGj4WB4G6sy1y2CCg
	ZXDJrYd/xBUDtxvpJ3l1KALXzoxhdvS5Fj7/0Tv3XaIH/zamk50LNUI2Lw==
X-Gm-Gg: ASbGncsIW3rSdHRsCcwwnvID1Zwd7ESCQuK8hn/HdQeOgCrFtnBL9M+BQ76JGx/SVJp
	MMn4s8GHj0BxpaPxAzg6inzBBQqyJQYpCZUyL5SC+s0IPBX3ILSNVe+kCy/IPVsLvGj/te3kqBj
	mF/YKcZthAF3zf3EbmsXH0do98bgwR5XupjmfZmI5cO6zD+dPOsNIocfElqvnQZj16dcDEMaIov
	bghbzImDUHtJQsjTSRYgvlsq0pkLikL0dVSXappgUr/fi/0AGwDk2HkN18G651pDN2TuNB7IvOe
	FSAbQcIj8d0REMvc3RmAJxYbIW3fIKRhAFGgcaNmbiojcGO4O8ELfb4xE4G6IKx4GqDZkicBquF
	c/bpQOOuvQ6YjCJcC0fsx
X-Google-Smtp-Source: AGHT+IE+BTllXvoYzTRR6YDXF+pQt7PFWbfI3FAg5WVfJj2PFVrGNcLuRNmx3oHLDL7RGjiafes5GA==
X-Received: by 2002:a05:6000:2d05:b0:391:47d8:de3a with SMTP id ffacd0b85a97d-3997f93c504mr7901318f8f.53.1742808739242;
        Mon, 24 Mar 2025 02:32:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd17cfesm114920275e9.10.2025.03.24.02.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 02:32:18 -0700 (PDT)
Message-ID: <966aa1cc-fd4a-42b7-a241-0537767021ed@gmail.com>
Date: Mon, 24 Mar 2025 09:32:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin/clone: suppress unexpected default branch
 advice
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, alan@norbauer.com
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
 <20250321231639.180762-3-jltobler@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250321231639.180762-3-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 21/03/2025 23:16, Justin Tobler wrote:
> In 199f44cb2ead (builtin/clone: allow remote helpers to detect repo,
> 2024-02-27), clones started partially initializing the refdb before
> executing the remote helpers by creating a HEAD file and "refs/"
> directory. This has resulted in some scenarios where git-clone(1) now
> prints the default branch name advice message where it previously did
> not.
> 
> A side-effect of the HEAD file already existing, is that computation of
> the default branch name is handled later in execution. This matters
> because prior to 97abaab5f6 (refs: drop `git_default_branch_name()`,
> 2024-05-17), the default branch value would be computed during its first
> execution and cached. Subsequent invocations would simply return the
> cached value. Since the next `git_default_branch_name()` call site,
> which is invoked through `guess_remote_head()`, is not configured to
> suppress the advice message, computing the default branch name results
> in the advice message being printed.
> 
> Configure `guess_remote_head()` to suppress the advice message,
> restoring the previous behavior.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>   builtin/clone.c         |  3 ++-
>   t/t5607-clone-bundle.sh | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f14229abf4..a4008715ec 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1523,7 +1523,8 @@ int cmd_clone(int argc,
>   	}
>   
>   	remote_head = find_ref_by_name(refs, "HEAD");
> -	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
> +	remote_head_points_at = guess_remote_head(remote_head, mapped_refs,
> +						  REMOTE_GUESS_HEAD_QUIET);

There is another caller of guess_remote_head() in wanted_peer_refs() 
which I think we probably want to be quiet as well. I don't see how it 
is helpful to the user to prompt them about setting the default branch 
name used when creating local repositories during a clone of a remote 
repository.

Best Wishes

Phillip

>   
>   	if (option_branch) {
>   		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 82e3621ec5..f526bb1c69 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -211,4 +211,16 @@ test_expect_success 'git bundle v3 rejects unknown capabilities' '
>   	test_grep "unknown capability .unknown=silly." output
>   '
>   
> +test_expect_success 'cloning bundle suppresses default branch name advice' '
> +	test_when_finished "rm -rf bundle-repo clone-repo" &&
> +
> +	git init bundle-repo &&
> +	git -C bundle-repo commit --allow-empty -m init &&
> +	git -C bundle-repo bundle create repo.bundle --all &&
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +		git clone bundle-repo/repo.bundle clone-repo 2>err &&
> +
> +	test_grep ! "hint: " err
> +'
> +
>   test_done

