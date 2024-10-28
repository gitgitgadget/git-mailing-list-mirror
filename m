Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF74C83
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096435; cv=none; b=CGOMJgSRzUgxn4POe5aIeFKljHdY31zOFVA5fpUFHd04FlkScekG3CLZQrHt3awz5lUJN3kwlRTQQ7zV5oTKtin7ZvT1BlpkMeYE6z4FgJwNqUHbdWGJc7pXbyTTrMIgL43+kQe1Pe52sVx1uPHOJNAKfWaJuCh0eGcuRW/7c7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096435; c=relaxed/simple;
	bh=wyM5cMvUGJEEvBJcRpIq3sgCQTj0gzfRaFnyJf9obQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMe9w+Oq9jZLI/3WSaKtZ2lCyt7ZxWor05iQ4KEJeSivIlYyiQNdokWZXRmGnvwvKVgkOP0EEJXJ2ev8qlg/vepgPDpzC/vK7aYPkFdtHl0S/eQZaU1FKatn+spTilX4Y8Nb+9LRoAVOYJGuLDDDShoL+kGr9LgUpBfXb7YVm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff4BgnKg; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff4BgnKg"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-851f5d3001fso1028045241.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730096432; x=1730701232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy0fYkuOcas/t4WRDdZ4kuJaAkM/vLnEWLPuodT0eak=;
        b=ff4BgnKgCHf03q5cmkXdPiX4dIhyDXC71tzcIcAGMk90hxfWlKBY4syn2gb468TkCY
         OSwBHElmnpG43qFhwBqR4e7HD3cTpM3Bjc88gmVIcDLpmv3LARxeATooSunrQwZkjorg
         QKwdCe2pJ3pWa1zMUVuu8w9GGDowYQlWfNB+TBlLGzZqLJbuks+PWLbqhZC5cRAildiK
         dvyTNZ4XgUqOrd71/WzTGa0bF2Q9TohGz6xzpLe98fSY1IknFW3hjDySXQ6eih6WPJAv
         HkbNIvjJtpZnf8dH5OhoX6iRZijhZ8Wtj6mOMC9kfJ19eMB+uXz932Yx0QOQC3YBYTdS
         flNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730096432; x=1730701232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy0fYkuOcas/t4WRDdZ4kuJaAkM/vLnEWLPuodT0eak=;
        b=TlQzcgWdEb0ybIt0tcMiMNkK1QSLVEP3MrFprJ8X93jE9PCGaQ2asLkWB6mUMFplVR
         zY6v2asQiMUnJ+XVmS1rIenLqAR1peWwoBCxJw1VJ1I58cBt+VpJxZQhBFFFt4oDGBck
         RVzrSr0AfwX8XyT8juD67iOeHbZoc0nFxI/T2FX87Zrp5Jt0YvAfJOe+cp2rOBcPo05t
         0PXeG4T1redf7EnTTtoRayeRRBFP9C9tOhSLibTZuiSQY0L09csDX9Zx+IFyGKZ/CssV
         IyKCC8q6D1ACcLzOB/n+9V02KTuGV5gpCqtBPO0ITOfZ9FtUueZ6d0jyuQy1Ic86LkHw
         OfJw==
X-Gm-Message-State: AOJu0Yw0rTLb5bDdH6fvaDZh6vfA0VRSGm/tHl8M6MB0dJYAWv0SAQNJ
	zG+HXpSgutBfSnteZEUnwxAk66m+cp5YRj/09aP2iSv6A5EGT9E5cyOBcgwHUNtSZqfUlZbIF70
	f4NT3ZyETrq4rtwNaxQ9jaYwTkBw=
X-Google-Smtp-Source: AGHT+IExNpb/shnFG1sPHLS7zUmbUeB8w01ucCeUdY4GGe7RFnE81C1iFVTPfRLnXhrMv1Behgs5UnZjCiQhE1VyvIM=
X-Received: by 2002:a05:6102:2ac2:b0:4a4:8fc3:9b7 with SMTP id
 ada2fe7eead31-4a8cfb616efmr4189085137.14.1730096432206; Sun, 27 Oct 2024
 23:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com> <Zx8q7jnDIS3_omBm@pks.im>
In-Reply-To: <Zx8q7jnDIS3_omBm@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 28 Oct 2024 06:20:21 +0000
Message-ID: <CAPSxiM92YO8askO7h=1jOy5PfOdrAfaKiSFv7aRL0iCT4BcTzg@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability to
 Git protocol v2
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Christian Couder <christian.couder@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 28, 2024 at 01:56:36AM +0000, Usman Akinyemi wrote:
> > Hello,
> >
> > As I planned to submit a proposal for two projects, below is my
> > proposal for "Conversion of Git Unit Tests to Clar Testing Framework".
> > I would just go straight into the project proposals as the other
> > necessary information is in the previous email. I would prefer to work
> > on the "Finish adding a 'os-version' capability to Git protocol v2"
> > project in case.
>
> Thanks for your applications! I'll only reply to this email as I'm not
> mentoring the other project.
>
> [snip]
> > ---- December 23 - February 10: Incremental Conversions & Feedback
> > Integration -----
> >
> > - File Renaming: Rename test files from t-<name>.c to <name>.c
> > following the structure outlined by prior contributions.
> > - Clar Suite Integration: Add the module name to CLAR_TEST_SUITE in
> > the Makefile to include the file in the Clar testing suite.
> > - Conversion of Test Assertions: Replace the test assertions with
> > Clar=E2=80=99s built-in functions (cl_assert, cl_assert_equal_s,
> > cl_assert_equal_i, etc.), enhancing readability and functionality.
> > -  Patch Submission: Submit each converted test as an incremental
> > patch to Git's mailing list following the Git contribution guidelines.
> > This phased approach enables targeted feedback from the community.
>
> One thing missing here is the work with upstream in case we want to
> implement any functionality that doesn't yet exist in clar. You mention
> it in "Additional Goals and Extensions" though, so that might be good
> enough.
>
> Other than that this looks good to me, thanks! Please don't forget to
> upload your applications to Outreachy if you haven't done so already.
>
Hi, Patrick
Thanks for your review.
Will it be better to include *work with upstream* as part of the whole
timeline instead of adding it as an Additional Goals and Extensions?

Thanks.
> Patrick
