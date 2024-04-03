Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25714A61D
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159479; cv=none; b=KRTKqx7Onc39FQI1CGXcTVtyMyAP8M1tL2RZAunvyIUvskLSVAEnIOKGZftarPjWSaEHgXFiWe1t4BAZ9gz56Yc8wBDPX4RuYRAVcshMyIj8dG7M6e3g5eatA725Gp4ohEPI57dvqbU4L6omu+E9OiI1XzSwmUW2A5xRwB4f39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159479; c=relaxed/simple;
	bh=jScDsa6qXDpHKx+aJMUAbipssUXmP/mTOl8Dd9Me2JE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EUeb1lNm5JwJpWIpgKY6r394P34mvysYR0RdMvKYwR5gwlr1DgedlOLuF++u3pGPKdfwCf+K2bhzyusOiCPYgIc6L6RddjDJDelGDZsMOBLUX+umEVv8aBRaO8cdwflOK0IwGUdHqi+uaRdvSNLHofarO8VCLNA9j2cIXEk/gJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmDiHuS3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmDiHuS3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34339f01cd2so4016083f8f.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712159476; x=1712764276; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jScDsa6qXDpHKx+aJMUAbipssUXmP/mTOl8Dd9Me2JE=;
        b=gmDiHuS3f3c7bczLULZ4n+M4DEu3HvncpujlIPeiLXH+kwgN1OUMDkcr5v7AjYTxeQ
         Q56oZvczQcNEuoXJoiuOOzhJxOR/DnSLHpMp/vL/01vMetpqLiDsgEJL69ZxLQhqgUJ/
         6YDVFuCzGAN0CXDXud3+3wFf2ynBnosTQ1vyVBCDr9b64kAfQUQjZQqMJ8qrw6ESHrHG
         r7r+RUn7EVxM8H3aqAmV7eXDG7DJSAPiecX2kHCB4V05X0fdJEvjDHhBst3m1cIuvwRs
         O/QttHAyyLOBk08jwxcsZ9nIH5ApOolka88ahZQs0nkp15WyHep3KtSCJ3Blg7FnNy0t
         HAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159476; x=1712764276;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jScDsa6qXDpHKx+aJMUAbipssUXmP/mTOl8Dd9Me2JE=;
        b=vm4a0AbvvZVZTF7mQZTTrTeZ9Y2Xh79VTVOYbaNvz9fvClorvbO9UkHEzpNrTT5RGD
         p9oZgwK3calSqF9sTvk7vI4Y1FOP5xQDcLUFgd5FckrKPWZeLBZVjAxzCcFZUCVPuP7W
         fDQLB+Xd3nHRPVm3/XLZDGWmHTiznJTicp4J0C0E+9P2SBk0NsNv+pEVovaUKunOTT7P
         z7Z8+QN/u92DN3DfIciQ/s5bujW3+PjEZp3ZnFn8KW4oja+VwPklnXj6pkZptdsCFhmy
         oqkZLktyWrbE4BJdG46Fb+P8MirHbrMthwKHd4pqjGVrDStNrE24n6uuswCZ9io5Kl1v
         aZNA==
X-Gm-Message-State: AOJu0YzY+VLMaWo0G4o8vRaa9I9Gx3tnmQ/ESCNTKyWDtuQNNBz3KZeE
	kh4KWfH50z9eOFu9aIUi+MD6AFa2RgZjXJ81QL4hN3mP5/ReeV5mlzPdnQ/cTNB9ZQ==
X-Google-Smtp-Source: AGHT+IEN9ZmUzVQATP/wUikvVHePUxFAKHHthUr22iYhAKArKO4o/mMVa182NSe92xidEh8+f1+42w==
X-Received: by 2002:adf:ff8d:0:b0:343:827b:dcd9 with SMTP id j13-20020adfff8d000000b00343827bdcd9mr2149228wrr.19.1712159475751;
        Wed, 03 Apr 2024 08:51:15 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:38e0:b537:6192:57c2])
        by smtp.gmail.com with ESMTPSA id bl26-20020adfe25a000000b00341ba91c1f5sm17434193wrb.102.2024.04.03.08.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:51:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: reftable & jgit compatibility
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
Date: Wed, 3 Apr 2024 16:51:04 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <64970945-5E37-4792-9F37-790CFD82A1BF@gmail.com>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
To: git <git@vger.kernel.org>,
 JGit Developers list <jgit-dev@eclipse.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Han-Wen,
Thanks for completing the ref-table on JGit and kicking off the work on =
CGit.

> On 3 Apr 2024, at 11:36, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
>=20
> Thanks again for taking up this work.
>=20
> As I'm browsing over your patches (and realizing how much of the
> arcana of the format I've forgotten), I hope that I did not make any
> errors in implementing the spec (and/or that Shawn didn't deviate his
> implementation from the spec). It would be extremely unfortunate if an
> incompatibility between CGit and JGit were discovered after it is
> released.
>=20
> So far I have always been able to read JGit reftables using the C / Go
> code, but it would be good to systematically test this, ie. generate a
> bunch of tables using JGit and check that passing them through the C
> code (read & write) leaves them unchanged. Or perhaps check in some
> tables as golden reference data.
> Josh can probably connect you to the right folks to help with this on
> the JGit side.

I am happy to experiment the support on GerritHub.io, we have over 40k =
repositories !

Luca.


