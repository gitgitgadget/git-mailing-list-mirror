Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8954645
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795615; cv=none; b=szpC/D3whf0TWObcNE4jzZESXZFKU7uCZlm0lelmfXkW4KJ/9LhJxhlkpdJA9k9fOxN4a3ptWHqBBC6wjj9NF4s6a1jUOhdCPF/T/RHCyt1pDfSaJSBaejPYODc3qE+hi2+PCXRVoWPyNplEkPwARmQqEB1mjon+UDw3vO1tSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795615; c=relaxed/simple;
	bh=eHvVjR8iewFCrlHI8o+n+x7fs35Ur2z4Fd0Fof1Dla8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy8yU5/Jb7aXo0X4nWhsFQxS1ByDSGsEZoUa4bMm+EUy6/eJW1T8PODEl4Wr32EFEH68DyGK/Fg4p70Cnk1yToAbZ3qwwXp6QVXNG53f0T3KPOwuGblD9S/WG8NzHfqiNmADIU6dOnUcV6Jz5893u3bMuggkzDuZwqyaTTFEgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A1BtyQ+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmayNrI9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A1BtyQ+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmayNrI9"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 72E84138FF72;
	Fri, 16 Aug 2024 04:06:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723795612; x=1723882012; bh=c1BOvr8B13
	Q9OJVAN+J8Btww1PLZ93fNFdqovQkmQUM=; b=A1BtyQ+w9QY+uL/qzVlg40SCy/
	7+0Nb18F4HFNKeZBEvEidBlw3Emlk4bQInzfqDS+vw6+aSl0HWzvY+eUjyXkjhB2
	5TOPs3KyDAvt0NUfw6ASAquLTD9dgyuza8T3009q0OiAE8YvXHOFc6yzq7EA8K2e
	b690Fp4ny0lB9NPMgOQ8RZg36mr7o+3TS7MUZFFv1Tnp7Ufgu/0Gc3xG/JhIAVnx
	u+nC5F3Vr38iFQXIwcVx9eJjwxkRuJ91RNsqj6BQ2QXuoEllj7/xlIKfnUt74Aj7
	1OBEM25ej60lk3Vz0nINTtc23MW1HNEZXzOr/OT4ap3b4pJTmSESJWwpZ8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723795612; x=1723882012; bh=c1BOvr8B13Q9OJVAN+J8Btww1PLZ
	93fNFdqovQkmQUM=; b=RmayNrI9QDzEloLYgt3U+ymWOhk6+ryGZhyDyQvCtJDU
	lhnqwS7CpftmltUolZTwG3b/T1sVjULBXtfJ8d8Oh2NyfvjvHSUL3Aqkl6BRaxOJ
	LcH3VpX/ESLBzbHZcbElNnD9ZbMLGaDuI10QBN4gso+z1laQ2jpFwEauVdkeOci3
	G9Csy2Rm7QVUQSQDPxzeek55nj5BF/xWSKkm2umSWoGeYdZtvYLsae+XlrhjKNU9
	PGTGxn5JF+yySwkb/par7uYUsFXjmdfrrreSnXsuSMD2cYstwZFjVqMEXOv20CKO
	mc61o6elJT9FlnvcydsG8yx1JWJ0YY+e1WIrv/tc/g==
X-ME-Sender: <xms:mwi_Zlka1GFZpL-w0UdrvuxCvkRKWyD0EjNrUiqraniO2zSdlqqMGg>
    <xme:mwi_Zg1K_fZxaMunu5jXBktnmMixjqraXQPEN2Xn447FY0FlsKeeslicGwWk1MrsC
    In3USL8YH0wpN4lgw>
X-ME-Received: <xmr:mwi_ZrqNvDsn9NLsRsc14EH3vaYIFyeU2qxHMVOzJDwdfASkZ2BZvgolzjxCz9WUWPZzBvs-Y-IZlGoKA7gQz0e5JtkUcj9a80K9LM1nRwLZ-X4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhl
    ihhurdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mwi_Zlng-A68N-JpdSEynJnEucC8-1G0Wse0RUihmv6GLgqujxJ4Eg>
    <xmx:mwi_Zj1A1zXDukZNPHYuLoR_L9djM1_6_7LBr1pZey36Y6IW7cL9Vw>
    <xmx:mwi_ZkvEf--Thpv4seqyYNgGYzLzSemWCJZwDLrgmOcHzcYZafC8TQ>
    <xmx:mwi_ZnWHgzVj1Wgr_7ZP7SW6Ae9Qbdojei5JL3MDntYVRCWHDVNF_A>
    <xmx:nAi_Zj-y-pg5TMECz8SxA3EEi13zJMJS6KLMoLg5zFDE_p_TsdRZElCb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:06:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1cea0638 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:06:27 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:06:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 5/7] builtin/gc: add a `--detach` flag
Message-ID: <Zr8ImP6knHO6-ZBb@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
 <ca78d3dc7c0270b434ee4ca4ef618212c7dc1d5b.1723712608.git.ps@pks.im>
 <xmqq34n5txcj.fsf@gitster.g>
 <xmqqttflqv27.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttflqv27.fsf@gitster.g>

On Thu, Aug 15, 2024 at 03:29:20PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> +test_expect_success '--detach overrides gc.autoDetach=false' '
> >> +	test_when_finished "rm -rf repo" &&
> >> +	git init repo &&
> >> +	(
> >> +		cd repo &&
> >> +
> >> +		# Prepare the repository such that git-gc(1) ends up repacking.
> >> +		test_commit "$(test_oid blob17_1)" &&
> >> +		test_commit "$(test_oid blob17_2)" &&
> >> +		git config gc.autodetach false &&
> >> +		git config gc.auto 2 &&
> >> +
> >> +		cat >expect <<-EOF &&
> >> +		Auto packing the repository in background for optimum performance.
> >> +		See "git help gc" for manual housekeeping.
> >> +		EOF
> >> +		GIT_PROGRESS_DELAY=0 git gc --auto --detach 2>actual &&
> >> +		test_cmp expect actual
> >> +	)
> >> +'
> >
> > If the gc/maintenance is going to background itself, it is possible
> > that it still is running, possibly with files under repo/.git/ open
> > and the process running in repo directory, when the test_when_finished
> > clean-up trap goes in effect?
> >
> > I am wondering where this comes from:
> >
> >   https://github.com/git/git/actions/runs/10408467351/job/28825980833#step:6:2000
> >
> > where "rm -rf repo" dies with an unusual
> >
> >   rm: can't remove 'repo/.git': Directory not empty
> >
> > and my theory is that after "rm -rf" _thinks_ it removed everything
> > underneath, before it attempts to rmdir("repo/.git"), the repack
> > process in the background has created a new pack, and "rm -rf" does
> > not go back and try to create such a new cruft.
> >
> > The most robust way to work around such a "race" is to wait for the
> > backgrounded process before cleaning up, or after seeing that the
> > message we use as a signal that the "gc" has backgrounded itself,
> > kill that backgrounded process before exiting the test and causing
> > the clean-up to trigger.
> 
> There already is a clue left by those who worked on this test the
> last time at the end of the script.  It says:
> 
>     # DO NOT leave a detached auto gc process running near the end of the
>     # test script: it can run long enough in the background to racily
>     # interfere with the cleanup in 'test_done'.
> 
> immediately before "test_done".
> 
> In the meantime, I am wondering something simple and silly like the
> attached is sufficient.  The idea is that we expect the "oops we
> couldn't clean" code not to trigger most of the time, but if it
> does, we just wait (with back off) a bit and retry.

Ah, indeed, that is a problem. We already have a better tool to fix this
with `run_and_wait_for_auto_gc()`. It creates a separate file descriptor
and waits for it to close via some shell trickery, which will only
happen once the child process of git-gc(1) has exited.

Will fix, thanks!

Patrick
