Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7258ABC
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483568; cv=none; b=IKYCiub06DGcuYRP1KNHU4Ed8E1VUAg5EolSBSasgO7fiO1MO1ti+oCN168aQ0Ubily7s5fxsjDhkwM8zq496zDx072X3pglx7d/WD6ojKm4g1tNj/zuMMkPmvtIg2bHC+V8PZt2lEMl4zh/vSnarHWWgEBB9D9nBTDRAMnQj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483568; c=relaxed/simple;
	bh=iEeHVPtR9rFtCXKUNs/zPKoemABR7p2Bd9GnOZ8qc7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJxkLIYMP2apgxWmMODtDvyjTVpCi0TR69C7At8QEb2yNyxBv6RMRuaom6HXUp7ZWCHToc/OjJmI8gyZtWcR72cyGGEef97nWmFnFd88lhYky1P8i08BP46VjhQbD/xA7HXT3mUj78cXyA6PTRdlxxHH9qoZlULIj8L0M3ms4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b27ce83663so3031966eaf.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716483565; x=1717088365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEeHVPtR9rFtCXKUNs/zPKoemABR7p2Bd9GnOZ8qc7E=;
        b=Yb3aV8nwYyZUDpHL7fs/7rlakpkTJC4HuXpzLq0yOD78y+nj6BpTzVvHBu4Ufg4zym
         o7SxMJRR+V3rehFls81bS2VZo1HVhYTWhee51IOpSzORC0mkmBn/35FgnnYyON7ybMCI
         c7Ict5dURdFddj6J2HpypFeex2T4QCwyqpKvve1wm+ikfd078nCKLTDJhmxrNP+LHVxS
         KmS/iQTmNH2diXEBBu/xemD0T5pjS1KdbleFbLxoKbhtgwYELsUCDWjccoz2ujzmFKbD
         aPEQQSyUvElCdfXs/f2kYwBh4598hKk5J7BMCbr3+ojnr0Vs2ASI9A70GO9gIkBOyhkl
         wOAA==
X-Gm-Message-State: AOJu0YwElCWXsoxh8CFNbYt8retkC+xfMyLSs73FjmTNBE6VMxX7/FK2
	A6Hm38lWRJp1o3Nbx8X8bwjixkT53x19sUVG939A5i1zM2+RH63TCbwhK616HU2g61mY42rAN1K
	3vYEvT9IyxsFmMiwC6711D+bRX2o=
X-Google-Smtp-Source: AGHT+IFFr498ZvbAoPEx8rn35ZvtqZohQp9Hx9xlQfiVC+6a6JWh8+MVLredGn+8/OyXDM7VhrxMXuKVLMw3GsEB5ec=
X-Received: by 2002:a05:6358:5293:b0:193:fcb7:767c with SMTP id
 e5c5f4694b2df-197e546a0c7mr388055d.25.1716483565106; Thu, 23 May 2024
 09:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716465556.git.ps@pks.im> <18dce492df7d4337dd639be767f2fe280083e9f6.1716465556.git.ps@pks.im>
In-Reply-To: <18dce492df7d4337dd639be767f2fe280083e9f6.1716465556.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 12:59:14 -0400
Message-ID: <CAPig+cSiw7=Ah6o=i=BzSvbrvKLK3BtXJJX0BSQ7cJA-Ke=xww@mail.gmail.com>
Subject: Re: [PATCH 07/20] diff: refactor code to clarify memory ownership of prefixes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The source end destination prefixes are tracked in a `const char *`

s/end/and/

> array, but may at times contain allocated strings. The result is that
> those strings may be leaking because we never free them.
>
> Refactor the code to always store allocated strings in those variables,
> freeing them as required. This requires us to handle the default values
> a bit different compared to before. But given that there is only a
> single callsite where we use the variables to `struct diff_options` it's
> easy to handle the defaults there.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
