Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A217BD6
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624743; cv=none; b=VLTMZ2rW0ZlrpeJkIGOeCR070Yn6ORZ7XyZ13FTBtlB6gdzlAN8LCGMk79lMv6OxfimuUlIlPK+UzGdAw+YOh+5xP4TovcWSay5JSxaFZGzrZ5LntS6I8O9F+RMxYieit8HmLeF/RFE81DlMtOMG2gobJAuCZoFzMlNcIECR8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624743; c=relaxed/simple;
	bh=zXYo0bP6TUYHKWjUrPQX85daV5BOVv3KsxGkwigzfUM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS94pjgxLnMk+IELqPvBeKkEYrN15UpAO82IOoX3l2As2MKkz9UwnX28IGG+oz97lOdUqLHK2J90oy6vtEWyA3gBocU3kvp7MPGrh1rTkRrCawH2ecs3w+f5tDsTjAtAWSxf00ZjdJB21z6lTc+nKn0H6D7fKomnGn22pnwty4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e84HxLie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bS0wBcKg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e84HxLie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bS0wBcKg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC6291140129
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 01:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624740; x=1728711140; bh=lDcg1vIXRA
	GMfVCNOw/s+H2p9E4G0J5mgeuYCl4vsp0=; b=e84HxLieazY7973Ok4M5/EoBa0
	WDXxlVyFsjAL+3LwAv3XUum0eWn/0FHoi4GdwFNFRmaOhygOKF8px3QP5n0wGzhf
	adpZkVEXtJ3fvUh7OVr+vrFxuwt2OYgB10WeDliS59ORQQE98oupxJexRTkUGMYe
	+DTrySXx/yK6YedqbhfuyXBmpEGghwXP1nxWG7JcljyhJrVIotKYcz/okBioD52E
	3/BYtq56dlecDNtk93ySniRYVS5k+28hK8euKfV13Fde865hgNwsm4e7ysF24gOD
	AB10L5piMJGDZFfLPxqaX/5wiwAED99XiOrClcxU7gMlSKuH4BjszmSKz/TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624740; x=1728711140; bh=lDcg1vIXRAGMfVCNOw/s+H2p9E4G
	0J5mgeuYCl4vsp0=; b=bS0wBcKga9h0zc0Nh6dTRij2HxI9AxVHckYYqEQuyC0R
	Mn+1RSjdg9J17H1YeCgRvYBRiIVmW/wFh+sMJNlFNQyTFJ9LqsRWiORtVPfIKT5o
	u6IxNdW0NSF45xoHR8tbX6ClrxcQH3nf1WX3YVX7TuBbJxthhgJoH1npdo5nWLKx
	REfI60OUl7OzM1ZlCmXEQKU9jWgD43iUohPvmdSW0CjQtG4MPPWmzFVG5JdYtIeE
	8Jrsy7Hwh+oHdIABW/lXu0K7xrQYLqzinNe+XHnu5LbkEI/q0TmBb1beZ5dpUed9
	gm/V9PhsiGo504eGYB0U3Q30s8QayLogdeZ7v1XR6Q==
X-ME-Sender: <xms:ZLgIZ8hTCg0NjfE9li8wI26q9Dh0p4E6kBlXbXZ26xJ7FsvW0bQ31w>
    <xme:ZLgIZ1B4AcmpSsJm6tzSIXERW1O7t-_FwrDjclM_Qe0Yv0txiQqjgFLKYUW6EAlto
    ta4G49qIpxgh4W1pA>
X-ME-Received: <xmr:ZLgIZ0Fy2CjnO-rIBY9LyfdWsptFAX7jH7wpZ9wePtnomXJDe6KpxaDA3qM5A8KOKVfr8BV6dvGmbtKsfYS-yIYYKdNRXkkL1TiZ5z7vRVL9sAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZLgIZ9R3ntFnKtd-IR2KtciYEisVCsm163ziS2YmC3DniXrwuFJsdA>
    <xmx:ZLgIZ5xB1SuTmaLCVZ86E6oZ_J_ZAF1yWmH7MMLJY4w1tXzJiie9gw>
    <xmx:ZLgIZ76zdYcvkCjp0zWNR0vG4FoD0BxUR1FXGADcetdFKWn_HPaUSA>
    <xmx:ZLgIZ2zNX1Z2LDoR0ipgm81bm-x7DB94nvaENV69HVSROmVNAMfM-A>
    <xmx:ZLgIZ6op1YoqZ0dFouKl79JE00hGXnmgC0-mY6AS6EP2LLkAOydhYc_W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fac8859b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:14 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/21] builtin/grep: fix leak with `--max-count=0`
Message-ID: <6b2c8842ef53a3e550aa3de7447c9c3d23bc6772.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

When executing with `--max-count=0` we'll return early from git-grep(1)
without performing any cleanup, which causes memory leaks. Plug these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c  | 13 ++++++++++---
 t/t7810-grep.sh |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f17d46a06e4..98b85c7fcac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -906,6 +906,7 @@ int cmd_grep(int argc,
 	int dummy;
 	int use_index = 1;
 	int allow_revs;
+	int ret;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -1172,8 +1173,10 @@ int cmd_grep(int argc,
 	 * Optimize out the case where the amount of matches is limited to zero.
 	 * We do this to keep results consistent with GNU grep(1).
 	 */
-	if (opt.max_count == 0)
-		return 1;
+	if (opt.max_count == 0) {
+		ret = 1;
+		goto out;
+	}
 
 	if (show_in_pager) {
 		if (num_threads > 1)
@@ -1267,10 +1270,14 @@ int cmd_grep(int argc,
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
+
+	ret = !hit;
+
+out:
 	clear_pathspec(&pathspec);
 	string_list_clear(&path_list, 0);
 	free_grep_patterns(&opt);
 	object_array_clear(&list);
 	free_repos();
-	return !hit;
+	return ret;
 }
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index af2cf2f78ab..9e7681f0831 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -9,6 +9,7 @@ test_description='git grep various.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_invalid_grep_expression() {
-- 
2.47.0.dirty

