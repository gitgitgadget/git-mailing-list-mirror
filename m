Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB32EDD58
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397697; cv=none; b=rIO/Byhgp8emePEnc38ckuJiZ51Yiq5CO3h9UhsNhAgSmAoqMvn63YykKs4mQ7RJwxzuWytrkUjEk1lXO1OywYgpOmpQyHGUItaWhH1dHeiKsz6uGi6czrayraLRI38AGWuvJaK5GbL0Mh+B7lquBAiaP4d02bBPgaFY6gvHi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397697; c=relaxed/simple;
	bh=C8tgXpSB97n7O/d4CVd+TV88P+1HWtAviCR3mmj6MXw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDR14xMV+Ju/XKPd/sR4IP4BBakhVYEzNKXr0mvXUYJ9bz6KRQVQcAixLC+Vs1zA9hcV1Q0RDp0O6vJ6Q5fBnFiixesuoA/ElMjGOoDQ51puKgkXNwkYyqqm74/7fY1W0L27bKQwXNj9ifqaCWYsswfQYFs9mrG3Dbe7/owNvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSX+6UOz; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSX+6UOz"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-50f8bf5c518so759602137.3
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759397694; x=1760002494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjgvxhAd+uNBukPL3EZT/70QmVqPoFcgcoBL+OExV7w=;
        b=WSX+6UOzMtnu6c68I7TnopQZUpz34gAv5z6TnjTbwTKME1VSI7RPMlSSqwlrJZ0yRQ
         P+rSxGsZDNfzUP0K3DKYghFC3g0zfhOjIaS21Mk3znIqld7qsAYeHq5JUJN51rALMCNV
         oEVyxdfQ7Fa3nN6kfuGMYvnQHOgML2VfPoSWj6vfRzBQlGRow5GPQ8wJS6uWHsHczBX2
         z4z08DMXpLEpHD4XpnGz4thlrSVvF/tyGOflxWKXDk4yUnV9cicRHhaK9g1Vwz/tbFsw
         eO9M4n+y86PtdLq/hiD17jGDs2dZXAk8xFG6UOc/wVqMZXg0RwArAp8TGAY8esNGWFvO
         2vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397694; x=1760002494;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjgvxhAd+uNBukPL3EZT/70QmVqPoFcgcoBL+OExV7w=;
        b=POfsVO7VuQhIMFwlemwaQDt1CEoRSQGRbF7u4yxFA9uyHs9BtWQwEblMZ6nc4zGcE3
         X4EoaS8FfaHprsl2G1gm4BZ47Qf6edouMcJzAiDkZIgA7yOAgP64JfCohOIE1oQQYolb
         ld6SwDWsBpt982kdK0QUsVnj+xARdjQ1r+ZPkgNopyQckYgkr3Jsnm8AqQgNj5Nm9Ewr
         rvYw4hZPyXLb4emqgytMvPHhrSjhHETr6Aq4/Q/f7/+AdGLaIvD+PSmDRGJHNWnyvCB1
         mB5a2NbkzzjuBlf6v+PGtKw/O3YF6GCl9zVuhCi5ZcFZuCW+sPoiwOqy4YYpEAVPyRYD
         h76A==
X-Forwarded-Encrypted: i=1; AJvYcCX69TPHLygVOEnid2J1/EBsBuoTyjB/Upq3TWcHku0mNX80e0/Adq1iEBk7Qi1NPse5Wp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDTGsLrhVsdZ6ia8TqNRr+cv5Rc/4adx0WDLAyI9Ryf6T1YRP
	l3vt3NQtdzcBVaok8OdaLrUI0a6dygXEMN+oP1+w1jaWwEdA6/IhBwPlunJ9SLzsqJYJEf/ojU2
	nec9w0r7bxJc9/X0NbTSvpsqtQpjBKMs=
X-Gm-Gg: ASbGnct/uicS3uNMIsBU7d/QtCQC8/JJUbZhw9qQJsixYWPJZzwZzSVZ9hvgrxHjVG5
	Mk4yeRifCbmGeQkEB+M+yAlEKwgyJZoGK22CL1zZSknX77HQvaHMgtLiuaLt8RmQbOJOTCimkZu
	BMvNlq4hyGcamfYLQsHttO9X/wqpT/iW42pjNM8Lg1zIEaKCzTTDM7XeLOsSdQUhw21DRjCoMqn
	yE0chGEf3cKvB4APeMvLqnuAaTXdhtFU/aLmq0LQkWCDhkGvFXkNLrNeXs4O1qyBA==
X-Google-Smtp-Source: AGHT+IEaLemTN80fM8nC7bY/N5TSFv10sNbrk5Bw29nEjpcCe4WBTCmZOdorVKnj0HnSLX9XBeEQ+fbecK6vfDPvBmY=
X-Received: by 2002:a05:6102:951:b0:521:d81:6dc2 with SMTP id
 ada2fe7eead31-5d3fe72f84cmr2942853137.33.1759397694193; Thu, 02 Oct 2025
 02:34:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 02:34:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 02:34:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001150805.9652-1-hanyang.tony@bytedance.com>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Oct 2025 02:34:53 -0700
X-Gm-Features: AS18NWBPTmJhxjuDbfFQwCBCS_3cth7d38Z_hWHe0XPdpwWuYaEQLNLw4izjXAQ
Message-ID: <CAOLa=ZSboPeTNSSh1fsaKc+Ef5DhaKGX+mNiRzyYfvFERa=JLQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] files-backend: check symref name before update
To: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org
Cc: Han Young <hanyoung@protonmail.com>
Content-Type: multipart/mixed; boundary="00000000000094ddcb064029b208"

--00000000000094ddcb064029b208
Content-Type: text/plain; charset="UTF-8"

Han Young <hanyang.tony@bytedance.com> writes:

> From: Han Young <hanyoung@protonmail.com>
>
> In the ref files backend, the symbolic reference name is not checked
> before an update. This could cause reference and lock files to be created
> outside the refs/ directory.
>
> Below are the original bug report by Sigma:
>
>   $ echo ref: refs/../HEAD > .git/HEAD
>   $ git commit -m "test" --allow-empty
>   fatal: cannot lock ref 'HEAD': Unable to create '/home/sigma/headtest/.git/refs/../HEAD.lock': File exists.
>
>   Another git process seems to be running in this repository, e.g.
>   an editor opened by 'git commit'. Please make sure all processes
>   are terminated then try again. If it still fails, a git process
>   may have crashed in this repository earlier:
>   remove the file manually to continue.
>
> In this case, while trying to update the symbolic reference refs/../HEAD,
> the lock file conflicts with the ./git/HEAD.lock.
>
> If the HEAD points to refs/../foo, a reference file named foo will be
> created under ./git directory.
>

I quickly checked if this can also be done by using 'git-update-ref(1)'.
But the command calls on 'check_refname_format()' to check the new ref
for the symref update and fails:

  $ git update-ref --stdin
  symref-update HEAD refs/../HEAD
  fatal: invalid ref format: refs/../HEAD

So this is only possible by manually editing the .git/HEAD file, right?

In that case, isn't the repository already broken?

In other words, the fix seem to only stop us from creating files outside
the $GIT_DIR, but this seems like something that the user would have to
orchestrate intentionally.

The bigger question for me is if there is an instance that you'd want to
modify the HEAD file manually. Or is there a way this can be done via
any of the existing Git commands. Otherwise, I'm not sure I would call
this a bug.

> Han Young (1):
>   files-backend: check symref name before update
>
>  refs/files-backend.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --
> 2.51.0.373.gaf4ee0e35.dirty

--00000000000094ddcb064029b208
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b9dba566cff75c31_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qZVJ6c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0FxQy93TDUyNkN4WWx0Z1NhaFdOT1lTTzdxaG9ubgp0ZFJvMDc0WTBD
cXliRmZGS2NPbTdBWUdZOHBpMFRjQ0lvcG5oa0R4c0FwWURHcFpIWXFER0Z3ZFordzUvK2ZVCldD
SmY3bjQxRjZGWFFRSGNzZFR1MmJLelgwMUx1M2JNMzZCWWwvRmROYWY5UDcvV2N0WnlGTTAzRXNM
b1pKWnQKa092Z09EcnBwNHBNM2dkSm5oMEx6YWJWdllCWENDYWhMUlZaTHROUHN1Yk9heGplUWlz
cmNFVGNlREcxdGtoSQowOW1ycThIV0ZxSmNCaHBaNlBjRmNMSFBCcjB4WnRkUFBXUVB6TkFXQ0Jk
UVFhd3J4NnU3YTl2dHBBdlB6c2FTCkhZRXpFays2Qi9BdUc1bDB0Q2hTVisvbi9Vclg3aWNqaHhR
MVBZdTU0blppQnkweTFHemtkeENNS2JBVk42enQKQmpVQWFRZG16dCswZHM5Yk9XYW9JRnYrTkE0
WTk1aTRLS2s3ZnFHWFgzNUVma2pwKzlsekVxQ2JDZG0zblJKYgpsd1lFNGlKUFY5aVFQSFkveExH
Z21oaVU2d3EySjZpSThDS1hxL2l1YjRPMGZLQXppVXdjNzRqN2kzVUVHTlRvCkRmMjBaY2g5RG9t
aG5PNzNXNGxlUXdIQ3ZSazljREorc3dNVTJZcz0KPUFnRDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000094ddcb064029b208--
