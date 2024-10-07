Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE91BA893
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296822; cv=none; b=KDHsArKsMWuTZv4LY9NExYlVbf05FnP1F4RUHSH3R8auuqMeRcktrBc0p3UaTcmq087cVxfcdOMo606zkQxNA12kM5/riVpzpt4AO37f94xruuuTkq+0e1dyc02xVQjXVgW9o4rP4ikFr/+x2WAWbrXeu4mYbf15u9nUICt0azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296822; c=relaxed/simple;
	bh=29bEX/29AjLVVXLfSxh3khqFyIlLXnQzE4r0kGaQkaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0PjGiGFttElKw1gIOblJf8NeHPR+HBJn3t4hwH/7uqQZxS/XdJ0vRM3ik4BmsihNKW/j1hTnXm3597s3NKMHZUThefWLqVbfHeZt7Haq/XuoTUmaUy7zeHoybNQKTz/N1dqVSWWPtTM8BcVmWbcq9z/D1RT4mAoMXAzY3NB5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwgzST/+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwgzST/+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a994c322aefso190072766b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296819; x=1728901619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29bEX/29AjLVVXLfSxh3khqFyIlLXnQzE4r0kGaQkaU=;
        b=WwgzST/+T7RGhlC5ZqoHY17Q+1T7l+MSLjSPxCT93LgIInKpsjyN50gr89LujSK5Kd
         KQRSdPcJYab9IjAX5oDPp9rEysWPQSTsIsiifxoWCy/XF4LOrywC1MfYou3f5ehuEmUx
         TLrFA8bKeNFIiJqg/W6UvoOS8XKq08EOuejx5WQGw445+NRv2ZTSVUkNGdNe0TkqJ+3X
         sv9ti0f2OC6Sjc1iS7p/ccbAwxtdwBmcJlokp5gPvpf1Khax6bkuTvRiMfEEl2pe89vy
         PmdUL1ZMy3pV+4vL0FtllidzN9LzlH9af8Gi8MvONdmF+uAU2Oj88gUjRpGglXGhyK1L
         EfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296819; x=1728901619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29bEX/29AjLVVXLfSxh3khqFyIlLXnQzE4r0kGaQkaU=;
        b=I8O8+IUiu7/wusFVjKj/TSwm0zwXigmhH3WSYUqOQJoXC9XOipk5+FP+eyZuM61QO3
         bSNmaojdTzOnqt+h+ZHuwkjSwqo04Ge3NBIf3Gf7GDl8ERYaHcql+akjiRXDQeiLfp7t
         b07AwyJRJVpHIJ4A+MdJ6ra1GORMzD59eyiD2utWHPtQ4iAmNDkdQovU6+oN7XEGMnp4
         EFbsPjsgdUTPj5C+QznIyLSE24m0yo9KbBjISfKLShe4wH3xFsLvXbDBMUEt/3rptxDE
         uTENho3kaOwVYIGCbViMFs6WNJy2GlsJg34ahQ45GP+Nr9CXsnEpjdq8itm0MxHaM7Lk
         xsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+MA9BP6n+/V2hcAJd7HUjKIrm3/UhujH3kXj6qukoy8mdLuTMgXN7kOnX1AjeATjkxAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywebI1ZZ/274fCbTELV47E7Yo2sNAryhD79N7l9gvEVBoJX3au
	kiD5K56NPJSxvgMYSKwPxvOPAU3BmIx641yOhW/qzEQm67oNjOO5Xe/Z+eF+HN1zkaIKkbngT1e
	1FS86wtqcDv0WeRfbxFO+03JBMkQ=
X-Google-Smtp-Source: AGHT+IH++8OwuOxgzMljQOzlbyPnRLwjHpW1J0xXzj8zpS2wQxuy0X/JAWQ5qtfAW4NQ6poMLsGMA33gBA2RhK6VTrk=
X-Received: by 2002:a17:907:745:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a991cf73130mr1082172866b.16.1728296818921; Mon, 07 Oct 2024
 03:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
 <Zv0-Wv03hSea_Tje@pks.im> <CAPSxiM_fTMCzXg3OrcbJrn=UskyCaR3D=xgR4d6PrnnAdoYcCQ@mail.gmail.com>
 <CAP8UFD2QN59LVAJgqwj5V6dJ9sTCHjdDG=XtuWcFkgANmfvnrQ@mail.gmail.com> <CAPSxiM8jTxFXZB5ek6nNFy8arKan7GfoiRmaj4jQ81Xfhcf7eQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8jTxFXZB5ek6nNFy8arKan7GfoiRmaj4jQ81Xfhcf7eQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 7 Oct 2024 12:26:46 +0200
Message-ID: <CAP8UFD39hCC8hOxH55_ghgdjqBEK3StPKkiLnR7=whJV6jcO2g@mail.gmail.com>
Subject: Re: [Outreachy] Potential intern.
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 6, 2024 at 6:34=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Hi,
>
> Thanks for your reply.
>
> I make changes but, I need someone to allow me to be able to send my
> patch using gitgitgadget.
>
> I had two links as the first was failing some test which I solved.
>
> Below is the github link.
>
> https://github.com/git/git/pull/1805 - updated patch.
> https://github.com/git/git/pull/1803
>
> Also, I will be glad for any review of my approach on using gitgitgadget.

I don't know much about GitGitGadget, so I am not the best person to
help with it. It looks like you managed to send patches though, so not
sure if you still need help. If that's the case, let us know what we
might be able to help you with.

Also if the subject of some discussion changes, then it might be a
good idea to update the "Subject:" field of your email. For example
here it could have been a good idea to use "GigGitGadget" in the
updated "Subject:" field, so that the GitGitGadget experts among us
can easily see that they might help in this discussion. A good updated
subject might have been "[Outreachy] GitGitGadget permission needed
(was: Potential intern.)"

Thanks,
Christian.
