Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13836B
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057144; cv=none; b=NOebolFaiWJ3V/ejjKBzhfHfXp2GTqhASs6/xtUedElpQQ/lsuCWfSQVqMNC6u7qB+QyoV4Wu17ipeArCBqAr+E3vEu/CEwowtueOh23rYDXV+bRV2CRt1LedD5lAj8FpE7rswwyY5UwogIaaPqNqimm+enmpr5EX5EZCB+/Sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057144; c=relaxed/simple;
	bh=Y7JTtu64Q+AFjzE/sYsMPYSsFF4eg6czwsXwt4pLm48=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iuCPUQjCu1D8LMbmcov8muwx/N4QwSiDloc9f3cwQO0UKdkAa8yoIQwF/pP5dzayjyyc1Pv3FlURr10O0ZzIdAQSSk74kkurrPcyzpAX0Jfd+UrejpnHmd5MWO39wyC8hr1gUcgy7o/5hqdIztC4X6nw9mkCmlgAGU/UrXJZPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK4ZE3I8; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK4ZE3I8"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-77f947312a5so15031277b3.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760057142; x=1760661942; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn6fD9/yu99QAAxO9BNE+EDjUkUTwzPHTo8dK9BJLJo=;
        b=VK4ZE3I8gRQKXmls2kI8lPEWRQBf0xQtcT2CBvS1gkhV40IzHIwV2dNFCwPJ47eQj+
         Qq2LXBRTBak0rQvSCIvbejXozidoIPYeV1M1o0o3iNCcJKVulLjVCSbhCI1dNdpsq92p
         8ECpZCvtah2eta7AxC0qGnhihc6eOr+mJwUrUmuKnmo8xwOjWW8PTXvcu+wBxyQZJGlj
         eJCbPonvD+4JMAVCMi39gkUqfW9zFIWSxxZ3OmDZsNC56ddaDGsUZdkl/t1XmX+zfMSC
         y0k/L9Jl8+aQSTYTI6SkUKaE3yzMIzQFgqVVihkhlmzPqShrxUGUJ0KSfrqKq/raP3wY
         xDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760057142; x=1760661942;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn6fD9/yu99QAAxO9BNE+EDjUkUTwzPHTo8dK9BJLJo=;
        b=SDWObeowFO9Ga/E0SmWNK2Jff4eyNAbAYhsmIXmWpQHtCNk66dw701RcAWvXb9e8Ok
         Au9YYUFEDYmWhAbso1MLcHI027jHAg4x13d8sW5CytnO11uK/yxwapyxAsutcLi92pke
         bodf6e8uU2La6/yqyqDMz+BdBh8VX8sjs+lGasywKyA47IcMFG84IzokOXnY2O7JYKJ0
         rpmF7f5V+8s+N79qWXrhcDQi6F/eBK8/41MNpxDKKJMOEUwFIgX99BOhkKyiuhQLD+Rp
         Ch72H5f4b205+A6cbVEeYcGuhXiqY1plzxbvXImNn0ObvJQeLeli1IhMgmEFQ/nV9ahy
         fBMg==
X-Forwarded-Encrypted: i=1; AJvYcCXSJpoMUswmZWcGy9AzAY1EfvTKnKoercPfweGJWJNPKJPq6Mo8fdA4KQKkC3TmR/YeZ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk/eJKKLs2az/CCxFD3xIQYOReUFXEF4WcqkTaLv1fTnhu+rug
	yDP2UtfUhpKNP3H9o+HzcWktweyeDta4ceiaUkocMASvewnYA5FTjW8XEjZ1IA==
X-Gm-Gg: ASbGncvigtBBKLbUQqIIE6aKBvgTn+Yl/4++vW6GAO3FFtlnhso/BLTUhiMcXOKgi/t
	KZ4Y1YhUjFhZO8ZKU9rQKCSUj+5BpJO9wAPHflt+YuOty/Hb39O+pzOljgmATtzaRIRU7WyUSdJ
	kUjiuUR7XpSgCrOfrPzsMxBeO6UhFQqDlwNWtop7zKjiM4M5B8bFFoDRfPMyQq1w3CEFfroQ5Ux
	KEEOPpoRl81JNWNGs2qR+9p2UCITJgVXpfCBBHVz1Bl0QaSFUC1OCADIkrG1xUbKcJ61OlW3WXU
	VX9Yymfq6Q5JPgtVX4hYzSD59oqm+ukP7KncPaQnRMWyiuVG1k0ixsHpt1j9lS8vpbysLqbP7Lo
	0Vu3mWYFdu5yotVxGRzKQU42G5krrc2SjzeDVSrGSf39Prxxeq4EuDcJOlZPD1Woj0vum1vIfUw
	==
X-Google-Smtp-Source: AGHT+IFMY2nRIm6WUdT5GU9xDvYqqjTNi7fBr9J5CfFl8obarxtEHvStcJRJ11pp3orrgZEnpTVYBQ==
X-Received: by 2002:a05:690e:1a5e:b0:635:4ecd:759c with SMTP id 956f58d0204a3-63ccb8dba6emr6717873d50.42.1760057141764;
        Thu, 09 Oct 2025 17:45:41 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:addc:817b:ddab:687])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd95160eesm1289528d50.3.2025.10.09.17.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 17:45:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] doc: git-pull: clarify how to exit a conflicted merge
Date: Thu, 9 Oct 2025 20:45:30 -0400
Message-Id: <6B75AE20-CF68-4C98-A49C-248E2C50A756@gmail.com>
References: <74f8a51f-f62d-4f85-89b0-f701338c7550@app.fastmail.com>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
In-Reply-To: <74f8a51f-f62d-4f85-89b0-f701338c7550@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (21F90)


> Le 7 oct. 2025 =C3=A0 17:01, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>=20
>> On Wed, Sep 24, 2025, at 4:29 PM, D. Ben Knoble wrote:
>>> On Tue, Sep 23, 2025 at 3:48=E2=80=AFPM Julia Evans via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>=20
>>> From: Julia Evans <julia@jvns.ca>
>>>=20
>>> =46rom user feedback:
>>>=20
>>> - One user is confused about why `git reset --merge`
>>>  (why not just `git reset`?). Handle this by mentioning
>>>  `git merge --abort` and `git reset --abort` instead, which have a
>>>  more obvious meaning.
>>=20
>> "git reset --merge" _can_ be helpful when merging, but won't fully
>> abort a rebase. Great.

While fiddling around: turns out reset=E2=80=99s merge flag does abort the m=
erge properly. TMTOWTDI, I suppose.=20

>>=20
>>> --- a/Documentation/git-pull.adoc
>>> +++ b/Documentation/git-pull.adoc
>>> @@ -30,15 +30,9 @@ branch. There are 4 main options for integrating the r=
emote branch:
>>> You can also set the configuration options `pull.rebase`, `pull.squash`,=

>>> or `pull.ff` with your preferred behaviour.
>>>=20
>>> -In Git 1.7.0 or later, to cancel a conflicting merge, use
>>> -`git reset --merge`.  *Warning*: In older versions of Git, running 'git=
 pull'
>>> -with uncommitted changes is discouraged: while possible, it leaves you
>>> -in a state that may be hard to back out of in the case of a conflict.
>>> -
>>> -If any of the remote changes overlap with local uncommitted changes,
>>> -the merge will be automatically canceled and the work tree untouched.
>>> -It is generally best to get any local changes in working order before
>>> -pulling or stash them away with linkgit:git-stash[1].
>>> +If there's a merge conflict during the merge or rebase that you don't
>>> +want to handle, you can safely abort it with `git merge --abort` or `gi=
t
>>> +--rebase abort`.
>>=20
>> This information is also mentioned in the advice given by conflicts
>> (and git status), so while I originally wondered if we need to say "to
>> know which to use, run=E2=80=A6", I now think we can trust users to know
>> whether they asked for a merge or rebase and read the advice/git
>> status output when they don't.
>>=20
>> Hah, just kidding. Nobody* reads that output. But I still don't think
>> it's worth muddying here, because the same folks are unlikely to see
>> the help here, right? Or maybe we say "Information in `git status`
>> will summarize these options for you." ?
>=20
> I think it's a nice way to reiterate that `git pull` is running a merge or=

> rebase under the hood, but if folks feel strongly that this isn't relevant=

> I'd be happy to remove the `git merge --abort` / `git rebase --abort` note=
.

I=E2=80=99d probably prefer to keep the pull->{merge,rebase} implication. I j=
ust want =C2=AB how do I know which one =C2=BB to be clear.=
