Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD7186E39
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286123; cv=none; b=AMV2L7E1mG+1gdg/seVPOSAFCkV02MfZ47YkflFSBISaCMNwzVdBMFTgDxYYzKUA1yX1olkMGpUV5lSG3BTuTtHvsZBWLEpCKLyb4VB1aX8DhTLzeLBTiH3OZv10X/ad8CS4x3XfdosOleTCsoQuocIFy82fjb5tDOkwRTD2FQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286123; c=relaxed/simple;
	bh=cp8yM3uJ7jT8Wi/WRjXT+JkEQJak6te9hlHkqa5LIuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tV5SYfY7tL/ipx6OkHS/kUqm3S9Bvtv1wUFE0oc3beA2NRdna5TawqCyu5NObO+yCO9HD3uyWIzjEXXcwV7Ra1x2930/zMqs3HwWROXXMAZZbIawWJU/d/hXCELgYUhFBJ2HVfilesB98ym/VbBXidyBrVijxdrbaUXnB4xfklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BymE7YOf; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BymE7YOf"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d32d82bd8so593347e0c.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729286120; x=1729890920; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp8yM3uJ7jT8Wi/WRjXT+JkEQJak6te9hlHkqa5LIuM=;
        b=BymE7YOfh8fD93tZZ4s1XhqZJvgf83zF1tXA8w9fyucmK/o14riW4Ehsbn3sNMGaIn
         KRHQJxsfQwF5CVQBPCobEuiA2uCze5O8lbBu1v1HXVn/nfkM2dBee6v6oUkzMNXp/GyH
         yCgR8mCDhmnA8b15byT/JRVdsehGsaz5gV0FwTq8VxwmPfyFrOp0qmrSxH6frZoUeyub
         c/ZerrwSaekgpQD6rdZZgbDqN/s4kn+kflLksL1tqessnvVotnO62YoRnAGp+bkw8RzX
         O6D3d3q6/qNj3OO5UzycaySFVc900pn3M+OvO69QlfANmUwLtie26P3osHc8sJYtjKo9
         c4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286120; x=1729890920;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp8yM3uJ7jT8Wi/WRjXT+JkEQJak6te9hlHkqa5LIuM=;
        b=ix/cEimgKLGuOGz6inLwaVXeaHBfPp8MEa5glP5KrShfhMp8Uvs+alR/7OtZoq5yuA
         2Jvg7fe2MJp7kQ0LT+xAfXvnAyO9JXDrw9vao0q98L1BLMvHcJz4+3bt2sOswxokgaUd
         qbfU1X8AlFatU2IPsXihkvJulrD9m6MMEWWcxTZu9rcc6cPhWsj5TZtIKmieFbTITI0S
         2BjAGqEKuqKD3VF9yvyFxySWFqKA3nXRE5q3MhpJeOY5KeIU0MqH34LBljNejf76hJTM
         Y0eLwAnbiONMXaKDeBg1EYrxEiTvytZ+OKwf4Bc3xQz7mXslJJRDkgPMHrYVZ5cBe5bo
         9jdg==
X-Forwarded-Encrypted: i=1; AJvYcCVTKTGJj5JnVyW1F0UQl/X3reENxqHJIn9bPM/QwaNipLhsUkYfOOIy2fJ5sDOtJN/Z3QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhic72gD9OqTpfLjid1QhmiaWnCXdsy/1gderO5gKWLKL6w1aQ
	odMjTyum6pEY3f0Ta64w++kWXMopZPvbWI23CRwS6kkb8rYl2kcp+g+fL1hyiGz7mvY/PtgDMjr
	lAIteZOJBLfG/+oCOPxkxBBRa5Z0=
X-Google-Smtp-Source: AGHT+IFXRx1D1lbYl7gH+UKvDH+F8kWYPXwrAyqUO8QQbNoObOAkmx/2RQ8hHCSC78a3QpOtvKXcK6QtdzsepxLi4Cw=
X-Received: by 2002:a05:6122:90c:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-50dda12e43fmr4346717e0c.2.1729286120190; Fri, 18 Oct 2024
 14:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <705912536.3510460.1729265181938.ref@mail.yahoo.com>
 <705912536.3510460.1729265181938@mail.yahoo.com> <CAPSxiM_4nBcB53+pfvC4YUsVz5wtJYgFEVuWQdCdo=2VWLj=Tw@mail.gmail.com>
 <1075918304.3566148.1729271777281@mail.yahoo.com>
In-Reply-To: <1075918304.3566148.1729271777281@mail.yahoo.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 18 Oct 2024 21:15:08 +0000
Message-ID: <CAPSxiM8sXud=J9pQro28=F9UCbf-PR_gmEp=uyp6d6prCHHxzw@mail.gmail.com>
Subject: Re: Oureachy: Microproject (Modernizing a Test Script in Clar Framework)
To: "shamimkhanum@yahoo.com" <shamimkhanum@yahoo.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 5:16=E2=80=AFPM shamimkhanum@yahoo.com
<shamimkhanum@yahoo.com> wrote:
>
> I am reading all helping material and also contact with mentors.
>
> Thanks for replying to me. Can you please tell me if you are working with=
 the Git microproject? Which idea are you choosing? Also, have you submitte=
d the final application or not?"
Yeah, I worked on a Git Microproject. The final application deadline
is by Oct 29. For the project, I will advise you to search through the
mailing list using outreachy as the filter. You will see all of the
microproject that have been worked on by other outreachy applicants.
You can look between 0ct 1st till now to get the idea of what other
microproject the applicants are working on. Thank you.
>
>
>
>
>
> On Fri, Oct 18, 2024, 9:16 PM shamimkhanum@yahoo.com <shamimkhanum@yahoo.=
com> wrote:
> > Dear Git Community,
> >
> > I hope this message finds you well. My name is Shamim Khanum, and I am =
a C programmer with a keen interest in open-source development and version =
control systems.
> > I am writing to express my interest in working on a microproject relate=
d to Git, specifically focusing on improving the Modernizing a Test Script =
in Clar Framework. My proposed approach involves a thorough review of the e=
xisting test scripts to understand their structure and add a small enhancem=
ent. My background is as an MPhil computer science student at the Universit=
y of Punjab. I am currently in the Outreachy contribution phase for choosin=
g this project. I am passionate about contributing to open-source projects,=
 and I believe that my skills and enthusiasm would make me a valuable addit=
ion to the Git community.
> > Thank you for considering my proposal. I look forward to your feedback =
and hope to engage with the community to make a positive impact.
> >
> > Best regards,
> > Shamim Khanum
> > shamimkhanum@yahoo.com
> Hi Shamim,
>
> Nice having you here, I am Usman an Outreachy contributor like you.
>
> Bellow is the extract of the statement from one of the mentors Patrick wh=
ich can get you started.
>
>
> I would strongly recommend reading through [1] and [2]. They should give
> you some ideas for how the Outreachy application process is designed to
> work in the Git project and lays out the expectation of us mentors.
>
> Patrick
>
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/
>
> While going through all this, you should get additional guidance from the=
 mentors also.
>
> Thank you.
> Usman Akinyemi.
> >
> >
> >
>
