Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348B3A9879
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992793; cv=none; b=Cy7QBgbYLVSyNv1rOVfCpWB1S+Is3okEqrwK73LpEdOwdeKWHP4S0ULB7yfBzuTAUq/ZLFTIwbgCHfUJITOWzKictd2u+Xs0Q1aK+zDkBsQjBUwqVZtn2RrN3cTvufvdzIijFQv6Ctm1JoSgvWBax/JZ2opKemB+hjILmbzkHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992793; c=relaxed/simple;
	bh=ynOH0UO7+hsof8xkzP1RdKTTruF4CxnLSKAFyQd/EDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQj/mXLlYjebT2lXdzjTXh8sUd4g5MJeJo1NrooRIsxKjVAtDb2QR/STcaSX3jOgU13O0jplR0uU6W9E03j5a25a8O4koH6EXRU30/JRenZ8mX7138e5NY8Z9+W5QwxzzBmVDsU+Eb+/0Oh8kXgWIa8Vg5bvggbKEGZ49z0UkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mNCHZ6n5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWsp1RVM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mNCHZ6n5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWsp1RVM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C6267A00D4;
	Mon, 17 Aug 2026 14:53:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 14:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786992791;
	 x=1787079191; bh=/L4zqg5DWBD4YBGIWUU0AJDidrmtzniyfxyF8g+MT1I=; b=
	mNCHZ6n5ZrQrTyMLfjO0m3qZ6ZgvThBqOi01ad9kIy+sOcJ8kYkiFja00YVT5eso
	1auTzBXVXAE25Q6tZrr63m1MuxsYxuOmsmh/NekTxeGQJPUEwJvbaROLm5+qK0Fi
	xFs6mZ1ccovqJXkFvjZzd7BJ3fmwekhQplIuHl0xnkhlMU1VLOeOvY4eKlDLgfbb
	vulTJhfeyfKtE7J8ptxL1h0rlm2K+rMoHv3tH0vk3WVO78lps53B9jqd3h4keI/U
	R7zQOL/bds+0NsW/UV2BnVVSoK80BUELc65QnNXW4jdjm1wsLmja9B1loujjcwAV
	U0Nx50mw9HtEyhLJMv9ynw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786992791; x=
	1787079191; bh=/L4zqg5DWBD4YBGIWUU0AJDidrmtzniyfxyF8g+MT1I=; b=Z
	Wsp1RVMGB7S6HCQZ94ND3xRBJQ+mc+QM7tmg+anMiUvEy0X6qrPSDFAKdBi/pxgd
	8jsPCG1TtU8v/HrEJir5IQ67XoUWRl85ONJpy+bQSuh2SsQFk3z72J9Ucth7nw5x
	loTGoFGixI3IJA35L6HTfiZgbOPWiGWCiE3NnZsu3mjxfpPtDjvqNfS9SsjMgpyF
	d/dn93aZcfKlVPjDYzqnL0Q2M+kVCLwbT6WQOBkISwU6lsBxLjKl0vuAk0gpeash
	1IAzstm6QBcmQlPnGIgHw/QrWfzHKmB68rU05txbn2KCq0yPHrkt5s9fCaEN6IX7
	lp8WMgxdqh5bNUvldG+FQ==
X-ME-Sender: <xms:l1iDakAzHrTfh41yVn0CIQ6m2Dgis-D9OriQbUHuaPurhldKLKPJa68>
    <xme:l1iDatgSFvX-3YvszC7a6NpUJ9klJddSS3N19rBZgmMMTrXYKmBwkxC1LgpCOIGhS
    WIHwhrnv2Js9kHj9yXivj_35R5OUYXmE51W8DBqJD97hWZs_-Qabg>
X-ME-Received: <xmr:l1iDaskjXkx-qVRDcl--iQ1C4CddR0RIjdgkYZXGk6YwwUEeRqghFvijLD5BjLSYnJ3_ff1d4X8DYFTSrKuKBWmBQ0HLqRRVO2RtzcV_EfZCHApqNdjw5-I>
X-ME-Proxy-Cause: dmFkZTGyRL5S5oNpoF6e3KZFS6fk3iX9E8GIhuqZcssxTPHRUad2hI0C1Af7/SloCf1JzC
    Ycg1/D+/v/9NdMwsJqa8RxFmbsFdYWNAzHvUwMhHGMWfnrCPQbj7vCUsFVxzx2Nao8dKcN
    H8fsye3U+Rr57XXQQ7Z6ayA1PlU0BkhsOSbSb48txr1hCf8I/+Bc0gpQ66OF9UnkP76eW2
    FJvcKl5KvtjH0N2RPPOmy6a5VvCAn3gonxcxEf5kun5pNC6TVMTEeSidKF80gWyTW2vINB
    SCJ7aX2htFmohTxUsvUkkJswblS7ECVw153GJ/hXtuiVL4Sy9NDPXZOsQrkYmjf+KpD7dm
    +8RLXUJxl71Tp2WKG8u0OsU91YfSqMZxtEyhJwmK+hLdW5Cdn0v6ssyGWtP3kEKzQZT4cc
    8s2MODycTooNdkg5MVPYJzxCyktnZFXvq/OS+zXjIhMRoz0NEeCIFjlCEVOQHyTIuY/zzz
    ArvjYQU9q/u7nDsU/OV1Gq0XuSGJpS/BzWfN+3SE6s5jbsBqmyxT04/qah4bFBMlkv1se1
    yA5avkPntDd4Mt/zrnSopxtT6GA8o/jU7lIg0TkObnDH19P7vwJu3Q7+MqqA3zVD7iolLg
    uLzcKey+E6/fsOw+ErHQsZ/wEwvBfBu/NLO8jls6guYMFHxNqEK4z2eKnKzA
X-ME-Proxy: <xmx:l1iDaprgpzxNnG85t7gi9ChV30aQD7h_Gjn3F1FGi0-K7sZzgAz__A>
    <xmx:l1iDalEzfu5upPNtX0bDSybJvqdj6ptjgQI2g4uC7yCEWUIubGiPSg>
    <xmx:l1iDalztGMmIF9Ges7Olyc0_ZIy-TF4-j6mCvnjFhdpwAfa19CVWSg>
    <xmx:l1iDaqrLmCVYuwXKnFBYEo3KnKjpE5Bjgi7Zc1X6kcNg_vT1vlTEJg>
    <xmx:l1iDakiEwx0iC9o131RYn7DTap9l_dsDK0prx4k1f1V2kBvuqCzwXVq6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 14:53:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v4 2/2] doc: format-rev: use [synopsis] on code block
Date: Mon, 17 Aug 2026 20:51:49 +0200
Message-ID: <V4_synopsis_block.b90@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V4_CV_synopsis_block.b8e@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V4_CV_synopsis_block.b8e@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This code block uses the placeholder `<subject>`. Let’s highlight this
placeholder properly by using the `synopsis` open block definition which
was introduced in a34d1d53 (doc: convert git-show to synopsis style,
2026-02-06). This renders the block like a code block but with emphasis
styling on placeholders, just like inline-verbatim (`) in running text.

Yes, note that open blocks since commit a34d1d53 can, on synopsis-style
docs like this one, be immediately preceded by `[synopsis]`, just like
the command synopsis is:

    [synopsis]
    (EXPERIMENTAL!) git format-rev - [...]

Cf. verse-style:

    [verse]
    'git name-rev' [...]

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Fix block: use open block, not code block.[1] This is what was
      done for the synopsis blocks in commit a34d1d53, the commit
      mentioned here. I have tested this with what I believe are the
      use-asciidoc (tool) and use-asciidoctor (tool):
    
          make doc
          make USE_ASCIIDOCTOR=1 doc
    
      And they didn’t give any warnings. And they produced the correct
      result.
    
      🔗 1: https://lore.kernel.org/git/xmqqfr0hqzvl.fsf@gitster.g/
    • Msg: Rewrite or flesh out the message to reflect this newfound
      knowledge
    • Remove Ack from the previous round since I had to make these
      changes
    ---
    v3: add Ack: https://lore.kernel.org/git/an2Wwe4ytilGoyHz@pks.im/
    v2:
    • Add a paragraph to contrast synopsis code blocks with synopsis
      command description after talk with Patrick on v1[1]
    
      🔗 1: https://lore.kernel.org/git/ansWZxZ6lB0tYIJD@pks.im/

 Documentation/git-format-rev.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 19241837345..c2268c92b56 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -96,9 +96,10 @@ The mode `--stdin-mode=text` replaces each object name with the
 formatted commit, i.e. the format `"%s"` would transform some commit
 object name to `"<subject>"` without any termination. Like this:
 
-----
+[synopsis]
+--
 Did we not fix this in "<subject>"?
-----
+--
 
 It is safe to interactively read and write from this command since each
 record is immediately flushed.
-- 
2.55.0.13.g85d2d65e389

