Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E7146A72
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148322; cv=none; b=U2VHZFJ6gbANCB+iW6yNbGxs+QPsgbB1nF9CC8FfUvXSuQgXDlRA61cl7emLQcHMoOc0PYhulDvFITIEWmtIyjIt7rkltqAu1BqZdRO325EsjTB/174hEyWXB2YyL5nL4QBLYdoV6LrJYzxzYl34MWZYz7awapSq6LD5t8QtOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148322; c=relaxed/simple;
	bh=6twdFvwoq0Sp6+v0b4oThowQhwIR8zH+Lz58ChLtjtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lhjpTPhlONAmQzVLIboqchbjr1tKKEAWizTWQ3X4wB9MJBgKzyjudFFaG8ODRqwVAEgQs68c79ZSpwFq1IPN9xKVlA1rRuOX8DUsiWJgD/Szv2fljNc5SpXKEa4MQDVuXccb2tcuo59AFVtgqKO77UK5sdNNHAjXPQKsPBbDIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtuYmgVr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtuYmgVr"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso2424252e87.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723148318; x=1723753118; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4bUYdn3+MeFA9/b99ZZFK2KJM9DQRFRLbM5AICiF2k=;
        b=PtuYmgVr06CPvDI2iRsir9zqeAAHEHL7rEC3gYJ5neSVYwnVzUrbzgw7xpSg1DpnB9
         bA/yzXBt1UEu2deDDM5982fqYcZlqy10gNpL/bxkEBlWZ7jjSn1iKvQaDyR2ROXhoR4J
         tcF0aZP0LFtpkeUqt7o+DV0fmZW/9CFZ+X9lSrhCq1FFUPOeXu/nqbe+pVE6ZG2F13r9
         HhS18/0m0GiOrVOAWyFUJGoFHz8Wnpz3a8/Gta8O84JqT+Ly90EwBTGTsPdhzoMM2zTb
         FbVz7vKc/UnBzlYwPmo4335tcflarsHnZp3uhFJxGXIHfTH42LcJcy5dDNdfNvBdXxAH
         fNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148318; x=1723753118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4bUYdn3+MeFA9/b99ZZFK2KJM9DQRFRLbM5AICiF2k=;
        b=ZwgOp4pYOKBpP4bTdLLo1DJkMEJNhnBn52m79sB139tvrr2eXodQFhd6Dm/qlg2uqu
         uX2uC8THqDpZgyfyD1nTrpDPEtVipzjhA4UWKh9cj/2fe13Siem7JTeIKalSGlansp6z
         TfHmehloDuckWgGchqF+i69Jd39k1CXTntMM7ZNbzTSf4OnWR1lHYLugGGJQYeTgQy3V
         Vvq9gGR8QIYsXkByVr4tpwQwCb+624MeORY8A5N/g+b8g+1pBMTEOkLOTkdQI2tpZ6PX
         cGdb8j/hUTnYK3cmvyqgtEJbxC9Kzf6M7k6So7gey/BvlvpJ6jGN+gvAi7UoNw0Y9sJM
         7xTA==
X-Forwarded-Encrypted: i=1; AJvYcCUapND2ISurgA4YdMQg3P0wmVW43PIs5Tmtn5XFjb3IIx4Vhuq5YF5aRfO6f6ZP0b+Kn4ZS4vhRvn1IJwF1s/0LIwu9
X-Gm-Message-State: AOJu0Yw3SS2s6nI25brciHmMiv20SeC4C1QA5e/P2qKq9oQvg2iIIu0m
	JR54YhiGoemyfrO6kp410N0dhTHLjyN2udgZlkq/Oph9dpt85o610odeYRM9KnueSLdX4wO2sbt
	D+zxsmJDziAc25b78MUMOUXyzoeBqvi+PgWI4
X-Google-Smtp-Source: AGHT+IFJ7s0YOXEMMaJ5250OzYRekaUo8hm1fmdAXvzXcv+pBUra7S2qgEr91lmrSogWf6eqnY/zxkVnpAFzE8vJGtA=
X-Received: by 2002:a05:6512:3e1d:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-530e58769c5mr3048562e87.38.1723148317983; Thu, 08 Aug 2024
 13:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net> <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
 <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net> <htakxe76kl7ll3q7trjj6cjnsrg4tnue2k46zo25bnf3zre7t7@r74vgvebdhsx>
In-Reply-To: <htakxe76kl7ll3q7trjj6cjnsrg4tnue2k46zo25bnf3zre7t7@r74vgvebdhsx>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 8 Aug 2024 13:18:26 -0700
Message-ID: <CAO_smVjEU4QH6JsLxt2v3ZYPEKwyd9gyJ4OjNgf1+mPVS6xoGg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
To: Josh Steadmon <steadmon@google.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:22=E2=80=AFAM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> On 2024.08.07 23:55, brian m. carlson wrote:
> > On 2024-08-07 at 23:05:00, Josh Steadmon wrote:
> > > Yeah, needing to free() is the only thing we striclty need from libc
> > > right now. Please correct me if I'm wrong, but IIUC then any memory t=
hat
> > > is allocated on the C side and then passed to Rust needs one of:
> > > 1) freed by libc::free() on the Rust side,
> > > 2) passed back to the C side to be freed there, or
> > > 3) leaked
> > >
> > > Am I correct in assuming that your opinion is that writing additional
> > > *_free() functions on the C side is worth it to avoid libc? If so, th=
en
> > > I'm fine with including that in V2.
> >
> > I think if we're going to be writing a general purpose API for
> > libification, we probably should provide free functions.  Normally, tha=
t
> > will be a call to free(3)
>
> [snip]
>
> So in this case, does that mean we'd replace our call to `libc::free()`
> with just `free()`, and then add a declaration for `free` in our
> `extern "C"` section of cgit-sys? It seems to work on my machine, but is
> that actually the more portable option compared to using libc::free? Or
> have I misunderstood something?

I think both having a generic 'free' function, or requiring your API
consumer to have a compatible 'free' function is undesirable. If the
API hands you something that you must return/free, there should be a
function for that specifically. So I would expect if the API has a
`libgit_foo_get(foo** f)` function, there'd be a paired
`libgit_foo_release(foo* f)` (ignoring whatever squabbles we want to
have about the names). Requiring `libgit_foo_get(foo** f)` to be
paired with `libc::free(f)` limits us to always using libc malloc;
pairing it with `libgit_free((void*)f)` means we can't refcount it /
ignore it if it's a part of a parent object, etc.
