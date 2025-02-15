Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB20539A
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739579087; cv=none; b=aL1xDENLgGBWld+lj8bNwobHr4RE0LyxhQw89VAo43jvwMb71aJclfOe/o6Y7pJrUb2jWA5ccma0KK5UjOSqI0phJ/UNL/SXd75EQoHQ7DsGcA8P+ZYJ0sZjScZXs/GALQm8Wy8YnbTzGmnGx2IF2Q5FHbW3+o2bT3/g67qMsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739579087; c=relaxed/simple;
	bh=Ck+2zRAd+H+ojtem52xgvFbrndhJrCh7k071ipJyn7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUphLR4QgAi2q3FP66BpYcduwexpIeF5BS7bHWDzUFjTBRgRna022ddlcD/1aaXvYcrppBzyc4Jtci2+fDkMExGAaaHQp8F/wyVDd7cIpDq/ZcQlubnCAYSYPy3YzEp0Qwmzz4Mo6eEUwQg4pu+7ag9PZ12yJShgBXF6cUfsrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii30ZzBW; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii30ZzBW"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b8e2606a58so1336029fac.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739579084; x=1740183884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=869WGsl24b1WSdBzIyi65Zk/t9MLHWSNOPQNbq+/pqI=;
        b=ii30ZzBWdlztyihKqpzwflSLTME5oiXGGaLyhx+jiW4mgGIbxylkg+y6phJ7RFLzNW
         vp2MqIYuqiPJiWeKv4okNuomfx0wvuj5tOON40ygT3dAri65gG7BCithyVubNhxkFqLL
         27X4cID3nZznf1x6+e9RmC694sm6a+O5VS+RyKYIRYN2KsuKxwbuSLKRJcD0HtkEqJz/
         GDy3MxTP/NhNM4NLamkZvrD7Idl5qcM9gzI+SbgZPj6JpMQ9iqTyHW57FkqoCSkIeYtM
         fqHw6usldXZ2ZNvIEENESfip2omXDqjaPRQAbnW/2rga7TFi+/31BoOifNVfh0jgEoyo
         kkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739579084; x=1740183884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=869WGsl24b1WSdBzIyi65Zk/t9MLHWSNOPQNbq+/pqI=;
        b=d7yNvpdQUVM0BAyIwxNPH+5zaOseqPf2kLklgO+6yuYzXZcfcH+MsrAsTaAkvBPJ6K
         pDh/zWXoywAONMOa2GpIB9YtfVod1dawY0mVfJs2ilkI/38iPpxo7RNvagwpgtcaEe0a
         KR6t8ToWj+cYVA8sqypQC+k2pxeTsUpyJXgLQaE1BUBHbMRZGTlEudZqL5NncaOSJVY6
         76iUipl/MRP8ws9g3LdFLS5E9jhb85Qh80XjmmklSFbvSExfvAouhMrW9xqnEbQHsruz
         1avPRVyIQufwD24VpPZ+cw0Z+lHZCzny2vVHhrauSg6Xy9D9CV8R0X6JjbpsunSGwWhT
         6ywA==
X-Forwarded-Encrypted: i=1; AJvYcCU9LQHl/PklQ/Psiwz/qtpsUT6SFORnozaoQpgo2Z3d47Khf7JkAyYbk09Na5hYLfrxLeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/uG6307yReVHD9rF3rzvsCci6tMmzOO2cxoNCMsoF72od759
	Ja5nXnZDtWSIPkOoCvpptGAggLXi2Px1ve5qOpHwLbS8+qNKmhojD8QR5ZPaYJ8ck9RyT1QEDsf
	hRaa1WMYfTZJEwpQVl2dMutuCPUI=
X-Gm-Gg: ASbGncv9oZYFgLBLxZh+heIlWgXo5ShPLpUqHpEQ702oeLnDGl1ize18nnIpfKqx52F
	0aakh5rI0kjntTBxT+19Lhv2tSu6VXY9wanuGAaR09raOyvepa9hICDy/X7p29IqcFRSVPKpB0A
	==
X-Google-Smtp-Source: AGHT+IEyr7a4vdiQm7GZ1+8NkqEZKviKbh29bSlnnojpRPnxHRsT4SH2SaMvlDP/qiGzukjsdiUQHJ3gn7tv+M72YFk=
X-Received: by 2002:a05:6870:51b:b0:2ba:11dd:249d with SMTP id
 586e51a60fabf-2bc99d4f568mr637970fac.24.1739579084310; Fri, 14 Feb 2025
 16:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com> <xmqqwmdtmmsl.fsf@gitster.g>
In-Reply-To: <xmqqwmdtmmsl.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Fri, 14 Feb 2025 16:24:46 -0800
X-Gm-Features: AWEUYZlYveBIhBAcYS6qFQKvndYuzwULCdS3xR0OWBT2MegyrkzYUFquVx8IxT0
Message-ID: <CA+P7+xr4EaTqSw0vqpJz17iF9gMFqhAt_6rvTsv+49mrWYntDw@mail.gmail.com>
Subject: Re: [PATCH RFC] mailmap: fix check-mailmap with full mailmap line
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > I recently had reported to me a crash from a coworker using the recentl=
y
> > added sendemail mailmap support:
> >
> >   3724814 Segmentation fault      (core dumped) git check-mailmap "bugs=
@company.xx"
>
> Thanks for relaying the report.
>
> I can easily reproduce your segfault with our own mailmap, by
> picking at random an entry with both name and e-mail listed as
> the mapping source, e.g.
>
>     $ git check-mailmap ksaitoh560@gmail.com
>
> > With a mailmap file containing:
> >
> > A <a@domain.com> B <b@domain.com>
> >
> > I get the following unexpected result:
> >
> > $ git check-mailmap b@domain.com
> > <b@domain.com>
> >
> > Based on my interpretation of the mailmap documentation, I would have
> > expected this to translate to "A <a@domain.com>".
>
> After reading "git help mailmap" twice, my interpretation is
> different (disclaimer: I haven't read the implementation of the
> mailmap code lately, and the last time I read any part of it is
> probably at least a few years ago if not before).
>
> Unlike "please map anybody with this e-mail address to 'A <a>'"
> entry, which is spelled "A <a> <b>", the "fully spelled" form limits
> the damage to those that match both name and e-mail, in order to
> avoid "D <b>" from getting modified, while rewriting "B <b>" to "A
> <a>".  So I would not expect a request with no name to be mapped at
> all.
>
> And the command emits the e-mail intact when it does not find any
> match, "b@domain.com" being answered by "<b@domain.com>" is quite
> expected from my point of view.
>

Re-reading the manual, that is a fair interpretation. I can share that
with my coworker and he can adapt his mailmap to match this
expectation I think.

In that case, I think the simple fix is to just replace the NULL with
a "" to resolve the segmentation fault and add a suitable test case
for that?

Thanks,
Jake

> Thanks.
