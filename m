Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921A175A5
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754372205; cv=none; b=MQNhLR66P+62RJEhWeItAbY0SdnSF3IwAXb1RphDzRBL/PSvQlA9wNhHWCq/Tnpy42dn49bDmVliLLuANv38aLBihBcUxkPaXJA9d+7/dN9I4lPfeM5v+BH3kJoYbDRgtjLT+v9pYZr8/YPOmNsNl0JqiIAcnc9gLKmizi8dKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754372205; c=relaxed/simple;
	bh=tMptUgGHZ2XD784uNtUGMvmc3cQBNYPUp3ZlX03vs1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJ3OLBfX93+DpvKSXG5cQZATxtGTyERH97aSNrTKEdSCDpNVECXn0swobYVuh58D0xFrnSRoeHuRvnAohqP+i0UhMmLHw7KYiAU39in3RVgBK2/I2/9fZT7rew8fFM2A1/JKEbreyHITFGb4bExaTd6xQ8wBKqzxIcnD3N6zWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OMjzm7nI; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OMjzm7nI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754372200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMptUgGHZ2XD784uNtUGMvmc3cQBNYPUp3ZlX03vs1k=;
	b=OMjzm7nIpyUH0fAs0DuBhXybRm7UiWmpro6QM5s0rwZ1jjEkk5xAp2sSKe7dNGUJMU4R3r
	p4rMXrA993FpXdmiNTWaIb0li+QHM5zW1DkgRf3Lv4SBwR62Cu2A0FmOYD/Rdgu/G/LPls
	UUJvaJgoRjHncqQlrrKNMXuBpuBeMgQ=
From: Toon Claes <toon@iotcl.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>, Patrick Steinhardt
 <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, Christian Couder
 <christian.couder@gmail.com>, Jeff King <peff@peff.net>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <5029495.31r3eYUQgx@cayenne>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <aIsQWcHf82ipHoWf@pks.im> <87ms8jui3p.fsf@iotcl.com>
 <5029495.31r3eYUQgx@cayenne>
Date: Tue, 05 Aug 2025 07:36:32 +0200
Message-ID: <875xf2uy73.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> >> +
>> >> +DESCRIPTION
>> >> +-----------
>> >> +
>> >> +Shows which commit last modified each of the relevant files and=20
> subdirectories.
>> >> +
>> >> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>> >> +
>> >> +OPTIONS
>> >> +-------
>> >> +
>> >=20
>> >> +-r::
>> > -r, --recursive::
>
> As a newly introduced man page, please switch to full synopsis style and =
cite=20
> only one form per line:
>
> `-r`::
> `--recurse`::

Thanks for pointing that out. I wasn't aware.

--=20
Cheers,
Toon
