Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F984548EE
	for <git@vger.kernel.org>; Sun, 18 May 2025 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747545242; cv=none; b=HBg7BfqLmpZtTZfVFp1TJqRyGXwgf8mLdjbJAhPVNzNzSHpuCV9qKDuVNyqy8lwNOF8PhFQhLoXnTkvbQ93ynHYT+8MIgpntiXQhGZLKvUUSay7gJKWioGgtxvR7INADqs5NbhE1skqlyCEaoOD7SYQ1/OkUZ+MeEN/FOc69nrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747545242; c=relaxed/simple;
	bh=kGioUELkxCGN7e+XLyD8UFahN1PCRwRIrhm8EMU6iKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXN3e6qKjXPsucJpCN8F9P2N4xzpATos9SiseMtL3l2Gn+5X625hTwR6biiIkyjBKLrIL08NsqpEJNw/K4cUMoreEDH4ROfMkBf3gr0iiMe1T6Rvnszememo50OwF0QJqmxaW1t1nVWOLaZ+O7FW7tzEGpgYIsB3HCx5l3gCvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwng1307; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwng1307"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8616987c261so139638839f.3
        for <git@vger.kernel.org>; Sat, 17 May 2025 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747545240; x=1748150040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygZSQIdfijcyXW7JxNYAFCrHwJL58Pvt+EMxCrj5SGA=;
        b=lwng1307V97/t8hGXmkH+5XoJmYtjSctNU7/OhK/PoCw8yL4ezTQY9+4ujwNZP+gKQ
         Xn0ecx8d516+2AI61P2ctCz/ukjXcH0/fEkv4ee4VcutLGx4ofDSot9Krs89j/T+H/T1
         9/GryKcOHKEhgUNwKZm7kb8+k/oxAD/JuYYkjZdfvYJadJ6V+2YrBRG9Df/kxbkKzz9I
         wmjpTFUpTbMzdrP6T6cVNlhV5VWmk5s0s8sEt8oDay8XNRPci21q4AazcFIwRXcMcgNd
         +kEFIytjaraj7Fl9zuA6Eaq/4bIfAJcwleOEufloYi70lUGurSfygK1g338PyjlcKZcp
         L8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747545240; x=1748150040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygZSQIdfijcyXW7JxNYAFCrHwJL58Pvt+EMxCrj5SGA=;
        b=iV45PaVpFALZ0WU6APng8peNoXqLvc+xYNwNRb3OCIOb2vfjvHio8I3HrlAZapxIMZ
         diVmKrRclD8VELi8OxMhhzhax0OM83OJN9eJtV7mVvWVTU4hws3BBRFYK0AAND9YGoLP
         kOKgE0eZZBofLt0bpecNJQjE0jes8mFrd1ot3Om6HCeaJAJJxM9b2Ayt3qboO1reWaDT
         PP9U1MBFhUkWutCpH9b2ary08T5fPVYSe2qxcxusZK3YmJXVkt+osvGEWRngrxjjD8N7
         oFUqplyVKrIat+dJyEAvRfAwDkyIDzmmjouQsuePhazpmGBvDhHTN3UGvUhzDWrlKK3o
         wNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9rKIBSzqImSo+OGDHuzBBdZ9pHFkBnwOZfxMovlAqWgdwGXGdZs1qwjoM3dcsqEgGccE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLzkkvy9OIVoNG9uwCK5FWBLrjkYZlBTjAf3oGpwjedGztQev
	uxP4NVIFJTnASi5QPVBl8GrXbMgeNfbz5GwT/TW2JF+CFkAXWbuTnw2VXgth5lxI4Ln/XfXWzAQ
	Say0G9wYwRM+g9vKCaK0RgKsbij8RAP0=
X-Gm-Gg: ASbGncuO0g7fWLW9XC9vbVJX9rCYatCJ9zeUYuLqb9ADhJwmG/SUX2by4pjawNBltrp
	KuPMjyCX/NjiRHCe6/vYwNjpu4zFWQfhlpwnSiQhpNQmEy8dPmo3GcUZyhoYfHptxeJCfhqjqf3
	t4o12aGYf4BLNGw36je+pYWKcCeyUARUXrIvsrWviy73YjHNof9LYW0H/B2oeQ04O/jA==
X-Google-Smtp-Source: AGHT+IGGinSApUIYK+1YLjXPD35Q84TRpRbTDZWz8dcXrEyCEsHv4gaSuj4j2dNjMjAi53lAh6pFXp3qaAKl3dYekCA=
X-Received: by 2002:a05:6e02:2409:b0:3da:7cb7:78c with SMTP id
 e9e14a558f8ab-3db84303117mr82348815ab.11.1747545240111; Sat, 17 May 2025
 22:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1008ijb$6j0$1@ciao.gmane.io> <xmqqfrh3qe2w.fsf@gitster.g> <e2a24cbb-1438-46b9-b546-82c9f6dc7ebf@gmail.com>
In-Reply-To: <e2a24cbb-1438-46b9-b546-82c9f6dc7ebf@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 17 May 2025 22:13:49 -0700
X-Gm-Features: AX0GCFuTQPc9FKdQBlR6x4C--la2yWHUNsavENkFs9WTw7Kgs9KaG6qPBGcw2vE
Message-ID: <CABPp-BGRxierdcqWz2ZNdvLLrSSSR937CgOvC19vQkeUeC1pFg@mail.gmail.com>
Subject: Re: Question About Sorting the Index
To: Jon Forrest <nobozo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 11:48=E2=80=AFAM Jon Forrest <nobozo@gmail.com> wro=
te:
>
> On 5/17/25 11:36 AM, Junio C Hamano wrote:
> > Jon Forrest <nobozo@gmail.com> writes:
> >
> >> P.S. I'm trying to read the Git source code to get a better handle
> >> on what actually goes on in the index but this is taking some time.
> >
> > Depending on the style of the learner, I often recommend reading the
> > very initial revision of Git, i.e.  e83c5163 (Initial revision of
> > "git", the information manager from hell, 2005-04-07), to quickly
> > get a feel of what various pieces there are and how they fit
> > together, by doing
> >
> >      $ git checkout -b initial e83c5163316f89bfb
>
> Thanks for the suggestion. I'll do that.
>
> Meanwhile, do you see any merit to my idea?

Isn't the idea essentially the split index we already have?  (See the
"SPLIT INDEX" section of the git-update-index manual.)
