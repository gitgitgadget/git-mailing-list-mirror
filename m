Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA254F1843
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420052; cv=none; b=VKVVipeePi/id5rAzL37ROdHcOh7xSMpiK6pzO57uzgVkd9wiYcQDrJdAJkxz//19/srBknkvqMCjGm0zJ8QA3z52D5mJFNm3ROB8Cyxo470S0/TQRQ7Yh5XrCvXb1mbJl9aB+bLAUwrmjYmzHFrH3RlH/P2qGYyC5tGbJPBd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420052; c=relaxed/simple;
	bh=ktw5RphQ0MQS1d36OX3RS2VZaEgxmEMPm3al+fV9Xlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Al7i8WoBXtkXUDC34NNXmf8XK2RRAj0S2oz3WBcu4DcXjvpjpkXv1ruhE/Q7ivF5nEs2p6K4RdZZbTLrVrYmTUyKMoE6pa6NEvzumHzaMNDlPHjpghBX/cl7dtwF41q/p4phUrReqS/aaAd3f3aHdaLW3qNoltTiLmBR6ML4s7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Apk4HrN0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFYvFrPM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Apk4HrN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFYvFrPM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 448111400076
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:27:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 10:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1792420050; x=1792506450; bh=Pi+umT3dJCKTkv1HZSk1sY8LTvxB/HiZ
	5AZfn9zXPoU=; b=Apk4HrN0UtYzZsGm9tQXk0jSyP3kQAJDjDyap9SSdb/2XYsI
	lbXZ78SnVWIr21ISMKYW2kg0wcULU4nBc9ZT/7PvhAPkfpEOY9PRE/KDxm2wcLH/
	DDrWJ0c3RRzbmKjYjnNmry5XgmvNLJy+wrLjYUr58LGCFQDrQTI9iLY80ZnatA0A
	nOitjyzJX4RCRVpYHnFCz/UGkrVQcswW3GcM+8ptqB6FGcKuv9j4OPLugwKGHIWC
	zO1dZf6b1jWS9hFt9Bsv/c6XqNKEpuk2A3YBFS7yiWzICT/SJCfLxH+GwJenixU7
	VIeG4veMPoTxqqRnM7Y6KpFBnRxCrLvKuyB9Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792420050; x=
	1792506450; bh=Pi+umT3dJCKTkv1HZSk1sY8LTvxB/HiZ5AZfn9zXPoU=; b=h
	FYvFrPMV30duXqCM9UDp3jWmF1QFg21rJZmtMayvMJAmgg9yhfrUPEWKkyyOsuJM
	E/VehMQQAMoxVmQE4q2Kmmv+j5VB+cyWLFEdvuUemh1I9O7x/8wUxgGaKQGdOlCT
	qSSI4AtZxpBcCzFVgnBYLLuVAqauuvqiNkQZ2sXkXZKr+t4r5EOQdH1P2Lw8qSAS
	/FFJ1KjdX1bdEoDAlqSDsN8jJrR5sdFCDuzUzFMygb6kdoCi5dOmIarmKxIjsj1w
	ml5LbXMfTNkEDesgy8cRf3/jjhgC5NXLEUG43ySZmeOfZ1Rz7gwjZCWAzRDmpfNF
	V+b+6o59M8fE3k20IkQAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792420050; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VgH1KW7EEciw2Z4GX3O20Dx1i8DWbK30MN165vKw8pTcRDy
	FFRLaKSxFAZuNGwsxFpCQTaZX2q+z4dytbtAWc7mhfo44ttcQFZZK4VtZTZK5Kdv
	ud+tvkie8CEPlyf7xMew/tv7XaS3Qf7Mv4jrwsOyWxZJaxKsdStoZcCaIgVRlegX
	MLgJlH8Y1aluMbeLSpzPjV/3vonMeVxFFhRwan3izle1cUkOdrJNWaI82WUfDDgP
	0lAh4GUdqu0PkGB5PKm+YHNW2V+SczZ7u6C4ltKrMnONOw3IGGnk+LVJ5LGAyQ4k
	5WWTaC01THDcxkRp7bt2wU1weRXDiMJur1e3U9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:eeNz4MmhsFkWJK/Z11NkhmPlnfcB2wf52qiDHPnxwY8=:ktw5RphQ0MQS1d36OX3RS2VZaEgxmEMPm3al+fV9Xlw=;
X-ME-Sender: <xms:0ijWamyQaPCy3TSB64tjNzpIWvhmFs3swQuUvYlv7SOMNlij69-8lA>
    <xme:0ijWaoQlavKBATHuQ_mkgmorW8PXbraarE2DtZW6jyU-4yNc-cv6xTBOajXoMhTlW
    RoXm2ncbodXJOotM3-amZLnwpl4AfcXVqHybMSb8AOQA6G22A0UOg>
X-ME-Received: <xmr:0ijWal-H39bgDUjANVCMbZG5VqpYKraN6fhVGloHt-F4JBbHpwMJCy7QS0JRsNu900ccvBwooc7ce_ATzxsdIfYcP7rfcV78yu_G>
X-ME-Proxy-Cause: dmFkZTFraUyWA0R4U780qGAVszi/Ab3yawZXs+Xqdi0gun5RGEapIgwVwysfcaHhZP2/5/
    qmS2tAxyiWNE9Z0UN6cK3vBa2PclsyZD8Py7ly7WQu2aLIlJOe1DbLfBgDA5V0tywg+gR8
    qeN6ngAtNKOQsIRD32pGHjwFd15sH1iX/I0olFjsCvUZOZlsha3pjAWVVIUMKwJCWqlTe1
    /ohRCRnswsaswVIhVKoi+Q94TD7H3bkMbY8oqPzKnVTqOpj5nOfPWmr+ona2G4Z/jKxRUL
    y7YmCEGMpz5pw1dxacaePVXiHSs/X7Aj36IMsqrTHIp5HcFlyr9wDGGxackJ8IJFctmqcn
    5PYMz/9jZm22pn9QjmvH6YI61cMB4t4xhHocwXxep0pPBUAm8kD+YgoXgp8Za0OQwqfWIi
    HctyAh3qudHyrIsyOFIJP/J9JLWTIcLexMDflm46QiiSrFA22fBG/Nt9z6V9GV59X8d92H
    L9iORoPnjYdMSqoekS6ciPemeb6cCtp2uVIoaUPYRY2LUN1nqVfcSwNuRUxK/a8W9hiyK5
    AF+i5yvpd0g9rqrO5zkB/n8yiDus0+H3ME3z8cf2C1BQVShimp5jS/2VDcH7ueKBGtqfsJ
    Gbd2omoANiXUdLXapwZzq3HIhfbAqbWsqJPmx6bGQ4xC9b+ab01gU+5CWmaA
X-ME-Proxy: <xmx:0ijWanpGOqbg7dstNoqgegMasNqtXl9UZeM4bJIWv7MmB0VGoyPJFA>
    <xmx:0ijWaqkbYNDnokelf0HjqKdl8SsYG6coGmnPcp8toUrPP8wbB5Z_mA>
    <xmx:0ijWamKIKb1he2-AhrXY022wEn-YL1uxeH6H6VP8vG7flJ3uoGIvqA>
    <xmx:0ijWanzQI21wyueLLbAXnepreHY-ewQGrC-d3BaeVeIjXxnG_3a86w>
    <xmx:0ijWaqJESuJLm3VQH8gkDEn73yKYrkJoDADPmFZ8xWxtmHnavyhH2sM6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 10:27:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC/PATCH] config: honor file permission bits
Date: Mon, 19 Oct 2026 07:27:28 -0700
Message-ID: <xmqqbj8p7okv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Because our updates to an existing file almost never makes
modifications in place, and instead create a new "lockfile",
propagate the permission bits from the original, copy the contents
from the original file while tweaking the contents as needed, and
then finally rename the lockfile to replace the original file, you
cannot "protect" your .global configuration file from accidental
clobbering by doing something like this:

	$ chmod a-w $HOME/.gitconfig

Of course, if you make your $HOME directory unwritable, it may
protect your .gitconfig from getting updated, but that goes totally
against the intuition and is not how you would protect a regular
file from getting overwritten.

Teach the configuration file writing machinery to inspect the
permission bits of the original with access(2) and refrain from
doing the usual "write a lockfile and replace the original with it"
dance ourselves when we shouldn't be able to write it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c          | 22 ++++++++++++++++++++++
 t/t1300-config.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git c/config.c w/config.c
index e0bb29b53d..2b84fb215c 100644
--- c/config.c
+++ w/config.c
@@ -3065,8 +3065,30 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 
 	if (!config_filename)
 		config_filename = filename_buf = repo_git_path(r, "config");
 
+	/*
+	 * Do not allow updating a read-only configuration file; it is
+	 * annoying and alarming that "chmod a-w $HOME/.gitconfig" does not
+	 * prevent the global configuration file from getting clobbered by
+	 * mistake with the usual "create a new lockfile, copy the original
+	 * while setting a new value, propagate the permission bits to the
+	 * lockfile, and then rename it to replace the original" dance.
+	 */
+	if (!access(config_filename, W_OK)) {
+		; /* happy: we can write to it */
+	} else if (errno == ENOENT) {
+		; /* happy: we are creating this file anew */
+	} else {
+		/*
+		 * most likely EACCES but other errors also indicate
+		 * that we cannot write to it anyway.
+		 */
+		error_errno(_("file %s unwritable"), config_filename);
+		ret = CONFIG_NO_WRITE;
+		goto out_free;
+	}
+
 	/*
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
diff --git c/t/t1300-config.sh w/t/t1300-config.sh
index e3f8064889..876d376cc7 100755
--- c/t/t1300-config.sh
+++ w/t/t1300-config.sh
@@ -3018,5 +3018,35 @@ test_expect_success 'writing config retries until lock is released' '
 	git -c core.configLockTimeout=5000 config retried.key value &&
 	test "$(git config retried.key)" = value
 '
 
+test_expect_success POSIXPERM 'refuse to "overwrite" a read-only file' '
+	gconf=custom-global-config &&
+	test_when_finished "chmod +w $gconf" &&
+	(
+		GIT_CONFIG_GLOBAL=$gconf &&
+		export GIT_CONFIG_GLOBAL &&
+		git config set --global some.variable some-value &&
+		git config list --global >expect &&
+
+		chmod a-w $gconf &&
+		# "get" from read-only file should just work fine.
+		git config list --global >actual &&
+
+		# "set" to read-only file should be refused.
+		test_must_fail git config set --global some.variable other-value &&
+		git config list --global >actual &&
+		test_cmp expect actual &&
+
+		# traditional "config var val" syntax to set
+		test_must_fail git config --global some.variable third-value &&
+		git config list --global >actual &&
+		test_cmp expect actual &&
+
+		# "unset" to read-only file should be refused.
+		test_must_fail git config unset --global some.variable &&
+		git config list --global >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
