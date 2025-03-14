Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056432040B4
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973271; cv=none; b=d2FYJdUJ6qp/0BIkQ7fNkrIaVTcOyEq1CczqR037I0u7Q4wF4UkTz4eKfch7xGakpdz9Gna9NILjDZBcx1pKXnuROKF3hMxQA1tuirjF0abHT3wd6Pp1y8f/oEs0bhwyj4IJA7OOyMzDxWcmCT5bqYBiVxQjN3uiBPQNDk8h17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973271; c=relaxed/simple;
	bh=S5/ZCChOfo/WvbBUggm4ZLzEDO34Ykbo0DqBNoHaUVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hDK4ihvu1bC6BtEEzCDcbAhdEe5eT1/hizS2u8wIPnxlixkwLQyn58wJNn5bepMgb3QJITmPFjhIyhuaMPaTntqK3x2rlX7Uz09O/BuAeK8MPqsd8cAHD8Pwol/BvOTXPrDmqx1vj+elOOpPQ8pRMKtnUT5KX4FRyxZs01EbIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmoLgXVf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASMhVQoX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmoLgXVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASMhVQoX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 079EE1382DA3;
	Fri, 14 Mar 2025 13:27:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Mar 2025 13:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741973269; x=1742059669; bh=swhOYFdbFJ
	S1/Rc8aR8EHxZcVZY2kpGcEMjWW1sKYgs=; b=HmoLgXVfvb0xWmn67wkQxgmGue
	GiaFMrm70XePoTb98J2mvmohDm7hWN9x8zXKsx7xGaKwbQlJp9tbNYTTFmupDrlG
	Y7tWOEH/9kKAjhMoVQ0H3YaCsxp+avSRgxtrAAzwWP+id7OD3oCbhO6RLzWgzBQK
	M/XYZl1gZW0QjLDT42SrfL5rATpVRDXTZrF7hDFKEZAd8pNc9bWtaV25XkBPP/5E
	UXop9LPEc/yIFRH1KrHUr56bR1Bjr5kk+vn2o1B2BmzDPzfrOL7XIjco0CxOasWf
	8yy7wI4IRnzStzCcmsHQq6ndlcwJbNIO/4FpBqmmF2vCt6Ofp1TCFS4iP2Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741973269; x=1742059669; bh=swhOYFdbFJS1/Rc8aR8EHxZcVZY2kpGcEMj
	WW1sKYgs=; b=ASMhVQoX2CA6YUzhmfwnWKKez8Albd6zYnHAA7gKMIuRKuyiqht
	PTZOvV/PDYEJ0yGT1EMivgA2SINv62T0ln4xm4W96kfOMXgcVMDD7Y71dqp3QExe
	cE8YuLjlDJ4Tpzd1gy5QQqJguUXWiDWPOBGzu6AuUcZ1mXQ4G/GvQ6/bhcaa6grk
	MAs6rjN2aWMotioESj0W/8BMN3ny68XzVoybfY7cSSTJ7o20bzNp0TZcIFlnHwqk
	sj/JpesBvxs7NRXGvgvCsO69kF87GeV9n0cf0EWF4HKDvOMiE2Y3at6MuXeLWohA
	LZ3GvaLLWVYqfIYCKOY8HyQwSBoCwGb1nfw==
X-ME-Sender: <xms:FGfUZ8iofgPJ4buvUKVN3sWKPEPgmMM4k6da1ab_gi93P_W9M0aKXg>
    <xme:FGfUZ1Cp55jgICNxa1ZDY-vQyu_p-L6ysGmuk9HsvbR63MkOTr16pHeqhf605JF7S
    FRO2dwp4jxfJJ192g>
X-ME-Received: <xmr:FGfUZ0FP4anCfrWr7_JSW2iQnOJ3MJ-sHfmTYI8WcME9VoMftziWMcR8ZnLJ-pONSqTuUPiRmUSqH7ajrsId_xFIavniNL_6vmbnTno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddt
    jefftdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:FGfUZ9SQ8nQSDCoxwcDHVw4-3MSI86DKvhw0j0quMp8m0QHRB6-4-Q>
    <xmx:FGfUZ5zmGVEAt7C1Ke5SLcyLwiTLRua0CxoM893-mUkE8GHAVZRI7w>
    <xmx:FGfUZ7707S2elbm8MrhgkUxm40j-x7lgVblPK2aTXPiFLQCQBgmC2A>
    <xmx:FGfUZ2x6-S2MKojFNrOej2ujBfe4XqXv4w0nxo2kIomt1KGXLV73bQ>
    <xmx:FWfUZ4wnzkxNr03zDXGOFzzbCqhrGfiLgT8K3hKl4zKlRAFaW5DB_PTG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:27:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250314161347.GA9440@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2025 12:13:47 -0400")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
	<xmqqfrjkao75.fsf@gitster.g>
	<20250310160440.GA26189@coredump.intra.peff.net>
	<xmqqsenk7mab.fsf@gitster.g>
	<20250314161010.GA8522@coredump.intra.peff.net>
	<20250314161347.GA9440@coredump.intra.peff.net>
Date: Fri, 14 Mar 2025 10:27:47 -0700
Message-ID: <xmqqv7sbh698.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> -- >8 --
> Subject: [PATCH] run-command: use errno to check for sigfillset() error
>
> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
> complaining that the die_errno() call in:
>
>   if (sigfillset(&all))
> 	die_errno("sigfillset");
>
> is unreachable. On that platform the manpage documents that sigfillset()
> always returns success, and presumably the implementation is a macro or
> inline function that does so in a way that is transparent to the
> compiler.

Would it work to instead do this here

	if (sigfillset(&all) || false_but_compiler_does_not_know_it)
		die_error("sigfillset");

with

	extern int false_but_compiler_does_not_know_it;

in <git-compat-util.h>?  And a standalone .c file with its
definition

	#include <git-compat-util.h>
	int false_but_compiler_does_not_know_it;

and nothing else, linked into libgit.a?

I am hoping that such a false-positive would come from conditionals
that are known to be compiler to be always taken (or never taken),
so eventually we can mark such an expression with a macro, e.g.

	if (CAN_BE_TAKEN(sigfilllset(&all))
		die_error("sigfillset");

Because in this particular case we _can_ rely on errno, so the patch
we see here is perfectly fine by me, but a more generic approach
like the above would make it unnecessary to

 - have a 4-line comment
 - come up with workaround

suitable for each such places we need to work around compiler
smarta^hness.

> But we should continue to check on other platforms, since POSIX says it
> may return an error.
>
> We could solve this with a compile-time knob to split the two cases
> (assuming success on macOS and checking for the error elsewhere). But we
> can also work around it more directly by relying on errno to check the
> outcome (since POSIX dictates that errno will be set on error). And that
> works around the compiler's cleverness, since it doesn't know the
> semantics of errno (though I suppose if sigfillset() is simple enough,
> it could perhaps realize that no writes to errno are possible; however
> this does seem to work in practice).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  run-command.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 402138b8b5..d527c46175 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -515,7 +515,15 @@ static void atfork_prepare(struct atfork_state *as)
>  {
>  	sigset_t all;
>  
> -	if (sigfillset(&all))
> +	/*
> +	 * Do not use the return value of sigfillset(). It is transparently 0
> +	 * on some platforms, meaning a clever compiler may complain that
> +	 * the conditional body is dead code. Instead, check for error via
> +	 * errno, which outsmarts the compiler.
> +	 */
> +	errno = 0;
> +	sigfillset(&all);
> +	if (errno)
>  		die_errno("sigfillset");
>  #ifdef NO_PTHREADS
>  	if (sigprocmask(SIG_SETMASK, &all, &as->old))
