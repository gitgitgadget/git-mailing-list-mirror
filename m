Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA503381C7
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421974; cv=none; b=aWEqbLJJC9WHemTEjkz91xUAfPwOP2Tsp7r03aJUTNt5GmG1jYbhUr2FPQ27SWUu4mEwLPoSTPxtN7cF62VacXrZEbe0ggzzRTmNAvq/S24XgUOZFk7EPL5C/Lf5xjIZrYnNoE0Mai5O/JCxe0FVdePyxf5zdR8h8+TcXIuInU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421974; c=relaxed/simple;
	bh=LFu1CZ9bE8y89Gj5hoMLME2rKRbrQQIhrRAJP66YgNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4MrV64fVmITE5YayXhFlP4YcCnmzXq67d/0I/dlVQ/WX7CZvqCwDdkheHA7VnxrXO1isHVet2cr5LCD14pbJn7V4OBwfrDF6Q88LN/8IjjDs6Dffg7ScSG+o+SR0967pCRKiA9svU38R2gmgpxYgFALqKWy7EVZSUtKYZapty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+nJbozD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+nJbozD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so23226666b.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707421971; x=1708026771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqeoYz7JJjhbg3AYSJABZodnHgqRyMolTZxxbuyAbgo=;
        b=v+nJbozDq1t8pnwxQDWexDVz7K2VJZLn20J3MmMgSUGqiB//tS7u8FA1YP6BYZAhzM
         P+RiV9e8ON/cjS7ZRIkL7hsZVdzIT9IWlWV4SiiDYt1Atdgn1G4ohMerg3BkW8QQw2Em
         NpurRTryyW/BN4c7moQ1byDbex0HBInXjse/CAtjlcgVkZi5ePbyusZg77QNLyTK/ao0
         EQjcRGa1EO1yfHOiAshGFomfy3dOwg0Lff7kkrR87PrLIVbOPtuHHSMpLEWP16NdmAtI
         UDiQKb2Dj3yB5Lzar0HlaxS6GVHR+FkffYNel1ABNjd9hHJKL+raGA8tBhNHIoFhUer/
         rn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707421971; x=1708026771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqeoYz7JJjhbg3AYSJABZodnHgqRyMolTZxxbuyAbgo=;
        b=dxKtBf6E3FCfdz9S5OtSiMTeuyaEdDb8LGU8v9pfFlTyA/Lc8AL5PzFH/YHVUw0cJJ
         skhUE4S7U9vgT/ajdJFnrXZk5u6eGlM8YJTuaK1OameSe8i3SXu/KrtBFyKGtgPRrFdD
         3P096/PkzZGaF+KAPusGg0xOn80jOs6L+E5vUkNlS5iSB8ag6xbGinSIwNnuWu68KAHm
         pMSZxF3IMgALhvvsmkKRxv4S/fhR9lxYh6cZmz+LLDcqvZeLNVr4zDGUbL2841azYCa1
         DbFmd5Q9iuNlPR5p7/lRhj/Uvw6rWckKAPbWgaYOGiQmEFPpppz5uGQdeC8+Yn4j4KO5
         MdOQ==
X-Gm-Message-State: AOJu0YwfT50oPXjdqHkLDF6wUCcN3EhuhVxVagHQkk9JZw+QD5sTrWTe
	PQjRDoFm5nCDfiue7WGHuC6DTJt2Gia16Ra40ZHBHFyK1VP5xhuKEk31V5Qn8po4FXSCEZYUqy+
	Ey7UTdFHV0JBdXqYEkgM4lKZKCg0btu/tzgC+
X-Google-Smtp-Source: AGHT+IE+syI92eb+BmHT1H7LF2eBeNxLLUYfvnp/XrZhFcf97xSVnhFaIKFXOKmCuIx688KAnhwKDVAj8ieUHEzlXr0=
X-Received: by 2002:a17:906:b78f:b0:a38:970a:75df with SMTP id
 dt15-20020a170906b78f00b00a38970a75dfmr288805ejb.15.1707421970879; Thu, 08
 Feb 2024 11:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
 <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de> <20240208010040.GB1059751@coredump.intra.peff.net>
 <8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de> <xmqqil2yn3ey.fsf@gitster.g>
In-Reply-To: <xmqqil2yn3ey.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 8 Feb 2024 11:52:35 -0800
Message-ID: <CAO_smVhsKHu0QrvpFbofd7y-Exhnk7=JUzffECNZQx=MWzmnsw@mail.gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>, 
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Chandra Pratap <chandrapratap376@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > But anyway: If NULs are of no concern and we currently end parsing when
> > we see one in all cases, why do we need a _mem function at all?  The
> > original version of the function, find_commit_header(), should suffice.
> > check_nonce() could be run against the NUL-terminated sigcheck.payload
> > and check_cert_push_options() parses an entire strbuf, so there is no
> > risk of out-of-bounds access.
>
> If I recall correctly, the caller that does not pass strlen() as the
> payload length gives a length that is shorter than the buffer, i.e.
> "stop the parsing here, do not get confused into thinking the
> garbage after this point contains useful payload" was the reason why
> we have a separate "len".
>

I just rediscovered that. I think this probably should be something
that caller (check_nonce) implements, then. Having a _mem function
implies to me (though I'm very new to this codebase) that it supports
embedded NULs, but that's not what's happening here.
