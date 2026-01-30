Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB91EB9E3
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783524; cv=none; b=rKwzKkEvvLbIsEFiDDvfFQfZ2jANqq+89xhxE+e/fc9DDLtFbj5pjoAotVbIejFjdIJm4tUiUbYvlzXWEaI+d7y89oT4IG0P3GjdHXTC/I+/uQJ8pSdLq2Dvt1Fst5vsXMT6Fl5PJ8w8PDVtouT6hqhodr9zCOW4OLC5sB/BQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783524; c=relaxed/simple;
	bh=HEDhoESuHQ+UMlK2DckEVDRGcFsp1D9fMkCNlPGDraA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhJ1ueCzUefxm+afbp7kV4D9YyD2wW8ZLf0QMWeKFjuexEpnaZyCGzcJwQml9jXVfRik3Mk0Ik48elXZyxjph6S/QEvuToEzSYzSv0lzbW5Dvz5nGya+Z9RVJkm+D3fYxpVVdJQTQcLIGC4+wpdceHdt2kLUNm+X30cGewz/SIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtjZIkhs; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtjZIkhs"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so24603555e9.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769783521; x=1770388321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iGAJlD+wZszl3yiKMUaD0ahoXKhg0dhsyKCPdUauK1k=;
        b=HtjZIkhsHLDP2yhmTwR0Y8zhxn9wviCJ0yf+N750seJJBCssQ+iZ7obgzsxOsPp3B3
         anclSBGOfIDMlC7DsjxAtCiNLcWpc2GdLLHSbfCoGPtXIoMggFsFPr6FPe4Rd53FV6zi
         krnv6J/PVFJqp5PUWltO37VLWTI5YKHUJejJ2egCr9rcQKZQLsCgIMl7S5W7ujBwxBWY
         /dRfDiYJQTouFsZY9Xze584pc6b5+VsaFDfWSWchkogqxztIWhrnY26cy3MCJrNe7l11
         lbunr638r1Tp0TQdo64GnWN98OSkDZA9gsDMZc4iur2H3KKMv9HLB15YW79Guh40HDre
         BLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783521; x=1770388321;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGAJlD+wZszl3yiKMUaD0ahoXKhg0dhsyKCPdUauK1k=;
        b=IT6rxDFVxC8uY2d94zC5lUb5EhfsxMdGK/6CY7uX73QTs5GSIwgs4nDdKxRH/8wndn
         DruLE83+4/Y2iDZgSIwKmodVkG60ZzFz/xnHKcJ8TP+uaJuX+4X2Zx7/G59HxJVMbNrf
         OAKYRzcln+pmpVAx3TtZbObX4p4R07w91e2nNQhQr68c8k8W0S/AfhPs2/fE2Hd6fsMv
         AaSqVgM0HZK+3MqDvpswtm98fHcZQD5YG0CfmRaptcv0NirDkfP+gJAanuSLBIAsCBgL
         xHnY7XFJDJHDEOMVlwR5Lcmy32loqdMyy28TOEgN0FB/8jPRa5bJkz01O5m8EoW+LqI+
         lQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEJJ+z1USPKJQuQc54qSFtzvTuUutCIcJ9gDbf8KecCu7csIC59hrWd5CH9dt9HCJCNbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA0neReQoThBjje1rS+CwMEQv4Q8CRqQM/3MfEpLKbadFSm+dL
	7d85/G03eiq+KsgVdTDCYWaL4+mXsUrMKWaSqchI/xB+6KfVc2kYSwU1
X-Gm-Gg: AZuq6aJcDDV//6WU+MKLHnsHyfYYs10DK2nlJwlzYhVC/EcH55SkKof4UnecAUsdBiK
	EHTwYsPMJVb4FNyJ+jbcR8dA09MiQWh3SKHxwz6jTxjQ8Vl8JyhKBButPQGLqu3PswiRwwe1q05
	CiN4sRSNWmCViybQMfBIOwaakqHAjjEI+F1mLTwVhjSilIWgwN4R29n8ushBoAvFP4AIfTa6Gps
	G+CijGjHErqoaczdTsbKRtKcAiajmBjaXm6k6JNk4yo90LAcgbxMEfcSnf/CBLjEIlt6DqspcGm
	3BzA4FOHvCukuUN0m5zl79CsZ7VEAx8rd7oaAJOLpaexv4JOrDo5WHATyvK2zUBMyghCmKsS2rB
	DJrN3Ou21UYtty0EZX0yNNGtI/aMH+17SfLHtMA9896Oe5tM9ht6uG8FYjQayKm3SX4/YBdCI4K
	Cy5y4qjLRnLp3WdCB2ViAF8S8I6IiL8/yq7Pn1na+Q73B+jqujcDlUtWatQW9BECw6ZA==
X-Received: by 2002:a05:600c:3f16:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-482db4592c2mr34834665e9.4.1769783521207;
        Fri, 30 Jan 2026 06:32:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdeafffsm190708715e9.7.2026.01.30.06.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:32:00 -0800 (PST)
Message-ID: <39b421df-a2cc-4ab4-9aa8-b79c5c172d86@gmail.com>
Date: Fri, 30 Jan 2026 14:31:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Johannes Sixt <j6t@kdbg.org>
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <20260128160717.611391-1-a3205153416@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260128160717.611391-1-a3205153416@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/01/2026 16:07, Tian Yuchen wrote:
> The setup phase in 't/perf/p3400-rebase.sh' generates 100 commits to
> simulate a noisy history. It currently uses a shell loop that invokes
> 'git add', 'git commit', 'test_seq', and 'sort' in each iteration.
> This incurs significant overhead due to repeated process spawning.
> 
> Optimize the setup by using 'git fast-import' to generate the commit
> history in a single stream. Additionally, pre-compute the forward and
> reversed file contents to avoid repetitive execution of 'seq' and 'sort'.
> 
> To ensure the test measures rebase performance against a consistent
> object layout (rather than the suboptimal pack/loose objects created
> by the raw import), perform a full repack (`git repack -a -d`) at the
> end of the setup.
> 
> This reduces the setup time significantly while maintaining the validity
> of the subsequent performance tests.
> 
> Performance enhancement:
>            Real         Rebase
>    Before: 29.045s      13.34s
>    After:  22.231s      12.78s

That's a nice speedup in the test setup

> diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
> index e6b0277729..9f4251aed6 100755
> --- a/t/perf/p3400-rebase.sh
> +++ b/t/perf/p3400-rebase.sh
> @@ -9,25 +9,47 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
>   	git checkout -f -B base &&
>   	git checkout -B to-rebase &&
>   	git checkout -B upstream &&
> -	for i in $(test_seq 100)
> -	do
> -		# simulate huge diffs
> -		echo change$i >unrelated-file$i &&
> -		test_seq 1000 >>unrelated-file$i &&
> -		git add unrelated-file$i &&
> -		test_tick &&
> -		git commit -m commit$i unrelated-file$i &&
> -		echo change$i >unrelated-file$i &&
> -		test_seq 1000 | sort -nr >>unrelated-file$i &&
> -		git add unrelated-file$i &&
> -		test_tick &&
> -		git commit -m commit$i-reverse unrelated-file$i ||
> -		return 1
> -	done &&
> +
> +	test_seq 1000 >content_fwd &&
> +	test_seq 1000 | sort -nr >content_rev &&
> +
> +	(
> +		for i in $(test_seq 100)
> +		do
> +			echo "commit refs/heads/upstream" &&
> +			echo "committer WGYDY <author@mock.com> $i +0000" &&

You can keep the same author and committer as the original with

	test_tick &&
	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" &&
	echo "committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 
$GIT_COMMITTER_DATE" &&

here and below

> +			echo "data <<EOF" &&
> +			echo "commit$i" &&
> +			echo "EOF" &&
> +			
> +			if test "$i" = 1; then
> +				echo "from refs/heads/upstream^0"
> +			fi &&
> +
> +			echo "M 100644 inline unrelated-file$i" &&
> +			echo "data <<EOF" &&
> +			echo "change$i" &&
> +			cat content_fwd &&
> +			echo "EOF" &&
> +
> +			echo "commit refs/heads/upstream" &&
> +			echo "committer WGYDY <author@mock.com> $i +0000" &&
> +			echo "data <<EOF" &&
> +			echo "commit$i-reversed" &&

The commit message in the original is "commit$i-reverse", not "reversed"

> +			echo "EOF" &&
> +			echo "M 100644 inline unrelated-file$i" &&
> +			echo "data <<EOF" &&
> +			echo "change$i" &&
> +			cat content_rev &&
> +			echo "EOF" || return 1
> +		done

As Johannes pointed out we'll ignore the any failure above. We can 
address that by adding "echo done" here and adding "--done" to "git 
fast-import" below. That will cause "git fast-import" to fail because if 
there is an error in the loop as the last line of input to fast-import 
will not be "done"

Thanks

Phillip

> +	) | git fast-import &&
> +
> +	git repack -a -d &&
> +	git checkout -f upstream &&
>   	git checkout to-rebase &&
>   	test_commit our-patch interesting-file
>   '
> -
>   test_perf 'rebase on top of a lot of unrelated changes' '
>   	git rebase --onto upstream HEAD^ &&
>   	git rebase --onto base HEAD^

