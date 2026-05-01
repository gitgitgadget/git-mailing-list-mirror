Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7242F90C9
	for <git@vger.kernel.org>; Fri,  1 May 2026 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611974; cv=none; b=bSkY/JSK/ez3OXdpv8RR4yIE+hTTGRnxLQKfRl3iDS7+5Y4Rt2yuKNUCqNNUvzj6869KHDEDmwmDL5f07HdBM1OGfPnr+uA5Svv3WvuHNOLmViggp2bjVhFPHHh7TbLZCIjeBArqPkaJyWb+i6jKW2OamLdflxqfM5V7pzyi83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611974; c=relaxed/simple;
	bh=6kKX72Xuv8qeqjf9v2HAYFToSakGkIX60ZYLzFC5gV8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ImKBqAaDSUJyoL+a6Kb74uHDPPzaRCrGO5Gsx5CZNSHjOlujOusgdmnV79ijdbrKzOWnq/FGDvm14kcRouTz3PY3pw86VQpRiJij03eZM5KoG+ukgMt5AlyHClna1TA8PUNAoUMVfAq6Dz88KTigFSaAGDQbrnpKz0F9vxC/XtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ty3VXXxr; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ty3VXXxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ulsjzrvm4rfkjblna4z26xhxrq.protonmail; t=1777611962; x=1777871162;
	bh=6kKX72Xuv8qeqjf9v2HAYFToSakGkIX60ZYLzFC5gV8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ty3VXXxrVhIOwQEDmPb7lx3l0Zg0C+7DkCK9g1Ssz2OI2FoMFnQcD0j24l4f4VOIf
	 P/xGVQcWrF52uaCaZyHP57oqaB69ak1y9CMIVSIv5YUx4/WuTXqn6Wuy4X5ML2gJNz
	 it8Y5Jhyzj+L6ybKeR5s79swmVdBUM8fUCoDlS4scIe9xF8/hK+Yz5piiWUWi/t2Ie
	 qRYqrULD+IO1vGshZArC9Y46KdDOsoe3SprLSs1RKMvgzdznxkqn1Y7jWWNqwg8Z3Z
	 PQ9YhumEx6glRWE4A4NWn/uO7X9Pa/HCyqshP/IBAyPHnR6LGgxYWfiHDYs95gGl0o
	 QJgdAsf4SXGmQ==
Date: Fri, 01 May 2026 05:05:59 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: "sebastien.stettler" <sebastien.stettler@proton.me>
Subject: git rename/moved status unreliable in ruby
Message-ID: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
Feedback-ID: 67513414:user:proton
X-Pm-Message-ID: 7c30d7fd214ca49b5c85e1a6d0580b7368f1b147
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

1. What did you do before the bug happened? (Steps to reproduce your issue)

when moving ruby classes between namespaces they are marked as new files an=
d the old
ones are marked as deleted

if i only change the class name it will mark it as renamed

2. What did you expect to happen? (Expected behavior)

in the namespace state i would expected it to be marked as moved since
nothing has fundementally changed

3. What happened instead? (Actual behavior)

the file was marked as new file and the old file was marked as deleted

What's different between what you expected and what actually happened

4. Anything else you want to add:

I have demonstrated the behavior here https://github.com/billybonks/git-ren=
ame

Mostly i would like to understand what is the expectation from gits point o=
f view in these mutations.
If this is considered something that can be improved i am happy to build ou=
t more test cases, and help with implementation.

if not, understanding the reasoning would be great

Thank you.



[System Info]
git version:
git version 2.47.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
uname: Darwin 25.3.0 Darwin Kernel Version 25.3.0: Wed Jan 28 20:51:28 PST =
2026; root:xnu-12377.91.3~2/RELEASE_ARM64_T6041 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


Sent with Proton Mail secure email.
