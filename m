Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C03EBF2C
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890847; cv=pass; b=n6JCnvZWDbSHTs7bfN/jNpVAXlFTNWa0wxFogQdC8OAjowrYT22ncLGq4Ly1NSSGWzKM7YoVajaSWqUfN96anH6TMGYI/ZnM9ReKWlizNjG2QQOw1+C9wNqfyLHGnkkKSm2jvmaN/o0xb1KUA/LzgTnGSD+ZDAkrbF5FnqLORdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890847; c=relaxed/simple;
	bh=WYFTWxPT/PZkC3bBAbwInGOdiJbgPte7wb9A5z+A9C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1vxR0yBy9ojdlbO/GeqcQkVqBzyHa/jevn/Bifd57uBvYOCa4+dNgd+ngRcwQUedKogIGDEYKxbWV2LI+KgurIBvwp0t9aYjsQADUkd2a87It9eXikgQ+otTjMF/g9dpBkh6RSEr/V0fDOndaAre1L0/F0CtU/bsgnk+67apl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV70oIgy; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV70oIgy"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so3361695c88.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:07:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890845; cv=none;
        d=google.com; s=arc-20240605;
        b=Q80w9uljEPjs4HkStUF07Z0c94a0jvQS2CxHPbc5ij3muNHSYrkCDPQGQsmU8uSn91
         cbQ4EKSRSjHVuIu5cZIj6p4b//sXbNBeXchbYUzY/zxkS7b40RIi4CydKJKqySDtl+O9
         Hv3npbQ2x87GB5RxkY8LcmbIxdop17j9RKWLuCR+KfTxrIoFzK+ckU2+t9s1XbjIK/cb
         5QlBOYbKrffuTmCQFgRjct6AwIF0jBfNH3Hs85g+5BSW77+b2aGUdSG64V6bu1rfjkh5
         i0elE2UoBFH2JWu+5QdC57XTZ0kTkMO+OBm4WooQzpKVWocxo9K5q1oqmDvrZiMoF9yO
         66yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WYFTWxPT/PZkC3bBAbwInGOdiJbgPte7wb9A5z+A9C0=;
        fh=T+JWMKS/K0RN/o3ygFuUgU3S/RsuViWDc8E3GC2UqNs=;
        b=Omc9e9kRlJ/bCRIFOqxVYkSSl/Y9pceEeRIIDa51YfiNsoWtFh78cjQi2WwRTBQBH2
         2sTZjhMc95dbxR5A5pexk3PETCvGA2bnV6Ij9Vo4K1Rf4vR0De+fNXhzZyCbmJqbl20W
         KQ56PebV4KFqanMVnIGS/UTpO6x6JSFiHxiMR5w0RgMwtADwl6x7DQx2JThwQs4vhPXq
         LZftQCGQItt2XxwLLB5PdOEgQZSB3RewdAPPd+J6bnuygiCgTjiI4MT/HlCjVdNqwFxM
         uln8yy+oZzj0EKCISLetAg59Bcc8mqec1EaoZgYPBojW1DYfvoj65aMvXPrDaZ6icTwW
         +01Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890845; x=1771495645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYFTWxPT/PZkC3bBAbwInGOdiJbgPte7wb9A5z+A9C0=;
        b=eV70oIgyHnCE6vq1xMf9PoE+I6+ic1bc9Dt6Lk1GEHiD1M/Elq0FJXpStCCyQoQpdP
         LwQcP9CEIuF8QdvUR9pGnKG/oFkAcTKYiI8Yc8FlOGwcTb1lcdQex0ZBku2QKV5QCW9r
         5igWVh7PXNLMUKm6pHtzoJRH8fE8jbDfu/+QHutIpaC4l3G7H4xooZRa2oQ1gPgYguTc
         XotzHwuDXjCFOTQP/Gy7DPrnCxVUyelnyb0H6pN7NqjoAngI8L8JFe10tMfseSF8dcOR
         Ir8q6//flWlRWUL1YCKukxB4rRPZbRtuoQUMeMdtWTL1xLUc9qJXr3t2ZjFrQeU5bT1W
         QA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890845; x=1771495645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYFTWxPT/PZkC3bBAbwInGOdiJbgPte7wb9A5z+A9C0=;
        b=Mhwh/u5bqzcN/yG9EgpqBa3IdN1SisjpgveFpeiB6s1XEOVZRuIizjnlUgYXkCwM+x
         HijWE2XKm90h4U/yuuocy/Wxxg/FMZLRXU3+qKb1iD1RkbCuMgvfSK5K8h1wkx7q9U8j
         UGv8uY33xovWbpkB5E2H2TVGm8KU+Qdumd5gEiDxXmWdFG1CqpGuxt7BP1BGGnhQ8pZe
         8rGJ6KDo1ctg8j9y2KwzTlnNLRJdIhGai9zJ0O4IFU0xGdsI6NapJf/4+a9hZodXxisP
         cv3cIMwQbbNQNzl2qrSOqTW6IW/S1Bfh7oUrM7JVjta5z9Ai6HnlLVtqIPTXY7iHSavW
         B1Bg==
X-Gm-Message-State: AOJu0YxGiPaO8+2cea6/KKY9jd6SJF11qqbTxm9si+uPI3xg27blOpbc
	saTgZ9/LGvSKif0IOXziK5rH2VDquooWUVxZ8HHPyGBUN2BPJODSyQ5zEGjTofbjHCypc+Y1xER
	tal4yIi3p36JgD19FCNFUh+wl2q+7iPc=
X-Gm-Gg: AZuq6aLX3TuVnwKAXyAqJlqIWPmDW0o2pXl1vjAk/QJKTHBflfpWETtrMeDS0/qyi6C
	cH8gKbrVfKt0c+xeLdGd1NQ5C/1y5RC+kI1fuCFvq+Bsnb3ZpTrKdc5RVzgasPZcnztv0dPcNTz
	HQgpJoyC47eoa14jSQnTcDAQgyZzfsm8KBhrwrxd8xMa3QWS9s5YaJd6rPTNKZgkWPRnb08LYXh
	Yr6p8ITvwjGfha4FBA7DWkLaMyA9AcnvluRoWgPgltcJyWU978iLrq6c9hkZ9nKvihBe/KJdwFY
	ba6GxdsWvF6DzcbNTIA3IMTu/sNBCfVLcHBDVtSkeNFwsRWEAe4qAqt4rxbry1w9G5OX
X-Received: by 2002:a05:7023:90b:b0:127:35af:1446 with SMTP id
 a92af1059eb24-12735af1713mr77662c88.36.1770890845333; Thu, 12 Feb 2026
 02:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-8-christian.couder@gmail.com> <aV4v8HCe6CLqXJ-1@pks.im>
 <CAP8UFD0iBxn6cPFKLAkSW7O3To1ago60MWYwV7YxjxOVxni1Kw@mail.gmail.com> <aYxsgL3uMpNlLe8o@pks.im>
In-Reply-To: <aYxsgL3uMpNlLe8o@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Feb 2026 11:07:13 +0100
X-Gm-Features: AZwV_QgyCYGb5XbL12qG0fjNXWD4u6GW_0SG1BKmDYDHbTLjc5gY_eYVSfLB03E
Message-ID: <CAP8UFD04BTTjXhTz_6HbSZiWZC77k0XfnusaP+V9h_3bzH9=+w@mail.gmail.com>
Subject: Re: [PATCH 7/9] list-objects-filter-options: implement auto filter resolution
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:

> One thought I recently had: if one selects multiple promisor remotes,
> how does the client know which promisor remote to fetch a certain object
> from? We don't always have enough information about a missing object to
> be able to tell which of the filters would have excluded it, so it's not
> possible to basically "reverse" the filtering and deduce from them which
> remote should have them.

When there are multiple promisor remotes, the client will try to fetch
the missing objects from the promisor remotes in the order they appear
in the config file, then it will try the "main remote" if it still
couldn't fetch some objects.

Note that this isn't changed by this patch series. This is how it
works since it has been possible to configure multiple promisor
remotes. It's also documented in the "Using many promisor remotes" of
"Documentation/technical/partial-clone.adoc".

By the way the doc says "the long term plan should be to make the
order somehow fully configurable" and this is what the "Implement
promisor remote fetch ordering" GSoC 2026 project is about. See:

https://git.github.io/SoC-2026-Ideas/

(Thanks to Kaartic Sivaraam who recently submitted the PR to add this
and other projects to that page.)
