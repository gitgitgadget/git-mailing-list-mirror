Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E04B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306116; cv=none; b=JqyXaFHrG2jBwa+cPnNhJ3LAHJfhei0/OzJMYhJtR3IaJfcVfyOa2GFW5OQJge3w5MmfeQD5losNYe8lBJ1YbrErC2fVD+/6ocaimB5LiI8021zxOEqaJ32wNkkhoxW0apyjb+gA5HMA3ZOYFIjh7OcsHJT1eMHjcELu/clSGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306116; c=relaxed/simple;
	bh=jrvzBSQQJa0OZjY+b6jlWKIMAGJcXYmF8hH9nGC8uN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSDrn1At7z8rW9yKyy68iFqm3KeLOFmHWaWI49S62u34vkd5ul+KRyeUbhpfhcHqCJSymNZjjISXmlGDZcvIzUODrv7VORtGbU7yFedwg7SfIe/dE8bVlqTdQ00dh3LGHxuX3kWqhCeXI3SqD3lbjjsh13Mt9EeLeH2hgwimgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dQcMlV2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8sdarID; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dQcMlV2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8sdarID"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 01A101D00028;
	Sun,  9 Aug 2026 16:08:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 09 Aug 2026 16:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306113;
	 x=1786392513; bh=TlLDZxv7cRW+e0ioz5NAVcTpXwFtDG3WORhNaALehks=; b=
	dQcMlV2GdK/szWxvJzqvYKIWnfD/zm8PMv/ocDO3TqZ7byjXBeFKMWmesfk9WGMZ
	/G/J/Zft/PpzFzwRJeBYC5ZqPKRST+wds9rFTGvnIaY98es0qDhbU8XVoXgt5COx
	nUsoaxlHXEEGdZTeTG53PZI7iwzPSG8kH+AqAHfrMvs20JNo07V5i7p8qcIomB3x
	4OAoMgLEIlTtN8s01s1Aa8x/L+XiGpm2z0PRMgHgAPh7eK6Nqoaw4oYXS/rFBoxz
	nykq/Ro8YGLt7ZpAyz+yLAFPaDYGSoDDjcXcy1zL7VPaFye2RV80OUGMRt6WjaDW
	Q9d7wafkkxHlcSaDchAN6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306113; x=
	1786392513; bh=TlLDZxv7cRW+e0ioz5NAVcTpXwFtDG3WORhNaALehks=; b=c
	8sdarID8pgPV5O8QibASq6mhq7cfzLxmzKE5lGoy0TpznhVOJvg2XEZjQxhtcAzT
	IkLhFBy1qqIJ5vpbS8Ezqv+1A9puFkFzb6qEjVUa9UbkREUjJGuRNFz9+vxLAeQq
	d4X4K0orih0r4qeNitw4kRf4Hjr2++ghzlCarfArNMM2b0myWCtBeBKQBVhRHgzM
	TKsIAM3O57j6RWeDBYq9B2RIBDZUCUJ4sPEi/4DZHlb1jRV7hfRMhpkTxSH5/ULZ
	qDFEKS9WCZ1k1uaoBPMaZ9HK5/XR2GU8OlkfYy2CVafxCj6X1Qc5Hg0oefmlCaHI
	tmhF/zuP2abxD3QWcE9bQ==
X-ME-Sender: <xms:Qd54audyp5sTunInA7wCgS85nXaCcEhcJ6iekElONwFP4R-XBwOSSAw>
    <xme:Qd54anRx5IQhne3mEUqSJuzv6uCzUP-DDBPYMRQ_a4h9tXqdsSzbM2StONc5tvF1v
    3Eieea4od29fBBKhYBgBZMcRUjcMSyA5uE0y6T26Jyi6i56Qmnmqw>
X-ME-Received: <xmr:Qd54altEr5XzwZkUsV7QehaYkLphN11BPCYIDr24N2z8OtNaB1VrSrlTQNFFLTbZI5lsWLsLUsrDZqUh_FaonJHjrZGbmSEEgXhytG5aGfNPTA68p9kmJLY>
X-ME-Proxy-Cause: dmFkZTGDgrJ11887wtahT2bOh7OYHsQUBgHnp9OycZqCDEYNX5Ufjd0PxPUgc93BAA44II
    4K3JRUK1n8IGY3QHnIosZnp+TKJiHUC3HOsCfTBgty9wfQwVRAj8BcVCtpdQi8RC5673Az
    RwlFGzPD8HVQuhjfthfHqTn9ng8YBO+NA1cUY6G7k74yuCagrr2gUe50/jCZjzfzptmS05
    td8pBKp1QKamNnJ1jFU+YZ+bN8W5Q8gJDQeRlu7rp3dczGUnNahSqgfh+rN9l2NjXUq6HF
    UEEiPcsIQkA45TEwZiJj4fqDyM1u+4fxM4QCyl5fNuziPGAG1B0cjqT5uyOSEMuwJLvOqL
    3F7YA8PJI0r9luDET+bq+C8Com3D00mI4EYr67qj+SL2hXm6EgnPdboLtHLkk1yD7nnLBM
    SxyVYwRhUel4jb9ML1wl82DwX03Fl0ks+fVhVuY6njBKts3C81f5mi6bnSTNS2IH59Fl8m
    f4rZvrV7xYC1YSvDzZcD4cV68ibP9H7+kPxdHSpHGMA71uSFwH/qwo+qYHEjetDIZrlGO1
    4cj3EEPNjsAgiqmelWHvzA42lPLXsf2sJ9A0i3fnOtdBV5TyffdSdawLPZLLdQ5oyG32NM
    R/mz8TMy0aZDgTPDLvx+ZxeBpej41vqkh8mWAkwxeESNK5ASxTK3wID0WG0g
X-ME-Proxy: <xmx:Qd54aof61pXDRbIHmgjBmH7b7z9NfH8291fJ1YIW0YtxoBeYr_0rtQ>
    <xmx:Qd54avaDUCCusOn72kgdWp6kPNTPNnk_z9uTN1tMeqROijUKQFOfsA>
    <xmx:Qd54aqYxV_S-io9oi3SKJYqyW4ucz6rydKklccCb3p4m4gzwzTvSgA>
    <xmx:Qd54akKYhpsxQkOIGVY3DbMRq9q1onwPlkQ2KxxwZPMlX7sUJgadJQ>
    <xmx:Qd54ahatUwrDwSMpHNTjYZovcBkpOTirulXBr2a6RtzlA5IMSyiuesiY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:08:31 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 04/11] doc: interpret-trailers: not just for commit messages
Date: Sun,  9 Aug 2026 22:06:28 +0200
Message-ID: <V5_cmt_msg_or_other_texts.b2a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command doesn’t interface with commits directly. You can
interpret or modify any kind of text, even though commit messages
are the most relevant.

The git(1) suite also isn’t restricted to only direct commit support
since git-tag(1) learned `--trailer` in 066cef77 (builtin/tag: add
--trailer option, 2024-05-05)

Now, we already introduce the command in the “Name” section as dealing
with commit messages as well. That is fine since that intro line needs
to remain pretty short.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 5e776f0059a..ab3627c2cba 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -15,8 +15,8 @@ git interpret-trailers [--in-place] [--trim-empty]
 DESCRIPTION
 -----------
 Add or parse trailer metadata at the end of the otherwise
-free-form part of a commit message. For example, in the following commit
-message
+free-form part of a commit message, or any other kind of text.
+For example, in the following commit message
 
 ------------------------------------------------
 subject
-- 
2.54.0.22.g9e26862b904

