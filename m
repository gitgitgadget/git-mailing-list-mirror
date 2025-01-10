Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF08204C11
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508825; cv=none; b=AW+4bijyz7PHH+COx4qzT3ouHUquk4EWTGY+cEbNFCxD2NDzVX1HovFh+2lsG291NTZUqOzvw4qJ9yB1t9BbfBntC9P7Nac4XvuLh1Q4v7tptB6qtHhEP1ZJSnLEI8Zgjs5qpcIhFs784PnNoK5jLk3GYb6msJXwr+5fXI8v9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508825; c=relaxed/simple;
	bh=Y30wfVieL0H4ZmAkHzvdGa98mSPD/j0Ig181W8yoS/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6zlKLSrNNgUTwfcOavCDjtFDD4ElVqrHpmrdN4MhG5aro3VTLRMfj0PKSflb4CeAoluteu80O1q/vVu+0ZkmmGWj5clb455bGK0vV/ayjJwM0wbLvnZYey1FBwgu3eM36YFNuQeAZ0IgEwzmxIP8oIkbDi4MeT1torCixzeZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvbBaBaX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvbBaBaX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso2541466a12.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736508821; x=1737113621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y30wfVieL0H4ZmAkHzvdGa98mSPD/j0Ig181W8yoS/Y=;
        b=VvbBaBaX3pjXM9nQr7NNsWGLHXiZTiqw8/DM/P1S2gpfPs2ALtJDwIgRwrfWqc620b
         QCAo6CQtRXsFXVQeU6gX0bIX4j1izh/VULi+8pS3UeKJ0JzJovfpIltQaV55mJFH+Ghp
         cCXN2n8e6FvmXyqUBWXMUhjt2mmATggZVS8HrlCwErMtN9YRW3n3wDt2DwmzZg+ylfCk
         0unI39Bnf+LToX60um/vFaxUrUU6mBI2AAvI28zeqCO03nBYHCqe+N+132mImbbSZlyW
         M3Sodu0eM/XJaUty0y9bNIUYSUuA/NPub3aRSvDaZsqpBKpJNC9bAaAsi877gR7R6kWg
         hB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736508821; x=1737113621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y30wfVieL0H4ZmAkHzvdGa98mSPD/j0Ig181W8yoS/Y=;
        b=p3O4sq6QVExWz5/XKKskcuu6aGPivU5Ok/jRZjdibdmv9cJ1LIXut9MdimHlsQf7xt
         b8tbYIEUTDXZPMR0s8qTe/OPfrdHezQd1Jr117e8i5PbSRUij8CULQBOgJzbsr9Hr2I+
         r6GzWrRvGhNPYUnRF1FXYpTF0/+r85gjVZ5UWrlXHo2jtuCrKwO1EptABxrgh56X1TTW
         mO41o1GLIxJNBpDYDfuhA29jcChqIgSY0krGUXGmsKSScEKpKU9my51gqgmUi0kkM5C6
         2MxzYmHUNiAJLlzvbiShSc2jXuZYT3R+/MpbdLN1FlvqNkEfzEIt54Jxe9YI9/aDxssz
         5Bpg==
X-Gm-Message-State: AOJu0YwfZOYLfP/e2IxILb7DHPjg5gbopXV7oKHkq6aSGXBZx1ByyjV9
	9s/iNA46SWyhSvXjdk8uFh8pZYaiQP9eOdMTMceccC7h6MDdfsGFjTumqZI+Pu1lmd82jKcrxot
	NQXPt73iDB/30HjXecqKOmBMxt80=
X-Gm-Gg: ASbGncvpX1pkhEputE7o+E3gOyiul35x74HKNRDfhxxGJwRQv+SQ2XCVqB+iale0Nf4
	IaQ9reCb+clRL6Rz2lwmaGOjXPfhUZFdAFI9QcmMs
X-Google-Smtp-Source: AGHT+IF7KYi9AtV0J8MbnFLhZPbg39tV1miWOP+Opw0jj7QBLxDjGBSndsoHMEPOFFiNSgWe0I5vLd/DzVEMJECLFNI=
X-Received: by 2002:a05:6402:278f:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d972e085d7mr9343888a12.14.1736508821310; Fri, 10 Jan 2025
 03:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-2-eric.peijian@gmail.com>
In-Reply-To: <20250108183740.67022-2-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Jan 2025 12:33:29 +0100
X-Gm-Features: AbW1kvb7M43FVr6ioKZJPDjzrb1nlQnergCjroXNSz6afE4a3CxfJ3QsvpIJ3mU
Message-ID: <CAP8UFD1CoaEzqoCN+_6_qPk_5scf3mhvpCRrsuxc1K=ZObUgiA@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] git-compat-util: add strtoul_ul() with error handling
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wro=
te:

> +// Converts a string to an unsigned long using the standard library's st=
rtoul,
> +// with additional error handling to ensure robustness.

We use comments like this:

/*
 * Converts a string to an unsigned long using the standard library's strto=
ul,
 * with additional error handling to ensure robustness.
 */

Also we use the imperative mood in comments before a function, so:

s/Converts/Convert/
