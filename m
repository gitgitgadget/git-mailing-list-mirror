Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BC26F2A8
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854172; cv=none; b=G6yePN9NiF7vXtdgv63eLxcUhKOO4KsNiCZkgBDb8yOvaXX3yBPsYI37uT6qui/RnhPzU6gDrMdpNVFOabx+g0X0lcnf/BT2t4l8k1Yavn/XQcvDULUPb73ZkSczuZROl88/Ohm+3s7SK53En4aDTKwajBmsK9jARmGhDdGmnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854172; c=relaxed/simple;
	bh=7eIi99Cq7pcZRCIa/kAnyiMnc5pOCYY+2QMaLSzFS0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbvP78Er3sURthdXdiBEw7IgXpSP64qzNeq57KyEzrz8IoGBvFJq/gjbN63n0Hxm1lq6EblSC5fX9BJoMlLXBISOv59tFj/UbN3MbpPSl+vE+9lZO9K0Gb1O70+w8Lnrv+cz2CCK6QRnplw1Tsf/73cPGs8X0mdGXZuswKOkix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQK7bKSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlEBeiyv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQK7bKSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlEBeiyv"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A4D7140015A;
	Tue,  2 Sep 2025 19:02:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 19:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756854169; x=1756940569; bh=jpOqCLv47k
	8MezRoYf7uQLuOsPCT7ylBWKvcGQ3e3Bo=; b=IQK7bKSp/W0yeLDIQSeqbtLbir
	WksORl06v+wlTz7QXZR5+M1vxq2lAVaM2IZ3/gd70KbNC6cuhs/6VPNKb6hQ7KsC
	UasPC6LXyPv5ir0cqZtKLVeEGuKn7+gDpy8VSSWVlts/kb9YifVxhsIWoJjV3hk4
	fzXgVdHmYb4wYIyQZ6+uYJEDNSX/mMDhUUHPN5Gy94Hd3plhMTJMiU7OsyOKA9Cd
	Dj17C4cYIFHHtK5S4QoWtXjcN1lQHqipFYChrstVJLXuOLwIz4MLJRXriDRIeZ26
	by0NXhEj/KabJ+cpGxMUTavhlpVlwtshiCzspTmH5+GpHYwPzl0Z/qGkaSyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756854169; x=1756940569; bh=jpOqCLv47k8MezRoYf7uQLuOsPCT7ylBWKv
	cGQ3e3Bo=; b=GlEBeiyv5W+Og5jE0yPfcklJ+96xLizUbh7GODSWpYfusC9rv7x
	RLeQ7bVhqaJO9NFjHFfmGUpda/0UJeDXhIOsJcW2SYvQN/css5kt39rPrY5rRTbe
	UFzF7MCXHzWwIfjuTvOv3XfJXbdkqhVvwncOxID+Zl0ZkeVuRu/l+CvexKGPfahf
	uExQlYXhoaSVkZAowiGRwnxB3sXAAxPkjWkB2KYWi3PzdKLV2NZUmQ7QhNjzah0U
	3HZQpRj08d5GHAkS+xCfNp/MJnnawPc5G0J4rIjnzxaRoLMfLjpFvpjj6T4Ag9tS
	dRapNY8QuZSdt3ITonP+0eWRLCp8fLJxQXw==
X-ME-Sender: <xms:mXe3aBFGyiA63WoplyCTfzEnOr3oM7FxNruDAuG62vHLGC0ChVngCw>
    <xme:mXe3aCBUZXpVjYeG2yMKUy1DUzrLh6dxE4UHvTYpKaCgCprXQ_zzSJpeuRdbHvnEb
    UOrRyrz4mmSeaxLlQ>
X-ME-Received: <xmr:mXe3aPmSrqRw8IAAPFe7WxgjSgnj8lC2GqGGGRXztK6PItzZUy5nJB3G0UbSM1ec5nve1QDQayIyAU_LBLIoo75lShHOLSSsHKYYCnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtth
    hopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehssggvlhhlvghr
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mXe3aAMiCr5moOp7ATUmGQOKOihy-Kt0WOZZrVSiYx2RqWb1JUTyzg>
    <xmx:mXe3aM-kpdKzg-m3iu-Xg74L2gKN3u47ufmJ90XiY_MXhH_Xdey96w>
    <xmx:mXe3aCGPLYeAJlUiJ_JCfdQCvo_6qrycKavm9A-aC2mmSMH0wPoVSw>
    <xmx:mXe3aLin289wAW2SPRssJT3lH9NmRN-xlxhJKBFdu_alMowWoEXp0g>
    <xmx:mXe3aOxYf7SlVdgHs1Uh8mb7_fw6RxeMdmc4_dmd04gDowJ_UDwh7AEC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 19:02:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Stefan Beller <sbeller@google.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/9] t: submodules: add basic mixed gitdir path tests
In-Reply-To: <20250816213642.3517822-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sun, 17 Aug 2025 00:36:37 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20250816213642.3517822-5-adrian.ratiu@collabora.com>
Date: Tue, 02 Sep 2025 16:02:47 -0700
Message-ID: <xmqqjz2gh2zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +test_expect_success 'commit and push changes to submodules' '
> +	(
> +		cd cloned &&
> +
> +		git -C legacy switch --track -C master origin/master  &&

This test needs to future-proof itself, perhaps with something like
to force the initial branch name to a known value.

 t/t7425-submodule-mixed-gitdir-paths.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
index 8a2d2e917f..02bd48aeeb 100755
--- a/t/t7425-submodule-mixed-gitdir-paths.sh
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -2,9 +2,13 @@
 
 test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
 
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
+
 test_expect_success 'setup: allow file protocol' '
 	git config --global protocol.file.allow always
 '
-- 
2.51.0-302-ga83f9e55f9

