Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC791DFDB8
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509532; cv=none; b=oTXAPzbe9NC4bPz6O2Im+hNRJ7PfPEbAuoBDvdfc5OqP59dqUaGxSNTliuFomf2KhfApGTwRCU6Oi87mF2nqZhThGJTi2a88wzaiEohiucuZaok08c4SVNBNjRPIjMIcKWyZ2DGiB7iqS+UF7A61b3XlBL2ONcCn3bBuEOGh1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509532; c=relaxed/simple;
	bh=bMb2nz416HMSI0/R9cJlAK/wCqlx0vZVlqopnS4PcIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUxRnnvLS1sdhs8A7W+uNYezzbgJBVNjM2bZZxzaqY2F5OoHpPW3oLysouN1nu6Cfo1oTmIk9PkUQeORImsDaA7nb3Nk31MLS5gHT8itwd+Ouql0w+yzWSmPjQjXLzSgdjli6RQ7PkNiBUuFz+5Svq8tPORPctYPivDHHYOc4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsWk5oGn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsWk5oGn"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so30831741fa.2
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759509526; x=1760114326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgay4+ZMsPsMzFhOOif6qkI3FoliIOcvGnXFXMM++j0=;
        b=YsWk5oGnfBzasKY9Jkeg4YmJeR13zHrTV3GCWoNBiQ9gIjTk/iOKpXqV8GMtNz2kiO
         7+OPiPacXMHgd8knygWbSdv5Zawzg+N848feVoxYgLSptyp/UZZ5dUyw576xQNI82n5g
         VJC6/pRIZt5LrAW6fD6V44yQauxAyvXASk07ON+q89tgVjvrP1HLNA/VNMbv+/umAxzw
         pDnRdOsoFsyu8+3ec5FJEwu0sQ5Cx2xQRZ/i3Xnp02DEzcPRF1SR41LKzPwqJvBVsxPG
         V9TsAPJTv7SyVZlTS+oOfvWUwiN7PBao8OSIMV+8AO2lIySU6ojh10tY7Jz89tUv8BCX
         T2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509526; x=1760114326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgay4+ZMsPsMzFhOOif6qkI3FoliIOcvGnXFXMM++j0=;
        b=CIFLcYf4OM+UQ0KC5ygddoMdU7f421/inwo6Kb6RF+wyRcwkFV+t5qsYEexSPi8dHk
         kyT6KTe2rsStnwS4AKSU3AYdM9ls+2O3zYSPk7Oe/HrE8fTk2phtNCe92QnRustTLcxc
         9zL7DqXzVhmJB7Mg7PqFX0oa0KniXCAcUFE05Cx44QuKyo+oiXj2fJnIHJL8BLhLricq
         W/gQXlvE2/rm32tt7vs+GQZsd8guU9JT+Nc2bgtwnnMNffXwjw8BmqPxm2C7MzBU02z1
         13MYNCaidC4aAEYVUl1Ps2zzzxXMqMTPyy5yq3dNUCDVZ21FGy339UWjjhNzT3tvZYuf
         MNxQ==
X-Gm-Message-State: AOJu0YzULHeGT3AbOMYPv8tVet11JJVgwRWeqexZVWRyhTrJg4xiWXxC
	n1ecKwyvW/evr/WpAvRZPL00HBVBhI51HTxHPRuOgJXYfYK7/eTP5zNYyFoA29izT9fCuyBbkxR
	8aUVhdolIBRL/Dv3etlkCC8klW940zdbZXg==
X-Gm-Gg: ASbGncsHtvLWd4HQ3wM1yvbVUlQlkTyT2u9wgfQP2IDfkrZ7GfaEcd5gT4YO/AdXVBq
	wjLdP3dcQE3MzKxg2EYKhBdC/ipsKfJ2liClGI4evHVCqaIbJG0pnjLTTXBDwMDs+o5nK4Nayj1
	3/01XyQqeb/fre4cA5Sbyo1ruQJ99cYELMtn6+BzegPhhHAraEQdcV0RhFjbNt8i8AMYDFh0zkY
	vOnqLxm9Js35/i/tSY78MdfHRpsoV3jRE9TuADyTDptL3ddUsndoNP7X1NOG0j1vcjKbD+6a9XF
X-Google-Smtp-Source: AGHT+IF/nmPWBtw2vlz4BQs1V0aAFNFAtQAOHp0Q3RN8L6TY3dHA+dN0cgaXdPPCNgCaD2YVn3zBCJz9CGdZuVIeLjc=
X-Received: by 2002:a2e:be21:0:b0:36a:6c51:18b5 with SMTP id
 38308e7fff4ca-374c386ed00mr13541251fa.33.1759509525607; Fri, 03 Oct 2025
 09:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
 <xmqqldlv4skm.fsf@gitster.g>
In-Reply-To: <xmqqldlv4skm.fsf@gitster.g>
From: Stephen Harding <stharding@gmail.com>
Date: Fri, 3 Oct 2025 10:38:34 -0600
X-Gm-Features: AS18NWAKfDX2LRuAvm19rJjz--wBcsop1nio2VtgTrfvB6mG4isjnXdxsbQQdM8
Message-ID: <CAKu9fqysTdO5Q_K68pR=QwdTpaL=tkx94Vmu3jSvbWb0dt6h8Q@mail.gmail.com>
Subject: Re: I still use this!
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip!

On Tue, Sep 30, 2025 at 2:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Stephen Harding <stharding@gmail.com> writes:
>
> > I just encountered this:
> >
> > 'git whatchanged' is nominated for removal.
> > If you still use this command, please add an extra
> > option, '--i-still-use-this', on the command line
> > and let us know you still use it by sending an e-mail
> > to <git@vger.kernel.org>.  Thanks.
> > fatal: refusing to run without --i-still-use-this
> >
> >
> > I use oh-my-zsh and I rely on the git aliases. I used this today:
> >
> > which gwch
> > gwch: aliased to git whatchanged -p --abbrev-commit --pretty=3Dmedium
> >
> > and apparently you want me to send you an email to prove that I, an
> > actual human really do use that ...
>
> It is not about proving, and sending an email will not change our
> plan, but it gives users an opportunity to tell us a use case where
> no possible workaround exists, which we haven't anticipated.
>
> You can change your alias to
>
>     git log --no-merges -p --abbrev-commit --pretty=3Dmedium
>
> and should get output identical to what you are getting.  Also, I
> think "--pretty=3Dmedium" is the default.
>
>
>
