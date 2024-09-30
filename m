Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902118C03D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687669; cv=none; b=Ukg8j+blOyrSWFZwJcSaaLrZL0Ee/OdyFjFc4/y5SCo8Vyo+68L1uT3z4xAvZ2Tu3SPFTBoScK9XeX7fvgXRcYXnj8BuNSpKHPHdLKQU4ERbxNsax41/u/Z8ngJw2QAZAmos8zGOi/AM3+kZQyafnW4qGFt/E1Rab6Jill7b72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687669; c=relaxed/simple;
	bh=r84pHqvqnnZLhcGYAgxp8mPZFUsUT+uJjLnQhCqzmoA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrioRvcx1tUYvdy0o5dMhWwk+7wdxb1B57tmr4xsvfOBYZHZfcDmdUqL+d2H/o/U/JEQ+zufBPhHOeg4+E85zfVfdSoaYOcZTJrjgVV3h+lgFJgimUjM57nWcChY2hDvxi64QzOUS+GOURg21P6RDpTSIYXxhPaCq+iBm2Pj1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=If4VVvQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rm2NXwHb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="If4VVvQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rm2NXwHb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF2E8114026F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687667; x=1727774067; bh=p71VE69Wh/
	AN4ZcIi14bccifRUnxznCxhnPgwrZgpd0=; b=If4VVvQ9SjG5Znt7X7dO2A1lUk
	/QRFBuYnPPAV3IhFzDVakfg+CrYBGzA8+js/w16YXQjdOdZ0m6VsjzoVejyoJIqF
	9jpNSTD58mI87QB3gWLoqqOdWGFJxxpeIinxOCfdVhsoxkDWNA7mRHQWDP59S/i0
	Z3bPG/6m6ePORyeh/M8u+LgiDw/bsS/06ls1F7MH9bj7MGBH1S7E8uGyOCoH2T1r
	bpWLqzckZ4gz3TW1aw1bRxI94PBvtwVHxrSF/VNCyTr9Pm4F6H+9sTTh8Z6AiZdF
	LqDrLwRd/9+ZcImHemZfnaNZNHhb3FugTlSmt+QQy0BdmMifAC+nn3KHrU8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687667; x=1727774067; bh=p71VE69Wh/AN4ZcIi14bccifRUnx
	znCxhnPgwrZgpd0=; b=Rm2NXwHbjBh07SfwA/6Ehj11XQ5ALsGgsYlJVMPyt3uT
	G/1k1AQK5fU5VW8Qgm1IrOpZREJn+a629fFsKsGVlvU+T2rHOgIu1avJHpVSH8hl
	QZ9snbg4BxVNtV+d8UPdWemfIYabK6Cb4CpH1Z1qjow8N/Ocd8UVeQulzLHZrFvP
	txkOdXgSbrqXDQmrNuexR/6Qawaq4oFMJhm4GZ8Sd/Hib4uWljvqBJCe1SXbLNxG
	kT/7izsymKNFFxX3UYgNDSdSoa7FkjaWckkMPLbf8y5EvYAiplZEjMOi+gL4s6tA
	sBGtzMeGRSTtXNre0ZE3UrCB8ER/+glr8EnN+F9ykw==
X-ME-Sender: <xms:82v6Zgvrc2RCrEgvopGdB84-4j4zU2SYJo83MO6ZvBcSWWOcTk3ljQ>
    <xme:82v6ZtcRoWpumgVZfWV1NCbo58brZCpZhctfzzjS-a_ynPbimLD4PVRtI8NvhrIvg
    TqIrqAOue2ZnrKJWQ>
X-ME-Received: <xmr:82v6ZrwaMPj6kocUpcuqUkF54o7IHYVrDRbi55BKaNLyCk2aB1CpJfHYmI49DH-qa5K8Yw5cL66nmUAj2HRaf-Lea3iUlAHxib9dSpEJBuWDq00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:82v6ZjO2s9bnaCfDstVWrKzh8vSK22AY6cMPWrBj1WyLvImJjN1jWw>
    <xmx:82v6Zg8qfk2utDaS_k9XVZN_Xh_WqR9EdRti7ISu5tFvH9BSeYGm0w>
    <xmx:82v6ZrX-O6EWznBY19lTRrIDPc48oHlUfAlr5YrDxIx7gT7UZ9HoYQ>
    <xmx:82v6Zpei28TnLopJY2b7hxKiQa9SY_hFY3WR-UZa7ishpoYJbESRmQ>
    <xmx:82v6Zuk0CmlxLgHjRm9lAxHt9upVG-Wc8OK3QpTFQ01NXggddRvS5yOt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d847716b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:41 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 23/23] builtin/send-pack: fix leaking list of push options
Message-ID: <312de7828b646101145975466574434d2dae048e.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The list of push options is leaking. Plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c          | 1 +
 t/t5411-proc-receive-hook.sh | 1 +
 t/t5545-push-options.sh      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8b1d46e79a..59b626aae8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -340,6 +340,7 @@ int cmd_send_pack(int argc,
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
 
+	string_list_clear(&push_options, 0);
 	free_refs(remote_refs);
 	free_refs(local_refs);
 	refspec_clear(&rs);
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 92cf52c6d4..13d2d310a9 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -8,6 +8,7 @@ test_description='Test proc-receive hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index fb13549da7..64ce56d3aa 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -8,6 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mk_repo_pair () {
-- 
2.46.2.852.g229c0bf0e5.dirty

