Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99218626
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681805; cv=none; b=gpm30o1N+d9RgM6qPhUp/dattgFRXzW+86yJAeQr/D4LagzCT/+3A2nU9e9tE5fMqKtvi4VTePW2vPKFulyYatIk0kQy9Z8XPs6qRTQ+g1N7o/I4/RruwQPutVX+WTnE1ion9MJrujfrSO+kegdmoVvzsN9SIiBccqdZyCKTHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681805; c=relaxed/simple;
	bh=M3PEoLMdjfiiZht6yRIhN3tSgAGyHuylqIuJa+ig9UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcf/PHImglUvQuWH7ChTqC7eJABkYPxFMPETtl1oIsJs8yQ00qKyrd1ufgjdRFz98AZYw/rvb12ngHUe6uwm/vowep2lI5NTWRdiIfMb130OO0b+hxDSvX/3WfnOjmh601jq/goWkPKs70H3bFQ0lsExSeF2+1mYX+Y/a2ZyKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc7kBz2Y; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc7kBz2Y"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378e622e9e3so3773521fa.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681802; x=1762286602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyXSHQeULz2ZdF5Nevz5v3XTgHK6MCWbz88aXP2+oHM=;
        b=lc7kBz2YkAGEoYaRjUsgImyn8PE5m7G1x1+IzQBeGgJJPx4rUslDW6VigUlac818Iw
         yWwKOabX5BydjoycevTp9V+yxcFCv1AoyWORT5RRktqkvsuhbQnKcmpaTJCCKwaitvfz
         EsCnw6I9MQzkIyI2Qh7SJsgL3zLVvFVSpBOURqU7DyiPw6tMLLY7kmpWiys6Ce7HAVx4
         4jNXmvJGIEXdMtfv+9gJbtRgoa+ewXwncZa1IUcArhanoz3UToTPgoTuBSgCsBZEHg/E
         07/acqm0yJEExDyl54o7z9dK+LTqLD664mttS5Pm9U0wIaFB3Rc6ibtR5ccRhcfvuobI
         RvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681802; x=1762286602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyXSHQeULz2ZdF5Nevz5v3XTgHK6MCWbz88aXP2+oHM=;
        b=p3CASNbqsgxnRMf4RGzJrRH2UAktJJQbVKdDhIWIc/BW75/afgK9ORkRn0SN2XimW2
         v7qMCiWbSSOuJxZrq08qTIaBB6vVPZb71Q4N03blI6zOxorZg66H3a7dqGfI9+yEXR6f
         DGvZCDzjfK75cgSfvSL/EIpitNfMc4qQQbYFlOd2+HATb6AnCQljaAK7SJR4qDhur/Fl
         7AFiWkJxZxK/Lv1QnRvTYoq3DFbuSsstsENkB1DTEEXC9LzDl81fF1Ivu0KlftwO/wTU
         Fz47LNTgwmN7fevo2l0dJq9+kf8dk44paJi1Kj1cjMGbeF7Zv4zPTArikXalqYfVQ98K
         LmUw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ppvbd+wIFKUxA1bSZf8lq5Kcgr3SkcLe8jkmpPHlu6vZDb25S6sXd2+WsUPZu35fBuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgSurwhnOXDTEiTF9YEtPeXIySA769l+MAkuw+FLZ1ToJDNTk
	Calot/lprXxT8IiyWTHvLu1XMReKcP0wIK/SAXM+fQr/e+QUlGqHqoZeBVvl19OQbk0LU+oXfNT
	7S6tsX10DFriYsC8Id1IGZn+y6fzBAHg=
X-Gm-Gg: ASbGncuZsDa9iHzL6pomQuH2BfyLiKythfmxme2HjlsAnshasOLAsEtcNNFGG6y852S
	etJYCEHwyrGg6ai5h6R7X28K7RZZBGlloEnglrQOy6xZGqvIUdINe9dtON3gw+uTfG+EuVGcnut
	TVBkW1cDEpj1ShRrMqv7PfWyk/uMLSy4a1j1SuZ1Cazoh/3htKqEFYXqSEwx4Fy1SXhxRxaz1Rr
	PL9Eb7X/dNWfJSq7lsVPrrflt6HYWpF1dYF1S9CmAcMHJ6zV2i9iNsbmoMI5A==
X-Google-Smtp-Source: AGHT+IFZcU9/IuS/P257+u5lgU2wSuxQXQPAhSmtkDb/2U5s+9JDpoSmVbTmk0FR+IG0QePqabrBCw6tevlkExqp3Pk=
X-Received: by 2002:a05:651c:3146:b0:378:d020:b6b3 with SMTP id
 38308e7fff4ca-37907c4d528mr10378101fa.7.1761681802180; Tue, 28 Oct 2025
 13:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-6-sandals@crustytoothpaste.net> <xmqq3472dcfl.fsf@gitster.g>
In-Reply-To: <xmqq3472dcfl.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 14:03:11 -0600
X-Gm-Features: AWmQ_blY0X5N3Zcg34SERYSb9eRFBQtEWu3Ayw2F6R9rmmR_hNPa5TvFAyoHHmQ
Message-ID: <CAH=ZcbD80RGeuxqcDiWr2KNaQzFCrd=9fQOGo_+pW9E6+HmtQA@mail.gmail.com>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > +#[allow(dead_code)]
> > +impl ObjectID {
> > +    pub fn as_slice(&self) -> &[u8] {
> > +        match HashAlgorithm::from_u32(self.algo) {
> > +            Some(algo) =3D> &self.hash[0..algo.raw_len()],
> > +            None =3D> &self.hash,
> > +        }
> > +    }
> > +
> > +    pub fn as_mut_slice(&mut self) -> &mut [u8] {
> > +        match HashAlgorithm::from_u32(self.algo) {
> > +            Some(algo) =3D> &mut self.hash[0..algo.raw_len()],
> > +            None =3D> &mut self.hash,
> > +        }
> > +    }
> > +}
>
> These cases for "None" surprised me a bit; I would have expected us
> to error out when given an algorithm we do not recognise.

I think _Result_ would be more appropriate here.
