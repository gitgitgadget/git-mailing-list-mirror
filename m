Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC42FD7C3
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035784; cv=none; b=YG/BccIx4Dml4Mu2pqY/RL4+uUEND3xOX1pDTBRAMO9phYIi/6FnZgKHujOXntadmsOpcVDMf2dM2k4nT1OrPwWsHEY1O3ds45ePjayXKrHRnYNmkLHEY+BXYlRle/jLWFO/UQMeDVpEYRBGVEPT5/GSXfq0/nkAEzfwDwoT304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035784; c=relaxed/simple;
	bh=Z+0mPiYom1XP091piBTblF0Y0ea5eAguiM2AP+6nZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCKhmYuEaL+fRRD7iYtT0NebKAJpVC/5CVM6m7P1dn5xEM3WkSSm0/7FAYjml8a+7lpIJIqTqEzLkZmlYlWA0e6u+wwHxxYSPNzVf7wOrlh6fkrc0LehVQJMYHhmIwVl1RKNIk6NtQI0DEDnwzPFdFjEW/W+1l2VcsNtRAgn11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUOcx1HF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUOcx1HF"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c160420289bso550526166b.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035781; x=1784640581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knFMkVsrapzI8IkJeQXONTRDByn7cuF2z+qSdfxyigQ=;
        b=GUOcx1HFRguqMEstuJ6tTx5mpHP+IovNIBPqZx8+siqR/FESCB+zGA3b90ah9QhXFe
         QB2AFj+61aP4GMCWjKvpQF+iF7EVwMMv5VKCaKzgk1WOnIceN+o2drNsEoEDQe476VTr
         HoFy1nRpS3fhGhFQQe8G0qY7FkN5XjTKLH2vrXqiSt1XRslgZ6JNVe8Z8kQ7NIp8KuIo
         Tockzy58mvxo2cQox5HPtPCdntRW5S+0eHdRCJbPcr+XB6LDIuNLHmWYAzQ0pBihrf8a
         Sk8j6fdSNFlYzaL7rtor2USPRKrfmNfvSg15YWuLm/hwT1wO5n4hIHLz81ny+YlVDfs5
         eEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035781; x=1784640581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knFMkVsrapzI8IkJeQXONTRDByn7cuF2z+qSdfxyigQ=;
        b=GZvZYzO6ZBgS6HwruQHs1MSuHsSm0PQBhCX8mwYC4kDIvUE14unCAiMHjOorlUQBoc
         +sd6s8aUPKtHXg8usX3fXS4tpqHZwwX+clDYdsvvcACracpslQ77K2kmpRbcaL+3N8M4
         IcnI5fI9gm2fWiyHCvzKFd5PX1OB+nXkz7fGWpb/Wod+bpSSgIvx7lMUWrm6Ek/cLdiD
         /Rgho5odkey4z+JJBtreivKumbD69gzIP2jyW3vqTM1lq+/W7sygqLrVHpHhem5qa+54
         g3jJ5KyA74Td0qVfnS3CL4vNUqnmNqmvrZ/uRbt70qzSQsFCd0b350tvc0t6v8imgdNV
         0J0w==
X-Forwarded-Encrypted: i=1; AHgh+RqlpzVVEWcpmGPgEVsDb6J7d/np0rhzwlDgD+laHHLydw5yS+JshSMR0X//hdhz0f19Exs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmem1AGKZaTxxKeruV9mmzq9E3CUf19Jxb4UrtfE7hH0P0NEV+
	DTsQfKK1VU5gneHvAQY/Iq8s7NLbAvjdeBN5UMl6POBuXQ1vWKP57L/3
X-Gm-Gg: AfdE7cnUlX4yODx88Ct3O1VmljUNsvNH9u8My5YUaO2666nHyNE21//YurJkCowKJwJ
	Ivb5e5at0scZhvbQFq5DO1L0GadXey5hr5aBhBPp1f30JWnWmjzedsCBB0IuQif49IkgaSY7km/
	pamhx2Y44duMgzB+Rva1MfEzSuVBiDTkthc8GC/+5H/Y2pIyfZReTncsssd0ZKrYo8VI7qYDugi
	WyquFyoONSw4dgQjwjSTgIq3S6hZnUooRd8ROWH7H9O4I4PpP8hLNj3UAXOqZiilsIvuBTXFLly
	cMgIkDgumOqxup3Cxl/nxgtDiBNwHNw8Uwjykn6izUX9VtBM0JVEOHmHHdlE5awaGRzkSozrBI/
	QtTC1/ZVJZEl0pYcpBlLMkzGb9jqTJ4FIEZ1i/xL/P+C0qkXzFOLWZs/5bxRlJ6rqrGlP+ZgZO2
	TAVWGHPEYIv7SOHiYr5ExWTksEVxAIylOA9gQuySZyLZzvLvAIL2IsitCUBeptPQ1W8ZvuCD3xc
	7L4PeG0/ffQerg7eLS6nNKd2DukyQ==
X-Received: by 2002:a17:906:c14f:b0:c16:5ae4:77a3 with SMTP id a640c23a62f3a-c1667a11420mr155535566b.25.1784035781011;
        Tue, 14 Jul 2026 06:29:41 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15fd50d411sm670767366b.37.2026.07.14.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:29:40 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	git@vger.kernel.org,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/2] fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal
Date: Tue, 14 Jul 2026 16:29:39 +0300
Message-ID: <20260714132939.3368732-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqmrvybi5t.fsf@gitster.g>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com> <20260710122655.3066377-3-paulius.zaleckas@gmail.com> <xmqqmrvybi5t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Don't we want to pass down not just
> --submodule-error=warn but --submodule-error=fail if that is what
> was given from the command line?  Or does it not matter because fail
> is the default?

Good catch, it does matter: the per-remote children of "fetch --all"
re-read the repository configuration, so a configured warn silently
won over an explicit --submodule-errors=fail.

Fixed in v4 by forwarding the resolved value whenever it was set
explicitly, in either direction; when nothing is set, nothing is
forwarded.  Added a test.

Thanks.
