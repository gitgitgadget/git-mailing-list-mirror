Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C112F367
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676319; cv=none; b=r7R0AycTigq6H08RTQT9NGHJ36GNbrpahLTslIK4kNsinA4JtJNvugp7P7ZswFbgusA6c0OEl0e0E/G3z0o3vFRX6fAU8/nNDuk3tvrwI0bTUm3+9FBPlRdaCsQ/5QNMJLYUAaQKmYh0wAestL21/GqbFK6tLqNwbn3Ki6HH7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676319; c=relaxed/simple;
	bh=S+sqRFB7Y9xB3Rzolsz+S7jXDf7y9twBoTHldqSp2Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6jdNU1CjCFx3JEBhamftFbqqL0zHz2qlzhUIN9BAKHmRTRnX9NLDVf9h+ElWFckDeOcwzxrWZ3DzfMZw5zR0gpeQubj0Fb0xsDJ3rbj2+iNVay5dthpHAp4wUL1vOQf5Rnsp55ZhZnJNByuXrT49Hyfyms74+8UHiABD0nWeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy8wbGui; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy8wbGui"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso2828572f8f.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676315; x=1713281115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JsvF+dd3i6oXXw856ufImRoxGuuf5PXe6uhRGA4C3J8=;
        b=Qy8wbGuiffzIrgjVJMNTGKit2PcE8k9npOut2dlWrA18u0ddWLF1kGc9ukptZ1nnAs
         FUacOhDoJpPLT7sCT8WXeaHvem4H/JKdps7+sR4URl7dae8Q9w7LKpu3XKu5IYNiVnXH
         iq1n9/3/c+c8yt4yjlf7x0YjaSFx1xi2rUsJwbjlEAci212hn4X7eSjL/Tf6+O0swRdR
         4K1TY9wmBs3UkWVRpLDugcM/adWmqDw/9kiL358DfIysM55EXfX+o+mbCjUm8yyG58H2
         zwvhG/sCwArnl1taS6NUSZm/UpKyExpzTow2Ho8kfBqjoRbVCzYxutQ9snOHxtQQiRZq
         ZZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676315; x=1713281115;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsvF+dd3i6oXXw856ufImRoxGuuf5PXe6uhRGA4C3J8=;
        b=tLhK4lePkksKwIvk/PKnibrZbGZpJy9O/gNeVD1lUWu7NzxzT74U+MlRgdfhyTaX1r
         QLBBIdnFD9jiyIFoYIZ/tk2efjTY4kJP5WkB2Tyzux5ofdlJzRkwZUIFDqZEIQkuwtDT
         0T4pYFdz5HXyJQsIa6ffa9DwVLNLAhHNrw0a7I5rEdpPmoyKoDi+JT1cjAru+zB+6wMb
         k4mQmUjheGH6xOJ3N+UD5hFC+RGskRG76cVVq7R+Y7tQkonJZ4sF0LiN/udC/YX7A5QD
         atzOKCiFCr3KLsNWWqDql2HwKR8o9yoMJQC+T74PLgAT62RLBpIWQXU8fLiR3OJo5JWw
         jSxw==
X-Forwarded-Encrypted: i=1; AJvYcCV0n+RTANgl2H3yaBMoHHJQimZHDZLByh++c9aIMAwwvPPYzGNjh60XbO//SKgRGwS+E1+UMGmGxH5lHlLBCJu6qdmY
X-Gm-Message-State: AOJu0YzWnoSxMQoOYqELxelyeKegn/U5GhoTe9GWwF2fD8Mde3pJGDs+
	toS7nY+h7nzRVqEDOTZXNh4wg5WvTgxx6JgsbpEKBr1538QF0P5fv39KFSXY
X-Google-Smtp-Source: AGHT+IFGcwejo5GhcRvzNUthd5keDzje+tH25qLrbOyua50rUL3MXgDhbdDtnViF9yERItwkBAiTdQ==
X-Received: by 2002:a5d:560b:0:b0:343:81ea:c534 with SMTP id l11-20020a5d560b000000b0034381eac534mr23886wrv.64.1712676315328;
        Tue, 09 Apr 2024 08:25:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d5509000000b003418364032asm11688277wrv.112.2024.04.09.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:25:15 -0700 (PDT)
Message-ID: <a9ccd0db-2e52-4521-9d72-49d2a85656f5@gmail.com>
Date: Tue, 9 Apr 2024 16:25:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean-No=C3=ABl_Avila?=
 <avila.jn@gmail.com>, John Cai <johncai86@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John

On 08/04/2024 18:38, John Cai via GitGitGadget wrote:
 > +--symbolic-name::
 > +
 > +	Print out the value the reference points to without dereferencing. This
 > +	is useful to know the reference that a symbolic ref is pointing to.

It would be helpful to clarify that this prints the contents of the 
symbolic ref without dereferencing but also prints the OID after 
dereferencing the given ref.

 > +When using `--symbolic-name`, the output is in the format:
 > +
 > +-----------
 > +<oid> SP <ref> SP <symbolic-name>
 > +-----------
 > +
 > +For example,
 > +
 > 
+-----------------------------------------------------------------------------
 > +$ git show-ref --symbolic-name
 > +b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF 
ref:refs/heads/main

Do we really need the "ref:" prefix? It is not specified above and I 
think anyone calling this would have to remove the prefix before they 
could use the value.


> +test_expect_success '--symbolic-name with symbolic ref' '
> +	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &&
> +	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
> +	cat >expect <<-EOF &&
> +	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +	EOF
> +	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
> +	test_cmp expect actual
> +'

I think it would be nice to see a test along the lines of

	git symbolic-ref refs/symref-c refs/heads/master
	git symbolic-ref refs/symref-b refs/symref-c &&
	git symbolic-ref refs/symref-a refs/symref-b &&
	git show-ref --symbolic-name refs/symref-a >actual &&
	cat >expect <<\EOF &&
	$(git show-ref -s --verify refs/heads/master) refs/heads/symref-a 
refs/heads/symref-b
	EOF
	test_cmp expect actual

to show what this command is expected to return when there is a chain of 
symbolic references.

Best Wishes

Phillip
