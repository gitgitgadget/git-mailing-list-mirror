Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7F2DB788
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605359; cv=pass; b=SWFUb7Vcq/c+b/kFcu+dg+PRgzTzscS3U7BHV6OBZXQnx5Fnv3o113JaUWa8/jHGF4w3Zaht6QAH0z91zeESkjc9QepWKMKNeVgLIn9noKQ1zI1W9RN2Q1VddeWU92OsAkzIq+DjWPqXz08OWI7FLpm3BKbQbas+npgnQQQcgus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605359; c=relaxed/simple;
	bh=iZNuax86vDlPqj9pu67Bi00kA5EmVcQTh7IKbc6JlqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyZqzX8DSoOp4lr/XaG06WuojLja1EHgFYddLoyk6p4lW+F/r2cbhu9nxtcDiWscXbeiKgkaN+pIDCpoi4y+9zM0sxssU0ZbrRxbA+Dz1TTyEwq/2Jhy8htAxXVoppAK2OPIuS+YdEL7gjhdXWKRu67e/lq5HPN8BVvt+VXxL+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=freebsd.org; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=freebsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662f2fa7e67so838925eaf.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771605357; cv=none;
        d=google.com; s=arc-20240605;
        b=QTxaU8CZd7CIie3a9PWg17vNJVecxG9bx0v6L6zUc4/aEQDEz7SCSfFphuUZ3R5UgT
         UT9PUhWGfxy3xS4/v8nrK/PinNYd9box7wMCUN1D04/IKdX1VNxXtSWuvgwO788Zb/7o
         Xg2Ize/G0PhkwOjtPUzgb855I4LgYU5ITM4kvJC/M8qYUW3NxY1jb1H6uxfxogPqgOZN
         vTv5hDSEPIVZwj435GDrWcg/Ld/YjljfvkcNYDNTRhUHgLBe+shmuA7XknE/q+IB1HJv
         VryH5Glv4WGACvNy1lmiDzWUSJlnR/SnSk2TA/CIgA1V7mvE5NukBQSIrt9cOIYpPWC7
         3fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=iZNuax86vDlPqj9pu67Bi00kA5EmVcQTh7IKbc6JlqE=;
        fh=5pQe76T91OGE8UyFST1MV3NfunTi+rqqad5Vhoeg6oc=;
        b=D7eHhXWhujtlu7STETv4hqP3QNem3Wda4dauoWty9u46V7W6qGVMSpvbj87dPuTmeT
         Oz9pO0oQB5QF1ZmA6a+NhMEWx1JZbqBACMEALWpXpIEIf7+z0vqFcEKyQrU6Kti7fUg8
         F60aP4wAvP3bhH5RLjzwqY/4RRsINGDgUrYOEBYO3O4iG3y5tKrGLXhndPHDTQHytRFg
         t1wV7tugDqrbUgdn/fJnWKKH/THCZwmG4mOpqCph+AcPNMUbt0DmrpWYM3z636kHHj3p
         QEuCdvQBscPT02qS/j8ECrpPyV8zG4Qwss6DJEBwmzYAvd7NpJUZa4Ya2eRjkvBhKXL/
         PiSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771605357; x=1772210157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZNuax86vDlPqj9pu67Bi00kA5EmVcQTh7IKbc6JlqE=;
        b=W5yKGmCcUO4OMkDxqGYtLJJEthiILRm3u4pTtO9qROzKqWzXA30spy8/9JLZsrTBC7
         N3RCuQdoayogLmz3uRUB2wyD/JlN0mqou6mNpNTGJnnufUCXdHzl+8mFmxfP4UIanQ1h
         IruLJexinPJk79F09oEIPHpVrG7KK7AyZ4+Lq1ANWJO66isEyn8xoPLDd31JXMnXLPFJ
         Wo8TZ7m8Cq5NmQsecyWc3VbRTdg/HPz8VOT9XnD1l3mu66bgEbFgss8u+XV/kLmQHAiQ
         5xysICf+GHWcbB/tUz75T1zC7+YzDNW1rbYyQJr+hiyxujwTjGmZTYzA+fu1aPPq2djE
         6dwg==
X-Forwarded-Encrypted: i=1; AJvYcCXMw9L5tErHGAsVXluLxr0GCGH5uIl4JvVIb2IxwMOuH+pPth/xPHOvfd6D2Cf0HBdKFR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuin/aYuzwDFIe+YMZ6FVMCAARlUFgQYfiRN4+DlChfsZW1kb
	ghEVBes3Aw74l/ra3jXMBdJowf4f3wnS5FbIIayLijWFTDWV2uuNI4KD+jKUHrN7ddeJ3n/wGzK
	xJiTLR5DwQMj3UDI5vFyx/Q7Z+EDMYaY=
X-Gm-Gg: AZuq6aJnl5kfdJNFvuUk+Oxl1cfvra9Bgt5MPc7o/fut9MkeFE2SyjEeAlRCnkuS1rj
	Z9pZP8nRv9alQG8DBFwA6C8QpUogxGpKLJsdZV9E/pJyAKWXK5F3MtVTfE5VlTvMrAaRYi1xX2S
	4sPMkwdw3enjgnkbRVHZnfkatGYO/ho11Grdy786Rem9owLzkq35d5vsFa8qYmyKrFBj+VFc0NG
	Y5D2rza5Ijzi3ALxB5u8oNBsufimoq75FDa93RKAuLPkk3lQybcox7S7XjIWJ/SPdM/4OFSrROR
	6lbvPnjuJCoVaojY72ELWm/YMake/7hD3czgCyddalOyJGmltYM18KgKLGLeoOiEePJTtXEjjw=
	=
X-Received: by 2002:a05:6820:a0a:b0:662:f244:3530 with SMTP id
 006d021491bc7-679c468a332mr243712eaf.17.1771605357423; Fri, 20 Feb 2026
 08:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213124656.218396-1-integral@archlinux.org>
 <CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com>
 <e2a5c920-7f15-4ea8-9390-cf42ac33082d@archlinux.org> <CAPx1GvcdFN5gn97xxuNLRBy2sV2gK3Wm56Pw3tQGENN8_+BKnw@mail.gmail.com>
In-Reply-To: <CAPx1GvcdFN5gn97xxuNLRBy2sV2gK3Wm56Pw3tQGENN8_+BKnw@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 20 Feb 2026 11:35:45 -0500
X-Gm-Features: AaiRm53lcZBEs69hmMe3ZsN8iEl3aYjScDBdRd43o0NLayUFR39JXvXyI1tQe5A
Message-ID: <CAPyFy2Dj6z9OuYFF9Tpn98mrd3Hs6BD75B73B+jkqp9aVM8X_w@mail.gmail.com>
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on Linux
To: Chris Torek <chris.torek@gmail.com>
Cc: George Hu <integral@archlinux.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Feb 2026 at 11:50, Chris Torek <chris.torek@gmail.com> wrote:
>
> Ah, more importantly, FreeBSD's sendfile only operates on sockets.

True. If benchmarking shows this is profitable then we'd want to use
copy_file_range(2) on FreeBSD.
