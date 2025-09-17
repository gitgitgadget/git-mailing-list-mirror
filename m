Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF5332A45
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120827; cv=none; b=d6K4Nci7XtwcK1xay9Hvngmtkw5PNh6zrecdunhebQDj3YkHQQ4n5lJiUw7eA/errRGwnMmLCc6/y4q3YpqX7AAkcDT3gHqSP5xcD4eaHkjPsYRqsPVUKjamTsVJM3uLV7RQIljs6qCnrPsQz3s8DYwHQixYpCc1cTJ7jNigoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120827; c=relaxed/simple;
	bh=G+q/PaWwAViLI/YWHlTAAHdP+ucGdLR2kqvQP57/3Ak=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JYKraLnW1lVisDMT/roMBt8cAJOZ/EccNwFjhT0nvsZWEeZLm1I3wN3hhkIt8unakzRVCj/n7kb3QUHIJI3c/rRGVAuUJQnPs3Lbz7o6ahlIgUyhXZ/k9emAKCHoFf0E4zyz3pzJt2aN1Z2WJ2V8AfOB6sWfoF4whh8oAkLHT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEOjtDZl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEOjtDZl"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so25900855e9.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758120824; x=1758725624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmRKUYLfzeD/i2q0Rd0Yx2X3XTlznnl7mqmjPHCGP28=;
        b=FEOjtDZlrbGIvY5JjrKLrB2xJZ3Bd9585qKkHktzcVO+EU4EA9+VjLLrDBNSHDE25w
         kUVrBkpZ7gkAIfKWEHYCdP8zNVR+6jhj7VDsumOXYM4PggIQ0YzUyVfkq8UVF9IjrU1o
         SZVztLmrNi/FoLt7mMsy7Qwdy7Jay/rQ59H97svtUhw9X1dx4JKmSYko/+vkgQT3tOSd
         aTEu/ciUR40H9xN1WtbTBhriucB2EBC5OpDMbnfMlbHC1qhSEHxAjVo38cu1nsL8d2oG
         MthUg5qX4rODMbx1hB1wmYdAvai7im4Hpud+LhasC9Z00BDh/aYEplhA3/PDV4Hp147g
         E9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120824; x=1758725624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmRKUYLfzeD/i2q0Rd0Yx2X3XTlznnl7mqmjPHCGP28=;
        b=WaP9OYya+UG3mFVv/Ua00FykV+9QyGpL3dZYIg3RmfJ4OU+RdAe5K0m7CvmKzWZpqy
         R13ZArFJ8undCfDMfruyt/0KdXdxjDQr3KwPoaRbli0sv2Za2DrhTexmafOeansyFDa4
         lxpfjZiH5X19fBbaUjmIr10HhjMCxSnU6gozlDklx7A09eINrn++fD1qd+5z40+FFvTf
         q+VmyypbrdCI2OmG9uoTgqbqEInvBTGPxLfTQseQ740fDfW+26Hsa1zhB8kMN4UCYc1y
         mRdC3uNIm34bymJctyYn/Rr8gnEPF4MpYR40LeBrGYJX3/YDo5jnF/sqGhnKznft7kC6
         49NA==
X-Gm-Message-State: AOJu0YzLk6KIOqLiBcI7DYwZMYot9r4YBHFBLi0kgENWeAPlK+TnNbym
	4id5V+XPGb9kC9bOcbsCMtbbvU/Hur1LiZ8PoJ16E9zUmatrUhFWwX8U
X-Gm-Gg: ASbGnctq0iBudxX+i4H2qApf6FaLjqWGxAkZuKIGxiAX7q35t1Tw2m2pmCwTMljCET4
	A/vtcn4yVkdjMXjzeggJzPlJhmL14U7DxwhE/CZ8PDtsya9giUzfmjiPXSrzI0I3HSOf6kTRbhc
	v9ZAPVTVgth118jpmIdQuNRBGGlS/pfPq40Ya18/aGhyYfz2GyNmZZH/Y3mF7Evze3OVDm58eCn
	og8AWIEdYABVvjRFHaNMaP9gAdubA4xOfiQGgAGh6jm5naz2EYxDVP0hVuM47znGmav9WbQwt/A
	mfbiwqdRhizsaZYSKBhuOsVCGswdaw43vNsN0vIP/Eb1q1TVZz1an/TAHfHtVGxHVNje7wUR9hs
	kxBDZjP/10XZgEfXxzsMoeR8G/pPOJz4cysPYWAfo1vYziSowOI7DnIswjWX/SHjT0BN7izH94d
	o=
X-Google-Smtp-Source: AGHT+IESoWpewKQVVxwUOSAYtA/4fXY4Toq+EgnATaYnND5n70idYCoDemE4XXkV+3Mwbvad8e2vQw==
X-Received: by 2002:a05:600c:5295:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-462ae1c2be2mr18700565e9.1.1758120822857;
        Wed, 17 Sep 2025 07:53:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm42154095e9.3.2025.09.17.07.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:53:42 -0700 (PDT)
Message-ID: <70fa7537-3b89-4c3b-9dea-5a7ea0174a9d@gmail.com>
Date: Wed, 17 Sep 2025 15:53:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1757518141.git.phillip.wood@dunelm.org.uk>
 <xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv7lhigb7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/09/2025 10:22, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> We do this without telling them how to permanently configure the
> default name of the initial branch, and that design choice is very
> much deliberate.

That makes sense
> It also needs to be noted thta the advise token to squelch the
> message is the same advice.defaultBranchName as before, which is
> also very much deliberate.  The users who do have that configured
> are those who _have_ been using Git since before 3.0, and they are
> not the target audience for the new advice message.  Reusing the
> same advise token ensures that they do not have to turn the message
> off.

That's good

Thanks for following up on this. The code changes look good modulo
the typo pointed out by Kristoffer. I've left a few thoughts on the
test changes below.

> diff --git c/t/t0000-basic.sh w/t/t0000-basic.sh
> index 2b63e1c86c..54ed80ebd4 100755
> --- c/t/t0000-basic.sh
> +++ w/t/t0000-basic.sh
> @@ -220,7 +220,8 @@ test_expect_success 'subtest: --verbose option' '
>   	test_done
>   	EOF
>   	mv t1234-verbose/err t1234-verbose/err+ &&
> -	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
> +	grep -v -e "^Initialized empty" -e "^hint:" t1234-verbose/err+ \
> +		>t1234-verbose/err &&
>   	check_sub_test_lib_test_err t1234-verbose \
>   		<<-\EOF_OUT 3<<-\EOF_ERR
>   	> ok 1 - passing test
> diff --git c/t/t0001-init.sh w/t/t0001-init.sh
> index df0040b9ac..5fe7b8c674 100755
> --- c/t/t0001-init.sh
> +++ w/t/t0001-init.sh
> @@ -562,9 +562,9 @@ test_expect_success 'init warns about invalid init.defaultObjectFormat' '
>   	test_when_finished "rm -rf repo" &&
>   	test_config_global init.defaultObjectFormat garbage &&
>   
> -	echo "warning: unknown hash algorithm ${SQ}garbage${SQ}" >expect &&
> +	expect="warning: unknown hash algorithm ${SQ}garbage${SQ}" &&
>   	git init repo 2>err &&
> -	test_cmp expect err &&
> +	test_grep "$expect" err &&
>   
>   	git -C repo rev-parse --show-object-format >actual &&
>   	echo $GIT_DEFAULT_HASH >expected &&
> @@ -649,9 +649,9 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
>   	test_when_finished "rm -rf repo" &&
>   	test_config_global init.defaultRefFormat garbage &&
>   
> -	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
> +	expect="warning: unknown ref storage format ${SQ}garbage${SQ}" &&
>   	git init repo 2>err &&
> -	test_cmp expect err &&
> +	test_grep "$expect" err &&

The test changes up to this point strike me as somewhat unfortunate as
these tests are perfectly content with the existing advice. I assume
this stems from us not setting GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
anymore when WITH_BREAKING_CHANGES is enabled. I think we should do
something like

diff --git b/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,13 +127,15 @@ then
  	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
  fi
  
+# Explicitly set the default branch name for testing, to avoid the
+# transitory "git init" warning under --verbose.
  if test -z "$WITH_BREAKING_CHANGES"
  then
-	# Explicitly set the default branch name for testing, to avoid the
-	# transitory "git init" warning under --verbose.
  	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+else
+	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
  fi
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
  
  ################################################################
  # It appears that people try to run tests without building...

To address that which will also stop the advice appearing when the
tests are run with --verbose as well.

>   	git -C repo rev-parse --show-ref-format >actual &&
>   	echo $GIT_DEFAULT_REF_FORMAT >expected &&
> @@ -868,18 +868,18 @@ test_expect_success 'overridden default initial branch name (config)' '
>   	grep nmb actual
>   '
>   
> -test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
> +test_expect_success 'advice on unconfigured init.defaultBranch' '
>   	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
>   		init unconfigured-default-branch-name 2>err &&
>   	test_decode_color <err >decoded &&
>   	test_grep "<YELLOW>hint: " decoded
>   '
>   
> -test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
> +test_expect_success 'advice on unconfigured init.defaultBranch can be disabled' '
>   	test_when_finished "rm -rf no-advice" &&
>   
>   	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> -		git -c advice.defaultBranchName=false init no-advice 2>err &&
> +	git -c advice.defaultBranchName=false init no-advice 2>err &&

The indentation is changed here but not above. I'd be happy to leave
this alone, but if we're going to remove the indentation here shouldn't
we do the same above?


>   	test_grep ! "hint: " err

Do we want to check the advice that is printed now that we have two
different messages?

Thanks

Phillip

