Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC41F4608
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135661; cv=none; b=EOc/sbSeJ5QmamsD0mqGpKvleTdLiij8l8uB1yt8FVD9VJgd61G1LL93V3+pD1BGGHw8AzVbIsJfePIu2odd23FKp1zBxcj48AMdDKwxOUoMOi4xPFo4bqeDHfZ3SfORgieoN7Xm6Qj+mcn8t/g5b7Pi5EezgUJW7N40lOxW50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135661; c=relaxed/simple;
	bh=8ymY14T4mlprd8/AP4Kt7ShcXpVDctlh6ZR18PsWXAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+pQKsmma/W5XuebYBeuSc0r58XhIVg4z2cxhdDosXApEpOwS9K57jf71I0Y0RgTCcgev4zuuOlXkpBP855wimZOhXceW9mHvUpx4cNAoVMw5kGO1hJOtxG+PX1sYh3o/FKF+orRScSkglqiQSjkwA+meRIsFKv4JV6vawzRqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pZF+eku+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uhapcadg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pZF+eku+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uhapcadg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DC29E1380F2A;
	Thu,  1 May 2025 17:40:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 17:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135658; x=
	1746222058; bh=XdsyOeYnB2zuH4q2vgcCvm4/72T+fJrN7yhzKTybdWs=; b=p
	ZF+eku+n2zheoku55QFWaZES+95Z/+xE5uYRvsBu5rklaBws7US1kSHSd3vhJuEL
	SGDog739HrRm4EdlcV+XRqqA1fPi+ge4jSZmT0+auQQ9jsu8VQGhJOYmjSMVdelj
	9AXixGZgHvNY8mAEJ2SMRYYaUJSEIyLWhfIwNeB7JTZRbFODzsda0SHZVc7o6Y3I
	hiYlqUzbFwW/xttUSMGhc7h9UBXdprggU9j4JyfKy5VaiE0rtc2FsFcO6PRP+h6U
	Xi70b8txqVkV28tjfFXQimqyfRRtXi0sSW+yBkd9ldB6lEppU5rPPfVdUQEJRFrg
	WWtyFEWI9p/MhKbnEKp1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135658; x=1746222058; bh=XdsyOeYnB2zuH4q2vgcCvm4/72T+
	fJrN7yhzKTybdWs=; b=UhapcadgUElAk1k1MYh3Iap3juhuZ2Dlsco8rYAVfH82
	8DaLhFlFMIOxUrHLRLIvsxweGt7cmEgi8o4JsUozgx1v+ocb8WwuDpmHyPxWiTHJ
	bObIs4c7jDwy63ZwWEAnp931/vKgpRsTJIpEXVhLrF4usnWWa23v5HMDSPpcnz1U
	gTSVWMKdHb0bVUHVeCdQ7kCIF1AtCFdciLAZ1xgY0QY21i9gOHB65Wk9apbNvK7K
	ILQQK0BmmL8ZtafTe6N8u9JL08nuo7ysygABEttj7WT77W/b0r5lk/GRXJzuS8Mi
	4zpCTPVzk/ZCQUPTI69hBgYl2oXZsKE/XTcJZ/ZT2Q==
X-ME-Sender: <xms:auoTaG816GFxfrLrSgZEm38-cOyg9u-LAp5MAyt3c3hN759wmaZJsA>
    <xme:auoTaGuWKhxfiT0ceQMWWgSVuLbM-08KITdAKByGzAtRpn1pGfEmp9JKXYwO33-KW
    XD5QY08XUh2qPdQpg>
X-ME-Received: <xmr:auoTaMCFSq1BaA_4UcW3Oc8uegTGG2O49SWV-ZesYxZAobuFMuXV1u7GYQWkwHefq7rPzWbXZ6e1Er5Ri1Qcn6FNUC86rO5npBId>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:auoTaOfeyM7KyeLgJEhJTLC7anfUX3UJSC0ePz7FSJIo36lkxt0Ieg>
    <xmx:auoTaLM2Ao-SIU-Rebqc5KWvYeRxQZvqZSJme3w1HcqfVhnm6Me5nw>
    <xmx:auoTaIm4AAnXWFUKPDhVOgdyNmmwLGKNJBtcBu5pkXGHHFT-ae_87A>
    <xmx:auoTaNs5A9ofTldi0riThmyzZjB7GrfOErD4eJM9XaAV5lLxZSHTag>
    <xmx:auoTaC-z5xMlQwOZCjC4dUiCVgI6J9sjivFyN4cUVxabVAVGmCRiz5Eo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:40:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] specifying a file that can optionally exist
Date: Thu,  1 May 2025 14:40:54 -0700
Message-ID: <20250501214057.371711-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <xmqq5ywehb69.fsf@gitster.g>
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Refernces: <xmqq5ywehb69.fsf@gitster.g>
Content-Transfer-Encoding: 8bit

In a discussion some years ago (cf. <xmqq5ywehb69.fsf@gitster.g>),
we wondered if it is a good idea to allow a configuration variable
(or a command line option for that matter) to name an "optional"
file, and pretend as if such a configuration setting or a command
line option was not even given when the named file did not exist or
empty.  Then I floated a set of patches to implement the feature,
but the topic did not get any traction and was dropped.

I am resurrecting the patches after seeing some interest in it in
recent discussion threads; it would be easier for people to
comment on, if they are in more recent parts of their mailbox.
I didn't change anything in the patch; they are verbatim copies
that I happened to have found lying somewhere in my filesystem.

Even though I updated the documentation for the configuration
variables, I didn't find a good central place to do the same for
parse-options.  I'll leave it as an exercise for the readers ;-).

The first patch is a preliminary clean-up for test script that is
used to house tests added by the later patches.

The second patch is for configuration variables, and the last one is
for command line options.

Junio C Hamano (3):
  t7500: make each piece more independent
  config: values of pathname type can be prefixed with :(optional)
  parseopt: values of pathname type can be prefixed with :(optional)

 Documentation/config.txt                  |  5 +++-
 config.c                                  | 16 +++++++++--
 parse-options.c                           | 31 +++++++++++++-------
 t/t7500-commit-template-squash-signoff.sh | 35 +++++++++++++++++------
 4 files changed, 65 insertions(+), 22 deletions(-)

-- 
2.47.0-148-g19c85929c5

