Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896213B2B6
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493640; cv=none; b=pC0rA/PqrjIYyxLyyViutW6BNGmkaP/y4h2lheP+vynQDF7w2xcznGoKbCZikpgEVAlK4J18kbUp0v+IV3c4+du5y32gaorQV20H763rKJ5MBVJgVAJKP/9tJ02LKhI/YYCtRz/uGHpZoxELHpm3NLOPOusoSUdELGnKZ3249BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493640; c=relaxed/simple;
	bh=Dt8W49Td003rOIFg8+Cjax+3DtZJKrX2L9WL9vAboAA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KcMgQ2Q2XyGxu0sQDy11XW8jzihMFhgbXA2VS6jGor3wcn5fSGVV/pK0nv1cHe9s3+a/76Hh1lfFSR3PNNCgW0ew7Tsx4P1hPyOdgCehFZeu23ljID1SOs6IjBnC374WosPbP7gP8MYADcBMZ4U8wOVaTjIi6SWjQhd2mktuX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/BrQEbI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/BrQEbI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bd059b12so2002153f8f.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726493637; x=1727098437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8thVAp0MVXrc/m5w3ELeM3v5+w53fPTXBN5jZbu3LDk=;
        b=J/BrQEbIzvnVMkNWZMosrMnCrL8KxCwepXUezF0pBQaclsfxrrf7tiivTaBbxRFqts
         9tgRH72ew09c6EUCft+Y+r20DF9HE65+mm5oSX0LyWkmXvs8E2wZ+Uqe8NUgoNRi4wWi
         eDyRaszON/xjxBPoXd97ZjbZ8TVaFm6t+1EnHSRei8fI/RFrGLJ6RQgF4ndfmcxSwZFw
         4b1cGfc2GLU5kNLKBv8dHviPp4e4GmJnhlKVXxm0cCtBmFjbNmMQs90fUnX8PIDLdzsf
         4FU5jG/wnuYkvuHyiefK/aRSBkcKMhpqL+7HUQ5xkMjqV75mCd+0xJNo5EqsRGVBigPP
         S7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726493637; x=1727098437;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8thVAp0MVXrc/m5w3ELeM3v5+w53fPTXBN5jZbu3LDk=;
        b=D0K6dIZi0uaUoQNbGQtRb5NjU05dBYtyQawppX/Vlwga5rQLEFEkwiaD1BnNdiqT3+
         boSAOCRCHoZBxjdGmXvFoIHoYsFuBvGlNmd5JYjhWD3kUZ+X611y5kesoXrsB7plOzFG
         74bB3vbKodsgc8y8g0ECVBKHHDpx9i8wlAwCxavRCWvYBrxzlS7K/wrtwCdzgfC4Cg14
         1HAcZqhOOP6agADWrbIUZNnQO7K+8T55ztMR7aiFySZ/ZaVictJRLNGo3EugSILCeXic
         eUgsK72B3VMEQi+hg49hoC1rBR1tTSrgtloeQIIEZIl4wn2c0pNWhnpsxmGPHBkRDUTE
         Szig==
X-Forwarded-Encrypted: i=1; AJvYcCXYLIXLOmE7rtHoPXAYschHDYJhXFvKdZ2MR4zmQH6+938Ivyma71zFYErnd4RbKAeAHO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2JCEvJ8WLLLYB172MCakvqnwSUGjn/e9/V4kU9nvtgKxNKcH
	gTbIxlRvhvSp9D3OtxBBT1xcmOPXTZfIFJImnKnWvfBKrPRzPxo9XGXqkQ==
X-Google-Smtp-Source: AGHT+IEJGLZxxNN8uSdBbPtkb6RpqJI+phBDnGXIW8ct1KNj/M1QwQ/aClygsO2lss+/5sQ1RF7a0Q==
X-Received: by 2002:a05:6000:1bca:b0:374:c847:85c with SMTP id ffacd0b85a97d-378d61e2c1fmr5660854f8f.24.1726493635666;
        Mon, 16 Sep 2024 06:33:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:628:b501:20f0:d089:108a:54d3? ([2a0a:ef40:628:b501:20f0:d089:108a:54d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24213a7sm78748075e9.37.2024.09.16.06.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 06:33:55 -0700 (PDT)
Message-ID: <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
Date: Mon, 16 Sep 2024 14:33:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: edit the hunk again
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
Content-Language: en-US
In-Reply-To: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 15/09/2024 12:38, Rubén Justo wrote:
> The "edit" option allows the user to directly modify the hunk to be
> applied.
> 
> If the modified hunk returned is not an applicable patch, we give the
> opportunity to try again.
> 
> For this new attempt we provide, again, the original hunk;  the user
> has to repeat the modification from scratch.

As you say below it looks like we started doing this by accident with 
2b8ea7f3c7 (add -p: calculate offset delta for edited patches, 
2018-03-05). I think that although the change was accidental it was 
actually a move in the right direction for several reasons.

  - The error message from "git apply" makes it is virtually impossible
    to tell what is wrong with the edited patch. The line numbers in the
    error message refer to the complete patch but the user is editing a
    single hunk so the user has no idea which line of the hunk the error
    message applies to.

  - If the user uses a terminal based editor then they cannot see the
    error messages while they're re-editing the hunk.

  - If the user has deleted a pre-image line then they need to somehow
    magic it back before the hunk will apply.

> Instead, let's give them the faulty modified patch back, so they can
> identify and fix the problem.

The problem is how do they identify the problem? I have some unfinished 
patches [1] that annotate the edited patch with comments explaining 
what's wrong. Because we know what the unedited patch looked like and 
that the pre-image lines should be unchanged it is possible to provide 
much better error messages than we get from trying to apply the whole 
patch with "git apply". It also makes it possible to restore deleted 
pre-image lines.

[1] https://github.com/phillipwood/git/tree/wip/add-p-editing-improvements
     Note that the later patches do not even compile at the moment. I've
     been meaning to split out the first eight patches and clean them up
     as they're mostly functional and just need the commit messages
     cleaning up.

> diff --git a/add-patch.c b/add-patch.c
> index 557903310d..125e79a5ae 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>   				      "addp-hunk-edit.diff", NULL) < 0)
>   		return -1;
>   
> +	/* Drop possible previous edits */
> +	strbuf_setlen(&s->plain, plain_len);
> +	strbuf_setlen(&s->colored, colored_len);
> +

At this point hunk->end points past s->plain.len. If the user has 
deleted all the lines then we return with hunk->end in this invalid 
state. I think that turns out not to matter as we end up restoring 
hunk->end from the backup we make at the beginning of edit_hunk_loop() 
but it is not straight forward to reason about.

> @@ -1273,10 +1277,6 @@ static int edit_hunk_loop(struct add_p_state *s,
>   				return 0;
>   		}
>   
> -		/* Drop edits (they were appended to s->plain) */
> -		strbuf_setlen(&s->plain, plain_len);
> -		strbuf_setlen(&s->colored, colored_len);
> -		*hunk = backup;

In the old version we always restore the hunk from the backup when we 
trim the edited patch which maintains the invariant "hunk->end <= 
s->plain->end"

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 718438ffc7..6af5636221 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -165,6 +165,20 @@ test_expect_success 'dummy edit works' '
>   	diff_cmp expected diff
>   '
>   
> +test_expect_success 'setup re-edit editor' '
> +	write_script "fake_editor.sh" <<-\EOF &&
> +	grep been-here "$1" && echo found >output

'grep been-here "$1" >output' should be sufficient I think

> +	echo been-here > "$1"
> +	EOF
> +	test_set_editor "$(pwd)/fake_editor.sh"
> +'

I don't think we need to write the fake editor in a separate test. Also 
it would be better to call test_set_editor in a subshell so that it does 
not affect later tests.

> +test_expect_success 'editing again works' '
> +	git reset &&
> +	test_write_lines e y | GIT_TRACE=1 git add -p &&

It would be nice to add "n q" to the input to make it complete.

> +	grep found output

Using test_grep makes it easier to debug test failures.


Best Wishes

Phillip
