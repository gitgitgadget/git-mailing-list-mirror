Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644F1A3BDA
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543432; cv=none; b=E2LYiqwaT5Q59y1f8IjVefivd9GMkEw743O0ywM1PipBzCYCn8bXVLgYXEK+6hzBRNsY7k+BDeD+g0y7UoUADPZn/+sjvB5YTWSQdkIK7Co9368UnLa8RYQ23PyhSGDFrkp9hz6ubBOGrt6xytEZRNqr1CQp57jWycu9tNShOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543432; c=relaxed/simple;
	bh=YKfX6CXodpo5lsCcfpyj/VI/ebYlOSj9C5k/xjDfrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gj9KsXXvNcp73DyXg0wBVWh7M2+WM+88UDP+Vhdpal0JM/qujVXk/PdPB+cnDVK5ISY+JdxMnvsUwCB+TnIhkn0hWV4GrIU0Baxjddl0agqvz5x9JTawQbNRuCtKhePQz09BTHN8Y0VbcnFOObHwY8TcK9boPTWC1/5PfEfQvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoUJpIio; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoUJpIio"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so693962a12.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728543429; x=1729148229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKfX6CXodpo5lsCcfpyj/VI/ebYlOSj9C5k/xjDfrPg=;
        b=LoUJpIiovOQJTJuyge4qPVZ7G9OFeJIS8JAoRG4LxDHaQXUacY547RTSM+WwTQD916
         SYaZHheI57ZMyUz/QkzdcSeGtgXw00cyq4ESHLxY9ks1zJXxQ1VTTqv3LNFkrn4op1qg
         wbWQasaYxXLakUmlVl+1ubvn/g9owukcbutGQXaSm7K0nKycLrSCBFF9IPeb/wFWXvAS
         NAXRYV5kjOg9bfODX2K2p94+lmUCy5RaRVGR5lUJVJIXsjixq7n7UWf9jpBgn2bOioQJ
         nGVkBy6lDvT2IX6g3S1PT+GUk9Gqfmd6lsCmb6iPom/siyt0xtqnN30ut/nXW5khtwll
         MgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543429; x=1729148229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKfX6CXodpo5lsCcfpyj/VI/ebYlOSj9C5k/xjDfrPg=;
        b=QUybOrcRJLV/NoXlvUnHQKq/TXSIwHGHFTm2+dojIvsXEZm0WY8nTC2ktsT6Oxf755
         6fQuQFvFV3oAmd3nF4yKisbGjSMCdwd5zOs9pjmunTsPfFFe/jyyUKWSJtruMWydMXJF
         Yew3lf/csrWWaAMk/tYq85fG3JNLSgnlsaiLM4KmgZZG4bcB3GWVVZxqJc25GZ2UzXGr
         iuv0hd4ghVD57HkF8L88wtJ4R9Reo5DUVDw++mR4mJzliODJuto86a7+pXmz4SqbW3u1
         JfvPEJYQ37P0lffGVy9OLJ2fo2DTgQQ1OLpWKezGGAzvHOEPJsnBhAa60c+WINODBE4k
         G/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVG+jM5G825rsMOba6j/UEG8VWehfVVKiB2O/Jq3KIbgHQ3QWFUlrvHy6o+06SaqXRpBLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtlKtvSlvwuvpWxh3DTMlGxnN2IkO4KAlA9cpzbLX5HIG4vg3
	QyWQ80HGS238ufnw5LXAXZm3JWBYgL9elaQcZjq704H+RcO8IVwBgD8wBCsDdbMlizOhesEJCOO
	m/p9kLGEgbb+gvhTK3zKT7DzMovE=
X-Google-Smtp-Source: AGHT+IEKnoW5RvDp5pxO0M8tCTp3Lo7QeCOnPLA4SipqujfDz7pRH5vP3myrsIhFxoIxdiCuImP3q42vtohh1AvfDOI=
X-Received: by 2002:a05:6402:1d51:b0:5c8:957a:b1e2 with SMTP id
 4fb4d7f45d1cf-5c91d3f9cf3mr3977899a12.0.1728543429307; Wed, 09 Oct 2024
 23:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEqABkKmkqJCqpG5nOgGnK_BKhN_rTgmioptTvCLYGWd4WV0ig@mail.gmail.com>
 <CAPSxiM_OssSLAGd1JC3UJ9Saorf4yxx9FtvnhpL4=hBrcoh8hw@mail.gmail.com> <ZwdpHNOPKpi12n3e@pks.im>
In-Reply-To: <ZwdpHNOPKpi12n3e@pks.im>
From: Neema Joju <neemajoju96@gmail.com>
Date: Thu, 10 Oct 2024 12:26:32 +0530
Message-ID: <CAEqABkKvbpo-8-gDpFtfNcpmiC8A5mJMkcDXfhcdNrpwMvBsDA@mail.gmail.com>
Subject: Re: [OutReachy] Introduction and Contribution Phase
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:12=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Oct 10, 2024 at 10:21:54AM +0530, Usman Akinyemi wrote:
> > On Thu, Oct 10, 2024, 10:17 AM Neema Joju <neemajoju96@gmail.com> wrote=
:
> >
> > > Hi,
> > > My name is Neema. Pronouns (she/her/hers).
> > > I am an Outreachy applicant. Completed my initial application and am
> > > currently in the contribution phase. Looking forward to working with
> > > you.
> > >
> > > I have read through
> > > https://git.github.io/General-Microproject-Information/,
> > > https://git.github.io/General-Application-Information/ and
> > > https://git.github.io/SoC-2024-Microprojects/.
> > >
> > > I am in the process of selecting a microproject. However, there are
> > > some things I would like to clarify. As a part of outreachy
> > > contribution phase, making one contribution is mandatory. In the
> > > Project Contribution Information
> > > [
> > > https://www.outreachy.org/outreachy-dec-2024-internship-cohort/commun=
ities/git/
> > > ]
> > > section, an applicant has to complete a tutorial, microproject and
> > > then make a contribution.
> > > While I see detailed instructions regarding the microproject, there
> > > aren't any regarding contributions. Is the microproject considered th=
e
> > > contribution? or are they separate entities?
> > >
> >
> > Hi Neema, when you do the Microproject, you are also contributing to Gi=
t.
> > The Microproject is all about making a contribution. You can also wait =
to
> > hear more from the mentor.
>
> No need to say much more than you did though, as what you've been saying
> is exactly right :) The microproject is how applicants demonstrate their
> ability to adapt to the workflow in the Git project. So this is how we
> mentors ultimately decide which applicant is likely to be the best fit
> for the Git project.
>
> You are of course free to do additional changes after you have completed
> the microproject to get more familiar with how things work. After all,
> this is an open source project, so people are free to contribute at any
> point in time. But this is not a requirement.
>
> Patrick

Thanks Patrick. Thanks Usman.
