Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8673F6C32
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403321; cv=none; b=MSqbYQK+ej6hNkmJbBy4FXpoF0tTOAN/Jhe7nOyWWJFJ+fqwj+gx03+HMNzCCQsX1eFbepxt1hO89kfZwKNn7yfgyvDZdbukgr+bkJa6W28pCWTVzQ5tIV0PsSaHhoM48KVLY2O76l/9h1cJy1Dbk2rAtYYeR3q3flefzioTpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403321; c=relaxed/simple;
	bh=8uDOqRzGYropzwEDYlFG9sZSc4hCQedakQl/G9cFhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3Rsx8sbAk8JHHbcE7+7vHzTIoazoHtKMKVFSANbG0tAJ0boK3COf3JgCkDig9YIFtQ9gbwXV6pKSG3c0j7TcwHcDs+hAxRZ12c0W9qebrFX2GS0ddLPixTQvyPTxBerqX42C+/qXpZ4uw7m2kKJd44lbmj+sYtXmQ0AB560yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ODqMOBSN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLT89gXX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ODqMOBSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLT89gXX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F23CC1D00101;
	Thu, 30 Jul 2026 05:21:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jul 2026 05:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403313;
	 x=1785489713; bh=7Gn/sYEL9Bm0T5+kwc2CD6zbXbTQ83y3BcalQvGREVE=; b=
	ODqMOBSNqv6hBF0l8Zx/a71klpn11eOOJT64n9ZFqft1Oma84sS6n03qfrnZTeEs
	G5AzU+MfJG6vKHcxwV5kTLvtagdB07KhmfyCZU+kbsd0iUjDdiudPuXIIc9bzyUb
	FBLPFy1LLYlC3d1aXsu066YNsLFJrt2PGJojaVXPJNU2hmzsZ+LKMfIGR3GbYtbi
	SBADB+p7ZqpNlUklHJLm9Z7S5Vu+hejuTIRHLARySyzn6Zxp813NJ3zwkBTTGgVy
	02ZhkdKq5AK+0y57vMKu3uqnkt04p/o1Cbp4c6T30GivmUk7a2sJLzr8TNieVhtz
	aWOGs8Z/yeorUmkqnoldrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403313; x=
	1785489713; bh=7Gn/sYEL9Bm0T5+kwc2CD6zbXbTQ83y3BcalQvGREVE=; b=i
	LT89gXXyaM8nR6UGryNidNJ/+sOjwcMXSvKtAi4nASLVeVXIhOIjifTl+1ZXdzbs
	D7syW1lOSFMjoXjJ3Jz2EYXqbpaeps+V+hF/VQHAT/XBhR9pafN9IPdblhnCd/ze
	C5xYKlZ0KNanpZxJ7xj6hivSxozuLs3o0L53U0rQQU3iFjt3I+El3OqBMvPCQ+xo
	Di8sCPBAy2i8q1SEXgNGbGPe1Jm4vVjMfIIJJEawO7M9XfFOmSGSBDhiRmnnzSZ1
	4WZkNLb0zN3jHiygf6fG4xCFbXQGvqz7VHi4gbeQkjgmgrvWvmnUDnhXVyLn6TXD
	uEdXDolg25zMzO8XcTpmQ==
X-ME-Sender: <xms:sRdraiks80oslVWKu_unSm2YvhlKtPLisMTKKH2gaFuC0bc2H4DrPdc>
    <xme:sRdrao6eazW6E30oI8adcULQpE1673kSIEQj4qM3Gs6a0-Vx8ZL9VeVj8VVtsTVSO
    PNjNpDQMIM3SXrOH9PKcOL-222cjAlCrowQ7pv1rDORNmAEzCyG>
X-ME-Received: <xmr:sRdram3UulG3Dokfn5D9fCPqDm2GuyPKAnFfO_38F4VLCWsQbBpVsHAL-yNngHi_O36tnHhosj_1B1O0BFAU73IS6enDA_S720AkgnWBi0TNqQvv6RgcMgA>
X-ME-Proxy-Cause: dmFkZTFomTnSb+31p5NPZezN1HN0kXXqK1sw5PZwoB9qrOM5crVq75lvN/qBplNI+WaUmK
    SzBNJFqOpuKn5VJSRpZGcVyiO8T0hBeQz2AS6+PRYyxihtQzo4ShWZLDMRK2dyxw4hAiBQ
    yOTD/iYaPBE3Wq47yd2fzMRzITJ6K2f5+pwOMeOme85f9PtrphssWvC4hdDvYz1/Y29Nrz
    DTXBwjqzpxgKNjIt/bvEQ0GmSTEkzsHpWoy/RhtVYjrFmEt4MS+WI7CV79VhaDp6I/+iKR
    9vWjo4rp2pDXV0Z+5TseuTh4jn0WG1BGRcqwi33dD5ZZXKvZuWqiMSR8mVsOP4BSYJWnjH
    ismY0Wh6IR8qmD3yznv7QqYwWCmnz+4Hwkl064zsC/nP+QdL99T+sq7J1QoS1dz2nFM1NG
    R9q7XIZopR7GI9GhwOhPKPa9dTcDVUYKz93y3wghJsRkZ+KjnO867cuYnU+8ybobrLNLRR
    5EI1PcGJOGgurdPddg8wboD6TM53odiobCMg/nSTIy97vuJefBK5u2WplLw9ZLv4HYdpWU
    e3QMGo1a1qERnhANm5v38B+bNwAMD0ys8f+tF5pbdUeir2HXSXfP867l0ttlyRqhAuLwbS
    luT7JN1h0tg1OfHP+7+kmjPn44WJwltYXZtLHRlMcUqDPSFWu7m/wPklXVdA
X-ME-Proxy: <xmx:sRdrajF-y3bec3T5yle_WGPek1_PglEtCVHrFxUzJRRqMepb9qY4TQ>
    <xmx:sRdralhPb2NU5K7kWMzfo4op5yp5WuxWiVRX6QFgrmIW9rfgpmMyNA>
    <xmx:sRdramDWha1Rv9UCXmZDm5bDI84DPkO-FdfVMi29m_-uefHrVxju-A>
    <xmx:sRdranTX2YPiZgkyJoz8PDIm8ol9vynYtFCaBUS0HOVAuXj64pxCqg>
    <xmx:sRdraigQX_5krOuUzpnfrn6jyhJhFcjRrvVNzoO0tsh4FgRJqWKdiBUk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:21:52 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
Date: Thu, 30 Jul 2026 11:18:23 +0200
Message-ID: <V4_rewrite_new-trailers.aec@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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

