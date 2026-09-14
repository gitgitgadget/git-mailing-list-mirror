Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45F3D88FA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392705; cv=none; b=GuybwlLBrFIgzKG6qO0U2+YwPt/gZFLY85j03casDIWdzDDZja5hf4D0/JfLldC4IQHka0uEVesa0xhSmwL9oUxtsPpEz0EbXC82DIa/0W+PyW31WzRrnAM3OXVWCCrh6WZxnm3ylBmaAOwuHDKq4HRZGeBg5Xv1+DSR2235un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392705; c=relaxed/simple;
	bh=ZGGWOiD4uK993AbYm7B4I4aE8ijFkr8QbwY7u43wMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1p9ac11Dzz51qy/5QqlqLB3nTZf+pvcDOfRZvbgnAmBy5LuGqS1WykF2cAzGxDNsk+Iz9gxnU3TUHIKmmgxJQSGOYJChUSEr2LYHJiqOAPbU/9OYEUY5bqCirMZiggrwObtyimFgAllRIFfoBgTpzy+9KA6bmY4Yd0cCQ9CjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name; spf=pass smtp.mailfrom=spwhitton.name; dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b=L4MYLPOh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jvjyd9zx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b="L4MYLPOh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jvjyd9zx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD32F1400078;
	Mon, 14 Sep 2026 09:31:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 14 Sep 2026 09:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spwhitton.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1789392701; x=1789479101; bh=zk/YPwhJcLVibe13hUbi7
	McsGaQharlMfV7CahXBF1A=; b=L4MYLPOhYnTn3sIfkFp8wtsuD+rrgIvlOvH3c
	/ph18elwWK/U7mI+Oy21KwsEruuVr3JpF8Mgy+ijQoNv+F9YXVvjClBOGBSG6hMg
	4tICF96jfd4lZwdzIgHRu8B1SmF5XjB4OhERZ+/xO2xnk0C9tewsdb6h2w35El74
	AqB5SloXOmJPmBlzZfXXECg8+SBqPqWNTY1LVNxQGtfIaxxxBJ/c6nLeKmmWIf7p
	HpiZ37q8Qy6Ou/B82RRwAEcYtqC8tY8TeRZEpQg1sSYM2Dm/c3CYHZAYoBkd4xRT
	jP9h4qg/IEByJ2IZjnld3uiE36wL3GVmf4tmPgBHbQsI/ev7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789392701; x=
	1789479101; bh=zk/YPwhJcLVibe13hUbi7McsGaQharlMfV7CahXBF1A=; b=J
	vjyd9zxf8pG9gx81scqfjU8JCgh1cyZcB+tuhFoExQ41s/c0ykoGLtrtLOIIFVUy
	Ydb5fcW6+ShtF1zQg7aboYfRljg1DODbs7VMc1+7umXIEZ6Tp/yJeYebtdbdUH+G
	LpW0V79WbuPc5/dAOGgGk64CBagL+2PVupKb0EB6qtovfQmgV+jF3st7X8DH4fNe
	bgKJS30z0mCYubDDSCRJUjthvo+7fE9syNYAJkh7H0Yjg1bzqry8OJzMTy3aQ+fu
	wJyN6dTREFwnDZZbwYuEe3y9NQklgRV2DEnUURkSjun7eSI0u6CtKcnapXcm/uPw
	DhHJQQVhCsHBFJ4fIiQvg==
X-ME-Sender: <xms:PfenatNaQId8syt-OESg-qVw60wp5nzHP7IcVVIzSIRFOd_z0BdQkg>
    <xme:PfenanvBTgXJ2Nr7zLr5iGry-NKLxB3e2EuOdjlddpt0dkV7YF6zyvqUaXduvgQ7J
    XZKa9LSgyo8Y6eIqU-D-h8ziG5CJGlzlVHe3q21UYw2x5izZzFpXmmc>
X-ME-Received: <xmr:PfenavVeInbxS9eKpjQjfhPGw8OkejJMy80SAwnUVnQUO3FgV8QWd93aCcIu2vEEpjjcb8cy0xWogwnpcRyo4b2LvTnm0q1-TQ>
X-ME-Proxy-Cause: dmFkZTEo722Oksm5JvALPrVtO8RyObIZgy1/7xZQ6OantvkeYJW6nxE3m2xDCEnAYRUtlj
    HQkaMRE4ES1Nu+qyX/y8Rv8qy70kh0YX+eFN4xqObikULvFa076b98sRkF8Oof8aPIlCBw
    7p4slWmvbHOb0wUVQKA6f1cdkA5OCsNMfTos1TNG8d+ivtmYWRzi91cR1dEVd5jKfW91BN
    K2G3rG0bf2Sj1CHpLSpcdfMZU3zWRmrsYi3K0iLCOVLGvC/ixmgR6fDZgGk2wOKOABjgRC
    KDWDgl9rnb5aXHfHgumNxu4AHpCCxuhBRzBkmaaQM4Gs30/wTuEmMYuZMNbsEaqfpVW+pn
    qHK4SBRxrdfdX+9zq0p9W8gGlLSU+Gb3aV/u1UsO0RkJlxXof+wlX0HHY/4a+hNt5ac4tU
    wpvNf7P5Bwr2yvWLthyqzSuKbDGdH39FcNLQByHruyeQck4YHypAQ3qkcWlgivQf/p7j9a
    P96xQlLLLBjby70XIMH2BCTAgEXv/sPDGZlhIFB4MujraiR0IkqpZ47cToVjecwK7Bip3B
    VPPZllgrkskHwraWiKFngBFObpPv02DswSImunSEghWk/t1am162xYdd2H5ngTch5V1r+l
    JUzdl5ygSNhoHnJukRjU/xrI+6VxLMCTuZZeJYZeQHJkY81tfk5ByphoYiIA
X-ME-Proxy: <xmx:PfenansNYDiTyKBWpMoIJj5ovAwqbVLl_UUQOB0WICiJezk1fARYBg>
    <xmx:PfenajVJOdIkLjTlGYJzoKBRMv5c0X6fstV5qig10YKU0DC40XyLrg>
    <xmx:PfenaimKNNAVuMoAlPOogFo7Xum0B3WMYoYDYpOBnGN5mtS-Ly4QCA>
    <xmx:Pfenaka3NTRPnzusxbX1jdk_QyTobqOfQBnEN0vshyS5UFuSk-MUPA>
    <xmx:Pfenap5vz46Q_Mer30ygW-eRPG4orKfxJZyuOqUulVG2cZU9-KAEXekw>
Feedback-ID: i62564b17:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 09:31:41 -0400 (EDT)
Received: by athena.silentflame.com (Postfix, from userid 1000)
	id 64690281042; Mon, 14 Sep 2026 14:31:40 +0100 (BST)
From: Sean Whitton <spwhitton@spwhitton.name>
To: git@vger.kernel.org
Cc: 81625@debbugs.gnu.org, Lester Longley <lester@ieee.org>
Subject: [BUG] 'git status --ignored' <pathspec> matches partial names
Date: Mon, 14 Sep 2026 14:31:40 +0100
Message-ID: <87ld94klhf.fsf@athena.silentflame.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steps to reproduce:

git init foo
cd foo
mkdir bar
echo bar/ >.gitignore
git init bar/baz
git init bar/quux
git status --porcelain --ignored --untracked-files -- ba

Expected output:
none, "ba" doesn't match "bar".

Actual output:
!! bar/baz/
!! bar/quux/

Credits to Lester Longley for the reproduction, in Emacs bug#81625.

-- 
Sean Whitton
