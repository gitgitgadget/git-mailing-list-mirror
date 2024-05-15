Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660356458
	for <git@vger.kernel.org>; Wed, 15 May 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764791; cv=none; b=autjOSwYSzZWqSnKi7n0dlfwolb3x85uXjt+Pi4SCMi7MfIqUHUOtQ2WjflGdlX1F/uJuKZ8O340E6JBszGyYTcU1mkjoCpPWe/yChvMNzCCvJpG7Zv3OaltTQ0AqPoxFTSmG6YS/mZt2MIfFdWv1oyBo6H47/4Kb28I2j3O04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764791; c=relaxed/simple;
	bh=kqgGfhv/nvzmgKnPEL3/Jhw+UkbcFjHWb7dN/Eq86X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUaWjAaUIEA48SJhLGs14zSejGp6dl/DebCkn2O3kqAg6yAvBT2ndrS1JYuBFkmqUBwF8MEYDDRY/PBEXIoR4dvsMzF57dmy2zTMHmlTIUeqIaZJVyR7O0nlLovQvCS7+TkN5isAzndeU4LKmNQ6ZFfHGYI2i4CVXNgR9ozzhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cln3xCNN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cln3xCNN"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b81d087aso122569766b.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715764788; x=1716369588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqgGfhv/nvzmgKnPEL3/Jhw+UkbcFjHWb7dN/Eq86X8=;
        b=Cln3xCNN91Bb0mA22LGd6bzovVq/qavbUaw8c0xtXS6Opx84of7ngwF4CAcbVB4Hek
         9qp3MsTkyZBBHZk8gZM3XqRTYubkdMugtF4ajP8ZgneFEsxK4YdUmGReiJFC9u7cnVd8
         rwcpkW6+WHdrhEJxHpEExorh8eXFLj/kaoT6iyrMPWKSAA5Zzr5mWVLfuX2/NEqYlqzz
         QAzS5C9JIGdOtQHsZXqxwuKuCZOh/dUP50J8HigTxLpkyyc6/SLfEi+l6SmIP480aCrd
         b1Zdr1L5fEmswOipIfyxYp+aQ3qaaDf+LQIaHic+9UbwUJS6/UYrqpRm7IdD+mK+Ap5B
         PuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764788; x=1716369588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqgGfhv/nvzmgKnPEL3/Jhw+UkbcFjHWb7dN/Eq86X8=;
        b=wNkGI1AqrbsiDl7ZOIF3cVFoYLbk3CtUy++ryqID9KSi7H/cUSv5ct9qkfwjrQgl6j
         i/5mpfGm+KrUnvqac1tCbE+jL4cQvmcZ8pJoAtsPUSnuUDryxM5U78J5h3cJoZCf5n4w
         OE8THQDX+wFhABQ7ulweqks7/R5eJfZOad3yacOfXUI8Vq5kgzn+XuvnRfpdLRO0Icbg
         WsgLtHs0JaeAYdAMSb6UaQF50WziD8hw8g2rmG+bHYrD+yDfEzeBZbjoE5R0KI+Lq2Lh
         rAqEQ1tzEztWFmM5mA1kD3jzdxZrGD9gTaJVv+8oCMWoDnFkcY0Ts97O1pd5LHm4Uobh
         PsmQ==
X-Gm-Message-State: AOJu0YyhgWJD2SD0njhsQbKvESXzK8rHYz1ASOI+Y43CMztzpMV+fyvU
	peH/M9LqKn9jH04UtHFVmUkdAydiE+CHLnoYtOMnEu4P3HYc8u4xQg5OmP2+IXkNNpeovpYiI/L
	Ncw8EOP+FINBYVppUUfqUMqxpaKE=
X-Google-Smtp-Source: AGHT+IEwCebBymwh591sMZ/1xZF1575TgMogYCLp0GXWUazP88199PIKYTN3Mg8UKIH/7kM0DavwH+J5yNdgFoX68So=
X-Received: by 2002:a17:906:6d95:b0:a5a:5c98:c595 with SMTP id
 a640c23a62f3a-a5a5c98c68cmr987751366b.61.1715764787527; Wed, 15 May 2024
 02:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
In-Reply-To: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 May 2024 11:19:34 +0200
Message-ID: <CAP8UFD0u01mrjRfqrmv=ztv0-ek9yUebZNm-GmQyacLiynFxJg@mail.gmail.com>
Subject: Re: [GSoC] Welcoming our 2024 contributors and thanking our applicants
To: Jialuo She <shejialuo@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandra, Ghanshyam and Jialuo,

On Wed, May 8, 2024 at 6:01=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> As you may be aware, the results for GSoC 2024 have been officially
> announced[1]. We have 3 contributors contributing to Git this year[2].

Please let us know if you would like a call or some other kind of
meeting with only your mentors or with the wider Git community. It
could be on a regular schedule (like every few weeks) or not. It could
be a special Slack channel with us and perhaps others who would ask us
to be invited in it. We could also use this thread or other emails
threads either with or without the mailing list in Cc to discuss
things if you prefer.

We are suggesting this because the GSoC docs
(https://developers.google.com/open-source/gsoc/help/oa-tips) have the
following:

"Have a virtual introductory meeting with all of the accepted GSoC
contributors and mentors in May to help welcome everyone and help them
feel more like part of the community. This is something GSoC
contributors appreciate and ask for every year in their feedback, more
orgs should try this."

and in an email to mentors and org admins we were also told to "Set up
an introduction/welcome meeting with all of your GSoC contributors and
mentors (and other community members when possible)".

Also please be aware that if we setup something, you might help each
other on that channel, but you should not really work together on the
same things as https://google.github.io/gsocguides/mentor/selecting-a-stude=
nt
for example says:

"Don=E2=80=99t select multiple people for the same project idea: If two GSo=
C
contributors are working on the exact same project then they are
competing with each other. Likewise, don=E2=80=99t make one person=E2=80=99=
s project
dependent on another person=E2=80=99s project, that essentially makes it a
team project which is not allowed or in the best interest of the GSoC
contributors."

Also feel free to reply to this privately to your mentors if you prefer.

Best!
