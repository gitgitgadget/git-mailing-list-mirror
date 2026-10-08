Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0A3AEB5F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437403; cv=none; b=PH0XQrb1rtxmtVJtI5JRHs/dx1X57jb5rpzclziTB+g41Wd1PTCFFLhhwyJCwJlJ7hG24RNOWCaQYdPU8x23VricZ0nXRfsMxz+lt9t8heHcq9ElH54ZkaUtUY5gjdt+yy+PT8Q6mIchVfSWJWGJYFaMbMmqX4Q4H4ek5GItOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437403; c=relaxed/simple;
	bh=ltrpQIzXwLYNCdP3gjaQRDkEveFX4aXAR2xRYQlA6UA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dS9IkK6/Shc8TtJNIbjpNbUGjdRxTKhoYJvtg+GbfXWvPngVTT+lRCAgRlGbkSOq1A5+Wj4ndbl8YCilYyhw/xLuUw0x8DYcCZOUos8G2/wGl2GpKjHr5pjs0/rujqCxAAx7nEVIDTABA1ft3eHSEz4RpVhU4/jeol/Exx2y904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HANk1tOC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HANk1tOC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a16c399641so25345175e9.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791437400; x=1792042200; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yY96u+qWgA1Q8SaDCpla46zxUANUQTmCAw2hxdybKRM=;
        b=HANk1tOCtwmRmPHezzIPVV0LW8TqA9CuftznL+/DI43sHvMuFUtC5kFYI4muVN/zGM
         f4kC+iD7DYL2g7mxAY2lZZICBDm7UF2Ie6X/rGc98gbEzi+TmIV9GyISzNXtYzCrA/vZ
         7EEKN1KamD+fjpNZDj4ta+eNrDnZAHXJVTVvlhQo3h6c3/z6S6f8+nbci6/MY2FqhUDr
         yhkxS3YHS0AuaT4pXP8JHWRqveF+ndZkj7HSQnsOZ2Ln0k8+A0WvDDqBANvyg04Wg9Wp
         6jKvPkDfcmD26P+QV7jj6j4fIiWk1JU6GH9gxriLzx4hF0BM3NyBUaX6vqlPy6fSKOjF
         wkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437400; x=1792042200;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yY96u+qWgA1Q8SaDCpla46zxUANUQTmCAw2hxdybKRM=;
        b=nOBGo2XBZhstYgaEvtEEgWvwOVW78Ulgd1FJqtyPOS3bcy8slgq87SXizlTzruKe6X
         YapIaHyHXGB/PklGpiKEODT5UopyRCCCynR05jDdHQe5m0cte0eNixIuH3qrt1io+ftC
         piyikRNRl/fndEYZpxnGPVpMpqu4pUu/faNPTNdtclZxu0VaRIVkD8/vnsokaaVwaDdO
         a+C/VBxtekRbEuYmBcpiTURicZY7HUTmHD5PRZT7ytYjpHR0sDiokqcLVBrjTvelSxVz
         4l1DXq7P9ohOGcg03FkthIA3B5UAK+f40BmecAlgvuG58hDAVGfMvbTnGSC8YmBkzvfJ
         E4Kw==
X-Gm-Message-State: AFuF++mWm7JaqTdTT1vDCcBO0Rrb0vVRWBf3wNNFE0BGR/Q+mn9Ko4RB
	1ekT6x9QnC4eZy2FdLG2GzLH6Zd8IODdQvC342zTW15XVVTI2pezqVcT8Brf60RK
X-Gm-Gg: AYBFou0wrVXgmIzEkAED85x13hfXL/wVRxXYB/0cOrsEZ7QgCWk5pmYr13rREvEOnpb
	exk1X3Mz6IHib4KdKR3X14IwB8dqhfdB30bqKgbGw0YJkX0fDJa/INSibm/6bfEAxa7dahsLXkN
	e0NJWvK+d0g7mins99hX4bR+Ro+gRKsOQQOHe56dvbpQftQMa69XzRtY9matYon+sGBX2p+7Uxg
	omOWvavp/evQ0l5w3kES6jbWDqWa5sRPr9fXcYEk9ZjLglu6hNWEquhdJn+9UAvvJjyqVf2OUyt
	qKiwr83oGf6Qxv46n1wDZJBaFGo99+0Lgi4wbijJgc1RwxOE7eK4i1uh+izYE+TOg7XgigOu2Wr
	sFg7oLi9SxlPz8Np5CUcqxDxp0BneL5HsSzPgCEZ1bm8p0Vre8R6jL4hoOffruyMKZ5BOZmN29+
	lT0yY1SgX7M1z2zOmYK1Esq/SQNd+M1W4V8DR9c+VmhS4ZLFKLYKLwyVOELya7/paVjAwRcQpq+
	7LeShsVGgeR7PM9rGDG0yfASyvCR/KS2JCu6oCMje56jMgwZdM9+73int8aB0QC4sSF
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a18043be70mr74932785e9.14.1791437399854;
        Wed, 07 Oct 2026 22:29:59 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:a00c:eb10:a843:dbd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7273b5e0sm8975582f8f.14.2026.10.07.22.29.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 22:29:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI
 assistance
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
Date: Thu, 8 Oct 2026 06:29:48 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CCE2DB2-E2E2-48A0-B443-95B0AABFE83B@gmail.com>
References: <20261007142954.31761-1-scott@gitbutler.net>
 <20261007142954.31761-2-scott@gitbutler.net>
 <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
 <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.500.181)



> On 8 Oct 2026, at 05:49, Scott Chacon <schacon@gmail.com> wrote:
>=20
> On Wed, Oct 7, 2026 at 11:42=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>=20
>> On 2026-10-07 at 14:29:54, Scott Chacon wrote:
>> I don't think I'm in favour of this policy.  All the major models =
have
>> been trained on a large variety of code from a large variety of =
sources,
>> including sources such as news reports or personal websites that do =
not
>> allow copying, modification, or distribution.  Given that LLMs are =
known
>> to reproduce portions of their training set or craft code or text =
which
>> is very similar to items in the training set, how can anyone honestly
>> assert the DCO without knowing all of the sources that were used to
>> create it?
>=20
> I agree that generated output can reproduce material we don't have
> permission to distribute (though I think this is incredibly rare for
> anything complex). What I question is whether that possibility means
> knowing every source in the training set is necessary to make any DCO
> certification.
>=20
> Human contributors have also read code under many different licenses
> (and news articles and blogs) . We don't ask them to account for
> everything they've ever read before signing off on a patch.

There is a difference between =E2=80=9Clearning from existing code=E2=80=9D=
 which builds up
experience and professional capability and =E2=80=9Ccopy & pasting=E2=80=9D=
 code from different
sources and putting it together.

The first (learning from existing code) is a product of whoever writes =
the
code, based on its mental model and experience developed, the second is =
a simple
violation of the contribution guidelines.

Where AI stays? LLMs are a simple processing of a large amount of code
for statistically detecting which part of the copy need to be =
copy&pasted
and blended together. Even though they had a =E2=80=9Clearning=E2=80=9D =
path in terms of
developing an understanding and building a mental model (they don=E2=80=99=
t, at
least at the moment), *THEY* would be the author of the code, not the
person that just =E2=80=9Cpressed the button=E2=80=9D on the AI model.

Should we use fully-generated AI contributions? When =
=E2=80=9Cfully-generated=E2=80=9D
means code that has been totally written and reviewed by agents =
autonomously,
then I believe the answer should be a sound no, even just for the
lack of a legal framework around it on who is taking the responsibility
of what has been contributed.

> We do
> expect them to have the right to submit the actual contribution and to
> respect the licenses of material they incorporate. Again, Red Hat, the
> Linux Foundation and the SFC all now state that LLM generated code is
> acceptable and compatible with DCO requirements.

Do you have a link to their exact statement?
Do they really allow *fully AI generated* code contributions where the
human has no understanding of the lines of code generated?

If that was the case, how can you manage a review of code that wasn=E2=80=99=
t
fully guided and understood by the author? Are you foreseeing an agent
answering the mailing list to the comments of the reviewers?

Even though we would allow *fully* AI-generated code, who is really
the contribution from? The =E2=80=9Cassumed human author=E2=80=9D? The =
LLM?
The data that LLM is trained on? The company that developed the LLM?
Nobody?

Also, imagine that the code generated *did contain* malicious
backdoors, who is liable for it?

There are currently lawsuit in progress against companies that have
trained LLMs on allegedly copyrighted material, we don=E2=80=99t know =
yet
where they=E2=80=99ll end up to.

>=20
>> I'm a distributor of Git and I don't want to be sued or arrested =
because
>> I end up distributing code that I don't have the right to distribute.
>> Large companies may have lawyers and lots of money to fight those
>> claims, but I do not (nor does the Git project) and I don't want to
>> spend my resources fighting allegations of copyright infringement or
>> have my reputation besmirched for that reason.  Just because other
>> projects think it's okay to do legally and ethically questionable =
things
>> doesn't mean we should as well.
>=20
> Again, a lot of my argumentation here was directly taken from the
> SFC's recommendations [1], which Git is a member project of.
>=20
> =
https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendati=
ons.html

I am fully aligned and in agreement with SFC=E2=80=99s recommendations, =
which is
very much aligned with my thinking.
If you are the author of the code, even if was created with the =
assistance of=20
of LLMs, then you are fully responsible for each and every line of it =
and you
must understand it and approve it yourself.

I personally use LLMs *a lot* for giving me ideas and reviewing my code
or learning about something new that I never explored before. The end =
goal
of LLMs for me is to improve my capabilities as a developer, not to =
generate
contributions on my behalf.

My success criteria after having used LLMs is: I am a better developer =
now?
Am I more capable of writing better software and having a deeper =
understanding of=20
existing code?

P.S. My comment was 100% human-generated, including spelling mistakes
and awkward expressions (I=E2=80=99m not mother tongue).

Luca.

>=20
>> I'll add that if Git were to include a portion of my MIT- or
>> BSD-licensed code without including a copyright or permission notice
>> because it was laundered through an LLM, I would absolutely file a
>> copyright complaint, and rightfully so.
>>=20
>> I refer you to policies from other major open source projects that =
cover
>> this exact provenance issue:
>>=20
>> * Gentoo: https://wiki.gentoo.org/wiki/Project:Council/AI_policy
>> * NetBSD: https://www.netbsd.org/developers/commit-guidelines.html
>=20
> I'm not saying that other projects haven't taken positions as
> conservative as Git's current policy. I'm saying that much larger
> projects with much larger legal surface area such as Linux have
> adopted more progressive ones. Linus is fine with it on a project with
> the same DCO, the same license, and honestly, a lot more legal
> scrutiny.
>=20
>> I also will point out the notes from the Contributor Summit where we
>> discussed this issue in some depth and proposed an approach for =
further
>> discussion.
>=20
> It was unclear from the notes what a "vote" meant exactly. It looked
> like Taylor was roughly tasked with providing a Linux-style position,
> so I thought I would help out by providing a first version of that
> position.
>=20
> This was written to follow the current SFC guidelines. I would
> encourage Junio to have them read it, but I tried my best to follow
> it's guidelines and advice.
>=20
> Scott
>=20

