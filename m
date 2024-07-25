Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CD198A2B
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900741; cv=none; b=QRrrgIdWe3Tv35zz3woiljQglc8vAf1ip4SVsf/bwUHzm8VbRHs8GtUz3BZJspnMavNp05Jfkg1/gQ4aGYU6d4hM7AJ6Av3RefEy3BBOb7Yu8/Z7BNoiZ0OQ23ttRJ5J/UmdhxQhhexGO0BHeCN5rRUfofkwjolUz0nkiG9py4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900741; c=relaxed/simple;
	bh=GRbB3T8EEWR4/FZKFtt/Eb1z0rgE4YeyAFzHnEJRYRY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=SqYjDBq43NqCWC40qp2+IeU8SHBSdG+xk/HdN1aW9vC8rbrbNZrmnIo4VGecg2udXzASIXPXqvY8WxA505pqER0ecj10J69IgBeSUJUrG6OaOcTXHpILJuTMlQx3Um0omPqlCmdI/WfBFJN0GJ210sdS7H0578bBzjoQIGg65sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIZd7HRa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIZd7HRa"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367940c57ddso378324f8f.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900738; x=1722505538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Djp+ptWqTkxdfTt4FRqnRIWhpifk2V0Gh+T5zjgWkXg=;
        b=nIZd7HRaq38jKo6QLMc1j9B3QM8ntCFtZFMSMR2Qke/8vgCY9oY+JrzVN7A7j7Pguw
         Llf3oCDURu+Jxaxr/hTmYBEYGlBROMfUv6pLpuZ4mGF5uI3bQWiWQ3vpTTKFtJ5zBhox
         ihWSgMywAzdZztjyUMmjeUu6Tzbdi+5U7s8Rj694TYBxpIAHoKmetiboZSnzg0H96s6g
         XzYI8eJaZeKoQu7tUUmNJ59txjwF7QDhouulIx6ZL8w82xWizBNA5PWHlyUB/1iEwrsg
         aYbWxhhWeetDinNBpDKicdQXKgp1srR5e6GXJZJeugIlh9Y/bIbX7VQWcarw4V4dIQl5
         cOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900738; x=1722505538;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Djp+ptWqTkxdfTt4FRqnRIWhpifk2V0Gh+T5zjgWkXg=;
        b=OrN2NfvdXHNDwp4vgH+tsv8xGJvl8l4xvwQwxP+Hj3puGywXk1iDn3bHRsJ7W9l7+P
         vUoIhygCrKP8SM0cM0S+yqgyWwuAjBc/kCmUUP8tlEZR/DkMuVHaIsfSinpcbT5OlNBh
         EEJi+4Upl4GqkFKJWBTVhP9D6W1LCo8IorcovhRWx1YmIZVwGzyVeVXJHZEJZritYDqd
         nEtmk5juIX8JNI8q6Voxigc3WAomAy/FkdflxBLJ9No0852P/Pyscs3zV+nQAuh916Cm
         89fTEA2Ag4SFAIh2WnEEhBUDB6kvGCVeCo6TeeUFit1WH0LxuQ6fMYdPiIq1oMmr2xFw
         es/A==
X-Forwarded-Encrypted: i=1; AJvYcCVCCPldsB9wIJANX/z/sQsro8YEoKrE1eWafknMTh2gunjWWicSryuHe+niKvMjwmdJUrNcFMmUQfJ6U0OgBI6PSnxi
X-Gm-Message-State: AOJu0YyqoGznN7neeEEvLykjOITOm+j+ule0ssdNFsCA4zIYASHedCif
	fjDmYp3SDLvAx2Qob1cYw1fLym08+qSB1SnqwNrgpkoJEsp+bp1ZMEe9i13i
X-Google-Smtp-Source: AGHT+IEbKWjLR/4sBRGavfWRG70FDLhNBHvu5xSLwaSdmYW9yFPCx8M+Q6MEPxuwDRKF5yAzjwWWtg==
X-Received: by 2002:adf:978e:0:b0:367:94b8:1df1 with SMTP id ffacd0b85a97d-36b3642addbmr993129f8f.55.1721900738184;
        Thu, 25 Jul 2024 02:45:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dc2sm1558822f8f.77.2024.07.25.02.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:37 -0700 (PDT)
Message-ID: <5332f244-7476-492a-a797-2ef7ba73f490@gmail.com>
Date: Thu, 25 Jul 2024 10:45:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-3-gitster@pobox.com>
Content-Language: en-US
In-Reply-To: <20240723021900.388020-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/07/2024 03:18, Junio C Hamano wrote:
> The pathname of a repository comes from getcwd() and it could be a
> path aliased via symbolic links, e.g., the real directory may be
> /home/u/repository but a symbolic link /home/u/repo may point at it,
> and the clone request may come as "git clone file:///home/u/repo/"
> 
> A request to check if /home/u/repository is safe would be rejected
> if the safe.directory configuration allows /home/u/repo/ but not its
> alias /home/u/repository/.  Normalize the paths configured for the
> safe.directory configuration variable before comparing them with the
> path being checked.

I think this is sensible if the key is an absolute path, if the key is a 
relative path I think we should ignore it as it is not clear which 
directory the user meant.

Best Wishes

Phillip

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   setup.c                   | 12 +++++++++
>   t/t0033-safe-directory.sh | 57 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/setup.c b/setup.c
> index 45bbbe329f..29304d7452 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1236,6 +1236,16 @@ static int safe_directory_cb(const char *key, const char *value,
>   
>   		if (!git_config_pathname(&allowed, key, value)) {
>   			const char *check = allowed ? allowed : value;
> +			char *to_free = real_pathdup(check, 0);
> +
> +			if (!to_free) {
> +				warning(_("safe.directory '%s' cannot be normalized"),
> +					check);
> +				goto next;
> +			} else {
> +				check = to_free;
> +			}
> +
>   			if (ends_with(check, "/*")) {
>   				size_t len = strlen(check);
>   				if (!fspathncmp(check, data->path, len - 1))
> @@ -1243,7 +1253,9 @@ static int safe_directory_cb(const char *key, const char *value,
>   			} else if (!fspathcmp(data->path, check)) {
>   				data->is_safe = 1;
>   			}
> +			free(to_free);
>   		}
> +	next:
>   		if (allowed != value)
>   			free(allowed);
>   	}
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index 07ac0f9a01..ea74657255 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -176,4 +176,61 @@ test_expect_success SYMLINKS 'checked leading paths are normalized' '
>   	git -C repo/s/.git/ for-each-ref
>   '
>   
> +test_expect_success SYMLINKS 'configured paths are normalized' '
> +	test_when_finished "rm -rf repository; rm -f repo" &&
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global --unset-all safe.directory
> +	) &&
> +	git init repository &&
> +	ln -s repository repo &&
> +	(
> +		cd repository &&
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		test_commit sample
> +	) &&
> +
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global safe.directory "$(pwd)/repo"
> +	) &&
> +	git -C repository for-each-ref &&
> +	git -C repository/ for-each-ref &&
> +	git -C repo for-each-ref &&
> +	git -C repo/ for-each-ref &&
> +	test_must_fail git -C repository/.git for-each-ref &&
> +	test_must_fail git -C repository/.git/ for-each-ref &&
> +	test_must_fail git -C repo/.git for-each-ref &&
> +	test_must_fail git -C repo/.git/ for-each-ref
> +'
> +
> +test_expect_success SYMLINKS 'configured leading paths are normalized' '
> +	test_when_finished "rm -rf repository; rm -f repo" &&
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global --unset-all safe.directory
> +	) &&
> +	mkdir -p repository &&
> +	git init repository/s &&
> +	ln -s repository repo &&
> +	(
> +		cd repository/s &&
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		test_commit sample
> +	) &&
> +
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global safe.directory "$(pwd)/repo/*"
> +	) &&
> +	git -C repository/s for-each-ref &&
> +	git -C repository/s/ for-each-ref &&
> +	git -C repository/s/.git for-each-ref &&
> +	git -C repository/s/.git/ for-each-ref &&
> +	git -C repo/s for-each-ref &&
> +	git -C repo/s/ for-each-ref &&
> +	git -C repo/s/.git for-each-ref &&
> +	git -C repo/s/.git/ for-each-ref
> +'
> +
>   test_done
