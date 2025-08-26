Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3631A554
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223851; cv=none; b=u20dH4HtCmfly7JJGWYZUYF+tau4icehBxBwUylZGVF++usJTbFhITquZ2xTqqaZVfOqv1vT5d3wxwMVT32YkxFI2H6uXp5fU4vbIQqDjE9V4rYI3//QhPcsJIKKHhr3zEcfQGfuc9sCfrjLc2yevzzvbGPThP7fWIsmlWi6UU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223851; c=relaxed/simple;
	bh=5RC9+stS/YcnZVugMobZOYhjc8JDm5zTry3RiV6BmK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYnYLdi94y3OyQU33JqM76wQ4//7SuIT7rjk/dgjnNMjnUgqhN3vWFGfS+Xs2Lo73twpGG+wiBCBJ4ofPfQnP5GplTm5jqhfWUwZsQ2tkzFTveIiIZ3L+7TCNwiD75K2R44qIG/ao2dXNee8NHW8FPMX+ycts0QBOmYddAfYk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8LM+3vU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8LM+3vU"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so6782891a12.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756223848; x=1756828648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AaJlMowrOLTlMzSXxAq2oUAuJOuc2KAcTK2K84VDX2o=;
        b=P8LM+3vU3jss2Vr/EY9LpBFTMy95TgJnO2QchvmPvsD+yvb7BPto5xm6tD43XLSWcs
         ueTPGGpK/j8y19w388zfNbMJMk1pa78Hxsxavm6u1TneBwdEEh3WC+MtavaARL1/siLE
         0xWYHqxqAlPEwgoUVzq43/RAajjtiXZInCxubormlHoU5MkcGu92KV/COEt56QYyUcKS
         AfKVC+OF9LOxeZHKPNiJ3GDqYtw4LYImRx9XvAKsM2vD4e3qMh0dXzcyXxwKfdGVvMoB
         Tu7/jb0haj5ngExG6WeTP15oTVCdSQAgtwXnGRM602vNMTMiLsql/Of86XPTtoxRJ1Rr
         O+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756223848; x=1756828648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaJlMowrOLTlMzSXxAq2oUAuJOuc2KAcTK2K84VDX2o=;
        b=tlTsPk1s6o8Q5hMeGxcj8StsnCN53brMTZNcqLWjZyic8TeayT0AxOtusEHZcvNpJy
         roiZr/PoAlgopHkrp+2+SeRoTNIfE/HQYL5XKPiXotqf+D6hn/7vzXJL7KsjuhCKu7Ja
         ikKG9z9GIaOazYHZ5glL4lh11IyvF69lhypIwYjZz4aGFaOVc+FuuK4XjL95Kq3RF7xj
         it02lc7suBavOvqaZFczhllgDjx+Bs4DWkIB1XHugytOADdlEN7veQgHn8K/al7k+LQO
         mSW++K1wYYUiK2f29F1I85z46krFwtfwLoqHTbQvnSt4q+jz9MEQQWXV2OuzXNhzIw//
         fR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+x4L06IcKVsZnU534E6NhRMxzaQ0fc/buaKqMStkdpaTHZzmOoF3ppBi7ARFojeHVmhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQXNPMJB+MmowllC7VLyoZz76Qo/1Cp/knM+quyTBliWw1vkT
	ILowlufUekNuMA5UV9LvsS+KEijOCtKMmTUcs62OGZRfr+q5bQLneGFU
X-Gm-Gg: ASbGnctUyIMoKeGNXBZ/QGv6CNTRj9OMkh2KQ2nu/i1qAEqC30XK5rroMzl0ku20pji
	waaipGfGzf8OzvMGqCTs4HVFaGwFc2pKYwv/XX7fyEaupOsJB2BMyUJtK33+jzIG4cIe8qHrIeC
	GSE69I81URGq2s0ezxe7kyOThVJc18micIubq47PH1MQRZde9E/NUDC5zGdTSupTulsvI9kl+eH
	5trYlPXgLEVnxv2JMpBxszD6kGp1dAw6bx7s6C69J4a76vW7HLqKyDoqKeOxnuxW05o0PuRL1+C
	/Icjsx4NuuPWgrxi49i90yy98RyFqTzqlAZPShgUwqjL13lr5/I+NEdvF7SsfPrWkP9arR3Tlmk
	Ii2evD7ohDKUdZaOmDsexk+uvklFUsNNpSwh6GLqXm8xtGd6fynF/aE9X9cdhmqtG1zGW+QQWM7
	hrVQ==
X-Google-Smtp-Source: AGHT+IEyOlOmookiP6kf2FlcCbBkKwvfjYaGBQEdGlCeIDONWUrLQxnYpI5Vh4517hWohcb37/BUXQ==
X-Received: by 2002:a17:907:26c8:b0:afc:cc64:86da with SMTP id a640c23a62f3a-afe28ff788fmr1480503266b.26.1756223847430;
        Tue, 26 Aug 2025 08:57:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe81ebf53bsm448945366b.15.2025.08.26.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:57:26 -0700 (PDT)
Message-ID: <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
Date: Tue, 26 Aug 2025 16:57:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a
 repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, christian.couder@gmail.com,
 me@ttaylorr.com, ps@pks.im
References: <xmqqcya63cqx.fsf@gitster.g>
 <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250721115519.140361-2-usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Usman

On 21/07/2025 12:55, Usman Akinyemi wrote:
> 
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 6824581317..9fcebb7d94 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside repository' '
>   test_expect_success 'update-server-info does not crash with -h' '
>   	test_expect_code 129 git update-server-info -h >usage &&
>   	test_grep "[Uu]sage: git update-server-info " usage &&
> -	test_expect_code 129 nongit git update-server-info -h >usage &&
> -	test_grep "[Uu]sage: git update-server-info " usage
>   '
>   
> +for cmd in $(git --list-cmds=main)

This lists all the git commands in $PATH which is causing "make test" to 
fail when I run it locally as it is testing all my local "git-*" scripts 
most of which apparently fail this test. If there isn't already we 
should add a option that lists the commands only in $GIT_EXEC_PATH and 
use it here.

Also when I run the test with '-i' it does not stop at the first 
failure. I'm not sure what's causing that as I thought 
test_expect_success should exit on failure even when it is called in a loop.

Thanks

Phillip

> +do
> +	cmd=${cmd%.*} # strip .sh, .perl, etc.
> +	case "$cmd" in
> +	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> +	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
> +	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
> +	merge-octopus | merge-one-file | merge-resolve | mergetool | \
> +	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
> +	remote-http | remote-https | replay | request-pull | send-email | \
> +	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> +	upload-archive--writer | upload-pack | web--browse | whatchanged)
> +		expect_outcome=expect_failure ;;
> +	*)
> +		expect_outcome=expect_success ;;
> +	esac
> +	test_$expect_outcome "'git $cmd -h' outside a repository" '
> +		test_expect_code 129 nongit git $cmd -h >usage &&
> +		echo "Hello" &&
> +		test_grep "[Uu]sage: git $cmd " usage
> +	'
> +done
> +
>   test_done

