Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F612F56
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349008; cv=none; b=Ja3CmxSR27RVluqTbv6AE4TCL0nJjSBbXiyBSY+L8ki5/Opq1dwXBYQe9KJiwUUI8YY8vfd3VGjbLFWapyqIcEsdvbTZL3LIoW01dulypthWp6CuquusXGWYqjD9nmqq/HnNbrQRKD3A942NPOyMxgwBv+Aaag14hO13/gkrnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349008; c=relaxed/simple;
	bh=clsgtapjA8GnMs6wUD8FgdJPKUHsFVRLwqfRiji37HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teoWF5HE8sCVUniDEpTqOVnxoJVN828+BpxD6z8yZFFu688aKLe63opI8DJXmEFBd2GYkimPg/h0ngCxjGWL+lQLo6Im6bixWnUuLv41DTLx2ePZpTLRfDZqf/Bg86m3CqMtDSAD++/lpEmjtKgo75dRqdJ7L4QK2UzfLk0bHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b33I6Zwv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b33I6Zwv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786572c14e3so48754067b3.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349006; x=1762953806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mQFq6ZBZ9iWXv8zGcl4iXwTWbp88FEgyesVkC7mmpg=;
        b=b33I6ZwvgRGY/cXEdZ7OKbsQDVADDDTZ6BuQPUk1tRtdVfUGO5Nhq7/SDzGW+NczOM
         l3uWSN77207IphSKrGcNZTZ9Q+gJDQujKx3OOk3aEjtEBeSEmzr312y5db8Qqh6XBN1X
         uLh3nWFpVqg0SolX0BanQlb7ueev+k6WRzhBTr/IvjRldC90aQLDjshMou9JXeKQJL0B
         xNNwWVhGyh/qGH0EzX7CDTsBm0zHSn3Pg4qJRjfD6KxHmjJ12bb0asmQ4zdScLi/cyqD
         ovti6TQoCSfeGQDSk9xx3IdutVNKvEGfChclzI0UZX73WJklVf/TxnAg+Whs61HbbRbI
         VRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349006; x=1762953806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mQFq6ZBZ9iWXv8zGcl4iXwTWbp88FEgyesVkC7mmpg=;
        b=BeNI6ziU37Svc+r2kBV4e70k1btngJN1ilId18TlVoSpbYQuFYkIgXvLwSDxnBNRMT
         j6Zqma5IEMksAm6jD02EHiNoAe01roKvwWAii0nvYGYj5wEpU0bkDsiXgOeWPMdp/+AT
         HHQirfVlP1T3/EZUvMQHMuCb751zZSBaHQu3i4J6qgQHZgJQU2a4BmgJP8p4fAmdEv5Y
         1Wi0CEaMDh+OChGmL9rt5ZzV8mnwF3NKxJBpDGNSIOgyQkxVCA/CyZo6LjLu4X4QivDF
         93k8rucc+DmgcTZLARbKOsPha362dBKeMu546+EnTTgOVaYD+e74CYrLlfKtIkCWmF2r
         nh7A==
X-Gm-Message-State: AOJu0YxAs4Dnou325Ig5cwDOU+ZDxCnqBEY9QxLHDWsWTOFrFMWsZoVh
	3NdV2nMTPZkNtV3gPEusviYutqUIXLqa4RaWUqaYRSrSrLML0TuQvVVkNjnHPNOuutIJO9WZMBJ
	lWbBRxcuu1fZRrd1jVfJKTxy4Mh1ZD1I=
X-Gm-Gg: ASbGncsxv7ZwLJp97koHTYA7KSlv/UDllnWcdW8vjOgqEldAJgv2RBy9ov1UXUibe70
	7XIlOKQZ3thstVqQ4Jvc2NgBzCw14Nk0YhN/jmn0l0tY4s2zK37FVXyIOVpyv8wDQxZsqdNsLDQ
	SWcgWNrlBEFbNA2waXPPxPh0ThTP36wBDYx0YQrsjw79lY/8dAlD2Gx/1hxg+QtcTnmG3sELvNC
	APwqjJ8mQpXNg2UJ4m9GlWhgd4CmEJmeNYgSm0s4hR9DBaqCYKya1z/ekBljotT
X-Google-Smtp-Source: AGHT+IEka0ZhCIahP9yv9TlylhbEBWXOJWBLpvE1Cuz7aa5hc4bYyo6TFj2/7v2DJCye7LMMH2BtTuM3HsV5ur5U6qU=
X-Received: by 2002:a05:690e:4291:20b0:63f:a399:3972 with SMTP id
 956f58d0204a3-63fd35a2b4fmr2371755d50.56.1762349005689; Wed, 05 Nov 2025
 05:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104155127.1079-1-qjessa662@gmail.com> <xmqqjz05prog.fsf@gitster.g>
In-Reply-To: <xmqqjz05prog.fsf@gitster.g>
From: Queen Ediri Jessa <qjessa662@gmail.com>
Date: Wed, 5 Nov 2025 14:23:15 +0100
X-Gm-Features: AWmQ_bkGKblV5klaYOhhcxRJP8xytd2bDOhP3NKB-UJ4xCbr4DQGSXtAnJU7AmA
Message-ID: <CA+JX8Fpw215XPv9u8g3jVjwLKLDsTNXnxtcmGK5L3oo54SHvdw@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify server behavior for invalid 'want' lines
 in HTTP protocol
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi@gmail.com.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.
 Like you rightly said, the last two lines invite more questions than
they answer.
I=E2=80=99ll remove them so the section stays focused on describing the act=
ual
server behavior.

Thanks again for the guidance.

Queen Ediri Jessa

On Tue, Nov 4, 2025 at 7:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Queen Ediri Jessa <qjessa662@gmail.com> writes:
>
> > Update the documentation to clearly describe how the server responds wh=
en a
> > client sends an invalid or malformed `want` line during the HTTP protoc=
ol
> > exchange. This improves understanding of Git=E2=80=99s behavior when ha=
ndling
> > incorrect object requests and helps developers detect and handle such
> > protocol issues accurately.
> >
> > Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
> >
> > ---
> >
> > Changes since v1:
> > - Rephrased the explanation to be more concise and aligned with reviewe=
r
> >   feedback.
> > - Clarified that the server includes the offending object name in its e=
rror
> >   message.
> > - Adjusted tone to describe the expected behavior rather than prescribi=
ng
> >   implementation-specific messages.
> > - Improved readability and technical consistency of the section.
> >
> >  Documentation/gitprotocol-http.adoc | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Perfect.  Hopefully your future contributions we won't have to worry
> about these procedural issues.
>
> > diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitpro=
tocol-http.adoc
> > index d024010414..f3f48d3f35 100644
> > --- a/Documentation/gitprotocol-http.adoc
> > +++ b/Documentation/gitprotocol-http.adoc
> > @@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
> >  TODO: Define error if no "want" lines are requested.
> >
> >  If any "want" object is not reachable, send an error:
> > -TODO: Define error if an invalid "want" is requested.
> > +When a Git server receives an invalid or malformed `want` line, it
> > +responds with an error message that includes the offending object name=
.
> > +This clarifies the expected behavior for Git implementations and helps
> > +clients detect protocol issues accurately during fetch operations.
> >
> >  Create an empty list, `s_common`.
>
> I am not sure what "This clarifies the expected behavior of Git
> implementations" here, though.  Who exactly are "implementations"
> that the clarification is given, and what are they expected to do in
> response?  What does it really mean to detect "accurately" in this
> case?  For a client that received this error, they know what they
> sent as "want", and they are told that the other side does not like
> that object name, but then what would they do after that?  The last
> two lines invite more questions than it answers.  Perhaps we are
> better off without them?  I dunno.
>
> Thanks.
>
