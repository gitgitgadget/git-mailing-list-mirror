Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18C2AE78
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204899; cv=none; b=hz5S4HvIuohXGw4eXV4ee9jT8pRjwPA0kKfPO9yvATQhsSu3PjULZ4ULwgG2IIlk5bazSm/eNEniJvk5vOMquViYsJQdJoksLGxsUnKWp858ke30BZDm0P9ZhFOTD66GCjnWisE8O8dWrfdH5/DvepOxwT6uFfZzrA+Cft5a9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204899; c=relaxed/simple;
	bh=Ww2Dwr4TcGa1Mf1snhuRFXwHfZjbgHgPjBawc80k2hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b5tb7hrFVXBHI6TqYVs1CC13B4r8HgKGDBeZiD3Sr2QM4NPkiDKxFXYKUdcd67nuiDNvYtuR0Es8pZFrsFVeBNenhHMrEjuxOlBzgHPmJ3RPhyreDLMAdwrp3mf+oaiza6B5Zkm1GVG0GQwJRAIDQTQjfy9Dxh4PS0hQooAO9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rsnpBqba; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rsnpBqba"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765204894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0lYNZk1mv/x2fsua7RWQYSaf/QDN2+Z8+F75h9bz5Y=;
	b=rsnpBqbaCwlVRo8XPSY1RSQevCELPiAQWFMTeHQHU9bsHL8Pdrg8ob3EaUMoWKdkrGrcl4
	LibzZAp1aPIb0AAY62DMICK/BdwS+wYViVftIXuKg9aEc2KnnlICDuzYLGGVAk3s4QMkyv
	tlkhuEstuBitmjSIj9WYhfDyqVMYqOA=
From: Toon Claes <toon@iotcl.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] Few fixes for cross-compiling with Meson
In-Reply-To: <3tucvydzaelj2mngkocb75l52nssxkkdtt3dj4paviatd3uvnc@u2sy4vig7owz>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <3tucvydzaelj2mngkocb75l52nssxkkdtt3dj4paviatd3uvnc@u2sy4vig7owz>
Date: Mon, 08 Dec 2025 15:41:22 +0100
Message-ID: <874iq1vxwt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Tue, Dec 02, 2025 at 11:48:07AM -0800, Toon Claes wrote:
>> I was cross-compiling for s390x.
>
> Just to clarify, you mean Linux on IBM Z/LinuxOne, not 64bit ZOS/ZVM,
> right?

I'm sorry, I'm not aware of the correct terminology here.

If I run file(1) on the compiled binary, I'm getting:

    ELF 64-bit MSB pie executable, IBM S/390, version 1 (SYSV),
    dynamically linked, interpreter /lib/ld64.so.1, for GNU/Linux 3.2.0

And readelf(1) says:

    ...
    OS/ABI:                            UNIX - System V
    ...
    Machine:                           IBM S/390
    ...

And the toolchain used was installed from:

    https://aur.archlinux.org/packages/s390x-z13-glibc-bleeding-edge-toolch=
ain

I hope that clarifies it?

--=20
Cheers,
Toon
