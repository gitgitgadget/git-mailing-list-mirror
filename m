Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED6213240
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836829; cv=none; b=j2kYlpSJBQIUr95cE8UgVw8tZPSXsnffYU8ZY9taH31vVMvWf541z2x04w0/NXIpGM5t840o88ejqaDJcpkYXAQevKlRmRtqUqigcJcZ+NhDthgCOvmESnxvK2yszdjXt47Qvt8vx7l/FdmetZFUC+d7wK6xMLemjz1FmA3403s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836829; c=relaxed/simple;
	bh=yPejLFDv1b+Mr4C1z3k8kKivcwo8MfA5rHEDiLXUlR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=otUahPUngqyn/qt5cU9hSOWVY2T6+A99vFds9suYHWRgPibir61KVwr/oSXXGGAA9f7ExiBkghBOjLAtbzBNJkBkSJOTWff9SFBzDB48ZxqCCwmY5G86WFHxrbx6pTiThD7GuiboApGHoK0ooTIPqjwo14Z1kDcJbphaHB8rCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faiBMGbA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faiBMGbA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1128550f8f.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738836826; x=1739441626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KLhSoZsB7wfZAU5uCVT2wffKM/RqUhBiH02bS3S5fd8=;
        b=faiBMGbAGV8WL+8PVaH5v64BjRiP+zK8n2ahoM5cuE0zscmr6vAJZr5t9y5Rv3tmYR
         8H63AVN0wBQXtQSpOrjGZYjn9D3WtiHmwUrWrBh6ifdymTo5yrSnm1izMB1m5gRo20Qd
         p3jK6333r6kGbUilNqOCv9ZHjhZqe4ibnK/wqsTK20G/qzcP3xoEMle3EGtJwdrBOFEm
         SugiLoNmibABuA67ExR9ZIrrvQmkeBdgQPETVnglRK7LPTPxY/A/og29j9EMt55dcEUy
         /z1u3OjJiUjJ2imWF6Z5Hz8QPmPolJKU27y6Lxvv4HkL4s7jQtOEmjpqUPACeoYJeefM
         9KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836826; x=1739441626;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLhSoZsB7wfZAU5uCVT2wffKM/RqUhBiH02bS3S5fd8=;
        b=CN/SZIjR0uh/btvE76bT1gKh/XgMLckpv4VgItS1iW0qUoLLJKkjAH3q5cfDLSgl0K
         wvFHqQMXl4J+fjZ+lK83i8PCBP39HhnK3A/4At/pqKaeuvlVTF60TjQbgduTxYPHzAvs
         7YAMQN3uIfwzOMLqCLnDEH2WFoVSaguXwQEeQFNXZ5FObPg4glTZMQ73ktVIaEneQwn2
         IUe+iVe0lhNBNf5hVJlkIOjDK8hftc0Qf8juIgDRMGB9gCdoukhj0/8cXlsB37F+/H2m
         dKul+om4sk1gaDQcVHPmOlEaGZFpwPcWebdWInQKUDWJh1gnj6jFFEeUHiO7cBtykx41
         vRmg==
X-Forwarded-Encrypted: i=1; AJvYcCU4kf/8AoYpotZBz8RIkRaycQMDvbKQXMZMhoVMez36pTr33RVKKRIoG0eAcSAx/hBZtr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSAvwlfWuTMu05/efKjpKGzigOI0O6fHbM8pMLrdSa9vTH37e
	txPSdAde5sARKwH5PFC1wBqLfZ3OxdW44/y6o7Ga22RAna/tOYh5
X-Gm-Gg: ASbGncvx+FhAN3BFhk6yf3DUk1cOvNOCAPrGLQ4aPnyV14CKzFbeahHl455qdDckw2b
	Fq/ugFtGmU1VnifzmHx7aEryllB0EyBMSnFMBZIX8KZQjzMzHJ8/Lp7TUePgj8EbmfHNT+ipwZe
	C87c+h83DLeHs84MIQ0SXucnUHEDX0G15s45H7Rjws5ReREf/iYSEUWt7MUlQW22MYNWApXlBaj
	z0Ik6zgSqIgIOelVV772vYNhypg1XK7kQd8m05TlsgIxyRMaO8xxIdrU9SeLZ1SGDJKgpjkFIR6
	RjNJmJWydWyNi89MEQ1V2eXNMHrty8ufGXZ+Dp+bkA8bXQAZNw4Xyg1yWCxYC1ASHM5KuA==
X-Google-Smtp-Source: AGHT+IHOFpy0p5VyLQhWXc4NCwg2idf7PREsaLovwskvuQ79gIY6iSN2d1JkypNMujAHkQtrh6OZHw==
X-Received: by 2002:a5d:6da4:0:b0:38a:4df5:a08 with SMTP id ffacd0b85a97d-38dbb2d56c6mr2076492f8f.22.1738836825405;
        Thu, 06 Feb 2025 02:13:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfd7d7asm13856485e9.36.2025.02.06.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 02:13:45 -0800 (PST)
Message-ID: <c88b7b54-d032-4d91-95f8-2f139ec45b78@gmail.com>
Date: Thu, 6 Feb 2025 10:13:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Elijah Newren <newren@gmail.com>
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250205235931.GB30202@raven.inka.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josef

On 05/02/2025 23:59, Josef Wolf wrote:
> 
>> git rebase --root -x 'git add --renormalize . && git commit --amend --no-edit'
> 
> Unfortunately, this runs the command on every commit and gives a warning when
> a cmmit don't touch a filtered file:
> 
>    $ git rebase --root -x 'git add --renormalize . && git commit --amend --no-edit'
>    [ ... ]
>    No changes
>    You asked to amend the most recent commit, but doing so would make
>    it empty. You can repeat your command with --allow-empty, or you can
>    remove the commit entirely with "git reset HEAD^".
> 
> Is there a way to run the command only when rebase halts?

You could try using "git diff --cached --quiet" to avoid running "git 
commit" if there are no changes.

     git rebase --root -x 'git add --renormalize . && { git diff --quiet 
--cached || git commit --amend --no-edit; }'

Best Wishes

Phillip

