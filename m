Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD63537E9
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419693; cv=none; b=JTGIptfLZQP8S3QiENKVg1/2x2l44MZnMusqNbJ7wgnqjn5NN8+oaiKXSq8k5HdqWfHNceY8Eie4iLSjbtV0fZcK/bY/bnnVgVsJpseLeTvabMA3DKGC0OEsHMZGIu21rdQlbZh/O1ceJG6jKnCRA+Q88fNl6AFYP6RWCMvyN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419693; c=relaxed/simple;
	bh=+YvuzUPYHQDeI9OLn7WtWj7CawArLPrxwPRsIMD0vxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj4/4tlSmPPqv4t7bdsX0S3OFl4+SYiV58qxypNtGIXS8LQcBTKQ0w3IaQrfgcm3pG+Up1VS0PH/HjjpHRe39RVWlddBBlZvke4FGxx8SbaGQ9VcMoahHBfdpISWxm2Ca9S/7OZde8cWTlCoOhtvfvswelz2QSK/39qZd7fO5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D7QtVHH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kqR9eQRS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D7QtVHH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kqR9eQRS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 11CA31D00150;
	Wed, 25 Mar 2026 02:21:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 02:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419691; x=
	1774506091; bh=2PrROn7fi2o1V97U/9yuWNJeGB2a7y+SWobC0rkDPWo=; b=D
	7QtVHH+sfMYu0RSkQJRNiLrlk+yC28GsBB7zPZCTsC8Qb8iNtiAhQroWWFkWQSUv
	jBVI8NXqW5vNZQ0iq9IgE+OlWeZXi0UTd2PnLuAjb1vWOu5C6V/dNlXeCjsUIG93
	CnDBJnVw/vIacj94nnhI4RPk4Guyt4ychjeFDsfRhkNlwAJzZPTMXGZtzDtJUL5X
	pDAa8z1KmqxXYrfXhv+Z19N1BZk5S0fgCyaoGQlyJ4lYLgWiP6ASNElVhTCpTpzd
	ul0S6l8IyYXh6STOzFk+KTRD+1AZi0SzZsOEbp1PS6gZG+KrkDdtEphGvGbP44+e
	CCSHhBZ66cIjtvweuYfOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419691; x=1774506091; bh=2PrROn7fi2o1V97U/9yuWNJeGB2a
	7y+SWobC0rkDPWo=; b=kqR9eQRSsyzk7xbX8VNfsWqvUYiCbjs71jOlaeXd5X99
	Db99svPmhrogcq1XWe1fkwk+3XakdFvFe2aJmM4CY0V3Jxvxs/277BVqIFrGONx/
	pvP9ON/b8zl5EOlfYsMaZSyAweDVB5wYUeUMdEBtC2lAxuKTvnXlNt9BrDP48Cwj
	B+gSsAr0rGpoM7Y41MqaNrYnRUg2CgHjrQLOwXNhe0BmJmWvc0iG0YgU5jeORVKD
	qNCBSuFKblZwUqauZQ61SMR3wLaB+K8E8oVdNahFl9XwFdNQHldFvFkYFmX6s3mV
	TJZshTXmY6Ok3QM+oyRUtvuXeVYawPa4kdsJ/wWQKQ==
X-ME-Sender: <xms:637DaeqyJfnTZBbKVOhOqMSL07MIdEXjzqasRF0P7Gbuw6Ibctdvxg>
    <xme:637DaSoJF6jLSIl3zjl7VMbOq8-7NwtpM-vGg9BKATY9gOXKcD6MMB9CrVEtpO4Zp
    JgNo2zQAkCB3PZ_osog4dl-E60PrCtaN1j3yK18rdrF6fJoxWCPxw>
X-ME-Received: <xmr:637DaQ2ZC1cePHRDxc4EN2unVST17tQNhlTabKJzsNz3CVlFmYCv_8ZALnH7J5kqp4Q9vJwf7NcO58lLc7JZmDG8vtQRbNLsJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:637DaZAhSAFuqJnUS6kh3aw_btHfoI1TmbTTapYed4atMrlR-mhyXA>
    <xmx:637DaQcoZBTYmsw9nS7DhOYF_kujWh4wRGOyqhEx2HgFojj8rbk1Iw>
    <xmx:637DaWhAp0AaKodsZ_9uFhzAFh7vFack9PZCEm7J-Dhpe7xYp1x-EQ>
    <xmx:637DaQqPiDaHTPb0zNxZ6fPY6_mEJjnTQNOoVRhc2oZ8wVnkd9adEg>
    <xmx:637DaSB-8Gr4lkPNL4fqnntmkFw9pJmqMtCqCbOboUA3-bYqVDqKRSUI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 09/11] t940?: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:12 -0700
Message-ID: <20260325062114.2067946-10-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

The cverserver tests have the usual pattern, where it

	cmd ...
	if test $? ...

expects cmd to be allowed to fail freely and we can act on its exit
status, which is not possible under "set -e".  Rewrite it using the
common pattern:

	status=0; cmd ... || status=$?
	if test $status ...

which means the same thing but does not fail under "set -e".

Note that I do not run cvs tests myself, so while this change
makes the scripts pass to the point where they correctly sets
skip_all='message' and triggers test_done, it is very likely
that there needs further work to make the rest of the scripts
"set -e" clean.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9400-git-cvsserver-server.sh | 4 ++--
 t/t9401-git-cvsserver-crlf.sh   | 4 ++--
 t/t9402-git-cvsserver-refs.sh   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e499c7f955..e1cc18e834 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -17,8 +17,8 @@ if ! test_have_prereq PERL; then
 	skip_all='skipping git cvsserver tests, perl not available'
 	test_done
 fi
-cvs >/dev/null 2>&1
-if test $? -ne 1
+status=0; cvs >/dev/null 2>&1 || status=$?
+if test $status -ne 1
 then
     skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index a34805acdc..715723f675 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -60,8 +60,8 @@ check_status_options() {
     return $stat
 }
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+status=0; cvs >/dev/null 2>&1 || status=$?
+if test $status -ne 1
 then
     skip_all='skipping git-cvsserver tests, cvs not found'
     test_done
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 2ee41f9443..dd9ffe021b 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -68,8 +68,8 @@ check_diff() {
 
 #########
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+status=0; cvs >/dev/null 2>&1 || status=$?
+if test $status -ne 1
 then
 	skip_all='skipping git-cvsserver tests, cvs not found'
 	test_done
-- 
2.53.0-886-g529cbd14ff

