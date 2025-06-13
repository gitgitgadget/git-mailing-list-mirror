Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738C1369B4
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797856; cv=none; b=R8uPen/jiUBSscbCa0D/QKHwTbC3mtgFEEJt0cn19ri5f6OwoR2k8LlHdP5LxmrPbOsWhF+QgVVViPN2helMJmT0RLaTgS++w08O4php3wnOti08+14RDRgaobVXPYJ75WpzwA1JsFwSDS8wwDWGinbhSszF/0J4FuiL7rLBb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797856; c=relaxed/simple;
	bh=bIZ6QicN67yXePin4fFWfoYOPfeJlhurru+O3GTgzKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY+xpsR1vOM5W1b2uLUfeUvppYvojY6AhHcIRtgdTfw14nfzyVq/Ig/nJ7y1X5rMIghQNucoWFXulXOmyroDEoiLJiLMmW7LUTpRR4AgfVmZr2yYrDz9qcONfXMDggHZSPAwKgLCPF3zmzO0nCZGAzS8/lB820zCNRdKhAqnJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0BW29EA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0BW29EA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2f62bbb5d6so1340340a12.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749797854; x=1750402654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crGaZ0yT/JFQmnlBR5e05z4UQZOmI8kyLYWHy0HLZmY=;
        b=K0BW29EASQSc+X9fKmc+HFy9hLXbxihKdR7mXjTXDOcSdMxtM09LFmaZAzHUEBkE4X
         SMkWVUlokMOUDSe4rtf4t+aVbmYAwn3Hcz1vKA70j9MJUTY0cWC8bMpCiS6gEkVi475u
         Gj9PEKjt0nXmr9kwAjIvwGyaapOWo5zTmGhmpImJPBIhZOjrCfdCD8UyJa8Rzuw6mNoD
         TITaJmy3KbADv6bn+2IrOEuI1zXJmB1l0VGVrIb3WMackRq7GcXCH8uDO5o19jv2QNKb
         QP5dNaayC4Xao8XLagJaUd/xECLyeQd98ReRBHlPsvBIOQd4sgoQGXQNyNUSp7scPpMe
         9Pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749797854; x=1750402654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crGaZ0yT/JFQmnlBR5e05z4UQZOmI8kyLYWHy0HLZmY=;
        b=F//4jd9CTiC4MeodN+slrcWC+oz7PnBU7NcaXq4KFh9CwCvw0QjkFL8gfSKfJEL46j
         09zXDKRanhgk6YBGP4Eejra0ZgISSImWyxTl/nO5/QIxYrWLQLwqbkfRhnm5bb7x/E6X
         w3MUac6cugtydGAxeGNhB+2bzzI2MY/IlouHq9DQUF6iq0jrhPd3U8T3ARGpYgGpXPXG
         6CjsZ7FAOroGQPWLOabOYLVv481AWZL3R4wOpHIgZcUaJMbPfSFl9iaoZpjSFD2TmghK
         3tLzYmD2+RDSA6i7dkzuOO6nuYj/fJ4821IstDNUf+B/Y1XfqHjtOJX8zNBv9QRjdoB1
         AJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrPOK1tgGkl+9DaHaSV2dUKjpWYEd4w1fYVROBeJUR000i0uEiWf9zCkCdQPpF828eLhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzsutMxiAzLnkdMgN+YbfJ6+8pvzfoPXGRuOwB1HD5KUGX1iN
	P2yIBr4i4qRy+JDjypDuBWZnkHjqvq28TkGg5zGVpFEPhty6Q+DCJ+ikz+AEnh5LciTTq4Fx5+e
	x/frf0Za2TAo5KsuYkIa9HiEWjZWZZjnItLKCryjk9g==
X-Gm-Gg: ASbGncscduNfb1KWf6C9jguBenFLWs3gPJ4KxUprwhKVfmaoXBE/bacpO8axhNQiBeh
	du8hX3mQweApYV6PiDFBOv8q6S33q1rtQFfR6lLwTmpSu5XK/5Iyl2ofXp2a+MO+wI+7fnpWYOi
	5bWwK6qIv+NNPZC19Y1PC/aNvLEntF5EbUzbGJuQ7csmDKcA==
X-Google-Smtp-Source: AGHT+IFrazCC2Idp/FxaVnFhV5pUTSuVV92s4b7oMJjWpUhCAGQp9lzGurrE4JXuXZgR3wngpWPsTT2QdutXBvWOhFQ=
X-Received: by 2002:a05:6a20:2591:b0:1f5:9069:e563 with SMTP id
 adf61e73a8af0-21facc94d5emr3004754637.21.1749797854072; Thu, 12 Jun 2025
 23:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <20250611173433.74393-1-ayu.chandekar@gmail.com> <xmqqmsaegf91.fsf@gitster.g> <xmqqbjquge0c.fsf@gitster.g>
In-Reply-To: <xmqqbjquge0c.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 13 Jun 2025 12:27:22 +0530
X-Gm-Features: AX0GCFuN1ITfYmHbQifNJRNji-rRfiki4nNe4hMg-hiFkJCdi3WnsM0iBkQLVGM
Message-ID: <CAE7as+aMtOvniTpNhTN083_7fMY=b-HR9R4HsqWSCBtv+w_+7w@mail.gmail.com>
Subject: Re: [PATCH v3] environment: move access to "core.sparsecheckout" into repo_settings
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	ps@pks.im, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > My gut feeling, if I have to choose between "lazy loading" and
> > "popluate in prepare_repo_settings() and then access the member
> > directly thereafter" for this variable, I may pick the latter for
> > this particular variable.
>
> I left the reason behind this choice unsaid, but let's spell it out.
>
> Originally, this was read in git_config(git_default_config) into a
> global, and that is probably because almost everybody that touches
> the working tree files needs to know about it.  So populating it in
> prepare_repo_settings() for everybody, even though the calling code
> path does not even need it, would be OK---they were paying the cost
> to read it when they read the default configuration variables.
>
> It seems Patrick earlier made a confused comment on the two models
> that may need a bit clarifying.
>
> Here are the rules to follow.
>
>  - "lazy loading" is not wrong. Initialize the member to an
>    "uninitialized" state, never touch the member in
>    prepare_repo_settings(), and have its getter check for the
>    "uninitialized" state to lazily load it, or have its setter do
>    its thing.  prepare_repo_settings() should not even be aware of
>    the member, if we are going to give the member a getter/setter
>    pair.
>
>  - "Without getter/setter" is not wrong, either.  Load the member in
>    prepare_repo_settings(), which will turn into a no-op once it is
>    called to a repo instance.  Use the member directly afterwards.
>
> You cannot mix and match.  If the variable is rarely used, you'd
> want to catch the initial access and lazily load it, hence you are
> required to have a getter/setter pair and lazily populate the member
> in your getter.  If your variable is very commonly used, load it
> once in prepare_repo_settings(), and because you are not going to do
> anything special upon the first access, there is no need to have a
> getter/setter pair.
>
>

Oh, now I understand it. I will keep this in mind when working on
these settings.
I will send a new version of this patch soon.

Thanks a lot, this helped clarify things.
