Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9F2EA176
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622230; cv=none; b=rkqZN2THisnJo8dDdxaDwx95do4s9DUlDOpPHeyc+6cCXiGoJGu2Ue2xAL8ZG5aPoMEl8KwG7EvWxwKHLyswZNJNTfbghuDt06q5NSM9XXb6Bj8xmls218y7S8T+jnEi8Y0QCm8rus8IoJpvCIAOaPSUX+nPouaQL5zI9xsTkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622230; c=relaxed/simple;
	bh=fVfh1LdXXDSvyWKXQuc03yNBfHhyM9BNb2gAc6uba1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD9MnuMTZMFH2xiF/JlldKSMrgT38XbZGZ8WWC6PE625+5+22XOX/G13OcViHPHOIGet21knNQCpD4M+7uhXrNrO+Ee1Vh1flznrOOVkJnsYUCPYrWPrFxArDMPiBRmcVIYlVvEC4p+oqtPFlvBtl0Ah/D29gbTnOFd+Uy83Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VplV5KOv; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VplV5KOv"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-9491ba846b2so21081639f.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622228; x=1764227028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adwBSeAD6ExP7xdyXNixW4rPjGL1hjMzDjGR1g5T8rg=;
        b=VplV5KOvkTgngFtqBB8iu+8HufDTEU5/MA9B5rwLORAn4O6ynymiP8S8StLxHXsGq0
         U9hD8QXyqdKGvISWY/C2zce69uf28be/Y97nW8l37fBo1TGL2r4tZUYlDzydWe9Bv2YI
         gt8hRZqga9Ud+OAXPf/q2DXPGH25vaiwSi4jlUP60nyZ0BVMF2rGp551Cew3ZypoCIs6
         ofQetDO9lW6C7gc/ypJDdLKySgw5HBfYOq1e7iSTsGFDK7HIsLOaPx9WRK4BkSCXfAa2
         QMqJccDW3w2EL6xtALTeIMlJASdt0vvTo9c0i+58Cq0feddDBvTMjnpEgD0ckib/pIr+
         +bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622228; x=1764227028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adwBSeAD6ExP7xdyXNixW4rPjGL1hjMzDjGR1g5T8rg=;
        b=dzEinjV1dVOYdtnQ4sgTKLf9hiP4CMziEfe6UmPk/1+s6MhvA3atTYPbBWhNHGeYyg
         5bG8B37VAqbIo2jrlHlF5GzZUbe5AzhJO5cxKdhgaQl5EEfotatISrCfgUH2vXV19ouB
         0kgyKZWepJI3/sOR44u/zsa/xaWe6sNB2XKCaBRRO10mGoyM4No4QMpwtUVbS7D471Ev
         jdK1naDXy5hZtofj8vKjrU9j7GrWuJlzUDoKUH1LvpJFHF9Z0wwBFCAnrcIlCCQ2n+Sp
         pr74EMsI7ZEahTi2b/ZucJapaG9wWqTB3P2hG74aQm9BgpC1uM+6k2L4PmvBqNXMg73R
         pZWw==
X-Gm-Message-State: AOJu0YyfKt0IxiNmbJmhbDLsOjVcqAdHGjzsDkX+OvbGId8rP2AH6pLU
	M/GxP6LAl5ibF4ffGxn3GSn/uwbBf8YCnita9f0GDU+bKeCd6oiSFPkcwCeUn0a8vj510ocP2tJ
	LnWqybvLh60l+0OGLTToK04jNB33L3hM=
X-Gm-Gg: ASbGnct9M4FFMG8hvcpwKDrdUz/ZibokMkvoW7W6bG4J/JxqRnRj/BYm78UI4XrE/VS
	NCU2KhDYn19ggGCVI6zjd+wqbfPlveAQ0qYJFuac4QXTwdHTZwp7ivJkuPSIIn6ki2HZ3a3zxN/
	pZ6fqiOX/Z+MfmsOaKdacNv+R0e/m7wd/NyrpaiCei0yYWtW9ze+LgdhL+RwZN0S76Z98qP5bMq
	/fGVTteEeKbsKywjU2pWoQ6IW4H3SrXvRyL9GYA04DhzYDMXIFdY80zKtKB17BU72jiCXz9pO3V
	NB8nPwQF8XRiiDmeBPPQdlSmUOuj+IUY7zKG8xE=
X-Google-Smtp-Source: AGHT+IEqcqN/0eqYGcS6F6+iCM9kzarE85RzvAYhjTZmQLQ+1UrYlB1bznZ/dZQHR60aYcUXYMxN2JfZXh/pv36rXdo=
X-Received: by 2002:a05:6638:1607:b0:5b7:c46d:f820 with SMTP id
 8926c6da1cb9f-5b954042e29mr2001358173.6.1763622228135; Wed, 19 Nov 2025
 23:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-7-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-7-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:03:36 -0800
X-Gm-Features: AWmQ_bnzz7KMDhlBcTHcX36HwFiQtWiWREf8mEzjdiXzqwn8EWfFNiQuhY-kvk0
Message-ID: <CABPp-BFLEFvQ_ZpFtEB0twtx6J5VcrerCa6aGsUjrctBQVyDiQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] add-patch: split out `struct interactive_options`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The `struct add_p_opt` is reused both by our infra for "git add -p" and
> "git add -i". Users of `run_add_i()` for example are expected to pass
> `struct add_p_opt`. This is somewhat confusing and raises the question
> of which options apply to what part of the stack.
>
> But things are even more confusing than that: while callers are expected
> to pass in `struct add_p_opt`, these options ultimately get used to
> initialize a `struct add_i_state` that is used by both subsystems. So we
> are basically going full circle here.
>
> Refactor the code and split out a new `struct interactive_options` that
> hosts common options used by both. These options are then applied to a
> `struct interactive_config` that hosts common configuration.

Makes sense.

--color-moved helped me view part of the patch, and --color-words=3D. in
some places showed just repeated additions of ".cfg".  Still a pretty
long patch; I'm almost curious if it could be split up into more steps
to make the review easier (I admit to skimming), but scanning over it
looks reasonable.
