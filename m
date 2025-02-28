Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463F23F376
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774439; cv=none; b=Vdqqljjc85pEHR+c+JY0NVvuGZtw/oWacbcWeIb7IdY4E3McfuppTuxlmVTvAVCZf6u5Eajn96wDuSAFfuG9minsh7LWgfnUIxUYvh/qv5jcQ3GuMLKust/uJJ6/SWLkJ9c95QNTZi8V0ZdwQo2yq4M6bSZtc81dECyOBsaNVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774439; c=relaxed/simple;
	bh=siLx2Fc/Io+cNgdTTcIKLGSOkWMJTSRv6CffxV9LcKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwlSQiKAHIgBAAoxz3PfP47MsA7qZHzGhjq0LfUYV0v56IK3c+VM3nn2fsUlhg3UNV08BbsexZ5M+9UhKHsqfJ6UzwuGDZAUr5IMQCTdy5xd4+CvbipklriNkKgOHpvJuxXXnljYayVZahNxOX07mjr7P3jBLfqxcpr/6lDFL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMm9Uv9S; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMm9Uv9S"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53c9035003so2005995276.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740774436; x=1741379236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8VAOiOwUCqnOhLu+B08cCUjIWzq3hx1aqwZkWmYD5s=;
        b=TMm9Uv9Sj/HTEsNqt8rETbPz6ECVVFyaiYG8cYNtkG5sHnG+FxhkCMi9bL1sqFQnwn
         bP/98sb/KSmhc3aU6W/4te4sqi0SBcpGYm+zNFJxI0q+9rrh/1/VEVWqZ4W2Im5C+twX
         z/DLlRxruWNv5lyIGsxLxIhDc4h8lQMj0DVYhtxU0kCK8rM51mFqSSDFJc8Av/e4lVfg
         T/UrWUo/t+VQjAbwazjsSSvM/GnZwMxcTUqgYyfvX/2tsJ/pcliKcTJBRDA7LflEhiKh
         wrYCb+iaPl/7Ova7btZ2Vs6r0lLBL02GT/l/6ynFQMhQpGZSKFmDTFr5+xprSl/kBQ2U
         8WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740774436; x=1741379236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8VAOiOwUCqnOhLu+B08cCUjIWzq3hx1aqwZkWmYD5s=;
        b=w8e71MujlE2a4PGt94kg0tqkW9txbfO66lnBTsjoaRHBU2onFvct7kKYIE4P5k4eYm
         KAYLIzZS5RXkZ3qmJvN6wbycT0XdF8gkwou54Tj99HombFMGqrpxIldvvR9cqz6tL2PI
         WztXlx+BT+gKYFcHaL+MPjO8Mfcng4HPGS5uApCiSXEOeoDcvt2lZ1SdLVibf3JL7HiM
         FWp/C442fmX8O3SXAQfVoqmETvf2mz5rXD2iHimMAAXYBvx7rRFCmOxi5SPzQeyZhiK9
         BA0bhf2Ol/U6KjLbQeV9w48cMVdfu0mLc4MXjiOCinq8HwR3mL9IpwOVISU6W9gZq1oF
         r3TQ==
X-Gm-Message-State: AOJu0YynvoaQoCabOoR1HYtUgadjoj1pbJt9+pwp3OI3UtrymXS+s3t1
	OdnX0ToGzcJiOU72XhcIDP3d7JfMYMsv1SoxIaZrNW+0HdNMXRjjZ4vRRagAF+ONECL9Tkd8CLW
	N5wwThvjjWZ4uXMfd3GNvTbbfQpviEitndWE=
X-Gm-Gg: ASbGnctqVgBi9z+YRt6ubiy+v5hwiTyESfb9PB4RfNdryPcd8RrTQahNxKGCVEo5JlL
	HAlkkUhjg8lgxpTEuoIKYG8rYz/94bmdVKZ5Gs5I0JNC3jT9w89HrZxdrKBX9ZzOXwPR5CRTRwT
	PX2Ho9g6A=
X-Google-Smtp-Source: AGHT+IHK8DYalPr5m50Zmw1ATxg07/CiuBpyxxUY6VjJTGHSF+loMoxeW+uTr6yG+NYnG8b1SdH+/m+WUGU9aRW68G4=
X-Received: by 2002:a05:6902:1146:b0:e60:9d12:c1db with SMTP id
 3f1490d57ef6-e60b2f16112mr5145146276.31.1740774436677; Fri, 28 Feb 2025
 12:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADJmAEiE=9Ar8CJFRWeN9f0i7TVDOF7VcV+4f-UaPw0m6Frh6w@mail.gmail.com>
 <20250225013227.GB752084@coredump.intra.peff.net>
In-Reply-To: <20250225013227.GB752084@coredump.intra.peff.net>
From: John Giorshev <john.giorshev1@gmail.com>
Date: Fri, 28 Feb 2025 15:27:06 -0500
X-Gm-Features: AQ5f1JrPKbA82XoSNcQEBdrKIyAMLG7ouZjujAZehSTJ8XG0MZh4wMFLiRkF1Xc
Message-ID: <CADJmAEgCRdWzG6kUXS4FHJDQkRmMhQHmTbpHJ0w5q8_WyLqNYQ@mail.gmail.com>
Subject: Re: git client erroneously downloads files when --filter=blob:none
 and filtering unsupported
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply, I appreciate it.

My understanding from this is that it might be ok to send the patch as
is and not be backward compatible. Or, maybe we need feedback from
others?

Created: https://github.com/gitgitgadget/git/pull/1869

On Mon, Feb 24, 2025 at 8:32=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Feb 22, 2025 at 10:01:22AM -0500, John Giorshev wrote:
>
> > The git client, in my opinion, erroneously downloads files when
> > --filter=3Dblob:none is specified and the server does not support
> > filtering. I created a related question on this before coming here:
> >
> > https://stackoverflow.com/q/79413099/15534181
> >
> > Instead of giving a warning, it should instead error and exit. From a
> > user perspective, when I request "don't pull down the file contents"
> > and it does it anyway under some circumstances, this is unexpected. In
> > my case it caused performance degradations on a repo scanner.
> >
> > I propose something like this:
> >
> > https://github.com/jagprog5/git/commit/c4bd8c9640c1491dc6e23acf31fa0230=
485b68b1
> >
> > This is not backwards compatible. My question is, how best should this
> > be handled?  Is this breaking change ok? Or should there instead be a
> > new CLI arg or config which enabled this new behaviour. Looking for
> > advice, thanks.
>
> I could see arguments going either way:
>
>   - you asked for no blobs, but it's just an optimization, so we can
>     complete the operation for a bit more expense. It should be a
>     warning. That makes it safe just sprinkle "--filter=3Dblob:none"
>     wherever you like, and sometimes things get faster and sometimes
>     not.
>
>   - downloading the blobs is so expensive that it's better to fail than
>     spend resources on something that will probably fail eventually
>     anyway.
>
> Which implies to me it should perhaps be configurable. And then that
> gives you a backwards-compatibility solution, too. Step 1 is to add the
> config. Step 2 may eventually be to flip the default, and there the
> config option gives people an escape hatch if they like the old
> behavior.
>
> All that said, I wondered if there was another similar case: when the
> server supports filters but your particular filter is not allowed.
>
> E.g., if the server has config like this:
>
>   [uploadpackfilter "blob:none"]
>   allow =3D false
>
> But then interestingly, we already consider that a fatal error!
>
>   $ git clone --filter=3Dblob:none --no-local /path/to/repo
>   fatal: filter 'blob:none' not supported
>   fatal: remote error: filter 'blob:none' not supported
>
> So I dunno. Maybe nobody actually cares about continuing with a warning
> for this case. OTOH, I doubt anybody would forbid _just_ blob:none; it's
> the cheapest filter to support. So it's likely that nobody has run into
> it. But the behavior would be the same with something like sparse:oid,
> which is likely to be forbidden because it's expensive. So:
>
>   $ git clone --filter=3Dsparse:oid=3Dfoo https://github.com/git/git
>   Cloning into 'git'...
>   fatal: remote error: filter 'sparse:oid' not supported
>
> Which maybe implies that worrying about config or backwards
> compatibility is not worth it.
>
> -Peff
