Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BB2066CE
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480873; cv=none; b=SDRbUeZqQXVKOv3Fje4+HKc0chY+DjPR1Nin/GazgnSXTOaVcsEqDWzmcVSoCksvCfk3lt3O4McL5FkkYtkI64rxqbXb9IXRuAaiurMVNfQtJ/MBQdE0pGuLJR0ZsVcYBFKQnSrlrX5sXRe7On+/j7dOPVxoV777Q8zbcuIO9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480873; c=relaxed/simple;
	bh=yt9s0BtuoNwslmGrVUJspMnZLrL8LjlqmoebGr92Pjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeqprsZc9ZsbxZVfAfsjPbhufjDfkkzqgnDlfRrhKtFeNQy6TTM3fQpRkz4CenG1AXR8hXVCfEf00WHMhUcQCD9MP+UxxsUqgKMg1lnejPiFNrbUfGsEF/FfesbU9yiyoqpRIxA2r2Nz/FHKlMObgepG4LFDlOeXvOu9NCNQ/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gLwOaic6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8RDZhsu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gLwOaic6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8RDZhsu"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DEA41140199;
	Fri,  6 Dec 2024 05:27:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 05:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480871;
	 x=1733567271; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=
	gLwOaic6dhl7axoaVjQ5LN8kjuRebEpiPWdLP1TPYZFss8dWUGeTuLpY/NLCeWG9
	6+WKVno9m+v0gUxxkWcf+SFUz/ahyO5R5LAHFPMgZTPi03U/uScw4UfScBADNImU
	POsxk4VaiZoL8XSDiHvLpyvHcZXjQRacnenFDIUb6zRR60w0EdVxIxwe5QB6jxbt
	vKdrpT2YzNnjXjQxhy2m/tSZlTGlLdVfzZOfFmZx2acX/fEr/V3BtwBe5nY2n2d2
	avncqe2ns8tOQp7LmYMaR8izJJbCGtXKmiQF775waETw/I0z+aRxMNpdh8k/vGP1
	Ze6C50ONc8NI97L8f3Rxyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480871; x=
	1733567271; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=c
	8RDZhsuSoPOwUfioU8Qnznhk7XsTafe1QZuf0EJ9LqfkqzulwPXPPiNDOK0E1cd0
	O4RwHERXd8kI5uMHLn8H0jgKZrUpKvNeKMyvbLVQQB8Ifft3APAsJxXjiBTYYFc4
	voGs6vZGVY/XRtf04J2m1waaMymxxH/WXvrGBltEjHHRAs76kKwiGJPelHhqGbYL
	A09Mx4vvSnByPeAQTf6bI6sRa/dGjiFB3dIKY9+SlWTetqAAHmTEYCWvGOiQhZTP
	mvOch/KAkH9HJd1eVi2mT3v7NUnLUQGEw/NKlJ07dTaFmzZpzVoga4FhrAwMvrKG
	e/0iuYGDM3qD/fXAeQaFg==
X-ME-Sender: <xms:p9FSZ23W-NtIL89t572CNqMFgjar460VedeKwBI_UjAfhu2YPsNkNw>
    <xme:p9FSZ5FWC7SUMc96Xpc0IZWiTru3VmzVEQ0qGey7RFR_i2hQIobkOjWjBNKuMbf8t
    VCroZh0tx1ePj2vXA>
X-ME-Received: <xmr:p9FSZ-55pls6HyU6WOSUVQ4OdMvsUC6w9M0JgPtBl3dnLEPGjwgIbG_Dru82rvy2xPVF_f9ZcledVFJ7L4-HEExtRZTvUAdezrJy1aAYqcoYKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:p9FSZ30quacaIoun2RYEZl366FyGcnmi55_SSi_7gHvpxnzO1vocmw>
    <xmx:p9FSZ5Epg5OoxOyCx4vOK5nVp88RHoO_Ptb3asCq3uh6heMAhs65Xw>
    <xmx:p9FSZw-Vwzaizzw5rWlHYpFWprlhuDValBbvkgENQO6bGGQ2jHT6fQ>
    <xmx:p9FSZ-mCo-dPncEFNdZDNpsY_PgSv2LpbquP5vuE_KPyWvNOJp16pg>
    <xmx:p9FSZ9glAWIVqVsY_1G9dIPGEkbr7LUuqFrmfhzlOzEgex54X5SPEMFu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c17c5066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:30 +0100
Subject: [PATCH v4 15/16] scalar: address -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-15-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There are two -Wsign-compare warnings in "scalar.c", both of which are
trivial:

  - We mistakenly use a signed integer to loop towards an upper unsigned
    bound in `cmd_reconfigure()`.

  - We subtract `path_sep - enlistment->buf`, which results in a signed
    integer, and use the value in a ternary expression where second
    value is unsigned. But as `path_sep` is being assigned the result of
    `find_last_dir_sep(enlistment->buf + offset)` we know that it must
    always be bigger than or equal to `enlistment->buf`, and thus the
    result will be positive.

Address both of these warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 scalar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scalar.c b/scalar.c
index 87bb30991bf768534a988608d9b194dc8b5ba78a..f24bcd0169cee4f5055304a42954f7bf5df67e48 100644
--- a/scalar.c
+++ b/scalar.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -380,7 +379,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 	offset = offset_1st_component(enlistment->buf);
 	path_sep = find_last_dir_sep(enlistment->buf + offset);
 	strbuf_add(&parent, enlistment->buf,
-		   path_sep ? path_sep - enlistment->buf : offset);
+		   path_sep ? (size_t) (path_sep - enlistment->buf) : offset);
 	if (chdir(parent.buf) < 0) {
 		int res = error_errno(_("could not switch to '%s'"), parent.buf);
 		strbuf_release(&parent);
@@ -655,7 +654,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 		NULL
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
-	int i, res = 0;
+	int res = 0;
 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -673,7 +672,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 	git_config(get_scalar_repos, &scalar_repos);
 
-	for (i = 0; i < scalar_repos.nr; i++) {
+	for (size_t i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
 		struct repository *old_repo, r = { NULL };
 		const char *dir = scalar_repos.items[i].string;

-- 
2.47.0.366.g5daf58cba8.dirty

