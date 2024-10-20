Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8A2F43
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729459768; cv=none; b=hVDriivJd35BiIciWWb458QZnIoP5Wixqk/wlWDmJ/V2R/yZxuVyCZX6f8XzzmdCby0a+58VtJENdAk5b1/w3IReq3hfg5uki/Oo6+/qFPkOk5Qf9G7F+EYzTgKhxt0GfW7RcEnMqvCHJqaLFeX51ZM4oLw0GVRfleZWTirV88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729459768; c=relaxed/simple;
	bh=XjgN+Zg03SIdRaKJ2zKM5cZ57uO7VtIox8uzHnwkPRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osmck2ft002fm+CEnLfE5tjEd+nAnui4mOo6s5euHeJ/5AxK5wcXDZku1qOvh9LrZwjVygyNzcpWzBUqz7db/vpfwFA56Az8NgQ4+vFntuG246/IFsA2dM9+JAlHsaqjT8eOhIBfsJ7+FgATDv0zm1iGFJLGtgtMUJBqiQpi7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmRpVf3Z; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmRpVf3Z"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2887abeefbdso1951947fac.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729459766; x=1730064566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=537naWBtYloByb+67M91Ir617WPNm26cOQ9WphsbFDo=;
        b=PmRpVf3ZRCcCgPL2fsuFg5u9rCV0A2VYGGlc+yWmXyq/Ik1AqXfv5czHwbh5k6JvBW
         rFCSx4mD5Tuxhprfvd9R2mcYmkJzIXq8LEZhZtpCYZbVq2SJYDuc1Hm9E/PN5oWsYFru
         zOIz+RGa55kXQeaz72FeSSTIokaKmWymcQyvDpFwiQvZkaZFUUk6gETujpjs4bwjuxPU
         gP6jCXkP/odr+C7SNdyTOPkrrI+m7LGXAYee3Rce1s68HBzTXynklceD+CAE7tbOOv84
         JIpat/rvCojY8tKXpzBJF3GDFNOyL8jg3Jmi5WinQEwKeOs6GiEaMceidSd+yu8lGH3H
         RsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729459766; x=1730064566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=537naWBtYloByb+67M91Ir617WPNm26cOQ9WphsbFDo=;
        b=UEOAzNs1WWMdt1dIRVzXrHGyKF38S7CeFZCFhn01W/oahqdpA3K/WtPVsLbnQftLR2
         L6s7lk/+r3ItPFUFR4ZarjnSwiT3m9PvPTVX6dTtU4cC05gFkMbOrWtCPYdG+tPa5xqo
         QaHzmn6HyWKY6lHc3lkfIPw7Bv6dwhi2g6diGnc6Ca6VWFbr71gVK/++24Vf7cWPh+Fg
         WOMfkgb6yJu2iZ+MAFoQCD6v1GL7D+i5Tbrv4Lv3vnE0NAZiS0lD6tWRMuBO8QNKWHvn
         7Sw5J+T3HRs4YTlP/IkgDGYjSlnAeS5i/kSZMKO8nwLNYB+G0Kb49zXFGVyPJgiLmGid
         ciYA==
X-Gm-Message-State: AOJu0YzsjkT0F/ETRn1T0frHQrvIzwdjwYWiqFLwFaGGjOB449H/oLPV
	3GyCHv1PFGMNpUPENRfNf8tjj+oTVgTZZdhiYxo5gsqDEQLJ7+aUbclOOQesik4+gMRTloZ5RWm
	/diO1eD+U2M3Q6GmA8MrWWT2HV860ewc1
X-Google-Smtp-Source: AGHT+IGkoC+fyjBrLXqTYB8O76C7/PHXIIF+LWtFSLl6gmmRw8mGFw3p4qLL1SY4ltZew9sgatPBl5Zy/4QNWURRQy8=
X-Received: by 2002:a05:6871:724:b0:287:4904:7125 with SMTP id
 586e51a60fabf-2892c302071mr6774743fac.14.1729459765965; Sun, 20 Oct 2024
 14:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3a1ba01104da8496d52308c07c5c274fd30b0c2.1729443395.git.code@khaugsbakk.name>
In-Reply-To: <d3a1ba01104da8496d52308c07c5c274fd30b0c2.1729443395.git.code@khaugsbakk.name>
From: Josh Soref <jsoref@gmail.com>
Date: Sun, 20 Oct 2024 17:29:14 -0400
Message-ID: <CACZqfqBnqPpngxkYPhokOPdQN0T6tH4Zuzwv_wLgFCnY9FTXLA@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: tags -> trailers
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk wrote:
> =E2=80=9CTrailer=E2=80=9D is the preferred nomenclature in this project. =
 Also add a
> definite article where I think it makes sense.
>
> As we can see the rest of the document already prefers this term.  This
> just gets rid of the last stragglers.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Commit message:
>
>       =E2=80=9C =E2=80=9CTrailer=E2=80=9D is the preferred nomenclature i=
n this project.
>
>     Must surely be true since git-interpret-trailers(1) does not even
>     contain the string =E2=80=9Ctag=E2=80=9D.
>
>     I did a grep in this directory:
>
>         git grep tags ':(exclude)RelNotes'
>
>     It didn=E2=80=99t look like there were any other mentions of =E2=80=
=9Ctags=E2=80=9D in this
>     sense.  Of course it was difficult to look through.
>
>     +CC: Josh Soref <jsoref@gmail.com> based on
>     e.g. ac9fff2bf1c (SubmittingPatches: discourage new trailers,
>     2023-12-28)

This change makes sense to me.
