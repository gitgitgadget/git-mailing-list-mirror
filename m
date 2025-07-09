Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EA27AC3A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050232; cv=none; b=VyJ5Dg3WGrFk4Q/PJdmvH22TNYAzTNaxc0+g3ksat0dn8YDd/BV3KXQHORbYe30Amwc0yE6QEVsJdFJf0rV94lQXKDbJZT5uwJUwz62B10/NFbXF5Vp8tpaH1ExkZjs1MM77SEbJw9GODlEZ0Ji3xdOaVYzP6j+FY8JnkI8hGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050232; c=relaxed/simple;
	bh=p/4V+AsphoHAVIFAWr4qBgA78C/e9m3OaAaadeIJsco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCDxzmVJR518hEq5rOmV1NMkBNBa8cTsrIX1R/O9nFLCf5MUvxidEMlM8SxHsV+MMcz3PygC9tYyTwpBppZPXXO/8vT9Svxr+bUfjYquMWepRCMaiW3if95FaoiKr5lOdDTCigJKxCe+g/Tz1MsetfXK8ajvHwx6nRbtLMcNYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI1mKiVE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI1mKiVE"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb5ec407b1so920265166b.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050228; x=1752655028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXVXkiEppbaPg0++6M6GQZyewLoS09PIjFhsRA1sDdE=;
        b=GI1mKiVEI+bk4Et+gsCBfN087oATKiG07ra8u5UU+CqkLV+9XN3Uvikk7lqYY9bCGo
         mOdbs//6+0kybwFnAkvjazWdMzapymNvJKm9dOrEB4ltBOVh2UShA9k7k+PIChgyiBNj
         XN8f7I466nU31a3G07am17WX3gEj4ucUBzk9t1RMxI+YIx9R0eze66Wtfaylrsk/4zRq
         j9rRzCy3XDv6jCYktOBOgrG81gbk5cOhdwct2LxZKB0Hw4PVllEVONDU5Dr02hVL+I0E
         K06/2haFE87o876Fp0hopGGTjpNunzOZMz6XMyFJI2WONJ0sDeDMhoZ8F2jopBCvld2J
         flEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050228; x=1752655028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXVXkiEppbaPg0++6M6GQZyewLoS09PIjFhsRA1sDdE=;
        b=GuYcXMmkAqKDlrgW+PAh3qE0nCcYcdSmfZFNU7vfaGyNiEiH7GqcrO2YCTWWXA3nFC
         //O1fBylm0x/7FnCX2x7dFSw4K6A4mPbXAHSD/0O7p8qYh4VliDyAPMGm4CEwhNauJmB
         +zc+qc72fLOgeeaUhLCIULtynIgsH9ucJPdZNRuyJ5lqGbhUlnaseQYHXDpm+Jtptd8Y
         ztScWl2QixLYt3VQktIOF6T9/xTums+hqX8YSAEQGbRJdur2mY/4hX0k61lbA5EWvO0c
         z1wIkG8pAm5KhoPc2tdnBVkMlqYM0ySlPxrZoeZJQom17RqJ4rCDD6bZckqnNkZE+rNd
         tznw==
X-Gm-Message-State: AOJu0Yz3z/DehBTspkO/NCH21TiJVlgBBpCX+/qQE350fDWKmEwfsil0
	7vwwMzF9eUXBipd1uePJPDtRaLFnTgpGuItBcj0WFmMh32XpO+PmYmHlHxsZqnyTiRAH73W2j53
	r3PNg6+y0Nz6pV3txpiOxvX49cse72QIL52pw
X-Gm-Gg: ASbGncuaOGztAuU2hABhGm4Q9NkT/48DZ2J5Q1UGMAx5tOchw+aed12U9gY5eLd/xqd
	SkyGfNK0eXX9a5joNVBbIOqQF9zn46QK3TLfL+kDR1S2IJjcF3z1vzC+w3RHm/jRWmIKinimOo9
	mDnAyY4LXlPiXHwxrhQmWnd9MebmEP0zdCWkaWju9mmYuO
X-Google-Smtp-Source: AGHT+IExhBh5cDf0yGOQjNXmGcmEBlYJ6P461W9/debairLK1BPWn6/72T5ZKmySrJyeMqQkeC2psEayWMXfWAmRxwQ=
X-Received: by 2002:a17:907:c1d:b0:ae3:de00:3a31 with SMTP id
 a640c23a62f3a-ae6cf76e566mr159911266b.30.1752050227923; Wed, 09 Jul 2025
 01:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEWUs4iWwrOw4sXT9PhdccZyWtcvTgQfHDbeavTk-2kOdjUMdA@mail.gmail.com>
In-Reply-To: <CAEWUs4iWwrOw4sXT9PhdccZyWtcvTgQfHDbeavTk-2kOdjUMdA@mail.gmail.com>
From: Adi Shavit <adishavit@gmail.com>
Date: Wed, 9 Jul 2025 11:36:43 +0300
X-Gm-Features: Ac12FXxFP1XGxR4RhAE2Of4cxxlhYnA7GolK2OpUJEs5-oxWh0IaYqqzn5SHS_I
Message-ID: <CAEWUs4gEsASB3Fog2Zc5tEfACPURjHPqaS6e2XNWj0i50O-e5Q@mail.gmail.com>
Subject: gitk: visually indicate whether a tag exists on a remote
To: git@vger.kernel.org
Cc: paulus@samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

*Problem*

When browsing history in **gitk**, I often need to know whether a tag I
see on a commit was:

  * fetched from a remote (and therefore shared with collaborators), or
  * created only in my local repository and not yet pushed.

For branches this distinction is obvious because gitk lists local and
remote-tracking branch heads separately.  Tags, however, are shown in a
single list, so a locally added tag and one fetched from =C2=AD=E2=80=93=E2=
=80=90say=E2=80=93=E2=80=90
`origin` look identical.  This can mislead users into thinking a tag is
already published when in fact it is not.

*Proposed enhancement*

Add an opt-in visual cue that a tag also exists on at least one remote.
Possible UI sketches (open for discussion):

  1. **Suffix** the tag label with the remote name in parentheses, e.g.
     `v1.2.3 (origin)`.
  2. **Colour** or style the tag differently (similar to how remote
     branches are blue vs. local green).
  3. **Tool-tip**: on hover, list the remotes that advertise the tag.

*Why this belongs in gitk*

gitk=E2=80=99s strength is that it gives an at-a-glance view of history.  M=
aking
tags=E2=80=99 publication state equally transparent would save users a trip=
 to
the command line and reduce accidental =E2=80=9Cforgot to push the tag=E2=
=80=9D issues.

Thanks for considering, and for maintaining gitk!

Best regards,
Adi Shavit
