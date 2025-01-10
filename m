Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4661F5435
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509195; cv=none; b=LfICoZb0ffsNVXKEmLQd7Ob9Vc5JWIrCmU1YEaYsuO1wBtQqLcCCqr78/u4cBJWM2zWk48JvCRfZRHiJD6Yt9xA2wvlxwOYr9bxFcDZao0fPZM4KgVjo8n2oPaQ6mJz1qb7D3UmG2dRWqi1zfkAr1IdjaWznxDpHQQrZI8sKAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509195; c=relaxed/simple;
	bh=XxxebJbjeEO5Q3m8Ly5UWTb54Y701Ht7Oeh1Ra+Km5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywgowbko81aVZFGKo57V1fM8wjIcsjQyMx5yBwvwstWGqIMdHqEkNaUiC4MsLVEwCEbMEUFtkguYPhgouf3A7VOqXPXekMsgCEVkdLWOKzPgACjDE+cV/FdEuGII2HJND2XtEApvAdVTchJUbce4lL19U/O8T05Xj517cJsYsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxM48kkA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxM48kkA"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so3082840a12.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509192; x=1737113992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxxebJbjeEO5Q3m8Ly5UWTb54Y701Ht7Oeh1Ra+Km5A=;
        b=NxM48kkAwtruPvyI3R9X+O3IibhJFPrs8PItjrch/NDB4QB2hfu6bXqxEATMnKzCiA
         lVlPLXkN8QGzI1Hi4Ds4T5qDw5rQ0KAE5os8APB8FcS0TsjC6Vyz8+Y/1/35cEB5FEw8
         mVGwSljfN6Ov7N/bLnSYaMYI3JvItmk5wSsxa0wFtevakQH79xeFO1Foai1847sswiEk
         1P8yoyfzfOdX92HF5XQ1DUPU5YomM/eWqlQOv9dIuWKDS/KeeSNSZj2hTuikkAG1qYPc
         qvHCDKSf5V+ZcgaGFB4QzGHUQ0VTN0w8FNKjtfDUgQ0Vyp9xbA5JFcrkS8CdOSyy94E6
         Lqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509192; x=1737113992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxxebJbjeEO5Q3m8Ly5UWTb54Y701Ht7Oeh1Ra+Km5A=;
        b=aJEovUg7QQPvspUF3X6F/+kMfXKr8owsrfmcQPXAGyQe9pvt2cOHHRZlc00sFBVjSV
         hGkmbsDlQ2e5umvR9H0pXGBkZoN3VLKwMYXWkvcN83aD3N7uiXtKS0LjMOBNDmwfewHn
         PLbo7N5ykLGCdu0q75IVe7i6jZSHBp3ZfKrtgN0E0Zm+8myEVr8xvHDIGNE7hM884UU/
         P2r4TF5jhEvOWF1ribODRXSPx9KswRu0nOOvgevypnIdBoCRdRsCpL3X+4UWsDUOPiz0
         jOLrtCw92VjLeJmROhtInVWS4hCSkHFvIbbsa3+AAiKr5ThpFvJmy74MTk8BE+ciDB/H
         PpEg==
X-Gm-Message-State: AOJu0YwzXxrt+LVL6iB9zNWh+FeE5nccuXlpR8vzEtkbNTXGwj3Xwm+L
	QcK7oBphSW3biQ9qWujy4VZ1CENmdGHnmTw1lxFS1TfLneV9yQ4+WyThC1JDn04oMrnkMGl/9PC
	QJW8FvOKI1p/JS8fd0Z8TCRBWwzo=
X-Gm-Gg: ASbGnctSo6cBenoJ7tocOTQhAglx1+B8we4OBmMC6p3U2QrhZmZUEa6/u6pXrLX+pTq
	W8wERwZPRFhOp4zgLqx+QMtEjQ8frrX+JM/mIvxVs
X-Google-Smtp-Source: AGHT+IErgGrTfJrM09BR2owiymV36o6IMxJKo9UezlpJ/+UWxoia4rTUQsyy8ilYu0IdnqJcUbXENb9TJcWEGVvjUeI=
X-Received: by 2002:a05:6402:254b:b0:5d8:a46f:110b with SMTP id
 4fb4d7f45d1cf-5d972e17033mr10106162a12.17.1736509191644; Fri, 10 Jan 2025
 03:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-3-eric.peijian@gmail.com>
In-Reply-To: <20250108183740.67022-3-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Jan 2025 12:39:39 +0100
X-Gm-Features: AbW1kvZJoJVLfai_jyuISgAgKHwy4YvUssYDI4cBh9uFebaHcUxwktYbysUUK6A
Message-ID: <CAP8UFD2uVD4S8pWpg-oOdhNi_0m0ZTGOvaJX8MpZGFU9yAbV7w@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] cat-file: add declaration of variable i inside its
 for loop
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wro=
te:
>
> Some code used in this series declares variable i and only uses it
> in a for loop, not in any other logic outside the loop.
>
> Change the declaration of i to be inside the for loop for readability.

It might be nice to say that, while at it, we also change the type
from "int" to "size_t" where the latter makes more sense.
