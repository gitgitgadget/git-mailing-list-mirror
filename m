Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5163C
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729309752; cv=none; b=GEhSj0WG6VexuxItBXZOxxGpEivXbiPtzWH091G+x6LD3ixbOycVSo5DtK7VkWa98euVX8Rp6jHNe2lgifNJRjRJM0cM0/CAQepE1S5hjJha2cXThyDg24FftKyR1sjEnvH/6oeM9zCCW4/W0zSCCgRUR0U4IXvWdp2YrM1TR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729309752; c=relaxed/simple;
	bh=uSUkTiD5EiMu+WZBIyyqaNROu5a2SgOpyL7NVvN8YLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCHnH9dRRUtvkzgFpD54cyp4beVgwklwdrd/Yn9kCn3SGlthf2Hw1fMXlUjWIQiqupwugEjy9tcgLq0WNPwWwtZW+ju5RpUjm4DYPHTVeiI9ZLkXpd6xqNe45sngHLOHcKngySh/6+D8qMvNfXViCKbjDPkCJAAA7wV2adwvEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6xgAOfO; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6xgAOfO"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a4789662c1so696679137.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729309749; x=1729914549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSUkTiD5EiMu+WZBIyyqaNROu5a2SgOpyL7NVvN8YLo=;
        b=m6xgAOfO4sOW9Hq6IlY3UH46MLKNMlkt6vjoFW/OMYa9O7E0NVWEwqmSljxB25lBPa
         zoVsfdPegv4ioT4ubN7AWyb/nxzkz79CaYlfrs3YoPqbZjW/T1K/YpuqvjY1AeroTzUf
         P+vp7dKi/+h3MzpScQI+CffphYwvVYZdtPqM1WW3maeKlb5aGQF9oazMLYPFqz38mtVO
         MTzWocKU1Mr9FG4vWwhk/XS0nmhjosY+pRyrr28qTlsv+RH6MPKiCKmW6embMEIxWRnw
         I0dZKh5Fs+ObCDuzA1EyXQzYmZvaZlO+Com46v8BU7WRLTJc2Y0wdSJmo/GI7zfR5raQ
         XfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729309749; x=1729914549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSUkTiD5EiMu+WZBIyyqaNROu5a2SgOpyL7NVvN8YLo=;
        b=a4dZR6Y/dwfaPz4mDUZNbMXbVmKUJ1Qr/VW58S1TD/TIqlUAk9FDpxS2L3bQMKaSs7
         xLeL0xuXucqBv5SGqgewZvSRS5hOFIzAmep7CyNmfkT+DYG1WvyrLeHAbfoaPgiK0vnV
         TdT563w7j9z2i2U7Dje5D/7dFyIeF2GNkILJDbnEI+w0+jjwWx2JxhFZPghmG/PzaPYZ
         adYHjOJdAw43X7HNKmiZ2Fq9Nc0maweaRquorS6TA0C0pwYZqWSQHZ+7cu8Ik+m8TOQg
         OA4caz0nmtFVuVVaeFYCc5qERTDz20x5Own2x8bugKejLlKMXOw82Lcs/k0rR2sB67zk
         26+w==
X-Gm-Message-State: AOJu0YzmiCkk2vWI2BT3JYKhG5PemqFbo0GmPsMZFSrUkr+MwVoDC1MP
	ZMGLSUyjn2VcIH3vitDlB3W7rFGEPaqIrZhyG1jAGyOWatd4RiGO60A3BnbcqlTe6A8SLDcUC1F
	RgA6/1y/J/fDwsYfxz0YxlakD9Hg=
X-Google-Smtp-Source: AGHT+IEvoqmXZ7vYNuXFAOhEUGfqifLAsIGwposrw/hUiO23z9N6akSma2vz371blzJ4m0KsLlY+fHpRpDpvS1CBZgY=
X-Received: by 2002:a05:6102:e13:b0:4a3:ccaf:203 with SMTP id
 ada2fe7eead31-4a5d6a616b4mr5448923137.5.1729309749029; Fri, 18 Oct 2024
 20:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <705912536.3510460.1729265181938.ref@mail.yahoo.com>
 <705912536.3510460.1729265181938@mail.yahoo.com> <CAPSxiM_4nBcB53+pfvC4YUsVz5wtJYgFEVuWQdCdo=2VWLj=Tw@mail.gmail.com>
 <1075918304.3566148.1729271777281@mail.yahoo.com> <CAPSxiM8sXud=J9pQro28=F9UCbf-PR_gmEp=uyp6d6prCHHxzw@mail.gmail.com>
 <1692736727.3717090.1729300501716@mail.yahoo.com>
In-Reply-To: <1692736727.3717090.1729300501716@mail.yahoo.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 19 Oct 2024 03:48:58 +0000
Message-ID: <CAPSxiM9=k8NQ1ExkRS49=1A6GwMn+A3wu-dkv+0R=2vOVDGvzw@mail.gmail.com>
Subject: Re: Oureachy: Microproject (Modernizing a Test Script in Clar Framework)
To: "shamimkhanum@yahoo.com" <shamimkhanum@yahoo.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 1:15=E2=80=AFAM shamimkhanum@yahoo.com
<shamimkhanum@yahoo.com> wrote:
>
> Can you please share me little bit method how I can search previous micro=
 project? I search it show me multiple folder. And you also tell me I choos=
e this topic " Modernizing a Test Script in Clar Framework" can someone els=
e work on it or not? Please verified this and guide me. And mentor show me =
ideas link for micro project we choose those idea or new idea?
> Pleasure for me if you guide me.
Hi Shamim,

This is a link to some microproject as shared by Patrick -
https://git.github.io/SoC-2024-Microprojects/.
If you want to search what other people have been working on, you have
to go to the mailing list (https://public-inbox.org/git/)and filter it
by outreachy. The results which contain the PATCH tag are the
microproject that has been worked on by the other contributor. As I
understand, no one is yet working on the topic, since it is what is
supposed to be worked on during the internship.
>
>
> Many thanks.
>
> Yahoo Mail: Search, Organize, Conquer
>
> On Sat, Oct 19, 2024 at 2:15 AM, Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> On Fri, Oct 18, 2024 at 5:16=E2=80=AFPM shamimkhanum@yahoo.com
> <shamimkhanum@yahoo.com> wrote:
> >
> > I am reading all helping material and also contact with mentors.
> >
> > Thanks for replying to me. Can you please tell me if you are working wi=
th the Git microproject? Which idea are you choosing? Also, have you submit=
ted the final application or not?"
> Yeah, I worked on a Git Microproject. The final application deadline
> is by Oct 29. For the project, I will advise you to search through the
> mailing list using outreachy as the filter. You will see all of the
> microproject that have been worked on by other outreachy applicants.
> You can look between 0ct 1st till now to get the idea of what other
> microproject the applicants are working on. Thank you.
>
> >
> >
> >
> >
> >
> > On Fri, Oct 18, 2024, 9:16 PM shamimkhanum@yahoo.com <shamimkhanum@yaho=
o.com> wrote:
> > > Dear Git Community,
> > >
> > > I hope this message finds you well. My name is Shamim Khanum, and I a=
m a C programmer with a keen interest in open-source development and versio=
n control systems.
> > > I am writing to express my interest in working on a microproject rela=
ted to Git, specifically focusing on improving the Modernizing a Test Scrip=
t in Clar Framework. My proposed approach involves a thorough review of the=
 existing test scripts to understand their structure and add a small enhanc=
ement. My background is as an MPhil computer science student at the Univers=
ity of Punjab. I am currently in the Outreachy contribution phase for choos=
ing this project. I am passionate about contributing to open-source project=
s, and I believe that my skills and enthusiasm would make me a valuable add=
ition to the Git community.
> > > Thank you for considering my proposal. I look forward to your feedbac=
k and hope to engage with the community to make a positive impact.
> > >
> > > Best regards,
> > > Shamim Khanum
> > > shamimkhanum@yahoo.com
> > Hi Shamim,
> >
> > Nice having you here, I am Usman an Outreachy contributor like you.
> >
> > Bellow is the extract of the statement from one of the mentors Patrick =
which can get you started.
> >
> >
> > I would strongly recommend reading through [1] and [2]. They should giv=
e
> > you some ideas for how the Outreachy application process is designed to
> > work in the Git project and lays out the expectation of us mentors.
> >
> > Patrick
> >
> > [1]: https://git.github.io/Mentoring-Program-Guide/
> > [2]: https://git.github.io/General-Microproject-Information/
> >
> > While going through all this, you should get additional guidance from t=
he mentors also.
> >
> > Thank you.
> > Usman Akinyemi.
> > >
> > >
> > >
> >
