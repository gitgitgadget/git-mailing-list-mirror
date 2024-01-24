Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C07522B
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065606; cv=none; b=pN4+OhJx7AOopnHUE/qaWiGBp8wrhib7Z7TXDKa1irENE3GJVrtvbCvB+BCp6v9B/si9rExVoMG5st+01Fh6uY0wM9JzMY2/JYBxjcrCMBHhCJlVfInZCAlQdMRnv+K9wwScFL/8sUrs8wua20BcCagGI3SaZIjxRGxCYzs2dZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065606; c=relaxed/simple;
	bh=4xtzTK+HACfXumfcCxEy9dT3nfsXUshG1G4YfeQTvk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCuqz44MCZAC+oioxvg6Eq+fOE9DKwy/R2rzWnYJPj6eUN0aTN8rkNosfLiLJPNF1ZlyaljukbMinQpMlAk6LP9kmzYXGnWAUZPoM9tmaTxqrYrjX2oaRp8OlL0CbRqxgbNW+v7v2MkY5JhFAEza5XhcaNufSb4t+jpEpQM/mpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1+wnUfI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1+wnUfI"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso7205727e87.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 19:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065603; x=1706670403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJ0SZP6AGSevuelRRkoIKxVdfmtjngHUHXmZYI6hGPw=;
        b=G1+wnUfIxGTj37Dj7a3IPaBcfT2EH9li5UqoLTblT7KZr3ewkJAB5GDlB4oIellJEO
         PsC7WuHlVFOrla2tCRT159bGq983Ho4gp84g4Gm8dAO5077mB23uv0OYDBCFoUrIiKAa
         KM66hBJDv22oKIeIMzXz7Me5UBat4v/N2Wv1sdK6QPYB3LlncRACn8V6Sp0xgimqYCo9
         Yj86e3Vq21Y1BXYQQvzru7p7qWkkGt9YOHOvn8eiyJWdQFVeHT5e+s8SkDZPMK09NanP
         QH/sFUdv/UTmKjND2iRAxpNjedXNRwIbqMYLbJcuigAISmfwH9xSTe01ByWU9seN6R2l
         Uqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065603; x=1706670403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ0SZP6AGSevuelRRkoIKxVdfmtjngHUHXmZYI6hGPw=;
        b=wkz4rswHbeHvn5XdBJqo4CxXrMquTiAqzMpnsSeEEd4ODBmeoVKQsbW4JrOQC49mJF
         zCVrhARHS6ZViaEVLRm5296jSSZ6yVdE7utOZ2pantBFEy0l1WdOZ601GtaodSLS0C+h
         aXY9pkK+mzwBAZF6JCsSuUCh6vYL88A0bt88gZBon1MdNwph8JtW6YD/rd/ioY2pm8EG
         axt/rE4aq2wxVWqumq6zHPdPhTZN09lvze4H5Ou9z6jzGUWsG8xOeX5dwpUEzJQo+PDG
         yJIzwEqKK5WDY4KuTO1LxK7SYGm8NsF9bYebpETn+yCcP55oWjERsgAOBhGpanztgMsm
         Rl3Q==
X-Gm-Message-State: AOJu0YxwtgPnZbdQvZc7TTxYt4FJu79V5JClS6J28AZR98wudz0rbEEZ
	qn56DSpnIZGQWsD5Sa3N0zMertSyn/L3QEg1XDebPQlbZriNNphTs2nqjsJwFAd2kzEfBsB1ipb
	Ghh+RH4DDVI0e6YvFVdfnRazxpes=
X-Google-Smtp-Source: AGHT+IEjDvoLt3agXjpalFaNY0HOBltb48i/kE/VXpfu2g/dj/Fx78hgv0MaWcC3v+DXEs72qUwcJCHtew++ykHT1pQ=
X-Received: by 2002:a05:6512:ba5:b0:50e:8e74:6406 with SMTP id
 b37-20020a0565120ba500b0050e8e746406mr4457492lfv.36.1706065602971; Tue, 23
 Jan 2024 19:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com> <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
 <10838549-c364-429b-a086-68a41b7369de@app.fastmail.com> <CAHPHrSd8rLj_TDE11dYQW+51--8YC4rumnfT+v2bYr+K7AMQrQ@mail.gmail.com>
 <xmqqa5owot07.fsf@gitster.g> <xmqqmssvnb8d.fsf_-_@gitster.g>
In-Reply-To: <xmqqmssvnb8d.fsf_-_@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 19:06:30 -0800
Message-ID: <CABPp-BEJN_gvBucfndfFbUUM+=0EwjZ=oWqGd4XsJBS9gNtoYA@mail.gmail.com>
Subject: Re: Subject: [PATCH] CoC: whitespace fix
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Taylor Blau <me@ttaylorr.com>, Brian Lyles <brianmlyles@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> > For example, CODE_OF_CONDUCT.md has these two (shown with $$$)
> > I think can be removed without breaking markdown:
> >
> >     Community Impact Guidelines were inspired by $$$
> >     [Mozilla's code of conduct enforcement ladder][Mozilla CoC].
> >
> >     For answers to common questions about this code of conduct, see the=
 FAQ at
> >     [https://www.contributor-covenant.org/faq][FAQ]. Translations are a=
vailable $$$
> >     at [https://www.contributor-covenant.org/translations][translations=
].
>
>
> Before I forget...
>
> ------ >8 ----------- >8 ----------- >8 ----------- >8 ------
> Subject: [PATCH] CoC: whitespace fix
>
> Fix two lines with trailing whitespaces.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  CODE_OF_CONDUCT.md | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/CODE_OF_CONDUCT.md b/CODE_OF_CONDUCT.md
> index 0215b1fd4c..e58917c50a 100644
> --- a/CODE_OF_CONDUCT.md
> +++ b/CODE_OF_CONDUCT.md
> @@ -130,11 +130,11 @@ This Code of Conduct is adapted from the [Contribut=
or Covenant][homepage],
>  version 2.0, available at
>  [https://www.contributor-covenant.org/version/2/0/code_of_conduct.html][=
v2.0].
>
> -Community Impact Guidelines were inspired by
> +Community Impact Guidelines were inspired by
>  [Mozilla's code of conduct enforcement ladder][Mozilla CoC].
>
>  For answers to common questions about this code of conduct, see the FAQ =
at
> -[https://www.contributor-covenant.org/faq][FAQ]. Translations are availa=
ble
> +[https://www.contributor-covenant.org/faq][FAQ]. Translations are availa=
ble
>  at [https://www.contributor-covenant.org/translations][translations].
>
>  [homepage]: https://www.contributor-covenant.org
> --

I'm always happy to see trailing whitespace removed.  :-)   LGTM.
