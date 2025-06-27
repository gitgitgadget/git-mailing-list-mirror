Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE5CA6F
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750988493; cv=none; b=qpsiez+Np2xewkPM6MV31vqwPh6c+ZgVs8d2jDVTDvePiY1ZOt2BzNU4rNptKs9N+hTJHO9MKf3aLEs4jEoAlOFnXDqUigxlMkGgkgvl8Oh6r/c1CbI5I8UkVNxtKyKyNE2eNz3JdJ2ny3qsebpW3rnecl0jaL/ial8k7EQDVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750988493; c=relaxed/simple;
	bh=Q024l0G6PsyDRt/mTYqDDXPFAMEPy/kqmSRzUUAAUEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=brvx0v9YHuFq2rB5Wcl+XPMrIl5aNU9SjrQMTy2LSFBYvBy0I4AxCsWxyryFSdquYx6vy/n37HwXFGYkKDVL5zSF0IyDE5igL/N886aCzszR97GubB8XChqFaIf8+lAacChIYG94uC45oWPZU4riwc2VXvtRQCBeEuVpS2HNdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnSM6emA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnSM6emA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso1669665b3a.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750988491; x=1751593291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bB3aGc+jCR2t9Tn1cYfQBNJhmndm7een8RySHMNxUSg=;
        b=AnSM6emAFc9N1M1BIQnHi7RfUxfWgecVRdELJJdLqG+SOuM8ZP5M29Mal91lZQOsHm
         My7yr+Nvwk4YI419zupYkiecuDtbCeOxOLmXXu1A/p3dEy7Vbj0mhSvkY6ra/liCaNCN
         t0mDKoAV/zq9x/BGtcTz32Nndtcm3oJe5JvhaFKTT3gkDptdhBspXbqSRsojrIekh9kp
         Xq/8m+msPcu8WHyGK+NKxre/EeaVExXTreBzmQEqX3J55ZKPohnprkwrOaAImnxYDJKj
         X5A85f+vtH3yNdBxYqrVyFUeTUDahAGOg9Pt+MM6F4g/b1ifPVTsP58okoXXRoDCEa3L
         Gjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750988491; x=1751593291;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bB3aGc+jCR2t9Tn1cYfQBNJhmndm7een8RySHMNxUSg=;
        b=JDWICmVAkid012DdzPzhDVfpUkxNogOii7gQJX0m561oAL9jvDGM5ivnr7KrCnmCcr
         sykHZp1bHAhz+jZWla2b3jfi4KPHPeE8Wa+DNfqTtVND2KSPUn8NavfvsbWH218D+fPc
         TkLk1N2bUdHpLcK5/prdblMooeXLT27isxe1+SVq8v1EB2iUOOWxELQ8ch1tHiT6GqUx
         qUQF83klE7FNhLQ9pd2qwbnlKG9s+G98fLLaUgAyC83Appc8OxvfzXk77FtlW7WlPK55
         u/FvC5IgT4bwGAaGwSN63I9+IhnsikxhC8OTzx852j4y1YK/CPxnCuhL28SvzNDVBCtG
         mSDw==
X-Gm-Message-State: AOJu0YydKy54sE2Gwac9Gy3qqGuJgGlmUuN9zggXsgURn9UvZzY9Nu3c
	PDxpy0J3ZtAqbNzZXmiNUHuJAJz5F5U8M6Hvk32gEycTT6hNdnXQLbFm
X-Gm-Gg: ASbGncvmlerO5bHsKRpfvrqyF1DEodLX8VdRYF4sX7LJt0194l6in4M3rOUB2V1ebNH
	R943NLRENflgwMVN+kq6yuTAKo/EsqmPv1BYvCm60XUIa+YSfkYH/DZEiDxL0tJJinYSez2LKcb
	Uc0HtCzciux7t/K2+83Ychzf6/ocvtnXHlO6vUA7fDmCEeGFF1el8oqlMGJUplIo26r7yjGR1Ub
	HmTEq4PJ8hgnJsCpZtPOHU9T8LMb9ul2kGzFX8aXH8jaIND5bkXe9YI7ew+MU7B2ZqpTCDa+mPy
	1FnHt8rMVXbAPJ+NMOiysZoBpzSVqezAMoxvjGcJKWKqkfmd9RwxbDEq8tRiL30YEYy/OQ9n3QA
	mIgHwCO6jIRGy8lDkUtIdHXvEsE8=
X-Google-Smtp-Source: AGHT+IGQl1zYYIcbf/KTxTSdS/0rfWv3zdLWlS+e6LhpRdIHIyqpwHob8Lf6eVnW1wT7imMoZ1nMYg==
X-Received: by 2002:a05:6a21:9187:b0:201:85f4:ad07 with SMTP id adf61e73a8af0-220a180b390mr1612471637.33.1750988491447;
        Thu, 26 Jun 2025 18:41:31 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af540b389sm959144b3a.35.2025.06.26.18.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 18:41:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/4] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <ae1ca6bb2b258fc3c18c627aed2159dbb8f8c268.1750927989.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Thu, 26
	Jun 2025 08:53:05 +0000")
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<ae1ca6bb2b258fc3c18c627aed2159dbb8f8c268.1750927989.git.gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 18:41:30 -0700
Message-ID: <xmqq4iw29d11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
> +	AC_COMPILE_IFELSE(
> +		[AC_LANG_PROGRAM([#include <signal.h>], [[
> +			#ifdef SA_RESTART
> +			restartable signals supported
> +			#endif

So, where SA_RESTART is defined, we fail the compilation.

> +		]])],[
> +			ac_cv_siginterrupt=no
> +			NO_RESTARTABLE_SIGNALS=UnfortunatelyYes

As this is IFELSE, we know the condition that did not fail the
compilation is where we did not see SA_RESTART.  So we set the
NO_RESTARTABLE_SIGNALS=UnfortunatelyYes, which makes sense.

> +		], [ac_cv_siginterrupt=yes]
> +	)
> +])
> +GIT_CONF_SUBST([NO_RESTARTABLE_SIGNALS])

It is curious that throughout the two renames, the cached variable
used by autoconf hasn't changed its name.  Is it because it is
totally invisible to the end-users/builders?
