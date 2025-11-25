Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30636D501
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764108242; cv=none; b=WhWKVVpn6lDovXqMfKilo4YJ6ZMnhUxNfaq56uiPjtGauGmuF8EJRLexKhKhJdB5VYGvuS/wyQAn6oAXEns32XFX7QWOEE7bUKFV6Dlt30mVZmFMMUo44bmlcTHSwh9cNoJemrwDCoGKLx2u+q6NwMR+p5rWiOVjF7GmS4RoM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764108242; c=relaxed/simple;
	bh=AARwL/JbIV9St1UM+4+pJY0Hn/iluggrrjNh90FBT2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iacuEgGzY+w6st1OVcZCtEtCL2pHwUv64FWIjmwda135xLmQ1mErhcwKt5JlY9EV0oz5XbaXkuyFmvRQiVOa5vs6wDD6nK6nOtZ73q1V9BYnS/ukdipjdzvx1thHA+Y6szAPirVHCUFnsBD1xDf7W+Vjqf5w4BSOJyRcC5c5MYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dY6tK32P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q9Gew7Jh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dY6tK32P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9Gew7Jh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C125DEC03C1;
	Tue, 25 Nov 2025 17:03:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 17:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764108238; x=1764194638; bh=TygcSeZ9Pj
	em7W1AgVRF0B2SIFZFfI+mpTBCj3mQ3Ac=; b=dY6tK32PKXEjDSR2x8u8Gjiu5j
	4aSOPToW9X52Yn7jjvfLFSVYxqBlLCEzSWbneEU5IOR5Buk00vL+rfpFklc8l6iA
	6FaVOG1znGtVxtdgOfcvmNAinlevofCJTRNjnQocKCoVSUkQdi0nsKVCSIQIaE30
	Q1vaeYOSF1euSH1R40ZqLkDuhoaoksWnLyga8VyJlDbUyrElrxfBf/8yePnGJVI9
	jUbDPK4xTLser+zjDLOLPya1cW4TBKoFcgxMsgGaR6D2M3jo3XH3atkQAnxUSbDZ
	z2PRTRC1z+MSTjwhnnR8TCS8INnfYR9fauCOelGEzHrSxOkGshZ1kGjBtrCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764108238; x=1764194638; bh=TygcSeZ9Pjem7W1AgVRF0B2SIFZFfI+mpTB
	Cj3mQ3Ac=; b=q9Gew7Jh+XuciwXDmKUS8IiVxPXVAFbBJkjn6NdLcMFBORVfKCW
	lbcf9TARxFDpUyFHFI5tVr8lcnqMHuxWJOiHmu4laeRKnYlI4zQZl+NWohR5pFTr
	ZITrTEWT+6wrxH70fddcdK4TfwwyjutZC0K3Dlyr6BGtdrePFK7XHn7HJSA5eP5T
	8Y7Et/zLH2hgpXR7pON3XG+akAwH65TNmkCq8tyJgT9u3K5DyvSAI0ww+1q0lwCG
	hIqRB8ImmA5tHIBFyNDKZKSiQjA43Kg2yK5WtwM/VmdHplpAtcKjQmJFYHf2FopU
	znA8or3QqvBbzmmkIp51ZlB39ZBl+uuTovQ==
X-ME-Sender: <xms:zicmabevFCkzEzdTZNVNbCMk_yv2xrYIaUrfIDgJQPFsYgCQwYb6rA>
    <xme:zicmaU580rlPMRwiDi2afKZXLtPAouEU2XqUx8FTe1bFKrGFS5aPHiv-VGCyJtIWW
    CDX81HFxmvubIgJBMBSHUDH1wcpU22JJfUd-0NPvG9rOq7T271HGA>
X-ME-Received: <xmr:zicmaeVb-L43D8GYRcLmhqJEKv3sp_yzsuqMD6tYqcIDu5FXanNkHiuoW7pBwlAMN-09BfDIXo4F5PdmVg3uTrJu30b6pNVSOOvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieeigfffjeehteehkeetueeigeekjeevffdvtefhudekjeeuueegtedvvdel
    tedvnecuffhomhgrihhnpegtlhhonhgvrdgtfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprhgrnhdrrghrihhguhhrodhgihhtsehsrghmshgrrhgrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrggrrdhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zicmaT5OWKMHeXWxIr7JIcPgYdyqjs91JFwQc1Fyy0abcQcpgT2UXw>
    <xmx:zicmaZrTgi67EZS6mQjHJphUM7a1kIgktmL5gG4wL_2gW5muldLJnw>
    <xmx:zicmaWmT-IQMR_kMKK_IdRVi5uNClFcU7Mt0yuxStiDYxJ3ekBzn2Q>
    <xmx:zicmaVOQG_Mt-ohafMtsHK55ERM8srtgk9-7VPZmXMLvqR5MT2CbHQ>
    <xmx:zicmaWF_ISVbf5A-w1D-gum2j29pCqmXtgfSIhmweR7BMOqSJf6wunht>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 17:03:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Ran Ari-Gur
 <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  "raa.lkml@gmail.com"
 <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <xmqqo6oqucka.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Nov 2025 17:27:01 -0800")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	<xmqq8qfvw2lh.fsf@gitster.g>
	<20251124235530.GC2051672@coredump.intra.peff.net>
	<xmqqo6oqucka.fsf@gitster.g>
Date: Tue, 25 Nov 2025 14:03:56 -0800
Message-ID: <xmqq8qftrcqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The right right thing to do at this point may be to fix the
> regression and at the same time mark the "feature" as deprecated,
> and remove it following the usual deprecation procedure, but that
> certainly sounds like an unnecessary waste of engineering effort.
>
> So, I dunno.


The first step of the "right right thing" may look something like
this.  As this thread analyzed so far, this awkward lenience exists
only in "clone -c <key>=<value>" in that the keyname is trimmed, so
isolating the damage within the clone's code path would be the right
approach, if we want to keep this awkward lenience alive a little
bit longer.

This function receives the string_list that accumulated
the "-c<STRING>" and "--config <STRING>" command line parameters
(plus some internally generated ones related to submodules) and
feeds them one at a time to git_config_parse_parameter() that
expects the <key>=<value> pair to be fed.


 builtin/clone.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index c990f398ef..4ea8c92a6b 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -779,7 +779,26 @@ static void write_config(struct string_list *config)
 	int i;
 
 	for (i = 0; i < config->nr; i++) {
-		if (git_config_parse_parameter(config->items[i].string,
+		/*
+		 * NEEDSWORK: a backward compatibility wart that made
+		 * us tolerate (note the leading whitespace before
+		 * the variable name)
+		 *
+		 * $ git clone '-c foo.bar=baz'
+		 *
+		 * and treated as if the leading whitespace before the
+		 * variable name did not exist.  Apparently a third
+		 * party tool "Bamboo" relies on this past stupidity
+		 * of ours.
+		 *
+		 * Eventually we should deprecate and remove this.
+		 */
+		const char *trimleft = config->items[i].string;
+
+		while (*trimleft && isspace(*trimleft))
+			trimleft++;
+
+		if (git_config_parse_parameter(trimleft,
 					       write_one_config, NULL) < 0)
 			die(_("unable to write parameters to config file"));
 	}
