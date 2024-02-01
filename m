Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B495F46A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799239; cv=none; b=VsF1AjgX9U1p9hx+YWHpRY2OtpsdOrIR3uTYj2QsKT+1SFxAW7c9FxbtZXoqeD6KBzilsI188mF34AUf+kpPwJYEaDAkgasBA9A7Hh8ttLna7V+vnGpAYXAFttld6XDLMZ12U+5kfj+uMyfoiI2iSJgij/Hmoc/mKSAlTRcGXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799239; c=relaxed/simple;
	bh=opXUQtZeoqwtHcGP29TC0P9PzwDqqJ1TuQyG7+a34YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SklDigtHscO1Jnzh35S9Zlqp/4CTS2QokgPb08YKUTPCefRLRkAZ/DA9aushgq02HyGH86w0rKrj58IAow4Xyd7nCSuqGaX3GSUwaEd2COzD+JZmn31AlHfC5a9sZN3pdF1VX4A/2icXyxzv98aNtdZTdS5FSYB5Dp1Y8M7zJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c438fde8eso5712476d6.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 06:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799236; x=1707404036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opXUQtZeoqwtHcGP29TC0P9PzwDqqJ1TuQyG7+a34YQ=;
        b=Ug2ZxD/m/UYvu0rpL3skEIWoXW2wOSbD2gkTGQrO8uLbH6PZ6+xLWK7Z3uUvBux8Th
         DDWSWMy4F4wy4lk/JDogEpgCQ28hIqg9K/XCkjJ2Sf/K9KgqyhBOZ1N4hpaw8XOQOgOP
         J8d//Fo5/kPGOHG+C5prFzx/ioRs+euB+6/7UxllGLKgnqwnHRaXN6BGjNsIrP/+Qrd+
         06TC/RlVa5BnXwhJJKkeQlMxL7lYULLw25SEz1ipyMUEyUffCnKeHOKg68r1ec6JU4aG
         +CJWSO5qOjlEuygfY7dlukbbM0Arz5yevpHWp5TvK6hXLxyJfzgziwfWkHK1lwU8Bthg
         t+kw==
X-Gm-Message-State: AOJu0YwnHaCKnkuVwSBgfmFZlH08MIxLLX2oeyIU675qI1TVwBqF3Mdv
	8St9NI2q7eXpIyZrbBl1A6FXTrZ+XGdub6EyIBWHprDG21d6Wy2CgOtqvXXAP2VU1DaH6kqC/Bo
	SQtmTGdSKEsVX3dNSTCViwALf8IA=
X-Google-Smtp-Source: AGHT+IEzX1qBJ76+jpDadlkd53ihOt4IDhWXaoRoObG8D3JOCb2KWja4uGeAdBwIHfFEMksJJpZAzH/D0VubUPpay3Q=
X-Received: by 2002:a05:6214:509e:b0:68c:539b:b493 with SMTP id
 kk30-20020a056214509e00b0068c539bb493mr5286019qvb.20.1706799236416; Thu, 01
 Feb 2024 06:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com> <20240201115809.1177064-2-christian.couder@gmail.com>
In-Reply-To: <20240201115809.1177064-2-christian.couder@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 Feb 2024 09:53:45 -0500
Message-ID: <CAPig+cSNM0VJZ5SpvazY5T6rFvXuoTdfgD5J5f36PW4iW7xLVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] revision: clarify a 'return NULL' in get_reference()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:58=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> In general when we know a pointer variable is NULL, it's clearer to
> explicitely return NULL than to return that variable.

s/explicitely/explicitly/

> In get_reference() when 'object' is NULL, we already return NULL
> when 'revs->exclude_promisor_objects && is_promisor_object(oid)' is
> true, but we return 'object' when 'revs->ignore_missing' is true.
>
> Let's make the code clearer and more uniform by also explicitely
> returning NULL when 'revs->ignore_missing' is true.

s/explicitely/explicitly/

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
