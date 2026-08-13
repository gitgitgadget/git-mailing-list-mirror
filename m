Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4293B5318
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615077; cv=none; b=FtUc3KE3/rgvecWN7CP0uJrTi8x6l46R6NDTMA5oHBub4VVmv67C2PxwnlnFef0DPwIUKdtbVfIN9RDdKF2r62O/u6/ff3gY7ur3MBEuOE9oowLIRrTzeuI+zODnGJ/stXYJ7Udk+JQVMmpItJzx6/ZLgZHp8pun6nHptOPadH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615077; c=relaxed/simple;
	bh=leNAXu7cd/yJ2xALKCNb2AGqpW3xkDpnYUswhuPuTRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=migjjs2mI5S/1fR/v+aWCUT7QTaAKj6R7+cPs/00kCMSUAPEVsYDgeIcwSgWHoSCcBre8LDvmLl6HkURH9SZoWnD5vcmqptroh9X2JNBR9isKc+DynzqAIM2kxz4kAEjCS0jD1bfHIbxcFSpUeAZDsDfYT5mG2ZbF2Nug4jb114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KjmHOZWB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/flNOvU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KjmHOZWB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/flNOvU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 140347A0062;
	Thu, 13 Aug 2026 05:57:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Aug 2026 05:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786615074;
	 x=1786701474; bh=8tzUPCE+k0x49J4op10IwRyFAmQqd8dYuzYJgGsrHTs=; b=
	KjmHOZWBf/+UaEdBlZgstXFeYlECH2owKcP/0HBDM38iyhayRZoSCTH/Z893SwnR
	FuBd/E7d0h6RKZrl0/KBtRKMY3Gv8MolvWyGs7cmwBBau4jk1dFxKtKA6m8JMowu
	Ye7XwX8HdCXvcu1WsN1eeDnB/h4QFGdnCzfoAMmGqpQ/bXUZKrRCq30IAkOksOW3
	b9Uz8mgacB7UPAd2a/POs5LrErAAw/Fww5eVsETTGDixjVtgaK018DGBHGICGKXD
	v80T84cPODidF7Af4IX6UiDyXbq9sTRHlQWDQ8ch8KKAC2fDjq7r3Ng19MWGhYci
	aWd7Vu15DTnWbyK63ytddw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786615074; x=
	1786701474; bh=8tzUPCE+k0x49J4op10IwRyFAmQqd8dYuzYJgGsrHTs=; b=S
	/flNOvUtL0gHfsDtzv5wSWbuYCnWT0sbckYJYjEv71vn8ZzeIRevlzjDTB9MB8l3
	XUXrDn+5ly6UktJCbpwuoeiw2vOtZd0qIyL393oeL1b909yAQuUP4Burt4Y7Q3MF
	zvPJJNnMK+fJa+6v9NSTZQoAEFxpgcFA9q7PBIUY2kQx4KRtcaZTD5weqxGFUHBb
	Rt+lxbmlTUEoRDum+7cziqqtGWGx+9cY5efjk5WeMFnG5COb6YnNZ+JFeUURikw7
	IDZgNH+XXDBqoYL/o2KoRxAuA2ZSNatselcrwt+Mp8v1DeVfXThuj1Y9vGGp3i+O
	0pfOCzKwkjFureQnOkZKA==
X-ME-Sender: <xms:IpV9akUYz4BhC77n4hxA0CJYsmdQJYEEZ4tZXZjgDgYK2Nlaz6uN6Ro>
    <xme:IpV9avkTxoBQPd-brF98NI4HbZFQEPXCsuHBG2YyJX6FYVaKHLXCm1W_QlRXvniNW
    fZsYv67mr99qdmRUGbMJMVR5k5JfyjSBVqunhuVkLwtAwMgZxKn_a4>
X-ME-Received: <xmr:IpV9atZEvo-Gfu8alZZWEbnJeDrusZVd6edbdnOKLrIwWcymgGseoL554wQzKPzOTRCxt8p54_grlBN0ccrlFtmUMDqkDXPFcgM_bEI>
X-ME-Proxy-Cause: dmFkZTEB6ZnIp8K5u+ZHg79f5VGN0v6Xyr7YwESrQVj8tfGHQX7/VJN8N9ssagmFQf0meo
    lFMaOK2he87snGZgWGFW7oS4mdn6Td+cNYiOwOF+jvd/U5MpqSDgnrgjxDpk/tLLrL45Co
    bnrpr9WzPn62K05OUcIrOTv/RiikbG39prGvuC+1nJigHEyGrhtuIXhmuCa8QhZshindsC
    tvmjEuLk4apZZQQMawEociz+OoXd1epfr3ygCLFhGPG+TLLe8u12vewnOqCMFP74BquhCY
    hi4LWCj8K6lR2kigwP6+kayWdOA98tbDHCyFgETBK+S8Flw8BJ2n7/rApNje0SpWDaN3EK
    VBA0EASRZpeUBITplIOpRKwWL9UoMuISOHrfxCyno/p084xRWSJQ4egUjdkwOZkgmpxLLL
    t9DEaUll4/v34KAgari+jtBPr1x4KPc/UOxnNlUZPsHs27YwkitWG2FYWg7XRpi+g38C+7
    2FNEkDMbnsx/gHXbQD0GCMfhNlhqJS1uAFfMuArLC9hyrHzwcsmrFY2r/jnsHgFuC3LwfM
    s/sLd+xXmPzEudX7tGuUKOPleztXHfH4RLErr9M9EMFgByz4Sj7GaX8eTe2ptHWTohnNQK
    z+zw0ay89sNpnpFFBmFdcMTGGaLirYPoHiG8NmcsDfRg7STWV85wiorspf2g
X-ME-Proxy: <xmx:IpV9aiOhQwgxxhkEPOZnFOCVZECz103ilICtRAvVsvd9Nlx6n8DXXw>
    <xmx:IpV9aqZDFtvMQac3JdYnNinpdeNZjFM92Tp0TFtgxolI_Kt5qXQIFA>
    <xmx:IpV9ao0_4OjpFfmp_nyemKkeUTnbl0v3yu32sEps89n5PK-_rrbajQ>
    <xmx:IpV9aofQegQtEZqXIGCh3lvmnuYEq1N6_8QzEG_oiHhaGS788JeIzQ>
    <xmx:IpV9akXqzOtd11K2yHwIZqD-Y6IGHcUfAwOm60iOO3zSjamTvKJuM5b3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:57:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 0/2] doc: format-rev: use [synopsis] on code block
Date: Thu, 13 Aug 2026 11:57:34 +0200
Message-ID: <V2_CV_synopsis_block.b4a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <synopsis_block.af9@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-format-rev-1

Topic summary: Use '[synopsis]' on code block in order to highlight
placeholder properly. Also quote the subject consistently.

§ Changes in v2

See the patches themselves for details.

• Patch 1/2: New; see “Well.”: https://lore.kernel.org/git/a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com/#t
• Patch 2/2: Add a new commit message paragraph to avoid confusion on
  `[synopsis]` on-command vs. on-code-block

§ Cc

I’ve added a soft Cc (?) on Jean-Noël Avila because I added more
“technical” discussion to the commit message. Hopefully it is formulated
correctly.

[1/2] doc: format-rev: quote subject placeholder before and after
[2/2] doc: format-rev: use [synopsis] on code block

 Documentation/git-format-rev.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 836ba4b0c24..d6c2e4aec1a 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -93,8 +93,8 @@ acts as a _terminator_, not a _separator_. In other words, the final
 line or record is also terminated by the terminator character.
 
 The mode `--stdin-mode=text` replaces each object name with the
-formatted commit, i.e. the format `%s` would transform some commit
-object name to `<subject>` without any termination. Like this:
+formatted commit, i.e. the format `"%s"` would transform some commit
+object name to `"<subject>"` without any termination. Like this:
 
 [synopsis]
 ----
Range-diff against v1:
-:  ----------- > 1:  c82aec7969f doc: format-rev: quote subject placeholder before and after
1:  652198740e3 ! 2:  f528d7e9dcd doc: format-rev: use [synopsis] on code block
    @@ Commit message
         introduced in a34d1d53 (doc: convert git-show to synopsis style,
         2026-02-06).
     
    +    Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
    +    docs like this one, be immediately preceded by `[synopsis]`, just like
    +    the command synopsis is:
    +
    +        [synopsis]
    +        (EXPERIMENTAL!) git format-rev - [...]
    +
    +    Cf. verse-style:
    +
    +        [verse]
    +        'git name-rev' [...]
    +
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-format-rev.adoc ##
     @@ Documentation/git-format-rev.adoc: The mode `--stdin-mode=text` replaces each object name with the
    - formatted commit, i.e. the format `%s` would transform some commit
    - object name to `<subject>` without any termination. Like this:
    + formatted commit, i.e. the format `"%s"` would transform some commit
    + object name to `"<subject>"` without any termination. Like this:
      
     +[synopsis]
      ----

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0.22.g9e26862b904

