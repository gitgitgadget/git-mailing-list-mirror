Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA161E481
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604375; cv=none; b=Isb3ACQrDw1kXfolkTfuZDv/+8j47roeW9iSgPo43E4sDPj4yRJVku5WpaeTGsRLI8h92h4wTKPGYAQA3V8RSmrVbnCe2nFm2qm+8La3BJLSj0KkpHiW8G3xoSLekntIENIKsE97zVNUy8+jGStW8yZopTsWba/Ob6nfrecL+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604375; c=relaxed/simple;
	bh=fT01DsLcea3Rr7ZGJz5hE04i8P584FPkRXCFXxYovyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmeJNXArtqiFAiTfCNWMiolkxFW0ZDsl/cl08v05vnTLb/y8sX7R1SMtIWDB5s07pKW7Yh3S/WF2gdaZ5lzspcNiOVy5QCnadNtI5QdwzSykeRvCxe/OybFdBwyen4H/HPuBDsev7u/DyzcWuoxxN15bGgEFZfZwnaQjPwanpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX2mEMVd; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX2mEMVd"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so1869206241.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729604373; x=1730209173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZf3+s2e1ua8V9m7adLEy2xypXSJn7Vk9YiNYdpWDKI=;
        b=lX2mEMVd8Y6YsU2mccquHkc2QjZ1IUSljQKjuEJQ+oNBdk8fELQW+1o87C6CTArVyV
         7XngFcbsau9k+kiSGTkPUWf+yIWN36VgkWers6CY9cIWiMeh2ctoD2Yn0t1Wqpe6d5PC
         GRChhocKsQx888vr1k2nkJqCiBU22ujJgvIsHIgAvqS2+Z56Cwi32XpPi5ZEltGyvcRs
         ht4Y5Rd5Lk0pLtnIqfgmeTqQOniNH5ncYQU98IqDn5gNZYb+RptwfAlKH7CubBxiUqta
         fUxw+6/6HC0cXLFhciKRCj5IaBEJjidJuzvxzzcKWJJdQgrSNdo96xON0MY8jibNHFEw
         BKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604373; x=1730209173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZf3+s2e1ua8V9m7adLEy2xypXSJn7Vk9YiNYdpWDKI=;
        b=oXo/mjmPQz+dVOycudHO8N+nFgzMki2nWNZbFbVi7Y3Bur1hi9aPeJM3vl6G7tsgbW
         iUqX3eMXo/198G0wbHLjHFd0Fr1B7ZjRCRTFrE/BaNNa4CTi/Ssvc9vsykYW+vTB32dx
         a48RlIXlmZjQKShyymPIsQBE4mUppD8oQM4hlqZUkyHll/TGaV5sBQ6HMThxDrzk+Zrk
         DXtsvEIbn9dwa/zCADB/I4FU+Nu3MlqB+ebNzJal9RjWOpRwfMVMsN89vEkRDDcJUdZ3
         FXk5+9gvNvL3d1yHHMcA35TOpafoexHPmWvezdzcQmAAjKxjIN5QltfG6RXWE9iBNZPg
         ty3w==
X-Gm-Message-State: AOJu0Yy3aUvBibfRw6p2J2duoYCIBQQs1gY3yGUrFrcU07Jxk/yuTvRa
	RHiB7DCPH5YttGVwbGGtoScH2yR0RmvhVLawXRZamwkDpvipwlLgp68o9gJ+grfVj6mcc4kdjiV
	mo/JUugbbcrR6CqGH95Es1zUcghw=
X-Google-Smtp-Source: AGHT+IHf7S75/c+ucf9qroBvlXff282sA9tLlqCaIYVBMTqITXX9lhnhwUDVaQvrdRLzzHphj3g2B6ZuVIxVQuia/rg=
X-Received: by 2002:a05:6122:1790:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-50fb5e136d7mr2592104e0c.2.1729604372969; Tue, 22 Oct 2024
 06:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im> <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
 <ZxelBccIFk1aXP3l@pks.im>
In-Reply-To: <ZxelBccIFk1aXP3l@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 13:39:21 +0000
Message-ID: <CAPSxiM8bu9LErD8H13_qgb+MV224TbEFzkSr4f74YxEL3Sg7+Q@mail.gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:13=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 22, 2024 at 12:54:18PM +0000, Usman Akinyemi wrote:
> > On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > > On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> > Hi Patrick, thanks for your reply. As you may know, Outreachy has a
> > kind of form for submitting applications (they have some set of
> > questions someone has to provide answers to)not like GSOC where the
> > applicants do not fill any form for their proposal application. I am
> > guessing someone should add something  like self-presentation in
> > answer to one of the questions as there is not really any question
> > asking about someone personally. I think what is near to it is about
> > previous experience.
>
> I wasn't aware :) But agreed, previous experience sounds close enough to
> me.
>
> > Also, anything about applying to two projects ?
>
> That is a good question. The only thing I could find on this was the
> following statement:
>
>     > You are welcome to apply to Outreachy multiple times. However, you
>     > can only be accepted as an Outreachy intern once.
>
> I'm not a 100% sure whether this means that you can apply to multiple
> projects or whether it means that you can apply to Outreachy multiple
> years until your proposal gets accepted.
Applying to multiple projects is accepted by Outreachy I think, as
someone can submit an application separately for each of the projects
in a community. I am just curious if Git has anything regarding it.

Thanks
Usman
>
> I've asked internally whteher this is okay and will get back to you once
> I've got an answer.
>
> > I will start working on my final application to get enough feedback.
>
> Thanks!
>
> Patrick
