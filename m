Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D8253939
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340248; cv=none; b=H2vnnErBqMtj4aJNocIzXlVsuXOeTYHKqhjqqZpupFWMoo3DWhoSwkgtt9svxVRBRXwQyvyKK7KWAiBrkRKSVZmTCf7HjjC4ZPzuxGQIflsW93mC5aa8UOWZB6bN6kDahbwvlLjLjByqC/maUcIIM+Gg5iRpc/m97JgUgLvoY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340248; c=relaxed/simple;
	bh=UQHQk0AkvX2JIKFqPMarso2KuAchhaFELsDnFrqyjNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tBToucx0TLCYuTZpuUzc7P0wG/i7/5ZMqaX3L8mYtO2Uok2oghg+oSEVKOUSiazxCQX8xRLtAHjYDPFTQUs1+VSmiNJ652P2te8Pi+7We8Eqi+9D2gtJzEUyzPLzFrfMz0kaK0iDiE2yREaUgQqCptoUfkBiTxyPcT9HWP4mRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZV2n5HH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZV2n5HH"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so1139499a12.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750340245; x=1750945045; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsPfrNDl55caSTMe6pQcQx5IveJ8DgaSTngHChz2QWw=;
        b=hZV2n5HHHLWdFcMea1zVj3YiRupkWeEV4k1ceQjNyLjGxTH0UnfCz+EowSg0jIb44R
         N5xx82o0DOCTPdaOjtRQNWgL2npeG9vhVXQ/AFkQisOxqjdO4LP60eRwNlP6ckoHYxA6
         U29erb7u+HK71R1da7ydiaD1Nq8YmXFTZaLsFvktMCLsKQdlfBXPtelRks4oDUEMnr00
         Uy1evplhzZgKKYXsv4SW1x2MImWzAIYbSqunBy2xVKhdoSTXPea78c8WtIDqxcbmCq9P
         NxVaD1rsEraQ06SVMN5H5V+TRfI7WcBagSNbLl3zw1JnCKSMmlKhJfCORXDP9RZT+tiw
         ds9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340245; x=1750945045;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsPfrNDl55caSTMe6pQcQx5IveJ8DgaSTngHChz2QWw=;
        b=pCqpEsiW8lAPhgG1MtHgoxy1nIoGaDDYJslZejilVpaJVC3mvgZ34bCwVibG+V+urQ
         efquXBLk0Ho/cfxqfiJQPuAI5eEvroLa+czheTBGBoBF7B2dQq/5gMSfpAxoj1wFH/B/
         EflKppiGmhboZPk4s+664JtI6jaQ4L6rPFWVTX041sA2HOJn5f6lsJSUKEfjk56e2TrR
         j24GTvwazpiOpqDpJA2xHkiKeAClLzphqznTH/5BqdebuPkZWkec6fq4StVSXOAuunwj
         29bo0ZLEbr4q0Px6m37MKvGoNsu7KAnYFs8bKgOoPrQQmi+h02kB2LrslI0OaHeFoQgJ
         cA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWztbxuNhBbHwZsOZjVi+oqsDueRUdw9HE4VUZAA/mT6BI2zhHfAIJAk5IBTGlzzBqOw64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70OkVOvww30vFLB5OLm1qm0q8lI2aEG1QMRCFZ50PehQ01pwm
	yExXmRVr+Aiuq4a7oWgFull8U+laC+wJPjciesSaSAKLCfC2Ddvj/5KzsBmKhGWpimJFFKyiSq3
	eA7qi7R18RNmeTkF+RLBS8VN50w8QKqg=
X-Gm-Gg: ASbGncvyaf4z3JYvD8uMNaAm7QD/hgsdlt6Td91p+U74yfNCXNR+SAcWY7nDp2ITt1F
	fQRyhNwk7d1v/bCO1WviiEPAjEmk5qB5H7tQfl3gadv5T2jRTXRLS6Y9nkB9r1wjVTrVcYHYP5t
	vNQUQ+QxKuLLEq0TqidZ/7TzixyTpqdZTasu9ILhmxmiWyEg==
X-Google-Smtp-Source: AGHT+IE/3+cinugMlDqJJlQaq91L6HqX39szETagim+Ogm6WaMAnWiWssEWPcoZDD2i8lBAVJR67OmWMeBVAJZb8POM=
X-Received: by 2002:a17:907:a893:b0:ad2:313f:f550 with SMTP id
 a640c23a62f3a-adfad412330mr2169136466b.29.1750340244912; Thu, 19 Jun 2025
 06:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com> <aD4i7YhUnT5Kgew-@tapette.crustytoothpaste.net>
In-Reply-To: <aD4i7YhUnT5Kgew-@tapette.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 19 Jun 2025 15:37:12 +0200
X-Gm-Features: Ac12FXzX4JzqSb9sjtbc5myqgp5B6UcKufxnLAdT9_xozP3TVefyqyA0O6iykNY
Message-ID: <CAP8UFD28y7_AUGndCyPDTc0f0odufdTAW5vReM5pMGeCcAerYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] extract algo information from signatures
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:17=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-05-26 at 10:33:08, Christian Couder wrote:

> > brian m. carlson however replied that it would be better to show two
> > pieces of information instead of one: one for the hash algorithm and
> > one for the protocol.
>
> Actually, what I was saying is that we should have one for the hash
> algorithm that is used in the Git object.  I don't care about the hash
> algorithm used in OpenPGP, X.509, or OpenSSH (that is, whether it's
> signed with SHA-512 or SHA-256), but we can have multiple signatures in
> a single commit such that there's both a SHA-1 signature and a SHA-256
> signature.

Thanks for clarifying. I think that's what I implemented in v3 and v4.
