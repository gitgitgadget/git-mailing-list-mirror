Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACA194C6A
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963505; cv=none; b=NjPmqLlYKyKIVNl1b5OMB7RIgrAATiUnDVl+JIheDmPt081b/fe/J4wWHiNVKR+bBpnMiWlZbAlkI+D/RL2i5B+dBSTtRqktiezxTQDW+HRz3NvPBjZqsZJkoxxJy61afrIJhRMh66mcx5MXu0IhzAtcl9RPATyIrdQG2CCOhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963505; c=relaxed/simple;
	bh=gjo888hJgYtFy8OQc99dqG1L1dhCTq91uQUTbFEIXos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPmO+vnQ70aTtMzg5DDmrgxAvTnCqawRmTNXKeoJbSm/QLWpPSDY2jhMLsVgHaZk/T5R5EHvMFSqFI5N3CMheaHktavsHx3Iuby/gztEI1o4i+vDhdiL2+4uJUQtzDjsPzJn3dGLHSWqLUv1suxDvPENrlki89R1zobbiDDfwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SZr7ovTC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yM4DlKZQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SZr7ovTC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yM4DlKZQ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D0AE114010B;
	Fri,  7 Feb 2025 16:25:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 07 Feb 2025 16:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738963501; x=1739049901; bh=YRn2NwDsPq
	PwBJhoJ1i3ifb393xPP6OQKgJKoetzhWQ=; b=SZr7ovTClOyqGFgbCiAbvpRdKb
	VvKdfVjAmpkiXZoi7IsFmLMpbKrJBb1Z6mLECXfh3kl4YQvESS4taQDeEXdt4Nck
	Hpv7iaPFPEcKaIGA2BiVYJsQApbzR2VUu3TPUACuDcZ4oAveKXrAOy4E0SCnqBHF
	ShU5/otTRjmkfxOX1PlCuXmcS9EOL7bqsqzyUtiVD2jMCK5JQOyjnmEzkdHgwsUm
	Di3yrfBGoPD1n600SpgtGDNtZor5G1XT4nvR8y0UU+rVcaCYXsqo+dKeRm5xX2RT
	dX2dV4tbFdjUgLMqRUEn/BFw1dT+bpww6z63JdA07S58jczyGEig+AVsUaPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738963501; x=1739049901; bh=YRn2NwDsPqPwBJhoJ1i3ifb393xPP6OQKgJ
	KoetzhWQ=; b=yM4DlKZQcSGJT7QMV06KDlVEv9vILsK7EEOAzezUn+BmWcFiiu8
	C+L0ypBIXtXfb6V3FRfHeDsBCVbIGrQiM8ruwdkvtMzAsxmJmWiiylMWMqdLUOE9
	lmJWOlYfPheMBiEIjd/ySsDD5kaChcqGHzYry1JICIJ8HCOzC/wyRALHvns4+jxr
	Mcxoh/nZhqvRN+we5XlciihGeK3oRCvsrR12PCka7CoElendIZKxZ140+UuewOLg
	nWvUe7vir4fS0XM3Lh6X/UEibxULQ9IBp+vlvDBsVEThs9tLXpeMPIDAjLk94aJj
	TRC4TkArfDtj9nkJtsdGAUXHGI4q0W00RhQ==
X-ME-Sender: <xms:LHqmZw68sM_l6p20wKmqYblmvqLU9GgVpi_MfnCKc99C_tz4JbC4dQ>
    <xme:LHqmZx7CEgAuMNITcW6Ms0D2-M5DD2-27ZK9WKA-VFUXTxd8-9qyp8RUpfuGTL_qi
    B0lya_9rPFKtXfUVg>
X-ME-Received: <xmr:LHqmZ_fya9Eq7JQ3b0vJSg81ZTPtKvSPDXdXOrpgRx1VOLINPFFZ213f-3BhO3E_4YeXmYHzVWGeuOrV-N5cPHY_a-MCQ05Hd5n0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghnrdgsvghrgh
    gvshesuhhnihdqsghrvghmvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LHqmZ1LJ15mHVpSaW-Natif2QnObfHzRtBVe33iW5nf1XPhJCJ0Yjg>
    <xmx:LHqmZ0IonE-RYENn4kep9jD35eEXaFcgmp37_9DVzXdZykI7NxaUSQ>
    <xmx:LHqmZ2wMZwv3eugBK97eDg1kRCayke2hscAPGH8XJ2jxSpEygSA9eQ>
    <xmx:LHqmZ4LjNv4pn9hGDQbCiCz7xk9tNgZ--85OMn4wGX97WKpgGIHDJQ>
    <xmx:LXqmZ40TRD7E3hHBF3FFZSXtE-QilXEG0dgmtXwFeSI_V9bsbpruMabf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 16:25:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jan Berges <jan.berges@uni-bremen.de>
Cc: git@vger.kernel.org
Subject: Re: git clean -Xdf affects parent and sibling directories
In-Reply-To: <7d2cf91f-c4ac-41de-966d-3681ac549ef0@uni-bremen.de> (Jan
	Berges's message of "Fri, 7 Feb 2025 21:14:35 +0100")
References: <7d2cf91f-c4ac-41de-966d-3681ac549ef0@uni-bremen.de>
Date: Fri, 07 Feb 2025 13:24:58 -0800
Message-ID: <xmqq4j15fnx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Berges <jan.berges@uni-bremen.de> writes:

> Run git clean -Xdf in a subdirectory of a directory ignored by Git.
>
> What did you expect to happen? (Expected behavior)
> All contents of this subdirectory are removed. From the man page:
> "Cleans the working tree [...], starting from the current directory"
>
> What happened instead? (Actual behavior)
> Ignored contents of parent and sibling directories are also removed.

Interesting observation.

Behind Git as a whole, there is a philosophy to track the entire
working tree as a single unit, so touching a file at the top-level
or in one subdirectory, going into a different subdirectory and
running "git status" and "git diff" would show changes, in line with
the spirit of tracking the whole tree as a single unit, made to that
file outside your current directory.  Of course, if you add changes
to a file at the top-level or a subdirectory, chdir to a different
subdirectory, touch some other files there, and say "git commit -a",
these changes outside your current directory would also be recorded.

The behaviour comes from the same principle.

I think "git grep" is a notable oddball.  Its UI is build around the
guess that end users would expect a similarity with vanilla "grep"
run with the "-r" option, so it only looks at the current directory
or below.

In hindsight, some may argue that "git clean" should also be an
exception, but I doubt that would have been a good UI even back
then, forcing end-users to remember which ones are always full-tree
operation and which ones are current-directory-and-below.

To limit the extent of potential damage, I'd always do a dry run
with "git clean -n" first, giving other arguments I intend to give
for the real run, and then swap "-n" with "-f".  The command should
take the usual pathspec, so "git clean ." should work as expected.

HTH.


