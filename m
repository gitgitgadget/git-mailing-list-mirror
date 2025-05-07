Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76774B1E69
	for <git@vger.kernel.org>; Wed,  7 May 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613058; cv=none; b=U77TCf75gz/K0WGGVSBsv56R9+HDvpU1CDJnM0XXU7Hw9qGMHkeJlabhYNUH+Z0+CqQh4sUfdSW4IiXAaIkNiMXtnwxjqb5KQ1ZCM83pkncrYGhmNlv7FVswzktWdTylF8zdcK9n8J2EA4+j5qlrbX4YhlAeDCEmLNXJcGa2hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613058; c=relaxed/simple;
	bh=RtBPdx9eGGet3w9uP9KQRdl3imlxnriR0nmDYIPqcD8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NxEOKGXSx4SruQFVVGXugZS1ZZNytdBYvN9ET9f6371uixvVQV8Lji9e1V2D3GZKZyXoYTutTIhDjdcK4WmWhJoOK29dzUTdtyRJ5Vsho9EOS402qfRz9EcCFCozhnMeXVkXvFSKpED7SO9zff4VUcUo6XR7JdsGV9WM525JoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNwZwGA8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNwZwGA8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso4469411f8f.2
        for <git@vger.kernel.org>; Wed, 07 May 2025 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746613055; x=1747217855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciDEiNxekOZ71CDHOzyxJfwUKXL0VyMYO3FMy/dFpAo=;
        b=iNwZwGA8fl9Nu8vjoHE+pY1eHsecPT34tFbtPr5CRPxh7AITcVkwolw6SgQgtKNxph
         oDIUTDPoPqipsG8z4AA2osrnDoqzi0gmLJOSfOMaX18tgxekytr8gu2jQ8GVvbKIvVna
         MPh0morWNvjibL/KTQQXyWZsuWj4h54caLx5c/Y/ldKDi4oqI7iDoUnG/iG4c5qXJMnt
         gWgM/o383xe24+6KREZsMzaI042MfKI8vNJN4Zp3cQZTJUPr4hK2nTYaWpKHCNYUCvuz
         /KACt3W5QU7sEp3H/BS6pNy8Vzl3LcE38eozp+7/51ZRLCczp7RwvRzSOAIAPvHK8wKi
         R2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746613055; x=1747217855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciDEiNxekOZ71CDHOzyxJfwUKXL0VyMYO3FMy/dFpAo=;
        b=SP5Ahuxm/Jn38lnKp2jhuWdqZ5rLx61GvLV3o7dIKfiyctbSC3mAljWMD39l/coFpt
         SGwhB3ybNv+4AUvc7kJ+8y/m8LX5V4M6fmlWfhwp6eYC5+BchFxTI6TGWRC7fDowlhaY
         cXV/ZVMA3h6V8V5eNjG3LT9ATf0j8HgYBPjQCNq8EM+VK/fqoIaFEdMJ8bMfm9j9/O7J
         CfKnn/G5gvQnGtNQ0V7bTZyGNoImN8+g3Br8PeRLU71KI1ZlvsZQ8LSdQNurvR0JETrR
         Vznh1AaK5Y1mzgCKmLbHHiGccN0hMdBnN8mEYnOviAuXArmug03FmjM6HCC2nz3P3whV
         SjpA==
X-Gm-Message-State: AOJu0YxGNgMOxxB58s6UY0aRJRI2gqBEc9zq59ZkHMz6jt0+mgiZKOLd
	13HN51HtqiLXg/8Gb8HJsRxdE5dfWF0A24QSJKWf2XZ7RHetlw2J
X-Gm-Gg: ASbGnctOFSjncnCc0wZRVTJx7fNvhOuRkCn3QCZFcyC2Jhzou3N0RWpX2Okam598t5z
	BLCpSc/8j0ITqse71YRb3T5tlOU47LSF46N1VBJRt3KtjgqXGc7pnsdA82AGagBA7T+0qmplt9g
	YeqcXRt6Wd6KyJWl//6SN8FM5diYUvge5RsMNLyUIVqiqhkypkWymhrrhTYLoHAMFene98ZY1L2
	bJWCMbPvrUhzcuIK92IFB9hL5altRPLUiQRZwH0Jw3d4URhVhpUhnjNdHXiDIEBSNdrWKAa6pGZ
	6WbDj0pFnQ8ijdAXJLVdtAyxWeiOqidnxEDxODJ47PsAMv5TuQOLmKNvhIc=
X-Google-Smtp-Source: AGHT+IEGwiULJ3OYQRuPHdMZx7iUu6T4iGJdDsQzBQUN1VKOPNi22GYAs1mZcXGsbbQvQwsCkXvbWw==
X-Received: by 2002:a05:6000:1846:b0:3a0:8707:dad6 with SMTP id ffacd0b85a97d-3a0b4a02947mr2141244f8f.3.1746613054996;
        Wed, 07 May 2025 03:17:34 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b05334e0sm4349761f8f.43.2025.05.07.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 03:17:34 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
Date: Wed, 7 May 2025 11:17:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
To: Li Chen <me@linux.beauty>, Junio C Hamano <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
 <xmqqv7qdk3yl.fsf@gitster.g>
 <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
Content-Language: en-US
In-Reply-To: <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 07/05/2025 07:46, Li Chen wrote:
> 
> Some projects require every commit to carry a Reviewed-by: line
> for accountability, much like the kernel requires Signed-off-by:.
> A first‑class option keeps that workflow “out of the box”; otherwise
> people need to define an alias such as
> 
> [alias]
>      rbr = rebase --trailer "Reviewed-by: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
> 
> which is functional but less convenient.
> 
> I would appreciate your further thoughts on whether a dedicated
> flag(--reviewby) is acceptable, or whether we should drop it and rely solely on
> the generic --trailer interface.

I think adding support for --trailer is a good idea and if we do that we 
don't need --reviewby. The existence and implementation of --signoff is 
largely a historical artifact - I'm not sure we'd make the same choices 
if we were thinking about adding it today. Different projects have 
different requirements and I don't think it is sensible to add a new 
option catering to the different demands of each project.

I'll take a proper look at the second patch tomorrow.

Best Wishes

Phillip

> Thanks again for the review.
> 
> Regards,
> Li
> 

