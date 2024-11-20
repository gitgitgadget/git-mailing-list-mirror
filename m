Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E7156228
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126548; cv=none; b=ML+SJ/84EMoOCmQV5hS4mUI05jUZ4YW2JVlky6xk7ahyEVH1nDOylOq52NZ4Z8c5WcpK1DcPE8h1/N8WuQ1kxXZ9iWe0MJNQt2yjxBQdrawVmEHtIaiGdhkhdVQ4mEl4r1uGxSctNndePvxHJC6BOzH2/f7UAMEvPEYtTxfW/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126548; c=relaxed/simple;
	bh=BvU0jmFfQZPqeCtMX01/A77iLHn9sl2Fu+wJkx0qj+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuhPY1uNW2XRoe4K4gy08QkO5b5kpQM+IsoHD4RE1fuQZ8oevRQAd+JpL4EcVD/4p55HzPMVXSWgUnmVbKzuuOOOoLs8IDzxUDEgFUHIy8FX8T08q/AgRry5sjUbZxwNxAqBglViJbUSXg5uETpM6iS/SsA7unW9BfWKdl1BtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T11zsQvz; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T11zsQvz"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so872901fa.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732126545; x=1732731345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvU0jmFfQZPqeCtMX01/A77iLHn9sl2Fu+wJkx0qj+A=;
        b=T11zsQvz06p0bt+adKZp1SXWl+AnOIsXzixCmWsmLQjNZCIHnfOn79Z/sunf1Blom7
         ReZxAj1zU6GCIQzd1d2gvAfKm3Tl6dg/PWasz9Ho6uxvBBTMzdXX9/RHn9fmrvJAzJMA
         mphFJ1UVEInzMC1S589kNZz1mfxP3oFuRKzbDml3uw1kLDXxuuzuthmYgDss8YlqML/r
         +0oCvPBAemT9svc1ha4G5x2sVxWhE0XDCTYgnQT24MiUvWYMbd0BBky+fsYg2PUBTvJe
         t8bh+/K3dTpt67UfAnxGwPHrUAX8NNZzzImOk5W6PjwZtwP09hGovkWI8Bnsdki+SyHr
         PblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126545; x=1732731345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvU0jmFfQZPqeCtMX01/A77iLHn9sl2Fu+wJkx0qj+A=;
        b=Az+JzjC5DlDqOK+kkKBdm7k/5DEBm+I87Ik4ozNx6LTMyjxAXJp6N5z6PmAUUiWc7b
         Hu01LFwoaJhrkyqMW9atiDS8ZmSFuqHNrB4Pkqh42Yah1l7ZITvkZO3XiyLcOMnpePr+
         mRZjgEXD5wGbHBuYM4j+ww0PTT4QxZ6MhZcsZEtWv1NxIPt6k+epGiDNouA5FwvD68ZF
         sJ6E2nCOOxbqKxdqKNZmlWHeaDefEwYVBhi4YZL77D0yqcgP081fl8jmYajzO+hzAlYL
         /h632pfSMsD2WrSamob+xCtD3b4Jw0CemK4avJe5X/inI7rWE8mG+rFg0Od0WduLzjI1
         9IhQ==
X-Gm-Message-State: AOJu0Yxmlc4iljGs2e9c/V6H8gA4tM75t5GFtTpD/VNfOY4MDpYYHoLK
	Jvxy+z2sy4toyjdhKzN/CIiE/C+GcjF+UojHyVbemJ1TF/itT2YIri7w5v5emJ/E3reCZQUbRUf
	kegc1G4ic/Cz5eBRpVe6Sqc9if7rw3A==
X-Gm-Gg: ASbGnctYVSZhbZEM5QGqSr1aD3KSE1dJpoGkaqYSsS4utht0xUXHaYlIYcQ4LdQmJMr
	P5Jd8qeJ375By/zRlX5kN+kqazgd4v2Ui0Q==
X-Google-Smtp-Source: AGHT+IFdzRSK4Jm0OJVBLh16qwhAyR7yitA3uLA/qIqQn62TCSNX+VZNHpX6MhqRMSoFnxdPSAFLXoRqYfWKhweGbO0=
X-Received: by 2002:a2e:bd11:0:b0:2f7:4c9d:7a83 with SMTP id
 38308e7fff4ca-2ff8dcdaad8mr25785531fa.40.1732126544535; Wed, 20 Nov 2024
 10:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-8-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-8-e2f607174efc@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 19:15:32 +0100
Message-ID: <CAP8UFD3ZuTtd2SckoyvXmkMG3eeGqH3eHSHtda-4o5yGdj6cBg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] midx: pass down `hash_algo` to `get_midx_filename[_ext]`
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:39=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> The function `get_midx_filename_ext` uses `hash_to_hex` which internally
> uses the global variable `the_repository`. To remove this dependency,
> pass down the `hash_algo` to both `get_midx_filename` and
> `get_midx_filename_ext`.

Technically passing down the `hash_algo` to both functions is not
enough to remove the dependency, as replacing `hash_to_hex()` with
`hash_to_hex_algop*()` is also needed. It's a bit unclear if
`hash_to_hex()` calls are replaced with other calls in this patch or
not though.

So you might want to add something like: "Replacing `hash_to_hex` with
functions that take an `hash_algo` as argument will be done in a
followup commit."


> This adds `the_repository` variable usage to
> `midx-write.c`, which will be resolved in a future commit.
