Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621D185925
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223621; cv=none; b=eoa3UcHUydIJ1Eeoo7EHUTvbMQQFY/0qae64sK7GmNxCW8mjq0iusjX4BwVBVmEukvEsAxJfGmazTGcsxjr6lYfAsfATUWvCMNFppmjnuTEB5AxFFBflpX9JH2izB2GbiUnjS+yQB6jnLe60RiWmtr4AljojyITr5SRhK+NSD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223621; c=relaxed/simple;
	bh=N0HiDdwNsl2AckZ6q6Lu1LUEMBLtWhCBJdCOjdu2ZDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRnKWUFzDKMv7KD9BfBC6JmYXSUHswqBoCinxKVV2bCbn4/T3RleGw2RmuJsFY3F9d2mrrMiWCTUTQrsAjpG5MEYMxlC7DEDluIwj3XGHOo7pOXDtjVQ37NZ5BSRbSpE0FVxXjKECLJnmcjSdgzIiuXdvf/F5yj4Srpu1MvNQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a649612fc8so45811085a.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 00:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724223618; x=1724828418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27OwdejWQv0AhjPfXa/3FEpXSHsveqfraQb7Ykz98P0=;
        b=n0IPUdS3Q6LYn2giu5GnqLq2VINkvFJ58ZwPW00srjMuuObkWO0slqX/yIA+ubOsPZ
         N30hwLsF/Y51uDWa2wNWX409OFtId+d2zeC7uVNflrd5Hnl060JXfT61JuBc8GPGZFqy
         zlvrK56+nXU4F5WAyaYxfcjz1wv3g67OsisagyU8Qi8mSELZDon1wX2Th3y30fDntNVt
         P/Ph4S/ra2ydgg/01bNJsX6rUJoLOe0EphcxThYrbZdL4aiDgAG9c1G4zkNc3YsdX5P9
         DSgq4gh5XmfTn9cLhyiPLRY09RlQ8bVIypHrcGoyIbSBPMhWuUVjBawJz+2bm0rBs9K1
         a9jw==
X-Gm-Message-State: AOJu0Yx/LbxcoFQJrpZtYF1ohYaaIuZhu2XbKb7ahctSev+fvcsxlk6H
	DmrPyasbacrIXF3pE/6xffFL8ms7fbZXhICk/xXhBmHRGcM/jiUrCK0n51yUZzQAh7csGr4MEsq
	OyS1TPYKwOdgOrKTHg+hITkXUZdM=
X-Google-Smtp-Source: AGHT+IElllX7IU6HtENqlHVb3dYhs2N6i4g5t8W7/b/6/9M5Xka/+3rqrx/85q+ZOI0M1TY3lXfDqo7TX6scPZUF2MM=
X-Received: by 2002:a05:6214:2583:b0:6b7:b149:ce06 with SMTP id
 6a1803df08f44-6c155e1ce80mr11363586d6.4.1724223618557; Wed, 21 Aug 2024
 00:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710083416.GA2060328@coredump.intra.peff.net> <20240710083755.GE2060601@coredump.intra.peff.net>
In-Reply-To: <20240710083755.GE2060601@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Aug 2024 03:00:05 -0400
Message-ID: <CAPig+cTACjostXvjJMnLEpgbnfat9cjM63pLXwNJm1=2P3gq8g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] chainlint.pl: check line numbers in expected output
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:37=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> [...]
> It would be possible to do all of this in shell via the Makefile, but it
> gets a bit complicated (and requires a lot of extra processes). Instead,
> I've written a short perl script that generates the concatenated files
> (we already depend on perl, since chainlint.pl uses it). Incidentally,
> this improves a few other things:
> [...]
> diff --git a/t/chainlint-cat.pl b/t/chainlint-cat.pl
> @@ -0,0 +1,29 @@
> +#!/usr/bin/env perl
> +
> +my $outdir =3D shift;
> +open(my $tests, '>', "$outdir/tests")
> +       or die "unable to open $outdir/tests: $!";
> +open(my $expect, '>', "$outdir/expect")
> +       or die "unable to open $outdir/expect: $!";
> +
> +print $expect "# chainlint: $outdir/tests\n";
> +
> +my $offset =3D 0;
> +for my $script (@ARGV) {
> +       print $expect "# chainlint: $script\n";
> +
> +       open(my $expect_in, '<', "chainlint/$script.expect")
> +               or die "unable to open chainlint/$script.expect: $!";
> +       while (<$expect_in>) {
> +               s/^\d+/$& + $offset/e;
> +               print $expect $_;
> +       }
> +
> +       open(my $test_in, '<', "chainlint/$script.test")
> +               or die "unable to open chainlint/$script.test: $!";
> +       while (<$test_in>) {
> +               /^# LINT: / and next;
> +               print $tests $_;
> +               $offset++;
> +       }
> +}

I'm surprised that we're not closing the two file handles opened on
each iteration of this loop. Is that intentional? Or am I forgetting
my Perl and they are somehow getting closed anyhow (for instance, by
the <...> operator hitting EOF)?
