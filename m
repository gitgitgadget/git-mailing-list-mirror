Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131248C8D9
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006309; cv=none; b=BFFmhD0lsSrdXeLpJu5fZ/M5yIgbK9vAJm4oS8+Bm6d261IQ0mOBnGAeuvcRlc0DgNB4q20Ae/2+6oYaALuDppZTdKQFrI7VtyeDevR9GM2kx8Pt8dOpq3Hh1oaPXBIyAQHQIoEMlzv5MNLKm7ZnlM7/RZqPP3O57mRiPIrMRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006309; c=relaxed/simple;
	bh=5pp5rTNZr2MunBwVHLqWPj6uWG+NRsy7wLOZORRNyB0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uruocR0HCjUQYwPY8XYvv1aZezsTFckx/uzCY69J/pPQuWWdXI1REVGAzA/6HfvXqC3OfbN7N2sxll/jFD9SgsslHPzuUhtiY6qHs6ROKpNHZHIVLuGZVYyQcDTCPpvLGIKASxyHP9Emsbnu32WPyoj1HN0clUrnWIPKK5vmBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3EIo4B/; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3EIo4B/"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11f36012fb2so9663232c88.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769006307; x=1769611107; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pp5rTNZr2MunBwVHLqWPj6uWG+NRsy7wLOZORRNyB0=;
        b=T3EIo4B//EqQ8xSPM97crbIsRW5uIAAubTlDhlbjziZ73bgVCBN63N8lSUvn/sRBH4
         RoOTaxpL3uc7b2ICwRULkms0CsWQSRLYILfPwQJUFds+rGE3VWACUs4eLI0s4kGulCCE
         Z9Av+8kcL5h25fuiAKlsqjzwuaWPL1+IiKWmRVk8UCWzadHfFl7uQXImN6VVjyxTvifF
         wzl9LHiQwC+FGr3SPsmSUsYythEFTvZOYAzh27/+LB188viyi8X+lv5esrkMDJJxt2Xu
         uWZmrftnp11mBhyd1ZdxILzWJq+CCwqatS9HP8aS4/Lg/Ztghys3/N4FI+87n4mSZPSp
         j4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006307; x=1769611107;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pp5rTNZr2MunBwVHLqWPj6uWG+NRsy7wLOZORRNyB0=;
        b=fmGYe5ctnJq+Y3MMc8kRIRx24thyG9WPacOr8Od75EIeopym/nn2cPPg7gGlhczuJo
         CkZDvAAKcNxRqaU/rSXcxmomByZ8iyZG7YvgYDYW+8pdXGqgEV54JI0o4UAF0BAtRA+E
         zXhnxK7+jDvH1z8Uwab6zk/B4IClPXQlq9UanloNGtKIQIwX++tE1mi4vcVJfKtVYibJ
         snNvOh//7dBr4/gndYp/cfMziqoiVctBl3NA0pSqGrpM+hLJa2TsKUgMqAIPt/HqVoZa
         R+VruyD7WsDRFNkPXS4cROyQYOStp5J8baqMZ9BumpPCYHrpZyPfZ/yGmd+SzTUs9O1x
         l0Kg==
X-Gm-Message-State: AOJu0YzHyAtvFyjtGXdEFVpiwhjshES4lhLq/XA5rOZkNOSRz+5g8UMs
	G/xQfddufR8t3CP4RsIHJiFIj9fY/cmvuVfQb0MDiGAolNyKvEZopcar
X-Gm-Gg: AZuq6aLvjBYfQeS6ZWZHenrv/Fcio7Ae8K3tzXrAnsc/KLRtcYQg/8l7v1+Rl6NWbK9
	tIfuZwnvqsIkT/e9equFZODFFpzRUah3jpiZVrErY5glQcZKFoBa1Ax75uyFiTv81o8m9j+nmAI
	jhYR/a2hnBALsbc9if+M39YkpUVFYMubyXxyv9hE1+1d56KaeLGBxEYPmbsnhkbComcvOaH3ZXr
	c5LKDtRLbbIwLbwTSAYfTJoP1voLslgaLUg/CT8BpruP66e86bhU838WJ5VTXgPwm6d9YynsDce
	bKCB5WOL4HexfSnGqmqbZ7uugXlKh9EMbdSVMn9IBXgPxYj2DWc/8PsYY7U5LHUCNwXV2VHHlFC
	JbCZ0u9mB3Ej4HviUW4X4jJe9Xm8T6leMoPHYfCN+zSISrjSrq/7Hp7de5WRfiU97aTShDRRjLZ
	LdaXPcf9+Fm0DJVUdatGYZELon+wb5bzb89TE9DouyJFOOsnma5csQWnDqPCNhsyVigoFLm+c=
X-Received: by 2002:a05:7022:248a:b0:11a:e610:ee32 with SMTP id a92af1059eb24-1244b35fb87mr12365960c88.25.1769006307086;
        Wed, 21 Jan 2026 06:38:27 -0800 (PST)
Received: from smtpclient.apple (201-1-211-91.dsl.telesp.net.br. [201.1.211.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefaf0asm22640428c88.9.2026.01.21.06.38.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:38:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 2/2] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aXB9976b3Oqf-_Tp@pks.im>
Date: Wed, 21 Jan 2026 11:38:13 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8095CC7-E913-4012-8036-DD2FC5A0E290@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-1-lucasseikioshiro@gmail.com>
 <20260119210932.68893-3-lucasseikioshiro@gmail.com> <aW8bOfVLcG58t-Uk@pks.im>
 <2B17A803-F1E0-4A9D-B0B7-2C62DA3939A2@gmail.com> <aXB9976b3Oqf-_Tp@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> I also thought about it, but didn't want to propose it myself. But I
> agree that this would be a reasonable change. After all, git-repo(1) =
is
> still young and it's marked as experimental, so from my perspective it
> is fair to do adjustments like this once we notice that we've been a =
bit
> too narrow-minded.
>=20
> So I'm all for it.

Agreed. And I think that it makes more sense than adding a new output
format only for --keys and extra checks in other places.

Besides this, I sent first patch of this series (the "default" output
format) to support -z with --keys [1]. If we change "keyvalue" to
"lines" maybe it wouldn't be useful.

So, now I'm thinking about dropping the first patch and replacing it=20
by a new one renaming "keyvalue" to "lines".


[1] =
https://lore.kernel.org/git/5A4D4433-FD38-4BB0-81B6-3BAD33A30A74@gmail.com=
/=
