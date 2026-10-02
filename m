Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038984B1295
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950307; cv=none; b=lrVLct1TCuWGdhKDtkQmv7A6lEr6lJGtGoqZA3DILP2NKkybUOJ6P0RCrfOAzLpuOS6xOfJ3WWPqYcF/AdG5MCdOt5jiVraNLAEKZlfvqlgd1GsbjyHl+F6yQs/T6lVcOZ2a9XQqMWQrLeNjPDCuGrJfx4ZcGiVXO33M+FMelXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950307; c=relaxed/simple;
	bh=N8TXnMEkDwWiBqoOstgssZiKYIRqnosEHov+ln0UwQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLAYpXeBKOiOT17lS+M5dwySQA8Xyo1FKQLpN37RrCiUB/5J0mnpoEZtFTsw/F8S8SltW9SZvCKbDNG/nJYwTPgkz6HO59kN7fw2V/KZ15qHf8baiNOCnduwi9HJ9sq+Kaab5DUfveQZhQvs6yUkmQqePkwrKpEnplAd6yhSEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMFIiQDi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMFIiQDi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so58346585e9.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950301; x=1791555101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zBg9nJ7GGpjF1QDZj8i3eDG9tOqVSRTBdkU6leHkkmg=;
        b=SMFIiQDiuO0hSOkgrxtp6YqYxyohTPA4wwQA24zMDL/BM+O6MJoHI3SOTiYRQJDYDb
         A5SIF+T+DeNSOYWAR/sH1N+lX6cKkEriFs/UCAQiC1deU61WhHrzooEh3tVTqWyJ7P/m
         lncwvSLIuvF0TPOAOq69YSE/aXQrlcvA+vuF87pHWJgCMZEl1WHYkWiem4YshRNAY5e4
         MaD3J61fFHMWZdTTMyCUbCwCEhgCQqCDF7gYDUT69gzoF3E7FnwLGWLw1KH3Wti/moQ9
         lPN8D9ivuzHSqsNGx2Y3vAU/koGjicSbSogyPZkRwrKH+WQe+3FqxLbb52rUnD01wUnK
         hreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950301; x=1791555101;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zBg9nJ7GGpjF1QDZj8i3eDG9tOqVSRTBdkU6leHkkmg=;
        b=o9QW1HYvoDqGymy3viydLh5GZBUDdDF2y2FH6PJz4h8PiFQDzRMWIoF1I3oKj6Qgq3
         0SGYBYpjj07M4kpqif4zK/+P6hEC+7vAGZs9AVD1/2IJ2asOhO9cxIEujIUuwvQPFA+G
         8PuyeU1sTOzaFXbZmhNaTVzWlsuQ6ojRN08cil6uGOW4f95QvsgULkdA/1tqTtrbyuah
         T97im758lUwBj9ItqhKAJzD8qqAlSKDW0Y3BPs3XW4mlzyHnJzf7lh5g2Lm3qXamaHpM
         lpSI8eFoQy+3of/o443+fAaTCoSvNFE77RzJwWwqXeSeqcl4g1xDwV502r2NV6OYNtXc
         jNlg==
X-Forwarded-Encrypted: i=1; AKwUvBzQQk2P323pPG7mrlxlqsD6QFCbY38x/X7Sfo5RrF79gZZdNy7huDno9l7KS/3qX0+kIes=@vger.kernel.org
X-Gm-Message-State: AFuF++lmA3Luw0WGgtzkV+ASkwU1GA6vNiPjftZKt5EPz/2z3SUmR6/B
	pWxSP/B+dOhw1bY4xLoOM9dZZJjc3M+v0vCDuy13/lxCQb1xJQ88MyVG
X-Gm-Gg: AYBFou22oVOBCOBfpHzUuenalOuImwp/ZNJcwCHV3V8NO9UE4pUEMSmMQAJGFqY1ly7
	DKZFx2iNckFsnIaSEW/M8VsuBwU8bKs2LhoKuXEh6spwNJIa5Uam/84VsgCiu1NADhk/x7ClIQ7
	dA6JJorOhj2olKvd+XlbN2y614c37Pe3DT95CWJgYuOInnLowlHJDndyzb+Fl0YoUAd7ds4Vnh9
	xxsoerm3LwB89EMbz/QTcxUyBzyOiOWKLSWaaU0D/pRUo2uAhIPGcODGXWwGv4U+cV2E9Bh8jf4
	yETkeYAfKA+J2EuMGb2iZgBVk+/FL+BzejxnBnR8yVKGTP6iQmV9qlm1emDUvYwxZ13D7kkaaVx
	MaGzEy4tZXO1rWgE1FQfjCNJLYUY8VcOdb3eg7yU647AOcgl7Y+gKbjLd9AfPxiXGNFmaczqnYo
	BFYrw/ty+3htO9lPoFRCoaZqF5WKgnf3xiRRwethnzsIaf6LCRo5RNP+iAa6FrJ3drGFDn6pX+E
	mwuaSwINbPySYKnuqG7sNVBI04bwavdUcTzBbKHZFjd9zvY5/JaVw==
X-Received: by 2002:a05:600c:230b:b0:4a0:2533:c8b7 with SMTP id 5b1f17b1804b1-4a0276c6176mr38680185e9.35.1790950300979;
        Fri, 02 Oct 2026 07:11:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16620dbdfsm7608095e9.0.2026.10.02.07.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 07:11:40 -0700 (PDT)
Message-ID: <33f24834-8e73-4230-bf0a-6809a85d9a86@gmail.com>
Date: Fri, 2 Oct 2026 15:11:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 0/4] var: -z output, multiple variables, and broken-out
 idents
To: Andrew Pleeter <andrewpleeter@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood@dunelm.org.uk, ben.knoble@gmail.com,
 peff@peff.net, sandals@crustytoothpaste.net
References: <xmqq33va1lcg.fsf@gitster.g>
 <20260926162048.30853-1-andrewpleeter@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260926162048.30853-1-andrewpleeter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

On 26/09/2026 17:20, Andrew Pleeter wrote:
> This is a reroll of the single patch in v8, split up as Junio asked
> for, with the changes Phillip asked for on the list.
> 
> v8 was one commit doing four things at once. It is now four patches:
> 
>    1/4 converts the internal representation of a multi-valued variable
>        from a newline-joined string to a string_list, with no change in
>        output. Phillip suggested doing this as its own preparatory step.
> 
>    2/4 adds "-z", which is what forces the switch to parse_options(), so
>        that conversion lives here rather than in 1/4.
> 
>    3/4 teaches "git var" to take more than one variable.
> 
>    4/4 adds GIT_AUTHOR_NAME and friends.

These patches look good to me. I've left a comment on the tests in 
patches 3 and 4, but I'm not sure they are enough to warrant a re-roll.

Thanks for working on this, supporting multiple values and NUL 
termination are really useful improvements.

Phillip

> Changes since v8:
> 
>   * GIT_SIGNING_KEY is dropped. Phillip asked three times how it was
>     meant to be used, and once I looked properly the answer was that the
>     value cannot be interpreted without also reading gpg.format, and that
>     in the default configuration it is a committer ident rather than a
>     key at all. I would rather leave it out than define a variable I
>     cannot describe. Details are in my reply to him on this thread.
> 
>   * Asking for several variables no longer exits non-zero just because
>     one of them has no value; such a variable is left out of the output
>     and the rest are still shown. A non-zero status is now reserved for
>     real errors, such as naming a variable that does not exist, so
>     callers can detect those from the exit code. A single variable still
>     exits 1 when it has no value, as before. This is Phillip's
>     GIT_CONFIG_NOSYSTEM point.
> 
>   * GIT_CONFIG_GLOBAL is documented as a variable that can have more than
>     one value.
> 
>   * The commit messages are prose rather than a list of bullet points,
>     and no longer narrate how the patch was developed.
> 
> The tests use nul_to_q rather than running test_cmp over files
> containing NUL bytes, which Phillip pointed out in v6. Each patch builds
> and passes t0007 on its own.
> 
> One thing I did not do, and would like an opinion on: for a multi-valued
> variable in multi-variable mode, rather than emitting a trailing
> delimiter, each value is shown as its own "VARIABLE=value" entry, which
> matches "git var -l". Phillip suggested the trailing delimiter and I am
> happy to switch.
> 
> Andrew Pleeter (4):
>    var: represent multi-valued variables with a string_list
>    var: add "-z" output mode
>    var: accept more than one variable
>    var: add broken-out identity variables
> 
>   Documentation/git-var.adoc |  68 +++++++++--
>   builtin/var.c              | 242 +++++++++++++++++++++++++++++--------
>   t/t0007-git-var.sh         | 153 +++++++++++++++++++++++
>   3 files changed, 403 insertions(+), 60 deletions(-)
> 

