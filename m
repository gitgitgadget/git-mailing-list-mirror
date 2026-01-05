Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCC3C0C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767577686; cv=none; b=q+Cb7EgJ8G2jGgvfm/pesEEYjBbgjlVVpst5F8qjE7iILGVaMsNyFnNahEXNASWKO34UrXLgCGN1KlTGjznxsnm+w4ofQhY5RuKBexZCTBIlV6ir0pa/eRu5Exb3Dg+SMaGdJ9FQEF3oA/OUHrqg1/lByNUIzdTcqJ88+iHbATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767577686; c=relaxed/simple;
	bh=QNppf5aATpHuhhOKmAcVpGGoRBawXHAGtcsrJpSDYEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WM1oW14FczaG9t7eOOky3HAoAhclxjGr+evrZRDLZ83zDpPOpQSetJyPy0LE0tjLj5HDok0v+5n+01lC0Knq8ISOG6D0AozrVm6fDiN4aY5dtlpK62GNO8x+xbrS2xu8O9qyYrXzY1l148jFj8gVAp5aICv3lDnrVTNHFiYaNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k37Si50I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xo+z9azQ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k37Si50I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xo+z9azQ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 01CF71D0003E;
	Sun,  4 Jan 2026 20:47:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 04 Jan 2026 20:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767577672; x=1767664072; bh=osZE9NDmIS
	KthXlvnIfTPMjL2ScDxyfcMomxrEpeXJ8=; b=k37Si50IRRp1lzyxnghck44tqW
	fv5EDdpisgRCRBxc6KtPEcWk7t8MEiQtCc7hEe+PwQCQmTrtmlE6+3Gt13iTAfNa
	Hkc3NNfWDKq+8LASHYKCW2CEPv+UXONMiNqbyUbwQN/ziXNH1PmdsKmVeRIeRpZo
	namEuHsq6722wlvs1UDDT2dZFE0PnjPmrMK69XK5Ep4wPxLrHka5B0jqr0tBDahV
	jWvmzJFnZZpUOPbD24j9UtDp7op+0EtJel9MYeNjntsVjAMtfFM7q7nwDuL6dRxB
	WwzGGWPuiWTz3z6E9SQEtPYNbScSObOfn21yPPswKLOoNtF748vebQmXNQrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767577672; x=1767664072; bh=osZE9NDmISKthXlvnIfTPMjL2ScDxyfcMom
	xrEpeXJ8=; b=Xo+z9azQ0HL7LRp7t244GJr1oV0nypt81oTUJ7ayzR7qyiNFYmW
	OhCeGHdIQEleQz9u9kdTs3tbZX7aajmqecH4dPY7cWYryKcF43HbncsqqvSO2ApS
	qHX34LiniseTuaD1p4jKDAfEN6ZZIzRHB+9a/erd1UH4XNpF6KdBbR5C2YhlghXv
	oZWfCve54SddnKp1RuBXpLQLkb+ZtsSdpyOmetKm/tpBPWPGJsOoMDl4VM8IVf6J
	MmHKJvJut6JTuiKI5QzzTSLl9hPy8ctn2C9yEOLSEEyzY/Xlk3wuZM86sLKu+IRt
	G92bXv/voWkGDoQ/nVuZlnKX51bBsV8kNFA==
X-ME-Sender: <xms:SBhbaR7laV77cnsyy8OJ4DKcSCwiTzzu6EFjB0dmc0KPwXEVT-JjIQ>
    <xme:SBhbaWV5aUT3mYw-PByROHfZ6_IKYYmgrq_kQ3vR7hwTWUjzMfLQsfAaUORChhKk3
    4JmnlY0rSozJKeTQosdjy9vz4EivnbBHAzpFOnWOY48a5qArTaqzw>
X-ME-Received: <xmr:SBhbaV12k5fctN3LDAtNmDa6FBzIAtMXTIv2mho4wLT1LZ4YaR1CZkj-LWaIcvc12Wf5Z4ntE2HPpu_sNcgHTxyB2Xgkh09UzZ7PwIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeliedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtshgrhhhirdgvlhhkrgihrghmsehprhhothhonhhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SBhbaT13p7JFootenDRviWnn0522jLWHVGq1G09GpSH-Tvmk4cN6_A>
    <xmx:SBhbaY8ODMObtocCtR4bFjEeTqjrxNl5OwDoPgkdT73h03frxsU3ag>
    <xmx:SBhbaQ0unFnqG_VrpMj7yENu0eNS8QhuQ4akb2YomCof2FnCsirMhA>
    <xmx:SBhbaV9TrqDYklq9nZ1MSnwo-H3vXsDik3mDGaRE3CsuECDb_4awqQ>
    <xmx:SBhbaa-Axc3c7YFElZYy8Uv9xS2rm4xKXLHI8pQZmY_FDVCs3UX3_UMP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 20:47:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] builtin/stash: data loss from reset --hard
In-Reply-To: <-98ze4v1cX5P2d_tlWY6nBZuQhY3J7OJLJX51VS53bVhirt-Gm9zA6E_Y-pNMMYhtcLN2MM_miuPfR_Nrq5JCUWDgI_BwG9rUxtuBoqf8h0=@protonmail.com>
	(Tsahi Elkayam's message of "Sun, 04 Jan 2026 11:05:01 +0000")
References: <-98ze4v1cX5P2d_tlWY6nBZuQhY3J7OJLJX51VS53bVhirt-Gm9zA6E_Y-pNMMYhtcLN2MM_miuPfR_Nrq5JCUWDgI_BwG9rUxtuBoqf8h0=@protonmail.com>
Date: Mon, 05 Jan 2026 10:47:50 +0900
Message-ID: <xmqqms2sn83d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tsahi Elkayam <Tsahi.Elkayam@protonmail.com> writes:

> Hi,
>
> I am a beginner C developer exploring the Git codebase and came across
> something I would like to understand better.
>
> In builtin/stash.c line 1747, there is a comment:
>
>     /* BUG: this nukes untracked files in the way */
>     strvec_pushl(&cp.args, "reset", "--hard", "-q",
>                  "--no-recurse-submodules", NULL);
>
> Steps to reproduce:
>
>     $ git init test && cd test
>     $ echo "tracked" > foo && git add foo && git commit -m "init"
>     $ git rm foo
>     $ mkdir foo && echo "precious" > foo/file
>     $ git stash
>     $ cat foo/file
>     cat: foo/file: Not a directory   # precious data is lost

As far as I can see, everything I see in the above is working as
intended.  "stash" is a way to get rid of your work in progress and
take you back to the pristine state quickly (after all, it is
"panic!  the boss is here and tells me to work on something else,
clear the desk real quick now" option), so after "git stash",
whatever change you made relative to the pristine state (that is, a
regular file 'foo' exists and has "tracked" in it) should go away,
if it gets in a way in order to get us back to the pristine state.

After the above sequence, if you "git stash pop", it should get you
back to the state immediately before you did "git stash [push]", but
depending on what you did between push and pop, it is possible that
the changes conflict and "stash pop" may fail without popping the
stash entry.  This is to allow you to attempt to pop it again later
after cleaning up the mess (like, perhaps going back to the state
before you did "stash push" on a new branch).  The point to note
here is that the "push" operation cannot afford to fail at the
"panic!  the boss is here" moment, but at the "stash pop" stage, aka
"the crisis is over, now let's get back to where we were", the user
can afford to see a failure and spend time on conflict resolution.

Another thing to note is that the new foo/file in the above example
is not tracked, and IIUC, "git stash" by default will not save
random untracked cruft found in the working tree.  I wasn't heavily
involved in the design of this optional feature of saving away the
untracked cruft ("git stash push -u"), so I do not offhand know if
the contents of foo/file is saved away correctly in the above
sequence of yours if you changed your "git stash" to "git stash
[push] -u", or if it is recovered when you later say "git stash pop"
(and if it doesn't, then you have found a bug there).  But it does
not change the fact that the "cat" in the above sequence immediately
after "git stash [push]" with or without "-u" should notice that
foo/file is now gone, once you got back to the pristine state.

I do not know what "BUG:" comment refers to in the above.  Without
"-u", getting rid of untracked files that get in the way of going
back to the pristine state is absolutely the right thing to do, so
there is no bug there.  It is possible that it is done way too early
even when "-u" is given, making it impossible to save away such an
untracked files that are in the way, but I didn't check.

