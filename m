Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA52E612F
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378277; cv=none; b=QWEYPUWyb9fbNGYm31GXNCmoKPM2afTjsG/d4xUiQJJOzizIF1aLrSY/6GqHcKJqK682uDRktFN0nB8pRtQlnryKzG9I0ibkOhy9talDkEuIgiwp7Ca7jC6HCPmACzfi4u2VgilQzfW5fW/jIm4WiJHGd0j3+KUxx05uRUFpil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378277; c=relaxed/simple;
	bh=ovo3UT1EeuTn1zTAerPRaS1SOgdHSmTWpzi4MpR1Gqw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdpJhdQCFsVmrz2AEAskQPKTOc72gmsbeXS206+LG9N0iIosj5JmBsnpitFTqSHw40WWshmIeuLN0nYfuZGVzLpnTKsT2MPSy/lmsktdYRzVLiqEcvuX+I/eGz7RxFPg8nK2qGTAFnP+xfbbTNEWlQXjDzhU3j3FOEuZC9MoM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtzRuMCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lj4WP8O5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtzRuMCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lj4WP8O5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31CF77A0027;
	Wed,  5 Nov 2025 16:31:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 05 Nov 2025 16:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378275; x=
	1762464675; bh=YJ0Mk3Rjg/oabCYph6teRyRRK+VINo2Qvm5BdCq6reY=; b=Q
	tzRuMCL66FXBBHzFaivbHIJbi0wxA1dy3Vg9wtrMD2Y+dbE+PQ2TFSwDzk7/rCBe
	MNXRkhYlOxmWI6k5bjMi0eyfCXS4Fo2owhOjTHiPY+fzH2mG4hTcaEAVE6bMlPS/
	tv4UQ94+YFqavnIZPL/RjLq70OJVqIV+8tqSy/zQN9Fg1X033tvr8LOjd5hmyJPa
	d6P3HFrH9rZWoxFBl7BqnJ8hvxREJ/7y9iHV/Xpe+Mrpg4MjpRTh0WOszYkIznoc
	XiMxX+1iqqMuyEY/6phkKxBJOTH7tzQw99rKsnsgqYo1EwcrMB2ON7dQ2bNMXouP
	SazSH8oFSfXQMR5ZEe+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378275; x=1762464675; bh=YJ0Mk3Rjg/oabCYph6teRyRRK+VI
	No2Qvm5BdCq6reY=; b=lj4WP8O57OVB2nySFRr5qvqVu+oIFXeRHvVmK3yKTRTN
	krfduOwITmvO7zkpikvI0hPdDm2Yg09l5jLyvkB9VF1B35QQisfrldYy5nOvPR0e
	mXIjBKG/feq6kmCSXqGF1We9lbPsG20+d3ztR2Q8gGZDyyvUVqjLZxKkxsoCLAqG
	LvQMHJKAkBkfDs3rRTpjtmVRnHJDEoo8DTnzZM+l9Zr/ICBeVGSwnxYRSQh6YwXI
	w8Qor5NNLaerNAvQKTzWm0Qu9f0TW6wc/uQ+0UaAyB5Z2tC11RV3bjlwrPpbxHr7
	yYH42U9jBUr3lxhzrQzLkuhJq2O4FgsR1GKVF86GRQ==
X-ME-Sender: <xms:IsILaYP4Hep2enk50BfxXDvrSpNcEwoNIi6vJFTk7WpGfvdt6rr4MQ>
    <xme:IsILaU8hYCfoX0RIwQox_MpGqnZg4L_01JEzQyhJznCgcucvsZS21R-9XLCHHiX-d
    TQC8282ou138EOfQjhxUSfPR2h38phmsdX55vbyljjjaTBV2v7b2Hg>
X-ME-Received: <xmr:IsILac4e-IyY8ek2oR2tH4c3a4CWKGQw8PqeePE56QfYmizoAdYGQR5zbabAsPykgAGvLhIeHn-uaHBaMBod5voUIblEmftFjvNJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:IsILab16FCP32IjEaUKHKTlfIH09McoO-gFHrlKrpGnbaXWgja9llw>
    <xmx:IsILaTCOAEz0kqoZwFMWA9F1EeK0FB2dr6UVj7Q4-ADJfRJBMKbhSA>
    <xmx:IsILad2V0y0IdXBQx4V0up9Mmzruox_2ecCOqp-Y5k9aa9C9npk9GA>
    <xmx:IsILadsPDEXLQCE7wBm1UBCdyPVA4WZJZWT37j5TjvQ2LelSYLWhug>
    <xmx:I8ILaTmEIGacUIa7R3L3Jz2u6CGK0venCX-44NK_ctdIwr8odkvuDkEI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 12/12] attr: enable incomplete-line whitespace error for this project
Date: Wed,  5 Nov 2025 13:30:52 -0800
Message-ID: <20251105213052.1499224-13-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now "git diff --check" and "git apply --whitespace=warn/fix" learned
incomplete line is a whitespace error, enable them for this project
to prevent patches to add new incomplete lines to our sources.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitattributes | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 32583149c2..0accd23848 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,6 +1,6 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space text eol=lf
+*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
+*.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
 *.pl text eof=lf diff=perl
 *.pm text eol=lf diff=perl
-- 
2.52.0-rc0-105-gc08128fbb6

