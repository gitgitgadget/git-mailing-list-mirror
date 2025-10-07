Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75C32D9497
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842287; cv=none; b=C7lzfU6WS0Q6NSj1Q2/C6RV5JpwSwS5Gy/FzbxqmQnzSzPF4opWw0lOvRvC+AatW+yGVvgQHiGk9FGNRvCDrC/eQYtESxHKNCaPQFYq6pdHu0G8iHCyUYS514j8h7wY26i4A5aXXEY1iWZUa6GXACGRrG6O0PHwfoUb3OEKaSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842287; c=relaxed/simple;
	bh=h9qTyO4l9w5ZSUS4JE+/HTM5uPsPdTnrWhHxJIsfsNU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Slw8SVxUEYXFaj5pUeKpaN16RDSdSOu7Jm4cb49ON2v8S5zLVr0ZFvP0BVdw/pC2+vwnD4x5mvVhqsxLVDKfwz9G8UtoD2b3xCJArO8d+X4JRxZHphdwlb8y1WzIOeglFIMg82b0t8/SzYuzeAyxCEMhN/IZy1YqEBu69SaV7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUL6+nhQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUL6+nhQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7bc147fd11bso3846026a34.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759842284; x=1760447084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9qTyO4l9w5ZSUS4JE+/HTM5uPsPdTnrWhHxJIsfsNU=;
        b=dUL6+nhQIMVodQHrbsC1GpyY0UYjigj3uKvukaWHDtSFLL275Z8R++2PNYa+9Dna2U
         6bpsUHney5PCVmeetrdaiVXz28uIp84S1x8BH4oDJGxRgF5sGxHhqq8cfRua9YBzpBqE
         HLglh683Y4ijvQbzyIAP23MKhTWUEvxZgizRVJtm+K44aFnSu1y2Z8LxPtRGkQjD8NsB
         oEnVh2BOIjIOL4wYUbOvTdxiMT10S/qnrGDZzBD2pIosJOVpoz3IXBDfJmgZNgZ1CjrD
         AiXJ7qMXgFUN3yi16Uhs1GTBpYSSaFKQTxS+mxI2uZNyjw3MXv9mICu/5YFFAVDHWhBx
         ppcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842284; x=1760447084;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9qTyO4l9w5ZSUS4JE+/HTM5uPsPdTnrWhHxJIsfsNU=;
        b=JslHC7jL14XsSNS4yZXk36ZGVBAVwa01W5RetdYYvFsj2zkN6mnvBj4WLCXL3aZw5k
         2xIp7evJNgZ8cqr5RwtZO2Bxa6T2XXfDycWo2vSVHHJNLlYm8rDjA4bb/WommX1ycvZB
         lalhRwac6QF1YdQSbirDIYXqSACV3hqjcZKruJH2sMC5DSeCIMlPEcBN9Y+3jKxmNBev
         ML+Mqiv4X5AXLBgS2pm7VNjYGua9Q95d4WP3Jw2t5TWLRauxwDkH/tQQ3+q21wNO4SF6
         eYb91Z9LpBqX0hpdmryRGmO0q6FTf5OSutao9ud3YFCzacNfNFI2xl8DsL9vN6O/yGVr
         9VyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhmsWZKUQ/dauU16MPjClTKnED3ZjRlO+RGp2nw0sY38h316L5N8xW9APcgu3FHLwjn8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfC+eITPSusKqFDQ7EbDFkG2lSzGJpbv7X5YmZQAOYugGklmI
	nD7fy6yDRwKkrQ0SbC159HmWZFbsKHeuo9y6aqvr+cADfJqqG6TZl7rVkAYTnfjwZISBZAhop03
	lJCzGACxkeYqvaev4xFtKS19InNYHXN8=
X-Gm-Gg: ASbGncvOrJA0Bl46hZEqYOdxwoeiCUSRrfn9+z3AiqkZiOLE6/MQLSfHohAP5uax9q4
	ebVBAlsDDS94c1Hfd3lziY7Med1TlmAKED+fy4ybhUk49SR1w0TlTDvd/8U0+6ghRRp5VQdD61p
	Q2tdOFHM37DLnpCb5qogwD6PGPewDSQEsrwFCSsVxY0OrIvqrvi65P93OgcR6zmDhzV4bLFGpYi
	H9scgTElWONXesWyqvge5aH9pdtl2fR5+u6ow7+4Jw7g9HEIcz60VbQbBkY6Q==
X-Google-Smtp-Source: AGHT+IFKEf7mIFnPJNE4rvGm4KbOt2VeglOE5649Kdsidln0+uNKE/AofKk2NUuFgVRpTXAhxtJkutQOeqCLZfRQoCQ=
X-Received: by 2002:a05:6830:7002:b0:79c:f9ff:43e with SMTP id
 46e09a7af769-7bf772d87e6mr8159413a34.28.1759842283240; Tue, 07 Oct 2025
 06:04:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 06:04:41 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 06:04:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im> <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 06:04:41 -0700
X-Gm-Features: AS18NWDhDJMJKELQP7h4gx8jMdLy545H2S46EEokEx2Yk9zlGiMN2SLo37UTuEI
Message-ID: <CAOLa=ZT8TDiA=1cAsnS6RkHL-5J2+3YBorBjKsKWm38oaXt0Fg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000281f7806409136e2"

--000000000000281f7806409136e2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a CI check that verifies that our Rust code is well-formatted.
> This check uses rustfmt(1), which is the de-facto standard in the Rust
> world.
>
> The rustfmt(1) tool allows to tweak the final format in theory. In
> practice though, the Rust ecosystem has aligned on style "editions".
> These editions only exist to ensure that any potential changes to the
> style don't cause reformats to existing code bases. Other than that,
> most Rust projects out there accept this default style of a specific
> edition.
>
> Let's do the same and use that default style. It may not be anyone's
> favorite, but it is consistent and by making it part of our CI we also
> enforce it right from the start.
>
> Note that we don't have to pick a specific style edition here, as the
> edition is automatically derived from the edition we have specified in
> our "Cargo.toml" file.

One small nit: We should mention that `cargo fmt` is simply a wrapper
around `rustfmt`, which also handles file discovery.

--000000000000281f7806409136e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5dc2786794cfcebd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbEQrZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTlsQy85U3FyR21pdWVFMjRselEwNWFUQ1lxdnArWAptSVYzbUVuZVBm
bENKNmNNMFJOTFU0NjhETHRiSkhrUWpycW9BWUdaT2kyS1EraW5Na3h2VVRKQS82OFhXeU5HCjl1
S2JtMWVrRnFVRTBFTVVOSkI0OXpzaXpLQ3ExYlUvT0JsUE56YkhrSWpIUVl6cmlPTzNncEphbmwr
d1ZlckUKQUV6bFZwOW9aRWtTMlJyMkxpWXVDSTErZHZtUlR4RjB5bHkwdkZZZEJQS1VwVlVEaTBY
WjIwbUlCRldLRFp6eAo1bFRzendhQnhQcy84WjZQK2VxN2ZGNSs5cDBtVGswZTgyTlNkRjFZQmgy
ZCtISXl3NnlDdUVZV1VjL3N0QTNICklydEtOSmM0RTZnT1FKTzc3eG1sUTgwYlFDRDkzYk40YzVx
SUl4RUxMQkNsV0VkV0syT244S3F0VmxIN0RMeG4KTUdCaUFsYzF2d0taNmhiTkNXN1lROTNCTy8v
bTN4WDlheVgzWUlLa2p3bDNQbzUvSng0eTlPREJ5cmUvWDNzUApiWjE3TUh1eFY2TzlnMTdmYUZr
MEhaYzhXR3ZBN09lREQvM3g1bnZZTmdjQU1iNDIxQ1VndnB0L3k0U1hOV1h4CkU1aHlsb2dsVWdU
Rzl4SVBEOWk0ZGkzOVVmM3Y4bHRiOWV3M0g5bz0KPXpTdFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000281f7806409136e2--
