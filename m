Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1E3DD533
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615096; cv=none; b=rEwoSOozcpzvgAZvChHujjMQGQ0X4rU78PIZmoXBFCYgxPVjhMKVDFAmQObA1b8Jf8is6s5jQNpK2RQRnlMv9ZI27c4KnOPzyXgEkrFkzEwekdEmDaYJO1q2NfdLHR7G58AS3QRNPVXzOaurqVjoAvNKiSWIRB86fLVrTsqgFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615096; c=relaxed/simple;
	bh=ym2+H/tNPtKhfo3gdJDgkjJzAW1205uTJEPRej6XUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxGiC2Nb4msi+1QmpAQqghHWM9/m+yio/w2vzGgJq26w2w1WbvkzKyP8CBLEj6uhuNosD8OXY/M1u1cuungr0yq60FXh7uSmaNSCcN1MX6UGyIFZmUexSjFxdwG55aXTeY1rHvHROUNq/od4EAvHC+TxUjUnj6pC0Nl7goJ/pRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NCzVvV3x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VuxXFAkD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NCzVvV3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuxXFAkD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7715B1D000CC;
	Thu, 13 Aug 2026 05:58:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 05:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786615093;
	 x=1786701493; bh=UhahpWAz+k2CZYhYh/9dBEA3mLfyOzPrZ0/svCcBhF4=; b=
	NCzVvV3xXHhF0RqFBLNx8QLyFMPmoA7ntyr+EcNoNHQduWT3SlUHX5p0IxUF8sXG
	wSztuxdC38q3qUpT4fzn8IBKndFMDB2+Thv/67UT5tvJyVnvNW+QZ19USYntqdFc
	kaDesRirpfts08qHfT3cPWogrdyPbWUuDKit2N+PCSIy4T1qWQGbv9dV+cdcTjJr
	Jc2tItWbdYCHLWo3d2Xz4Tif6KL6TKgJc4ugwdkKJgham3Ts5fJsOItwefvne/Qs
	BI/ngloOgedpxdFOlgy6rGS8jXvfATlSN869qTegf8nBBsoKzVx8UvNiasY/MrKn
	dp2gaUSgf/gI5C8gWg0AVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786615093; x=
	1786701493; bh=UhahpWAz+k2CZYhYh/9dBEA3mLfyOzPrZ0/svCcBhF4=; b=V
	uxXFAkDySHkxLyeHfKdRoHG7VFZYac8HhrEPpkjAoUDRfE3umoXOtJ9iALOISfQs
	IWYGBZ4F1PEJwlk30B0igKxlCz5AXiFeNE8oeyXcbzXSaRDHOkkvyspkdrRKa2tS
	bfISoYTNTmGRNz7K1eODeF06JRp2rgsmviVLcEk0Seda5qdN33qB90SlJ66LV/RO
	GvGFhwKlzJECYSc4aDPqS17Gz5fzX58szIV9I4EFuBE+XM6QrPCaNuwt0M0l8Hdg
	Tw2WVuammC2WZs0McgTuFRX0ryOney6TYBpOOEwMORMASEEWKcGw2DsfCKkSH4GW
	+muqT1yhZuA0sj13nEP9w==
X-ME-Sender: <xms:NZV9amZvKGN6l49_TZVW8Aafnt0TW0aFdOTxyGELnqOa5j0mYQ0wnOs>
    <xme:NZV9agbTgxWf7S2yO4-E2PfkDgp3b8ZjSAemuL-FuYFWZ5nTXkaKry76nqfr5pfId
    R6Q_borSuDnVmKHKZR9lGAkBl50nB2EvSIT0lB3_Jpv82Js05MNxg>
X-ME-Received: <xmr:NZV9al9LKsR4fFNaT6DWDRAZGY6QxPQtm5PL3uU67_tE_gCLCw4ENM5CjC6vojEAirHo4lI84IqkQF_bdqY-iOfghXzvrS4MOyQMlbY>
X-ME-Proxy-Cause: dmFkZTEB6ZnIp8K5u+ZHg79f5VGN0v6Xyr7YwESrQVj8tfGHQX7/VJN8N9ssagmFQf0meo
    lFMaOK2he87snGZgWGFW7oS4mdn6Td+cNYiOwOF+jvd/U5MpqSDgnrgjxDpk/tLLrL45Co
    bnrpr9WzPn62K05OUcIrOTv/RiikbG39prGvuC+1nJigHEyGrhtuIXhmuCa8QhZshindsC
    tvmjEuLk4apZZQQMawEociz+OoXd1epfr3ygCLFhGPG+TLLe8u12vewnOqCMFP74BquhCY
    hi4LWCj8K6lR2kigwP6+kayWdOA98tbDHCyFgETBK+S8Flw8BJ2n7/rApNje0SpWDaN3Iq
    ryyVE9sIWN5NtFnFUVITOKbyJ+8Il9eUChGMjHqVTkA3Gzaf8Gqpc7DIaD0ZPuCwjOYOIN
    i+hyVrD8O6Ypd8KhTv6zIXP3HQWeN3ekyBFNIIZx2RjkKo3WzGH5k/9OlwF0J6i2fod75a
    zgyxM/g+D8Xdt8TcZ2/Ibul7r3gbxdy1PdFoEF2ekXU2pEN+rQWbfiv4JlDzLsSzGWBqiY
    kdLxUasqYVfR9sMF6SBwI655hOtV2ZD7skMZ9dtvZpO/GvM0c0L/t2qNtEM2S/tMY7g+a8
    vQnrApFmEi8FDWZuC1Yz0X8g9R9Huuys6SdryHuTBdQQlyGzBsgTVTUZhUwA
X-ME-Proxy: <xmx:NZV9anh_bTx_m75vdxiD_PV9Gv5sOYoZ0GS4UqcB1CTGmA-ivf9fCw>
    <xmx:NZV9atdLBlsXR6n0dEYKGuLIMkS2fU63oNXRT9HQ-bc3AQV4FD2kjg>
    <xmx:NZV9amrCmxSCx5Dti5FFD6zvm9Q1j8wVk8LQ18sQ146yxFgwt3-0tQ>
    <xmx:NZV9aqAWoGQQL5D6UCMF2CR1H8gSgQJzuzW-EQ7GOeK655lqSH381w>
    <xmx:NZV9av4KE7Q1abpSjOPAJrvCRkopn-k5szLdeSsPf20sFcMxMDeYLizo>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:58:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 1/2] doc: format-rev: quote subject placeholder before and after
Date: Thu, 13 Aug 2026 11:57:35 +0200
Message-ID: <V2_quote_subject.b4b@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_synopsis_block.b4a@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V2_CV_synopsis_block.b4a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We first talk about just `%s`, but then show the result with
quotes. That is inconsistent. Let’s use quotes both in the format
as well as in the result.

The implied input here, which is not spelled out for brevity, is:

    Did we not fix this in <commit object name>?

Which is then supposed to be formatted to `"<subject>"`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • [new]
    • I wanted to add this after spotting the problem in [1]
      🔗 1: https://lore.kernel.org/git/a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com/#t

 Documentation/git-format-rev.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 505a52feccd..19241837345 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -93,8 +93,8 @@ acts as a _terminator_, not a _separator_. In other words, the final
 line or record is also terminated by the terminator character.
 
 The mode `--stdin-mode=text` replaces each object name with the
-formatted commit, i.e. the format `%s` would transform some commit
-object name to `<subject>` without any termination. Like this:
+formatted commit, i.e. the format `"%s"` would transform some commit
+object name to `"<subject>"` without any termination. Like this:
 
 ----
 Did we not fix this in "<subject>"?
-- 
2.54.0.22.g9e26862b904

