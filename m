Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5426FA52
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375869; cv=none; b=hNDJV88ucwwlELt0IT5yqhYAcLqOPa6sh64diau1g9B6Lv4/Q5+pPr07t5t0PYcEKW1KkvsEuqrrgVrS7x6PfRyOVr+2roGTVIVw5zTwHd9ZZASjLt9fwqngY+lakrt/sqzC1ZM74U4K6yYh3upLEwpb8ZeDRyMLR1eEtbInO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375869; c=relaxed/simple;
	bh=UHU9veUICfn3fmOawh6e+rU2aapQe5FhdJFhuldOjEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHMgZytnOYKVBw1Qm+GJCcdyhBkPoIRy1IRknskiU8cbI1Sjcuh1lk7/uacpu3GaFSW1GLn3VdUm9pvFFHnNwbJWJXJERCQcuDo0De2dC6PpAbNbG7jewB5ur7TEttp8C+S7H27EIEJJE7SgZdv2JxsRK6U/ZHgApyRwcu+xH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT2PhLn0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT2PhLn0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso27771755e9.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751375864; x=1751980664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lG5FGWqMo4bkitdfy7TyWHczedTqpaQQqtoAqk5+Wmo=;
        b=LT2PhLn0AZnaK2JEYiIdQNpyyGLhVdqwqdYC6i8/2aSmheKzIpf1Wx9tjKngKXdV3X
         RBUxfCeIWmHolxOpQ+BeLrajTkOGlz52PO+NnKR9Hq3I9Lbx6OxMoscvWlm1vFZNYJHp
         trQKb5r0SLVySBlsMy1UqD0pW4qRS39s9v5A+JI+0/9GLLDX9l4spDQC0kiJ73Sc+6nN
         kZ7H+hoQnxBTfzbbpabUq4NK8ILhW4+E1t7uq6kXpJnrshQP5uNHH9t1vPUdFrAiAs9x
         QHxI3CPEmcX4JfSTRMtrztVNq130a/ZHU36RZXRlD1h7dmDJX9b9tt1rw5vfu9iFMGZd
         5+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375864; x=1751980664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lG5FGWqMo4bkitdfy7TyWHczedTqpaQQqtoAqk5+Wmo=;
        b=rN7/yUfSvHtYJjCkGY+19qIgK/+wV/qlN1Pg2bC5rhKpJodRb2lQK0nyJVDIf5VnLV
         bi47NLB42ziQMY9UjVp/6ZI4fqsQ1BjuEi+ywGFU5QrBHwfjw+HY72AY7UvP7lAFmeS6
         usTslCbcr1EtFfPjFn2+heBSo3VH17JBVDRWj9MApOork1vi9qJ9gqeBHqAE/9f1zal5
         dYOLArU5ipuaBtxA+sp4EBE2KAsaLDXjtfWsSGBPFOFHRE6BpfIaHLkEGdAQqvforhk4
         Pfcr8G5k1FoGzTGFWFZrOU+DwA79rpssfC2nPoFUuQbN0qBtvlC+f3xERYYu1RboPHA0
         knJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwq5trUp4CdtjJEQ+rBH/jfly5GbTUO0zzYaWgVf/eu+X4o8fzdgFp85mrSGTpDfzbNjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJJSCwn974YN0n+AJyGSnG3H6WniRhrumDhU/+x8k0MT26BZ0
	Bg/vI2D6o54fHYNlAjChMHTZWnalkuihPwiLR4CREN+7itoC5kDmlYIpObw/ww==
X-Gm-Gg: ASbGncvSNuyEIhbhjKmcDaU8RBdaXxLlVb2CQG5Lmp/pd7+QfZPj3Cl8usnM+gyp8XD
	PguueLcn1uPQkSbnSfUhDJddLQ4SDepcMVMzIno8bTcUggpTtMxzTdlzoH5FI/NOdhw6xzVAUmb
	0aLyZY0IQ3qlZeJE+9kqgWdYnCi9I7EGLd0asvipWoUgQCa6sYrKp0imri9O9v9H51ZvzpfGVnw
	gdbRzR07ThDQX4Xa8RdDtsUKpK72DS5H/94AV4eccH4+liqi4QkivAAJfQX+jQFo7bJ2CcfkuIx
	uIWws7TVLflRvu+DlFMoPHDw4W4IZOGpKJJS3nN1QgVMSrGTqV5BAtZYPRgRZ5o/asx+TG/R3VJ
	VPigERyqbtuv2XPPRJeMxjYIXc98/5rfgWt60Xw==
X-Google-Smtp-Source: AGHT+IHoP2CKMIz6fKifFtLfE///ugKZO/UEInInc7oTipobYhCrxl67lRUQlgja0U5TcRvgikA4lA==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr182985575e9.4.1751375864220;
        Tue, 01 Jul 2025 06:17:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6fa2sm196717465e9.27.2025.07.01.06.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:17:43 -0700 (PDT)
Message-ID: <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
Date: Tue, 1 Jul 2025 14:17:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, kristofferhaugsbakk@fastmail.com,
 gitster@pobox.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250630182527.69167-1-ayu.chandekar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 30/06/2025 19:25, Ayush Chandekar wrote:
> 
> Range-diff with v2:
> 1:  4e74e7a9a6 ! 1:  693f890a36 commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
>      @@ Commit message
>       
>           The "auto" value for core.commentchar was introduced in the commit
>           84c9dc2c5a (commit: allow core.commentChar=auto for character auto
>      -    selection, 2014-05-17) but did not exhibt this issue at that time.
>      +    selection, 2014-05-17) but did not exhibit this issue at that time.
>       
>           The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
>           with conflicts, 2024-04-18) where Git started writing conflict comments
>      @@ t/t3418-rebase-continue.sh: test_expect_success 'there is no --no-reschedule-fai
>        '
>        
>       +test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
>      -+	test_commit base file &&
>       +	git checkout -b branch-a &&
>      -+	test_commit A file &&
>      -+	git checkout -b branch-b base &&
>      -+	test_commit B file &&
>      ++	test_commit A F1 &&
>      ++	git checkout -b branch-b HEAD^ &&
>      ++	test_commit B F1 &&
>       +	test_must_fail git rebase branch-a &&
>      -+	printf "B\nA\n" >file &&
>      -+	git add file &&
>      ++	printf "B\nA\n" >F1 &&
>      ++	git add F1 &&
>       +	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
>       +	# Check that "#" is still the comment character.
>      -+	test_grep "^# Changes to be committed:$" actual
>      ++	test_grep "^# Changes to be committed" actual
>       +'
>       +
>        test_orig_head_helper () {

The changes here look good but I think we want to update the config 
parsing as well so that comment_line_str is reset to '#' when 
core.commentString=auto. We probably want to do that in its own commit.

Thanks

Phillip

