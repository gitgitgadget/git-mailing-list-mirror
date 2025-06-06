Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A328C00B
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224624; cv=none; b=kCnHqFi4kqMF3ONtn5a8qEkAXNrIR1cOx1Ssc6BSXl/Iel4iRHClvr0LHFIqP7uQXROOOFUuNrKulI+O7DeYByCQM9p2712T7C6TPRccXVwSc+23C6Oi+N5HZfoXqZhVDGgfrgYr/gLPpqROorDFhV8MFtQ3MhSogBmiOcxUj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224624; c=relaxed/simple;
	bh=n2n9WzjRUzE/5p74QRFPWP7QEjrndaPJaWCxo1snhfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeEecbcQn/LK3VAhECXFuCh37RREL6l/LF1BgDDwQuKpIkNyY2fE8IIsYpkoCcTB9xlq+2kNbUAE/i7m/T3QObAQiNRI+OXcRzkak5sBHgKqtrOSS0O+Hf+gWKA2PXk3R7PRGdZpB59XDhApDekrYqQUGecKswtnbZj69yv8470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZtIie95; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZtIie95"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1672307f8f.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749224621; x=1749829421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKW7Zmn1m9wdcMYM609oS3c25pZe86CssGYTElW9ViU=;
        b=MZtIie95R6DoB4gWcTLxiyXO3PXQTvEvVFDdSpH+KwSYhUJGwkXVunANio2CpdVUHn
         QOUaZ+rGxvph/pi+Abu7iBu8bXoyU6R4872KLuZDzUigCXJpribDW2FSYazzzBDWbgYY
         c9XQQMOcrc2FjJYXdA1undPEKfFXXZfaskaoC8PKbo4AYPK5WDon/Yk/JQhioWwoqlK1
         ALLhOOc1aZmWGZHnqUlkeh0HnOzF2Y9R/lbnzrQtPSltMKnZwplXIYks5lVmYwlCgl6Z
         WXe7/GnrTlVZcPxnFVaFVGmz/CqWeKII3xeCoIaKoSJpjq6cR9iTrUyrwJbe8i5DM7Tw
         647Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749224621; x=1749829421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKW7Zmn1m9wdcMYM609oS3c25pZe86CssGYTElW9ViU=;
        b=WCpL5NhFlyvqDdjw8nNZB+iRniXVz0l5qm0ey/sTtRsxY0J0e9IvIGLD7EYxEBDfuZ
         9pYdkmK4t/Cqp4Gkx/LZEz0qCeRok/3aSxMX+A4ixQ4g3efxMDtLnWcktXI9lKeqQL7X
         etDozQ7WHfYuKRSYwwEZBTYf/7MZV1K36o3+I2RcIt/Xt9fhQOD8EHqM/JUY/JJtsaT4
         jSMP6OAxQu+WiXb3a3x56VJFwTUlKIHSLSXuLTGKw0/9Di39ZK2v9vV0zxXg0ZV6xnwa
         SgDGYJV4m5h9vjLlk+GH+vHeXaBvSeOIJRSbbu2bYz4D8g+6RG7W34V1sgPohrf3n72e
         UVoA==
X-Forwarded-Encrypted: i=1; AJvYcCW4YV1HWwnDiLlu+eSe1q4Gf1lENAvdnXE3bEUmWIxDpZsrXJ4iRG3+gEzfXUNXj+Eu2ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+h4v4wIMHGl2s9gDqCXNghCRo7yNXzMCauNPGWZaIKUU9/5mT
	KilADnM5sFmzON8+UISRaPTsN/oVOYRm67Ps2sS+y+8goa1IzfR2h9pc5qXo1bpbBRXvCIUAMBS
	r0zXiHl4o6Km3tA3mQiJUgdM6+nEFtxs=
X-Gm-Gg: ASbGncuEVlj8qaTorjK7jAfXEP84giOG9Tz7/F6tkxsa6c2TrQUb0PhtiJb5TTIeNQy
	kNK6zB38Uhq5EQiXksokGNqtkdSGsJDweSnYryPxOwygjR5psBPxf3glzIATLx0Kx7o3fujfaGS
	9bG2dbBEoIvG+sOQQNcMgpmxdblvJQ+lZkYQ==
X-Google-Smtp-Source: AGHT+IEhqnzfEeWEy3Wyq+o/qmzDeFYj40np23IDpREWPO9kQaj+e7pfZaip18O9XbhOHmePWoP6VaKBxLHkDfOv7KA=
X-Received: by 2002:a05:6000:2507:b0:3a4:da0e:5170 with SMTP id
 ffacd0b85a97d-3a526e1ed18mr7356553f8f.27.1749224620989; Fri, 06 Jun 2025
 08:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
 <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com> <bf919293-562f-4572-bc0a-aad7f22d1013@app.fastmail.com>
In-Reply-To: <bf919293-562f-4572-bc0a-aad7f22d1013@app.fastmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 6 Jun 2025 17:43:27 +0200
X-Gm-Features: AX0GCFuhy7HBSL-cEW1ywJ3GKsCpH0oT9-BLVPqSVjSgdDAV1xKms0Xnsp1VciI
Message-ID: <CAN0heSqJfrLYbVmKh9-mS0fHkBSDR2dxphSaF7Q_qfyzONs2Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] curl: pass long values where expected
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Jun 2025 at 16:28, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Fri, Jun 6, 2025, at 11:29, Johannes Schindelin via GitGitGadget wrote=
:
> >        ## http.c ##
> >      -@@ http.c: static CURL *get_curl_handle(void)
> >      -                die("curl_easy_init failed");
> >      -
> >      -        if (!curl_ssl_verify) {
> >      --               curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, =
0);
> >      --               curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, =
0);
> >      -+               curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, =
0l);
> >      -+               curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, =
0l);
>
> Maybe I don=E2=80=99t understand range-diffs enough but it looked like th=
is was
> using `0l` instead of `0L`.[1]  However the patches do use `<num>L` inste=
ad
> of `<num>l` throughout.  Which I like
>
> =E2=80=A0 1: Or rather I don=E2=80=99t understand that this is showing `0=
l`

You can read "--" as "we no longer remove this" and "-+" as "we no
longer add this". In fact, this whole section begins with "-" (in the
outer diff) and we can read this as "we no longer touch this at all."

Where, crucially, it's "we no longer touch this *in this patch*". Patch
1/4 in this v2 does change this from "0" to "0L" and this updated patch
4/4 then leaves this spot as is. Unlike in v1, when this was a much bigger
patch that touched this spot and many others.

Martin
