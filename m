Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DC188006
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942773; cv=none; b=ta8Lm20RyTkFP3B6s80Jyk51J4zGN9GVtCHhSUS+WtZDk7J4IqYDovT9VRj+lu4r5jOqVMY8+bM5AloWqV0qg1EYLcAXrN8wpBJVkV5h+WwYseUhE1KBSrAkMKAxAQqvVUJTjgRMpGOjy2+70fJiDIHEpHx+UFpi8uL32Xdi2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942773; c=relaxed/simple;
	bh=w1vbe5/EsYI/phzHHw3loIcvQNpmM9Nz/r2vjTKzURY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q21Fx4wrwaOOpWvx0ABuAWyFCW7UQP7WbhA38DdXjV+bHu7gPW5NKVM9fFjSTj8AuleV6qc28W1WTBTeNE3YfozR6YV5WiPmGq9YwnwkIBMT00/CNn4XPk4YatRwKvc/B4gS5JI1/kknTlZJaLJZpqcaaWmcPnnMY4E+t99SJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XZBTzkHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPKrbmdP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZBTzkHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPKrbmdP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DDFEEC0A02;
	Mon,  7 Jul 2025 22:46:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 07 Jul 2025 22:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1751942769; x=1752029169; bh=pWyP6h0DVI/SGUibU+hTy
	F90dKKoSQKyzk9qcNS9OjM=; b=XZBTzkHEtG8KK4lFM1doRW91CVRWODtWjX9M5
	PpyzT9rXDfVL5CWu6gaJ9bYUJDCp+ni80hMAALrgSYzr4cggA8lX/GJM84nP+goH
	uQ9EsUDNVkbkl3G8IbLKAu/5E/P5VH5TwyYlBddN/mxJEZ76iSEtAFvyCmtj5yXZ
	ONe6PEF4aLsMxTd6MVWFgbadk+R0PopEWXziWUE1yT5ZZ7LWLzvu5/i0hN+sLl1Z
	R76OKoh1sFFg+gkGMAWN0ot7vxZqiQFP/wjljnbeNiUgMrG1MlTddxoFd+pAVpU6
	E0OkX/2lnZxJK/lKRHRigOEVHRI2ndVhY1FjtQT+PO9PTbbRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751942769; x=1752029169; bh=pWyP6h0DVI/SGUibU+hTyF90dKKoSQKyzk9
	qcNS9OjM=; b=fPKrbmdPf0KMviDMvUm/tqfIyt2B3kjP37chI6ZifHMc4hcZfyN
	UkqUZB71k8BquLcQ/NDPA+SvsFzyojTse6h69kc3ZaCqiAmnb/FNgNa12EOwpiX1
	pd10aX6dKFglC4Ldami2lS1iaREhOjqY/IM3ExMoQKMoyQe+ittRhRukiBmJ9YNN
	/KqoDqBz/PNhIwb/K5cOZ2jfuFGswdHIb8988mQ3UD/bRw8fUTcr8DxdzEAK8hfq
	IuvQUTGO0KJklPH44S90RlVcEPnC2+1pToXmGTdfo8Qgi33m+jDZsqlOvG3NPe9X
	KwGv8puqEKYs6BM8Pcx1QYoV6vMr4Bzn9pg==
X-ME-Sender: <xms:cYZsaEl9XzjKcr8bCecaS77aY6H7nZtVPhBEstfuuu1WhOCUzbkD-Q>
    <xme:cYZsaEDkzMzilJ6J-gIjTr2pLVh3ofxyVgpnTSWz5SKLLJf1AWMKWv4FuGnQ8ZbpB
    g2zFxpvvo53hIp-97g>
X-ME-Received: <xmr:cYZsaEf4KFuxqR2eyMcamLzvRsPtmzV7fSRa-OvcsR-d3If8UtFZ8noF4K7S7SmQhxhAPL9JnVJnaGLLm9pgFAQ5R1AN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomheptfhushhsvghllhcujfgrnhhnvghkvghnuceorhhhrghnnhgvkhgvnhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgeevfefggfeivddtjeehueffgf
    dvhfeufffglefhvdefgeduueffjeettdevgefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhhhrghnnhgvkhgvnhesphhosghogidrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhhgrnhhnvghkvghnse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cYZsaPL9u_xOaDSehidGFw3wUZjnTAsqc12UxIKxDV6WPk-25kR3hA>
    <xmx:cYZsaHd34hYJLO7TCYAzzQkv4dQn6SgCuhEBP_jXWnZxq8DDh9gqOw>
    <xmx:cYZsaG16CmU2fq-9HZfLuXMxYcY9xeRezFEeOg1tN9ijFIkQ0oazTg>
    <xmx:cYZsaAgGwoOT1XiUtDLFVHBpT-kRatkd35B6t9Yw_OaPqw7Fukt59g>
    <xmx:cYZsaHLRLYKPhhkB_2AYseZTiADHGCQXL_g2CNLROHv_xE-IsVli1esU>
Feedback-ID: i0f414978:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 22:46:08 -0400 (EDT)
From: Russell Hanneken <rhanneken@pobox.com>
To: git@vger.kernel.org
Cc: Russell Hanneken <rhanneken@pobox.com>
Subject: [PATCH 0/1] doc: correct doc for glob pathspec
Date: Mon,  7 Jul 2025 22:45:06 -0400
Message-Id: <20250708024507.62386-1-rhanneken@pobox.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gitglossary(7) documents Git pathspecs, including "glob" pathspecs,
prefixed by the magic word "glob". It states, incorrectly, that the glob
pattern "**/foo" is equivalent to "foo".

I suspect this incorrect statement is the result of copying and pasting
from gitignore(5).

This patch removes the incorrect statement.

Russell Hanneken (1):
  doc: correct doc for glob pathspec

 Documentation/glossary-content.adoc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
-- 
2.34.1

