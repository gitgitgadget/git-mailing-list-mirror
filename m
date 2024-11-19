Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FF1BD9C8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013436; cv=none; b=f1vGH2BH8oUQy3nOQlw40qhl5YT5L9k+s+aJ2+m72idT54+Vo/IwAjpOPLqVherb0AjhcAG3Pjc1y0AXmlu5BXYEHkY1vXo6oRBKwCEj6e1TmXR6Khv1Th3fbvTHqXRNuzr+XKimeE4AIIg9EoKizaT3cfwSP88o7M8WEZ3Qwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013436; c=relaxed/simple;
	bh=gd9Ozdfa2bXGH/XSl6+YkEQQO7ueCnW0drlEKG1vZks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZNfXGsv4bwyIkbtdmPdj+rYwJDl3Mt1iMfNIRmMHUEEx9vc8apZPN5QzTXMgfPzrrMzWegauiql9MYt0qwLjDAvjhYZTiZfRjDx7Vel01WNKicRd1hugKIv5YlN8dQQg6IXJiCuhaX6iHmftIAICc8I83zfsPDHBmcpatKIiP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XEKBbl1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC9THnnG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XEKBbl1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC9THnnG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A5C2114015F;
	Tue, 19 Nov 2024 05:50:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 19 Nov 2024 05:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1732013432; x=1732099832; bh=QU7X6thltu
	S423Ce+/WcX4CixGpqz1puOnV4XGTQlUw=; b=XEKBbl1u2FGADVuZmS15r3MgkF
	oLxIsiXdsaTbi09FuFkc5H4wxSyovWOuBkK2Cle5Kq9wFLVw0SdD/ErSzyU8evsS
	deE1kcOrXVvSNlaHCD8YwIfWlSfoDJOLkmKWiIpUf3X08Ysk8f/9GMTUBbdQzh8I
	fxNye5wU9d993C5M+QuOjrwN8FzSkGnVoKFebtI1yaCUT4b7pTWIpvxnKvp2x+iB
	PD6WiRk4/3r9uKlz1RDLq4Yr1Jxm64qorVc4WPuxfnSDOKEpG1euyu07eOB+I582
	NVcuQE99mV4hvRmgyOvZI57Vepc2tj1ljzaDbNTwv5H+DiiPO2vVrzwOU22Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1732013432; x=1732099832; bh=QU7X6thltuS423Ce+/WcX4CixGpq
	z1puOnV4XGTQlUw=; b=SC9THnnG2dI+69Wy+MLRsFyEKCIAmDaHeQOYWg2rzDBZ
	blqU04J37aT4U7sAs8M4zWGf9tYGNdnGYT738L0s1lwpMMdULcVQn/MdL41z5/1Y
	OXHsQORXarF+rSzbOvfduIHSEijY6G+q5wGnLfoW0/jN1BrpmnXqAht7qLV1FFfr
	/3uF0FNGPpWtQyDrNxjrzVLULNn9z+eWiKNICwNHgvSLKFA7tf4q9Psc9ssPjpOO
	u+OvOvKVoYFgK6WF3MLwRXYxs9JYBmDqwNlBBNLDAtyzGJUKZ5CJ7dAytykmJ13p
	fubA2F3XaQu0lAPfcVHSeCZ+4ECZ7eaitaADsOcoTg==
X-ME-Sender: <xms:d208Z6eEjQlRxqL_LzcFpLC0gb006l7wTrcxnJMi-sqwCAD4yeSJew>
    <xme:d208Z0OhWZphf5vT3_7YvaASyX82dQjhhNfkihqvAlMLbxYpsk1H9KYdwxkZJ4Mn5
    BU5_bqe0xIuYbsiew>
X-ME-Received: <xmr:d208Z7gzMPrTSYMx1u65TaRbLCXAAZWpswd2oS9BUcTI9a0DSR4ieUBgH1CKMpQ7N9qEENdh-0qO9x46mO3d276w1LUJusT-GZ4hgODgNNlAIic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhheekkeeggefg
    ueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmrhhinhgtohhnsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehkkhhlohhs
    shesghhithhlrggsrdgtohhm
X-ME-Proxy: <xmx:d208Z3_BgFcib5NzvaMfdz8oaSm0f6sNXOdBLxh-to8bQUvxGeoIMw>
    <xmx:d208Z2tBAq9W2dRzRIfMDU8ewIL-9yQkLWyXmpnODmqEck-Vs5JNxw>
    <xmx:d208Z-GYRiR7CDOGH4K6U2F_cjtldngqcuVTVsSZVMOliqwo0RSlOg>
    <xmx:d208Z1PPcl_pJ0VCE9jXk-2H3aEjf0iHfUP-BUdbLiy3nIRNOAN-1w>
    <xmx:eG08Z6LZOkMfJ9D7LNc7bE6kU77leDYpG4gBs3ZwjJw9ByHCD_o2R1Ur>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 05:50:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 511e791f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 10:49:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 11:48:43 +0100
Subject: [PATCH] builtin/gc: provide hint when maintenance hits a stale
 schedule lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-maintenance-hint-with-stale-lock-v1-1-f9f9a98e12a0@pks.im>
X-B4-Tracking: v=1; b=H4sIAAttPGcC/x2Nyw6CMBAAf4Xs2U3Y8jD6K4ZDLQvdgAvpNmpC+
 HcbbzOXmQOMk7DBvTog8VtMNi1ClwpC9DozylgcXO1aIrrhvhi+vGhm9RoYY0H8SI5o2a+M6xY
 WbDruWrqOfeOeUFJ74km+/81jOM8fH2iVgnYAAAA=
X-Change-ID: 20241119-pks-maintenance-hint-with-stale-lock-35e5417d632b
To: git@vger.kernel.org
Cc: Miguel Rincon Barahona <mrincon@gitlab.com>, 
 Kev Kloss <kkloss@gitlab.com>
X-Mailer: b4 0.14.2

When running scheduled maintenance via `git maintenance start`, we
acquire a lockfile to ensure that no other scheduled maintenance task is
running in the repository concurrently. If so, we do provide an error to
the user hinting that another process seems to be running in this repo.

There are two important cases why such a lockfile may exist:

  - An actual git-maintenance(1) process is still running in this
    repository.

  - An earlier process may have crashed or was interrupted part way
    through and has left a stale lockfile behind.

In c95547a394 (builtin/gc: fix crash when running `git maintenance
start`, 2024-10-10), we have fixed an issue where git-maintenance(1)
would crash with the "start" subcommand, and the underlying bug causes
the second scenario to trigger quite often now.

Most users don't know how to get out of that situation again though.
Ideally, we'd be removing the stale lock for our users automatically.
But in the context of repository maintenance this is rather risky, as it
can easily run for hours or even days. So finding a clear point where we
know that the old process has exited is basically impossible.

We have the same issue in other subsystems, e.g. when locking refs. Our
lockfile interfaces thus provide the `unable_to_lock_message()` function
for exactly this purpose: it provides a nice hint to the user that
explains what is going on and how to get out of that situation again by
manually removing the file.

Adapt git-maintenance(1) to print a similar hint. While we could use the
above function, we can provide a bit more context as we know exactly
what kind of process would create the lockfile.

Reported-by: Miguel Rincon Barahona <mrincon@gitlab.com>
Reported-by: Kev Kloss <kkloss@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this issue was reported to me internally at GitLab with the suggestion
of providing a hint for how to get out of the situation again.

Patrick
---
 builtin/gc.c           | 11 ++++++++++-
 t/t7900-maintenance.sh |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9f87ba4e8acb593dd11aa0482223e1..34848626e47c777112994e5b5c558b65952ac8c2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2890,8 +2890,17 @@ static int update_background_schedule(const struct maintenance_start_opts *opts,
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+		if (errno == EEXIST)
+			error(_("unable to create '%s.lock': %s.\n\n"
+			    "Another scheduled git-maintenance(1) process seems to be running in this\n"
+			    "repository. Please make sure no other maintenance processes are running and\n"
+			    "then try again. If it still fails, a git-maintenance(1) process may have\n"
+			    "crashed in this repository earlier: remove the file manually to continue."),
+			    absolute_path(lock_path), strerror(errno));
+		else
+			error_errno(_("cannot acquire lock for scheduled background maintenance"));
 		free(lock_path);
-		return error(_("another process is scheduling background maintenance"));
+		return -1;
 	}
 
 	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c224c8450c85f567bc29258e18b4a59fe6682f0a..6d6ffaaf376bdbadecdb23a460994af1d218dc19 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1011,4 +1011,12 @@ test_expect_success 'repacking loose objects is quiet' '
 	)
 '
 
+test_expect_success 'maintenance aborts with existing lock file' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	: >repo/.git/objects/schedule.lock &&
+	test_must_fail git -C repo maintenance start 2>err &&
+	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
+'
+
 test_done

---
base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
change-id: 20241119-pks-maintenance-hint-with-stale-lock-35e5417d632b

