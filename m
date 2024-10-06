Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628712572
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218787; cv=none; b=csTz9QOPLELaqF97BGAQxU4zfmz186PMTEpBiCaes65Me0X/zXML7/iGAfV0Pa2MnUKCo6K2uoIQ3m0tXE9vsMhZbhGJ5dITmcARyxvePlCC0G+fSyhOJRgI0RyIzAwTvuR6TIqDds4h9+X7iHfidfQKRFfUTDUQ10W8zhS+E6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218787; c=relaxed/simple;
	bh=Qn6D6NrNe5IDcU+H99ug1u6f5f9Lgxf61EWOGjTuwtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5NX90crB/6sqX2z9kFZVEZFwnZ8npYaOp1Z/DXoIQQBhthVJZKN2w7mwFO4cCM8JDpaOltk/xzNOjXrwCxj4f7tFro5Ls2AyHKUUc3PwC9j0INIkZEBAwswEaJi4HZBXzsbEkZw79j1Lb7K1vnGi9lQuG+bCBEsvc653flw8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqOM4UkH; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqOM4UkH"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a2ecdad7bcso1093980137.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728218785; x=1728823585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn6D6NrNe5IDcU+H99ug1u6f5f9Lgxf61EWOGjTuwtw=;
        b=gqOM4UkHkEaVGAnJIi0ZHfvpNVk/9J+6057k2f6exNFrb6qZGloUBhWBRpXHwdfFTN
         HRaGXM4CxH4JPOM9leU+2/n/ByZAVtbf3LY1Q/5IC1DP1yoefVT+WoFRb/1LsrGhHGUW
         iu+0nL86uUxbxcfIml+5+iKoypoUXys+BmGF2MMvkK9W5oiog9q9GbrE0dhxU0m9i45t
         M3XMYjhrAE7W+9amr7mQ2qdqSazxUFTS6ZXWc03+eCiC5lM/DBw1AODSC3IfTyOT3wdz
         /ybn+j2vfXZZxJLIdJdM6+tTRwM2EAy4xv80pfu6IiOJoORo5h+n7FylK2QFAR8czgJ3
         asMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728218785; x=1728823585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn6D6NrNe5IDcU+H99ug1u6f5f9Lgxf61EWOGjTuwtw=;
        b=az4WsUaBlNe5FnRSsEV5TR/aQ1tK+8ieT37WQXcAMD+1PHtfPG6uPVwqqf8YzpgteZ
         u2RyXf6ldfmAyo3HvNzWt/+ZFtvW65Zh+AODXY7N7ayCeMrEwKqoSoKNcWLaE4jpysGK
         9w6jCRbjroPcO9qkSew1F4mzK1cUgN2PPKB/YEwko2ZfX0/N3RBUUv7nliNMKYWngkdL
         +baCrpLM3oFwxMMTM7g5fptAMzTKpahoFQc0D0wR5PMzr5y3V0un07f6JXGaPppICVvh
         uTlQQsQYNgGigqlgJKvVvCR0lUt1Bl0lv0YMIhsBKnU+jQgyI1HRTLeUQ8DzkgUr1a48
         ELqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE5GoCnuFNUqND/4Qp8fkri04c4rEglO53/8UauHNw5kVyy3Ft2+TpHE66K6YQNekmxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpkJL7JUmSXRvmRzGdBDO1+VjuoEzijncvE4oV4HV8E7mCFdG
	TPnUSB3yRxWRAuheepma8O85pCe7XcrNYyS9YNJk5p57iQDvfZcm9LaniVf3+On03fNFyL12IgG
	l4Ylts2LyZNhaqefmNRA7O1ABKcW0fF3s6FQ=
X-Google-Smtp-Source: AGHT+IHotpo7siezn9gEXHo6dkJnkq85fbNSEcpqSJA0iwjFz7oDGvFwGIgftl+FCL47jLJkygog541L6oJz53m82tI=
X-Received: by 2002:a05:6102:3a06:b0:4a3:cb08:326f with SMTP id
 ada2fe7eead31-4a40578490amr4664837137.14.1728218785122; Sun, 06 Oct 2024
 05:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux> <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
 <ZwKCxHzbWxNQ92KR@ArchLinux>
In-Reply-To: <ZwKCxHzbWxNQ92KR@ArchLinux>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 12:46:13 +0000
Message-ID: <CAPSxiM85QuiJK+0HYDPT-4-hoBpeZ42uzG+ZoMdPEZYC1C_yZw@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: shejialuo <shejialuo@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Shejialuo and Eric, I really appreciate both of your time and
help. I am not frustrated at all and I see any changes as a perfect
opportunity to learn something new. I have also learned from my
mistake and your guidance and would keep it in mind for future
submissions.

In that case, I will send the second patch.
Thank you.

On Sun, Oct 6, 2024 at 12:29=E2=80=AFPM shejialuo <shejialuo@gmail.com> wro=
te:
>
> On Sun, Oct 06, 2024 at 08:06:10AM -0400, Eric Sunshine wrote:
>
> > Your observation about outdated/confusing "[foo]" annotations is
> > certainly something the submitter should take into consideration for
> > future submissions, but does not seem worthy of a reroll, IMHO. First,
> > `git am` will strip those off automatically, so they won't become part
> > of the permanent project history anyhow when/if Junio picks up the
> > patch. Second, asking for a reroll for something which does not impact
> > the correctness of either the patch or the commit message just makes
> > busy-work for the submitter and wastes reviewer time (which is a
> > limited resource on this project). Third, the point of a microproject
> > is to expose the submitter to the workflow of the Git project and to
> > the review process, and for reviewers to see how the submitter
> > responds. That goal has already been achieved in this case, and
> > rerolling for something so minor provides no additional benefit in
> > that regard.
>
> Thanks for your detailed explanation here. I don't know that "git am"
> could strip those off automatically. I thought the maintainer would
> delete "[foo]" manually. So, my main intention here is that I want the
> submitter to make it more perfect to reduce the overhead of the
> maintainer and also pay attention to this for further submissions.
>
> And from my perspective, the reroll would not bring much overhead for
> the submitter, so I expressed my words in the previous email. I know you
> concerned that my words would frustrate the Usman. And I wanna say this
> is not my intention here. I think Usamn has already done a great job for
> this microproject to understand the workflow of the Git project. So,
> actually we are on the same boat here.
>
> Let me withdraw my previous words ("We should reroll the patch"). This
> patch is good and don't need a reroll.
>
> Thanks,
> Jialuo
