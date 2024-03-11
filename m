Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD7A3984A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154465; cv=none; b=ivJATyHdxj6l5BYkG0TxjN2TPB5GHvg19LPhLat/ApUDyHCcBFWgpMaTTryLP7zG+RW5LO8qz9ap2v90H/3kvPPl+gC2frwSDcRf1GWmi/WO15H6XygmbPOSeRpCw/BkkBHJ//C+4sB3tgE2xztxRelxrVYkP1l1oc09Bw38ats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154465; c=relaxed/simple;
	bh=6vg2/ewPZn1CQYkOvCJ0yIuEjKfIpoNismAvDRNbsi8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DrS0EMyJOg1P5bCLL9l/8g+qIem4gbBsRnLVkaRvZC0h/XIDRSMVkDTihNw9zVpxoS0LRltsW8Xz7FMJK5/wrhvbxbZRAhQQ80lyLUYbrtkWe5qa0RLr6zU/+eOvmz34pMZB9ka0OGPL/PmgJs3r25fql55GaKYqrsCSVF57bJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAaKc6XC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAaKc6XC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41312232c7aso20625465e9.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710154462; x=1710759262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paHRc8NCrYLs5Er66X6+HQ/GyihWG7scScMi+WuCDPQ=;
        b=iAaKc6XChogl36PZQkA3SQrg5cNdI+eYugqNRzheFaoc81le6O394i4jB490IFRr/x
         L/UdFMD5bPEwM5tzc6Hes2aBYpf6fREoHyPFiFNb44KWtg4khhQpo169/U69vXvSPOGO
         vmqpJoQ+zS1Ki5n0tom+b9XjhjT1gcoeMLH/dvVpZqbimp5im8zYMHJvCvj/Yfx2wuKY
         sOrCqLBKZ67/vLLM9EC1Rxua/AuhhBuwsaLi7sKF+fyL+UtlA0sdfOwLSwxRd2sBA6uN
         fNmVBs/uXhHddbm8pWDRuAHYPMKjvohMcDpQm52Gyd3hzkWuTnHaEhY6O62VcVK1j4KS
         aYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154462; x=1710759262;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paHRc8NCrYLs5Er66X6+HQ/GyihWG7scScMi+WuCDPQ=;
        b=tTn4RIWWIr7VrDI3N90MMbWahW5jolmlAeqoRbgq6f5+X1mai3wFbDGqFA/nE5/hyr
         HRyMCeL6PbvRhBQQ8MCUwttE4lxL24IZnj0UIOyIotna7G1TWO+kZ7ZF9z3dIrsq6m0w
         3QIj07BTwJiikeFvcct0kOUxwroSZZ35UyN3+MWwkFhYXvKMvCWidMiOhlDmBP4cJ6jf
         Wcxtol6p/7pyrYqh9kw6y6q3Rvk+4MWsJx3hCMXe/GShJaMFxx1A6M/JrgqI4EeXc+9H
         hdG3HwuQEZ2eRI2Ke43m3y10fJSe51CvWSRR+kMTW/ZUdxL/nW4VJ2bxevBHlOoFbT7b
         gzoA==
X-Forwarded-Encrypted: i=1; AJvYcCWBhowf5Hk4uOj2T1jU5OxPdhQ54ZaFFIXM0RrWbTjRySdTJo+lgZ700T0cMZgjR2YxYwcAp0w/xMd7oEPoXWfYuBBz
X-Gm-Message-State: AOJu0Yx7aPCqFgrpDnUJaksParR7Muz7fbmCkuXuG2LXFq22OOFfMFSM
	kdiuvjU6jIRtBh+08JRHOSOti9hFNa4CXcgousfI8z+RwGXl/tBd
X-Google-Smtp-Source: AGHT+IERnmT9VkZOBrGpKrlIf2Kt+jJ94tF5/0YSUQ3hKkdaak5tTn620k4XX4QCHdSh1ahEfm/xHw==
X-Received: by 2002:a05:600c:1c07:b0:412:eddd:12c1 with SMTP id j7-20020a05600c1c0700b00412eddd12c1mr5483207wms.14.1710154461752;
        Mon, 11 Mar 2024 03:54:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b00413101235b0sm8790721wmn.2.2024.03.11.03.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 03:54:21 -0700 (PDT)
Message-ID: <f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com>
Date: Mon, 11 Mar 2024 10:54:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 10/03/2024 19:51, Philippe Blain via GitGitGadget wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> index d1990d7edcb..0e97b827e4b 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1150,19 +1150,23 @@ static const char *msgnum(const struct am_state *state)
>   static void NORETURN die_user_resolve(const struct am_state *state)
>   {
>   	if (state->resolvemsg) {
> -		printf_ln("%s", state->resolvemsg);
> +		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", state->resolvemsg);
>   	} else {
>   		const char *cmdline = state->interactive ? "git am -i" : "git am";
> +		struct strbuf sb = STRBUF_INIT;
>   
> -		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
> -		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
> +		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
> +		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);

I think you need to append "\n" to the message strings here (and below) 
to match the behavior of printf_ln().

Apart from that both patches look good to me, thanks for re-rolling. It 
is a bit surprising that we don't need to update any rebase tests. I 
haven't checked but I guess either we're not testing this advice when 
rebasing or we're using a grep expression that is vague enough not to be 
affected.

Best Wishes

Phillip

>   		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
>   		    is_empty_or_missing_file(am_path(state, "patch")) &&
>   		    !repo_index_has_changes(the_repository, NULL, NULL))
> -			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
> +			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
>   
> -		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
> +		strbuf_addf(&sb, _("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
> +
> +		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", sb.buf);
> +		strbuf_release(&sb);
>   	}message instructing the user how to continue the operation. This message
>   
>   	exit(128);
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 3b125762694..5e2b6c80eae 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -1224,8 +1224,8 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
>   
>   test_expect_success 'skip an empty patch in the middle of an am session' '
>   	git checkout empty-commit^ &&
> -	test_must_fail git am empty-commit.patch >err &&
> -	grep "Patch is empty." err &&
> +	test_must_fail git am empty-commit.patch >out 2>err &&
> +	grep "Patch is empty." out &&
>   	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
>   	git am --skip &&
>   	test_path_is_missing .git/rebase-apply &&
> @@ -1236,8 +1236,8 @@ test_expect_success 'skip an empty patch in the middle of an am session' '
>   
>   test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
>   	git checkout empty-commit^ &&
> -	test_must_fail git am empty-commit.patch >err &&
> -	grep "Patch is empty." err &&
> +	test_must_fail git am empty-commit.patch >out 2>err &&
> +	grep "Patch is empty." out &&
>   	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
>   	git am --allow-empty >output &&
>   	grep "No changes - recorded it as an empty commit." output &&
> diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
> index 45f1d4f95e5..661feb60709 100755
> --- a/t/t4254-am-corrupt.sh
> +++ b/t/t4254-am-corrupt.sh
> @@ -59,7 +59,7 @@ test_expect_success setup '
>   # Also, it had the unwanted side-effect of deleting f.
>   test_expect_success 'try to apply corrupted patch' '
>   	test_when_finished "git am --abort" &&
> -	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
> +	test_must_fail git -c advice.amWorkDir=false -c advice.mergeConflict=false am bad-patch.diff 2>actual &&
>   	echo "error: git diff header lacks filename information (line 4)" >expected &&
>   	test_path_is_file f &&
>   	test_cmp expected actual
