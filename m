Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2F155A52
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738993926; cv=none; b=gL1bpB9mtK81y+6C46ZdWw17elSIxe7bM2TCuygPo6LQo4HMBCAHT5UieQd0XDn2cvP5NEMBQm5jwWEPGBrJgqe1eHhO/ocS/FcGkxTsxp4XPvpDg63X/+e+V0bUZmsdIFmq3523/gzt3lLkVA3v76Dx1PvaGckynsXY+4m0XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738993926; c=relaxed/simple;
	bh=nCz6yklb/1/1cqJracPJ/uBBMTMDAKhLCZPJJC5cfbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDbp6JWkaMKFzjT+0iC8GVhjfw/7af+cr86xgplM+4YRy3DHtUzWGuLcrWOVWrixWVEMK9JMOpH27KM+BAAqF4PE1TBFFrM9Ej06TQleOyZKnFqfChNkLt0QzV0JARPODxLqSSR3ibvJzzYuAzqWcRrrA/usUC2KYT3td5UpSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1BKJgZi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1BKJgZi"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso4483545a91.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 21:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738993924; x=1739598724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCz6yklb/1/1cqJracPJ/uBBMTMDAKhLCZPJJC5cfbo=;
        b=H1BKJgZii7ib3yxueZDUVxu0Ns240S/a5SNZ8Zhs0ljfKn2X/1+HEOUOHveQ9XnUI4
         BwKGI9VInbxvC+NvakzTiGONk7MaBXTOslfA4Lq/HpB4dGmUAb6/fww2HQSH3E/uyxu8
         WqiTSyb3DUDWFOSVhUcRjX3SyNdCmidykQF8blGTefe4lIYyjFKZQXpBZRFL6WF0LX4l
         joHUXIsteCdjOWE2avwF3b9ri1eYAAEUr0HE0XcgCNjUxm5GGqj0iqyqQfm777Y6KzXo
         rnKXzWIlOwkIoVFtP9quCHUhoDMl0dZbwPdiUX26tteu7NzuXNI+ZEFR2g6bYikjI9M5
         oCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738993924; x=1739598724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCz6yklb/1/1cqJracPJ/uBBMTMDAKhLCZPJJC5cfbo=;
        b=BB1CdUMgjFcOvLN9HUt3BdngcLua2JwY/xhtkjtrXLRMCQQVja7k1D4QniYBsoIHot
         T8l1dg86qCQAGdbxz7e8Vd42jzmfiLIfF6lPSTy7ySwAgODekXCPTPlIvTTUmTXARGai
         FjY0lj+n8CZDxMQCQ0pVRpBsqZs+d9fjVmwJY+Tgun3Z4zpRULKHvm5Jtbp8+AFAqIhS
         1J0OWhXnMuqucq8PUXRkpn1NMmccKa9dH5Li9F/8ZtzWTYJxk4Rzm/ZpXwlCDaslOYqT
         /t3B4fuQqaaCqKwzC80SFm17Kkku6kVIa877l2syHIvR8GZoAlcFjNzZ9CQb+S+PQsTD
         n/7g==
X-Gm-Message-State: AOJu0YyOrnJvl8X1IKfiMkM0o6N/MihrDRok4sHLFlcO7+R6Ag0obx1R
	ucnrUwRkoqtFqVqvo/X3iWIMr+RfTN+RUHVqAKWT3G0wrb2cj7WOvU0PkMWSgsHUh4PpgSztbrV
	4E3RFP5nh3WGvgbLs1Tj/+aQJHpzxEDhl
X-Gm-Gg: ASbGncsJoT0+spXazJC0qP0M5jHZ7lMm9P/ULONluVLS7Bxz5XBe03Q7C6fV8WVqiJD
	biCnVWmH3PtsYgAFy6SgM0Ck4IwB3a3nX7jDEGN392oeJOqJ4Ph7DH/++lZyPYIanuPnqndj98E
	jVvT+VhZ8NwX5A2gYTsVq+gbB4Mv4s
X-Google-Smtp-Source: AGHT+IFcLr6Ee8aF083UznhmWGE7d2SP71RxkXmIgzVzxdoPlP2xGir/FRBjDMMaWk/5Ktqj532/rzVOAu+fHl1QnlA=
X-Received: by 2002:a17:90b:350e:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2f9ffb7ba83mr17246185a91.15.1738993924107; Fri, 07 Feb 2025
 21:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADY4h_qagYhSP2kz=zNSjfskN1ODxLf1DjEME6BdYw6j-JEAhA@mail.gmail.com>
 <Z6bhS7THkV2ovXfQ@danh.dev>
In-Reply-To: <Z6bhS7THkV2ovXfQ@danh.dev>
From: Emily Klassen <forivall@gmail.com>
Date: Fri, 7 Feb 2025 21:51:53 -0800
X-Gm-Features: AWEUYZnRNfk7WJ6ad1cOWFwZc-RlYd937Rzm91VFbm76BtiAFhOUU7kFwafJW2s
Message-ID: <CADY4h_rOxG3eMR46SCL2Db4L6+++Tt5Ky6w5R8PPgofC+0iFxg@mail.gmail.com>
Subject: Re: git log --graph --no-graph can cause segfault
To: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yup, I built on `next` and it's still resulting in the segfault.
However, I did end up figuring out the issue, and I'm sending a proper
patch momentarily. Basically "revs->diffopt.output_prefix_data" needs
to be nulled in the "--no-graph" argument parser in revision.c

~ Emily Marigold Klassen




On Fri, Feb 7, 2025 at 8:45=E2=80=AFPM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4n=
g Danh <congdanhqx@gmail.com> wrote:
>
> On 2025-02-07 19:34:11-0800, Emily Klassen <forivall@gmail.com> wrote:
> > > What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >
> > $ git config --get alias.l
> > log --pretty=3Doneline --abbrev-commit --decorate --graph
> >
> > $ git --no-pager l --reverse --no-graph --name-status
> > e83c516331 Initial revision of "git", the information manager from hell
> > error: git died of signal 11
> >
> > > What did you expect to happen? (Expected behavior)
> >
> > I expect the commit listing to display successfully.
> >
> > > What happened instead? (Actual behavior)
> >
> > Git seems to have crashed. My best guess is that some state gets set wi=
th the
> > first `--graph` flag which is not cleared with the `--no-graph` flag.
> >
> > > What's different between what you expected and what actually happened=
?
> >
> > Git crashed.
>
> Given commands yields: "fatal: Out of memory, realloc failed" in my
> system. But it's fixed by jk/combine-diff-cleanup, which is merged
> into master.
>
> Would you try to run from master branch to see if your problem has
> been fixed?
>
> --
> Danh
