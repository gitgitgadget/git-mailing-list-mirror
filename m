Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6349FC0C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291724; cv=none; b=DOd8YGH3bkjT8z+hoZ4XG+N7nEFdG2fM1XH04aTJI055K7GkaIOIosyEnqEG8yh+agSPloQMF2xMdPP8oL8p4r8lF2S33VJfbKnnx8seRKDyiX3SnFP2ozz2SjvRW/13Al7EGanYdkSv7VsJ2qUeYHCgGZESE+h2AmESBEM5YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291724; c=relaxed/simple;
	bh=B/Qnn20sZuFrGea8J+ydCGQMQly9OOiVBImHELUUEWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCpvMt9jJ77Yg1/yo9cpSTUnH25ciMuywLNkNjUyE56MnxLXnyzbLzKBPGsoy5t85okywNCIbHRM/d8NfjpWcNWK1JiD35n3nmnkFwclSKDp7c1+Rv9l4xzpRYk2JOn5s+aY3aOqbtfiO2U7BwjgZzqdvT8TZtyiVuwLpqklSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HovvpIhN; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HovvpIhN"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a3b97cfbf8so1538422137.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291721; x=1728896521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Qnn20sZuFrGea8J+ydCGQMQly9OOiVBImHELUUEWc=;
        b=HovvpIhNRW3hQwfh7XxxYVPsd/OJjJDxAqQqOVS9pbZVcKDit0SNPpVAoEQnQk+3Ee
         fFQz1gUzPwQ1oqOy5kiDFf8UHEwR0SubLkcK2fKdC/9kjcuo27r4KqmTuNucOkYY6s9Q
         E7qO2re4VhcXtscK+/DDUuWo8nHxVJowHo0uCC0k/iCbn8T2fqCSXl8oilx+FcUQuQIl
         M1tVzdDdthN7php5Mom8sVpkqHs3Wj+T2GN2fBshwdwUNRbd66Q6cJ4ZYKo+xEelZVgr
         CbV61vM40idmA8XrQ1YMj0BHbFren6inefVxXkgsUvB9fjasV8jdX8tHrDpVBGVyWfvP
         /Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291721; x=1728896521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/Qnn20sZuFrGea8J+ydCGQMQly9OOiVBImHELUUEWc=;
        b=QTbyzA1dOZ+4kBm09i7/e8GTVramhkDF0hROJK8ZtQFsyX5519TK4SBf+edaGKp8+2
         jtBTrmKgIHBiRuKqH/y21jxDVVHme2gbuQA5uliwwvKv9HOStKoAbggAXdpt0LjEGD8p
         6mVgwpmiPlkOXfbR1HQcmc7Ky8cn43ZOaLVJkY3PSmsE1yhw+oQN2OykNlQIyqKiV012
         lBv29OoE8WLd4PCph1wA94e2L3E990NYQLqUg/DhoFH7+1cLXtJhT73JRfTph6IIwjcm
         3onFcfxS030XV8A9jdbDwa3RO8hrXQ2LMDbmmUpL0XbL0T0G6bPeJmqT0RJ8TaRmluMV
         dEFw==
X-Forwarded-Encrypted: i=1; AJvYcCUxGqW3OZzrXXUywkNLTUpKXQDkH1uUfdM/plqrTuAscTEDpwtjUtiQAHYMRyEl6h7WzWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk6Ph30GR0LnfgOGG6nbVvVjHOiifPm6i55qhjjyBBg7/fksS
	7uX9SxXgTASyQImfutxxIxpgGhZ4xG0X6PVoJcs6+EYc7pI1XK739a53v3V2364oidmCKLHma8W
	n07xfrJEQw4PjiwwRA9QpvmJoV90PKfOwd7Q=
X-Google-Smtp-Source: AGHT+IH8NQLd9+K6I6iaI5b5RFZo6ku/YtGDxMt9sOnZ8S4tvrtwcmelct+lnrPy62wJJJ8CYUQ6Z4xsBjSv7gSZS6o=
X-Received: by 2002:a05:6102:419e:b0:4a3:ad8f:4ff3 with SMTP id
 ada2fe7eead31-4a4058f84f4mr5825947137.29.1728291721603; Mon, 07 Oct 2024
 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
 <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
 <CAPSxiM9Z3q5Oz0PkadC72J0cU2F9D8Rh5eAtNz7aZoUZxp6PUA@mail.gmail.com>
 <ZwOW96K1_12Kzefo@pks.im> <CAPig+cTGESaCMfCzP7Zt3Y6JmG_uroCn1cd6_12W1QKLU7hk8A@mail.gmail.com>
In-Reply-To: <CAPig+cTGESaCMfCzP7Zt3Y6JmG_uroCn1cd6_12W1QKLU7hk8A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 09:01:49 +0000
Message-ID: <CAPSxiM9=CzKzjjQCmqeyt5mNf4jFMTwNzN7pzPhAgbLsM8Um+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:11=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Mon, Oct 7, 2024 at 4:08=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > On Mon, Oct 07, 2024 at 07:25:44AM +0000, Usman Akinyemi wrote:
> > > test $base =3D $(git rev-parse HEAD^) &&
> > > git show >output &&
> > > grep NEVER output >actual &&
> > > test_must_be_empty actual &&
> >
> > That makes sense. The expectation here is that `output` shouldn't
> > contain the string "NEVER" at all. And as grep(1) would fail when it
> > doesn't find a match the whole test would fail like this. So the below
> > would likely be the best solution.
>
> Thanks. I was just about to respond with the same answer. As a bit of
> extra explanation, the &&-chaining means that every command in the
> chain must return "success" (status 0), but the return code of `grep`
> depends upon whether or not it matched any lines. In this case, it
> returned non-zero which caused the test to fail.
Thanks Eric and Partrick. Thanks for the explanation. I will update
the patch then.
