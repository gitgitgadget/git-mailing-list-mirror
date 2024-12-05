Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015581D5CFA
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391422; cv=none; b=dxiFZO4CcMtDkssSOZU7VRmmYYJeSuvhbpr56yAOB2t+Dr7g7x1Zhsae+yi3POzKWf/e/ldO95Jfayk9HBHkHILt03JsvjEvFd1pTuHzKkzeylfazKss2kwdBH+YKql+otIGQpslKloAlIpSH4kQ1njOxOw9tQ84/7D4rXqlMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391422; c=relaxed/simple;
	bh=yt9s0BtuoNwslmGrVUJspMnZLrL8LjlqmoebGr92Pjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXKEzGkRFu2ctRVlUDeBgvzKf8dJjuvcdhRlwpeGuaJ1G4rHVH2LQU+UMAYsKehk2kn8agdsOGIuu69nG48qt4oeSaKRFZ6/llsN7W7Tug77sK9Amps5wbHX731qBK42iBXa8fdqyTKGbIm2o477srZdMF4LM6kebDC+1j+YofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y3Qa+eul; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wzvuHqQE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y3Qa+eul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wzvuHqQE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F17281380B8A;
	Thu,  5 Dec 2024 04:36:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391419;
	 x=1733477819; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=
	y3Qa+euls4mivs/l+tiW6wP7Ra/pBXLhZGa6F0fyEFKTVBskTwmz40wEVGMEsqCF
	g4wJN0KxU5h2MQyLgAxa9nerEoqv0qYQdrHB+d0RpK/MlclxHahZEDXBVkJ5FiR4
	HtgDLZ7nUxqx1SBS1d9nTBYdTTb5OZqdzFYzZD73+CkfHCe+Zk2skzX/pkqy3jRu
	kmuTb3YjvK+Y0OSeVEiNL+G6D29vij5b9o1BeADJAJbX4rtaXllBiSdW+2bBuv6v
	fqqAMDOl4aCAEGLGuxvXauMl9Kz5EO+2vNjRSqzXGf500NLepl56QuvOFnKw0fhh
	2YOUjmJeUfVFftCry+Oeyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391419; x=
	1733477819; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=w
	zvuHqQET/QkgCfI3F20zO8T/h9ORybTo2D7g+CY0F/I+feQtgD2g4wDbtouiR868
	gf6RiF/QcOyiGtSs/cyyOF9iqnUjqvS5JxoUuxdIbq7rBTsjlVTo7tXgG5jMl5Bn
	6+/pFcbz+xbW4GkE5FG0DmcacV3nIyPe40QoBuCNghrpeaQJ7rbO2FTunlDQrava
	CQKmdyfFHjYVQhMncPyDnS0mU9HNEgZ63vg2+6fPZRRbkoDkSqljpkNnUsGJXs8A
	0fmON5EZLB5+xlWnF7BlqcSMTABnQfxcVyR529qrCAuYObAagIbBKTo5Mv7hGfEy
	fFYF/hu/2URnReRQTVQ9Q==
X-ME-Sender: <xms:O3RRZ4KDug8kw_Y3Bw3dvukSIGvYCi6EakabZV8jcpEceTBoAUKaHg>
    <xme:O3RRZ4LmXoQ1DjPVYNRAHc5cVHBSGSjlDG2mQOZDuYOPhr9B_HQtVks_1a1Mszln0
    w48uMw6H__yX9Hicw>
X-ME-Received: <xmr:O3RRZ4tJudJVRmvHt7_sK6qd84NySUG-vkwFvFubbhjIoh6QnjaeMgVXmc97jxPLD3qPQoqYBS-TsKMpTBtcGmfq_TvGrY_TL8B6Ws_C-bleNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O3RRZ1ae_ssWSrHiPykXvCfJL7zA7CHvdXNGrQLZ1FQjPXWN5ok25w>
    <xmx:O3RRZ_ZyNmUG_u1YLx04n9SfXV0f3V5I8E-bA3f4yoTfbvJBraGX3Q>
    <xmx:O3RRZxCTJtPNEvJlTkd92bze924zsMMe-8f0gSVAdmiZm4JPDFdKUA>
    <xmx:O3RRZ1aP6nSAhnn2Y9jKu37zKP1c7maWdeuvU2Yn9Ngdq-VZAUSwlA>
    <xmx:O3RRZ-Vyojf8GwDKFqmVAPcoz-LpVlXbeALiE4AOd1XKMTM41qBz1SSL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c98ba1b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:36 +0100
Subject: [PATCH v3 14/15] scalar: address -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-14-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
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

