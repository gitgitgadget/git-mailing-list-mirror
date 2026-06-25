Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC213672B4
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350239; cv=none; b=Q6RmhabetGTOTg3ABoyTAwaZ2a/SZJrPKSk8+eQzCVnnrzOPBp2A45/3QrowQtS80To5iz7T1pj+0H5ehnYDIYvSUXbNRTvj8to9S9W6rhMOGXkaEyn2k/9xWEKshuWVcLhLXEa1hX7gT9UURqUwWyGJsf33M40FKXmWD+bKAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350239; c=relaxed/simple;
	bh=rPH2I0W3/t9GoQhTyUixzata/vFB7soQ8W93m8TNOzo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DhVxxZqvXPYajTC/4Z8ezeN0ScD1FTeqFNZZyTJQgrH9yhWFHrmO6BmhM43G/5bkyq/qo5SL+qMJxUndhITs/91BHBHt2XdjZTpD7ncVSkr+CmChW+61iIErIG1LELEyP+7tG4zELLtHurBBg9mFIaDFrY5nzGzKAh7D5bE7nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deB29T2G; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deB29T2G"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-662b76dabfcso1918391d50.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782350237; x=1782955037; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D09Q3Je0FkkgrljvFxlwX1Kod7lOCQrSgAcN38tme+Y=;
        b=deB29T2GOgR1fYpcnTzKS0A++5TtPcm6PEiO/mBKZcaaJOvEcpk+q2CjWCAZIcXFzB
         5yPmLqhh+fbi77ueFsEviUDs0YPjgVxWGb1C3sWnFNQGBcvsMG/SxWO1UexZkkl4DSgq
         FHC46qbs3mX/oID1yc9ZGMf28rnFn+Ur11fC374t2DwMbXkzNWW/+pH9MiBDYulXL5tU
         hBdb/xjGBrGiWnQRBgTe2GZpjTLylNJHhQ/aeEGDNMBFA7EF0ooT3t9mjjQglpZ9yfk8
         bIOSIWHra2gajRx72WSzwqOEP0N4l8qeRdz0DZp1w7ldy5Xrsdu/JKHQIBddrD18Gz5U
         4kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782350237; x=1782955037;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D09Q3Je0FkkgrljvFxlwX1Kod7lOCQrSgAcN38tme+Y=;
        b=Ywh2DrDyMtZb4O3O1QmR/+IoNIsfgKUInrkwAnMJ8UmJAGvXP4vGrPXFCbHqv1+S2l
         lqTodhCYZtGGvv4gk+lQN85/MQFsuHy77CnSI6uaaJH44JvrOVX/FCJO6N7n4DMg3dEA
         8lp55A8B+SvBdpaVvAOLZ34y5x1c3n3szLHCSLyrWf156UNpKt91BkvD5tzEHE+0dL5Y
         rumzYmP2y/r3cN2pCNJpDGH0KMmO3NPI4JFmSTdrVGIBRm1hQVTj3KDUmf7lLi8yk2/q
         jKhH7EKRrk93dzm8ulZHzx68aUN0S2Gf/fi16dXm6y/AOQekTcUR4+BFKKrZ/AqHZaI0
         J9zA==
X-Forwarded-Encrypted: i=1; AHgh+RpSR8UT/tVGt9u3eSGKhX02YLWtWjs4yx5b6eJCtbi15GifB8GScdCF+o+YiZxkMkT4T80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdn67QYviAis6CSl2S0gsAojveI+667FcSaDhYg+5ZnlFOp89J
	dd7HpiKWQUGHjfigxu99jwzZB2loMz3Qqemu7cFRHpElRBZy55ihHsUs
X-Gm-Gg: AfdE7ckAyW9jp5eFQwiy6H/cRg5+cc1V6xBPNVap0BK9mvmiuUMsa0nw8vJf6TjIkkd
	m1Q0oN3YczDVEaJ+Hjxz7f+z5Abrg6xe3b6eoUTSC7JoW1SJ4iEDfdao4N4f1woC2Pzx02Bioep
	LXGGBj/GXRWFY02KLgP1fmAXvGOoXNzdygfWBvBrXuSRdGrLpHbJ9DxifY79wjck4dYDs5HU/m7
	Qv7zpmoLMbOtBjkO8ftwBiE6ZE6ogzFrujoWt1lxOVTAB5aS1TtJneyPZDiL/XmA1MP/THud6bJ
	jNiJYrYsQGF/GWnqKb/de2rJlAZt543YiM3WHP2l9vhDgxVI/TNy1HwCT24jexDHiY2GY1wSq73
	J8Ub9BnGw8ZYYIyQKFreA4OkNzDv2vDI/fbh5DIbjs7Vi6Rjz/U+fTL2KkkGreopSjmqEtunYe3
	/CGR3TL6ZhhFcPJz+Ch4GuAJv0cpZxc2lx+JpPTJe8braK33YSiJYydMBMrPpEjD3PPEpLZXpea
	t5pwioR6XNSPO5a/id/kAmg5EWiyl5MBA==
X-Received: by 2002:a05:690e:4852:20b0:662:dbac:87cf with SMTP id 956f58d0204a3-66487e20ec1mr249634d50.37.1782350236790;
        Wed, 24 Jun 2026 18:17:16 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:d65:3756:91dd:3987])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f741290sm675869d50.3.2026.06.24.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:17:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to refresh start-point
Date: Wed, 24 Jun 2026 21:17:05 -0400
Message-Id: <43C04FB5-7FE5-4535-A79A-C35449EB38C0@gmail.com>
References: <xmqq5x37h6fj.fsf@gitster.g>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>
In-Reply-To: <xmqq5x37h6fj.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 24 juin 2026 =C3=A0 19:20, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFHarald Nordgren <haraldnordgren@gmail.com> writes:
>=20
>> Ok, let's focus on the need for the feature before talking code:
>>=20
>> In an active project, forking from "origin/master" without refreshing
>> first often has consequences: you start work that has already been
>> done, or you build on an old version of the code which causes big
>> conflicts only later when you pull. The fix is simple ...
>=20
> The above only argues that contributors should not start work on top
> of a stale codebase without looking at reasonably recent codebase.
>=20
> I am not sure if automated fetch immediately before forking to start
> work will be a good fix for that, especially if the fork of a new
> branch is done blindly _without_ looking at what the updated
> upstream contains.
>=20
>> ... ("git fetch
>> origin master && git checkout -b topic origin/master"), but it is
>> still a mouthful. Other tools exist because this is annoying enough
>> that people automate it.
>=20
> And to actually look at the recent codebase, one would probably need
>=20
>    git fetch
>    git log [-p] ..origin -- your-area-of-interest/
>    ... other inspection of the recent changes to refresh your
>    ... understanding of the base code comes here
>    git checkout -b topic origin
>=20
> or something like that.  Wouldn't folding the first and the third
> step into one operation encourage omitting the second step?  In a
> sense, having a tool to let people blindly fetch and fork without
> looking at what changed recently (i.e., they had a reason to think
> that what they had was stale, so has a fetch actually resolved that
> staleness?  what new things did the fetch bring in?) may encourage
> a bad workflow.

I think I remain overall ambivalent, but as anecdata: when I=E2=80=99m worki=
ng on my employer=E2=80=99scode, it is the default (90%+?) for folks to omit=
 step 2 and have the kind of blind fetch + branch that this would facilitate=
.

I myself do this when I=E2=80=99m reasonably sure the other changes can=E2=80=
=99t be of interest (common), or when I suspect the change I=E2=80=99m going=
 to start on will conflict with recent changes I haven=E2=80=99t fetched. At=
 other times I=E2=80=99m more interested in step 2, but generally I omit it a=
t work.

Now, as to why: I spend a lot more time reviewing PRs at work (and making su=
re they merge quickly when they are in the right direction), and so I=E2=80=99=
m usually fairly confident of what a fetch is going to bring! [I also fetch s=
everal times a day to keep up to date locally, to facilitate various mainten=
ance, admin, and archaeology tasks.] Contrast with distributed open source p=
rojects, where I might not have fetched for weeks and can=E2=80=99t predict w=
hat might fall out (let alone how it might it interact with local WIP).

So =C2=AB bad workflow =C2=BB I agree with, but am plenty guilty of :)

To wrap up, I wonder if the convenience of this proposal is especially aimed=
 at folks like my corporate environment (where =C2=AB build near the tip and=
 integrate quickly =C2=BB is the norm), but less than useful for those same f=
olks in a different situation?

(OTOH, I suppose I might use something similar when starting a new topic bra=
nch from Git=E2=80=99s master branch, since there=E2=80=99s probably no harm=
 in working on a recent copy of master unless I already have older code that=
 needs updated?)

> An obvious complaint against "update and always inspect and
> understand" would be "it would slow us down!", but that is why
> projects encourage forking your topic at a well known release tags,
> not from a random "tip of the tree of the day".
>=20
> I think most of the above has already been communicated earlier in
> discussions before we got to v14, but I may be wrong.  Are there any
> new arguments in support of the feature?
