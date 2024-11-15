Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8912F585
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701619; cv=none; b=VJjS+D+EHMhtAXNGaFjkjjpT5KPAZPqlokJXN0YNB2BPYOSNt408KXUt8EEHa8hsV3Zkj6YXqqpyKnCMXJ0FwKFTM6UPEetfLUwnuDDd4WpG1zL1zT59DbsYAiFrC4NWPSIAzjiphOowdoEMoOTba0mYhgQjwWp/JYfEOHIC/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701619; c=relaxed/simple;
	bh=1s74u0yG8+YvHaMQ7Af4oe8RQ6cUHnN7gPNv8R0QsFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHz6t0/yD8S/St6slEPDPJxjRLrE1yMU9a+fOYwZMT//QsERrG2BEjh1TTaNbt/WAKlY9XynLtUzySXQN2DiVJ+yj7GyBkf5iKM5H8cTlQVk8GF40ND/RQ5i2VHJGMNuqN2N6P/R8Ap0nhJ2+YGhtrDBujNjarvaZXpqpMvmURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gF50AlHz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gF50AlHz"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf6f5d4939so1065a12.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731701616; x=1732306416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s74u0yG8+YvHaMQ7Af4oe8RQ6cUHnN7gPNv8R0QsFU=;
        b=gF50AlHzXAnWU/iW96J9It335mrq53MT9ULDuXVKddnM+KR4l7ac8yXVOah3O5DLeK
         d5GPX9Ou5UhOO++QK41CkVjuHU25el7P6rGZcvN0xTDJ9dZeJrc/FPatC5D6MYUxUuN5
         W2ldMOMP1Byn/Rg2eXgoOLaZkhqBuodpf/iqcNtJefqlupFLoCD0NnLxXxavPG3grD3L
         tgixa8X1D1BlZZMlzZLyHwsHROOIfp8XMD4ROmtauMFazwXVg4F9R6AwWIV129FErUJs
         v5cCswv1q7JBpKCsHUqJ9tconxZBxfPNwuHynMQtdH+aqllzyZFMVLhaPsxeGkneoGjG
         8K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701616; x=1732306416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s74u0yG8+YvHaMQ7Af4oe8RQ6cUHnN7gPNv8R0QsFU=;
        b=VPBt9ZtJr4z95MnyNLSZiJtQI4w0nOKrnC/cx8o408s9d6Nh3Kz3Hd/2FYHmZ2rdRU
         Og9IwVTrhl97ut4YOEEALQxI7OkDJfOTbTVwD7cxwXTB5L3iakWWl/rV5YMXoyIhJO7c
         TDBhtZ2yycxDnZajaMUyB2RNN0/v894FZi31hROc7EmcqhxKIkpGYx2f+a03Q3TC03nL
         Jysp6rCALezissiKGV9c8G575/nn9bIt+xCoh1chlKt8yplzJYT17iHjbLX4KkzC1FJV
         j5ECzDqClfx7UbGvzG0WZ58i8DvbngTo9+Tyvw5T7CGowy8MCuV7CWLWe7wE0fOTGt7x
         M4Pw==
X-Gm-Message-State: AOJu0YwAC2KFG7fZJLSxw1+5ebslOX1Q9AYgwhJTVatjoTFarQ2SKqqK
	25jDx+eWyteIZvxxQWA4/wvDbGCKeLAt1sVM35rwqXDaHkc2TmvunW0Hn75aJBAtgTskk/LoVxP
	VjQliRmiDlwgDjabHTYYd/qFuJ2nNjkmeNtcL
X-Gm-Gg: ASbGncvdR9mt9ks/v870RpnXWKEHz8FpmYLyPZbt0xRGSske2CULX9who/F0ycxPcFA
	MB2HkUWWNjBaUZEsz6WthN5nrcLMIaONXlvQbX6xBtLiASnkY9IISMdrI7RI=
X-Google-Smtp-Source: AGHT+IEghzLKIjfSKIi9p2qyrJUoH4B/J94viPycbNS6CvdzaLgMwd0r8+q9USBIa4fqv82M4hY18uubZ8JTA/+CuLg=
X-Received: by 2002:a05:6402:33d9:b0:5cf:95cc:9a64 with SMTP id
 4fb4d7f45d1cf-5cfa2a1d312mr4670a12.7.1731701615586; Fri, 15 Nov 2024 12:13:35
 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com> <ZzGtD4Jz9Wj6n0zH@pks.im>
 <CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com> <ZzL1jy3plVeld_3m@pks.im>
In-Reply-To: <ZzL1jy3plVeld_3m@pks.im>
From: Calvin Wan <calvinwan@google.com>
Date: Fri, 15 Nov 2024 12:13:24 -0800
Message-ID: <CAFySSZBioOrfk5O7oni3LRLWasFo6DsuyW7icDDVkiUxq4fNOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and unsafe tasks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, emrass@google.com, me@ttaylorr.com, stolee@gmail.com, 
	Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:29=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Nov 11, 2024 at 10:06:10AM -0800, Calvin Wan wrote:
> > On Sun, Nov 10, 2024 at 11:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > Hm. I wonder whether we really want to expose additional tasks to
> > > address the issue, which feels like we're leaking implementation deta=
ils
> > > to our users. Would it maybe be preferable to instead introduce a new
> > > optional callback function for every task that handles the pre-detach
> > > logic?
> >
> > This does sound like a good idea. However, would there be any issue
> > with running all pre-detach logic before running post-detach logic?
> > I'm thinking if pre-detach logic from a different function could
> > affect post-detach logic from another. If not, I do agree this would
> > be the best solution going forward.
>
> Sure, in theory these can interact with each other. But is that any
> different when you represent this with tasks instead? The conflict would
> still exist there. It's also not any different to how things work right
> now: the "gc" task will impact the "repack" task, so configuring them
> both at the same time does not really make much sense.

No you are correct that this is no different than how these tasks are
currently run. However, I have just received some numbers that the
repack, when gc'ing in Android, is the longest operation so even if we
were able to run repack first in the foreground, ultimately it
wouldn't save a significant amount of time compared to running gc
entirely in the foreground. I think for now it makes sense to hold off
on rerolling this series (at least in the form of auto
backgrounding/foregrounding tasks) since the purported benefits
currently aren't worth the churn. Thanks again for the comments on
this series
