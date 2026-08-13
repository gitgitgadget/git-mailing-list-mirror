Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299134756CA
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631057; cv=none; b=XBsuon1iYqaMbeFTjHuJ6plE70XGHhZVS+aufS/k1Ot7UNPv+aHEUsSRvpI9NvEdYCLt/nwLHeQjKj64Vm/ueMO/+bkki2MEo3HnXqA3OaysLymI3sKtrsVbHmgH4tA+8o543uplEVxyeAlM18Yka5ydXNpC3jVY8liifXj+s0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631057; c=relaxed/simple;
	bh=ym2+H/tNPtKhfo3gdJDgkjJzAW1205uTJEPRej6XUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joh1KHF/CuXfWavx5TJUaOl5kWua0p3v9ptxcaqb4/FCxN40QCrE/vywhTIPT8aG4PsY1V6H9JTm0RasbVBD8ozTGwd5o2uIuP9l6WtKeGyHkzmPCiy6xDC/XQaxxKhRogLy/+U40FG+djr3GrgcAk1SwOYIuvuUdaJc6GbrKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DKCSvD/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgNUv3gg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DKCSvD/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgNUv3gg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 63D94EC028B;
	Thu, 13 Aug 2026 10:24:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 10:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786631055;
	 x=1786717455; bh=UhahpWAz+k2CZYhYh/9dBEA3mLfyOzPrZ0/svCcBhF4=; b=
	DKCSvD/OmjDb/9WszjDGzrZ0Q+Yn9MAKOHjX7+LdH4wpUmh0d3RTBit9oGLk+Cgn
	Ftm2unnyqTej9dIn3niUYoOsyJe4+91O1fhCrVZ5yVyhIS8pCnqfBuvpf8JlGBEX
	k2HRQy95wwGK4n8wYjQ3tVr37emOkMEp+E5RJ8cD5MgPS8fNWlF+4SaERznLEHRS
	JteAJoqbTykRh5TDMhNQaGBIwAe9b1FryxmoZaOIGdE1XtK7j8Wt36ah7PMbTVNj
	yWWXtMtuAwvmMYf8VTpDkSs5Kl+s4hiCL5AmEW9iPsjeJqLFesjtCT+LGLFfeulj
	Oq/NecDDEPHuctichRXmNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786631055; x=
	1786717455; bh=UhahpWAz+k2CZYhYh/9dBEA3mLfyOzPrZ0/svCcBhF4=; b=f
	gNUv3ggk9iULZKDmXRHpb0+jApc0eSovckIymn1rEKHvq8VwceyFh1xQp0j3nq1K
	1pLesuWhZ8X7rIfNsTv5YKflWwSzWC7J5o5p3+hk03kkTzz98SIU3CWL7kq3Liby
	1JOMX6YrcQjUuBLTWRJm4k2ZU/fMMNgJ5YqryPqYyeJud4G23sNYsfQPVXSw6btX
	ZvBJ+LCOq2iW9ku5OdZk/3eQqL1kdCnurNPBiDaOydDjOPMase+a2GmxZx7VyX2i
	ujPnPahweuDEa6f1BT7uu8PwULgnPQhflynXrIx+0UE6n9rQxjGQ/xbwmJvqpV4g
	nMRiPQBqMqBPhPz3O21mg==
X-ME-Sender: <xms:j9N9avOoLDtC4BC_ovX1kBeJgLcnJtvywey4F9k4F7dY1tnsZ2gskJQ>
    <xme:j9N9ag8CAS8Iaio10QeEbpZOXUcvAjYWNOYP81x8t1W_0Z3m5pGUeAkOu474XfksA
    un1HdBx8Q4wqh6sYRyYLkIXOU4EtVSVsaRzfESZSH2c1ShYbtb_lg>
X-ME-Received: <xmr:j9N9ajRoBUHTx4wiLE_cdDAHJJmDhq1u5c08mHjVUO63dEUbSxz3TdM_Q_yu_rqJPiDenT6Eaavz_iFeayyFiFIiiTmuSJMMbkL53y3ZlhcfbSyqJg>
X-ME-Proxy-Cause: dmFkZTFxb1vDiiJVsTxnnMT4JeGcT/LTxcqf8saTTK6TYmFccLeAmYAmRs0RussylGrhnB
    36JBcgASYCkSo4Bq/Lbuu74bBPXnQXxO3Ms/lHylOTqWPH/efLScHqQgRi02xPtLXGcm2r
    L8cuY3gWrZvENzK/sOUTAtqh9ZMlkvwUUh7QXovYRGviqArfwkI6AQ8wju8bvbAvBZHA6A
    FU8j67iSVsadOF0dP7UlVJ7UhaGwFbdDYaWNkX5f50G3U7Bu5BTHYbb5XKby8JN0z1W0Wf
    RpilK3uDTdSPsolufTqrnxhC1MrZ62yaqsP3ifAHt7hWUszsZcfMqi681ogiGA0ZZUW3RY
    Bwe396679kMdT+4STsoFsfi2X8YlWrw52QUILWdas2PjGme80M4c2/2KiQu+qkgoBZ48Zd
    7PR3WXS7CNYVgFam6etfsxHr89Ah3XB1phmD5WM81QMJJXzh9ReYUF1pvv4ApSTF5lQpGR
    HsP9o8DJA+D01AE04YvF75lro+RibR+ardx/PtIwbS4PyIgPhf6eVzDY2HHWntT4FtyHR2
    jLiUCHQwewFY+24IsIGJoCjEL2Y/kAH0dAoxGcGwfvqbgFa0nWWiEZU5DuRzXJIiAILDng
    zRvESyUGMMFfUi/gzZL25F9emWHtcXOqRs7kOH2M17Xxmt7DhinNAQVR4coQ
X-ME-Proxy: <xmx:j9N9aikk_ItuKnPnm21rTIrzAuDqGFu-fDdkVn-RuoRlZzQMolf7sQ>
    <xmx:j9N9ajRx5bMaH-Vato-H7XiRijiDxTeC5S63PXuSCs3Fujk9-q1cDQ>
    <xmx:j9N9agM57H43xKVPydrc6hVO6RX22nUnLArJohfVqobhHhoD1IM-mw>
    <xmx:j9N9asULfPboqjrQjo_LO7qQ4-7lgcYI6cC2KdjDHJmkwB6-Zgzbiw>
    <xmx:j9N9akNm094nISzuOCUyu9Fs8BuzFiSiAHhqPihva_1Ns_VP6RywSEnn>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 10:24:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 1/2] doc: format-rev: quote subject placeholder before and after
Date: Thu, 13 Aug 2026 16:23:45 +0200
Message-ID: <V3_quote_subject.b65@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_synopsis_block.b64@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V3_CV_synopsis_block.b64@msgid.xyz>
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

