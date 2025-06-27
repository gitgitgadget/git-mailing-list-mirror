Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B12E9ED5
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047398; cv=none; b=q6aaRSjvb8M5mgJrMGcMcFqFKG/sCiqFnuSM8frpsYRMxCh9bG9OqX9ZPT2r1jZJ27D6fwTABPfMVSOC+VwMAdqYjkpE/uzwt8i03/uesy7md1OjY8QICZYvU+pvuJHtzY6zD5hSzFyqCCFcwlPYv9P1lagQ2mtryzKyvq117/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047398; c=relaxed/simple;
	bh=fs4EAat2wA5B/1MoLWyB1GPIAEZc9iocL3Ww9cF1asQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+8musP70hwMgp3y4oDk4dBPUUPtSk8++QXCQkHwPSmEJ8aYbEtU8SpCcp2GJW97AWHZT8rMylU/uihu3MrbvOnmD2rlnI4C7R+Ll7kv87rAV9tXlI8MEYFTh9XYsoXci9rDk54yDYtlNdX5pr/HLNeVwSgZMCih7J2O6PkWGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb/WuDAA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb/WuDAA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso257220b3a.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751047395; x=1751652195; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUwBuq15d+16GRrLt5B4HWNTXHTwGE4wQMv1QdBys2I=;
        b=Wb/WuDAA7VCDT1hm30EXWRbYo156Qpa8YDKBZhdsIJSFoCORYpmqOpSDPHfl/4mfLY
         SAIJbhfkDWNARGHgcYkQ3M8ndAkOEhgnXV8gU7Uhn2zhr4Jt7EX/XWLfpygw50vMy6G4
         pKmPLaYaBkj9AxW0aaXSXw6yGeMRfpCK+CJMnYBD+Luknbbbbf1z0tHoWpEmEjeZ8J1U
         qSnXLd9x1m/iHNk5vQIpG3S857pFYT6U32NJdS3Re04fOQIg/9xntthCE2olGnQym3sz
         q8kTfFtuB7yLpB35USig/jrEU4tRbxVEixjFRHbqrz080V7BmcBWR/CtMHAOP8waPRXo
         J5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751047395; x=1751652195;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUwBuq15d+16GRrLt5B4HWNTXHTwGE4wQMv1QdBys2I=;
        b=dLoYma6DatizIZ9Jc4bOeaPsUBft7wneIXZQ576e8ZfRA9FB4RREF5DDTO1HVqDdqr
         1mytMdoaVVU+bEuT7+yIrAM3CoBJElXZQhN1SUemYT3EaDCCbsY3ahHPXYZnTa6f8tpE
         mMXqHmGI7QSf4oswrhgPy6bctuG05fXsOEookuE4jSuytBqiMe8YP3eoFkm7UVYPSBPB
         b+P4dAMxqkgwBp8fcEH6MynOFjrgkzQQqFZ2XBAKUbpnlbBXzTsnZWwFjNG/hiV/J0KN
         wadbCwCAP4yajWsIRZXnO9hYsqyywC/VRUJJohg7+iC2dnP1okzdJOccOGuFjKz5wdXy
         zXPQ==
X-Gm-Message-State: AOJu0YyY5FWwQAYCDTdY3UKyU5AdK52Iq+lAX6n9H17hp4cGmVV60+Z3
	yQ/gTphTg6frrbOsH/oztHKUxRKT6P/552m0Oypjc+jT96Zgx0rGUD25dw5RjA==
X-Gm-Gg: ASbGnctK+aqumSYjQfxlsozqheqJQUsoupxETWSygYLzJWlrCPnYAeC8lGs9OVF0NtE
	I11cJVdqrXQwP9sgscbhCXmMCOu/TRp9fsSrYNGlPJKC2B5doQxzRUySIBCua/XY5an3rK4GSvk
	y/oEfJBW99ZvekcEha+HV1a4fqFqksFTx62ynGF1VAzSnwcWeXc1y6bbXRKFGjC72wLpV54ehg3
	F+aodOaUOOP3d8WzJq2Ux5Ybi0OS4yZWnnhCGV2g3jz0UmrNt31/4xBx2BeIVwQrmSq9/89Hak2
	cL8EGx66OB9nFouEOJx7FpDc27tk90o8sJuog8AJ1IhyyCuie3ej3mDKOord1T5qNQ9FGQjAo4U
	jgkVaTp/Guo7wi4dtmJxgZbegYys=
X-Google-Smtp-Source: AGHT+IEJ3COr4c2On/6dbowOhMDt9LjJdCK5u3JCt+Z21V7Gzq/A+ifpMrgTOfGGVbeDTfS1kHEz4g==
X-Received: by 2002:a17:903:240e:b0:234:f4da:7ecf with SMTP id d9443c01a7336-23ac2d86924mr65361925ad.8.1751047394717;
        Fri, 27 Jun 2025 11:03:14 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c5a97sm21255915ad.220.2025.06.27.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:03:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
In-Reply-To: <20250627074934.1761897-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Fri, 27 Jun 2025 13:19:32 +0530")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
Date: Fri, 27 Jun 2025 11:03:13 -0700
Message-ID: <xmqqh60183ku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

>   - Remove legacy or obscure options that are no longer needed.

Such as?

>   - Add improvements that wouldn't make sense to bolt onto legacy
>     commands.

Such as?

While I agree that there may be cases that the above goals in
general would bring us improvements, I think neither of these two
applies to for-each-ref.  People are using for-each-ref to iterate
over and enumerate refs already, and if you are to add some new
features to "git refs list", they certainly will demand these new
goodies to be added to for-each-ref as well.

So, I dunno.
