Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CD1E871
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651717; cv=none; b=cFYQEvVEXwDTM4fbCYiwbrAKI5uVSEtKPlDrAzoM4LE5os4P02qm/JiN8BhDMxS4oZcDdMO+2H5NDJtriiZ2Yj+4nP+dmfjhzik4O7pBXDspauPnMRIz3PWV77E9wUaBA9CgeA/VS/GInOaMGasRU04ZnMC77DglHmoMkyIPvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651717; c=relaxed/simple;
	bh=T9twdu/i/K/AEJYTEzUJs6g2U4bANDhRQV3dqUL2HqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM7LhPU7IhEu0z+3phwuws3ycZyku6q+Uj4WArgB2B6VjcbU+dX+VAAFW5KfsN88KryMz89VD2ENoQWyYsgLkL8MboMYlUQO4InshQQxeP+lTBOLxV704XPhEGFqdahbHg+pkZ0NnzMeHQRfnq/0GVk9nM18ZzbVc5RLA5XPd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2VcqSOG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2VcqSOG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab34a170526so193115466b.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651714; x=1738256514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5/8cp+9oPRjsRf4kERSs/aaDXBlJCRatCSFMxbjZuI=;
        b=S2VcqSOGmcz9QRg+iBSVEyhjdUPOPDpGJRJU2160GI45TSIRKPAYrr/AfKrgWitpMO
         QO04rw52pU1A0JBJnrhGxi9scVvaOnAf54Wal5A7qa69OeRwl2Z7qQdS4Gu68Q75jvm1
         WoKLiP9mO/Lbq8PBocKz+2U7aP8JmQ1gR0trrFQgIIxCsUlODSr72at6dy54PtrE0nQa
         TU0lgw2YUnGpFjivewvz/7yOhgC5f00Cj0ejBL2HnYObfSX98uJbJvpqsZlFSHXVRLiI
         dENGr3XRe7E6VqJdfoXf5wniDdJQT2dVCy3kIiWOwq97pVgp0Y2e3khQCYJTeQYEL7VG
         x4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651714; x=1738256514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5/8cp+9oPRjsRf4kERSs/aaDXBlJCRatCSFMxbjZuI=;
        b=lqLZgJoHgax5fsfUrjzLG1LkJh64AR4nt6TSJLu7ZU6jlL19UlUIeCUqwOdjk8kQ2Z
         gED9mif05zjfceg6PnPJjxW3cE7xXB6eXKISi3bsgZ5QzqISb68V2EcKOUpQ6sNZXslz
         aYRWL2gbziSpmt7P2hcuoiG0TvcU9IaMVM9LoRC7VzmHf1raPUMNz3esk9l1DN2wX5m+
         GWWkT2hTgHN+ZBgZzU+EqVl6Bebto+kit++cbIHUafoMeJelpkP+/R0UK8kbznPhVCXE
         2tIZfEH6aggvIcAb3Cl8JFTsMgpl8O3hewnQsds5wtF7yOp9Pa7jA8o0yqtGuLYEyTn5
         kdDw==
X-Forwarded-Encrypted: i=1; AJvYcCX1q38uQtudz+Y3CuYvajHi2NFJw6gz4X9K8YlHcsm48iCEZygGHmlpOkBI03UGm6injRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yYxhllZfq/9zXxJoVB3upL66Ze38PA6HaRC9SMPp2E0uejYz
	K9Jk9rOKKZE9jN5XTCJhCnU+Y4n8LnaKS5OIVggTgMkvNOZdNjhwV7GdteZyspk72z31sAnVFvf
	phrVzQqN3oiCc+PzSrldq4lmmolY=
X-Gm-Gg: ASbGnctDoZPJYY1ShkQ9Wqn2qwzbWOoASEbNYZ5XklrAV5viE11n+t1z/OFv1bucnlB
	CntaHH5s5DVyhDOyjLZxsHWLoFFx/lM6Od7BbHuyUXKjiKwEjX1F8gDCKtAqWsw==
X-Google-Smtp-Source: AGHT+IHckG/QgiBp0WeYSg12dtGMnojCn00Addkduia6y1cdUVHAOg5/sRjoiUW03zNLsD4ef9EpuG6RmgsnyUHcb8g=
X-Received: by 2002:a17:907:1c22:b0:aae:93aa:9ac7 with SMTP id
 a640c23a62f3a-ab38b3da31fmr2513978066b.50.1737651711793; Thu, 23 Jan 2025
 09:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
 <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com> <c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
 <xmqqfrlawwd9.fsf@gitster.g> <xmqqbjvyww3j.fsf@gitster.g>
In-Reply-To: <xmqqbjvyww3j.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 23 Jan 2025 12:01:40 -0500
X-Gm-Features: AWEUYZnpbxSLEj7qCEurBZfCjZK-Aswa-v1rlAp7PGB3JEQUFBX7qYfzA2fOlHI
Message-ID: <CALnO6CDH1aQrq0tcvr4rEGukksYv5bJ9W4icqBUC2Z3AyixRUw@mail.gmail.com>
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where no
 value specified
To: Junio C Hamano <gitster@pobox.com>
Cc: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>, Adam Murray <ad@canva.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 1:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>
> >> This patch looks good to me!
> >
> > Thanks.  As I punted on reviewing the tgt_perf part, it is very good
> > to see somebody else step in to look it over.
> >
> > Will queue.
>
> The test part used broken indentation and also the use of
> test_when_finished was careless, so I'll touch it up before queuing.
>
> No need to resend.
>
> Thanks.
>

I was curious what changed, so I found 792a3850fa (trace2: prevent
segfault on config collection with valueless true, 2025-01-10) and I
noticed this:

-       redacted =3D redact_arg(value);
+       redacted =3D value ? redact_arg(value): NULL;

I think I expected (based on Documentation/CodingGuidelines) a space
before the ternary conditional's colon. Then again, "git grep '?.*[^
]:' *.[ch]" finds a few other cases with the unspaced style.

--=20
D. Ben Knoble
