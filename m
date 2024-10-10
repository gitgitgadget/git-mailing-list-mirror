Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8219E7D3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538387; cv=none; b=mpFwA4sAgBfeOEqvqqZ6k060wFsPUCDK293DGPGnRfHkoWxSkpkklk91Se1krxJQqtfZcGbNP09xkwOPGBKgicRX6rZLeOqtW3idzxNRVT6VAT240sEN1Zmg8z9M9Jmx7lIBOed8TJGtwASyKTbaadIUHBH8xJ3e4v0cOjO01OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538387; c=relaxed/simple;
	bh=TEhnOhrqVrYY8l11KJLeFprogYdIc2aGz95aOyS2d38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq3aLLfW8wHDOvi0gjrzLy13mhKg83lqDP5RQoUZH3SC9THvQiNQkt/O8ErfkflmwUyqClAKedRvbAA/dy0x2bDrue3DNh8r8/EsvlUQioJMR6T6EgV5iri2ugFaVpSvkT9+ngxwaeaY2Yj5rob5ePK21QvBIumUTDuu0jGN26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okthMSEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMk/5Kkb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okthMSEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMk/5Kkb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4E301140270;
	Thu, 10 Oct 2024 01:33:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 10 Oct 2024 01:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728538384;
	 x=1728624784; bh=FjHAT3IYWGh8G2n40wWVTRIvpsQCKc/vmqrSbuI7mNI=; b=
	okthMSEtkg9NWioujtaZK7tUEdCSA2kMkBvrFOvj+6Ztd2i0U+1JTjdBd/sIV0kJ
	aTP/c8ocFl5gAEHnkYS1kGt9KSngHnbe5zE+PK3F+llipGO1wgmbHMsS8/ty3N0F
	1SUC+jFA6d8pZ/eRfJGU7ph7MvNAtYasm3vv4fDA4XqsFQwTRilrCk9Gi2oqp22U
	lb+m8IP6FvghmLbBxvhGfdv4UbpJyrg9PLeZrN113j0NPjq7H4nR3e+/sIHSUtJv
	sfeC6CltNBvxk6cr4mx90xcDkrQ+poo9Ws0O/pC+4gt71O37Elwg+h92k0myrFy0
	Xc4JwTMOQsW98SDayiHYJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728538384; x=
	1728624784; bh=FjHAT3IYWGh8G2n40wWVTRIvpsQCKc/vmqrSbuI7mNI=; b=q
	Mk/5KkbHMp4TRrh7gey0jIbejReNtx2/G//WlrgD06TrcnV8h2Q7+sXxPLGrhqg/
	iqZrUVYZTlPiXDjynzvKayha986lvr685dHj1MpNKkbVSqzVOQy7cMYb6Sp5EJ3F
	/uZssqEkcx4/4pq8g15C5AYnMbriJL2pSlv7Cw08OMu1dTHkXsEtDxwFhjmgGtFY
	NCAsT3ETYtQ38VwGQhk0NzZ+DQHJASC1VntGVA/vCG+bS9ay3faF+8pM+9jqwyB1
	CDEftxma9I7q7GdaduApPIabkTOwLWKWm+iF7rt6gi6IoxE6y+P4Vp0aPv67STKR
	UyQdraNBT2hB2oSRfRwCg==
X-ME-Sender: <xms:EGcHZ8g1kZbx8SuAEM9FhlUJX6jc1rJmrWRmPMp6GD12nnLK3wrCuA>
    <xme:EGcHZ1Cye968nRh_NsWzGxiweMm6y_942PIWIp8E0unMU3Yhg5h_8Nybftjj2sFKS
    6JWteVgave-Zr6CoA>
X-ME-Received: <xmr:EGcHZ0Ek_5UeyA9M08Kipdy6JKb_6t4kaP2Azm8LjEcDga5Mxf_1PLGd3-gDuWRFfRz-25tulHl3n_UfoQHCDOB3-PPTjcadQJk1AFPNdhcXE_zB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EGcHZ9RBBCdBUhyscEqQQVlBKqLsyHTD7tVa25HxPW5S-ti8c41OsQ>
    <xmx:EGcHZ5xDqDNTGtCfc91uT8cczdUbZogtZRf7W7lxg7rsGgXtoRbVAg>
    <xmx:EGcHZ76NGUjSuEBK_n1hfI9CX_zOiitdSJpdcf9Kf_RSQcR8qzbayQ>
    <xmx:EGcHZ2yf_4lGF43GC5AjKhIuHA9pHpAKLoFhKrIA_5NVo5bMSnMBwQ>
    <xmx:EGcHZx-tco6uzY_nHL9DDNvvup0qqW_1zZOCoxo95Z3a0Omz8I4OmQWG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:33:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fab1e8b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:31:58 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:33:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] builtin/gc: fix crash when running `git maintenance start`
Message-ID: <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>

It was reported on the mailing list that running `git maintenance start`
immediately segfaults starting with b6c3f8e12c (builtin/maintenance: fix
leak in `get_schedule_cmd()`, 2024-09-26). And indeed, this segfault is
trivial to reproduce up to a point where one is scratching their head
why we didn't catch this regression in our test suite.

The root cause of this error is `get_schedule_cmd()`, which does not
populate the `out` parameter in all cases anymore starting with the
mentioned commit. Callers do assume it to always be populated though and
will e.g. call `strvec_split()` on the returned value, which will of
course segfault when the variable is uninitialized.

So why didn't we catch this trivial regression? The reason is that our
tests always set up the "GIT_TEST_MAINT_SCHEDULER" environment variable
via "t/test-lib.sh", which allows us to override the scheduler command
with a custom one so that we don't accidentally modify the developer's
system. But the faulty code where we don't set the `out` parameter will
only get hit in case that environment variable is _not_ set, which is
never the case when executing our tests.

Fix the regression by again unconditionally allocating the value in the
`out` parameter, if provided. Add a test that unsets the environment
variable to catch future regressions in this area.

Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Two changes compared to v2:

  - We do not expand "$pwd" in the HERE doc anymore.

  - Fixed "$(pwd)" vs "$PWD", which broke Windows builds due to a
    misformatted PATH.

Thanks!

Patrick

 builtin/gc.c           |  7 +++++--
 t/t7900-maintenance.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6a7a2da006..d52735354c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1832,7 +1832,7 @@ static const char *get_extra_launchctl_strings(void) {
  *     | Input |                     Output                      |
  *     | *cmd  | return code |       *out        | *is_available |
  *     +-------+-------------+-------------------+---------------+
- *     | "foo" |    false    | NULL              |  (unchanged)  |
+ *     | "foo" |    false    | "foo" (allocated) |  (unchanged)  |
  *     +-------+-------------+-------------------+---------------+
  *
  *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
@@ -1850,8 +1850,11 @@ static int get_schedule_cmd(const char *cmd, int *is_available, char **out)
 	struct string_list_item *item;
 	struct string_list list = STRING_LIST_INIT_NODUP;
 
-	if (!testing)
+	if (!testing) {
+		if (out)
+			*out = xstrdup(cmd);
 		return 0;
+	}
 
 	if (is_available)
 		*is_available = 0;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a66d0e089d..c224c8450c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -646,6 +646,22 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 		maintenance.repo "$(pwd)/$META"
 '
 
+test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
+	test_when_finished "rm -rf systemctl.log script repo" &&
+	mkdir script &&
+	write_script script/systemctl <<-\EOF &&
+	echo "$*" >>../systemctl.log
+	EOF
+	git init repo &&
+	(
+		cd repo &&
+		sane_unset GIT_TEST_MAINT_SCHEDULER &&
+		PATH="$PWD/../script:$PATH" git maintenance start --scheduler=systemd
+	) &&
+	test_grep -- "--user list-timers" systemctl.log &&
+	test_grep -- "enable --now git-maintenance@" systemctl.log
+'
+
 test_expect_success 'start --scheduler=<scheduler>' '
 	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
 	test_grep "unrecognized --scheduler argument" err &&

Range-diff against v2:
1:  5798c31e1e ! 1:  a5b1433abf builtin/gc: fix crash when running `git maintenance start`
    @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'register and unregister with
     +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
     +	test_when_finished "rm -rf systemctl.log script repo" &&
     +	mkdir script &&
    -+	write_script script/systemctl <<-EOF &&
    -+	echo "\$*" >>"$(pwd)"/systemctl.log
    ++	write_script script/systemctl <<-\EOF &&
    ++	echo "$*" >>../systemctl.log
     +	EOF
     +	git init repo &&
     +	(
     +		cd repo &&
     +		sane_unset GIT_TEST_MAINT_SCHEDULER &&
    -+		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=systemd
    ++		PATH="$PWD/../script:$PATH" git maintenance start --scheduler=systemd
     +	) &&
     +	test_grep -- "--user list-timers" systemctl.log &&
     +	test_grep -- "enable --now git-maintenance@" systemctl.log
-- 
2.47.0.dirty

