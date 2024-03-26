Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623786BFCB
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453895; cv=none; b=ObhfJmP784RfYwoX0fF8QkfnXt4wjRG9o12SI8r/0h2BonRIKNZyCnTT7xo4RAz+MSlkW52WRQ3jdtc/04Hn534rQhsGK7g5jtB7gb1MwrtAFFUk9UE2jj1878c+gAlOBDY2qoWwfCZZJzts8Ke+rOj9b3V/5WxgxxqCkFkcLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453895; c=relaxed/simple;
	bh=NRmcnU/Q8ub4plSVklZLvHoSEXi1Fe0+Dyd/2anFP0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9P4LzIp/xH9VYQ5Ix6DR/KQnEos8+uFYkMbkGa1/zD3xRvuIV0edybM/tVz3ZRqEsh3Aa+nh1s19JgNQftkw/4keYSo7qsuTsMifoTYOItXceppGYEYshN1NWRPj7BBAvx/LARruo4dqDGm0jJDzkMnJFLLDezcQ7X2/ysCfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpgqzCr3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpgqzCr3"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56be32b9775so5153693a12.1
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711453891; x=1712058691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6vC4zUfEyLVqlsf70063WXHsdvADfqxSqKOoT53tQk=;
        b=PpgqzCr3xFEYdzkTi/i3oZNJN8p07NP23EUDGed9DnMDFpvfVR5d3y8gdBIK2GXs3d
         ydsOQ8wa+HlU53QbsW1iTvXAlKSKTFqgTItZRV06OPj9hHWEmrG/MhOXstxF/1NBlGnK
         8EhUhXszKL96jX2SphQB5hVyQTjYAezJ+IHZ0n9KcVCEL3rtfC1lHjqNPgeblq6G348W
         iOOrC311BnfpXQgPETE6vR3kqAltrSKD3BSo8sW3AtHzkgtdNLPYdZYg6BZL+/Ur26Vd
         zxPjIYm/OqCnsSwyM671mwLe0yRGSZHERu9UqlilHJt8HyvK2mzXQPYLpH6Aj1MgOJ9c
         +cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453891; x=1712058691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6vC4zUfEyLVqlsf70063WXHsdvADfqxSqKOoT53tQk=;
        b=JtDoN/l/RDJjOme16duPspUROIw8sgwku1M+yRuGGh6mcIFWvrXSwaIbKFsfnBHXvM
         oaUp1fpAwlcaql82L8fCcl5jEXanLfwNwaNP37zNbfqsSseyZSkxhPa8XpsDrtNNQTtC
         cULugRyLj2Y8rHZIv0qnS6HiN2f3t0M/x+myT1SEKLkkHLGdL98OzClVp7Ov+HafIM3x
         XXDjEtShkW1gdVtZA9YeOtOBwMJQUlFEqTkOFIA8XZPeyVx2eMeg48tYLLXxyYPuZsXy
         sUVCuaqw3fwgLFsTW6F3M0tModFeypm+AiPjdcgxHFirb903t3i+6Ta1GHEdymfV0/gx
         Bhzw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Vx7oClDUr/E7lfFSqJG0GzlvFmC2ubc7eBMv+H5sKsfpgDdxWw2PkmgLQ6CnpNJB7qVU8FheEyMdHNfrxhbqf1ga
X-Gm-Message-State: AOJu0YzfLxlvv8+lAlj331k6uncm/59zUpsfFy+PdI1HVaf+2pLld1d5
	SfbmgfZ0V6Ddfyv1z+t8NjEZs4pb5lo+Zb27YxBrtHkknJCUBMM88zGL4YYw6XLHNyQmrPn1OVo
	ukBJpPqb9x1UOLOXb8Ab+R5in90c=
X-Google-Smtp-Source: AGHT+IFD7iDx3Bt/r18Gau5w4uut3QQ+b3ld4/XsP333SlFbgePiLRLetoc3ITtLrHJ028KtSMsFnuHeD7E8fM1yPpc=
X-Received: by 2002:a17:906:ae46:b0:a47:4366:57d5 with SMTP id
 lf6-20020a170906ae4600b00a47436657d5mr698666ejb.13.1711453891345; Tue, 26 Mar
 2024 04:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226143350.3596-1-ach.lumap@gmail.com> <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240229054004.3807-2-ach.lumap@gmail.com> <ZgK0Ap8CokOqWT7v@tanuki>
In-Reply-To: <ZgK0Ap8CokOqWT7v@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 26 Mar 2024 12:51:19 +0100
Message-ID: <CAP8UFD38-LngmtQ3cm-GNsPH1eRv4=-SjgVhfn+twzR2NnuNwQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2 2/2] Port helper/test-sha256.c and
 helper/test-sha1.c to unit-tests/t-hash.c
To: Patrick Steinhardt <ps@pks.im>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, chriscool@tuxfamily.org, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:39=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Feb 29, 2024 at 06:40:03AM +0100, Achu Luma wrote:

> > diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> > index 482a1e58a4..7bfbb75c9b 100644
> > --- a/t/helper/test-tool.c
> > +++ b/t/helper/test-tool.c
> > @@ -73,7 +73,6 @@ static struct test_cmd cmds[] =3D {
> >       { "serve-v2", cmd__serve_v2 },
> >       { "sha1", cmd__sha1 },
>
> I'm a bit surprised that the `cmd_sha1` subcommand still exists. I would
> have expected it to be removed as part of this commit, as well, judging
> by the commit message.

I think that's because it is used in t0013-sha1dc.sh not just
t0015-hash.sh, and porting t0013-sha1dc.sh is complex because it
relies on `test-tool sha1` dying when it is used on a file created to
contain the known sha1 attack.

But I agree this should be better explained in the commit message.

> In any case I think it would be easier to review if the "sha1" and
> "sha256" refactorings were split out into two separate patches.

Thanks for your review!
