Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A7191484
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527374; cv=none; b=n5hBL5RdJ1NO2ZYjEsq6vRbN8jK4xllvWb/oPspwZcsEuasRzeHffolRQ3m0ozyPFiqHTsyOTN3vpOJlo4Dsi0es22mYJQOQ9NuE3mu9qbymRU5uB63o5s8RuQwFe9My3rbD35d/oSnCSCwdjmUDwVrE5LjgxYrYGAO2hhuiSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527374; c=relaxed/simple;
	bh=j+d53/elYi1rZZPjMkQzjPSRIseene0DVWFOMswmUOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhinCBNvzy1itKCGbcp1f48Cnpt7kbZ9COTW7N0bK0OcOmpvv7glduPsGJDquK77+5NaorKU7elZKIAQwXZchzTG5glt6wqeX3tHAlktQ1wrWVOMJoYyExzgFnqTKqvRCbcUsEU74fkS5pUC8M51pj8FC4Xz2Ckp8Z1iGB3EH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo9potxb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo9potxb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc016f301so8088171fa.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732527370; x=1733132170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+d53/elYi1rZZPjMkQzjPSRIseene0DVWFOMswmUOw=;
        b=Wo9potxb8nMAPooE9qfG79RRRm7KSyGt2zD47tvd5pohmNKnZDVtdhq9baDVZ95yTj
         KpiIkXjxlV9NPfyOpdmboPeYFBJ6E8dO+Y+JXo8DsfIuhzPsqG1e/Vn5bAbVCzP+1lZB
         fI5L5rxS1cC/upVqVZ9AWiX9US1kbYhnFpxx03Wr8nVNvED6Y8rsuUtUqw0K7k/a4e3V
         tPwj/Noe79rIYbMyCFOsj3CIJmlMPGV8C2s9O293RpuJw8Y/Qwkc0G6k+Lr3/L943IH3
         Mh8s3+TMwsuJldz/El7VbrBj15m1CGPzMuj59Y1SkuvFC0K18qd2QfaxnlkklkBfTVCb
         IAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527370; x=1733132170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+d53/elYi1rZZPjMkQzjPSRIseene0DVWFOMswmUOw=;
        b=MDJJSNo8Jo5/oFr2bFduQgOuvjmYPlPQ10lXgn173vRnQFZvcruS+e8wMEbsTDfRvs
         5p5+YaNfLAIAvkGejVd3berewxB1Z3n5K0KrMh/LM6t1hItLfKvAfBBh80jSGvmiDIgI
         IW528SwVTd5bK9iHGXPFhVioTgbh+xFLwxes16mzcg3UDuadLfoPUCSTa/3dWChENAgH
         6npBqD1vIV7poV04xJ9unKm1CDCRwPq0iaoiNIXSeAH+cqRa1kNTWt/AGGedySIf1eEJ
         0h4rjGD+0yPLVf4q1sKm4o5kaLQCB05QHGp3DFjm/DuXPOwBsKH+6wJZHcTmuZE5Xwar
         GhLQ==
X-Gm-Message-State: AOJu0YxejHyUFCcAXTJgCr8L99mcP6XO9CSHsY3TiVPxhdNiKkT7Kqs5
	BlXM51c6mpRanXG4Ionbac9iMUA7THTHPjx2THyiAGCfnBpJqNhov6RvJ/c2WcDjcjZH+Kd5ZGw
	2Hyl0yVRvvOrsB6NkA8+9GI0gr7v83Q==
X-Gm-Gg: ASbGncsyGNFO0IxcupFbt8Tm3y1mWcERQfRPzj8G5kXMO7+wa8FRtZdvWchvruVEu+Y
	eHg6Q/FEp2hJwtvIvp7t46CbVTG1VPnZXjw==
X-Google-Smtp-Source: AGHT+IEuoNnLKY3prU38yHk/EgcUL6Wz04rMGl6pm4OpNi38Acs4Jy5OJsA5XLHd4qF7Ex+kenyAvMJBad7sCWmqGAc=
X-Received: by 2002:a2e:a556:0:b0:2fb:5da7:47a7 with SMTP id
 38308e7fff4ca-2ffa7197a78mr58907641fa.25.1732527370321; Mon, 25 Nov 2024
 01:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
In-Reply-To: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 25 Nov 2024 10:35:58 +0100
Message-ID: <CAP8UFD3XYZe_10dBVpORKPq0PgMPDEAsbZAsd=xJB14i9Ocf7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] refs: stylistic improvements to ref migration optimization
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2024 at 8:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this small patch series addresses some stylistic nits surfaced in the
> review of ps/ref-backend-migration-optim. v3 of that series and the
> merge to `next` have crossed, so I'm resending the changes from v3 on
> top of what we have in `next`.

I took a look and both patches in this series look good and correct to me. =
Ack!
