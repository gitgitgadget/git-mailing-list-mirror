Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F01C4A24
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962798; cv=none; b=gzkvqJ3SDTFvCvsIzWctshxyfDhKQbQo4E6aySnlZ3f9yzX9pGNLzpTmbMFia6Kj9lwsvCXqMJ0zku6EkEDjWxvubyVJY9voOxv+rkJPSVPpRYOXRAcmQrOv51/NPH2ycKedcJwctwfoFzocd1mDMgI/nkeErKTNsO9y7Zk6iwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962798; c=relaxed/simple;
	bh=tXbzWeqaiq6XoH6PPsM59zSYMsAB+V4vnuVLW9JmjZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0GvnRZeYh6EFRYlzXcgK69tCHRWyd3D3NQq7k1HTK2A9s33O4R1u/1NP7b0cx27OvnUyVrsCMQmH9DFyUcHQqo49ddVF3Jwe6HUZQCgWjHWPvmedt+fy7l3e/C6RS5jGvmTJ4PgKnFzgNHeMiXK55AEYu1phn0+KW9I5HVMBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Diw213nJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Diw213nJ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso207500566b.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962794; x=1751567594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXbzWeqaiq6XoH6PPsM59zSYMsAB+V4vnuVLW9JmjZA=;
        b=Diw213nJwnFG26n732QxtvhLfBdm2YYQCjt7u8+LwmUHZKMEh4vTmClcCC9/pGGNmU
         SIHy8/+1fMw1yhhcBsC3hV/PE14KhLCWcV9SnAAiLZVNyDxr9A/VzdOJLNEm1ych7/1+
         CdphKSP1H13EFGo4UlubtVTJc6IYdmj1tQRxp8uO6OAsDAgTH8PzkW4wMwgrBFg5Eo2T
         gQ7VVsLuzdUTL2Rw1CIRM79mj+u8vfHtgjcSAatwgu2UESNgbKtt/WRsi1gm5STS4BPn
         w1SgXu/khvdN6ju8gumY/BOSK22uU8N2ru0lONKQWW7d1bXim8Wes1ryAls2LMgf413I
         31cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962794; x=1751567594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXbzWeqaiq6XoH6PPsM59zSYMsAB+V4vnuVLW9JmjZA=;
        b=sxsZmi6LwOFwlx29rekZknqKSg1iva1mtPldJJ9YNhg3BbPWBHQCdmeL2RNtSGkdFO
         PRxa1rHpCCNiT050nrmtaVeyC2UhZ2qOGo8VKB0eSWKcAvRuViZZqaVA9EPFqjszLTKE
         zcaNxMQsJkcgJKg0yf/nIMd6t6Uf+oGo7Omp4XoEm9yax1TqgGe7QlKdpVKpFFPBf11W
         XUXjhZC0y0oxRAbU06Ve8vE9PuAi2/2uyCB6bVlfIp/NFU9XWkicPdcx3ntYHg775Fsn
         4fE7tPO9IBMrIQGRF5/nZWcXbnJ+44h8bMlBu+Z9N/brM5MaDVmMFJNnI2dJ1Tj1+PdH
         TzaA==
X-Gm-Message-State: AOJu0YxcffEyKod4UxHuK61ciBsuRJ/y9okCwGfDTXBTBKPxCBb6webT
	0qJCIHu7i5G5E/uVHGNyWM8hqAWt8FP1Jssg9PbxXcaai0UKv7naYi0/Li3GS/MUJZEQpavvYIi
	W+muEAyLpwHlzwKAEoxTW7M6AC+Q2+hZsqLVT
X-Gm-Gg: ASbGncsL7v05llPm9LJCL8L2oVHy03OTWsuVqRGeP7RxoKbY99G+1T3bEcm3Qk4rqgl
	lQmrAxvvxUUvY7Zri1lVUMvC4DbuCjoMaNUtKPRxEZFym/gwLFwzdgv25aZh7BK6fGaIFOYKRzw
	gAjcvAmuDTmjd2nCq9omC5BQh5itUUZqWcVMi/JOeXYPPjKQbRYIh+z4w=
X-Google-Smtp-Source: AGHT+IGrVwwrd+d4hm1hnD67+0H8G+NP5RN+UpFICw230gqBF52B5cgKhfvcp/aTk8m9W1buBhh6Rqpk6vAtOYiSYps=
X-Received: by 2002:a17:907:3ccb:b0:ad8:8efe:31fd with SMTP id
 a640c23a62f3a-ae350179103mr11183466b.52.1750962793760; Thu, 26 Jun 2025
 11:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
 <bec18631-c0c5-4e8d-99ca-7f2bbdd5e88f@app.fastmail.com>
In-Reply-To: <bec18631-c0c5-4e8d-99ca-7f2bbdd5e88f@app.fastmail.com>
From: =?UTF-8?Q?Denilson_S=C3=A1_Maia?= <denilsonsa@gmail.com>
Date: Thu, 26 Jun 2025 20:33:02 +0200
X-Gm-Features: Ac12FXw1ZsP2pRGvur_SiJ8s48IAdXwZWVQROt7ignYZc0VbUMpXQVGBl2fHG5g
Message-ID: <CACGt9ymuLOaA7dK-Y-g0WR99EKgknsuXzOpEd8xqpNOpcK_38A@mail.gmail.com>
Subject: Re: git rebase interactive breaks when working on a secondary worktree
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 17:58, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Jun 26, 2025, at 12:49, Denilson S=C3=A1 Maia wrote:
> >
> > [Enabled Hooks]
> > applypatch-msg
> > commit-msg
> > post-applypatch
> > post-checkout
> > post-commit
> > post-merge
> > post-rewrite
> > pre-applypatch
> > pre-auto-gc
> > pre-commit
> > pre-merge-commit
> > pre-push
> > pre-rebase
> > prepare-commit-msg
>
> A lot of hooks. Do you use git-branchless?

We are using Husky in our corporate/enterprise/business application.
And I think husky hooks itself into all git hooks, and that's why I
have so many of them.
https://github.com/typicode/husky

But inside our `.husky/` directory inside our git repository we only
have `commit-msg` and `pre-push` hooks configured. Everything else is
unused. (Which probably means Husky gets called, but does absolutely
nothing.)


--=20
Denilson Figueiredo de S=C3=A1 Maia
https://denilson.sa.nom.br/
