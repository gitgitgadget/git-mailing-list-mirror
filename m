Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7E85270
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250085; cv=none; b=skpbjIWhxze3UQI6AwOFBwHZiTmfgkHY6sES8DdJaTPNHSqs9POodwRUDH4CGKpnevnMx5YK526Dj1v6UySLbBWDLiH8vz9dv/bpfoChI+wlnXqcfrl8iYEh9uSCCiDxdN7xpJdj5TQak5DwMduCGr5vuc29rGAsRaoLUfxaVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250085; c=relaxed/simple;
	bh=QbOQlf/cMVIxzUYmKqfCM7vy5nOj3SxT2on8LWDUPYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfIVGR9bikU73I1Jwskhkgc2YmqjVqaXBjCsJiyD9gLn97uJQkrNGm249JXDwPn2pOHy03nqySUfflgYvKce6oX9qs1DAGrHOIQJVtIOF/KVgG0q+eUHk8wd6BhGgIPaQhQ6WlwR98DKN5as83dEpFw6rvc9lrAUXXNmk8oJzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l79mJR8t; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l79mJR8t"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a819488e3so2309542276.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726250083; x=1726854883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbOQlf/cMVIxzUYmKqfCM7vy5nOj3SxT2on8LWDUPYY=;
        b=l79mJR8tmFzfXMY6V/cgxRpIzCT0DltRunxJR2q1O6ufdOkTu+lg7HUPxyhRsCkphZ
         MNPJytCxqECVsU+zQDBlBMSQWOmg9WzYfK6Ba3EIvexqARNFAK1uj4LCDeVjFphNJzhl
         6kP9G8iXfHWWhrVxTVTn54Y4u8TsmqJLp3vxDeyfJsdMuVR7w2IaYEcY2bWjHOMWc/bw
         tDWM5BYUGRy5CZ4Iqz3WXTS7yRq6mVpRAlXfLQzMGtNX4wlYiQwCAUdiW2GsQvSMDHE8
         f4Vu3mH39tMoIcLFK9AiVFa3MEZ62R8juVc9fQW//xliulHIyycuYKfIxO89/YbGucZg
         1lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726250083; x=1726854883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbOQlf/cMVIxzUYmKqfCM7vy5nOj3SxT2on8LWDUPYY=;
        b=O6OBqe0c+ArcZXJUagEFpPYSNkbzOP3N2JxGWVZNongyQPrBMyScWVQFG94VXxMhiA
         JViOfV4D14OjIm+WlMDJ8IEJl41n0EMlcjihoXAt2C/UQtart6/cRHGf7+QKLFvLEi/e
         ZNWUE5S2ZDxJi8lwsRqdNKvOLkohu9cGO+ajbGRlU+gbf1zFaP1S13QRvPEiUkoA0S7o
         fPbEt4YujyjrTTEIyjHM7cbO0GE+XSgiMWIhuC1FPzIgXTes96hEn0cniXIVD1Lhzanj
         zHxclqtgP0vGHFSWzj4nXIUOadpcCXqxAJx47NGkLKrgyQHYeyVO0SFkP+id//JxY5hE
         8lzw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8Iz6grXxEXqdtYKqNYlO5ySLLmoeMd1TtbF5EVcg8yNnMeX19vIO7Lmiriv+xvpfpYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLLkHB4c6pD5en4iz5VPu2CcI+U9n5DEQKsLBcS0Z+Ka4iQ0b
	2GzN2rdTiJixhJi4sOm3obgbpNc06taEit1If9eO/qUFH0htOgc68jQePbou9t7DqExEO8vZsxm
	I0gpZ1XzBPpon+GZvP/89SCxBVK1qFIyt
X-Google-Smtp-Source: AGHT+IEkM7zbuI9lKLjWfcy2Wt4v04FvZW9WIMwAfgBTuMhdhflVCfGJqMU/rMfpkNZZ9UO6QPGdSyBwe0pGzM63U8g=
X-Received: by 2002:a05:6902:dc9:b0:e03:4efe:df92 with SMTP id
 3f1490d57ef6-e1d9dc48191mr6871226276.53.1726250082852; Fri, 13 Sep 2024
 10:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com> <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
 <xmqqed5rdw61.fsf@gitster.g> <xmqqfrq56gqm.fsf@gitster.g> <ZuK4RXMfherFBIxP@pks.im>
 <20240912104319.GA593177@coredump.intra.peff.net> <20240912105040.GA603079@coredump.intra.peff.net>
 <ZuLItS8eruz2b_D7@pks.im>
In-Reply-To: <ZuLItS8eruz2b_D7@pks.im>
From: John Cai <johncai86@gmail.com>
Date: Fri, 13 Sep 2024 13:54:31 -0400
Message-ID: <CAOCgCUJO-W3KGqp99rQknxmHVBS9+5F5fEZOU4aQT_0vmhON6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin functions
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 6:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Sep 12, 2024 at 06:50:40AM -0400, Jeff King wrote:
> > On Thu, Sep 12, 2024 at 06:43:20AM -0400, Jeff King wrote:
> >
> > > I do feel like I have only started seeing it in the last month or so.=
 I
> > > wonder if a new version of binutils changed behavior or something.
> >
> > Since I had that Makefile reproduction, I ran it against an older
> > version of binutils. And yeah, it produces the same outcome. So it is
> > probably just some kind of Baader-Meinhof phenomenon.
>
> I was also reading through recent changes in binutils and couldn't spot
> anything. But in any case, I also had the feeling that this only started
> to pop up recently. Maybe it's not a change in binutils, but in our own
> build instructions. I couldn't find any smoking guns there either,
> though.

Sorry everyone. I totally missed that the garbage file got checked in
accidentally. my apologies.

>
> Patrick
