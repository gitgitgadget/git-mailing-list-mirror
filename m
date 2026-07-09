Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B13EF65D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585774; cv=none; b=VcKo4lRnZDusz60h/oJ9eSk7CEBRvkRICLqo9o4XeRhy7AOtw4U1+Hi1Fm6XftjHaSTh999jN31aaJUuaGVZZY1L79+IMOPX2Hx08pM/9IwKQEU7C1aIciZ9frCxsB6zQK0uOaJjDd/omNXmfPWSXdrD8tEZ0irxeMt7rcGnD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585774; c=relaxed/simple;
	bh=F23fXBFMSZwj7vWQw4fjgD0wyghgtARn55X6qeyXGD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAuvCXsgFo/xOGrOchPmS31TNqRMAMhuMA9LpKQbOsEbhzgO7JTRbm2g1heP2+dHrZTyaP6SJudgpLZ8gTkU+3QIYjKEEgeCzmUpBIPwXDg3HmSYiGyXp9LwTgOx4YrPzvysvdO4KyIxh2aXSyx9H6Rul2k4Gt4ySv2RzGC40XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sd+t/icS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAt6RoSR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sd+t/icS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAt6RoSR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A62411D0006D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jul 2026 04:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585772;
	 x=1783672172; bh=4+kRhZJGfG5MjB0xxBTKUC88NfYv53FeuMNCTTW2I9g=; b=
	Sd+t/icSA/mFZ2t/1KYAJwm5gccY70Sv6rIx/9zK3ZqPtMy4OE+eg80Oq5pOq7q5
	u0c9Qm8312qk5W7HTMSyCgkgfnDBL4YByAt87tzOxMQDPziEbTPIi7DQNi+3XaFW
	9radqUZdpT8HjucjavM+J5SCX9mUr0QSNYl9pwBmOM5v1FGNAI+vpFq0ZU6yun3s
	ZzEi7QeWYtwSGj/MkRJ2djwju6g7DoJ/TdmUVi+ctbar6yfBEeVTFVyHgxEdseof
	pZUCS3fC+4DgG/zx5oc3GTUS9e4UhGhpX11aFq2gXKH2r9Y0c/B5O/XFIVXnZ7Ag
	O5KmsZbefIYK9f7QeEV5vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585772; x=
	1783672172; bh=4+kRhZJGfG5MjB0xxBTKUC88NfYv53FeuMNCTTW2I9g=; b=E
	At6RoSRvWccVxIurJFhEr0ryVxBDQZDr0XgOxsivbiijGELwntRwCbZRaeNi+tW7
	CfmgUNA2rPUunnSAvsp3E9mn9vuPN9EP9BTaCQKcks6uKZrFuEdbLvamQVjOwxqX
	xjwmnuvYAX6piTRRXm/2GPpS7jS7TjQWg36UJTKbbdwGjZfLDrtAqUJ9+E3KN2nR
	CqUdvV+CcMgrRhbr50ndhgP+P4wbGAq0seuEVbpjXupYZBVv6j/H0egw3Plwtx4B
	b6TcXVmRoYTlK1nu667zTmIXmc02Fn81krkBRvEUYv4Bc5oCdA9HdPZZIqSOKdCy
	std98u4FDLMzXMC5dxOqg==
X-ME-Sender: <xms:7FtParyO-XefKjeyK5mGH2l6PAAJ0pEx-mx7evKz1CRJRWbMwiIiig>
    <xme:7FtPaqPCbo90tQFzEbsWPM_Adhvb7foxNR20HdwbwKZnMGV4iwVh53JMcbJiPxfi3
    t3XZSJp8YK8zGLDXyvF4JXi9OhjIVnCiGzC0XZAsymFKuBloyMh>
X-ME-Received: <xmr:7FtPaq-8bdlHyWFEkby-OgyriELoLXa_N0x2iv4oci13y6VD7SFSY5bULY2Z3EFJqHoBZ_yydNHsHljkCH597TWz_swI8_rh_XoF6hgwHQ>
X-ME-Proxy-Cause: dmFkZTF2YEkw3GlKnf422ZK5xSDrgKWTJta7tPPIkHyWCqHXCKhy5rtZsPXLbbmOx11qNK
    Pq4NZCgekSLabKFJ43kuYWKfKAOmDfq8N6a1JoNPhUlfj6dFYJE32jv/GWoLkGuvVFvYh1
    zq5pAouDeRUsL7DtvG9WnhKri5//eSQZZjV205PnlKxfoMR2D8WKzcW+5Efuuzpr2cJnnS
    iXk7lznZdezxn0TNtGMP215ib7jqCP9HQKWJoii0a3xtmubVd/K/r9f1knEQru8T7bU5Bc
    MyK05X0vc4MRvefkx7V9jZuMzTITaSpZCVzHdgtKrnGLOgYuqJ/vCFTZ+NjzkcKPwIYZWI
    v0gJ3aF3GzbjSeCnDlUFl5OIl6mEKym16a8VRkVc8eCcGghhXSXjD/uhelANDX5+3K2cys
    YE2UhkqNp3sEv6FsDiaYCj2NkKpdoGif0g8nVn0DplCogUYnt70iLfHjbQl76wXCY6Ht7V
    dbBHXSXM5rOc12CfPPzWBalo/pMRAG7+ga1nyR05bB2097Qhh/egiqrS1DE71mdWMsp3MG
    N7xOMJ+ZiJZh4Gr6xGNifX2VfJS2oVtUncED0jFSLc5aL84+hXHZm9jG7HoHFKlufJDWKZ
    bxfEPxA7qSuZ54COaS9B/z2ukCDxyu/uQBHuiuvM1U6Ggh7+y+JmhS94dMqg
X-ME-Proxy: <xmx:7FtPaqoRCEfhq95WtZwS4PLYyimKJyX6YxsHm9CcYRbhVIjeqZFK4Q>
    <xmx:7FtPas42K9TIJ7xiT1Nf1EkdLFzlVzw84EKIbYtU4-r7syZwh6x4tw>
    <xmx:7FtPaqNWNhU_xdsqhK_k1Uz0HQmdsLr4DjsIT72kfhQHr8yXn_iglw>
    <xmx:7FtPauNePCHOyyR6e6a4usgYtcB0ZnIjJ9kj8r2YrrmjbmT6d62qSg>
    <xmx:7FtPapwfLDx-aJV9kVyUvf_1zUVb5dVMIcYjSiuHR__6_UQWD9DGYi9V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f640912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:13 +0200
Subject: [PATCH 2/7] refs/packed: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-2-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

There's a single user of `the_repository` in the "packed" reference
backend. Convert it to instead use the backend's repository and drop
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5c49c06493..7d0a4811fe 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"

-- 
2.55.0.175.ge4962bd3d5.dirty

