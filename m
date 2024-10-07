Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62B1D26EA
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301486; cv=none; b=OwonJoCZmXREOfkwfZY7LqbK5RIiAwj4YS39NrXN+UrC4RuJts4jPQWP9U+uvqpy8yMYIdSUTIsOn0kM0bp/oNj6UzZL+szMQqZKeCx2Fbug0EP3UbCOBplNz/hwAwb49+3IsozCSMovpyeVnRBO+drowBUmdYKqly+Zby1GCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301486; c=relaxed/simple;
	bh=7Ri51HyyIsJRMs+aR1PFjApihEKngsTHAeQNRdMaFtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX8GWkofiPvct9CgceJiNjqtN7mcz5EJLRg7X2/+wA5ZTYSvNx0h0/4iyX/zhS3wkPjypettOvfmDmIW3SuK9/5wGvTUROxNbuMW+r8ZjfyRNu8ZfiQK/Ht43V1VsGX3nigWd8NePB4JlG/ulAFCiDfhFX0zV9pHAeSmkW//MeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJi6iJw0; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJi6iJw0"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50792ed3ad9so1214045e0c.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728301482; x=1728906282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+7Bq4NRhZYWDXRyyYLUxCeXnITUaD0QqTK0ph6EpQo=;
        b=KJi6iJw0qf0vxmTGLMBASXyJbjrZzsyyzIhRqatCVo4LK9r4k+TCKKtAIdgFDtJrd1
         v/QEwrThGhGCGHqAlfSb1ClZ1D3TSLuuT1suXvzpknFC5oRpQALG7UUjsM2Q4NEATlS3
         3cs+vnzXkIarWBtmlS9LNXtJxefQmuKSigu18mXd1XpGqocPWJPBJfqskgXUCrxJMci9
         b3f0XKK1nkEcGvQPpHKJ4vMFsexrxoiHihzkW7DCVDiHIdRC9LubyCqHQkyqh3RSBIN4
         FNo6go6SLVYsXavycxdsPI1WI5yITpWXNqtxoXRpOulOwf3FJiE1If3uSSNFby+Xi0gv
         WIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301482; x=1728906282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+7Bq4NRhZYWDXRyyYLUxCeXnITUaD0QqTK0ph6EpQo=;
        b=OgF9KG1wrwRuu9ULC5vINoxrfRBw6+vlyEw31ymWN6G4KOMsR6zKzSkOoaDoG6O2hn
         qUfnn6n2Exi+J8s9ThdAQWjdVBfMIA5QPZR5/HliKRDOl3E32/4TdUjxc9hir6iN8+jm
         G6uPfPUv25DFxUzyHdAe3249MuV4/JYnuTdRF1llAIwA0WZ+Xqt6iRFgtp7ksUycDlUr
         L0Is4DZ0kEHQzL8GjqTNecxFu6b1/o8hD2D0+iHDtjonLvLx6b1/Iu0bhp95MQoe/gS8
         mxkDueHKgp1bFyRPiJfhATsI35NoyylY1ysl6wL/qCAvXi+GBlgG8MWENj2MW3+1mlan
         6yjw==
X-Forwarded-Encrypted: i=1; AJvYcCW1LTQXRXs1kvbaV/9rnfb6+CAkkY4utLmHxcGyE5sBCLyTmkcjKAGlQI2k5VXobap/Foo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXQuVqJ4Vde9/V7Cw8g5KEAOzz27Vi3qgPw9bj4S+I6mpC+uY
	EnFrQ/swydTt14/5lz+K5O0ohw2m57dhPKIkvpAd2O+krpR7xlNheYiEXVjorQxNK9MmPp5dtqT
	SfDAqKqaFGpInPZyImkBNRB6GNSIa/jSlDYk=
X-Google-Smtp-Source: AGHT+IHN/k4WWl2uyGE+Q1Ac8LDVsgeEN+GJk+3OLaO8HnaNe6Uo3tWt34SN49RZXIg3CD6T2rckAsa5fiMm9WWcGxc=
X-Received: by 2002:a05:6122:c9d:b0:50c:4b84:dafb with SMTP id
 71dfb90a1353d-50c855597f3mr6439840e0c.10.1728301482631; Mon, 07 Oct 2024
 04:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com> <ZwPCDAjeQVf4VFc_@pks.im>
 <CAPSxiM8FpPyCgvRqrH1gEhZEskGRAeBO_2+_1FamTHaezr9+Cw@mail.gmail.com> <ZwPG3QHarKerpN3K@pks.im>
In-Reply-To: <ZwPG3QHarKerpN3K@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 11:44:31 +0000
Message-ID: <CAPSxiM8cpX9NYB02fAPA7WbLsLrvmFfsE2=VN=Ncguif7mQN9Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 07, 2024 at 11:16:49AM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 7, 2024 at 11:12=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Mon, Oct 07, 2024 at 11:11:04AM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > Changes since v5:
> > > >
> > > >  * Remove spaces between redirect to conform with git style.
> > >
> > > Thanks, this version looks good to me now.
> > >
> > > Patrick
> >
> > Thank you very much and I appreciate all the guidance from all
> > reviewers. I Learned a great lot of new things.
> > Going forward, what should be my next step? Can I work on other tasks
> > now or wait for this to be merged? Are there any other things also
> > expected from my side as an outreachy applicant ? Thank you  very
> > much.
>
> For now I'd recommend to wait a couple of days until the patch series
> you have sent gets picked up by Junio and merged to `next`. You should
> watch out for the "What's cooking?" reports that he sends out every
> couple days and observe how your topic progresses in it. Note that
> things may go a bit slower right now due to the pending Git v2.47
> release, so it may take a while before he picks your topic.
>
> When things go smoothly: congrats, you have checked the first box and
> have successfully completed your microproject :) I'd recommend to keep
> on reading the mailing list to get familiar with how things work over
> here and get some familiarity with the code in question.
>
> You are of course free to send additional patches, but this is not a
> requirement. If you still want to do so I'd recommend to not pick up a
> microproject, but try to find a work item on your own, e.g. by searching
> for "#leftoverbits" in our mailing list. The reason for why I don't
> recommend to pick up another microproject is so that other applicants
> have items to work on, and it decreases the likelihood that your changes
> collide with the work of another intern.
>
> Patrick

Thanks a lot, I really appreciate it.
