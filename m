Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85A12B171
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729488; cv=none; b=a6FLAlrOKpYB7h0HVtftFi/ZQslYylF6F3hfkTu0QuyavTUyt4T3uf8dQXWUh5zQZQ9UymmaZhiMswVYmM1e7VL1EglFjyo3iBi7AoDjXYw9g+VtZ/6ZPEzW6A18hYN2T3+r6CLuk3YqCBOfK/xqcslHxsshwa2QgjMqzSqE9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729488; c=relaxed/simple;
	bh=TlIK9A7MfTkDzW5QUDjTcKBLX5erJOOTb1tY/ccV+Qc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gW1o1N2g6/jhMVJOnZMfwEcTqCOj3QhuJbi+JJSuzsPGvPuki1FrwhRU8OI1frT/2k6xXN3/Cj51J96FR7VcmWOoggNgaeb7ILLMUEvfl2BnDA3a3VojHFb83hZfuRrUZhWrS2ZDXJ0yK191WGvf/uvvG54ZGRAonjoZ1M2q+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46BKOTEv3934698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 20:24:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kyle Lippincott'" <spectral@google.com>,
        "'Emily Shaffer'" <nasamuffin@google.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20240709225042.2005233-1-emilyshaffer@google.com> <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com> <CAO_smViKbb5pKKsfEV9nMLNJEjJ34HU0fUZmG8EPJjXq2fnviQ@mail.gmail.com>
In-Reply-To: <CAO_smViKbb5pKKsfEV9nMLNJEjJ34HU0fUZmG8EPJjXq2fnviQ@mail.gmail.com>
Subject: RE: [PATCH] Documentation: add platform support policy
Date: Thu, 11 Jul 2024 16:24:24 -0400
Organization: Nexbridge Inc.
Message-ID: <00e501dad3d0$5577e4f0$0067aed0$@nexbridge.com>
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
Thread-Index: AQLOJF488y2+/PGZbbSRsjvDFvsFqgHGsZGHAOpA7/wBYP2wY6/qxnUg
Content-Language: en-ca

On Thursday, July 11, 2024 4:13 PM, Kyle Lippincott wrote:
>On Thu, Jul 11, 2024 at 11:15=E2=80=AFAM Emily Shaffer =
<nasamuffin@google.com> wrote:
>>
>> On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> >
>> > On 2024-07-09 at 22:50:42, Emily Shaffer wrote:
>> > > Right now, this doc talks about "guarantees." I used that =
phrasing
>> > > based on what I've observed to be an implicit expectation that we
>> > > guarantee support; it could be this isn't actually a guarantee
>> > > that the community is willing to make, so I am hoping we can =
discuss it and
>come up with the right term.
>> >
>> > I think it might be helpful to look at what some other projects do.
>> > Rust has a concept of tiered support, and it requires platforms to
>> > have maintainers who will commit to support an OS.  I don't think =
we
>> > necessarily need to be so formal, but if nobody's stepping up to
>> > monitor an OS or architecture, it may break at any time and we =
won't
>> > be able to consider it when deciding on features we require from =
the
>> > platform (such as Rust, C versions, or POSIX versions).
>>
>> It took me a little time to find it, so here's the link for others:
>> https://doc.rust-lang.org/nightly/rustc/platform-support.html
>>
>> I do think it's interesting that while Rust splits their tiers based
>> on how much of it will definitely work (definitely builds+tests,
>> definitely builds, probably builds maybe), which is different from =
how
>> I sliced it by time (works on release, works on stable, works on
>> unstable). This kind of lines up with what you mentioned next about
>> the tests (or some subset) working, which I hadn't considered, =
either.
>>
>> >
>> > I think it's also worth discussing what we require from a platform
>> > we're willing to support.  For example, we might require that the
>> > platform pass the entire testsuite (ignoring irrelevant tests or
>> > tests for things that platform doesn't use, such as Perl) or be
>> > actively pursuing an attempt to do so.  We may also want to require
>> > that an OS be actively receiving security support so that we don't
>> > have people asking us to carry patches for actively obsolete OSes,
>> > such as CentOS 6.  Finally, some sort of time limit may be helpful,
>> > since some Linux vendors are now offering 15 years of support, and
>> > we really may not want to target really ancient versions of things =
like libcurl.
>>
>> I sort of wonder how much of this is taken care of by expressing
>> "fully supported" as "can run in GitHub Actions". Even if an LTS
>> distro is 12 years old and using ancient curl, will GitHub still be
>> able to run it in a VM/container? Maybe there's no such guarantee,
>> since you can hook up self-hosted runners (which sounds more =
appealing
>> if someone's got something weird enough it doesn't run well in a
>> container).
>>
>> I'm not sure which of these requirements we'd want to enumerate - but
>> does it make sense to tack it onto the end of this doc? Something
>> like:
>>
>> """
>> Minimum Requirements
>> ------
>>
>> Even if tests or CI runners are added to guarantee support, supported
>> platforms must:
>>
>> * Be compatible with C99
>> * Use curl vX.Y.Z or later
>> * Use zlib vA.B.C or later
>> ...
>> """
>
>My concern with actually listing what the minimum requirements are is =
that we
>then need a process for raising the minimum requirements. For C =
specification, I can
>see that rightfully being an involved conversation and achieving =
consensus that this
>is the right time to do it. For things like library versions, I'm less =
comfortable with it
>because if we have to raise the minimum bar for some urgent reason, =
there's the
>potential for additional friction with these platforms claiming that we =
stated we'd
>support them (ex: we say you need to be able to use libfoo v3.x.x =
(v4.x.x had some
>breaking changes, but coexists with v3, so we just stuck with v3), and =
some security
>fix that we need to receive only exists on the v4 version, so now we =
need to port to
>using v4 so that we get the security fix).
>
>I think it's probably fine to list minimum requirements, as long as we =
have
>something conveying "and possibly other criteria". I don't want this =
interpreted as a
>"do this, and we will try hard to not break you", it should be =
interpreted as "if you
>can't do at least this, we won't even look at patches/tests/CI to =
unbreak you/keep
>you unbroken"

I have similar concerns both in terms of compilers and libraries. I am =
maintaining two exotic platforms, NonStop x86 and ia64. The ia64 is =
going off support "soon". In x86, we have more recent tooling, but not =
everything. It is at an older POSIX level. However, getting libraries =
built is either going hat in hand to HPE asking for updates on libraries =
or porting them myself. This is hard because gcc is not available, nor =
is likely to ever be - so anything with gcc in the mandatory toolchain =
is out of the question. For ia64, it doesn't matter much, and freezing =
on 2.49, or slightly later than 2.50 is not a horrible decision. I do =
have to keep x86 alive for the foreseeable future. My only real time =
limit is getting a 64-bit time_t (not available yet) in a 64-bit git =
build (also not possible yet) - which really depends on 64-bit versions =
of dependencies from the vendor, which is not easy to make happen. So, =
time limits are a definite concern and policies on those are important =
to quantify. Fortunately, I am monitoring and building git frequently =
looking for trouble. I think that part is important for any exotic =
maintainer and probably should be officially quantified/sanctioned.

>
>>
>> >
>> > At the same time, we do have people actively building Git on a
>> > variety of platforms and a huge number of architectures, including
>> > most Linux distros and the BSDs, and we will want to be cognizant
>> > that we should avoid breaking those environments when possible, =
even
>> > though, say, the porters for some of those OSes or architectures =
may
>> > not actively follow the list (due to limited porters and lots of
>> > porting work).  I imagine we might say that released architectures
>> > on certain distros (Debian comes to mind as a very portable option) =
might be
>implicitly supported.
>>
>> Are they implicitly supported, or are they explicitly supported via
>> the GH runners? Or indirectly supported? For example, the Actions
>> suite tests on Ubuntu; at least once upon a time Ubuntu was derived
>> from Debian (is it still? I don't play with distros much anymore); so
>> would that mean that running tests in Ubuntu also implies they will
>> pass in Debian?
>>
>> (By the way, I think we should probably just add a BSD test runner to
>> Actions config; we test on MacOS but that's not that closely related.
>> It seems like it might be a pretty easy lift to do that.)
>>
>> >
>> > > +Compatible on `next`
>> > > +--------------------
>> > > +
>> > > +To guarantee that `next` will work for your platform, avoiding
>> > > +reactive debugging and fixing:
>> > > +
>> > > +* You should add a runner for your platform to the GitHub =
Actions CI suite.
>> > > +This suite is run when any Git developer proposes a new patch,
>> > > +and having a runner for your platform/configuration means every
>> > > +developer will know if they break you, immediately.
>> >
>> > I think this is a particularly helpful approach.  I understand the
>> > Linux runners support nested virtualization, so it's possible to =
run
>> > tests in a VM on a Linux runner on OSes that Actions doesn't
>> > natively support.  I do this for several of my Rust projects[0] on
>> > FreeBSD and NetBSD, for example, and it should work on platforms
>> > that support Vagrant and run on x86-64.
>> >
>> > That won't catch things like alignment problems which don't affect
>> > x86-64, but it does catch a lot of general portability problems =
that
>> > are OS-related.
>> >
>> > I'm in agreement with all of your suggestions, by the way, and I
>> > appreciate you opening this discussion.
>> >
>> > [0] An example for the curious is muter: =
https://github.com/bk2204/muter.
>>
>> Neat :)
>>
>> > --
>> > brian m. carlson (they/them or he/him) Toronto, Ontario, CA
>>

