Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782010979
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705781703; cv=none; b=BQ6U0vgCsoIvCq0rRgUC+vyNkUYnCZztwkLPYzEZIL190IuU030qYRuFmZApvOOvaxv7VhgDTTfRtym6pfkm3ztqZPaMIIaByeGkrVacYT+UCFapEv+SwD4a2nYwE+SBurVIK9xQnfR8Ha3tBuYJeJ4hMbCHhMr8VWDf05+Vpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705781703; c=relaxed/simple;
	bh=f41KkolZF4FSrhImr97j4yw4Hq/QNbUgTHdIYu8HKSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpT4JpzaH5aw9+UgDFxfzfoj2TNgxfxWTIkuPq9hUB2O7wF6RhqK9SDf1dlrxHdaj/9uqti9OZbrsWDMEvzZGhX9ySwc7xbkRKgOqIRnR/ZCLQzpeIxv8eVAH90r8KfpIVN25XG81FltyD/t7LyL1RoDfMedZM1g7URPAwd3udY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJmgyIED; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJmgyIED"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf4b3bb305so1922834a12.1
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705781701; x=1706386501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ3cI+mdBYRphE+CtdMR8AYAP9kW59TM+P9TMBxA8Wc=;
        b=lJmgyIEDv5hhmcFxkeOxYXjYWG1ULW6RTNOj7ecX/MKWQ2WVM/tpeWJHPGLp95l5Zp
         JlDYVx8M1c349MnF6MxWYYdzJWQsJgleUI1tTfNFIKa0TF/hKHB0RVbeSKQOogLro8xx
         iUDgjIRGFVPot61ppPKNavxoyVSX7y/xdNwdXbNTiGq+TlNllK89Mi5tuj45sHrJ9ikM
         Ef/DR/5R4JnNEDrBUHpUm3M8nEw3sQW5P5BzpuZC7Kzw6ii92Fq8EFKIgOdH8lOh7Mwd
         r/ORNPCU1CVQBVBYfXPF3kKejti50YJLYdtbQ8Pm9btzZQPcP0Qu0HSsexRaMwcS3C7P
         ICoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705781701; x=1706386501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ3cI+mdBYRphE+CtdMR8AYAP9kW59TM+P9TMBxA8Wc=;
        b=q78XZsnzDbXXGFAp8aEZWkVvckYMGhzPXCtNgrU/TDMiuJj5evnGqmVMrEi4992RY3
         nElA6csIsUeKaKAYP2KT6jSiUt4dB2muwcQ/dB0mbdKjmpOjQZ4QFsQCrHIsejg/lIvY
         5zbAvY9fbBFOFNqCXMyqwFezddR9E2rDcjYD2RzoigB9ghf4reh1zCsfFfr6fZtif8K5
         Bm913FYcSvPljqTO0OhxzKzI0y4IuA7QNCQx/Fpu4HYP7/6Fx55tiAE0VL/Gspkh3h3k
         HxiMEN7v+IDgpbrpz4ep1eUw99ELFnmKE/frCcmNXGRZQxIB6vTD5qnggRNyHRI3IvL9
         Zo1g==
X-Gm-Message-State: AOJu0YxWDO0LK27EcakoBU79QXftZ7QVC5ii0oiZxcSB9uGREgIo1Dfz
	bClrJQpS7dGBIC8MR0KKdFjkZbP7QeFKCEyVkccn3FaYQD0x+3/lV0UvjW7bg1WhGgLw0bWSSFV
	kGw==
X-Google-Smtp-Source: AGHT+IGQdriKyC8ly50sjzJmToCYrhA159K/xMUyR943l7k/R4uuppHqMwcg3Cpkuoa2wHySYMBoXQkDf18=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:f0e:0:b0:5cd:fe3e:e66 with SMTP id
 e14-20020a630f0e000000b005cdfe3e0e66mr10276pgl.0.1705781701470; Sat, 20 Jan
 2024 12:15:01 -0800 (PST)
Date: Sat, 20 Jan 2024 12:14:59 -0800
In-Reply-To: <xmqqo7dim8dz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <8a99d0fca21eca41d62dcd682c8b4ae545633bf7.1704869487.git.gitgitgadget@gmail.com>
 <xmqqo7dim8dz.fsf@gitster.g>
Message-ID: <owlyfryrhid8.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 09/10] trailer: move arg handling to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/trailer.c b/trailer.c
>> index e2d541372a3..0a86e0d5afa 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -66,6 +66,11 @@ static LIST_HEAD(conf_head);
>>  
>>  static char *separators = ":";
>>  
>> +const char *default_separators(void)
>> +{
>> +	return separators;
>> +}
>
> This allows API users to peek into the current set of separator
> bytes (either the default ":" or specified by the configuration
> varaible "trailer.separators"), which is an improvement over
> directly exposing the "separators" variable, but in a longer term,
> do we need to have some "trailer context" object that holds this
> and possibly other global variables like this?

Yes, and I've implemented a "trailer_subsystem_conf" struct to hold all
configuration-related bits (and hardcoded defaults) relating to trailers
in one place, in the larger series.

> I do not demand such further abstraction in this series, but I'd
> prefer to see if we all have shared vision into the future.

Makes sense. Thanks.
