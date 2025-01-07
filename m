Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5B1DFE29
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239672; cv=none; b=QJrx8eWxw7hyfYjCl4od3pz/2YnlaMhbhN/MAzhJi1riNI9MmH63DgovlUUnZ1vcW6RH6XHC5NBjWBzVomtSxFtAEgqke5qRhMq8BPCjH+5H6nU7PPNZ1ogUpOb+9TxqhVeUbaodxiNU1JBqcn/2Dz5SZZjnSOCW5OTtCmswAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239672; c=relaxed/simple;
	bh=uVfIrgAAXZ+BWlGFwLrMJMPNhX8+GflogNil0X2Rh+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmgKmBXh6l+QCX7VmJpojqChPVUlcxEN8ue7SsDod5axTHrbUkAp2zycqhX3hxfXtiyxSk/k6UEv6Yk0okzBcs75z6SRSldLAXgCSheWD08eu3+BBYuoA5sUbswnHQU6REe/lNlEe4EhLKV9M+mhE4m/C02hT0h+FjBH8EK9nXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rDREXO41; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ch/IaWTG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rDREXO41";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ch/IaWTG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 15D5413801B3;
	Tue,  7 Jan 2025 03:47:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jan 2025 03:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736239668; x=1736326068; bh=gDTLVZSwfG
	vtbBZVopJy/tc+e+hUdJPG5zGq/2j9wjY=; b=rDREXO41Ya3sw/57nCV3jtYQac
	RVWmI9Z8d3DFpcoIyHnQAeZz1bZlmMo4x8S2k7COP+bm9JOUqGzmdLlpty86jBAF
	7650+0diyrF17C/QL5eYOBgif6/LGX7aiEvP2hwL4TbgEQKAL/H2hKnShto+t92n
	MlgNf8LtVhkTA+zHs/4F8M4gxTcaSLMzBqEtYnLjp1VuCpVDy0C2PWzjqdVdPdZy
	k/Mqjcac1xQLD8dOZE016AJt6vyyLEZlgRBfwS7zGQaQQddoCUHp3aZ1EPpPw1mF
	8Yy32DOWbrJFJZZ1YeKdJOfeBxW9inVI1/PR/bwTWE8Cxk6cL9SaVJnQ0wNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736239668; x=1736326068; bh=gDTLVZSwfGvtbBZVopJy/tc+e+hUdJPG5zG
	q/2j9wjY=; b=Ch/IaWTGHHyCmmjPiUp5/1ve5lFZcRdMwyywWh9ENFEyGIoUKQg
	aykJ6H+jHaUQ3vcO7wIMKsGe18iGux4mVpWsdv248n1yrQhJjrlfnU7W8meJkIlJ
	YBOIlAAsn61cWzFv+r2MwsMS2GSOvwxWRZx5l07R90hi4EMJnqIaERL/n2qMN4r9
	+UHqC2u24JGU3JbtilXQqIznVyn6Gyo9l4vIYVQcNKzU+KlfRWrqf+BxqMmLttkg
	kukF4KkFclswwc19Ygi9ZyAwkeXw/z8SlZjde2hU/Y/OhqT6dG4dAY6tGBRT7C2t
	3HmNGVAXq+JQ7gdyG8Qjsphm7mXVo+5c6rw==
X-ME-Sender: <xms:M-p8Z8mUzg2Zn4D9bRf152du9sPCRY-TfTrf9vVhDL0C3JeseD-3vg>
    <xme:M-p8Z70L5DluNIPVfffQU_5oU7-bbG73eqIbmLnKPGtf1-kYaIjEB_i9K1KtXHL5D
    eMKuJ24im-d7njf3A>
X-ME-Received: <xmr:M-p8Z6olQTjB0Wb__q9tq5swEFABUt2oa2_BfaET9dTZEJHaPMBJga1vuS8tgJL6EPQJjkoNP0GFGq1z683D-dFECgsZ-AjnYpIZWwfOMDudGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:M-p8Z4kxL-WjyH9c-uVR8Abqfe-SaCL5laeg7RH8KoI1M3WfKQPrjA>
    <xmx:M-p8Z63xKLCiLoCMdMUpKl2b9Hxj27PVg_yB_C0EluoZCuAPZhTCEg>
    <xmx:M-p8Z_vw8hw8SsZ5GvZENDIFtudVYRcF00aGjOn8uSO6Ro5WRALVJA>
    <xmx:M-p8Z2Wu89sKjC-Mnu1HsdOUcYKCNIpLMjK3qApCcHpJX4cr6zpbZg>
    <xmx:NOp8Z_xa7D0Vay5jbaxqkJwH3fZEK6OhBkJNeD32TcdRMeanqUpX7oh8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 03:47:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4462559f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 08:47:44 +0000 (UTC)
Date: Tue, 7 Jan 2025 09:47:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <Z3zqKSx8NVK-QQNL@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
 <Z3u6lj_bpM7N93Fd@pks.im>
 <20250107023904.GB2363@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107023904.GB2363@coredump.intra.peff.net>

On Mon, Jan 06, 2025 at 09:39:04PM -0500, Jeff King wrote:
> So I don't really see a way to do this robustly.

I think I found a way, which goes back to the inital idea of just
generating heaps of submodules. My current version generates a submodule
"A" with a couple of recursive submodules followed by 2.5k additional
submodules, which overall generates ~150kB of data. This can be done
somewhat efficiently via git-hash-object-object(1) and git-mktree(1),
and things work with a sleep before and after the call to grep(1).

I'm a bit torn though. The required setup is quite complex, and I wonder
whether it is really worth it just to test this edge case. On the other
hand it is there to cover a recent fix in 082caf527e (submodule status:
propagate SIGPIPE, 2024-09-20), so losing the test coverage isn't all
that great, either. And keeping the race is not an option to me, either.

So I'm inclined to go with the below version. WDYT?

Patrick


diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e920367..fbfc60936c 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,10 +167,38 @@ do
 done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
-	test_must_be_empty err &&
-	test_match_signal 13 "$(cat status)"
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git clone . subrepo &&
+
+		COMMIT=$(git rev-parse HEAD) &&
+		for i in $(test_seq 2500)
+		do
+			printf "[submodule \"sm-$i\"]\npath = submodule-path-$i\n" "$i" ||
+			return 1
+		done >gitmodules &&
+		BLOB=$(git hash-object -w --stdin <gitmodules) &&
+
+		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
+		for i in $(test_seq 2500)
+		do
+			printf "160000 commit $COMMIT\tsubmodule-path-%d\n" "$i" ||
+			return 1
+		done >>tree &&
+		TREE=$(git mktree <tree) &&
+
+		COMMIT=$(git commit-tree "$TREE") &&
+		git reset --hard "$COMMIT" &&
+		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../X A &&
+
+		{ git submodule status --recursive 2>err; echo $?>status; } |
+			{ sleep 1 && grep -q A/S && sleep 1; } &&
+		test_must_be_empty err &&
+		test_match_signal 13 "$(cat status)"
+	)
 '
 
 test_done

