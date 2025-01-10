Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCA1A23B0
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544391; cv=none; b=VRQbRp+0lURKN4J2gZE2u+6RG4+eAVazxvltr4fZN5nINB16d86dc7xSkBiUx23H0BXKFNxoeIz1GBG9iUuCT4ISoaeCxwpMSMwfT7E9mlkIoIUvgvT0Ra6743597Jrodp+8cR7NOoM8M2Ia1Bw5UQMFjFSPEafkV/SY63GUVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544391; c=relaxed/simple;
	bh=3yDubUqk5qGGP7cWORtkgBQkJEJWDbHxJvdE07z33JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR0DOdtBNgUnlcHryPJBgoeyF5npBKtL1pI+cUfgPwlH979/HVlGZ/iKqPtS+VUfb0crowKFXraZGyk9JZMHFiAhh/fGdKLsUF4dJrdPgvje/lj8A7t3EqY7AA0VKf6Q8do+6idvjP7wUzHcGhULl3jwdQ7myy9EIaTo4DjIKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKpnSl8s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKpnSl8s"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2f33766e6so6508966b.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736544388; x=1737149188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/7cIFJxp+qV2xRzl1pV/7ezMy18y79ZKlQmn3qPpII=;
        b=VKpnSl8sbF3q5rU/l4Ok4KZ2h9J1VkJWFaczhWn8uJ06avHuqq4u+Y5owuyaEkXF5V
         OnmOQlFi1ikwZoJTHf8KnT6w2ADeDY8HQOpfwiXkwkXH+1tOI5Zp/GpNo8WgyDD8P7QY
         fl1EUFcaEVh+F9wsfBC31LcHrSVNdmd1CaaWRni9P7smuGH9cUDKCcgE9498OOMzsYo6
         nj5gTv8vXuslxJVkKdU+DbFgH/M0fijXu+qJHqs1j5G19BBpxfi+ou56RLwK/9LbtAoE
         HavuMkzuKOFMVWC8ULWvxDD4A6MrlDZRllSi0cMF+k9LcuIysbtbhzWRJmk0DuYxkuRH
         ZX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736544388; x=1737149188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/7cIFJxp+qV2xRzl1pV/7ezMy18y79ZKlQmn3qPpII=;
        b=boG7IzvV7060s9wnHxMyE/BaWpz05/hobU1fP4LdLTFqlx2aASF9eCi31ND6gIh7ui
         7NJi8EHwx4T0XY5l8q/b78AdL1503Lr8sPayRLhPdMehd/YmVkpr+oy4oybcRCUosBma
         XJ8lOZRQK2amV+wPinfMih3yjx8YiwzpQ/nfPgrH2qb2AFC0LzCCs9pQLjRGQyuWMEwL
         MBpUWH5X3+8RnnsROC9HHbHsL5gT7wtDavhOwVO6sG7mNmCj1bst3b+5b2JeJhg4220F
         ysCO5DCTlTg+/e9dTRwRXshG4hARoMhwUK4R+CvF+3cIhk0YBEbOJGWDGKxrwOMz4SfW
         6TCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR3Ie5KglfdfRjBcSodsynYmx8hxnbj4glkdFGgUvGVsJNk+ObwVLbJpXuejL8h8hLVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzVmB6SOfbTyEiK5hesLrrxkDyauRWG3P1aoRstetWsDCnXpD
	4/hypNtmbeYSVB/NsDYn02Hhw5t0Zq7zPzfS4nqH2bCU+PdgayqMEEN4HdcVoA+m5W7Nk8LRD2w
	JsxojKVVbio3tAdcNbrcRKB3c/Lo=
X-Gm-Gg: ASbGnctQk+F+mk4yk1C+mW9IQV0gyjPXO4OxGu1YYnkiNGeVBtpgK/HjT6F1ihIxyH7
	eAiRo0Z+mkauck+9czMFrSqUgtme80sDYcZnm
X-Google-Smtp-Source: AGHT+IHpFUjcUdyaqnHwEtxLCq/X6zmaGjR8Id9t0I7dAOe/gZHSq0Hnj1JDNJvUP9Xq24pV7PZVEU88quB5pdjNEpw=
X-Received: by 2002:a17:907:60cf:b0:aa5:3e81:5aa2 with SMTP id
 a640c23a62f3a-ab2ab6fd5bdmr431798466b.4.1736544387986; Fri, 10 Jan 2025
 13:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1851.git.1736458019921.gitgitgadget@gmail.com> <xmqqwmf27cvv.fsf@gitster.g>
In-Reply-To: <xmqqwmf27cvv.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 10 Jan 2025 21:25:48 +0000
X-Gm-Features: AbW1kvYz6VkVqcRDtqNdFjPQIE1VwoeDQ5Rc1MHOhjgWAGEPL9ABwnFYacDNwzI
Message-ID: <CAGJzqsnGt7GSdNT0ToK5WRvQVvtxppRxx6W_y5sHNu2t2k_Rzw@mail.gmail.com>
Subject: Re: [PATCH] docs: discuss caching personal access tokens
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	sandals@crustytoothpaste.net, derrickstolee@github.com, stolee@gmail.com, 
	Johannes.Schindelin@gmx.de, peff@peff.net, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 18:16, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > Describe problems storing personal access tokens in git-credential-cache
> > and suggest alternatives.
>
> > +PERSONAL ACCESS TOKENS
> > +----------------------
> > +
> > +Some remotes accept personal access tokens, which are randomly
> > +generated and hard to memorise. They typically have a lifetime of weeks
> > +or months.
> > +
> > +git-credential-cache is inherently unsuitable for persistent storage of
> > +personal access tokens. The credential will be forgotten after the cache
> > +timeout. Even if you configure a long timeout, credentials will be
> > +forgotten if the daemon dies.
>
> Very true.
>
> > +To avoid frequently regenerating personal access tokens, configure a
> > +credential helper with persistent storage.
>
> Like libsecret and osxkeychain, you mean?  I am wondering if we want
> to be a bit more helpful by being explicit.  I think there is a
> section in a maual page that has a list of known and often-used
> credential backends, so referring the readers to that section may be
> helpful.

I agree, explicit is more helpful. I shall expand that
gitcredentials.txt section in patch v2.

>
> > Alternatively, configure an
> > +OAuth credential helper to generate credentials automatically. See
> > +linkgit:gitcredentials[7].
>
> Indeed.
