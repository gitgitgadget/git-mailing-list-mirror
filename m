Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51926A0C7
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029496; cv=none; b=rfVnNZXci7jyAjBBdHipstVfFYLqbRmMu6mvtcuV2vDMjcYyNMEd+uZwIafXUjau9S8wVlkFw2Fo4haEPYMBMKfFsx2+EgvTpLF1/7+bCmPy+qP0OpRopU0yxFP8VatHj63jIkumB6GK5K3fJrdoX8FsTSwtNFSZZkuemC5H3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029496; c=relaxed/simple;
	bh=+O4Q8VmTlkFkM0Cm3nkLpn8PSNouxHTZbxW4cQSFHYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USJ6ECwbpwaByGM3FZl/rdX2agZJIQUvFtLpaFhE5a9//69fcwutz52RCvchs72yn7xslS6E4uI799VnVO4FbeCT292xF8ToChplgUUvMnx9kC52DXibyzBZgPQpBX6OckAL7N1Md6AvQkBzz/T7hXVEalGu3BZLhSJc1NpuoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kROSKdR1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kROSKdR1"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4736e043f9so880644966b.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761029493; x=1761634293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lf8UDIFgoZP5dehcmyu8jZ6z9y2qNw/BdG/rrvV3Ek=;
        b=kROSKdR1ZxNP27LVRTBCzU3Iy42aK/5ZnZpxdEDKmR/7x/N5Bz1LMm7mMFRrfpr21C
         R3SDv8PnqCMC4CfETE8qYw6PO3GJGspAZ+NJzw+2EeOsQwQaJ9P7MithjmTtX0INxA3c
         UkVpCnGaRj3k99i5bs/yQENmC7Gld2LcDVz7/snuUpMODfoW2xaixT14phrIpgrzVglx
         nb/quj1Ce6hZGM2ABJjs4LwOKW1qTqWbUJSBn7NX0jpaA3ciAlS7DaTBkWtaepc+sXw6
         V/nO9p2Qkljxq/WsFnTHv1rm3vwHQcPQAKwIFmbHdMHY42wKdOqe5CnbRg1NRn3cROnI
         HW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761029493; x=1761634293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lf8UDIFgoZP5dehcmyu8jZ6z9y2qNw/BdG/rrvV3Ek=;
        b=A8M1YMXqHqVHKUcfeytVJYeu+8bCTBZgveoYx8Bwr06zUCAPxJeGrsTA7HUwuZuQCp
         QQq2tsNQsLLKxOwBKAdyM39B5pvusDsDG5i5sCnL778KeelvC2TuzHINHQRZmbK5FpfG
         xKcp/0IFfNFNgBB44Q/YnMJO4zx/HN86c0RKCGMF/6kdZWUpp5vDC6nqfYaYrVEXY7XY
         mi4FERxa7UYBfDwfTsi5gKF6S0E1XvGICg3pVCHF0mAxFcHz3SECkrts3dEwp59uOKZT
         A/jo6hsMrFVxGTXgIwhEeZl3rgx6F/dqlrD0UEPcvTTdu2yLtAVbvg4ocqQkMIY/hIvT
         BIGw==
X-Gm-Message-State: AOJu0YyNpH2rvvQee/JOYo36irVJO4DLqiuz+m/w5R8bbmszjW6zNJVD
	8Vwft6evFPHUY0ZybVMc2/3uMpUOEN6X2IAnpb5f37OdvmR841VG+4OKnsj9CUMmMZ3ckcfff3p
	X9H8yg/SacHOE04HkdsM90fLIAicyugR7/1U8
X-Gm-Gg: ASbGncugOjXwwVbPfki0nx4t3WMze2PBcAJhS/ODOuf6a/rNKa1I1y2QQExsf5inA0f
	LowJhqKIKDkclnHhwbmkWvnIXXl3NJPVfv5GiLNtO9o3sUDpxzPPrWQLrBZhMQek1QdjTPN9uZR
	xLEa5Rpfxmob50npiIwZlrqT3FceCsApjDMF37QTAMdaOmRFEs7zJkulj6YVJYlq2RZeY0MQLLz
	g2POnyWOP2sdIrlavg4hQWKusqX/Q1nL5p9SBxeurqCLWWayOjMUKIo0xPD
X-Google-Smtp-Source: AGHT+IFsTRMeFMzR+xVIdu7+CvUGFKNaNMtU5LTUSiNUOvyIrxTHXUAmLmMlQhX7J6jaFRF++MX2ofbxpHajs1tkUTc=
X-Received: by 2002:a17:907:3f87:b0:b3c:3c8e:1896 with SMTP id
 a640c23a62f3a-b6473b52634mr1744142166b.42.1761029493192; Mon, 20 Oct 2025
 23:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
 <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
In-Reply-To: <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Oct 2025 08:51:21 +0200
X-Gm-Features: AS18NWAHi6KlrazLualFJgO48y93p2l6bVsImKOSsSd-35oVt3oIu3QOSq4lZEY
Message-ID: <CAP8UFD1=b9NN6stjnPR62Nu0qQmcC=bM2ZNQ=cO08PEwYoYAzA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 1/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:46=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> > +       delim =3D strchr(begin, ' ');
> > +       if (!delim)
> > +           die_errno(_("failed to get the ssh fingerprint for key %s")=
,
> > +                         signing_key);
> > +       fingerprint_ret =3D xmemdupz(begin, delim - begin);
> >         strbuf_release(&fingerprint_stdout);
> >         return fingerprint_ret;
>
> I think this could be `return xmemdupz(begin, delim - begin);`, so we
> could get rid of `fingerprint_ret`.

No, actually I think we need `fingerprint_ret` because we need to call
`xmemdupz(begin, delim - begin)` before releasing
`fingerprint_stdout`. Sorry for the noise.
