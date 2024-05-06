Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4561DFF3
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020436; cv=none; b=dKvA48dwD4+fTvdZiPzKDjD0eZVnsbhNl22US+wQDK53slEWV1jaeSJXWt2gOWd4BAj6R2Efx88R9iWSsZ5rLCLyjbhwOGAH+U4/rDHRRZ2QiziCkeVszutbUln/nC8EvtLKZOgVFNz7hJ2v/LMvMjUKgMyurlBMqm826Ug9664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020436; c=relaxed/simple;
	bh=KRPB14SKzfo3MTT7EebBtGWh2qgEZFf4ga80j+wVXm0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=maMDf6reBsROyTgZt9EVb6Hz5sZHRrQcjVhHFW3oWx4krG1/LB8dPpgDw12AfZK4ovDZVBVA/VvJi9jfh0wO692Dbcb8og2Gi9YSUywwJ1HD9+g0VaHljf5aZW4+hryvDsPw9kRpFOiE2MeCL0tpfx4lCgxsFPw1QnA22ERBQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 446IXaf02610596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 18:33:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Karthik Nayak'" <karthik.188@gmail.com>, <git@vger.kernel.org>,
        "'Kristoffer Haugsbakk'" <code@khaugsbakk.name>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>	<b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>	<CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>	<015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>	<xmqqjzkaanr1.fsf@gitster.g> <ZjiL7vu5kCVwpsLd@tanuki> <xmqqttjazwwa.fsf@gitster.g>
In-Reply-To: <xmqqttjazwwa.fsf@gitster.g>
Subject: RE: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Date: Mon, 6 May 2024 14:33:32 -0400
Organization: Nexbridge Inc.
Message-ID: <04d001da9fe3$e9c2eef0$bd48ccd0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKBQTBe5e4gLvpUZ43kt8vf+F35UwHSzjW9AiAHsugCVIXXIwJRWA+4AjPZodgBrXl4CAEsQikBr9AEY1A=
Content-Language: en-ca

On Monday, May 6, 2024 1:13 PM, Junio C Hamano wrote:
>Patrick Steinhardt <ps@pks.im> writes:
>
>> ... I was pondering
>> whether we want to introduce a document as part of that patch series
>> that starts to keep track of upcoming removals for a potential Git =
3.0
>> release.
>
>Finally somebody has bit it ;-)  In the 2.44 cycle, I wrote
>
>    The RelNotes symbolic link says we are now working towards Git =
2.44.
>    It may not be a bad idea to reflect on what technical debt and UI
>    warts we have accumulated so far to see if we have enough of them =
to
>    start planning for a breaking Git 3.0 release (or, of course, keep
>    incrementally improve the system, which is much more preferrable---
>    continuity and stability is good).  End of year being a relatively
>    quiet period, it may be a good time to think about your favorite =
pet
>    peeve, to be discussed early next year.
>
>in a few of the "What's cooking" reports.
>
>> There are multiple items that could be added:
>>
>>   - Removal of the old syntax of git-config(1).
>>
>>   - Removal of the dumb HTTP transport.
>>
>>   - Removal of `info/grafts`.
>>
>> There are probably other items.
>
>A list of things I can think of that I won't be the primary advocate =
for but I do not
>mind too terribly if we had champions for the topics are attached at =
the end.
>
>> In any case, the old actions are here to stay for the foreseeable
>> future until we commit to a breaking major release.
>
>True.
>
>> Thanks for the thorough explanation, I have nothing to add!
>
>You could have avoided it if you copied some from the initial cover =
letter to each
>round (i.e. preparing the series to be read by some folks who did not =
read an earlier
>round).
>
>
>Possible additional Git 3.0 items:
>
> - Removing "git http-push" to push over HTTP/DAV.
>
> - Removing support of `$GIT_DIR/branches/` from remote.c API.
>
> - Removing "git update-server-info".
>
> - Removing "git annotate".

I must have missed this... I thought annotate was replacing blame.

> - Removing "gitweb" and "git instaweb".
>
> - Removing "git filter-branch", now we have a better alternative
>   "git filter-repo".
>
> - Removing discovery of hook script in "$GIT_DIR/hooks/", in favor
>   of the configuration variables that point at them.
>
> - Switching to SHA-256 as the default hash algorithm.
>
> - Switching to reftable as the default ref backend.
>
> - Switching the hardcoded default branch name away from "master" to
>   "main".
>
> - Declaring that "git restore" and "git switch" were failed
>   experiments and deprecating them.

This restore and switch have broad use in my community. I do not =
consider them failed experiments at all, but essential in scripts and =
usage. Removing these would block migration to git 3, in my view. I have =
actually been thinking about doing a YouTube video on these commands.

> - Declaring that "git submodule" was a failed experiment and
>   deprecating it.

This would be a very high-impact decision. Aside from my community's use =
(and my own company's dependence on submodules), this will break large =
numbers of GNU-based projects that use submodules for distribution, =
including build-aux. I would suggest staying away from this decision. =
Submodules have definite value. Please keep them.

If you really want to get rid of stuff that has limited use instead of =
submodules, it is worktrees, the benefit of which is reduced given =
sparce checkouts and fetch depth.

--Randall

