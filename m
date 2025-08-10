Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD51FF1A0
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754855072; cv=none; b=bTfJSPd7A8w8FPWqQtKAzb4KY7qdambyMCB2Ph6DLZQ5jpyup/BWn+nr6ScvYoz4DeMqI061W95exszjG8NnlJ2cKBzscZdkZE3aVxpRWSkXh6UDw2w3eeDbu7Q3FuNtl4CYm8qa1q8T7oL+psZL9bad8qEMeUt1KikXE3jcXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754855072; c=relaxed/simple;
	bh=4jgtWT5dpmpxsFrqR+mR1Mebri9VTQ5mRwxihPpld90=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhY5EWg5/zj4LZOhaAq6buCn22GrEp0V4UjJU/CCl+mb9CtfpUOSqPFZ40eSHAvZHVmrboVw4NgO5jQfM7G0fEBEuwu+CO0ENSdPuDcG5vlOCbvYsa2q/jgvNrfgrtj+W02X8oaxtteY2h9H/oWZ5D1zug8C09iH9EE7ISNwQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ3P1nn7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ3P1nn7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458c063baeaso20679015e9.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754855068; x=1755459868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYJTEaafRWzWa1/XqJqBIRpjG9kdulAB9pp84fkTGUs=;
        b=kJ3P1nn7PvomHu6zuCBs8Raz93CV8bQWYoot2TdhwZc8DufbRh8xeB1nNmDR9tuEcL
         7Rtnxlyyrl4QHaislMy3EiLJim7lodl2/GOcLjZ7IWT1PSIbLfN+nAOD1ihJoAZxsDgk
         BM4RErWXM5ghrnXKPIDAc7GpTSdpJLiT0mtOGpT3oKh2AfZMdMPL52p5S5T+wq5yZ1/0
         Y2O1R5puks1aBHX3xA2y3fb6iKpcq1scJDYBlH9DZ0GY3I297zWvknWVSs3btKQjtz52
         22KF/3R+wZzglso5yHaxgwSXuNlQE5nMdlxDm2DEDYX0K0esI8vzUIARATrr9yWwCLyB
         Q65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754855068; x=1755459868;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYJTEaafRWzWa1/XqJqBIRpjG9kdulAB9pp84fkTGUs=;
        b=RYg5FGK62sSIoBsG6E7QObJFnOssmubDB/7ohuE+ErgnotFZE+ULfjEh4E31HYs6+C
         PBRiEOJqi+D7kE9HaH15GatTOFbkzh4EUBoWHQonvdhNnJQMU+XT68VTj6XVsWKdW7b0
         atcCJGzL3dCX7heHNvwQhSZeSXKJzdoCt7yL31dUeqjRUtTh2UMzsIDercLvpZFli91c
         FDp85HzNCc6673iy9AeYUB4SxR4HYNw7WgmJWChRdjLaVXvoMPdJR8ou8VMMtWwQlr4g
         vp35f00XEM+eB+1D+cyLmI1HR7m3heQ4B9fltkY0uK+zQ8aVsYkCPwBlAXHpiRwQfwEj
         7OMw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ehamaVHeQfg2k9ovMGMxiQOE24Ex9wm4YUFbWxJ2W2D2KuNW9fDkuGTIpUA/+PqndBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDmGtvOS02BqAb5qbl954kHQ9aCxaeFKI7xWufVbSj4HirC/2
	KoANwZrD/f8AJcucLO9iqrYT7nCipscZwVvhraqN+bcXgBbVqm7L+M7VT9HQ6A==
X-Gm-Gg: ASbGnctMg83Q6p1PxJVspGkEhD5ViY9Jn5IYZf3ZKsEXCVK480hKrqF/36Jz/3phv9V
	p8pqHA/FwWv+dbHrVVS2KXJ33utKw9tt24mrhmEyGkodDktBB4l16OxxSIeTDO3iLBkpgVtN14s
	GG9mxVsbiI8tkEmwlga9/u8HcseJp6bGO9/uynf29UjbpPk/HD/E26E4lNGBtIbaLGMjBpUVla5
	gKwordq9SLMc7bVGTT1rG/vd29TZ+zLA5wbQsRUS9pBCfQpXQxGJzBoi4ckpUeO1HtOQ1dgsktg
	IfnGlHnGDiQVorNkT2VciGZy/k50IPjYeCTPf8G9HTOuSJ6RVkx4La6mzqyn4tNDYmb8HE1dbel
	FdBXKv6NqIwynwxfUkWt8KnD03fwbdx5P95K9tJ4vsIAJ8uhPlakYgK4Lu/ciMQxZWPUiguXVDL
	bv
X-Google-Smtp-Source: AGHT+IHtMidNccNX02YyVoRUsjVpqkayKDHWYlc3SHTtmO0bOqHb1xcm5N9NZ1ge3cdA3OvJ9NHMiQ==
X-Received: by 2002:a05:600c:5254:b0:456:13d8:d141 with SMTP id 5b1f17b1804b1-459f4f282damr81128745e9.27.1754855068377;
        Sun, 10 Aug 2025 12:44:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm37004738f8f.30.2025.08.10.12.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 12:44:27 -0700 (PDT)
Message-ID: <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com>
Date: Sun, 10 Aug 2025 20:44:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] t7005: sanitize test environment for subsequent tests
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250810160323.49372-3-ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <20250810160323.49372-3-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 10/08/2025 17:03, D. Ben Knoble wrote:
>   
> -TERM=dumb
> -export TERM
>   test_expect_success 'dumb should error out when falling back on vi' '
> -	if git commit --amend
> -	then
> -		echo "Oops?"
> -		false
> -	else
> -		: happy
> -	fi
> +	(
> +		TERM=dumb &&
> +		export TERM &&
> +		if git commit --amend
> +		then
> +			echo "Oops?"
> +			false
> +		else
> +			: happy
> +		fi
> +	)
>   '
>   
>   test_expect_success 'dumb should prefer EDITOR to VISUAL' '
> -	EDITOR=./e-EDITOR.sh &&
> -	VISUAL=./e-VISUAL.sh &&
> -	export EDITOR VISUAL &&
> -	git commit --amend &&
> -	echo "Edited by EDITOR" >expect &&
> -	git show -s --format=%s >actual &&
> +	(
> +		TERM=dumb &&
> +		export TERM &&

We may as well export this with EDITOR and VISUAL

> +		EDITOR=./e-EDITOR.sh &&
> +		VISUAL=./e-VISUAL.sh &&
> +		export EDITOR VISUAL &&
> +		git commit --amend &&
> +		echo "Edited by EDITOR" >expect &&
> +		git show -s --format=%s >actual
> +	) &&
>   	test_cmp expect actual
>   '
>   
> -TERM=vt100
> -export TERM
> -for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
> -do
> -	echo "Edited by $i" >expect
> -	unset EDITOR VISUAL GIT_EDITOR
> -	git config --unset-all core.editor
> -	case "$i" in
> -	core_editor)
> -		git config core.editor ./e-core_editor.sh
> -		;;
> -	[A-Z]*)
> -		eval "$i=./e-$i.sh"
> -		export $i
> -		;;
> -	esac
> -	test_expect_success "Using $i" '
> -		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline >show &&
> -		<show sed -e "s/^[0-9a-f]* //" >actual &&
> -		test_cmp expect actual
> -	'
> -done
> +test_expect_success 'Using individual editors' '
> +	test_when_finished "test_unconfig --unset-all core.editor" &&
> +	(
> +		TERM=vt100 &&
> +		export TERM &&
> +		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
> +		do
> +			sane_unset EDITOR VISUAL GIT_EDITOR &&
> +			test_might_fail git config --unset-all core.editor &&
> +			echo "Edited by $i" >expect &&
> +			case "$i" in
> +			core_editor)
> +				git config core.editor ./e-core_editor.sh
> +				;;
> +			[A-Z]*)
> +				eval "$i=./e-$i.sh" &&
> +				export $i
> +				;;
> +			esac &&
> +			git --exec-path=. commit --amend &&

It would be nice to stop abusing --exec-path here and in the next test 
by adding the current directory to $PATH with

	PATH="$(pwd):$PATH" git commit --amend

> +			git show -s --pretty=oneline >show &&
> +			<show sed -e "s/^[0-9a-f]* //" >actual &&
> +			test_cmp expect actual

We need to add "|| return 1" to the last line here and in the test below 
to reliably error out when test_cmp fails. I'd have thought that our 
test linting should hove picked this up but maybe it is confused by the 
subshell.

Thanks

Phillip
> +		done
> +	)
> +'
>   
> -unset EDITOR VISUAL GIT_EDITOR
> -git config --unset-all core.editor
> -for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
> -do
> -	echo "Edited by $i" >expect
> -	case "$i" in
> -	core_editor)
> -		git config core.editor ./e-core_editor.sh
> -		;;
> -	[A-Z]*)
> -		eval "$i=./e-$i.sh"
> -		export $i
> -		;;
> -	esac
> -	test_expect_success "Using $i (override)" '
> -		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline >show &&
> -		<show sed -e "s/^[0-9a-f]* //" >actual &&
> -		test_cmp expect actual
> -	'
> -done
> +test_expect_success 'Using editors with overrides' '
> +	(
> +		TERM=vt100 &&
> +		export TERM &&
> +		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
> +		do
> +			echo "Edited by $i" >expect &&
> +			case "$i" in
> +			core_editor)
> +				git config core.editor ./e-core_editor.sh
> +				;;
> +			[A-Z]*)
> +				eval "$i=./e-$i.sh" &&
> +				export $i
> +				;;
> +			esac &&
> +			git --exec-path=. commit --amend &&
> +			git show -s --pretty=oneline >show &&
> +			<show sed -e "s/^[0-9a-f]* //" >actual &&
> +			test_cmp expect actual
> +		done
> +	)
> +'
>   
>   test_expect_success 'editor with a space' '
>   	echo "echo space >\"\$1\"" >"e space.sh" &&
> @@ -115,9 +126,8 @@
>   	test_cmp expect actual
>   '
>   
> -unset GIT_EDITOR
>   test_expect_success 'core.editor with a space' '
> -	git config core.editor \"./e\ space.sh\" &&
> +	test_config core.editor \"./e\ space.sh\" &&
>   	git commit --amend &&
>   	echo space >expect &&
>   	git show -s --pretty=tformat:%s >actual &&

