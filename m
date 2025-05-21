Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403604B1E6D
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833589; cv=none; b=if5ECi9ij/eOsoTH3yz4zDwXGr78w+Y/SN8BXD/0N84Bq277gXgrapayRpr0lGZbpA2VE60dHug02Ch+PNKfFHG24ZB8t+lGvg/oSZhYPa+UlzZPuXaBp0wv9QR+PZKcpei/2XjKzKXPHi3WY0TJHP/Vy60YnU6yOrM6eTlWBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833589; c=relaxed/simple;
	bh=i6kw5AWjfUfhRGoMu04fa9rLompV/BOvnRe3ONFgCLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbLQYOa6HyiMnvuu3wXZ+awb3yNmQyuO3+ML8dUECQfcvTIhbw6VWcBty25PBF5M0kQmsxzmFeEPEOzfXF2ESsYGp6r3ElUkA6fkSeabDf0pKl2mIUOfBbOMkqcqih3zAmug+CnfjNxIXIiDiNcMu0EZ9UVYAjLBNEAy8jyh5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDQmrZ/n; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDQmrZ/n"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad545e74f60so790378766b.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833586; x=1748438386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjjNlI8/XU66c5faAjr8Qmr5nonmoOxWHSLzFRlYJp8=;
        b=TDQmrZ/nxpRdSM783OUmp2mdall2chRTvH1CxckdkWY4ff+bWfFcJUfVsgOWbFUew5
         OgFe7lavfi9kRDOtTN+8by9CQDz9T1NxQR3aXqMFYGDr0js7SI4R7XiolrCmT6qQFiM5
         YtYvSA678bMHS6dYzJ8obfIm7hU7ui5hysGpzZrGqE6oE3krzcGqlc9O6kw0RYwmGW0W
         OcwqqeChRGB8IsK22dKYCIAF38G+uUUn3zkISjb/XTInG+I3QrxXsvmWOOSU2QlpIyhu
         u1kVhGT18KMTeMA5CUESQ+czRSGOp/nSxLoNu32bSzSao/pChBNsQ146aj+9uqTC/p4e
         90jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833586; x=1748438386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjjNlI8/XU66c5faAjr8Qmr5nonmoOxWHSLzFRlYJp8=;
        b=I5XhinhUHpB3UrKyGkOIdhzkOAtXEYLMoF2HDZn3xh1SXV3cZ5Evc4ZAzcfbRGiygV
         e9+We8/poGIUgMGoCmQCv99v3nXDVlkr+QvaSYHLgyi/p4NAyAudJq2/VcyG95W4J1ob
         VDLm81L+DENecIJvHNvxyClQezebOftESJyFlxNewWpeDF5HfF36q/9R6N03n1oGwk4A
         /mFUUk7HdmO94e5wbqVI3JhJsP44t9ooaviIWLCkos2fq4oaPSkZXdr1cKLKUMhT3LrC
         EVtpLl3Ewva1TV/Q1tcViv2z5if8BQbtzv+XDy/pdheGykNwDnvohRkQJiy9ozHYJ/yG
         1SmA==
X-Gm-Message-State: AOJu0YyzQanZuQrZAy7N9iHXPDQCPAj7BDfZDH0VcGgwUeRc90yj2IDu
	8At5D8hiCcCnKfcBPGK9S2WPZmaR84hxb+YoSBfs6Cew2MfCfxIFGrzzlyvZXhEF0/Jm7Ee56Mh
	JM2CuYu6ANb4DiHDw1PHFKKkL/0iJiRQG+t/2
X-Gm-Gg: ASbGncvX3hmbtyds2xF8iVW7acNtkTN5cHypiRqob5WwXZjeVUzCZ+47YT77ssQorRc
	Pv33G0CvKlIREf4GQQc0nYjYPl62PJ2YsCGQXaGzlCPA/FN6nvKRGwYnZpGzW+Nc3YwhvFZ2AJO
	4N13bhAAqDfSsVSZlif02wyVQxcHrMPZi4DsLOpDYbDxu39i5k14dOojfEDioPClsx7BE=
X-Google-Smtp-Source: AGHT+IH/n9KH28oTgRd1rlS41MXGOvuItAwfkGwzSAOD7ulPOz4/+7rM9ylmwN+qlxGZq5PiVP8wO6kbw4QrPZZOv7Q=
X-Received: by 2002:a17:907:1b0c:b0:aca:c49a:aec5 with SMTP id
 a640c23a62f3a-ad52d4302d5mr1842940466b.8.1747833586249; Wed, 21 May 2025
 06:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747763769.git.code@khaugsbakk.name> <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
In-Reply-To: <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 21 May 2025 09:19:31 -0400
X-Gm-Features: AX0GCFtWvWlxI2ToAkUnOF_5RmW-mpaP7QrfvcYHHp7tcwor3GGpzn0dGZjUZfc
Message-ID: <CALnO6CAMgA1H3_Q+H6WRchMo4L2j_Qu8fdT4JVnfXyHwu97enQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>, 
	Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:58=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 46538012d94 (notes remove: --stdin reads from the standard input,
> 2011-05-18) added `--stdin` for the `remove` subcommand, documenting it
> in the =E2=80=9COptions=E2=80=9D section.  But `copy --stdin` was added b=
efore that, in
> 160baa0d9cb (notes: implement 'git notes copy --stdin', 2010-03-12).
>
> Treat this option equally between the two subcommands:
>
> =E2=80=A2 remove: mention `--stdin` on the subcommand as well, like for `=
copy`
> =E2=80=A2 copy: mention it as well under the option documentation

Ooh, bullet characters. I haven't seen anything quite like that in a
commit message in my short time watching the list. Neat!

--=20
D. Ben Knoble
