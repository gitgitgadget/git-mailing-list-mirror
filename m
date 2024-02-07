Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3541758E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303012; cv=none; b=HAIfInMU5sgXt0rNXt7LV4Lf3a3LTvEyVKo6F2WaixTUpYvHOhC1wmTmbJMVre+AWe6lKL7T1Hs7iP43ljq2vSsO8mhb816NOZC0DY11l0tJbhUZ9cm6jp7lecvZ7I+UUkw+02kZ22TrKpqIxQWmiWuYhvfUVjqDMx/bf+DsxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303012; c=relaxed/simple;
	bh=FJD2G+7WRzk/6rCDERoltLXN4/oTaBmFfVv6whjCxGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUYjsrNqagNoBrXVFJ8By6wCIy8oxXUBXRXPjHceY4z7UAc+Noig5S8ki9y3a1Wck+wIcCHAA4MttLmumViHjOvvL2sQtDRtXFe3Gx6f73ZyRb06Y51bDUk1jslHzK5CU/cT5IdILUfHPbJEqtpAPh3LrMuQ3HJq0DAg/2vrdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb2VmlkP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb2VmlkP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fff96d5d7so3879295e9.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 02:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707303009; x=1707907809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wzi4USkURGXEUWErHPo/4NGPTVmFGRjiYK+pumcQSw=;
        b=Bb2VmlkP7MKGsId58ncsLRdO+5hqt9n+2p6JqEIyVSxvHme6W5jtq9GaabsL5DWGkw
         2sCePOFW9vOpDJ05UNgsmrG8QrCQxt7qicjgeAxCXSoH2oPGA3ZG74rSGrbieUHsCYVh
         tFBK+8a4QEHvIEWzbWNVSFONQKgrp/b1LFhWbx7S7tWPkOXn7XGCxEynL2yPEoyyj87k
         4I86OOn+k0E3+z16EC4LpJVVtrezoaHU50uG2DaTSCcHbrgaHJxGRuIwbvoVZTL3qcM2
         pFyVllYUqs66iY8hoLNwkeBvK7j4faipEG0AlVQj37uNjydg70UzILV6MODv+37emSuv
         RPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303009; x=1707907809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wzi4USkURGXEUWErHPo/4NGPTVmFGRjiYK+pumcQSw=;
        b=KcypW5M7CaXOOu9or6/dMKYuukHOQyLu7VV0X3FBQ9yKADi31psYDtjCzQTdM41zzS
         wYPrSlJYL68Q2UTsqv79kLZipr36LjwGVHB3S1ErZdbsFSYTrP5tylhxtX75SI9j5ZuR
         xYcjaIALNmuNhw3VT9wlcln4xAbbodCWQZoHlFaWNamjevRqVeKWibaRLu+xuzIYX4kA
         hokTeiK5BKY5psYHMP7ZdfsIjLfsvn3GJDYJLhyLLEXNFV4kOOSTH//9RsufqokmQZSv
         ZbSUg4cT45uFsoijBCzEH9zkdA4Xah8qhb0Wqcc/jAcFVLHHG7Tr1mSZXmGQZrBcf8We
         4cEA==
X-Forwarded-Encrypted: i=1; AJvYcCU55qRJ3OmfduaDHI/BL6T2mUzkpoi6/wrj1wFX3yUFHBcH+dJOuxK2TbZHDskGLCseZyYNE3WJ+a3OCJ8I8thRugji
X-Gm-Message-State: AOJu0YyMccUlvzbHBXHas+mvv0ZM2WoAQJRFt11lGFtfKuOmwd2k2IQs
	lfo/sif1qDioki6qlgC50IQ9xvbe3xU9vIfNGm1PbNTc2AeAaMQ8
X-Google-Smtp-Source: AGHT+IHlE5p+PJT6cbNPQqHdOfNhKstltyhhuFpeIwbJ5TJXFyt1Y52jcAFZXHqRxYX6+isDZFfQUg==
X-Received: by 2002:a5d:4523:0:b0:337:c4c2:8141 with SMTP id j3-20020a5d4523000000b00337c4c28141mr3230447wra.35.1707303008393;
        Wed, 07 Feb 2024 02:50:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUO9LjNAKTBX8MSCcsi/P8c5AuFmNTPIucoQEIPpnRIbu95n4MOurJTvKjV0HJkxbJU5gWjBo4OHV+9KC7lm52rM5QBWigsL9soX/oW1k=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600010cf00b0033b4e58746asm1140381wrx.69.2024.02.07.02.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:50:08 -0800 (PST)
Message-ID: <8baa44ef-4960-4f0d-8cab-38d3d6ff971a@gmail.com>
Date: Wed, 7 Feb 2024 10:50:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/3] add -p tests: remove Perl prerequisite
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-7-shyamthakkar001@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240206225122.1095766-7-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 06/02/2024 22:50, Ghanshyam Thakkar wrote:
 > The Perl version of the add -i/-p commands has been removed since
 > 20b813d (add: remove "add.interactive.useBuiltin" & Perl "git
 > add--interactive", 2023-02-07)
 >
 > Therefore, Perl prerequisite in t2071-restore-patch and
 > t7105-reset-patch is not necessary.

Thanks for adding this patch. If you do re-roll I've just noticed that 
one of the tests in t7106-reset-unborn-branch.sh and another in 
t2024-checkout-dwim.sh still have PERL prerequisites as well. I don't 
think it is worth re-rolling just for that as we can clean them up 
separately if needed.

Best Wishes

Phillip

> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>   t/t2071-restore-patch.sh | 26 +++++++++++++-------------
>   t/t7105-reset-patch.sh   | 22 +++++++++++-----------
>   2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
> index dbbefc188d..27e85be40a 100755
> --- a/t/t2071-restore-patch.sh
> +++ b/t/t2071-restore-patch.sh
> @@ -4,7 +4,7 @@ test_description='git restore --patch'
>   
>   . ./lib-patch-mode.sh
>   
> -test_expect_success PERL 'setup' '
> +test_expect_success 'setup' '
>   	mkdir dir &&
>   	echo parent >dir/foo &&
>   	echo dummy >bar &&
> @@ -16,28 +16,28 @@ test_expect_success PERL 'setup' '
>   	save_head
>   '
>   
> -test_expect_success PERL 'restore -p without pathspec is fine' '
> +test_expect_success 'restore -p without pathspec is fine' '
>   	echo q >cmd &&
>   	git restore -p <cmd
>   '
>   
>   # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
>   
> -test_expect_success PERL 'saying "n" does nothing' '
> +test_expect_success 'saying "n" does nothing' '
>   	set_and_save_state dir/foo work head &&
>   	test_write_lines n n | git restore -p &&
>   	verify_saved_state bar &&
>   	verify_saved_state dir/foo
>   '
>   
> -test_expect_success PERL 'git restore -p' '
> +test_expect_success 'git restore -p' '
>   	set_and_save_state dir/foo work head &&
>   	test_write_lines n y | git restore -p &&
>   	verify_saved_state bar &&
>   	verify_state dir/foo head head
>   '
>   
> -test_expect_success PERL 'git restore -p with staged changes' '
> +test_expect_success 'git restore -p with staged changes' '
>   	set_state dir/foo work index &&
>   	test_write_lines n y | git restore -p &&
>   	verify_saved_state bar &&
> @@ -56,7 +56,7 @@ do
>   	'
>   done
>   
> -test_expect_success PERL 'git restore -p --source=HEAD^' '
> +test_expect_success 'git restore -p --source=HEAD^' '
>   	set_state dir/foo work index &&
>   	# the third n is to get out in case it mistakenly does not apply
>   	test_write_lines n y n | git restore -p --source=HEAD^ &&
> @@ -64,7 +64,7 @@ test_expect_success PERL 'git restore -p --source=HEAD^' '
>   	verify_state dir/foo parent index
>   '
>   
> -test_expect_success PERL 'git restore -p --source=HEAD^...' '
> +test_expect_success 'git restore -p --source=HEAD^...' '
>   	set_state dir/foo work index &&
>   	# the third n is to get out in case it mistakenly does not apply
>   	test_write_lines n y n | git restore -p --source=HEAD^... &&
> @@ -72,7 +72,7 @@ test_expect_success PERL 'git restore -p --source=HEAD^...' '
>   	verify_state dir/foo parent index
>   '
>   
> -test_expect_success PERL 'git restore -p handles deletion' '
> +test_expect_success 'git restore -p handles deletion' '
>   	set_state dir/foo work index &&
>   	rm dir/foo &&
>   	test_write_lines n y | git restore -p &&
> @@ -85,21 +85,21 @@ test_expect_success PERL 'git restore -p handles deletion' '
>   # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
>   # the failure case (and thus get out of the loop).
>   
> -test_expect_success PERL 'path limiting works: dir' '
> +test_expect_success 'path limiting works: dir' '
>   	set_state dir/foo work head &&
>   	test_write_lines y n | git restore -p dir &&
>   	verify_saved_state bar &&
>   	verify_state dir/foo head head
>   '
>   
> -test_expect_success PERL 'path limiting works: -- dir' '
> +test_expect_success 'path limiting works: -- dir' '
>   	set_state dir/foo work head &&
>   	test_write_lines y n | git restore -p -- dir &&
>   	verify_saved_state bar &&
>   	verify_state dir/foo head head
>   '
>   
> -test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
> +test_expect_success 'path limiting works: HEAD^ -- dir' '
>   	set_state dir/foo work head &&
>   	# the third n is to get out in case it mistakenly does not apply
>   	test_write_lines y n n | git restore -p --source=HEAD^ -- dir &&
> @@ -107,7 +107,7 @@ test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
>   	verify_state dir/foo parent head
>   '
>   
> -test_expect_success PERL 'path limiting works: foo inside dir' '
> +test_expect_success 'path limiting works: foo inside dir' '
>   	set_state dir/foo work head &&
>   	# the third n is to get out in case it mistakenly does not apply
>   	test_write_lines y n n | (cd dir && git restore -p foo) &&
> @@ -115,7 +115,7 @@ test_expect_success PERL 'path limiting works: foo inside dir' '
>   	verify_state dir/foo head head
>   '
>   
> -test_expect_success PERL 'none of this moved HEAD' '
> +test_expect_success 'none of this moved HEAD' '
>   	verify_saved_head
>   '
>   
> diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
> index 7147148138..3691b94d1b 100755
> --- a/t/t7105-reset-patch.sh
> +++ b/t/t7105-reset-patch.sh
> @@ -5,7 +5,7 @@ test_description='git reset --patch'
>   TEST_PASSES_SANITIZE_LEAK=true
>   . ./lib-patch-mode.sh
>   
> -test_expect_success PERL 'setup' '
> +test_expect_success 'setup' '
>   	mkdir dir &&
>   	echo parent > dir/foo &&
>   	echo dummy > bar &&
> @@ -19,14 +19,14 @@ test_expect_success PERL 'setup' '
>   
>   # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
>   
> -test_expect_success PERL 'saying "n" does nothing' '
> +test_expect_success 'saying "n" does nothing' '
>   	set_and_save_state dir/foo work work &&
>   	test_write_lines n n | git reset -p &&
>   	verify_saved_state dir/foo &&
>   	verify_saved_state bar
>   '
>   
> -test_expect_success PERL 'git reset -p' '
> +test_expect_success 'git reset -p' '
>   	test_write_lines n y | git reset -p >output &&
>   	verify_state dir/foo work head &&
>   	verify_saved_state bar &&
> @@ -43,28 +43,28 @@ do
>   	'
>   done
>   
> -test_expect_success PERL 'git reset -p HEAD^' '
> +test_expect_success 'git reset -p HEAD^' '
>   	test_write_lines n y | git reset -p HEAD^ >output &&
>   	verify_state dir/foo work parent &&
>   	verify_saved_state bar &&
>   	test_grep "Apply" output
>   '
>   
> -test_expect_success PERL 'git reset -p HEAD^^{tree}' '
> +test_expect_success 'git reset -p HEAD^^{tree}' '
>   	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
>   	verify_state dir/foo work parent &&
>   	verify_saved_state bar &&
>   	test_grep "Apply" output
>   '
>   
> -test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
> +test_expect_success 'git reset -p HEAD^:dir/foo (blob fails)' '
>   	set_and_save_state dir/foo work work &&
>   	test_must_fail git reset -p HEAD^:dir/foo &&
>   	verify_saved_state dir/foo &&
>   	verify_saved_state bar
>   '
>   
> -test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
> +test_expect_success 'git reset -p aaaaaaaa (unknown fails)' '
>   	set_and_save_state dir/foo work work &&
>   	test_must_fail git reset -p aaaaaaaa &&
>   	verify_saved_state dir/foo &&
> @@ -76,27 +76,27 @@ test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
>   # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
>   # the failure case (and thus get out of the loop).
>   
> -test_expect_success PERL 'git reset -p dir' '
> +test_expect_success 'git reset -p dir' '
>   	set_state dir/foo work work &&
>   	test_write_lines y n | git reset -p dir &&
>   	verify_state dir/foo work head &&
>   	verify_saved_state bar
>   '
>   
> -test_expect_success PERL 'git reset -p -- foo (inside dir)' '
> +test_expect_success 'git reset -p -- foo (inside dir)' '
>   	set_state dir/foo work work &&
>   	test_write_lines y n | (cd dir && git reset -p -- foo) &&
>   	verify_state dir/foo work head &&
>   	verify_saved_state bar
>   '
>   
> -test_expect_success PERL 'git reset -p HEAD^ -- dir' '
> +test_expect_success 'git reset -p HEAD^ -- dir' '
>   	test_write_lines y n | git reset -p HEAD^ -- dir &&
>   	verify_state dir/foo work parent &&
>   	verify_saved_state bar
>   '
>   
> -test_expect_success PERL 'none of this moved HEAD' '
> +test_expect_success 'none of this moved HEAD' '
>   	verify_saved_head
>   '
>   

