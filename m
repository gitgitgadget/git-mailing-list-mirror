Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEB1F2B99
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550769; cv=none; b=Q/UbfaVUBri2sHNxXrXrbJyHv4bvLtV/5pVsMlnbk5gqwitWIGv/C5iyqMKUD/UOTyXN6CZcz8YtGUxKEaSGQnYqpJ8i08KLvcxDd2aNVl4emCnzYtMi9mIDell0f2TFPLCHYAo7MjVevzQc+G+isrbrXlyjLLXI2fNYwxNLj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550769; c=relaxed/simple;
	bh=hukOrt9sNmKRGG/33q5LUXNBuukBkBiWxv+3mn8ZHRI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeogqXxKx7Vo2VwcE7ZpXQxj3Cc8Ze9fJVn4jqjtg5kowmT8zxRxj0vR47v1tSiyBxa0Q9OFJXQ52HZ+YUKVROeghfGU2g+N8ysbvcWAkdgJzNy/1CMipfNO6m1AGwOP5vff8vr/tisOvwF7oAtTfw3/xFZjh/lWixzeqfWfJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+1pZH4x; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+1pZH4x"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523dc190f95so979590e0c.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550766; x=1743155566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEN1mqj0iHBmP2BcrXqPoBrUpMj9hBJdlbhrRfx2n+s=;
        b=b+1pZH4xNv7xjJg5TfiomnuLvU6Cq6WOJSXTzg41kp0p3mlzZ724pGmLEcn7oi5VSX
         jdiGZ/dPDyN2K+PeWq4/rsY6GBIgZv6xmeuKpFXDN+DG8aV8B5B08ZQPmF7OmORzRejM
         oDHN9W+RMGVItl3xYoEHVmpylmOOfr5i6z6Ef+SuwKMigGXZcgv8K4KWBpamZ3jxTbPL
         rMrwO62nBSwYLF4OkX5erxI0pPubJ1blcIlYev5fZJHPrlPLjXqARijqaqXk0VmfX8Z/
         vyfGvWGRcFpXFJpukm5niOlqoGjE7aNQZ6ZqIeA840dLihQnJy1trGlc2Ke1j5Namld2
         NIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550766; x=1743155566;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEN1mqj0iHBmP2BcrXqPoBrUpMj9hBJdlbhrRfx2n+s=;
        b=T5EGcVZ8gqlIWmlIeVIyQ9mL/OZVRD3RqTqFM7hH8duoToWE7wE/gTKmvW9pFDRr76
         m9+EfptzblmaQsbH3blZwPNwqdAYuxYoLzDDB3ASjLh0lcuLQjRZEglRGE1ncEnn3sAS
         1wfr8AFd1UL3TKk8ygI/+/ZSHdJ/+B5QPCkl1ST7mmCBnXQlGs4s9dIky5G122DNRBqB
         3reVVMOT6EAI/4ugP6oSKUMgLoFr3hBeybXSbhd0r/Vg35uZBhSXhbDcKaLvBrJSh0IF
         VVxu1eEZdpHSNKBeA7/GnS3OErT6yWE9qz47yfKZ4e6ht/1igcBS1Vj26WGVmBLYDwrA
         /ZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV52VmEXmEq6750z2F5d3RIUZBe9pC3tGNnntKPBpgayHBBS/n1/aODsS4Nlm66+nDfNMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqDSIOln+SDj9yrS0Dh/Za0lspcVyclklrqTntgqGz5wOdPYR
	bcTRme+unVqv71nlWaclN3MgDnZglJm7ipif23q3a363ZYVQXTtUk5v6xEyg1XvkiiF6FjVbs2f
	yg6g5RqEjNXw5Ur/mxH5REQ4sDyE=
X-Gm-Gg: ASbGnctGPnnB+r83pCdcXK4Lo+/409bqOY8kE4dZJ2vOUCYgW6lwKTkjp8K0hnEUwl9
	z0Jf1V0gFV1xALVgj/kIP03JqmjttZgHMv0ZS9wIpkspiFZl51+8JnZMJ7z+hDUQ/3pb9Jbq78B
	ygFzHyCUJJOBnxoN1/1xAgx227
X-Google-Smtp-Source: AGHT+IHO4u4jhLxpLkZvXSZnWvwawXbJmRHaibELKSiWPk5kWSiGOru85VP/ouePHVXJirPrSPblrYkJewQVff5iMwI=
X-Received: by 2002:a05:6102:2d0e:b0:4b2:ae3a:35d6 with SMTP id
 ada2fe7eead31-4c50d5fa6e6mr2015626137.19.1742550766052; Fri, 21 Mar 2025
 02:52:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Mar 2025 04:52:45 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-2-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-2-b1eefe27ac55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 04:52:45 -0500
X-Gm-Features: AQ5f1JrutdJI1XrWFK1Hg7bT19L7GggUebaKmn83EiiTnReuPutqqw4FEsrnsdE
Message-ID: <CAOLa=ZR3V9e33oU5ard+eZLCUQgMybGwcj9PLMr7hy+4wNgM_Q@mail.gmail.com>
Subject: Re: [PATCH 02/20] t: refactor environment sanitization to not use Perl
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="0000000000006a09950630d737c0"

--0000000000006a09950630d737c0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Before executing tests we first sanitize the environment. Part of the
> sanitization is to unset a couple of environment variables that we know
> will change the behaviour of Git. This is done with a small Perl script,
> which has the consequence that having a Perl interpreter available is a
> strict requirement for running our unit tests.
>
> The logic itself isn't particularly involved: we simply unset every
> environment variable whose key starts with 'GIT_', but then explicitly
> allow a subset of these.
>
> Refactor the logic to instead use sed(1) so that it becomes possible to
> execute our tests without Perl.
>
> Based-on-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib.sh | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1ce3b32fcac..a62699d6c79 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -499,24 +499,20 @@ EDITOR=:
>  # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
>  # deriving from the command substitution clustered with the other
>  # ones.
> -unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
> -	my @env = keys %ENV;
> -	my $ok = join("|", qw(
> -		TRACE
> -		DEBUG
> -		TEST
> -		.*_TEST
> -		PROVE
> -		VALGRIND
> -		UNZIP
> -		PERF_
> -		CURL_VERBOSE
> -		TRACE_CURL
> -		BUILD_DIR
> -	));
> -	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
> -	print join("\n", @vars);
> -')
> +unset VISUAL EMAIL LANGUAGE $(env | sed -n \
> +	-e '/^GIT_TRACE/d' \
> +	-e '/^GIT_DEBUG/d' \
> +	-e '/^GIT_TEST/d' \
> +	-e '/^GIT_.*_TEST/d' \
> +	-e '/^GIT_PROVE/d' \
> +	-e '/^GIT_VALGRIND/d' \
> +	-e '/^GIT_UNZIP/d' \
> +	-e '/^GIT_PERF_/d' \
> +	-e '/^GIT_CURL_VERBOSE/d' \
> +	-e '/^GIT_TRACE_CURL/d' \
> +	-e '/^GIT_BUILD_DIR/d' \

So we delete all of the following from the stream of env.

> +	-e 's/^\(GIT_[^=]*\)=.*/\1/p'

But any other `GIT_*` env variable is printed to be `unset`. Ok makes
sense. This is much more readable than the perl version!

> +)
>  unset XDG_CACHE_HOME
>  unset XDG_CONFIG_HOME
>  unset GITPERLLIB
>
> --
> 2.49.0.472.ge94155a9ec.dirty

--0000000000006a09950630d737c0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 326867b0952b8008_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mZE51c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnVWQy85Rzlyak9OY05Gd0ZLaDRxdFpJS291WG9nZQpDS1pQaWp5YnBX
eU55UGNXbTlGU0FuK0E1SDZja0tncWpiQWhvdTlDMFhaVE5VUFgvZEd5WXRQM1d5VWFqVkEvCkZB
akFtWmV5MlQ5VC9nL2o4Szk1a3pnSFB0SldNdWZnRi9FREI5Q1V6WDRLa2hicW4reWxhRVZUcXRy
OGZnbHAKSEFGVUtzUDI2OTVCZWdnZ1p0WTRCOEQ3NWlGY0QxWmtiUkI1MDVYSlZtQ2NBYzJqbWJY
cVJXTDlSbkRVN0pZNwpyNHZMVEVpUXNkU3hEUlYwMEhwR0plVXRKempZUkVYc2hzTmY4dUJlUnND
cVlxYXJUY1hwTWhwckwrSEd6empRClFKY3BuTW5GZ1RDMjVlQkZVanVUZnUveHhEV09VTkE3dUMy
R2NERm1pK1RBU3lOYjVjTXlrK1pydnE5T0w4NFEKc00zQTZHY2VuT3RNOEJYenJZVHRlODZyZHRs
ZDZaQW9ldDVTV2NWWmdXUlIxSnNvRUo5am55TStNaHZGUSszSApQY2Y0MkZueCs4TTZ1WFNrUFNn
NStvanhrcnZYVHZBQTdFM2IrZzBESktiN0gxbG82bnNyZVRoYzk4RVdyQ0pkCmFWUFFaVk1SU01u
RFI3V3cyZFIyMTA3N05BTUpKZ1lHVDk5SGpiZz0KPTZ2SEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006a09950630d737c0--
