Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD6166F29
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380422; cv=none; b=madnIhPwdrl5W3ONe6PJOVrMbqj7oh1hyWKLEZYFnMZy8B17W8nvTdgONXQwu0fTWWFeK4GrXdLkXfmn4cncHG5tywVkSPWP4WdD6fq0RNjVcXrrodik66OFlfUgIIPXcnZmh941DBEo2SN0TWoIhqINPt75SvkoPBIWOaMhxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380422; c=relaxed/simple;
	bh=wKC4txPSC7tE0LZPgLtkrCYQQZRyUI8LRErrsbafa/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULlqJZ9rmlLBl8GwNchLqMytWISmRR5Zsm5Vulq1cuJ/wMCSDUwnMdQQwZKwyeZGk35R6pPz5OlwkOPCsbgbH21dtJKRv9ZDDN7gzt1iSMi9iC1DEibj0lmOMfQ6canJyLDXOkf+43Se4NzY+veJ7BVuogrUxmNsTp+qOBXrw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAUGYBY5; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAUGYBY5"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84f9ff42378so20145241.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728380418; x=1728985218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKC4txPSC7tE0LZPgLtkrCYQQZRyUI8LRErrsbafa/g=;
        b=lAUGYBY5j8kb3K0Zv9fVRbp5fz7xVwrqNhNwLTFesWLt7qcm8Cokk4WVlO1R1io8gh
         5W6tSut2he6Mwn8AArp5GdkYBRUVvW07ErqIA6YfDiN81rYqS5DEGb3ZzdgeGaJfNASz
         hbUXP/qEj/sCIGq2vNKJnOHwnCqal+91IoXNgpDflxH5JVID66FumshL/7MN1qR78Ehw
         ep1NLksx5TsKQ6zmq7DssaKyWekCfySXBCzUqiHN4bxEyUHZLlfGkOFUjRb13qIjYjaN
         e9KkhfQ7gpgtsaOZi62yBLlp2cYSt3diXR6HX3wsQfkwjccThX7m2Gqqf/6owUzyXiBK
         5r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380418; x=1728985218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKC4txPSC7tE0LZPgLtkrCYQQZRyUI8LRErrsbafa/g=;
        b=dBUpUJWSrbqMVL40wK93ZPAOdhDO7upb5dgapw0bsGSgPq9hy2pQnkX0ffzzqCe0x3
         7RntMKsdEw6oMVnvLSDGdvT+Fb2YCHzAwXJJjoLIthCfZoOhFpoyDDo38f9LKYYtENDw
         wvn/fPao6QzAggZS2Bv3AJGty9L0QTUOeMI2MOqEt+MyKh2m1xik80RXrE3BYbX8ecWE
         2dEtv1bxcRwZX5dnyMxjvsSwoT4mOZ1WIlp/QSSd08hE7/rtH0ZeisMhAB+lMKLv+Vrm
         9IckM45OAERXtDv2Sw49joLRm7ucaECP4BdTOgHJ5uTtQm7uI4ZBmTReS/9LkgO1Zz5T
         xA+A==
X-Forwarded-Encrypted: i=1; AJvYcCV2VN+e6Kc7UuLmQYqrUcDyLhMAJjXabJPta+GJ5Cy+n7bgpKXkEgUOCUfOb7Bt/MlZyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNOh8/d3D9GMAsrFiE6tP2cXU2LEJDCr5Fa7QTC8nLQ+5kZe6
	+g4zJHl1NsHvTJyo27frVnkr6Xp5/RDg3IzHiV2q5WodeRlwxnCpu//Xvsc6nT5O5GAjrx96hLY
	qfPR+kJ5pD4uIQMCC8kPf5Wq+1b4=
X-Google-Smtp-Source: AGHT+IE/qAaL7AGwuaivF1QGC/V5UuASprLYdaDKMuojXbguX/YeQuPEtTgOVipS7ne+N8sDrd9TDZoZAF2KVsKRaP4=
X-Received: by 2002:a05:6102:1610:b0:497:7085:99b3 with SMTP id
 ada2fe7eead31-4a4058f6e7cmr4027967137.4.1728380418529; Tue, 08 Oct 2024
 02:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com> <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
 <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com>
 <ZwNx-sKJJNDQ4sIC@pks.im> <CAO1n885jtQag_2gHkuVFggBH444vKCK2chuxfecvniuN7SMBMA@mail.gmail.com>
In-Reply-To: <CAO1n885jtQag_2gHkuVFggBH444vKCK2chuxfecvniuN7SMBMA@mail.gmail.com>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Tue, 8 Oct 2024 10:40:09 +0100
Message-ID: <CAO1n885jXKXDWzzO2ncCeyfTGHh9i-_CfPSYMvt1DHbF_BP=uw@mail.gmail.com>
Subject: Re: [Outreachy]
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:48=E2=80=AFPM Abraham Samuel <sammymore50@gmail.co=
m> wrote:
>
> On Mon, Oct 7, 2024 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> >
> > Hi Abraham,
> >
> > On Sun, Oct 06, 2024 at 10:57:26AM +0100, Abraham Samuel wrote:
> > > Hi Philip,
> >
> > one note up front: we tend to not top-post on this mailing list. The
> > reply to an email should either go below the quoted parts, or if you
> > want to reply to multiple parts of the mail you can provide your answer=
s
> > inline like I do here.
> >
> > [snip]
> > > Please kindly let me know the possibility of doing these microproject=
s.
> > > Thanks
> >
> > All of the examples you picked seem valid. You do not require something
> > like approval to work on those projects, but it would be nice to check
> > that there are no concurrent threads on the Git mailing list that handl=
e
> > the same microprojects. I'm not aware of any though, so please feel fre=
e
> > to pick any one of your proposals and work on it.
> >
> > Thanks!
> >
> > Patrick
>
> Thank you very much Patrick, I appreciate your time. Please I hope I
> am replying the correct way this time.
> I have created a pull request on GitGitGadget, please can someone
> kindly allow me. Here is the link to the pull request
> https://github.com/gitgitgadget/git/pull/1811.
> Thank you.

Hi Patrick,
Please I submitted this patch via gitgitgadget from my email
<abrahamadekunle50@gmail.com>
https://lore.kernel.org/git/pull.1811.git.1728328755490.gitgitgadget@gmail.=
com/.
My github account uses a different email address
<abrahamadekunle50@gmail.com> to the one I applied to outreachy
<sammymore50@gmail.com>. How wanted to draw your attention to the
patch because gitgitgadet did not include the [Outreachy] tag I added
to the title and the patch title does not show the [Outreachy] tag in
the mail list.
Thanks for your time
