Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7B5C603
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626713; cv=none; b=P8CibWYkPXhSYIoMfvbOam1V28vNaxX4FiBrqvGfbjy10kk5lQ9Fozr4QTYisRRM9QxQH9eG/znFIAHLWAQZ2BHADUpA8UOlsfQoVLzRitJvterabREBVPkIm8U11Hdff66du3E6UNYLyTvx+TtVbsdzyRpObmRH8qK3jjstq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626713; c=relaxed/simple;
	bh=vIl+jG8WALyFZho7B6bDaJFJRBobTXkheVWGT1IEBPY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NNuIFIVjcYRRaWyRU+94RIb4mFz2/Rgr2NWP+oKG4TPZoC+tkNAgPFvigrnJD09Hs6yzTOcOekVdsnuZ5uCvAr3Cd6V3L/70z+GDhbWc9bIgvOcmzMiUMUGticryTi37WPAyL4q4+13l06Fdqwi0hAVAfGRmo8slbWYRK4vdDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it/QItZL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it/QItZL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a0e72e19b5so19723336d6.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715626711; x=1716231511; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIl+jG8WALyFZho7B6bDaJFJRBobTXkheVWGT1IEBPY=;
        b=it/QItZLs1FAq4Dac0gXT+B2qbhfiN6D1utA1ydfW0Mgj6vD3IFSVNe8v4oaYrt1pb
         Xz84lATa5GZ90C4dW9Dm1nCOuPRqzjiE6Wl9Q5fuY70ZxoendQOS+2/eMRLyah19BQRZ
         sq0z7TwvXzFfj2fE9JVA7NWCiknp7260MjcuQ1JQ8vK9UANd5u53jWsWR0BS9RfwEWwN
         GeUqMUqMF+DpUAjN61B7qHf4bsBeDCi3IGCh1F8iYQMEnDNX5UxJyDRuBzWOLTaNN/3J
         Rte9NgRnmUM3YGsHLpZbMoOJnwQSnqgQ7NNUf2hGbJusaT2VUC/+wkAWUnTF/9wH3PVc
         RO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626711; x=1716231511;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIl+jG8WALyFZho7B6bDaJFJRBobTXkheVWGT1IEBPY=;
        b=ryOa+vC6taGameO7I3Kdnm+7kh8mjsKiw81ExkmXzQmj32a94f6LlwkBEdyBQ8ycVB
         /IUxCXs+ZkN7djM94l56CKg52OEhBrJWhD1QeJPg17MxlgIQcVxvDIBWrFtRJjjsORA8
         YbcP96gTxTaJI/V/B0oLkFjnqbNGPhU2dtB9LUZrvKLn0J3ycS3KRXE5A5rVKkloy8QQ
         k4FphYsZtFgz8M3yInCr7/gHurwSD+jnUHY74yAh0nWeZFWcxM8Lc40CdgGkYi0xzAM/
         zpTsz6SZ4eIjhGD6s9W3gP4mdeg+AmAqepD2q71+LOEYlpEveNibDbJiBl10CdiRjnan
         emfQ==
X-Gm-Message-State: AOJu0Yyj/3U4rchsfmfjPEXHuoR9nQX9BanQY82/MgGQQsZSLLwaO3sm
	+8phozGVxzWkzSePaUe3qqq469GZH81lnfG4w+TEFiuckRPDOfnqS4hIqz5u
X-Google-Smtp-Source: AGHT+IH8X3Ojs+fROTJqx7XKbJKzanHjgvoIaJI0LOpY5izuVDoc5tb4arQuhvabqhbSAxZCJ0qQMQ==
X-Received: by 2002:a05:6214:4388:b0:6a0:c8c3:7a53 with SMTP id 6a1803df08f44-6a1681aeba1mr114000266d6.31.1715626710223;
        Mon, 13 May 2024 11:58:30 -0700 (PDT)
Received: from smtpclient.apple (syn-074-079-217-104.res.spectrum.com. [74.79.217.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1797e0sm45520896d6.27.2024.05.13.11.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 11:58:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Bug in git log -S
From: Sam Clymer <clymersam@gmail.com>
In-Reply-To: <8bfa50e3-996a-407b-9c02-a9fcacfebc4f@kdbg.org>
Date: Mon, 13 May 2024 14:58:18 -0400
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B9537F6-A76A-4CF8-9EE4-2CC3C98D5784@gmail.com>
References: <ED9E5AD9-D15D-4E63-AF80-209EAAEBAD5C@gmail.com>
 <8bfa50e3-996a-407b-9c02-a9fcacfebc4f@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

There does seem to be a bug on my end. I am searching for =
=E2=80=9Cnet8.0-windows=E2=80=9D and it=E2=80=99s not finding an =
instance where it=E2=80=99s added. It is not a line of code that is =
moved around it is purely added so I think there is indeed something =
wrong with git log -S.

Please let me know if I can be of help in resolving this.

Many thanks,
Sam Clymer

> On May 13, 2024, at 1:55=E2=80=AFAM, Johannes Sixt <j6t@kdbg.org> =
wrote:
>=20
> Am 13.05.24 um 03:40 schrieb Sam Clymer:
>> There is a bug in git log -S where it doesn=E2=80=99t find every =
instance of
>> the search string.
> -S does not search for *every* instance of the search string, but only
> for those that change the number of occurrences of the search string =
in
> the repository.
>=20
> For example, if you have a commit that only moves a line of code =
around
> that contains the search string, i.e., it removes the search string in
> one place and adds it in another places, this commit will not be =
listed,
> because it does not change the number of times that the search string
> occurs in the repository.
>=20
> There is also -G. Maybe it is what you are looking for?
>=20
> -- Hannes
>=20

