Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8A76048
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457722; cv=none; b=G03Ib7C1ZEdcpSANsm8JtINGPe47yNh+SGW/DT1nFti2rIrGqMQFGWqxLqqI6HT8xvZDsdYKeEwekR85JYfrDvunTGbZ1xDLsIvIqcS7mmJWlU4pS5KjMD/FN6Tqwcx+BTQloxsy2pp+lfsBs3UKoOK6GAE3Se5+DnvXKPGckvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457722; c=relaxed/simple;
	bh=yXyIzjMZ+7qJ8KAPU5GjpptDcjO7cOd8O3PpKDdzRBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqvzx5RedIZ6eNQmt8uNxkiD/D7EomOWHbAxx5b0mn/h1XOECm10sT50FRMcRwOEBhWduymfUKPXiTQVHkkNxDyrwIELDHTcnVESOEMeSValSj6GHWnQRc8wlgEiHc7gY8nxU35zKE7dEKsN/uuSpWlJniHztjo/cUBLATM1a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MIfvyXnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DcOoZZLa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MIfvyXnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DcOoZZLa"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DA815138060C;
	Wed,  9 Oct 2024 03:08:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728457718;
	 x=1728544118; bh=8iBGjmp1NuY+/Wmqgzy9JASO2BgW06SKmnsbkUz741c=; b=
	MIfvyXnDIgQEXQQjL6yue4fJJ09X5Rjhxe2YccMQuow5Rqjo7GxEtqyUCn94HVWU
	iV1jI2tmDOgrplsJp/8RuVLpVlWHhXuIbDmgcwdFOp2ml6Z88PH3kD8lcUMrZYSn
	70Z/1i7lgKAW61zIeohhPBs67LMRA3PLwZZdcKgtbiy24yYhL3AAyjZOsfSPy602
	1MjJ6JehAYLgZ9KO0PK7E2PE8/KrUqEL0/shMedbijM78m1xOCvjrhj22cye7e2o
	oMXmf36GfWdPGwuobt/tda1rKMUC+o/2XAjY5LfJPSspzjtAXkpxZSRmdor7Aqjj
	90yzZlq08MSiec7oGpzOtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728457718; x=
	1728544118; bh=8iBGjmp1NuY+/Wmqgzy9JASO2BgW06SKmnsbkUz741c=; b=D
	cOoZZLapHFQ1YmC19d6yKkwRag9GKmykWSmTP2AWJy+/HW0V+cuNS0EuPjiFsULP
	lAH2DFO/398NCXOLukEwg9NrIDzjbXQvLV1xFzrCpIvILGSJC33tbwgvTanXP/4/
	owhusMDunyA1eN2Kr1EzRP6ihSvipvzyyQURC+zg+ygPMPywXL84SH1poJV1V6gc
	yhiz7AHBXyIzAmdwoUR8N1FzJO0/tYIqLTwqapRu5FQI/1OGSHeOB4TzoMsRjUMA
	DU1m13s0TttFVvPLGWYiAM+g8KUCW3olBtaGCHYjrc7+tTTwpMrc8XHNQHNKtUAo
	LqcEPFn2TqOJI5DBK4DaA==
X-ME-Sender: <xms:9isGZ19iqlaM2LhyAeo33XLegYC2mzv-R14HHB3GJMwk6XCL1AMo3A>
    <xme:9isGZ5tYd1TbPciQkxf3resUmd6_a6SdoaZNEfcLSzEKlcvu967xU9dATOVYJWXlG
    2I8QunDGl5EUzPcOQ>
X-ME-Received: <xmr:9isGZzBUsEBABqokrxlyTaCqAkf6bHlXqbKMORcgoZGmVedesV6ZCgZm-DoEJp-AGN9XEbuXYlLj0QYQvGs_HeLq4GuAYZCu0-Y6xMBAQGQtJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9isGZ5dk2nc8UcIN3Gx4x5DKpyN0f9iWG7akQRVoVXze6eVCde7klQ>
    <xmx:9isGZ6NC1Cc_SIWxUqb5PH-osDkfHa7x0_zcRziFpq2c19UAkA7Fmg>
    <xmx:9isGZ7ltafJzB9yxj5iLnMp5SGLEUkLg3RTAzUjn6jUIHHJHOiuIrA>
    <xmx:9isGZ0t_ofYl8G4h4hRsw84yuojKaJO9UEpluIcnDTvEhuzq6CPszg>
    <xmx:9isGZ3qMqWi56bxUCBD3KPpMhYRams3YzNCmDw6_YbKuZIxA0Q4vkzVF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 03:08:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff801fc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 07:07:35 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:08:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] builtin/gc: fix crash when running `git maintenance start`
Message-ID: <5798c31e1ef9346e7faf73f8c80b32c436937a8a.1728455715.git.ps@pks.im>
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

There's a single fix compared to v1, where Stolee mentioned that the
added test fails on both Windows and macOS because the "crontab"
scheduler isn't available there. I've adapted the test to instead use
the "systemd" scheduler, which _is_ available on all platforms when the
systemctl(1) binary can be found.

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
index a66d0e089d..e75b485319 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -646,6 +646,22 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 		maintenance.repo "$(pwd)/$META"
 '
 
+test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
+	test_when_finished "rm -rf systemctl.log script repo" &&
+	mkdir script &&
+	write_script script/systemctl <<-EOF &&
+	echo "\$*" >>"$(pwd)"/systemctl.log
+	EOF
+	git init repo &&
+	(
+		cd repo &&
+		sane_unset GIT_TEST_MAINT_SCHEDULER &&
+		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=systemd
+	) &&
+	test_grep -- "--user list-timers" systemctl.log &&
+	test_grep -- "enable --now git-maintenance@" systemctl.log
+'
+
 test_expect_success 'start --scheduler=<scheduler>' '
 	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
 	test_grep "unrecognized --scheduler argument" err &&

Range-diff against v1:
1:  976c97081a ! 1:  5798c31e1e builtin/gc: fix crash when running `git maintenance start`
    @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'register and unregister with
      '
      
     +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
    -+	test_when_finished "rm -rf crontab.log script repo" &&
    ++	test_when_finished "rm -rf systemctl.log script repo" &&
     +	mkdir script &&
    -+	write_script script/crontab <<-EOF &&
    -+	echo "\$*" >>"$(pwd)"/crontab.log
    ++	write_script script/systemctl <<-EOF &&
    ++	echo "\$*" >>"$(pwd)"/systemctl.log
     +	EOF
     +	git init repo &&
     +	(
     +		cd repo &&
     +		sane_unset GIT_TEST_MAINT_SCHEDULER &&
    -+		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=crontab
    ++		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=systemd
     +	) &&
    -+	test_grep -- -l crontab.log &&
    -+	test_grep -- git_cron_edit_tmp crontab.log
    ++	test_grep -- "--user list-timers" systemctl.log &&
    ++	test_grep -- "enable --now git-maintenance@" systemctl.log
     +'
     +
      test_expect_success 'start --scheduler=<scheduler>' '
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

