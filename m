Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7E10E0
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345610; cv=none; b=sD6vrRo1LGJlkDRmEheYnCw9vGqwk/S1utiwDlKO1zgqnO4wIYSu5kaB2h8q8fao7PPSdJd4DvNJjz8QJ+UxGoMYCS4/AKPWdIn497oU89Nw+2xdHMg7ZVllE6JRGaDIXcWpIAEQkTKvvFL4wKfPFE4d1a5vA8EXSXnOTBKuGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345610; c=relaxed/simple;
	bh=MHGKzW4/ediONINknVGAUzr+A85Xybavuh1gv9LkFVs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IGzal3MsRHUWsRp04Z0JROhzr0Fmlw+5YK5bM7AI6oNpMZL9hxJmSb3smyBxWgcp1mWlWISkEEqavzUtlgTdR+06DqiJ52YdIGyhq9D6Uli0KEVb6Syfj8KqOZSClHpkCDy+XnseG9tr2R0M6aiUKKMqA6DE9DtocWAM1eTvGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 588FWeiv2979476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 15:32:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com> <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local> <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com> <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com> <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com> <ad54bb8f-04e4-4bf7-a13f-6ae7b967b718@gmail.com>
In-Reply-To: <ad54bb8f-04e4-4bf7-a13f-6ae7b967b718@gmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Mon, 8 Sep 2025 11:32:36 -0400
Organization: Nexbridge Inc.
Message-ID: <049301dc20d5$d1643340$742c99c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEGadT21z5OprxVD7HWLLwOJZ29EAFNCYxRAdIt06UCgtOkMwLNWyY+AkPZBcsB+sNnaQLQ9HhNAfwz3cQCYIs5bgMRNqFTAiZSYtwCDxYVSgItQfdjtUpUdCA=
X-Antivirus: Norton (VPS 250908-0, 9/7/2025), Outbound message
X-Antivirus-Status: Clean

On September 8, 2025 6:12 AM, Phillip Wood wrote:
>On 07/09/2025 17:09, rsbecker@nexbridge.com wrote:
>> On September 7, 2025 12:10 AM, Elijah Newren wrote:
>>> Sorry for the delay; life outside of work is challenging at the =
moment...
>>>
>>
>> I am going to address the critical point mentioned below and snip the =
rest for
>brevity.
>>
>>> I still don't see why distributors _must_ ship the latest version of
>>> Git and why folks on some platforms are considered broken if they =
are using a
>slightly older version.
>>> Let me ask again: has anyone answered why this is considered
>>> mandatory?  If they have, I've missed it, but I've asked multiple
>>> times.  Even if you want to lump "distributors cannot build a newer
>>> version" under the umbrella of "breaking changes", I argue it's a
>>> much different kind of break and one which merits different =
timelines for
>handling than e.g. lumping it in with 3.0.
>>
>> I do not see that distributors _must_ ship the latest version. =
Suppose
>> we are on
>> 2.51.0 and a CVE comes out that prohibits its use in an organization
>> that does not allow any medium-high to high CVEs. This represents
>> hundreds of thousands of impacted users in my community alone. How
>> does the CVE get applied if the latest cannot be built and the git
>> team does not apply the CVE fixes to old versions. Personally, I do
>> not care if git versions are different between work and home, or even
>> between CI/CD and other platforms. I don't even care if I have to use
>> JGit instead of git in some situations (which I see is a likely
>> outcome of this discussion). Is there an official statement of what =
an LTS means?
>
>We're currently discussing what promises we can make about supporting a =
non-rust
>version of git.
>
>> In other projects LTS is typically, and formally by policy 5 years.
>
>I know commercial linux distributions offer that kind of support but =
are there really
>open source projects that guarantee 5 years of security updates without =
any kind
>of support contract?

OpenSSL provides 5 years of security fix support (at no cost) for LTS =
designated
releases. Currently 3.0 ending Sept 2026 and 3.5 ending around October =
2030.
After those dates, there is a fee-based support arrangement available.

>>  From what others have said here, positions of 6 months, 3 years, and
>> "apply it yourself if you want to continue to use git" have been =
made.
>
>Yes it is still being discussed, and no one is volunteering to offer =
five years of
>support.
>
>> The core problem of adding a breaking dependency is when a CVE comes
>> out that prohibits git from being used at all. If the git team is not
>> going to provide a clear statement, one way or another, if how CVEs
>> (at whatever severity level) will not have a commitment of any kind,
>> then distributors are essentially cast adrift and on our own. It =
would
>> be helpful of those of us who donate our time, for no compensation,
>> are able to plan for this in a meaningful way.
>
>Doesn't your company make a front end to git? Are you saying that the
>management does not allocate any staff time to work on git itself and =
expects the
>community to provide it with free security updates?

The REAL PROBLEM that is not being addressed in this thread is that =
large
companies (the ones who process your credit cards, build your cars,
manufacture your drugs, and tool your factories (a.k.a. NonStop =
customers),
are generally unwilling to accept CVE fixes from third parties. The =
fixes have
to be part of the official code base or the fixes will not accepted. =
That means
that either:

1. the git team has to officially sanction the fixes; or

2. do the fixes themselves.

A compromise may be possible to keep a support branch around in the =
official
git repo, for those of us who do not have rust available to contribute =
to,
specifically for post C-deprecation CVE fixes, but I am not sure this is =
practical.
It would also require occasional assistance from the git team, to make =
sense of
some of the fixes, If they apply, as none of us are rust experts.

I am already allocated to spending between 10 and 20 hours a month to =
git,
which usually involves running and verifying build/test cycles. Since =
git tests
are flakey, in some cases, I have to manually examine each failure
situation and decide whether the failures are sufficient to pass the =
releases.
These have been reported previously without resolution and do not bear
discussion here.

It is important to understand that many git customers in high audit =
situations
build git on their own because they do not trust third party builds, so =
this
needs to remain an option.

>> Please remember that
>> we have to justify our participation to our management teams to be
>> allowed to continue to participate.
>I'm confused by this, as the sentence before say's you're donating your =
time for no
>compensation.

My company pretends to donates my time with very little direct benefit =
to
them. My participation is because I feel it is important for my =
community.
No, I do not get a salary for my git time. It is evenings and weekends. =
Any time
I spend during working hours has to be made up during off hours.

>
>> Nothing is free from this end
>> and if fixing (not just applying fixes) CVEs are now 100% our
>> responsibility, if would be critical to know that when we build our
>> business cases to our bosses, who I am fairly certain will say an
>> emphatic no.
>
>In the long term, unless your platform gains a rust compiler I'm afraid =
I think that is
>most likely outcome.
>
>> Also remember that without support from the git team, the code base =
is
>> no longer the same, meaning the auditors will not necessarily accept
>> fixes from third-party sources.
>
>I think I saw a suggestion/question about the possibility of hosting =
any long term
>support branch that is maintained by interested parties within the main =
repository.
>Would that help?

DEFINITELY. With assistance as above. With some help, we may be able to =
make
this work. It might require a deeper participation on my part and those =
on my
team to approve changes, which we would consider.

>I appreciate that any move to rust would be very disappointing and =
disruptive to
>you but the community has to weigh up the benefits rust has to offer =
against that.

The community has plans for Rust but they have not taken shape fully as =
of yet. I
have personally been badgering product management to make this happen, =
and I
might know more in a month or so. However, this takes time, and 6 months =
is not
enough.

--Randall

