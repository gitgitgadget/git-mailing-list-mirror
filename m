Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099C22A817
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022370; cv=none; b=Ey1kJc+tc1Pxo+2ia1CFYDokrLuZwRF6mOnWTmzXobkH/D1wLXrIhhjCoZhHlhHyfjq+4x9aWON8D4AHKTUrj3EFDMSHX3wrLGELIZMr9/0o7Q3jMuFQSzqz24kgfnAg0oqFTR0nieVnFVRaMXmeMfovBblw4kXW/KSmhEHPtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022370; c=relaxed/simple;
	bh=nTkf9I2Oo+o0zXy+xUhSz8kVziB2vPahSQqcEcAikAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgz/vliorzgbhKNp0813rDZyoMInfqi8ZUNk/590T+gkUpW6hu3+GGR14IssXD52yIuiTkCVPSGMuE3EQXBvcsW0TSFGKxS6M8IU/+PcpYMHnxwPeG8bWLNx3nxo4klRn+lY5HvafdSQYNAfj/W5MBZitBlmx6LBvLJE4sPhZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lPOv0z9C; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lPOv0z9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774022363; x=1774627163; i=l.s.r@web.de;
	bh=cB/3UUuNMezKna69RgCONaQhlLns1NiehR3RYlJdCEM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lPOv0z9CDonJa6iG/42kTfvcqdmhMzeGktAE51oSSZjxlZXY29Xmy7+Jv4ZACb6f
	 41t0qTV7Fluh7W0d26x0NYuFr/fY/ykaX3Hdo9s41H8Y9GEaKaZR/QxZK1sM2oL0G
	 c11P/U0XHUEPMG/1+4bH2dbBRpFoMT2MPDjsX8Ju2cJMFM+jFFzFmMsTgjOA4w91b
	 syu+WFw8yrrxI/Tb/dpesebErTVvtMyu61+mPERu4TmBPAA1FtvVGg7YUcjYv4thK
	 HSYHLzX3z2tz8RZ9pXV76c+cHZN5WygKlqmUzu4k0qI6qdiZTt61Q/n3AW10Uy0cp
	 Vwrif13AQbiOi9FaBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1wHpih1fRc-00Z3K5; Fri, 20
 Mar 2026 16:59:23 +0100
Message-ID: <2e0df4c6-552c-4293-9d56-46917343ac78@web.de>
Date: Fri, 20 Mar 2026 16:59:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8qbnigxp.fsf@gitster.g>
 <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
 <77b6ec9f-46a5-1f38-9733-188e20da55ec@gmx.de>
 <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
 <5b8e24c2-452c-486e-a143-386e06a75e03@web.de>
 <58f3c772-6d38-0807-29c5-75e26c229c1d@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <58f3c772-6d38-0807-29c5-75e26c229c1d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+puXctU6bqOR05vH9v3qf0VewmFYS5Q308vAZzdwtlRStiMAeXH
 3ozklKRduxL2BMb4RKMeQc0QIv+84pNY/6ZG64120Mmx7gxWLHXOl0Zq6Bsj/Ry47+YnwiD
 M6AVaoBhDVndh7cAVTDRX9WRXziljxEmBzTGNgCOKmH/zbxutt6H198jZotvQVrDiNZabhe
 r2W3QDmUp0D9/7Nz+pf/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d3gdtTvtIDI=;CuBaxtZ0zHyUOrgF3DkSmeVI+9U
 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
 JODR316Takk/KYlZtsOrOJmF9Lfx749fA==

On 3/20/26 4:12 PM, Johannes Schindelin wrote:
> Hi Ren=C3=A9,
>=20
> On Fri, 20 Mar 2026, Ren=C3=A9 Scharfe wrote:
>=20
>> On 3/20/26 9:55 AM, Johannes Schindelin wrote:
>>
>>> Homebrew's LLVM clang uses different include paths from Apple's clang.
>>> In particular, the `regex.h` it sees does not define `REG_ENHANCED`,
>>> which is an Apple-specific extension present in the macOS SDK headers
>>> since at least macOS 10.12.  The Makefile unconditionally sets
>>> `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` for all Darwin builds via
>>> `config.mak.uname`, which pulls in `compat/regcomp_enhanced.c`, which
>>> references `REG_ENHANCED`, hence the build failure.
>>
>> I suspect it uses the same regex.h.  The definition of REG_ENHANCED is
>> gated by a __MAC_OS_X_VERSION_MIN_REQUIRED check, though, and that fail=
s
>> because __MAC_OS_X_VERSION_MIN_REQUIRED is defined as
>> __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ and that one in turn is not
>> defined by the Homebrew version of clang in the runner.
>=20
> That makes sense! I couldn't investigate this because I do not have a
> local macOS setup to test with, and I did not want to abuse GitHub
> Actions' runners (nor did I want to spend more of my own time on the
> investigation).
>=20
>> I can't reproduce this locally, by the way.
>> /opt/homebrew/Cellar/llvm/22.1.1/bin/clang is not linked to
>> /opt/homebrew/bin on my machine and also provides a sensible definition
>> of __MAC_OS_X_VERSION_MIN_REQUIRED.
>=20
> Hmm. I am convinced, though, that if it hits CI, it hits human users as
> well. Maybe the difference is that you upgraded from an existing setup
> while the runners (I think) are built from scratch every time.

Here's an experiment: This command:

   printf "%s\n" "#include <regex.h>" __MAC_OS_X_VERSION_MIN_REQUIRED REG_=
ENHANCED | clang -E -

... prints the preprocessed regex.h on a macos-14 runner (from the macOS
SDK, good) as well as the resolved values of the two macros (140000 and
0400).

Calling make instead of ci/run-build-and-tests.sh lets the build succeed,
including compat/regcomp_enhanced.o.

So the plain runner is doing fine?

>>> The `osx-gcc` job (CC=3Dgcc-13) is unaffected because Homebrew GCC is
>>> configured to use Apple's SDK sysroot, so it still picks up Apple's
>>> `regex.h` which defines `REG_ENHANCED`.  The `osx-meson` job is
>>> unaffected because Meson does a compile-time test for `REG_ENHANCED`
>>> (via `compiler.get_define`) and simply skips the feature when it is
>>> absent.
>>>
>>> Work around this by setting `NO_REGEX` when `CC=3Dclang` on Darwin, wh=
ich
>>> makes the build use Git's bundled regex implementation instead of the
>>> system one.  This sidesteps the missing `REG_ENHANCED` define entirely=
.
>>
>> Or how about using /usr/bin/clang explicitly on macOS instead of any ol=
d
>> clang from $PATH?  That would avoid user-visible changes.
>=20
> That would fix our CI runs, but it would expose users who set their `CC =
=3D
> clang` to the same problem that broke our CI builds...
I still don't get it, but below are two fixes; either works (i.e. only
one of the two files needs to be changed).  But why?  $CUSTOM_PATH only
contains p4 and p4d.  My observations don't make much sense, I must be
looking at it wrong. :-|

Ren=C3=A9


 .github/workflows/main.yml | 6 +++---
 ci/lib.sh                  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 826f2f5d3a..f8c6e034ee 100644
=2D-- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -322,16 +322,16 @@ jobs:
       matrix:
         vector:
           - jobname: osx-clang
-            cc: clang
+            cc: /usr/bin/clang
             pool: macos-14
           - jobname: osx-reftable
-            cc: clang
+            cc: /usr/bin/clang
             pool: macos-14
           - jobname: osx-gcc
             cc: gcc-13
             pool: macos-14
           - jobname: osx-meson
-            cc: clang
+            cc: /usr/bin/clang
             pool: macos-14
     env:
       CC: ${{matrix.vector.cc}}
diff --git a/ci/lib.sh b/ci/lib.sh
index 42a2b6a318..6310c16b7a 100755
=2D-- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -346,7 +346,7 @@ macos-*)
 esac
=20
 CUSTOM_PATH=3D"${CUSTOM_PATH:-$HOME/path}"
-export PATH=3D"$CUSTOM_PATH:$PATH"
+export PATH=3D"$PATH:$CUSTOM_PATH"
=20
 case "$jobname" in
 linux32)

