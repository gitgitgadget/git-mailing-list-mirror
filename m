Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CE207A26
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305601; cv=none; b=YTtRvVU+iJ7xOE71hsq9LEQuumnb0dRALoGi9FqZAPyGuV9Qy53+q/2kAPVW3OahZ++Opk6W01TvyTk9smMT+mG4rm6sQimqT+3NHaWMzci2B18q9cevFw5cZ6R/0ggPKcKw2ugDFzeym2xJxNgpo7Qdh0kSyRf+Im8gSX+LXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305601; c=relaxed/simple;
	bh=Re6yCYfywb0u1oUPBH/GkuelLlLjwaLiBy7ToPsF7ZQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jyiw/9tOY+ve926wfpbzCRkvMHDrLNAauceXpsTZeb9XMps14OH/j/erYsnkMt20f6gucaDkSkSAXhgXN+1Sxh8EsEPS/afDhvgECH/aizrwYtwDgWyKQBR7FjdHSjEl3YkGyLiLiI5T71YLRNSbd7uZzwhsMWZapGtVlWSCMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57REdEwX138052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 14:39:14 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, "'Elijah Newren'" <newren@gmail.com>
Cc: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com> <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com> <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com> <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com> <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com> <aK5mJI1NfVQDmDXN@nand.local>
In-Reply-To: <aK5mJI1NfVQDmDXN@nand.local>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Wed, 27 Aug 2025 10:39:10 -0400
Organization: Nexbridge Inc.
Message-ID: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHKaANAdlFqcOHeZ+UNw9ZV5fNZlgJjoZaSAeK73o4BCSPnmQFMkRvcAya/ufMCJfQ+PgG6B6/ItCzZI2A=
X-Antivirus: Norton (VPS 250827-2, 8/27/2025), Outbound message
X-Antivirus-Status: Clean

On August 26, 2025 9:58 PM, Taylor Blau wrote:
>On Sat, Aug 23, 2025 at 11:30:26AM -0700, Elijah Newren wrote:
>> > The assertion in the policy that Rust is easily interoperable is =
incorrect.
>>
>> Are you mixing up interoperability with portability?  Without further
>> context than your email provides, it appears so to me.  Rust code can
>> call C code and vice-versa within the same process without huge
>> amounts of serializing and deserializing of data structures, and
>> without what amounts to something close to an operating system =
context
>> switch in order to ensure call stacks are as expected for the =
language
>> in question.  To me, that means we can call the two languages easily
>> interoperable.  On the other hand, portability of those languages is
>> about whether those languages have compilers supported on various
>> hardware platforms.  The document explicitly calls out that fewer
>> systems have a Rust compiler than have a C compiler, and that Rust
>> adoption would thus reduce how portable Git is.  Are you referring to
>> this lower portability that the document itself also calls out, or =
are
>> you pointing out additional issues with interoperation between the
>> languages on a platform where compilers for both languages exist?  If
>> the latter, could you provide more details?
>
>I think that this is the main point from my point of view. Yes, we are =
strictly
>worsening the project's portability by adding Rust as a non-optional =
build
>component. But it is *not* the case that two Git clients (one =
hypothetical one built
>with Rust components, one existing one without) can't work on the same =
Git
>repository, even including one on the same machine.
>
>Forgetting Rust for a moment, I don't think it is a realistic goal to =
have support for all
>platforms that could possibly want to run Git. I would imagine that =
there are
>platforms today that cannot run the latest and greatest version of Git =
for just that
>reason. My hope is that whatever version(s) *are* compatible with those =
platforms
>are good enough to support the workflows that those users need.
>
>So my personal feeling is that that (not having a 100% portable version =
of Git across
>all possible platforms) is OK. But of course that does raise the =
concern that security
>fixes will be more difficult to backport across a hypothetical version =
boundary
>where Rust is introduced.
>
>To that end, I would note a couple of things:
>
> - This assumes that the Rust code has the same security =
vulnerabilities
>   as the C code that it replaces. I don't think that is a given
>   whatsoever, and I would bet that emperically there are fewer such
>   vulnerabilities on the Rust side than on the C one (in fact, that is
>   one of the reasons that we are considering Rust in the first place;
>   brian m. carlson explains this point quite well IMHO).
>
> - If there *is* a security vulnerability in the Rust code that also
>   presents a vulnerability on the corresponding C side, I would hope
>   that the project's track record of generously backporting security
>   fixes would suggest that we would do so in this case as well, =
despite
>   crossing a language boundary.
>
>   On the other side of that coin, if there is a security vulnerability
>   in an older version of Git that isn't present in a newer one
>   (regardless of whether or not Rust is involved), I would imagine =
that
>   that we would write security patches against an even earlier maint-
>   branch and forward-port them up to the most recent vulnerable
>   version.
>
>So my impression is that the main contention here is a concern that =
worsening the
>portability will make it harder to push out security fixes in either =
direction. But I
>don't think that's necessarily the case. Even if it is, I would again =
hope that the track
>record of the folks on the git-security list would suggest that we'd do =
the right thing
>and not abandon users on older platforms the moment Rust is introduced =
into the
>codebase.

This is indeed my concern and hope, Taylor, as the maintainer for a =
platform that is
feeling abandoned. Please note that HPE NonStop is an actively =
maintained and
vendor supported commercial platform based on x86_64 POSIX, just not a
Linux/Windows machine.
Thank you.

