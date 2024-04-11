Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7B481A0
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876274; cv=none; b=TigOQOA80QMP+P2b9wLajaSV7Dwxwe5rE1N2PynWsZIUIXleTqLI4OJfRA7LFKpDrExFHndgvSkofc5e0J9kGENGDuJd/gHuqHvwKG7muuYiMXILRwJYhmqaREwX426vYrYxHOKkmb2kNFrJrday5etyHQmEInLwnn+eQeGwL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876274; c=relaxed/simple;
	bh=qT5Ecmgx04wp2yTKX6KSeGM0sggHq+oV3X3Zf5rsHUs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o3lVxDywx9lMWxLjWD3gx6nmaPaRlMt/7JUvzAAkr9cckX85KiKy0RSzraX5pXuj+vDEz/EvcfrWrANBf1CuF/4JTI3sxJ4A3FvoqOHX6X64XnoLUdRaUT3hVL4aocIPCZJzc4Myj68mdm4iE7vtVwr3+m8ZPKFJTAeGCqKbKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT+Um5Rf; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT+Um5Rf"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so224065eaf.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876272; x=1713481072; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f11Yas4ciTIQxxda2MJRiyH2gigteEsWV6Y+4bZHgU=;
        b=QT+Um5Rfg/NKppmiqOwqhAlFw8GLZwE1AqTdB9J/BZcbBlihLPvrz3jHrfUJn3HbIa
         RuVA0N4cWBVMXZNeZGQe14TLBE8hu5Bpq1SOqlidsGy1XVgA7Y63MxBvCckqpVC9GTCW
         oi0mLanyPZr8+R4jT5j2z/DehEnUUpAI12aU6eao+wufpOrprWTGDeyer33TadJxND04
         DDJXPc3YkXnGHqYuM9KRr9AxcGnzl22jcoH/2EvJ9f4l4qh9YEqdtHsnE22lyH0t3ogI
         ti1ugA29Fno49AMKauyw2aR0kVAi6yMrz3d5PNIE/6OhyBBwaE2PwXltbDqcU06K8F3p
         nW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876272; x=1713481072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f11Yas4ciTIQxxda2MJRiyH2gigteEsWV6Y+4bZHgU=;
        b=kBo+dV3Jia9+UhW/mA1bPnh9NRo+obPS5a9xDKfbkzjpDLiNBllTRYJ3Hh2oC7xXck
         q2B3SU7QgBbphCN45Hbo+J6X/ZUrAbDKgLKqp66hH8fwiJkBSSiBiTUamOJk7vbmIkGK
         lRuVM/AFQm3aobpn2oGaust608mM+C7Q0pLLuTzj8oDDc3dOErknQ4g9t41/5JWubSq4
         T/Fh8KQGn/v9ZFsKSuywhuMwrM+h5Vh+uqchPggkcuwVOL1wVAr/lWon7QxurbUE5MVR
         5ll4hOwroBNWABPqtBz6VzmaURv/8CN0O27UaakY3JBW1Hnhbr/t/67u7LHLfGf9uh00
         3Ieg==
X-Gm-Message-State: AOJu0YyvNZ+ccS5LvrrwUzJGwgR75YauxWBCcCDDM3XtOdr285kVRiDg
	eYZ1pc6Q7rzW8Qcx9o+7zVUHCTB8OMyCg27ZC47KiBXP1UrZyB7FegqLbxX9
X-Google-Smtp-Source: AGHT+IHS7Iyx0FYbEvUmHp5PdgbD7Pm+7hDV1Aeo7wBeiJ9eRwR1OxOrbk9h4rOostCFH8eVcB4yyQ==
X-Received: by 2002:a05:6358:250c:b0:186:27f9:d725 with SMTP id m12-20020a056358250c00b0018627f9d725mr762347rwb.8.1712876272108;
        Thu, 11 Apr 2024 15:57:52 -0700 (PDT)
Received: from smtpclient.apple ([166.198.37.50])
        by smtp.gmail.com with ESMTPSA id i20-20020a632214000000b005cd835182c5sm1565761pgi.79.2024.04.11.15.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 15:57:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Date: Thu, 11 Apr 2024 15:57:38 -0700
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 John Cai <johncai86@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Scott Chacon <schacon@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D6CAB74-9AEE-4E14-9E08-65289887D7DC@gmail.com>
References: <ZhcBJSP4MxX0AMFM@nand.local>
 <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
 <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 11 Apr 2024, at 08:37, Scott Chacon <schacon@gmail.com> wrote:
>=20
> Heya,
>=20
> I was about to come in and say roughly the same thing. GitButler /
> myself personally
> would be happy to help organize an in-person, recorded talks Git Merge
> style shindig
> in the fall. I'm also happy to help with some of the core team /
> speakers with travel
> costs if needed.
>=20
> I helped organize the first Git Merge in 2013 in Berlin [1] and would
> love to do the
> same thing again this year (my my, have 10 years gone by since then?)

+1, I am based in the UK and I=E2=80=99d love to meet again face-to-face =
in Germany.

I=E2=80=99d hope also to have more CGit to JGit reftable =
interoperability results based on GerritHub.io <http://gerrithub.io/> =
data.

Luca.

> If everyone would prefer Chicago again, then I'm happy to just attend
> and help out
> however I can. If we think it might be nice to bring it back to Europe
> this year, I would
> love to take care of it.
>=20
> What does everyone think?
>=20
> Scott
>=20
> [1]: https://marc.info/?l=3Dgit&m=3D135896927120693&w=3D2
>=20
> On Thu, Apr 11, 2024 at 5:18=E2=80=AFPM John Cai <johncai86@gmail.com> =
wrote:
>>=20
>> Hi everyone,
>>=20
>> I'm grateful for the chance to gather virtually like this, and for =
Taylor's
>> willingness to host these each time!
>>=20
>> I also wanted to throw out the possibility of an __in person__ Git =
contributor's
>> summit in the Fall!
>>=20
>> GitLab might be able to host this, which would be an awesome chance =
to get together
>> in person like we did in Chicago a couple of years ago. That was a =
valuable time
>> to talk about cool topics, but an invaluable chance to get to connect =
with each
>> other personally.
>>=20
>> It will likely be a two day conference in October of 2024. Location =
is TBD, and
>> depends on the level of interest and location of those interested. =
Requirements
>> for attendance will be the same as for the Virtual Contributor's =
Summit.
>>=20
>> We wanted to first gather interest before determining more details. =
Please fill
>> out this form to express your interest: =
https://forms.gle/hTcsYM4fomEqaKU59
>>=20
>> Feel free to also email me off list with any questions
>>=20
>> Thanks!
>> John
>>=20
>> On 10 Apr 2024, at 17:14, Taylor Blau wrote:
>>=20
>>> Hi everybody,
>>>=20
>>> I've been thinking that it would be a good time to gather informally =
via
>>> another Virtual Contributor's Summit.
>>>=20
>>> I had been waiting to see whether GitHub was going to host a Git =
Merge
>>> event in person this year, but it looks like the answer to that is
>>> "probably not" (though I am hopeful for next year[^1]).
>>>=20
>>> In lieu of meeting in person, I think it might make sense to meet
>>> sometime in either this upcoming May or June (though we could extend
>>> further depending on folks' availability) in the same style/format =
as
>>> our last Summit [2], the details were as follows:
>>>=20
>>>  - We'll host the Contributor's Summit on either Zoom or any other
>>>    conferencing platform that works for folks. (I spoke with Emily
>>>    Shaffer off-list and they mentioned that some Google folks were
>>>    interested in Discord for a few reasons, so we could do that, =
too).
>>>=20
>>>  - The schedule/duration is not fixed, and there are options to vote =
on
>>>    preferred days, length, and timezones in the form(s) below. Last
>>>    year we did two four-hour days, so we could do that again (or
>>>    anything else that works better).
>>>=20
>>>  - Like last time, in order to participate, you must be either (a) =
an
>>>    active Git contributor, (b) planning on contributing soon, or (c)
>>>    working on a Git-related project that has interest in Git's
>>>    internals. If you aren't sure whether or not you are welcome, =
please
>>>    ask!
>>>=20
>>> Participants should fill out the following forms:
>>>=20
>>>  - https://forms.gle/VVrJ7RbHVxurxZH99 (participants)
>>>  - https://forms.gle/iGnfexF4hDuK6MQe9 (topics)
>>>  - https://www.when2meet.com/?24557185-cHKWv (When2meet)
>>>=20
>>> New this year is the When2meet, since this seems like a more =
efficient
>>> way to collect which dates are open for folks within the next couple =
of
>>> months.
>>>=20
>>> The participants and topics lists are being recorded in the
>>> spreadsheet below, and this is also the place to record your vote(s)
>>> on topic selection.
>>>=20
>>>  https://bit.ly/git-contributors-summit-2024
>>>=20
>>> Please feel free to send any feedback or suggestions you have for =
this
>>> year's Contributor's Summit to me on- or off-list. Like last year, =
my
>>> hope is to have a small, remote-friendly, diverse, and efficient
>>> discussion.
>>>=20
>>> As we get closer to the date, we'll finalize the schedule, make sure
>>> we have volunteers to take notes, etc.
>>>=20
>>> I'm looking forward to seeing everybody (virtually) soon :-).
>>>=20
>>> Thanks,
>>> Taylor
>>>=20
>>> [^1]: Coinciding with the project's 20th anniversary!
>>> [2]: https://lore.kernel.org/git/ZMATKIaU1A1D0wJg@nand.local/
>>=20
>=20

