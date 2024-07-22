Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64D16DC1F
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661009; cv=none; b=dqBTriZz4lW0vFNpc3aaoO9YH3tSEoejYwKVtqaPmx2Ap+zmB7thtplMD5nss83oIW9E6cVWIJZ9OCov9RMblmszediqzWe5YU0xIKcGbnw3OokyCgU6nQRKb2PdsTxb8OY+skwgoy8exWyVuS3mPBtVgmnMWEMSn1yYgF+/dIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661009; c=relaxed/simple;
	bh=ryuw1DNHqWQ0GEsRQj7zVKEAH9YeEAMzFHBNZ75Y/IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSYBubSzCOPWuvWaA7zRw/XATn0vj9E6E08hZNt2X/E0LlMGmLONgnYeyhGMDIvDeuhVOqq/63odGE5GguxrKu591RmhOb2TbSjkKcBiD8x8CYpTPOC0kcDY/MBpq/N4TcwgP9Bl9t0uGnsphoeE9nQDV6SLb8FrIHlHJeuMlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXYs9ugw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXYs9ugw"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so714360566b.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721661006; x=1722265806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdpXqgWuTIKNO/gz3x4nHooel647mbvWBUyH7VNQFfA=;
        b=XXYs9ugwvbEMcDUmsr4+Jw094xrEej7LerT2k8wPBpD+3TXABveqplhk9Pk2qdvvQq
         NWeDdnFB9xqEdVapWcyjrWQArJ8Knoq1uqod334cIoYMHwKe6FJ//fCLEimCCgGn/IjN
         F5Hclkb9sJDrVauENC9f7BtJmafFy80oZqmdfQrxY1UKwj4jHtOUjdtdm1QsNtub6rIW
         MWqOF5qQoddOQlqHppbqPCxRj+kudcT+dFxeH+6ulY0YponCaOmjUXM+tZH50JTdPTD/
         JeyhK7Aw1GX3TBZVaHEkkHjZYcSjynMY89/mQ1t9AjqI9gJB5xaKk3EPXMfWmvNtJI7a
         hc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661006; x=1722265806;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdpXqgWuTIKNO/gz3x4nHooel647mbvWBUyH7VNQFfA=;
        b=Wq5eI0GTxE+mr7oUitim/ZOJNLavOYmdeBTGuSx11FexHlnXoNDYk7b8Y4qf+Q4ePm
         fd/0dVbljxjd9sQg+aywf76/UHemdwSb8sdl3i1ug1Z3ncxjLQpiQ8v3vy6Ro61UflRV
         ny4/L2VNkP9Jd+QsV6RP0UXIItQqachug+S6uI3kbqJvxgW3jeE+c5QKI1OgoNO7+bF/
         sd6w6Viy/cbNvLVqoCLApq30UFdXu7Wzc0xN5EPBr8Te4CLN4h61z9nq3o33ZJlyoXV+
         D3BY4u0xLwHI/GmDX0lfNsN/QPJvb/hnosmfkJSFa0r77qFLHy5C/jLUWakmYpbV6fQf
         y4mg==
X-Forwarded-Encrypted: i=1; AJvYcCXUftEyxZB7IsyaHhxiITqZMi2/Xqj7gVVs6I+gARyPRsyhuAtlFIGoCSJHhazz1S9C/JC2WL1UQf39qWHhV0mPtoTl
X-Gm-Message-State: AOJu0YxNrrYALGCiTorZ/ycZ/1deJiNjhnNAlaGxjGU+HGkSSbdAMlMb
	BmNcnaLPl//Rmo+JtXi0B9puqhCcdkea2dKf8n7pu3qkUyZPUqre
X-Google-Smtp-Source: AGHT+IElBU5AuugAjqRUlboeVymTsb331+OsjUTnl1GkJ+LLHtpA6APDHO5DgYAlBdELOv/5eb9r6A==
X-Received: by 2002:a17:907:3da8:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a7a4196509dmr839063166b.0.1721661005512;
        Mon, 22 Jul 2024 08:10:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8be70csm432750266b.125.2024.07.22.08.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 08:10:05 -0700 (PDT)
Message-ID: <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
Date: Mon, 22 Jul 2024 16:09:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func"
 invocation
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-2-ericsunshine@charter.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240722065915.80760-2-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric

On 22/07/2024 07:59, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> Unlike "VAR=val cmd" one-shot environment variable assignments which
> exist only for the invocation of 'cmd', those assigned by "VAR=val
> shell-func" exist within the running shell and continue to do so until
> the process exits (or are explicitly unset).

I'm not sure I follow. If I run

sh -c 'f() {
     echo "f: HELLO=$HELLO"
     env | grep HELLO
}
HELLO=x f; echo "HELLO=$HELLO"'

Then I see

f: HELLO=x
HELLO=x
HELLO=

which seems to contradict the commit message as $HELLO is unset when the 
function returns. I see the same result if I replace "sh" (which is bash 
on my system) with an explicit "bash", "dash" or "zsh".

I'm also confused as to why this caused a problem for Rubén's test as 
$HELLO is set in the environment so I'm don't understand why git wasn't 
picking up the right pager.

> check-non-portable-shell.pl
> warns when it detects such usage since, more often than not, the author
> who writes such an invocation is unaware of the undesirable behavior.
> 
> A common way to work around the problem is to wrap a subshell around the
> variable assignments and function call, thus ensuring that the
> assignments are short-lived. However, these days, a more ergonomic
> approach is to employ test_env() which is tailor-made for this specific
> use-case.

Oh, that sounds useful, I didn't know it existed.

Best Wishes

Phillip

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>   t/t3430-rebase-merges.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 36ca126bcd..e851ede4f9 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -392,8 +392,8 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
>   
>   test_expect_success 'root commits' '
>   	git checkout --orphan unrelated &&
> -	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
> -	 test_commit second-root) &&
> +	test_env GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
> +		test_commit second-root &&
>   	test_commit third-root &&
>   	cat >script-from-scratch <<-\EOF &&
>   	pick third-root
