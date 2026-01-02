Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDE1DFF0
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767346791; cv=none; b=juVrZBTGIDHPn5YsoSdkTcYGdRTdrte4JAsY+yUlAAMzWotEU2ARN0Hc3eBu+s92wr+8zLqASxh++4FP/JMvo7fKhaWanNill9PMAlwR4oDBrP2Pd283JCMRDVc2M4VMhG7VQegATg6frEi1PEvhf1hCP0HVr/iTDMTeFCGbiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767346791; c=relaxed/simple;
	bh=75QK88HR9R/OS5T277hxCt5IJ9TjW7iaSN4zlTuvDRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHmBI6QpW7g0cfiNSQ6/w7ZN8RN1BOHdN9J4m+Rn5ICyFc27NjuAFIYAwkonj+cynKuL2XwRiufm1w5R+Rm0rdtCr+zcu7zcO9AhywJQpya0D299LXaW0UmTpF8Mzi2+3js7uTSoU5ueZnjgwqAFvD6kY4CWdWsDqaDm+vy/wM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIdaJtBQ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIdaJtBQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6446c2bbfe3so9415637d50.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 01:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767346789; x=1767951589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ajq+ZUytI9Ec6FFmqrsH0cahN4k4Q8l4eM783FbRBU=;
        b=DIdaJtBQykXo7V9Tp1y8CbNkCfnOH5D0fgOHDCY4Kf2rvG89tvqig6tNIewWfcc1yK
         9zymHhsn3DKscZoFI2fNWXdJmYdbO169u5bdW2n3NkOuCyRwthzwCJqs4bo4pkoWHRLi
         2uPlo+jwmo7r1nnPV0SsopEtw8baaQj/c/gYYQu4SofFfFkKUY9AOkUrSHRu6RwkzReq
         /Ip5NAczvm2uM0GQdxxcANKMF9fwmeLamalT42hHKxnUUolns7706f/MnYr5j+s+MI4n
         e7GrV2f3U60Rm8gpTCQSlmyyKm7nHjlKzOnN5Ew7ECDrEPnDoE+8u4JIEmDM8AnJiCZW
         4k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767346789; x=1767951589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Ajq+ZUytI9Ec6FFmqrsH0cahN4k4Q8l4eM783FbRBU=;
        b=MTp4CrQYBK9ubP3vaHjnwjDO5cEY6kX9wN6nWpOzknMfJiH4iQvQa8LS8FQP/+P7a+
         +yblvKk1oveOQCK2XNKFotV6FnwzdR3ZLLBcsFibLeHF8hEBbLnuLScJf6SdkEJ4ryG5
         ciiZdQBGxk8iGQCZF9gg2gOxTLwyrQsC7p9gYMhGHcNBawpkBMQ5Ysiefen5Xel8Uaco
         942eu3XCBx/v5zccxuz3/KV2vqef4SfwORYZ6zOo7/nLKvljJopI5/i2ryjb9cgVELge
         KZGpAKFh+VgCXy9RZ4cBkhCLprbXnPumOt4mTsLnTh5hWpmRyiiXnz4qBwIpyWK432TP
         wX3A==
X-Gm-Message-State: AOJu0Yxmn4b1TgzgwjfY0jPggE8lCyBxzaJd6B9N7o6I7s9xdjGr/sGZ
	s0VfEVygnT7hS7S01GRbNaB2CYBDKuC/ZMQgBiLytlA740fLzVa7CUeG1uoPsFDl/zg4wlNLwu7
	0OsrOg+lVSQ2PhAsMtH4matwY6NkTpvpGFqRZf3w=
X-Gm-Gg: AY/fxX79IOyO2rNsxiFrY2l0Lhgc6uHXQjqsyBI69Mo3N4I7sKntM6QV9xfSRRkNMT0
	yUdi1gs9ztMPlKsI1KmcaCicCk424OyVGrkQbbgMFgc2F93iCSPYKGJtPcp/6v1cI+tpk+DKNTw
	rkwcIlmbM7B9dNJRNXg+W3T6wAaYoRsmU55tCy+je9AQAZ53gLuvkKtx94Xl5P0uuUuuZzSwXow
	MJKEhoZDdjdpv2SQW2myt86gG7eTVhygzzEdaOtbaSusQc+6H8ZV3TpDfJ8guFOrg==
X-Google-Smtp-Source: AGHT+IFkdsF5bnoeGC1VZTRCLVvZ5EPtyf78vpyj+JG1FK2oUK5swQQrmadkZNnP56HESEdOq7HGJe6fCEDB3XN09fA=
X-Received: by 2002:a05:690e:1918:b0:646:81e0:1340 with SMTP id
 956f58d0204a3-64681e015a5mr27483651d50.71.1767346789221; Fri, 02 Jan 2026
 01:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com> <CAOLa=ZQrKO-Aeoa_9E9Gi3rzM2AuVETDT4sUEuc0V8XQUyk4Pw@mail.gmail.com>
In-Reply-To: <CAOLa=ZQrKO-Aeoa_9E9Gi3rzM2AuVETDT4sUEuc0V8XQUyk4Pw@mail.gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Fri, 2 Jan 2026 15:09:37 +0530
X-Gm-Features: AQt7F2o0TqIMH4j6t7BemwAI3qXPm23PFN_oFzCSCUEQU4CXnvj6n2v9_f5xLwA
Message-ID: <CALE2CrRkKneSJL_F-mF_aTBzbGwW8c5A+qSU+8etQdbB=o2wJg@mail.gmail.com>
Subject: Re: [PATCH] t1300: use test helpers instead of shell primitives
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

Thank you for the review!

You=E2=80=99re right, I should have clarified that `test -f` checks for a
regular file and `test -h` checks for a symbolic link. I=E2=80=99ll update
the commit message accordingly and send a v2.

Thanks again!
Pushkar

On Fri, Jan 2, 2026 at 2:39=E2=80=AFPM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> pushkarkumarsingh1970@gmail.com writes:
>
> > From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> >
> > Replace plain "test -f" checks with "test_path_is_file" and symbolic
>
> So 'test -f' checks for regular files
>
> > link checks with "test_path_is_symlink". The test framework helpers
>
> and 'test -h' check for symlinks. Would be nice to also mention the
> latter.
>
> > provide clearer diagnostics and better consistency across the test
> > suite.
>
> > Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> > ---
> >  t/t1300-config.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index 358d636379..9850fcd5b5 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configu=
ration' '
> >       test_when_finished "rm myconfig" &&
>
> Tangent: Not your patch's responsibility, but we should also remove
> 'notyet' :)
>
> >       ln -s notyet myconfig &&
> >       git config --file=3Dmyconfig test.frotz nitfol &&
> > -     test -h myconfig &&
> > -     test -f notyet &&
> > +     test_path_is_symlink myconfig &&
> > +     test_path_is_file notyet &&
> >       test "z$(git config --file=3Dnotyet test.frotz)" =3D znitfol &&
> >       git config --file=3Dmyconfig test.xyzzy rezrov &&
> > -     test -h myconfig &&
> > -     test -f notyet &&
> > +     test_path_is_symlink myconfig &&
> > +     test_path_is_file notyet &&
> >       cat >expect <<-\EOF &&
> >       nitfol
> >       rezrov
> > --
> > 2.43.0
>
> The patch looks good. We have two files, one being a regular file and
> another being a symlink to that regular file and we simple need to
> ensure that they exist.
