Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9A35965
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818404; cv=none; b=hduOAutY8aMDnYtGfam4ljUUqML0pgGIb1oP2CoiaF1ofVAJ4H84Oav+PJU/vIaRnSMvtMvgErYJwqNK2MR0OnfoLUejYj4PZJS46zuCy6iFA1xcXGafibe1qSezpPsilHNmSpw4VhWZD2Cgr6hMdhwW8mBiT6sUjUroVn5y6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818404; c=relaxed/simple;
	bh=iT7wR65vAd2RQcXKJM9RV1gf+uUbxRvWUfep1iKM03w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk+ewwJU5ktpup4/xEoeGrEapbG9vw6Xtawh4Rh697+4B2+prRngxrsFojx7MoWC2w7PLLTl43+3k63uiCaTqx7/Vw1KcWwvXBer9jSUum5S6WsurnUfvMFL71LQTQ2JLMz21Bl/qYhBjnIZOo+hzFSBEvfMQ8CKZ+FLjjwOKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew0C4GnG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew0C4GnG"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39779a268bso7413415276.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818402; x=1737423202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WutBIoBjEyHXcWkm19lr2YzQrhmCfWseQ/TTsS/OzUQ=;
        b=Ew0C4GnGRz4SAfC3/vQ/abIpOEFe97WVbbWzew8ks+U7ti7Pu5SzeAC+Ot7fsAg4UZ
         YsAX7XYBCsiQDazTkrVuPyCCss3AEpwcl8CUk7VzovL/E/BLzyVVTWHhzs+pnKha8osF
         V//7nZQQI4qSWPcXONRTcuh6yG0soZPz78qOWDxHFy9pxt+Yhq2q1QZAcdpT4uGpEW4Z
         JZZIeN5BCRlgNoPWQPS8DgmQibIL3H7NDaRGOx4LO1Kv2wS/wT6uviC/1ikyAXtZLbIf
         HEWIkIDmYzN+mTuHCl71lfhmdbHA7WaDdpkmtzAMpvTmHA/zgk++PSGncLqEytbl9mWA
         dWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818402; x=1737423202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WutBIoBjEyHXcWkm19lr2YzQrhmCfWseQ/TTsS/OzUQ=;
        b=gaZ58CQ6TeK+h7TcbhCw6PyR6iXRrWZWVHz7IJXTG+iDytr8G2dDr3zVniVW/lcQVT
         J3JKMy/DMyXeX1o4GLyefSbhHs53l0jFMTnT+i3Zd09OOVHoyPp2Q57PqwBtUyDqtLG3
         h078V5Lt/Dtdg+ItQdYRQ6CbKsyqhQL4DVPuCmKqWKskO6bjy98HyGBaYnG4fLBe8wRv
         PvUhO9CYJXZelAqlOk2B9g1rswk8Qxa4lMrxzzCnNktw/l2cLvWQdA7nCpSQ+g6zJAez
         pwiqrJvYue1I5db+CoUUci+PhsP3kCK6kEU/WnOAt5RTaptheVqf2xlwfmhuZKbv60Mu
         Z2Rg==
X-Gm-Message-State: AOJu0YzLCNrt9i9Sm6bH9T7kyWKLqNHamBQhgr/hetG7WGia+6R5XBJ2
	yhlFMiXZi+d0NpeovyG9jdhHAWX6HoiR8pkyJ3uRTbwT5aPKmj/lW6Oi3vGjaUnfZXCFYrKsoPy
	kpvZxwp2qWBbLlDfJIfccmcVjOVU=
X-Gm-Gg: ASbGncvbdvc67OQj5yi/IFtuyjykUICKEi3pLhMkh8Mlpgq8PdEM/9iDmJwU0YsWBcO
	0Xr+FeNDPp71V4QkO/RqgXAZMnVJDja34OPp8rQ==
X-Google-Smtp-Source: AGHT+IHZ6A9Atk+M4DdiHetbLVwGYPvX0voDmSR0s5cX1IT0eBn1CT7Ts5M/SrxX+vy5Wzz01NbrKzpEJD1eJW/sbMY=
X-Received: by 2002:a25:df85:0:b0:e57:2de7:ede2 with SMTP id
 3f1490d57ef6-e572de7eed6mr10828685276.7.1736818402190; Mon, 13 Jan 2025
 17:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-4-eric.peijian@gmail.com>
 <CAP8UFD1U3P6ef9x58MBvrhDhdMn_3qe+Pjmf1L=Mi8Q5Ge0EPg@mail.gmail.com>
In-Reply-To: <CAP8UFD1U3P6ef9x58MBvrhDhdMn_3qe+Pjmf1L=Mi8Q5Ge0EPg@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 13 Jan 2025 20:33:11 -0500
X-Gm-Features: AbW1kvaTkXFXpylHFTWOo2azRds2goH4etqATSfYAjVZtXS25vO1PAbQ-uuCIno
Message-ID: <CAN2LT1A8Ns591s4zrZfccJDcLmXb-6umM6UvzJOA_vV4Oendkg@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] cat-file: split test utility functions into a
 separate library file
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Christian. They are all fixed in v10

On Fri, Jan 10, 2025 at 9:26=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> About the commit subject, maybe something like the following would be
> a bit shorter:
>
> t1006: split test utility functions into new "lib-cat-file.sh"
>
> On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> w=
rote:
> >
> > This refactor extracts utility functions from the cat-file's test
>
> s/test/test script/
>
> > t1006-cat-file.sh into a dedicated library file. The goal is to improve
>
> s/a dedicated library file/a new "lib-cat-file.sh" dedicated library file=
/
>
> > code reuse and readability, enabling future tests to leverage these
> > utilities without duplicating code
>
> s/code/code./
>
> > diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> > new file mode 100644
> > index 0000000000..9fb20be308
> > --- /dev/null
> > +++ b/t/lib-cat-file.sh
> > @@ -0,0 +1,16 @@
> > +# Library of git-cat-file related tests.
>
> s/tests/test functions/
>
> > +
> > +# Print a string without a trailing newline
>
> s/newline/newline./
>
> > +echo_without_newline () {
> > +       printf '%s' "$*"
> > +}
> > +
> > +# Print a string without newlines and replaces them with a NULL charac=
ter (\0).
>
> s/replaces/replace/
>
> > +echo_without_newline_nul () {
> > +       echo_without_newline "$@" | tr '\n' '\0'
> > +}
> > +
> > +# Calculate the length of a string removing any leading spaces.
>
> This might be a bit misleading as leading spaces are removed from the
> output from `wc -c`, not from the string.
>

Yes, I will just change it to "Calculate the length of a string. "

> > +strlen () {
> > +       echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > +}
