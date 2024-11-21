Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979641B0F0C
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194728; cv=none; b=TuUgWCIAr2lCRSOad1Y5RX80UmLi/hXxazSDnXJ9GAiornBZAokYH6aq8uu1LZXkVfYBfPoMhlOBaNYZl1zmaY1h+cqRcwYGLK8jB6abs2yFbEYK+liYmIF5nxyAy8bM/HUK4iDgu9VU80dOCKrSP2WA36g6ypj2oE3VWssZmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194728; c=relaxed/simple;
	bh=sFnwE8bGC4bHquSfDK5NsgLr2+dvtKCO7fL7Cx+tR64=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrDv1hqBhRmp3ifnL4E4/FdtxxTplmKH5P9H5YEz4FXbxVVpRJlWRBfCYFIjn65orf6RYIcoeCrppeCTyjLWfvz7spmraWpEmZ8+fsEEei3SMnwDU7l3bwYX5FLLJ7rihlt7PTdQaq3G7he6HzdldxriWNRhltvq2i9jGeyGxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqI+W7mt; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqI+W7mt"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5f835c024so520565b6e.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732194725; x=1732799525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fIN9sVPws1v5cIb8/vhUg/aUeTlOBsfvq3at9uUCf0=;
        b=dqI+W7mt2HwlQXaABZyCOcblYSxcq5eooBk4rOr/cNsi4WEV/+esTZnjfPJbjLvk3d
         vGsU5iG3/wIvNQhAwCdfetz6o/jLLzc5nE+CfSoODKhA+sS+oZ+7aspp4B9yiUO5jPuA
         pZWWduZ8PTCKqtQLo72yhgS3yoKGGsTO8lo/txmShsWM970dfM6e6Ta2Hwpz5fNlHpaD
         muK7UjZ/Dw9peiHiPTaSrwyWVk0eAzHRV8OO1geC6bRhi5ukAhHccnT4YyfO1fAnrV/V
         UEK3SEARHMnhILcSPiUkfSHtLaqT2Cup43UnV2KXbUHv1p+0qf6ZuoXorvpsZyaW1RZl
         nAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194725; x=1732799525;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fIN9sVPws1v5cIb8/vhUg/aUeTlOBsfvq3at9uUCf0=;
        b=kMm8PgI9+x7xRy/ij6StjhK4Sjp5YL+0Biy7pBDkMYwSf6DzKOHocm9zmOBfmRiSym
         K90aqZpqtf0dJMx/XNSUTpSh4SJB+PZIAfn6EfXrtlBA1JkMtQUXf6fzAZyhaqclqxeO
         kPYYMhf6XPoObsQ2TlLltLykHPzt4QFpI0qS3L+eZ/70dYqmmZQF/iyUiUxAykmqyS/f
         YvLrP0uMMqVPE+fnszZojVds5i/Md5sLUk2j60McJHDSglhbKGoz8CrIY262rgK2EBMP
         9YtEyEKpiuA2vAHAtHAqk1lNlegjZRv+RWqQvBqcO3k5zbp5YZG8XCTPBW7pkgtaFgb/
         h3nA==
X-Gm-Message-State: AOJu0YxWFNpI76nInrBx0qC6Qmj0sWD6XXsA+5BiqPrnY8TgJsUVWCw3
	kK83bW/b7Z9m2iUMcTJIXAnNhYau+ajnXhI9Z8QS2eViezNtQ2/uxKdLSsRRaQsywYvGLeh6dL+
	XCHP0dtwFIncS7J0M6X2RNUStmhY=
X-Gm-Gg: ASbGncthx67D22bBbu+RsaPvUT9FEMYMT/o1FVMrQyTjp4O6eDI03EKwtKl2QmhbEFw
	dkS6BM+P25bWYcYcM7nmXjTUGDxRs4/XSpRA1XiLVk01VxW3LAwn+w9W3u0Y83ZqSFg==
X-Google-Smtp-Source: AGHT+IFZX9+8iWI2hvTuKKM+uiVa+kfjE4Gm+NrikXVo+mBYCpexjrSKhXnlTEROKNmV9WaM58VB1MXdgKgGFbHPv5E=
X-Received: by 2002:a05:6808:1593:b0:3e6:4f5b:afd1 with SMTP id
 5614622812f47-3e7eb68d12emr7459987b6e.6.1732194725627; Thu, 21 Nov 2024
 05:12:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 07:12:04 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz5o35FZPFyM5KyL@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1731323350.git.karthik.188@gmail.com>
 <Zz5o35FZPFyM5KyL@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 07:12:04 -0600
Message-ID: <CAOLa=ZRVpq7=tRiCrJD-do+PKS-ek3m58bpUm9S7t1oKepiLNQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] packfile: avoid using the 'the_repository' global variable
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000004e2a3806276c0314"

--0000000000004e2a3806276c0314
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Nov 11, 2024 at 12:14:00PM +0100, Karthik Nayak wrote:
>> Karthik Nayak (9):
>>   packfile: add repository to struct `packed_git`
>>   packfile: use `repository` from `packed_git` directly
>>   packfile: pass `repository` to static function in the file
>>   packfile: pass down repository to `odb_pack_name`
>>   packfile: pass down repository to `has_object[_kept]_pack`
>>   packfile: pass down repository to `for_each_packed_object`
>>   config: make `delta_base_cache_limit` a non-global variable
>>   config: make `packed_git_(limit|window_size)` non-global variables
>>   midx: add repository to `multi_pack_index` struct
>
> I reviewed this round, and think that it is looking very close. There
> are a couple of typofixes that I and others have noticed, which are
> minor (but I think in aggregate should merit a reroll).
>

Thanks for the review, indeed, I will be re-rolling with the fixes
discussed.

> I did have a concern about the conversion of delta_base_cache_limit to
> be a non-global variable, since I think we're determining that value
> from within unpack_entry() in a more expensive manner than is possible.
>
> So I think that merits some investigation, and will likely result in
> some changes that we should consider before merging.
>

Yup, I'll move it to the repository settings struct and this should help
alleviate the perf issue.

> Karthik: if you do end up rerolling this, please feel free to include
> the patch I sent in [1] on top, which should make the maintainer's life
> a bit easier than adding another topic dependent upon this one ;-).
>

That makes sense, I'll add it in.

> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/884ca9770d1fb1e84962b1f700b1ce4adce6321c.1732142889.git.me@ttaylorr.com/

--0000000000004e2a3806276c0314
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 75ddecc832720783_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL01hTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0JTQy80Nk9DZDhmdCtZeXlYSHdQbWc4M3o2NENOeQpGb2JVNkJ6a2g4
YStFRVhmSFJHVGpXM1hTK0MxZXVnTVZwSXlCYXVaUXVjb0szYVNiTXR5Mmt6ZHA1WTloc25RCm5v
OXEwbitSME04YXVuS0REU2tJU2szamlrUjh3QUlWdk1GcTFpbkRMUmgza1BQYWpWSmJKTjdGQm5L
NzZYYkoKMk1PMlRFaUIxUHZKdzQ1S1U0L2tjZWxUVlZIcEJVKzFkY296WVo1ZDZqZk5STG1rTkNR
dkxhYVZ2Z3hpTVMzNAp6eGVNZ2xqTmJnVDFjRkwxeW9ocjNRdGhJSFJvbU9maXlBR055a1RJRUta
a05yZm1GTUFYWTJJUmVIZDR1S1ZjCndnNk55Z0t0VEFCWE5NN3B1d2lsbVhHV044dG1LOXMzNlV4
WHFUU2ZTMnZsOUMySHdKanBSdkJobFpMbUFYYkgKZ1lueEVMNmxLZTJwczRGMUd5bm0rc3JYblFx
K2M3Z0UrQXE4WTQ0emdvOGFTY2xORU5Bd2s1MEZjZk1BbWNtSwpwek53VmVXNllXREhhb0lOdmIw
dEJtemIyZlhJdTlzTXRFUkdTZ2x1Z0MvQzc0c2dHeThUaExCZHNHNzZVZDRKCmZsNG1UUGlIbkNQ
QWZBYk44d2diNFJ5b3d6ZnhNc3FIbmpDa1pSOD0KPUNrbTcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e2a3806276c0314--
