Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2D264F83
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728318; cv=none; b=RrzTvuX5acc3h0VEPox0M9uQuVCQrSMkfEfIkZExxqNDMBROOUG0nMYir+9u82e7isJXCv09L0bWW7l76RQXcvHFjmKYeU/5BT7SIBu3PyhuaAdGng8psbNj1hEPSS1MaeqPyGTtcgFF0VWYLyE3FqH44XmRWMIxH66Sfi/Himk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728318; c=relaxed/simple;
	bh=7ln9nwkpyznxT7iJp0fwJHGwQyfyaS+yby3jHRwtetU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFOAO4DXpcZgNEQJeKEKAdhcJvodnsLvSs8RjipgXySYPfwmg1FBdYliqMTG6SrDrZCEMfqiy1K5ZJFsJEsacf493MiHpuzGC5rHD+MZv8ae1kRnI2ssMxJOpo7bSvUvo56zruCEnVnT9lGz+m8wX8XRtnkz0rV9yXXfSPXMFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QgCp9EQ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eS5d43RR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QgCp9EQ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eS5d43RR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 104EF1382DC9;
	Tue, 11 Mar 2025 17:25:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 11 Mar 2025 17:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728315; x=
	1741814715; bh=zCgsvPjZovXhu7lkJaKwVRC02XY4VjUSUu57r6QdKMo=; b=Q
	gCp9EQ6VocICgg0qDj7BIQb1RA+Jiv8M6ea2EiSLFZLITDxAluD7d9JM/QyM0mq1
	ThNE9jeDt5MXPkx7+K3VppQMZLn0y16GRgOzwQd7vh3E8enx2dTErc8NvMnmULre
	CsVBIEL0cnSXU/IuxXUorZiWeQ1MFTU0892w+tN8uxHlONGtnDg8FFbtSzvPbxMB
	p7FFPOT55DezqJ1ZHydFYplAWIzDJJ6lYlVrDrN7UXl2FrrAbrbN8HUTsmKvpajC
	mX46eo2XmWAC+JrDfykNmAmpjTvpX+3nkyc0G6bdVvHtKrlPHKT/wKuzEqPcEHXY
	oCJTi0cZoCWCq7fDmYWiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728315; x=1741814715; bh=zCgsvPjZovXhu7lkJaKwVRC02XY4
	VjUSUu57r6QdKMo=; b=eS5d43RR6RgpEpordHDFxOMMesixxrneUSkaZhj+o7Vz
	PQW+v6HgVbimsgZ6vBKZnxDjEq02YLWZF9I/v8xsQHb+W9cR7vbvVMv5GkOSFmlF
	4KgFCp+UGEYzXkVqeMllvGRYCynlTPM3oWZ04ohRmsgVp+sRWUpW62hacvus1J3P
	vmDPpDMTjFc6JXRMIKi15zoQkmpYYm1RZf+plLlEjfsj0JuNMgC02BP7foUepy34
	P0RA4vGkug+IYam01swf8wUOo9KWeMo79HzlcS6+PHOiKNUtkV9D/D6Vhxq70DWS
	3j8fIaxrxKiE/NV+pMipVrzcuyiDe6AyfToGC3yEsQ==
X-ME-Sender: <xms:OqrQZ2Z9P63A-0kqKirpQyN90RpdtoAVYgdBoieTO4rTfdyOjWBh8A>
    <xme:OqrQZ5YksCQ2Tb6Yh4vBQN_QvWmHKEWjQZeHQ1okXdHgDiZ65U-xdI3SKRvy8tLMp
    DSC45kFUseSNUMxvA>
X-ME-Received: <xmr:OqrQZw-whqUBd1h1b5Nn9t-kJw7rkIPiDgyPmHlEm-cEuJPssSvSZb5rkEOjZKh_1ep0mlM4vf5jJVN1_emx3EfeGVVXaSO51Xb9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OqrQZ4rcPREcCibP48p1-BLjns-cf0DyIhMAZbpcilpcOpTyFJNOHQ>
    <xmx:OqrQZxqn9iI0BzmVxV54dVkLjb-eWhfQWQR07AhqexrHyio9S0aqGg>
    <xmx:OqrQZ2QeBZZJKG4CyXZhfVAzrpxkBxBewsZtG_S_n-6KTg9YJ-9vZA>
    <xmx:OqrQZxpaSagEVzjRnso1bMxmGAwAhwrkc6_9S8UsEgd4vNp-eXxy5A>
    <xmx:O6rQZ429Ib3HKQLlYP8Jd-64opEB8MqjNc_3FYB1Uu75O5449BeFsQI0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 5/6] t6120: further modernize
Date: Tue, 11 Mar 2025 14:25:04 -0700
Message-ID: <20250311212505.2920181-6-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is absolutely no reason why a pattern given to grep to find
'warning: --stdin is deprecated' must be quoted within a pair of
single quotes, or the pattern to look for the literal string as ERE.

Quote the test body with a pair of single quotes like everybody
else, and quote the needle string in a pair of double quotes.  Also
use test_grep instead of "grep -E".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6120-describe.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index dcb526e37d..71e261394a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -298,11 +298,11 @@ test_expect_success 'name-rev --annotate-stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'name-rev --stdin deprecated' "
+test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
 	git name-rev --stdin <list 2>actual &&
-	grep -E 'warning: --stdin is deprecated' actual
-"
+	test_grep "warning: --stdin is deprecated" actual
+'
 
 test_expect_success 'describe --contains with the exact tags' '
 	echo "A^0" >expect &&
-- 
2.49.0-rc2-181-g28e223d67e

