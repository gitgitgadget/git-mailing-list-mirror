Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0220CCD6
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438874; cv=none; b=PVLRPQrpZpVF2QypacpHXHFDPU/wpxbnlJqyhDvy9CkWGGUgh9L53k642Nj9HVKXnoqBhvBk1hnZea9iJZwwzGVdk9VZNpB/gDjllUq0b4VY4V0hlkR8f9z/237YSdGalbnDsFr63zhTlXc5/GElCycU3DsdNcANV5p+ho3K9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438874; c=relaxed/simple;
	bh=IqRBrVBD6+5OT6EKC7kHkdjIe7ripmDtvxG5T9yAwJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTYB3V7hzNEqZLm9ChkXGS/hYsvQbPC6G3Fs1CIQUFu7rb9RmHxPkeB1b3QPdk4eoGw3J4cEYw2MhuAbsrZy+tSpcJXdMlKGXD4Bk8sqrU7+pOGUSS1WkogANERB4e7GWW+RIOqP/o3VJTvpw6rjbG7h+0mPRQZzx09HSWraYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZU11cTP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZU11cTP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so954530a12.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739438871; x=1740043671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqRBrVBD6+5OT6EKC7kHkdjIe7ripmDtvxG5T9yAwJo=;
        b=AZU11cTPGGNz2NXMYKUnBkmzSRlkB/mG9z9Qdc9r7cmN9uRGOE0yrj2tM6/qpa2mZW
         VJTa87pKSmH5yBAfW3SCGRjQ/npJtsNtTiq+rvcTaxw594un4k3sbW8etnd/rGECqb/k
         lQAojr9GZani6/J0ljI6YS1sNor3u3MhGsoy0G56tobwwhwhFUdZYlnvmdZrElwZzXgG
         0q4B9VrvEw3AfQAzlU7xfdIA+ctd/ZioNJJt3/o2R37rxgH+cAeqVOzvbbpoo/TW/qqE
         s57uMMEAet1Upo5csaSvtAAt8BAR4bxnC5MMj5PyWOIGCWLh0rlipdVU7lelJIQf4YZH
         H8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438871; x=1740043671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqRBrVBD6+5OT6EKC7kHkdjIe7ripmDtvxG5T9yAwJo=;
        b=db9IjgLEeFfiocGRjYk2zHGOcwE4xe42TxIn5pu7JMMpKZN3GdpD55TAvIoaL0MmF7
         WAAPeHmkbeNqgnh2PpJ24i+SSzo8OuWwvk5l9iqfkE83x8zgg+6GI4z0Cp9tEBRfq46F
         hsLM+qmCrgYhtBqJtHR98/9PqnBWpy8aynfHd3PgKZCWNc8mjzYEh79dMWHMv/yoz4Tg
         a81HEm/B3j+q5SD98zstJQczZmoJ2T1+kzU5Y1q8zUCRcyRElsn4aS0jSAQfE8JF5hex
         vkv7YDf79ppnWmgxpStp7b1737gSxk7W3r1fEFmUIT18HAGIFuIqwgXkfFts3QodvRIF
         EBcw==
X-Forwarded-Encrypted: i=1; AJvYcCXvTjQXzdz7HeOLjMAqshVfCbQ8pOYed8mYxhMil9dDN29825YrNzGiX8hrssGgRmV2Ej4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYF7J1eGAI80bnPcraVHDY+JYcd4zSCXwmM/xW34VMdQ8nfsjQ
	+09cqFXXI3I1g/gAqp7BAMtfdXNc2eKzVMVb1HKYHNCvyr9Qhjr6vTIYXab8lz7EbZSO5uO/DXD
	YH2sv6hRqnNGz3zdbn8zszwh1o/uHE6y8
X-Gm-Gg: ASbGncuJSh0RqRbz2ToSpZ2WohPvRcO9yYL3ufr4bn0sHBbhxloDUqJ45gcw8OnWnt1
	IHtalSj6tPEUVv84ClaHYbkGglXJbkbk9T98zp61c3u8TfKSmM8MLNEELZNnCFjAmZsv7eW8ElG
	A=
X-Google-Smtp-Source: AGHT+IFx9o7I2LJF/I+eRp4UFaolO+zqj6oCB0V+4TzhHMETi4z33qsACbKDNR3l+MahJzI3i+AO275VM8J1ZJP1tvE=
X-Received: by 2002:a05:6402:a001:b0:5de:c9d0:672a with SMTP id
 4fb4d7f45d1cf-5dec9d067edmr1397130a12.10.1739438870975; Thu, 13 Feb 2025
 01:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im> <Z62booOOXODOl_sZ@pks.im>
In-Reply-To: <Z62booOOXODOl_sZ@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 13 Feb 2025 10:27:39 +0100
X-Gm-Features: AWEUYZmzYXsfQvGCxPbbBNRqAouBeeWJXKOWg9Ouusbm9s8cZC25SyVLZeBbljo
Message-ID: <CAP8UFD3E8_mTwneUgNkC_hZbkaeznAT-dG9njT5wjnm-=iMmcw@mail.gmail.com>
Subject: Re: Poor performance using reftable with many refs
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> We end up with two tables: the first one has been created when cloning
> the repository and contains all references. The second one has been
> created when deleting all references, so it only contains ref deletions.
> Because deletions don't have to carry an object ID, the resulting table
> is also much smaller. This has the effect that auto-compaction does not
> kick in, because we see that the geometric sequence is still intact.

Not that I think we should work on this right now, but theoretically,
could we "just" count the number of entries in each file and base the
geometric sequence on the number of entries in each file instead of
file size?
