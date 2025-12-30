Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C0227BB9
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094725; cv=none; b=uqsCGLdpbAyzD8mEquNGxLA1dvnNSoAzd36f60BwRCn1RGpjQsY/1SSbTirNtDvbuoIDqZAUX/uUqDOtdVUgUgWmzcSZbW+F5BsGV+146+EztQCfqACYOEpswNkcvh9KBwY6lOonlsid2kdkpj3LW/eDUBWdNl8zirlYNaJ1heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094725; c=relaxed/simple;
	bh=JVkHduqyJRenqsXON07irHe2Mfv/IfzKcnRsO685tK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=khOrhm9JoPY3X/DVnLLOApPMnvW36/lzsDCeclPz5gN4GrY7msYa1sfx4JND3seWRuppQ65YCycLWyPI1YFrA5tskWLGgj5s5LPcj31q3BFeCeOJ2svorhRGDvyhEHf1IHfJDaABaS20ZpwnYuXOxdYn6dEkYivRxAxb4t+tlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kTNYIorW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCMJgyz/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kTNYIorW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCMJgyz/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 58C721D000E3;
	Tue, 30 Dec 2025 06:38:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 30 Dec 2025 06:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767094721; x=1767181121; bh=QhqCZu9LmF
	Q9r114NxKtplpzEsrJ5uvUFpOQ2/HpDio=; b=kTNYIorWIAxtj9hSR1EaMWjR7p
	jVlo2DCOBbaYRBBSiKOHw5WsONah5fzneKVG/tsIVYJxtK/jwpE8yRvPkSZ9iBih
	zxd3FIKujK9GzhU548Z7EcYAlisiNQiTMyoYRQ86SpEvrd4cA+5Hhzi4NWY6Gk2V
	VBly/wwHldME2gY5+9GkRxq0yoDErTO71MhkZ+ZelbTPBAzoJKTgJCx7900ntfAm
	RQqdm15GaMHYvN22KzYYqZ1leuDq0UGMN1zzy3tQDq1ImfVzZ8jsUrHiTAyMd++G
	r0TG1hxIs3N54SEImMfz+lehBP9PA4S0UYpKCRz+Gg/xdOWCc6l2/TCbd9yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767094721; x=1767181121; bh=QhqCZu9LmFQ9r114NxKtplpzEsrJ5uvUFpO
	Q2/HpDio=; b=mCMJgyz/iT35AgagSuF8wLXy7uKEaouYVBqtVajo/sMtRjF22q5
	e02QgNIP8ihBBO8Ou0SoMAyurLaEaJ5FezB6Fg+ROlNQyAsAuIrUOs+V91/aP4wQ
	goMQqDBukof69qNNyCLDAP/5XvPVncvDNATbW1jMjW3bs4pz1JpIg3BnNNGoI3ii
	asX1P7CkVSSURweYyZzkGhvMDR1gPAhBCGk+4KCSYrGzL7XVZvOMr3X+HwleLBbx
	gnCHtFgvdu8AveImBMZQf43m+XMyM61a01mtgseZBzkKwC3uSMopXOqEVfgSEZ5p
	GX4YMtSLWzsHqCg/ZHWyeqkt1zU6AReaQww==
X-ME-Sender: <xms:wblTaaLU6T66HrrI2WYtMt0havT5Me_f1t5K_UrH6gWrY_ALtIsQsg>
    <xme:wblTaZLVH8Nqi5ZfoeFWJYvxEis7UYi95phg74j4r4E4jolvTPL5Atl42AQAJhL76
    Tpdr5D654Uwkq3bLitqnBTdsm8SkM4NMvxly-r64kkmAMX4qp0nIQ>
X-ME-Received: <xmr:wblTafso8ZraF6zs8LgJx0t9sF4ZQ09zPizR-4Y7q75K80ZGx9yrHpBOlYRmDA6eBsslOgk7DYAC9g2IdqKjgR56WXhMEK5g0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejleeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wblTaeQCBO7TMaI_nrUMj77aya8eQ0Ag6C1ZLo5qBU_R2SOwpSmY_g>
    <xmx:wblTadNIvwGKXO0leapRcaw_wvbEWUtLqpHZY_u8njh6CssPVuVohA>
    <xmx:wblTabbh-QSF_8wbSjAoOn_TMlg2Oh49qAAWRSiFsrsyHDpnq7Bocg>
    <xmx:wblTafyx4Q5akuxH4JDig3muw9gp3z0s-W5QRO3gtkjKpimu_jHlRg>
    <xmx:wblTaVuSfubYToODuMCw0JboFC-sCHH4iWXzowxZKpHwFHrl1A3RtMm2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 06:38:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH] fsmonitor: implement filesystem change listener for Linux
In-Reply-To: <pull.2147.git.git.1767082450088.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Tue, 30 Dec 2025 08:14:10
	+0000")
References: <pull.2147.git.git.1767082450088.gitgitgadget@gmail.com>
Date: Tue, 30 Dec 2025 20:38:39 +0900
Message-ID: <xmqqqzscfbcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Exciting.

It seems to die with leaks when "make SANITIZE=leak test" is run,
though.

Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t7527-builtin-fsmonitor/test_implicit/.git/
fsmonitor-daemon is not watching '/home/gitster/w/git.git/t/trash directory.t7527-builtin-fsmonitor/test_implicit'
builtin:0.145521.20251230T113644.793433Z:0Q/Q
{"event":"data","sid":"20251230T113644.762195Z-H3cfff1b1-P0002386f","thread":"main","time":"2025-12-30T11:36:44.813131Z","file":"fsmonitor-ipc.c","line":99,"t_abs":0.052581,"t_rel":0.048830,"nesting":2,"category":"fsm_client","key":"query/response-length","value":"45"}
fsmonitor-daemon is watching '/home/gitster/w/git.git/t/trash directory.t7527-builtin-fsmonitor/test_implicit'
fsmonitor-daemon is not watching '/home/gitster/w/git.git/t/trash directory.t7527-builtin-fsmonitor/test_implicit'
fatal: fsmonitor--daemon is not running
not ok 2 - implicit daemon start
#
#               test_when_finished "stop_daemon_delete_repo test_implicit" &&
#
#               git init test_implicit &&
#               test_must_fail git -C test_implicit fsmonitor--daemon status &&
#
#               # query will implicitly start the daemon.
#               #
#               # for test-script simplicity, we send a V1 timestamp rather than
#               # a V2 token.  either way, the daemon response to any query contains
#               # a new V2 token.  (the daemon may complain that we sent a V1 request,
#               # but this test case is only concerned with whether the daemon was
#               # implicitly started.)
#
#               GIT_TRACE2_EVENT="$PWD/.git/trace" \
#                       test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
#               nul_to_q <actual >actual.filtered &&
#               grep "builtin:" actual.filtered &&
#
#               # confirm that a daemon was started in the background.
#               #
#               # since the mechanism for starting the background daemon is platform
#               # dependent, just confirm that the foreground command received a
#               # response from the daemon.
#
#               have_t2_data_event fsm_client query/response-length <.git/trace &&
#
#               git -C test_implicit fsmonitor--daemon status &&
#               git -C test_implicit fsmonitor--daemon stop &&
#               test_must_fail git -C test_implicit fsmonitor--daemon status
#
1..2

=================================================================
==git==145489==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 512 byte(s) in 1 object(s) allocated from:
    #0 0x56179e6ce042 in calloc (git+0x8c042) (BuildId: de5ce3c9d0b0c09380c910e6a9eb181e324abde6)
    #1 0x56179ea0aef4 in xcalloc wrapper.c:154:8
    #2 0x56179e8b17b7 in alloc_table hashmap.c:79:2
    #3 0x56179e8b174c in hashmap_init hashmap.c:168:2
    #4 0x56179e73e6fe in fsmonitor_run_daemon builtin/fsmonitor--daemon.c:1288:2
    #5 0x56179e73e141 in try_to_run_foreground_daemon builtin/fsmonitor--daemon.c:1448:11
    #6 0x56179e73dc44 in cmd_fsmonitor__daemon builtin/fsmonitor--daemon.c:1584:12
    #7 0x56179e6d2c8a in run_builtin git.c:506:11
    #8 0x56179e6d1910 in handle_builtin git.c:779:9
    #9 0x56179e6d2747 in run_argv git.c:862:4
    #10 0x56179e6d169b in cmd_main git.c:984:19
    #11 0x56179e7f7a7a in main common-main.c:9:11
    #12 0x7f091ea66ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #13 0x7f091ea66d64 in __libc_start_main csu/../csu/libc-start.c:360:3
    #14 0x56179e69e280 in _start (git+0x5c280) (BuildId: de5ce3c9d0b0c09380c910e6a9eb181e324abde6)
