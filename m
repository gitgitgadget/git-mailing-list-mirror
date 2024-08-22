Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3914A4E0
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308505; cv=none; b=Hd2hzMllx/KufyPel1aIavF+J+XrqAz+J8R597VrfLoXMgV6LV9T+PpjL2Y8oFeblAzP2jTfyt8bWsY1vLJTrRLam0bZgILyVXoZJdeMkYhfsqX5Kf3pZnjT6EtyZBVla3xBdFfaKgPCYMsYAdi/zmRL3vTLAKVp4gvoAxs3rNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308505; c=relaxed/simple;
	bh=cY7jiUdNccPCVsQZl9kOP2J2lRJmGGadu2bnjXE+xHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfwNdtbkyu2y0Ozv7/tPmYA8t9rPBVi0WIttVlXLkpJCA9i4W5BphHasvL0TuyIFopE6xpKfjeugQIwJcylkqPkqdGfOFGan5nS5RKFA+9FTkEFAVd9K44/N1VdcQ37/tv63iVENLqVBQG7E1xE9RRCXMlqWvFDFN1PQh8uBiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U51b34jf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z61eW2vs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U51b34jf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z61eW2vs"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3D7F71151AF6;
	Thu, 22 Aug 2024 02:35:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308502; x=1724394902; bh=KMmhErjqdL
	gavUUkjCPNFfDarxV40ugUdlGRjmvO+qc=; b=U51b34jfbVbe30O7LdwJZlVUaE
	O5Tk5P0MhejVXSrpLt9kX7yV3MdKhl09+Zj9chTHHvSf5zFWkFs29fGqUm6VaHUg
	t6DX00yKgJUhZv3hHFvQ5H7DBxjb8PpVrJXGeDRr81Q98bemnckuFfkm66qJ6tNz
	dDb+MXWL8VAQJJXNoa4j+JFwMDOj3QXW+C+ST5AlPNgWLbK4BO7TPZaWCPoWpZ/0
	hhmGxfNr2DGWRa+yUSsCWX4Bdcd2cnCzkIu1farw6P5z/wKkin9A1xl/mxxtJFEv
	jc/A2Jzw1nkQl88YRrcmm97m2/eejzheARf5bg3g0Yo2vAI2upjU/q5ZtWCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308502; x=1724394902; bh=KMmhErjqdLgavUUkjCPNFfDarxV4
	0ugUdlGRjmvO+qc=; b=Z61eW2vsokZbrctN1C8n20sEQMc0/aWId5M6QmH8A1gr
	oVy1XrpzwuM7ZKqtjKgq8St/cnbYtM11ovNMFwUbGy8P/xTA7bEi/CLlb8BIu40n
	NQWbMWaM2eTK6uZEUWzVRFtHYlrQfb05q/uZrgsUD09uGTYdWH8uDTy6BJ55DZ7v
	5o1B1MxvrKVglDfiIB7dd0Xr6aA6IcFyBIRBmMxuB45uGnBmY4EA/0HoIBXT3Fyy
	jSSmlbrzYFQvoGp9oVisKGv+wDnpxCKkpmHvmto11EwtLfAv/uxCqumOqwnxXBXw
	mbuQ09LQhqCNqBNByttreAgcwmtXoK4mhmVPTXGfmw==
X-ME-Sender: <xms:FtzGZoGnVh9zrXtW7FoeFwIlqqOd3k5NDKEyUwtZomFfhSYIdJ6v6Q>
    <xme:FtzGZhVURcOavFHlG0_ezF2B9QGjSn1ACpBjIPK3aA-A8ctyFWW6pHpanV4A1enPH
    jpidY1ejvYbvLfg3A>
X-ME-Received: <xmr:FtzGZiIDzB55vZdoJvI8AhPboIq5QEmPM4sFRFevggf23MTzt4YGR-YjNX4-x1S2CS8GXFWKfgbMYnO1JIegpp6X_O0-0DS3swoQjsJnG6gDMok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FtzGZqFN6Qv0YPgiSag0Xg4g2G1xH0htYpBDmpSE4U9d6nzYoMT9cg>
    <xmx:FtzGZuV3xBhNv-0qbRe9iWT4zDkzARtGdlDLyztmUXiKPPevYclQAg>
    <xmx:FtzGZtNmYa08rov69GZp1d1KZ__seZX1GhUFh3uUbZpwtIRJY2C2Ig>
    <xmx:FtzGZl3r-4tk6tYJ5XpBrK2izZJod5Br9qDvkUBRVwy5g6fUZM9aAw>
    <xmx:FtzGZtSzkqeD-DOn9WnASg4S_-u1Q07-RGm1pKRGUiVgc_9dsZ4_NGhO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af51f47a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:27 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/15] reftable/dump: drop unused `compact_stack()`
Message-ID: <4011fa65d81928348e2e4d107279d04ed9fd7324.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

The `compact_stack()` function is exposed via `reftable_dump_main()`,
which ultimately ends up being wired into "test-tool reftable". It is
never used by our tests though, and nowadays we have wired up support
for stack compaction into git-pack-refs(1).

Remove the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index dd65d9e8bb7..391d93de6a4 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -24,30 +24,10 @@ license that can be found in the LICENSE file or at
 #include <unistd.h>
 #include <string.h>
 
-static int compact_stack(const char *stackdir)
-{
-	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { 0 };
-
-	int err = reftable_new_stack(&stack, stackdir, &opts);
-	if (err < 0)
-		goto done;
-
-	err = reftable_stack_compact_all(stack, NULL);
-	if (err < 0)
-		goto done;
-done:
-	if (stack) {
-		reftable_stack_destroy(stack);
-	}
-	return err;
-}
-
 static void print_help(void)
 {
-	printf("usage: dump [-cst] arg\n\n"
+	printf("usage: dump [-st] arg\n\n"
 	       "options: \n"
-	       "  -c compact\n"
 	       "  -b dump blocks\n"
 	       "  -t dump table\n"
 	       "  -s dump stack\n"
@@ -62,7 +42,6 @@ int reftable_dump_main(int argc, char *const *argv)
 	int opt_dump_blocks = 0;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
-	int opt_compact = 0;
 	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
 	const char *arg = NULL, *argv0 = argv[0];
 
@@ -77,8 +56,6 @@ int reftable_dump_main(int argc, char *const *argv)
 			opt_hash_id = GIT_SHA256_FORMAT_ID;
 		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
-		else if (!strcmp("-c", argv[1]))
-			opt_compact = 1;
 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
@@ -98,8 +75,6 @@ int reftable_dump_main(int argc, char *const *argv)
 		err = reftable_reader_print_file(arg);
 	} else if (opt_dump_stack) {
 		err = reftable_stack_print_directory(arg, opt_hash_id);
-	} else if (opt_compact) {
-		err = compact_stack(arg);
 	}
 
 	if (err < 0) {
-- 
2.46.0.164.g477ce5ccd6.dirty

