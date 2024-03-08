Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19806026D
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935954; cv=none; b=j33AzSedukmSHlO40OxX9sAGRoeLRCb3aCeUiOUO5X7dz9xILcAuKmBnYLlyv+oms23cSrsFXAO4OT7bcbRtytqIAV/SfystNrxa1UjgcLN01/a4bomQwdhJgKVgNOnXKgO/ly3sLgjOPcEelrPScDV0zK768Pxu3vLNTUCzbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935954; c=relaxed/simple;
	bh=DaK8jbWCRKyfbRz1cik/CL+zZG3DU718yd3VXbImrZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1Jck9WAi1lenw0zyJlQERXb7KShSi1GVc59TJlE/QKR9U4F/F/q7FI8aQKqRX98VmLYaJb1AiMLwK4CTiRmrG/OVSDT7uCi9JUmCKR1GIaQ8XMub6ewwXHU4/BL2gIcccvmlhtFoAexVdgQ8MDb7rmkTc+n5ID+J2v7d26ZYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrjE2j3H; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrjE2j3H"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56759dc7ea6so3311615a12.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709935951; x=1710540751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Umft6ZLSRhu4jjs5+4XFqL03OlzZMfIxsf78piwNE=;
        b=NrjE2j3H3s8aASmK0Od+0kyCnEYvcSJYaNk/zGtKxW09vJ1rORAF/SACzq7pV0tuI/
         5Mb+S9UyoWw7Tcwf5JuirlK+RBqu89JJB3viqpIp/LZ/wHr1eX3UdUTxPAt7+FBlCPVj
         7xoSMQwbmyQUjeJn3P806xFa2k5AGHk5b0tUsvR/AY7HMNHHoJjUvjr9OjHSzG8SnKGK
         TANGJpS0fCK69e3caRBT3J7RymWMCkNnYWEa/AOi/V+h8oq4Jt6Hto0mHfQOtKmoN9Ti
         7vsSrq2L78/5vwdTZbCGAstUTSYeeY2zEyG5/XebXVYUYc3Nv4QG3Ch2I2msooBBDRLm
         s1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935951; x=1710540751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8Umft6ZLSRhu4jjs5+4XFqL03OlzZMfIxsf78piwNE=;
        b=TE0XqJK0XCJ9EnlJrrsSuiAr3iWzzfWApbt33LWgmEGqzhk8EfbIPaFBJn9kuUJVPc
         R+ST09wvNS7UVItP2yhiu/H5NBcNVKnalFGlvvuDetCQT3DNWraXoUWKyXmosU86bhg1
         eYNIkL8HQjS+mF2rycWo3C271TKXolxHEovLMpUQAS+cSIGbLSCjOR9dVB+HFIybw4gy
         2ejfSsfQaVcNQll0kHbsfe+DIiCpQj8zGdI+jj+cPBtSb+yxQ+rWDk132I4eRdAhYdY8
         0uc5YxnZNRsz6pfGUV06dCo0fGFu7h1ovrdNA1/s+RrAnhJYdXTZ2Mhwg9DlXbc+NaCn
         hl5A==
X-Gm-Message-State: AOJu0YzQayjpiPB5rrOP/hAZGBew1u4KhvKjurZ8jEsnP/+rXpkQMyIU
	6q2/h5sWseCegf1QJG2Q41Qxw2lGWssq1yVFL2U2T0S3NodjQ1QB
X-Google-Smtp-Source: AGHT+IEEquaPHKBZ/8mgoKib60uaBxJyShOaNxMKX1335k+iX0PDYnzsadlDm6NRnVJjBdLuOgzphA==
X-Received: by 2002:a50:d5d6:0:b0:567:e280:6411 with SMTP id g22-20020a50d5d6000000b00567e2806411mr389652edj.15.1709935951064;
        Fri, 08 Mar 2024 14:12:31 -0800 (PST)
Received: from localhost (94-21-23-218.pool.digikabel.hu. [94.21.23.218])
        by smtp.gmail.com with ESMTPSA id q17-20020a056402033100b00566d6e30f1fsm184546edw.31.2024.03.08.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:12:30 -0800 (PST)
Date: Fri, 8 Mar 2024 23:12:29 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-R=C3=A9my?= Falleri <jr.falleri@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
Message-ID: <20240308221229.GA1908@szeder.dev>
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
 <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>

On Tue, Feb 20, 2024 at 11:08:25AM +0100, Patrick Steinhardt wrote:
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 6a36be1e63..96ae5d5880 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -91,58 +91,67 @@ test_expect_success 'difftool forwards arguments to diff' '
>  	rm for-diff
>  '
>  
> -test_expect_success 'difftool ignores exit code' '
> -	test_config difftool.error.cmd false &&
> -	git difftool -y -t error branch
> -'
> +for opt in '' '--dir-diff'
> +do
> +	test_expect_success "difftool ${opt} ignores exit code" "
> +		test_config difftool.error.cmd false &&
> +		git difftool ${opt} -y -t error branch
> +	"
>  
> -test_expect_success 'difftool forwards exit code with --trust-exit-code' '
> -	test_config difftool.error.cmd false &&
> -	test_must_fail git difftool -y --trust-exit-code -t error branch
> -'
> +	test_expect_success "difftool ${opt} forwards exit code with --trust-exit-code" "
> +		test_config difftool.error.cmd false &&
> +		test_must_fail git difftool ${opt} -y --trust-exit-code -t error branch
> +	"
>  
> -test_expect_success 'difftool forwards exit code with --trust-exit-code for built-ins' '
> -	test_config difftool.vimdiff.path false &&
> -	test_must_fail git difftool -y --trust-exit-code -t vimdiff branch
> -'
> +	test_expect_success "difftool ${opt} forwards exit code with --trust-exit-code for built-ins" "
> +		test_config difftool.vimdiff.path false &&
> +		test_must_fail git difftool ${opt} -y --trust-exit-code -t vimdiff branch
> +	"
>  
> -test_expect_success 'difftool honors difftool.trustExitCode = true' '
> -	test_config difftool.error.cmd false &&
> -	test_config difftool.trustExitCode true &&
> -	test_must_fail git difftool -y -t error branch
> -'
> +	test_expect_success "difftool ${opt} honors difftool.trustExitCode = true" "
> +		test_config difftool.error.cmd false &&
> +		test_config difftool.trustExitCode true &&
> +		test_must_fail git difftool ${opt} -y -t error branch
> +	"
>  
> -test_expect_success 'difftool honors difftool.trustExitCode = false' '
> -	test_config difftool.error.cmd false &&
> -	test_config difftool.trustExitCode false &&
> -	git difftool -y -t error branch
> -'
> +	test_expect_success "difftool ${opt} honors difftool.trustExitCode = false" "
> +		test_config difftool.error.cmd false &&
> +		test_config difftool.trustExitCode false &&
> +		git difftool ${opt} -y -t error branch
> +	"
>  
> -test_expect_success 'difftool ignores exit code with --no-trust-exit-code' '
> -	test_config difftool.error.cmd false &&
> -	test_config difftool.trustExitCode true &&
> -	git difftool -y --no-trust-exit-code -t error branch
> -'
> +	test_expect_success "difftool ${opt} ignores exit code with --no-trust-exit-code" "
> +		test_config difftool.error.cmd false &&
> +		test_config difftool.trustExitCode true &&
> +		git difftool ${opt} -y --no-trust-exit-code -t error branch
> +	"
>  
> -test_expect_success 'difftool stops on error with --trust-exit-code' '
> -	test_when_finished "rm -f for-diff .git/fail-right-file" &&
> -	test_when_finished "git reset -- for-diff" &&
> -	write_script .git/fail-right-file <<-\EOF &&
> -	echo failed
> -	exit 1
> -	EOF
> -	>for-diff &&
> -	git add for-diff &&
> -	test_must_fail git difftool -y --trust-exit-code \
> -		--extcmd .git/fail-right-file branch >actual &&
> -	test_line_count = 1 actual
> -'
> +	test_expect_success "difftool ${opt} stops on error with --trust-exit-code" "
> +		test_when_finished 'rm -f for-diff .git/fail-right-file' &&
> +		test_when_finished 'git reset -- for-diff' &&
> +		write_script .git/fail-right-file <<-\EOF &&
> +		echo failed
> +		exit 1
> +		EOF
> +		>for-diff &&
> +		git add for-diff &&
> +		test_must_fail git difftool ${opt} -y --trust-exit-code \
> +			--extcmd .git/fail-right-file branch >actual &&
> +		test_line_count = 1 actual
> +	"
>  
> -test_expect_success 'difftool honors exit status if command not found' '
> -	test_config difftool.nonexistent.cmd i-dont-exist &&
> -	test_config difftool.trustExitCode false &&
> -	test_must_fail git difftool -y -t nonexistent branch
> -'
> +	test_expect_success "difftool ${opt} honors exit status if command not found" "
> +		test_config difftool.nonexistent.cmd i-dont-exist &&
> +		test_config difftool.trustExitCode false &&
> +		if test "${opt}" = '--dir-diff'

The quoting doesn't quite work here.  When $opt is empty, this results
in:

  expecting success of 7800.14 'difftool  honors exit status if command not found':
                  test_config difftool.nonexistent.cmd i-dont-exist &&
                  test_config difftool.trustExitCode false &&
                  if test  = '--dir-diff'
                  then
                          expected_code=127
                  else
                          expected_code=128
                  fi &&
                  test_expect_code ${expected_code} git difftool  -y -t nonexistent branch
  
  + test_config difftool.nonexistent.cmd i-dont-exist
  + test_config difftool.trustExitCode false
  + test = --dir-diff
  ./t7800-difftool.sh: 14: test: =: unexpected operator


> +		then
> +			expected_code=127
> +		else
> +			expected_code=128
> +		fi &&
> +		test_expect_code \${expected_code} git difftool ${opt} -y -t nonexistent branch
> +	"
> +done
>  
>  test_expect_success 'difftool honors --gui' '
>  	difftool_test_setup &&
> -- 
> 2.44.0-rc1
> 


