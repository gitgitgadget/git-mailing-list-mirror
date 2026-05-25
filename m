Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E63438B5
	for <git@vger.kernel.org>; Mon, 25 May 2026 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677932; cv=none; b=pH7kcAhhXzbf3qJyP2VGTSqRGDTJQVPJdl7IUnq9lzcTPqcq3vdbibHmhmy49imxrnQFOq9y7tdDnSAExb3ZYbF11wHHwuySd1suJGSkekI/AOqbyQ2qr8a7cdrmQx9Lhf2JQFhHf+0R7ybhm6mqTBemgMn4FWccEg+MPr7OpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677932; c=relaxed/simple;
	bh=KZJGLcWeWzajH4md0IUWhSG2iArUrjCTy+2URPeSC0s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jnfb3u8qUkXEnDnckJ85wryfDDkfdHdiFhCKgL4g79HCHYjVCaDC/Z2gMRqyAOyIpWPiA395IZEdB+mVQYTyaGkg5ZIi16ZKxu8PYSRPmTxRBJF02P0LyfVwCla9kOhgAvWsboK1nUrZebImYsRMCrFjCsBltAPapE87cJSjVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LQowV3qv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ju5O53oV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LQowV3qv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ju5O53oV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5EECA14001AB;
	Sun, 24 May 2026 22:58:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 24 May 2026 22:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1779677930; x=1779764330; bh=HuHRsJ1qXhczNuYvj1HxJjMQYgQbS+X9
	D+RM95eZxbg=; b=LQowV3qvdbAI6xarYKQWGh1SUlHCkHFAyJCGdWWAn89coI/I
	ecCR2POaSa4NvzNhOeyJzZElLgLB1z3EV+3cGYjxG3yN3qSynkBI1YTDwntlRRun
	xS10hUo8Zvo6U4XVJ0oW6rhJ4Kf32FbI9bP96mnJxp5t2ydESSIegjrji8pj9XAP
	fDH3LPYSLueVOZiTZCcSncfOCLDLYxeI+sPIeaUIf23QtXeCe9xvtn2/SadYftjH
	RearXqInDMXP6ZaYUUl1KHIMbM8R8V87F0j0pj09pqEOBLAZu4qOe9uqCDplYKq8
	znsgI+SF9brnKQaATSNSABVuBg+Q8AXHx013qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779677930; x=
	1779764330; bh=HuHRsJ1qXhczNuYvj1HxJjMQYgQbS+X9D+RM95eZxbg=; b=J
	u5O53oVeCk+B+ZFGYYmsDymsz8zMCHi4FcVrCVq5JL43rKidXgq1uQHFPo/JnZ9y
	urLDm/7EyAhvlwIWhgZmPoPFKcnRRu5vRbEmjhXra0CYXGQRE/ammT8N4tkgV+DU
	2TISyz1hCMNS6vhKxYP4LE9ElnbDm1uHIZLVlPNYDPdXci0zA9jb9bULiIRJ9gl3
	FVSdk7n6Z7puAHW3ur106X/u1I0wUqmIKUNz4e9+7nF+PJ9GLoMddvEdWzucdqSJ
	fSp0gFCJnB5a6Iw4YzMFMxD2qGYBF7RjojnP4sYm+eXzsbw2ZBCPbmiyvl7ADPbZ
	LP6dgBGxm2Gw3usuwZ0kA==
X-ME-Sender: <xms:6roTaiG1FGyGsaj9p6A-GV-HWANr5u-KEauhGiSYlA57vfpmjKPryw>
    <xme:6roTapVkjBDbLfDS8O-zMj1dVEx6zH3jI_PRdexnFEAwS41Fzk1SAWQRc0SeAAcva
    8rD_UIILjHSzDLAGd7Eyear3XALFm_sjVj5mn70Q9tTeUuicl9h>
X-ME-Received: <xmr:6roTapynyVHZEQk10BJYtWAUaEXt3UE-CfFAmA_oKQ-DTZMkANN9Zye2BIk10ZdlgnoAMYuRIWLNbs2kXkX9-Jz5dREhgF2cSIsX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepiedtffeikeegleeltdelleegffeiueehhf
    ehvdettdejkedtvdffueeigeevieetnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6roTanPOHPNi6un2ODZzdxd4zV9RrxsBAZmvzHpJQpFNF6xgOfg1Ag>
    <xmx:6roTaq62iVojWHDmWYC6y_9r_CKqvUoO2yxJUSrT9c6hsGgp8vhRvQ>
    <xmx:6roTaoMHwzDlemTK1EJsWip_JMYUPjZtK3hI9xohKFk8ESsk1HvOnw>
    <xmx:6roTaomXIl5LKMER3ePqYxgIR3rV4JFw6y0hBNttzywedDTsyAbFOA>
    <xmx:6roTatfnd3SvJHDNH7-_pgkrqTr4db43GvRFx3WIcq-9mX7Xxkea2r1L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 22:58:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: proactively monitor GHCI pages
Date: Mon, 25 May 2026 11:58:48 +0900
Message-ID: <xmqq1pf0gpp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Even those contributors who do not come from GGG and do not first
push their changes to their repositories on GitHub with CI enabled,
can still monitor the CI runs triggered by integration of their
topic to 'seen' and other branches to notice a breakage their topic
caused to the system.

Encourage them to help the project by keeping an eye on these CI
runs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e270ccbe85..ad2dce1998 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -792,6 +792,17 @@ relevant for debugging.
 Then fix the problem and push your fix to your GitHub fork. This will
 trigger a new CI build to ensure all tests pass.
 
+Even if you do not use GitHub CI to test your changes, pay close
+attention to new failures on the branches when the maintainer pushes
+out after your topic gets merged to the 'seen' branch to make sure
+that your topic is not breaking the CI, and retract your breaking
+topic quickly while you fix the breakage you caused.
+
+To see maintainer's push, keep an eye on this page:
+
+  `https://github.com/git/git/actions/workflows/main.yml?query=event%3Apush+actor%3Agitster`
+
+
 [[mua]]
 == MUA specific hints
 
