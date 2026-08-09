Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC484B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306235; cv=none; b=o8EBbWyv4swcvnCPEL+2OOJKGE5XTQk5hn3CJRjw3D14hvUQy/JdkdgjZD1nRaovJx7GiyXYS4m3wshOsNVQDV49LmwuZmQrhiaJYYnC1DOh/7jnW9emeE8pCam+dKABlSMyPBzcQ2oMt798VaE8zvbOkGtPzKSbF9i52gaL3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306235; c=relaxed/simple;
	bh=8uDOqRzGYropzwEDYlFG9sZSc4hCQedakQl/G9cFhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTX3vkLR+MPqkeuJajKOl3+Atl7wNDOvkUcnfSU0LhcCKPYniHbz1wQ+B+6b08bR1aOvFDLgxXdQM8Pt1yqDp5BCJnDh0vlY/nAauc6WwF5HPk3c/O+GEjGoNq2L6jGw3YxPEgsteba4RtloPcne2oLVchw1zERvCShLZ9paVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Js249ots; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfkDWu5M; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Js249ots";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EfkDWu5M"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 046B71D00049;
	Sun,  9 Aug 2026 16:10:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 09 Aug 2026 16:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306232;
	 x=1786392632; bh=7Gn/sYEL9Bm0T5+kwc2CD6zbXbTQ83y3BcalQvGREVE=; b=
	Js249ots4HnSc9j8+M4iEXHsbH9bYBzd4wd/qS/B42FTEM4uLjGOwHQmIgftj+Dz
	LdmsFkbfy10xEmg1yf9VebYU6WzRguVSF+qkjCKRxh0zzoA4QAEBFlBBMaX9AIQ3
	dkI44R2/+KM8dUwW6nQjmNQRizDjODfFToMv1JkkQKc76/nsRCDQUdhPm0D5mIoC
	gY1fSI0mx7kVbOu2DKDo2nwWYvLM5zzEWazNDgCaFLNJgIo4aLICE5cdo3AGD5+f
	WR+BNlAnItm4EA4LLIOxAzGpuRHFJ3lqEujhckLDLaGVIWKhQ1b8r0Mu3nt9UDzG
	cSDPpbCiVRmPB0bbT4cbQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306232; x=
	1786392632; bh=7Gn/sYEL9Bm0T5+kwc2CD6zbXbTQ83y3BcalQvGREVE=; b=E
	fkDWu5MU7+wW43hgE5q91tfrjQumjA/VxTo+Fv7oX31oM1Ra5spyqm5ros/NA4Bb
	VvubCGMjGVFgnd1kz0rqX26uFPvpiiyJoo508b7xr1T6XaTxYPvGWXTyk/HKgRLy
	tLEKaQ832IBgqRElrEIZ0SItb1nohk/0v9bAFLHp0ZyJHkvrGiEA8rMt4PlKNuPT
	B3xbU1SjqkIGWj+6BbMz9cErsqfojB9w50hCV3eGr7VgEwu7tylhuvE0c37isPmP
	s6bTy18ENS5g0psOwBSxUTc0/hbCnBFOACspCXkRTHXcfO5XUFve+G72n6RLxIB9
	VLPJmeQpq3l5aTDeGZYPg==
X-ME-Sender: <xms:uN54avjXKDbQen4xe9JZ-rcwsAnI0D-X8zdN7UX2AYMJlyykf2wXb78>
    <xme:uN54arG_dXi_TlMd4MKt7kpHYCATEl3rNlAGNBjA1NtkACF5xkW6AGK4P9ZFzElJ3
    UUi5uVjD6niIFpP8kZHSB4pCnTP9wTZLIfgj4YdKKoxKt-iZt8YwME>
X-ME-Received: <xmr:uN54alRiFN3rNpkN8q4MWVdYWC40sIdP11ZlCMtA_0lJNToeh34r-VTjV2cPqxp336IZLFcpEn03E5kx2x8Nv0F8FTc9esqVSzTrZXgf8AcQY6s8bPyA7fg>
X-ME-Proxy-Cause: dmFkZTEcdI7FD+6TWE4ETRG7ILyNt0FJmLCkf4B7Rh7bvO9LDSLJTh+a8sSGJMVUTrqw4H
    t+TcTQVn0225EKdTVhRDBQrL3gn3hH52gWv+bGIdmXvmIP18dxA6walyfMaaYln20G1xoF
    kRKdLe8RsVLgQpNI5NFqcuau5PlG11BgHlUCxZ0O5jphPzlOd3qmyr13Ux4UWy+vN/oWHF
    50/FAfD9zQHH9iGUl2Xc/1q2la1VviA1N0mKCTbiLbIiGg1/ZCTG3pL2DaODFhu8wNIiUr
    9P3zZ85qGs2o7yRcd1dFb7Azn2UrkJrazICMpJpdxrrQnz7x8H+iHPqNcRNEv9rHIIH1is
    J+3CdM57MQDkJ+5+Rw1acruv/qdMXB7cNUdUk8PDX5GVHFQV3QE4nQHPHV2562dmQ5F8Ms
    lBcaaCOC0hxn9HX+s/i9/9KydTvh81DS9nqiIbbRMjDrae1GrBz/d3S/VXes3zaFw/HeIV
    u3F6cwPB/6qxQb3JKKQat9BuCctXL9UqpUbjt9jdxVB3ctOItC1Y0eiRzcY9LVq2JEMG2i
    SfPDHl9lZPAEQRA8nu3iSbH4mqku1oQ9MRxTt69BmbhV0C6Hm9QZnZxkj1gTbrh+zF/XvZ
    ktxcGHI+JdXfKDzhbO1lyW50a/S91TP4xHKKM/AXzomZ6+mpo+G6EVTtGVjg
X-ME-Proxy: <xmx:uN54aoxzXmTlv8g-hKmD3JDEYzjK4Unn2_Buryn_7l14HKClyJ0SVg>
    <xmx:uN54aheJVa2dAsBQAI9BlpRCX4I7tvUzjN93ShEpxP1fqV8Vgp_fag>
    <xmx:uN54arMGgtot4NEUH7heVtExFiSIAze2Ek_IquDnOTBSM4aHoatMZA>
    <xmx:uN54asv8KMUAkRBER66PO6ZL0jRKkJpj-wZq1TfVKyVydpI96pIEdw>
    <xmx:uN54ao_cIfqVq6ujRMY95Jn6KXJXQixcAcp-XypADARbeRN1PQtZrEph>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:10:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
Date: Sun,  9 Aug 2026 22:06:34 +0200
Message-ID: <V5_rewrite_new-trailers.b30@msgid.xyz>
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

Two commits ago we moved new-trailers paragraph next to each other.
But there is something curious about two of them:

    By default the new trailer will appear at the end of the trailer
    block. [...]

Then a source block and a paragraph later:

    By default, a `<key>=<value>` or `<key>:<value>` argument given
    using `--trailer` will be appended after the existing trailers only
    if [...]

Why are there two paragraphs that talk about how “By default” a trailer
will be appended?

We can make these paragraphs flow better, and with a more distinct
character each, by dividing the flow like this:

1. Declare that we are about to talk about `--trailer` appending
2. Explain the default behavior
3. Explain how this affects the trailer block
4. Then discuss what each trailer line will look like

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Simplify “This is how the new trailer” paragraph: drop “More
      concretely,” since it is misleading (this is not a “more
      concretely continuation of the preceding paragraph(s))[1]
    
      🔗 1: https://lore.kernel.org/git/xmqqcxxyt4op.fsf@gitster.g/
    
    ---
    
    v3: [new]
    • Based on draft: https://lore.kernel.org/git/fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com/
    • See msg:
    
          Two commits ago we moved new-trailers paragraph next to
          each other.
    
      This commit here might fit better one step back. So that it
      becomes the commit right after. But I can deal with that commit
      movement if this change is accepted. For now I didn’t bother.

 Documentation/git-interpret-trailers.adoc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index a1adab20fef..ac59ef51f80 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -60,10 +60,18 @@ are applied to each input and the way any existing trailer in
 the input is changed. They also make it possible to
 automatically add some trailers.
 
-By default, a `<key>=<value>` or `<key>:<value>` argument given
-using `--trailer` will be appended after the existing trailers only if
-the last trailer has a different (_<key>_, _<value>_) pair (or if there
-is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
+Let's consider new trailers added with `--trailer`.
+By default, the new trailer will appear at the end of the trailer block.
+Also by default, this new trailer will only be added
+if the last trailer is different to it.
+A trailer block will be created with only that trailer if a trailer
+block does not already exist. Recall that a trailer block needs to be
+preceded by a blank line, so a blank line will be inserted before the
+new trailer block in that case.
+
+This is how the new trailer is added: a `<key>=<value>` or
+`<key>:<value>` argument given using `--trailer` will be appended after
+the existing trailers. The _<key>_ and _<value>_ parts will be trimmed
 to remove starting and trailing whitespace, and the resulting trimmed
 _<key>_ and _<value>_ will appear in the output like this:
 
@@ -74,12 +82,6 @@ key: value
 This means that the trimmed _<key>_ and _<value>_ will be separated by
 "`:`{nbsp}" (one colon followed by one space).
 
-By default the new trailer will appear at the end of the trailer block.
-A trailer block will be created with only that trailer if a trailer
-block does not already exist. Recall that a trailer block needs to be
-preceded by a blank line, so a blank line will be inserted before the
-new trailer block in that case.
-
 Existing trailers are extracted from the input by looking for the
 trailer block. A trailer block is a group of one or more lines that (i)
 is all trailers, or (ii) contains at least one Git-generated or
-- 
2.54.0.22.g9e26862b904

