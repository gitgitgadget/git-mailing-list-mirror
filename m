Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C01EFFB7
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766763806; cv=none; b=kzAnWvW+xkyKc0cEqcpFP6XsaW2et0W/W2n5xpYWTmWoIeMIwNJ1/jkit83Krj79NANbV3R6U91seVrdkhwluslv//v/kFpuwW+aBxVilNNAqF3eD5P/0mvAP7/YR1BpizPpw0hpWZTuYbzFsp8IPrlW2l+AwPCGSWXKt5iENF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766763806; c=relaxed/simple;
	bh=llUIWs7s3YVwomMMDMXpGe4T59jaNETOV5phjoKrIcE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=so1uJAAOHAjJLy6900738oShUdtc5c19vA7T5t/FAB++OfhVg5xGN9sLKPeEiLMiMd6Y2Nad2s0vizuxWqbIVTJKLpqGSiDZ1wx3xQt5xkeB7TL52PNkWv5qNWiywnaP5i8GZNU4BN+DiDI+Q+PUNdFBY8Mr1xiopLO8MSdV49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNx2sfav; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNx2sfav"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b983fbd45so56620531fa.3
        for <git@vger.kernel.org>; Fri, 26 Dec 2025 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766763803; x=1767368603; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulopfqEH3U9DoDxKnqGLsKrLPG4DWpc1Dap5v2PzMGw=;
        b=iNx2sfavE02aKisItpYXRqUox8KGtqraN/ZDJQ742HS5HfDGzhQwkIahhKqewF+q/k
         oGmRZZC5XVuog30eL4/HHX4pXzeirh/Bs6gjfT26Pr6GQGJ/c1IrK6RCd87Lf7N5ryLX
         tlWEbE+V80yf93tDT1NW2pNiPqA7TJrkOwovUMzBA/aRJwbvllSltWt6MqWTR8+sks3C
         t7JBdVmcw0FSv0pVNgSc4IJoqTFFM+MWAAvwEuB2B88O1pvFQF44UwOlTw33uPaPUNx5
         ckitFpAJtMECQWtNqtVTSjo6MntD6xhgfO6XJLQ0ANTqvrl6EYvmcCNo9etg1fLsvJJB
         CR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766763803; x=1767368603;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ulopfqEH3U9DoDxKnqGLsKrLPG4DWpc1Dap5v2PzMGw=;
        b=R4gUGy2WVAKTZBnNXbpGqV/wsqdFP4IOtjBsyALcA+3Mu0C0/cms+TojQdhWaoW5GM
         wTKfwpOP8ZpPPDtOvqFrT/UegzXsKKux1RkA+1YLmD7/2ek6woeyg5EQKyrJg4QHTm+Y
         yi8RYhdGZwG8pQTq/9y8per8qceUEMfiNDnTShmk88UigDOdwGGyp6MkOUkZSHJN6mJj
         iVSE3ejvy1aRAGPSex1teJFdD7NCODyG+ZuNKz9L2fajmM8Bj9vAyQRWw3G4T2cI5U57
         ALUjnrTI5FCtkI6Sd7mMXAaVasPuJL/Abg/6Ybp+AYL+D0i+/7wdri4EORqLnN4jqy9L
         MsRA==
X-Gm-Message-State: AOJu0YycedNJQgxM6IRrf/4+l0j8y5bJ4ce+iS1I9FRZrvH6RprvgT5U
	50JjGtViHHDDLWSOGIYiYhWrN+WuzXwzZ+2r12m5qxWfwOJ+cWU6/aE0L/BBDf28
X-Gm-Gg: AY/fxX7VAsLCwpeB3wKF8ZuZ633MEi9jWp2eZ60V7O9BcVr/d802hTZ9XFbDOVdJwgT
	HooSHr6X/oFjN0ThQPT4Dlzk6B1M3GcRQLyb78lFDR0RyGeClRrSFhMGLWelaepyHEBiT9ZXPzn
	wGI6Vj0uCWYV4d/8nfnN2KaghD5v0nQmABu+qiyxT5THiYvtmpOHqdEPzoc3V609LAlyZl6g+xU
	ELPBXs7lRAGgsLqJOGG+HhiDsrLJpQvZfv/lIe81Ef290G7C9A/N6bsmtefoU+j6IxZy5kUWDoI
	OAhxSM7O2o7Rl1j2guHIwCLu57b5lJe0Gc8f3kXYQXbkCT9Z96BIA8yotg5Q++DY7Ccixwdk2bG
	NqZVd4CcPCqzqrPy9PjQOXTGf54JpFmOhbYf+31Rb1ZHaI8bGB0mnXEpuHa66PCOXdb7hsoZB9a
	jQcR+MtSFgvSY1rg==
X-Google-Smtp-Source: AGHT+IHQKv6WSNfUnlb/5es8hMhWm4IsT6rZvT6FVXi1NdfXbAfIvGr3x+HTEzLhaKo4uLS4b2Rn/w==
X-Received: by 2002:a2e:ac13:0:b0:37f:cb34:211b with SMTP id 38308e7fff4ca-381215ab664mr62716831fa.18.1766763802747;
        Fri, 26 Dec 2025 07:43:22 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b3aesm58867771fa.32.2025.12.26.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 07:43:22 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Why git branch --show-current ignores -v?
References: <87h5tev918.fsf@osv.gnss.ru> <xmqq8qeqm1tp.fsf@gitster.g>
Date: Fri, 26 Dec 2025 18:43:22 +0300
In-Reply-To: <xmqq8qeqm1tp.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	26 Dec 2025 11:09:06 +0900")
Message-ID: <871pkh8d0l.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> It looks useful and natural for "git branch --show-current -v[v]" to
>> verbosely describe current branch, similar to what --list does. Is there
>> sound reason why -v is not supported by --show-current?
>

[...]

> I do not think anybody terribly objects if somebody teaches "-v" to
> make "git branch --show-current" more verbose, and other "--list"
> operations in general, but I suspect that the exact contents in the
> verbose output may have to be different from that of "--list".  For
> one thing, as "--show-current" limits its output to the current
> branch, the two-place indent "git branch --list" gives its output is
> not there, and "-v" would probably not want to add it.

Yep, I didn't mean to suggest exactly the same format and contents,
though just reproducing the --list won't hurt either.

The actual use-case was to quickly figure the upstream branch and
relative status of the current one, and

    git br --show-current -vv

just looked more natural for the job at hand than something like

    git br -lvv master

that besides is not exactly the same, and then the following one is
kinda overkill for manual use)))

    git br -lvv `git br --show-current`

That suddenly gets me to why Git has no synonym for the current branch
in the first place? No @HEAD or @@?

   git br -lvv @@

is pretty-looking perl'y that unfortunately doesn't work.

Thanks,
Sergey Organov
