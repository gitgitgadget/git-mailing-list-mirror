Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD9C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCUWeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCUWeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 18:34:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593F50988
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:34:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j13so16904388pjd.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679438045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvYSjZGgtjKfRDyOV7ALT2d9QeuLT9jkqY5YSFWxHs0=;
        b=baaNdEH7JHwQ5ryGcqxuCnmJUiLqqYRCc7YS3ufm4mEuJyOtoetmNOwlXqwYYZpllJ
         ZeDXPfHxjO4VPdBfODbhEEHBK/7ghRvxbVyWs7DyWT8OgI2vLFbXP+xRqmeMSRgu8Kt8
         Ldq7xtm6LKPmFn3WtiM1D2VUilKR5XAaGvXCmqQn7beVTEToDYnfQFsuSR9RX/un2KfG
         CuND+iwbOfabeHcxBecTv4ZrsVngRYzuEMko9ZALBSluBTosBMaZiXBS3s6EkxfEOOSL
         VHHitiQb0LaPr+L6z1JWz8+KyWMWQPdCoVLzWhKWLRmvEwYcv/uw0Rxrr5F8nIHwr7K6
         a9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvYSjZGgtjKfRDyOV7ALT2d9QeuLT9jkqY5YSFWxHs0=;
        b=hznhkn7rGXYnnKT+gclPesUzt0BwNYIpQyC+V75WaDpO4FAtKyMeeRI0uIDrCYvGe8
         SSqs/ZYsmjrybAw9xAvZsw7IsfweMlr9U72wESqiBdpmcejnQEGlvQxgE10rQpMPzEkK
         r0rjmnr84rmkebKcaI3OlreqqaMVEPrKnw0rUsb+DIi2utPM382C2gimnXgduY3s+XQ6
         FctEl2mej9X5PRiem886gxZ/OkokGAGr8fcs20571yalsM4oVoAAFc/J4G9Jm5gI2qCI
         IMzlvLZ+CuvAO+AZDNpkljULk6U1e5SNb5k9YAa4radFV1KXSo62eyF3Qd8b5dK8ziYy
         Q6UA==
X-Gm-Message-State: AAQBX9ezpXcdaIUOIOGiUkaW+gveicAAiMt9Fm5HveuFLvf69ogZUGyn
        dlZpTGkOXWnIqOhY+f3nyYAKN9S37NIf1UEpmg==
X-Google-Smtp-Source: AKy350aBN3AB4kXz0QFm0teHTpO89TIVkqiRpEoArLgIfvZcFw1y4yTHl8YaYaChRbeXiqEucuaVmw==
X-Received: by 2002:a17:903:5cc:b0:1a1:97b5:c64f with SMTP id kf12-20020a17090305cc00b001a197b5c64fmr132217plb.11.1679438044919;
        Tue, 21 Mar 2023 15:34:04 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902b68a00b0019edf07eb06sm9224815pls.122.2023.03.21.15.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 15:34:04 -0700 (PDT)
Message-ID: <cea3c428-02e8-a50d-1211-e62f593dc0a1@github.com>
Date:   Tue, 21 Mar 2023 15:34:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v6 2/2] diff-files: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-3-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230320205241.105476-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Originally, diff-files a pathspec that is out-of-cone in a sparse-index
> environment, Git dies with "pathspec '<x>' did not match any files",
> mainly because it does not expand the index so nothing is matched.
> Expand the index when the <pathspec> needs an expanded index, i.e. the
> <pathspec> contains wildcard that may need a full-index or the
> <pathspec> is simply outside of sparse-checkout definition.

...

> +	if (pathspec_needs_expanded_index(the_repository->index, &rev.diffopt.pathspec))
> +		ensure_full_index(the_repository->index);

Looks good! I'm glad you were able to use the tests to confirm that this
pathspec-based expansion was needed.

> +		
>  	result = run_diff_files(&rev, options);
>  	result = diff_result_code(&rev.diffopt, result);
>  cleanup:
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a..82751f2ca3 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -125,5 +125,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git diff-files
> +test_perf_on_all git diff-files $SPARSE_CONE/a
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index c1329e2f16..6cbbc51a16 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2097,4 +2097,35 @@ test_expect_failure 'diff-files with pathspec outside sparse definition' '
>  	test_all_match git diff-files folder1/a
>  '
>  
> +test_expect_success 'diff-files pathspec expands index when necessary' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +	
> +	# pathspec that should expand index
> +	! ensure_not_expanded diff-files "*/a" &&
> +	test_must_be_empty sparse-index-err &&
> +
> +	! ensure_not_expanded diff-files "**a" &&
> +	test_must_be_empty sparse-index-err
> +'

Thanks for adding these, it's a good idea to show when the sparse index *is*
expanded in addition to when it is not. However, checking that the
'sparse-index-err' is empty won't handle silent failures, so it's probably
better to create an 'ensure_expanded' to mirror 'ensure_not_expanded'. The
two functions could share pretty much all of their code except for the last
line ('test_region ...').

> +
> +test_expect_success 'sparse index is not expanded: diff-files' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	ensure_not_expanded diff-files &&
> +	ensure_not_expanded diff-files deep/a &&
> +	ensure_not_expanded diff-files deep/*
> +'
> +
>  test_done

