Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A651D6DAE
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314536; cv=none; b=WsZL4XuydODsAk7hxT0qPyQBuwUv/SU+dIE6dnP2uyDH7vArp0eHn3+LHxgiH2VpO8Hm+GZGvTG/DFJbkhW69hhr7oHK/jEbnw7NDoLacgTU/D1eKf6Dq+y/UtXXyQcgPqrZZM+gjTWsPxac9J/KrTxI1X0cGQ+4VVgYTVS4krU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314536; c=relaxed/simple;
	bh=H2MRwEtBpGoVlhtolj189ZIcpR4bLvJ11PVwuOE6Ve0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgh6A6MnC/I3MSlFNN3deJqRxLyzOHy0wO6kwKTetcIR6Nh6O8YM9oh6AcnjR6IFnDyfwuDLhxPCe0BStN+Tmanj/OiXtYOlEhy/fg31ph/kiEOWnPVf5VRYtr9CPMGei4hu5zzcekCCrRV4bXWEwlBy8Uh/CXlGkIEpNCRGz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6so9rGK; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6so9rGK"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8323b555ae2so190958839f.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314534; x=1728919334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0F8dPpmIRqO3sJYnE55qE+LApJB1RNh99eLBTeKYhw=;
        b=P6so9rGKGD4+ObuC3PnnUZ76whWBwvwWnWzQoAcB5W0xBprkpjYe/IxBRMKFWK0fEn
         e8nCpV9QVXhAnBnNM7tqQyWGb5hmsFIxcuA+XHtIWxwF5ruUQ/Ya4bW+coxcyZiDkygK
         C7FZ80wT6udLTdmyxhkv3gO3feEO89AVpBvTjDDP7tnF4rEWEMMp786wE2FbWJnQvBhH
         wdInwBTZZS9YgugYeAqVN6W0ukZSqrZZj1PbApYYYpdREW3j8RMEnXZzeC9DS/XVr4j+
         jzxwxfMMUNjVieU+E7Jl+NpFnDppaxBg8FzZ61HndAT+zO7xFZq1eUFot7PblgesQUw+
         AgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314534; x=1728919334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0F8dPpmIRqO3sJYnE55qE+LApJB1RNh99eLBTeKYhw=;
        b=N8Bs1ckOb7aAA77wn0q0dA0y3eM8vsxlLDIKJvATQ64XWHSN6baWlilTvEzg/V21yI
         yHltEsFBphMkNIX/DHE/r3rkBI8cBysd+nREw4O6UWzhoRzpLgf/uHjxTOrhUd22UnSm
         KzELDOX14GRcyyyhf6frHaWNf5VjAOoTa0/ejfPD0m5TKPLkCeOZWmeuFK7XDo1X6/me
         0E63g7ySvhQzUWtRitY3q/AO4311ex5HFxieaM0rb1c62HnwKKzbojdv6I/xLs3Txwbp
         4niDIccRkeofr4auyBpWJv3h4pzwUCQyv1fhMLKbmwIhxMZabDwBwV/wM94cLk2ZNuu1
         vRTw==
X-Forwarded-Encrypted: i=1; AJvYcCUhHFs0iuSCM4gbTdwMsgz5hlJarVl9nVejkMn780EEgtr/PIxiWa93CTNMdTreWBaIt3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrzeXeT7Zt8z8wqi2dVZU0IcGucipQVf7wnU3Qqp00XN/OGtA
	700TfiRhqDAoXcKjMzkNIINGFwGtcMftgyyEJ8pg0tIhA+DYPK7H2i3SbbIi/LJn85BTG4SPWJB
	/H22LvKy2DNMxnPVVIwyCUozNhG4=
X-Google-Smtp-Source: AGHT+IHiY2A0D9PlCVXkYygqYSzaQ26V1cU65tKqowMiHLPucGptwHYGhTQW/TrlcPXypgysUro9PfunX8J5T0ehH5A=
X-Received: by 2002:a05:6602:4148:b0:82d:581:8862 with SMTP id
 ca18e2360f4ac-834f7d62b07mr1043123939f.10.1728314534467; Mon, 07 Oct 2024
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728298931.git.code@khaugsbakk.name> <97f16cb68e059792ddc7d1897ab6e93d536fe19c.1728298931.git.code@khaugsbakk.name>
 <d18f6fdf-d0ba-40e1-a2b9-2fecfbdadde4@gmail.com>
In-Reply-To: <d18f6fdf-d0ba-40e1-a2b9-2fecfbdadde4@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 7 Oct 2024 08:22:03 -0700
Message-ID: <CABPp-BFogoe5+X8aTpLF8ksVbZJxwXOw-TCh6k5aAJctxUzZUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: merge-tree: use lower-case variables
To: phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:58=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Kristoffer
>
> On 07/10/2024 12:10, Kristoffer Haugsbakk wrote:
> > From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> >
> > From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > This is easier to read.
>
> I think that is a matter of taste, one could argue that using uppercase
> variable names makes them stand out so the user can see which arguments
> are parameters more clearly.

Yeah, I wrote it as uppercase because I thought that was easier to
read for the reasons Phillip gives.  It's not a strong preference, but
I do think the commit message needs a more detailed rationale or link
to an agreed project coding style or something, otherwise the commit
message may appear to be false to half the readers.
