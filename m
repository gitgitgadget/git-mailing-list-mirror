Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AA4683
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228622; cv=none; b=oKqxBuT9u6Idnbj7EjqH29VsylZCFcurdAsHS+vybYpsGbfe9P5S7vbezbU1yA0jwHIS11H1gkYPke4X25cy+N3aTZEryTYxxGgRvi6o5l/k9/xknTDYVq+GqnItRrJt8mI1WsSeB5+A5i4c40MzzIPEEuR+NvwAZOhLdzt4D2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228622; c=relaxed/simple;
	bh=MQQpC5srpV84K+mn7PKMQ+BGzOkKQrns5+jCoXSvSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j894tWVIsc7zEgvv9zybwHOh/j7BSgj0Iy3eDkyTZJ1vhLBFFCSzZtdXlvfwdYcWPtZdwZqM8Qo5Xf1VAX1KEND16RnsQ7R0bhjTcbFVDeE7GBEoBN7/dvkSkOK3+bytqfB/IAmQsxuzp0nOFyAKSGNKXZXBWAFlWJu3Sy5BUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdAqUgw+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdAqUgw+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a34b468154fso608566b.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706228619; x=1706833419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQQpC5srpV84K+mn7PKMQ+BGzOkKQrns5+jCoXSvSA4=;
        b=mdAqUgw+6mn73wl64aj80KZ+IDNoduShg6axpisQjzcXZXDwOvtEIbIf6mJpLkXyuR
         2PyVDnFpw1jvPjZplP/D8Uxaz79eYY0qLgSJ4gfHZBQZSH+d4Rkh1qEHMzrh45nW8wNP
         Z/tQn/qlTyHyhfxpNiRs9fZgomI7Ajj5nFdWOXL59AECTlP3sV/b/sJxhClpiFAK3lzR
         GtctGHcXSYEA0udJH2YjrWrAW+6oLqMzr7B6jPEaqA5lXbBvKLRyUenQ8PQiZPFR/wsO
         55Ky4LH5aCjCBnHdOAqzDwRqwBIgd+2xTm/jk8Csi6bLcsgOv9+o/UOO+5AOw1b39DDD
         GA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706228619; x=1706833419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQQpC5srpV84K+mn7PKMQ+BGzOkKQrns5+jCoXSvSA4=;
        b=MMtkzXDCekQpbo086IQPcRVP2RzBY5woH/RTjURqUeHA+dibgWy5v4BB3QkUCdfZMm
         ruXMdcj1qmBuSQC8ehB4mRrGIWh44a02VGzMwsxIgScEXXIdXLw4MvGHxoRRiWJwGoMq
         b6yMSMMLztUrP23zv6aiNon4XGxFK6O4eqHSjkJ/sP6Yk7uMZGCIHVsRp+qk7Kn42AW+
         XB3yUGamZeIcv7s8aHqK4hW2IVgLnx8kDdrGxgEJDKYiV+fQnDBQ+G9C8IfqoJNqz+oZ
         DWMBHsfO/sLAK3L14qu3+NZBK3CzCmunwtED1tNo+gjC55BYHY3gFTJDlsZXQAD06MNO
         9XSQ==
X-Gm-Message-State: AOJu0YzANnv4GoHvPcOMfmRp3SczeT/IFRNs8hTSsoAKfA/qQ8e1NTf/
	L+dHVdkhAlQkeOwsouY2You7ePzt1PhvlnaZUDpTnoJy7brsnRgufVOxCLGfY0gePU+wHIYebIE
	QR1KSf/adRbBvTg1Rd+MWqHiTWHNODeVu
X-Google-Smtp-Source: AGHT+IEU18f+HMQOoWjBpyh6vOEqLJ8kk+P+e5xnx9Tk3EBC66iAJ3MuzKklZBuT8pqf8zGc5ehKtPoHGh4A8SSEiyg=
X-Received: by 2002:a17:906:cd04:b0:a30:6015:3030 with SMTP id
 oz4-20020a170906cd0400b00a3060153030mr106279ejb.110.1706228618592; Thu, 25
 Jan 2024 16:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com> <ZaofJhHsFjRxx7a3@tanuki>
In-Reply-To: <ZaofJhHsFjRxx7a3@tanuki>
From: Britton Kerin <britton.kerin@gmail.com>
Date: Thu, 25 Jan 2024 15:23:27 -0900
Message-ID: <CAC4O8c9qe2CNv2aHLwDBS9WaME=2DDje+QWq3T-OmxC5wAbw8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] completion: improvements for git-bisect
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:05=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Jan 18, 2024 at 11:43:18AM -0900, Britton Leo Kerin wrote:
> > CC to add: CC: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <=
ps@pks.im>
> >
> > Relative to v2 this only changes a wrong misleading commit message.
> >
> > Bring completion for bisect up to date with current features.
>
> Thanks for your patches! I've got a few comments to bring them more in
> line with how we're doing things in the Git project, but I agree with
> the overall direction that they are going into.
>
> It might be a good idea to also add a few tests in t9902-completion.sh
> to ensure that the newly introduced completions work as expected.

Thanks for the review, other than the one philosophical issue about how
functions should be introduced/moved I agree with everything you said and
will rework the series accordingly.

Britton
