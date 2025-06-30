Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC403292B3A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301326; cv=none; b=t7R81+Hy3Lhnb9vsa4zujGdO7kUjSg0UjlDOZgWd4OOFGbGQA72saFwo0XvvQUVJaV7/J4iV7ewk8rXV5gflgIy5+a0T9PbPdDow1I2W1oR+Y/H2BtLSyhwuLMC0+9yYkAmFVQoIV69ik3YAeiVK5ZA0vmIKb1OOsjydHKzEwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301326; c=relaxed/simple;
	bh=crBeIYorAqXk+nRX6KfOPVH85fXoY4xvRA6Bp8Q+T3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/tOP291nbIpBd9Aeb1woEAT4V2vN9iZ8FI0zslKMQaErxSEBpozop9bN+HFBcax4+7gh4bjGi21X0h+ku5oVRmseMzvj/TzgxEIkvuB8hXfVWrR+aX/7QIPoHuzs2Qdc8uG/9uoWW3rwQ5aBt3VfXSwYHSIxuV3CeGJT6vFHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJhFNmtv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJhFNmtv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234d3261631so33284725ad.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751301324; x=1751906124; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiGASne3hrAQcxlbzNXqxcK5wGf9vWmfghHNtLXt+D4=;
        b=jJhFNmtvmB6CVcjBU6B/oHGlDM20CmdEjzQY9X8DR5uO2qJKV5KH+LqK+uMo43SUQs
         WmQrvUHNaNEJ3nGcKy25IBGR1Nbnbl39sfe3pGJeLpfielN18c3ZCjXsJ0qbB3HyWCFt
         nvkM4a6hFzqyGmUPxfBzEBmRkpQC7jR9ATfLZRk2ZVr75kGEnFAF4aYqyeWjZeT+gR6c
         +zqRHOLdOcmzyLPg7pkubnDJXYdTSPnnV8V1eUXIwJvq87k0J1c+yORPceh8tCeqmiRp
         w7cSdkL+P3BTq15Kl9xQjM4UcZ2CtxH3jslE+mRK/jxReFoR4vuW74c2AsFhuOV77Vlq
         oWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301324; x=1751906124;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XiGASne3hrAQcxlbzNXqxcK5wGf9vWmfghHNtLXt+D4=;
        b=GUaV1ONCBfNeXG95gUKwU+4ucFkhuL0zkBmGcVyjNjDPcbW5ulG97exK0WLivQ6/rM
         RdIQKyVqoBJ5tb7YN453ibgNuAU5cbmNktqpobyFrPnTrEFnNcUOur+fMmw1jL4ckSKh
         JYL1jaerV1t11x89MYt7BKGJrnSYX6XaKG2Ee6KbfyL/XcFz29BC0HbaWXi/Go9z3mYu
         nKLIhaRKpkre4z132lV2dmD5QxS5TGalFMiExp1ayWYpVOKKttu0B8xxtz1N1NJ3Tcmj
         5j/QTB7WKerFY5+vmUDX6N17Kr+cQbf/K+G7DH/DNIBJCspiRBATPnvQaq6EtnBfunCe
         PfOw==
X-Gm-Message-State: AOJu0YxJDAOlhgI7MHlZNBVP+aJkbVKQwa6Hw6KkAEI1Dk5REJntSnql
	FZ+RP6zaRFjjQn98wQvQhzCZC4Yfv+JZEOyLeV9HR6qtlFPL0AuUNLaC
X-Gm-Gg: ASbGnct3vwnfQsWz4JKTT2Yv1FYA+FiyMIB1wbFW0HeEsThcamOYSoFB4W6nWEHCd3s
	NiylK+PhysARWXyDGRXSaZmmqtmAUBtocg+ntBhnZta5b69hW/cZmp2cs0KGcdFmlkmvWcBz03C
	l5Mx7LkV8VwgNo4V0NawSLmLt80zH0iuFGPPudSgB2rYRdGTyQJBKSV5Ba67n0pqGP3eH23z6Ox
	sMyVBX+91TdshcsV47jjZK5LXqkersR2XdrWMmD24qynTV6fb3PfO1kjhVxrJbMBdQ2wuPpKNrM
	9kFd7ieAupHWoYOSB/BRj58cBfcbtx8YZHZAuqClZ3CMkKA/04NWHyoTSs2zDP45Vbau7kNBP77
	Xw6DIxTxhq6rHFu7ExVO6ezrIM/o=
X-Google-Smtp-Source: AGHT+IFXA9TWWvJH4FT/0uy+B/g5mfiArIdZW0EtHPNoKGhYu7/Et7MMa51KupicHcBJ7nk+IK7djQ==
X-Received: by 2002:a17:902:ea10:b0:235:f3df:bbff with SMTP id d9443c01a7336-23ac45c0d00mr213301855ad.4.1751301323886;
        Mon, 30 Jun 2025 09:35:23 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c7041sm87236695ad.229.2025.06.30.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:35:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 2/4] test: use "test_config"
In-Reply-To: <e5c40d37750fe7effa95e8bf2cc24945150364d7.1751128487.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 28 Jun 2025
	16:34:44 +0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<e5c40d37750fe7effa95e8bf2cc24945150364d7.1751128487.git.gitgitgadget@gmail.com>
Date: Mon, 30 Jun 2025 09:35:22 -0700
Message-ID: <xmqqjz4t2nn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> Use the modern "test_config" test utility instead of manual"git config"
> as the former provides clean up on test completion.

Here "completion" is not "all the tests in the script are done", but
"each of the test_expect_{success,failure} piece that uses test_config".

Drop "modern".  It was invented 14 years ago (the same can be said
for test_grep which was called test_i18ngrep and had an extra
purpose, which was invented in the same year).

This conversion, unlike "test_grep" needs to be done a bit
carefully.  The fact the configuration is removed after the test
piece "test_config" was used means any tests after the test that was
originally using "git config" needs to be inspected to make sure
it was *not* relying on the value that was left by the previous
test piece.

For example...

>  test_expect_success 'diff.context honored by "log"' '
>  	git log -1 -p >output &&
>  	test_grep ! firstline output &&
> -	git config diff.context 8 &&
> +	test_config diff.context 8 &&
>  	git log -1 -p >output &&
>  	test_grep "^ firstline" output
>  '

... the test piece after this one may have assumed (wrongly!  The
assumption does not hold if this test failed before reaching "git
config") that diff.context is still set to 8 but that is no longer
the case.  But that one is OK because ...

>  test_expect_success 'The -U option overrides diff.context' '
> -	git config diff.context 8 &&
> +	test_config diff.context 8 &&
>  	git log -U4 -1 >output &&
>  	test_grep ! "^ firstline" output
>  '

... it was setting it for itself.  The same can be said with other
tests (not quoted in this reply).  They all set things up for
themselves, which is a good hygiene.

That means the last one in the patch needs to be inspected
carefully.  We do not know from the post-context of the patch what
the next test used to expect.

>  test_expect_success '-U0 is valid, so is diff.context=0' '
> -	git config diff.context 0 &&
> +	test_config diff.context 0 &&
>  	git diff >output &&
>  	test_grep "^-ADDED" output &&
>  	test_grep "^+MODIFIED" output

The one that comes after this one is about giving an explicit
command line option -U<n>.  It should not be affected by a
diff.context conffiguration variable that is lower-precedence
so we should be OK.

Thanks.

