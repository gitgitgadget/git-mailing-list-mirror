Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197B1FCC
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924901; cv=none; b=RASNztCSgVv8n9asDqOmSU+U3Cvh4rYw0jq7mcwLvIx0uUr1aMuuRIlNkJDEkpMQVrXH6WnvZ0YjPRtYhvCcAzPBlUfg8CmQote+i7i89rQ/iBkXjo7RieWRhCZgXdLxHTo/X05uGyzgZW4EWHkJ2+KP7s1/darHYT44PGIcjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924901; c=relaxed/simple;
	bh=1y7Re0S60/nxUfGPZdTtJJ6lZPQ6nwdtGTiukNf/l3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKWKQ8qQLwNiMmYL7hOkqpOPFfTuNFrTO+ODuJgAPJJDnWulKNPQdp7dtvBiJR8ymQf9WUU8e8hvAacjGQUeA6xGX5FRUuAxZu9hU+qjG9ostuN+uH0i/26sCq+9q31f3fwOGAOFAWFO/Pnb+9JIYJEgUrW7LN9vLRk2dk2DEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOSNhN4V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOSNhN4V"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29653f86832so620348a91.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924900; x=1707529700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1y7Re0S60/nxUfGPZdTtJJ6lZPQ6nwdtGTiukNf/l3c=;
        b=AOSNhN4VgoxSaiuvpfGA+wPsywEZAyXUL272qTakztY4Bjc8VonDl2bTSRtOz2wGPt
         4EuMFqvG8/yqCLlXYP1qw9WMieiB6FrZGS4WDP8S16P0YCbmfuKtZf9enb4itzOGoN5T
         x/iIrdWlkPjujCmtyU1z/OdYmp6+O+kEuF3NfnJsQiyETbE7QUh2JcBGYOq2nQqvlOFe
         +y8tjVt29Jp8wWro+guI94R4Uo3TS5Tnk5xTZRk7QxlTID5ItUk7Wnute2fc0PVgAqQX
         R1hJ9MpgTs6sz+1KLVwxgMesOqwr5xusLDzuiuPMYx3zXIq++W9fptwmHKM/1BdF9jCJ
         +uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924900; x=1707529700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y7Re0S60/nxUfGPZdTtJJ6lZPQ6nwdtGTiukNf/l3c=;
        b=VTnXVQr4uAE44xacVM8FXAO4SajcZC7sDtB7MmT8GV24dXkQSkcIkiJC+jZBJStV6W
         loLgfiBjTgVw7+UITg/6su5ezgynquFPPq59Ov7rhmeicMyZiVJyOqXz8VINFMACsRdy
         HUCd25lYSnR50bQF9lMxzwiwvue2gnhiPhLop2/GGLPCYd/mXi9ByDQ+WlA4E5nLqtsE
         Ee5C561z4EHza2WYonsuN2Giz8J9N6R/g5InImr33GBdpYpDxy3CYQ6GA78MipJFbtZ+
         tcGPC+QhEo2gZYMi7c0uOW4Lv7knKqayPY0fXFrKcZZhaUDULqw5GxvwdPpZX9x6R0Aw
         huTQ==
X-Gm-Message-State: AOJu0YzqVMAPofVDVmWloJVTlgdwa0pCq9boIv1yS969V1xTVBKoVZz+
	5nf8TNNUuzSWrn0vtKrK4yxA6Iaz/QoZNOMgjqJpEzLy1tqPnzjLVSiKW6CCPXkzORHjOdXldLk
	nkA==
X-Google-Smtp-Source: AGHT+IHEKyvT+vITC7ckm4CM9T8PQkU7TZVxmTkTC23rjTYH4CKN/I14bAi6VBjn20YxHDLJkBOVgU0g6N0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:35c9:b0:296:4d0:5840 with SMTP id
 nb9-20020a17090b35c900b0029604d05840mr9378pjb.4.1706924898808; Fri, 02 Feb
 2024 17:48:18 -0800 (PST)
Date: Fri, 02 Feb 2024 17:48:17 -0800
In-Reply-To: <xmqqttmrx1ro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <465dc51cdcba28d235241021bc52369f6082d329.1706664145.git.gitgitgadget@gmail.com>
 <xmqqttmrx1ro.fsf@gitster.g>
Message-ID: <owly1q9u1foe.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 08/10] trailer: move arg handling to interpret-trailers.c
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> [...]
>
> Other than that, the main thrust of this step seems sensible.
>
> Thanks.

Quick update: I've broken down patches 3 and 4 into smaller pieces, and
am now ready to break this one down, too.

Hopefully sometime over the weekend I'll have some answers ready for the
many good questions you've raised. Thanks.
