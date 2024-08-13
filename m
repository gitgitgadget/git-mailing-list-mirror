Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122E3BB47
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540697; cv=none; b=aIIRzONZuwVt40czgTThSe1NCAY5AMZzxmmgyApNJYfq1kPild4bqHQLdHPVeBf6ZOJ/HUYtRcB892dQbQBdCslfX5h9Hw3EXSazVB70kPw1rkf2CAlRFRgoh9C0qV30Cocn0/jDJqQYZ2O5n4V0gh4TvAWXmUjsU7l3iiCfy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540697; c=relaxed/simple;
	bh=EgZjAPw2+6a20yuUkyHJ7QfOJuXWrVj0GB0gwsZ5kWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5MZ0JTlMgrjFRiZAuOZ/ltEdwMeT3q/gScQ9sHcdBjnCJSF1C76ECUP7gqP8cz7bDbDU5VGbIAD165vTVV5X7L7WLpw1n0fD3TDicz0PF4BWMl4qwN/pPzVwns7ZsCs603rM7klUzmRMY0Hv936bKqlb5GqG/GhdSfNt4u9k4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EZaT4HSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gIrvZcZQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EZaT4HSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gIrvZcZQ"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0032F138FD66;
	Tue, 13 Aug 2024 05:18:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 05:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540694; x=1723627094; bh=fCwi7RoOIP
	T21okRL9Pi6RSwvpYBI4zpimZAAq+4cuo=; b=EZaT4HSBTmR6bCdMMWQyOjFpkW
	jedj59Smzrr3BMUsQmXR9G0QARaisKw8EQArhj97oD8fhtcVg0/6APpojGHznNC1
	Kb0g3s/ffOgRU6sP00ORfFlrIImAsTBdTIL/+frz5r34/VJsw+Tx406nqIuGMJCj
	/Di2zORyKMhHgAgdfOKFg8aJ+E6+0vsFJnAth71qNFFNLlGfqPIK7zt1Vxx+aCYG
	tVxbVSDvf0KCop8pKSpg9nl3gM6FCR/RxKNtfzfQYd1CxADiUQBuGd+yKxDZijV+
	eIY42OkRkkGEK6F4SzdP99PzFHDe7IJR0oZ12ppMW3KXmruY3xDZvTSYv6xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540694; x=1723627094; bh=fCwi7RoOIPT21okRL9Pi6RSwvpYB
	I4zpimZAAq+4cuo=; b=gIrvZcZQoociXvjhnueR0Z7taMYIL+Za5YJR8qDhMfcA
	GsPacqT93a0nehRN4k1sx4lmU38lu8NvHCjYBVFpsMO2BfGT+ZNXkCQM2Y4Mvsj8
	X+F3diEDlY06jTN6nEVhihmv2UNd4ne1NfAsYmhFq6gpyXj0Zk4TF4kdplzxIroa
	LlW7JbXoj40HzVHDNt+dEJeF/rRdvAgZwBjg16jsq86l67LiLKP+dzHA+lFYdi35
	Z9TKwlO8jdwaxed7jaN26YyFkGLLOa2/cosB6LI56kHXTGki8U1p9pB/7a4v4dso
	AUfAwthAJvxqW2cK01JcVF/HsCGLDt4otQjVQ0ri1w==
X-ME-Sender: <xms:1iS7ZkBYaNvp7RPE7KzLpuyX4jq-zGSATWHTMTgH431VgfqTWKYiMg>
    <xme:1iS7ZmgvrU3_MVSSjFVNJsIGoo4xAQPP_5KS4D0isfJWVnkLhLFuISu16NfhRbX5g
    72OqWJNeRgysoRQBQ>
X-ME-Received: <xmr:1iS7Znn3lIbAIfFbtRjzlHbW-oWS2WnqgtWERg648-x1rTeP4CdqpA8vXwYc9WK_NzbyxiO0Mv5BtveB2ZiyW6ULWXTSb4K1rhsmazNzZfBmrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrrhgtth
    hitghlrghmphihrhhiugesohhuthhlohhokhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1iS7ZqyAM3o0Ch4a1RhUYgj2gmIt5KdMYiTyt9RLRJwzUD2b8B2SXA>
    <xmx:1iS7ZpQVXFD57Vqu0mcY0rwNzvvYeURqTAV30dl4-fTni18NrSWPVQ>
    <xmx:1iS7ZlbE7q9jg4s_y6850-uSfcCW8vBrUrpcK7bbge1ShJMHNoA6aA>
    <xmx:1iS7ZiRu9HLIcwq_smnSlBdf9a9RKMCeAG5iexNwVPxcrGb5ajWlWA>
    <xmx:1iS7ZiLSnvtWQq0LRYUJaZ5y1xSMP56qBrsu8vEBH8AoLm5qm2n5Z2ic>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:18:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17317de9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:17:57 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:18:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: ArcticLampyrid <ArcticLampyrid@outlook.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] builtin/bundle: have unbundle check for repo before
 opening its bundle
Message-ID: <c57e1cca4c7d2a0f52ae8d4e0870e4e0667184fe.1723540604.git.ps@pks.im>
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
 <cover.1723540604.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540604.git.ps@pks.im>

The `git bundle unbundle` subcommand requires a repository to unbundle
the contents into. As thus, the subcommand checks whether we have a
startup repository in the first place, and if not it dies.

This check happens after we have already opened the bundle though. This
causes a segfault when running outside of a repository starting with
c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07) because we have no hash function set up, but we do try to
parse refs advertised by the bundle's header.

The next commit will fix that underlying issue by defaulting to the SHA1
object format for bundles, which will also the described segfault here.
But as we know that we will die anyway, we can do better than that and
avoid some vain work by moving the check for a repository before we try
to open the bundle.

Reported-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c       | 5 +++--
 t/t6020-bundle-misc.sh | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index d5d41a8f67..86d0ed7049 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -207,12 +207,13 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 			builtin_bundle_unbundle_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
+	if (!startup_info->have_repository)
+		die(_("Need a repository to unbundle."));
+
 	if ((bundle_fd = open_bundle(bundle_file, &header, NULL)) < 0) {
 		ret = 1;
 		goto cleanup;
 	}
-	if (!startup_info->have_repository)
-		die(_("Need a repository to unbundle."));
 	if (progress)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index fe75a06572..703434b472 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -652,4 +652,11 @@ test_expect_success 'send a bundle to standard output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unbundle outside of a repository' '
+	git bundle create some.bundle HEAD &&
+	echo "fatal: Need a repository to unbundle." >expect &&
+	nongit test_must_fail git bundle unbundle "$(pwd)/some.bundle" 2>err &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0.46.g406f326d27.dirty

