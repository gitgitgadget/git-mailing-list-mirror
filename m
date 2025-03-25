Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418B257AF2
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913347; cv=none; b=Klk+3HpiQoYK1nX6fY5VvE77i5CC2xjG8M/SahrMneu2CvbtRLzTbg0CgiloBfZVvAbcQBZXbsLY2z0NrzAvVEciIZEeQgLSxFGeYpTlNhJPZ7gtx5dsuGl5mIn8sEgqD1xiX/S/c0hbAeyfSDaU1i5hmG5rkX1Riy7FpnqYKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913347; c=relaxed/simple;
	bh=rN5GcFoh0M+kuldw7dE1ZACaz1w+7A2Nd1NyX7AIJvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgtp355XDZs6rj1+hH4ZJUTHY/mtk+yhs1NpNdZVdz+CRA9i1wr8nwW1TK3GzDCCeeIKB1jQ1C1xBP+wJAWXu7sJxa4RGvB5LIJ1Agy4JdaDngfab3fGs4jOvjm5cOjL/BnqZrlxIIkDVsShRZj2NJNv9dsL+xTlMX93nVeQmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Llp/7ek1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llp/7ek1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso36585865e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913344; x=1743518144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1JNPUp7xFtm3Q99n4CkxmTmLsFg+ihETVR1GtcURaUQ=;
        b=Llp/7ek1r0DNuaWbksxYdQQPwJhsZeqFyfPeUPszq+LO6kevzHNeqq993aXkATegvb
         DGFd76Jj6ByDkxYKywHYrgtneFKG6utwh6f36vtY+VqKYrOFItwyItKtpLt0uZWwsXM5
         q7z09+t1uTbez5XNGvLo9RosO9sDz2GCwCcMZF+xycol4ib7PWIa4+FgKbUNhB0ea+Zv
         yaeVfZNlpKiUQPg5YnkKpKvUpwOnU0okO8H1hRHGOPlbkGrgXh7RbqBd4jrq8MzOioNt
         dQM+/5iBe1WZPSRvUlaBfqBJUibyItct3kjsIsjsdhKEFc42oxSHbFpjf1NQ2fJtnt13
         OR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913344; x=1743518144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JNPUp7xFtm3Q99n4CkxmTmLsFg+ihETVR1GtcURaUQ=;
        b=h2X3V2mIn16loMsBlGzQNwwSRvDqJCkKUjOQvSIDgEd6XB6jEID08mjTvISRz87mmg
         RKatzwVqIaZAhu3N1xtk8HgSAL+h6bva0N0qWUEch5by71UKsYaFi63+MqJnoKrLz4cK
         97qHzTQvBAwijxGbF1kl8KxKTH9olsV8qgArzgZitucGymdes4MBej6oVHsfXrx9dfJz
         YQlAy5VkBLsudS0Bp9eCCbA0uYvmZShWmJ05SJi5ucQKlGwu8hkvJyaPNxYaPec4Ceyv
         79LjwsoqTrvOQXmQcY5cuHigQPQIPq8j68EChwhG6knQ2l+bz0OokhBlCAJatKOhgGbn
         MOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6d2hXVnlfSsn1UPqQxGxdkSc5gm+FirM0GVgxVe9ypqCkvvz6XVGFwMAqOMhBh+aA/Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTbugkecVJl77uVgAwAS/NIQhQFGkdWxEOkJDJMFaVNRunAWQ
	hsf62tb5yqXiZiebY35RF1i7aRMvZ3M8iZ8AV8jkAWIq4SMVHfNf
X-Gm-Gg: ASbGncs4JBfscaj2akGsMqoF000HJ3Rv0wnjVmlajensl6S74Ad0xjSx0pPT4bRonyn
	LndjA+14qLjSo/k78stztHBvCAZJ7oDcjdb1g8/7+59CdwraPVYrcnxvyacnPHOlNagmo5LuMKI
	mFgox+zanUyssmrJmq9wQVrLoMTSi/lpILotf3d5fT311RztWh9dygbA39vG/WW2/0l57dOMe7P
	54n4P4lipl0rpqGbXI6H8Nwsr5vO6Bk2a3lI8yZEu1cn3Hqa06Vun5E4lFT3w/Rv+jdEE1tpOmA
	CE7cWUGUNNVXaBMXJ7uBVm6QhIM+aBv8W4AqpXPdMj2cJrnQrIi9XOhbYZ6txO6+pxMbYad79nV
	MnemBgu8Erv+tz806xJ0g
X-Google-Smtp-Source: AGHT+IFxpx4drBAxGDLM+3qWrHX94RVor28fcJ76N+hxecINTWi0p5YI5mBCoIVb8QGrQBfvyaEemQ==
X-Received: by 2002:a05:600c:3ba3:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43d6ce18becmr34515255e9.3.1742913343394;
        Tue, 25 Mar 2025 07:35:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556a4sm203125345e9.22.2025.03.25.07.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:35:42 -0700 (PDT)
Message-ID: <69ccc682-3f81-440f-8e96-a5af5d49fa60@gmail.com>
Date: Tue, 25 Mar 2025 14:35:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] clone: suppress unexpected advice message during
 clone
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, alan@norbauer.com
References: <20250321231639.180762-1-jltobler@gmail.com>
 <20250325005148.1771502-1-jltobler@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250325005148.1771502-1-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

The range-diff below looks good to me, Thanks for working on this

Phillip

On 25/03/2025 00:51, Justin Tobler wrote:
> Range-diff against v2:
> 1:  4dae06d2dd = 1:  4dae06d2dd remote: allow `guess_remote_head()` to suppress advice
> 2:  1180caabf1 ! 2:  2a69b881c4 builtin/clone: suppress unexpected default branch advice
>      @@ Commit message
>           Signed-off-by: Justin Tobler <jltobler@gmail.com>
>       
>        ## builtin/clone.c ##
>      +@@ builtin/clone.c: static struct ref *wanted_peer_refs(struct clone_opts *opts,
>      + 		if (head)
>      + 			tail_link_ref(head, &tail);
>      + 		if (option_single_branch)
>      +-			refs = to_free = guess_remote_head(head, refs, 0);
>      ++			refs = to_free =
>      ++				guess_remote_head(head, refs,
>      ++						  REMOTE_GUESS_HEAD_QUIET);
>      + 	} else if (option_single_branch) {
>      + 		local_refs = NULL;
>      + 		tail = &local_refs;
>       @@ builtin/clone.c: int cmd_clone(int argc,
>        	}
>        
>      @@ t/t5607-clone-bundle.sh: test_expect_success 'git bundle v3 rejects unknown capa
>       +	git -C bundle-repo commit --allow-empty -m init &&
>       +	git -C bundle-repo bundle create repo.bundle --all &&
>       +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>      -+		git clone bundle-repo/repo.bundle clone-repo 2>err &&
>      ++		git clone --single-branch bundle-repo/repo.bundle clone-repo 2>err &&
>       +
>       +	test_grep ! "hint: " err
>       +'
> 3:  6fef1d070c = 3:  98b32cdc99 advice: allow disabling default branch name advice
> 
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e

