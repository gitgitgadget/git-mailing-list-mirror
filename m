Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED53F9D2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077904; cv=none; b=NwmhHP52XMkRdWL+2SgJCW585mZYrb3yr06Pe1lB1RKNig/1K23S7WFOJxiPIGtaIJ+dTM1UgeP5zsyJc2HkvsThCkmV6g4Eqx+WLETTC9rWJ4r1uB/iZjl+I5zbPdR6jcvImQIn/yPmrthPYsx09bHpfTSzLPteFeM61Wa+Ozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077904; c=relaxed/simple;
	bh=QZUxb9qpCcSoge9oEtgtc5ohYalOpLtHi+YIwa/fAdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL6K2cStM4/IK3CbBkmUyrLB900Nn2KM5XVT+cMexPhUhYy0K/hjbHUK8x+mNTAH6x20EmstL2AjUctX8sAIch+RzaLMO4iJ+56WN9s7NuAH/ESzC4FJIu5qQB6lOmUHAYwVVPVQKJl/z61XqAKZXcq7ypgj4rIAcDPnh9bhctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNtfj6a/; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNtfj6a/"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so390589e0c.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760077901; x=1760682701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZUxb9qpCcSoge9oEtgtc5ohYalOpLtHi+YIwa/fAdw=;
        b=jNtfj6a/rHC1Uv3nH3sCBtDilTb2JQoRkYg3o2iQ6GABeBpnUG89sasl0jf9oMoDCL
         16PN/466nTL3MhG5L+AuS1AELltSvaBq0wI36AfhpYYbSVR3SDI62aHLx8JqAA7jaOqD
         YKXBb7HXekxUlRFOgvuRD4Rx09T4v6yhslSSZzHMLo34qDYY25uQdIgQLc7RJoSfAEUX
         wCqAeRjBwRTlM876Pfvg2Lo70xHzUSwS9fRuuiWh9rt3G9n1P0xc6YhJIT9nOdRG1QU6
         l8gWVUDj2KTs+3IBmaCRB0tzifDMXhJV4p2pTSo/qVd53pwsLyNVw0fMdXJmA3NK+HL1
         rj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077901; x=1760682701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZUxb9qpCcSoge9oEtgtc5ohYalOpLtHi+YIwa/fAdw=;
        b=G39TkyV0osFRL8m6Vvn4bj3+1Vp1NDWCYspAMWqwwDk7zq6e+Nd7wn/ueIXhr3znpz
         CPYtps0KBAyprvjAqqCMXrTtCZSonDilgoo8ap5iahxB+G3oDEqsoKUGT0ClmEQekOWE
         QjSErFVvN3bs22d5VG6qrobSnmZDEQifazBDTCp7DVRqnaT9uCEDxDmfnBr09AzPcp2v
         uznvjz89vr51yWCkQA0IReK823TVhlG6rrQQ4AkQYqsOOSAQwGpX6ThG4S3dCZmpXfJA
         6Q3qnEIOj2EEFPB1a9krwLkVNBK2OfnhJdFnYJ5kTxseGbktj+ZavaakKo3n1aVNaqrG
         dANQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuT4emuIwjwMlWYsHRKOAhCBOrBt+1vYZ+PQ68BukzwdxD8lk7bvBLy26/xc/GF0IqnIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWpCvBEqiWTWPxy66AoRam9zKPqtFjbtInJxXviaHKdqlC71/
	muc8xEG4aGB2++WoM5jtqdfUKbv32immxt/yAG+wDoKNSdAR6s+Xk2tsZ14JbBv9oi2swEYE3bO
	ASNNed8TDkCjhXnZoRJpLUFnA9rfaAVc=
X-Gm-Gg: ASbGnctVmHMTWcHNk/IUPO2eCNTvijmU+0I4a+2fXhg7C1gr5i0VKVLzgIW+7beN9If
	P3F5NfYH7dl3X0qw52x2XHgbJtdJGuAE1fwNUlMeANvHo3UB4Clw0zCT7xNH5dc6eCV9fa1ty9L
	j3rZ5Pjm+TfLbf0ftw8y+cW7g8fduSVaKHtuiN2ib27ULlKYp4R9SD633qIO/kHE+NqG4Bu1uBV
	MDzcBwJFJk6ELgClZ8heegCELcKfPWGPpIjGd4rW2XFY9zkSC3o1RPN0Q==
X-Google-Smtp-Source: AGHT+IEX7zfmLjS7R4NthKinO8uv7/9zj4zb6VvJ1qCoOngmXfon8mHvhjz/LEp+t1XdGcja9k2kn8ZEoqUH1AFhlaU=
X-Received: by 2002:a05:6122:510:b0:54b:bf2f:bcd7 with SMTP id
 71dfb90a1353d-554b8cb205bmr3863462e0c.11.1760077901418; Thu, 09 Oct 2025
 23:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3> <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com>
In-Reply-To: <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 10 Oct 2025 12:01:30 +0530
X-Gm-Features: AS18NWBrg81qS0uMzjxVt7H7VlxH4IPNvavu4795R_NkXOOMAe4kLY2UQax_9Dk
Message-ID: <CAPSxiM_nkXDaieL+2oq9=KqG9eMkKjMhHzQz7SzEQ96bN=q=vw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtPdXRyZWFjaHldIEludHJvZHVjdGlvbiAow4FnYXRoYSk=?=
To: Immaculate Atim <immaculateatim56@gmail.com>
Cc: Agatha <code@agatha.dev>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 5:05=E2=80=AFAM Immaculate Atim
<immaculateatim56@gmail.com> wrote:
>
Hi Immaculate,
> Hello Agatha,
>
> Welcome here. Please feel free to reachout to this mailing list or the
> mentors in case you get challenges while working on your micro
> project.
Thanks for this.

Importantly and I hope other contributors can see this,
We do not "top post" when replying to email in Git. You can find more
information about this in [1].

Thank you.
[1]: https://git.github.io/General-Microproject-Information/
>
