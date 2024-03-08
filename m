Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC05FBA3
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936684; cv=none; b=LpoDr4hnM3Oc/MqKZEjnzZhJFvGvLj7ztHB2iPU1FCkLfLYpOqjHT/Lja7++EDq9AGn0U16QWi/UH54CkQPEPb17j/Tahc8hyiKor84vxolxrQhBr67zNj/oTWl5HdGXsziyM6owAZ+TobnRu2KYRsy4GvmIzj3dbFxIa4IEPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936684; c=relaxed/simple;
	bh=PeyYEvRP/bEJR7/07MtDrXn3XkM+OIjRigF5WAz6kMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRwofZ23WNgEpDt0xksmWAHTc40N25uZIhREFt06gDSENtqKaEf/kJg9Nund1IAgDmgBjyOs/xeibgoN6jYlmbdPo+6ah1438Cgr9UE53adY9Eylfc869Fxvwsv1CTYSfsuaJo+1y0UFus9mRY+YCUIbyP/UVrqG78Oq/SBpIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM4FQcPY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM4FQcPY"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513173e8191so1911137e87.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 14:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709936681; x=1710541481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgLOEwxfYrYwQECddkt7kbBFRVMqwoDifSSs4rZNVuA=;
        b=DM4FQcPY7O7bqSaa9Di2qim86PWvPmZqrNkmdZB/WpXG2Oh1vjO9deMJDG0KnipaXR
         8n/HKKA8lF2j7+mDYgu+9L9Emi1bqX0Oe7ST3SHgMDcHLVJtW9xassZFoeOx+qcB/jCQ
         Oge6qh4rYb0Ip/DgK3R2YJIIDKmneFPx0V9ciiJmjpTIPstmyONV+7dDsEtnn3cSW4VK
         77vCWmjSQTyP9FEVJ44RjYCNdVfdlL5+jX8ZxqIiR03UDfMCSEgB5mYXMbjwSCvmYBx4
         LZ0Gm1ABkFdfjI4WL8Rc3Vuj1xRbFB68pc5Z1gv7lpDQeZq+v1bkm3yXV1wd2UJ7vkUw
         BGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709936681; x=1710541481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgLOEwxfYrYwQECddkt7kbBFRVMqwoDifSSs4rZNVuA=;
        b=G80v732/bmLW81gfUUg0GQCe7HmQLTYE54jnkOpYIKFMl7hPOAg5NCljHcr4jpoKwt
         OKVwJlEi919OONbN14OfbMGq7WqyIFVU2OYOLAbLnLou3MpG19Yg+AMd5faifIUYlFUG
         iWJpe5ZJ3sqrWoJKuA1qrMUIXO7lJ3+O3VGIT8STPy5zesZhaoK3lm9Ja4uIgK/rFUmt
         CPspnLsrm3xKau9IeQ39aZBjBufID+lyC4NbPRuklcQ+hmNiRzQloYI7bMlwhqw1NtTf
         jfWJDb4+lMbqhTXuz4rNtJPYCbckVtrF6UK6N3mB7AUVzDQ98GP0slwfUKcst0/vQo8F
         ovbQ==
X-Gm-Message-State: AOJu0YzUmd4hUj9WPSx/4NaFysVTjDWLRJH0ff9aKc/pA4VTPenSWGKb
	B83jkm4K4Yq/EVYKi3eYqyZUvuO5JkBJO51sTepXGLeRqe6tnvmP
X-Google-Smtp-Source: AGHT+IGz8Ti4zz3ZFpDU9OEXJABCFI7Q9CMRCheu5Ey4R/bFq7WcbOculJQ5SBWqDJ6OMsgYOD6yRg==
X-Received: by 2002:ac2:43cc:0:b0:512:f59f:15d3 with SMTP id u12-20020ac243cc000000b00512f59f15d3mr180014lfl.20.1709936680857;
        Fri, 08 Mar 2024 14:24:40 -0800 (PST)
Received: from localhost (94-21-23-218.pool.digikabel.hu. [94.21.23.218])
        by smtp.gmail.com with ESMTPSA id hq31-20020a1709073f1f00b00a45c09107d6sm226557ejc.29.2024.03.08.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:24:40 -0800 (PST)
Date: Fri, 8 Mar 2024 23:24:39 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
Message-ID: <20240308222439.GB1908@szeder.dev>
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
 <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
 <f29ab9136fb4c23c5700a73731a5e220f92b7c30.1706751483.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f29ab9136fb4c23c5700a73731a5e220f92b7c30.1706751483.git.gitgitgadget@gmail.com>

On Thu, Feb 01, 2024 at 01:38:02AM +0000, John Cai via GitGitGadget wrote:
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 496fffa0f8a..a58f91035d1 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -441,8 +441,7 @@ test_expect_success 'index-pack with --strict' '
>  	)
>  '
>  
> -test_expect_success 'index-pack with --strict downgrading fsck msgs' '
> -	test_when_finished rm -rf strict &&
> +test_expect_success 'setup for --strict and --fsck-objects downgrading fsck msgs' '
>  	git init strict &&
>  	(
>  		cd strict &&
> @@ -457,12 +456,32 @@ test_expect_success 'index-pack with --strict downgrading fsck msgs' '
>  
>  		EOF
>  		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
> -		PACK=$(git pack-objects test <commit_list) &&
> -		test_must_fail git index-pack --strict "test-$PACK.pack" &&
> -		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
> +		git pack-objects test <commit_list >pack-name
>  	)
>  '
>  
> +test_with_bad_commit () {
> +	must_fail_arg="$1" &&
> +	must_pass_arg="$2" &&
> +	(
> +		cd strict &&
> +		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"

There is no such command as 'test_expect_fail', resulting in:

  expecting success of 5300.34 'index-pack with --strict downgrading fsck msgs':
          test_with_bad_commit --strict --strict="missingEmail=ignore"

  + test_with_bad_commit --strict --strict=missingEmail=ignore
  + must_fail_arg=--strict
  + must_pass_arg=--strict=missingEmail=ignore
  + cd strict
  + cat pack-name
  + test_expect_fail git index-pack --strict test-e4e1649155bf444fbd9cd85e376628d6eaf3d3bd.pack
  ./t5300-pack-object.sh: 468: eval: test_expect_fail: not found
  + cat pack-name
  + git index-pack --strict=missingEmail=ignore test-e4e1649155bf444fbd9cd85e376628d6eaf3d3bd.pack
  e4e1649155bf444fbd9cd85e376628d6eaf3d3bd

  ok 34 - index-pack with --strict downgrading fsck msgs

The missing command should fail the test, but it doesn't, because the
&&-chain is broken on this line as well.

