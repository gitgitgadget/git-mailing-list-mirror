Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47221B191
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407722; cv=pass; b=IgWeM7pRo4kq4/s3SuxVq3WfGPGbSiKDUaEYg3lRf5J4o59bID3BShkGu84TnEMEDXDdKbNdwpx4tMzmULue6oVpmoR3vgmvBcjxN/XOsDoPT5R9PjC8aUT4u2RBirjfj1jYKpNrQ/hFBnDxQX5tHD+v03BRDm+jhq00JPnOaY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407722; c=relaxed/simple;
	bh=5PcWYB+aZtJQ5bWADh2wBwrz0eWS9b8OcAqZZYgdThY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pw5Li1qJYPgoJMtlGT76AqjZa/vbe8kBcnfQnKtK6nEGLFDe8iQMcyR+vIfRSAi4j6o+FhZ6Bq+V1w+5W+xodkLXk2k2ZlJpuNNgqjSX5MuogaMPjt79R9HJ0KfpH5HsqRGYWYsPlDskzH2U096FMCJ0xnm/JWUNXtxv+guMExY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMqsrQBk; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMqsrQBk"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec4639953dso445288266b.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407720; cv=none;
        d=google.com; s=arc-20240605;
        b=AQOEHHbK81t4n8EfREm1130S3x0fOHW6sS39aBLSN+H1uCjHQ6lC9ro2gnwImGB2WA
         Bq1o8ehh8rnIUTy1yizw1cIoCpq3XMCMW3+CW2fFOK3QPYf5KNR3JpA+nAyhJwwhAOp8
         bzgPEU0YRY8lMG3DwOGCwBUgYNfQ6RgTHf8j24qqSI3ugifkjtlbwOkZ4fGA8QN8Nmeo
         GrETd+bTiZVqMPhekuhq7Caeo6PIs5E3jS1j2N5r+P1peAQpSmVjrJ0RTAGcKo1esqrL
         tvOyuBMOXGM1pbfnHKSfRWoql7oRxb4HuuDFjeOYBpY9J9qEp8PaxV26XGHPWIHZOGIo
         RRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5PcWYB+aZtJQ5bWADh2wBwrz0eWS9b8OcAqZZYgdThY=;
        fh=eFQj2ZRoAzTdMnuu7P3q39Tt6Xb7gnoUcj9EhHa2x9o=;
        b=QxFv7FBsqtGY0oj1xaY25yGf/G0f9Kba4kfoCe7yF28ODTAqlvg6Nf3+U0Uw+vAvqy
         NsBIFuH08TO3YIlV+r4eQ0LoK03Ty4Wa2nC3mogiTUO5cJZZgqezk1eP3XaQC4aOtDhR
         Va6KYenPb/aetct8Ect3s9NcaLBQqa6cloQitbkGOsUj6iqgsaAdTbFVwk+JB1xLhYQi
         jeIYgXQRXf1OE2TvnfkJaLdRlpeVg8+Wn/MVW55AXl/uaV6SGhKUNT8Snn9Xp6J4/OIX
         J5I1fVwY7RjxJqPqZ8aiTwnla86rGi1hRJEKqxXNavGnhkBgkP1llzqkUgXpASV9Vv/s
         6OZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407720; x=1781012520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PcWYB+aZtJQ5bWADh2wBwrz0eWS9b8OcAqZZYgdThY=;
        b=MMqsrQBkKc5mRFfJ3xSfD/4WgRut4bhLkpyIA3qYZTl+APeRpGNHx9hglHPIPfE+jy
         eGKvpPlYsJFN0RpscVNQ8f20bBL3vTcjc1XJ39DH1gnasnEMExdRUf42JmhgjjT8ebzm
         wvxX5EBZCsy4Eu6HrEo3UWaj/uHl3bPzOWc0PVhldRDj7zwgsgLcE+M2ff8Zjy3beRKA
         SJOgCwyEBqXTOs6ly9x1YcIQtN8ZaBWysZ3CKUn8J1H5JpkVdDGbEKhgPPIkI+6T0Lqr
         2vUiiXuKQl30BRHnyIJbqoOiw2Oo7kVuH+sxfQCwvgKAQ9kMzRTqEngGoqpi+Qbc4cl7
         0L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407720; x=1781012520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PcWYB+aZtJQ5bWADh2wBwrz0eWS9b8OcAqZZYgdThY=;
        b=SrJ0PeeLEEB+QjNkVgEg55tCOaGhpfD82L8PLQUabECL1a46kfc5RjEY5MRJOcYvx8
         sUcpv5LbK9P2NtoXW7a9X2J1/sU/QrMb4z+0H5EOt3+wROzUwDmhhi9ew2rcsx40oIEk
         u65ewuRGfV8FaSxNl88qsaD9KkW6M9BL+4/rh1ExuzkPL1ftxlDVVQChUTAQ3CG13DP9
         A0hUfPA0YrXHL1u1FKOLIuoLpl7zWITYiQAl2EfdadxmtJAbY8aOjtpBFVEbonX184Gt
         ZqqNpAOPDPc1HB02xX+zvzKn/Mw4hkdvYW3ODk9Ei2SExODG39v4miTBr4mdSkdFMyCP
         2fEA==
X-Forwarded-Encrypted: i=1; AFNElJ8KJqGQnFZHyE7hLVWtZlpEq6SobJ0xwwTIRuKARn0MHlDOJeDxaXIH//+bdrrzaUjZdHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqc26NoLJrVC5JAjHftMIduboRlqE8hGmXtJxFdp5CFYBQvvi
	oSggO+hInIJXc3quuNYu/9J5fjQTpniwfaxob9edt/6CjH7ccLe2wv8R0PsiqlC1pOqlWU0OyMT
	FfOpn3yqaORDYC/DLWS9iONyhgPAG+TU=
X-Gm-Gg: Acq92OFe0/IoQzg/HPHZX13VSUupNWlxL/R3zLYBpEM71v1epNOw8i/XPKkYzBrXfYI
	UpcueFeIteE5X3VhiVXOzLUvDsW1x01ABivrcmCdU1JOIy168H1x6RtIlCVLzRJk+LM2ZrI01IU
	LPwiYkdwOW9yo49/7+Z6Puo8UhAZNKuwq6nC3piuebERau2ncgUFPrDK6dIxKh9r35bHWUxBUDR
	cy3yo+HHrTRB53gU0kvJPvjmL4HEnni22ybU4ur3fWcbrW6ALsOd7a9I5CPe08CeIzZLp5n0Tpf
	QlE/BD/s3tntbIVQUw==
X-Received: by 2002:a17:907:25c4:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-beab13b7517mr951579166b.17.1780407719963; Tue, 02 Jun 2026
 06:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
 <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com> <9b44d867-219a-4ca3-b8ae-67fdac1c72f6@gmail.com>
In-Reply-To: <9b44d867-219a-4ca3-b8ae-67fdac1c72f6@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 2 Jun 2026 15:41:23 +0200
X-Gm-Features: AVHnY4JOogA2_JcE2B06mrOp5ZUCrwfcrT7j4DlSzKJpPAvVqKZYCIKjdmLK3M4
Message-ID: <CAHwyqnVL=PSCpH2s5RS5kzEo9FXmmjc0n4Oc_ztg3=uhP+-Z8w@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] branch: prune-merged
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> Hi Harald
>
> Just a quick note to say I've not forgotten about this, hopefully I
> should have time to review it later in the week now I'm back on the list.
>
> Thanks
>
> Phillip

Great to hear! Thanks!


Harald
