Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57A257437
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716244; cv=none; b=W65knWfVy76w19dBQD2a/eiS6evG5b5QElJ9DCMwWVOiWBsy1DaWrsrBelLOOWyczet1OapGRDOYRwfwTKSnhlrL1+73PNE2sc82TxdJdB745rlAWV/94vA8Mnr9SEymZbB/7xpTIw/rAb4SYTGWJXs/bVrrU3qUp7DXaSsz6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716244; c=relaxed/simple;
	bh=MJADYfg8OhQHHlYaHtpVnd6nw+G4zhShmgf0ez741Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsAlAbdH8Jsqp9JXCJ+sVzKNW9/jTqFsKrlUJ7SoZNEbAlQD6G+gyu26GFUWexBqno/5DuZxqnB7FLFKpfkbl82hK7ajXwZavX85+UOM00iTakunlzWOhHUnAj8m215i0+TgcRh/Cf+xIkGnZ4MRzgT0g20V6qEpZLvB1QwlMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=A2c8DIn4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWEjixO1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="A2c8DIn4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWEjixO1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BA46EC01F2;
	Fri, 17 Oct 2025 11:50:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 11:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760716241;
	 x=1760802641; bh=hb+SbkuWQsw6a7qxucO3z0CM0zNLv4w2gdkGonWrwqM=; b=
	A2c8DIn4q24okUgDNOOLwwBcFVdg4qZsjZ6ZpDT0ZGm+mVhJOKN882V1XrTadS2Y
	CqQe3Ww7xOfXjDMP7CjfuXA/25Q8EmVsBQyrTy9o+wNcqDqq1vj4hB4IqMUO7jZg
	jkKeMLa70PPaV/2ue6lMi3LAJxtZuVBaXYxU3/vB0puLAHiBpHHfidtmhoF60Iec
	baDtTQ22fjssgCRamFBz0PEeX+3gzboLjKe2fPAYVghpRlAKSDVImfgc7G8HvqeZ
	Fa6IkCchILAk4X06DTkvqayRq/4WDuan+HRQdaeUQc1SAcYd38/n6bSLOGg/Z+Bb
	Vpha00LBmkTQE48ONXTzKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760716241; x=
	1760802641; bh=hb+SbkuWQsw6a7qxucO3z0CM0zNLv4w2gdkGonWrwqM=; b=e
	WEjixO1r586x1ay0EaiF1MWckxSuV6agvVoocsdxDE3lss+zYgUJJTRsFZoCRN2P
	/I7x9YP9YEwqHULMa26jA65SpHmMG/22xDxMmMGvhi17BIC4tqG6L7dTHk5e0q0T
	3yMsjNEajqbHUhYaCEXQkm2BMq1bTOKUdSmRj/VPJhbODbEC2WACJozgp6fyI7Er
	qStHWHni1f2ZuRxVDSt69hgSw3qQSzvfjXpDkZz5WLyBUGHiOszkF18YUTnI0/d4
	jRdzrmFrAjILCyhgtWXBo4nj649RL+ogngVmPFiwYNP22MnwV+F38T81rqdY1taV
	Qe/AF3gZCRuZ8zW8ESnvw==
X-ME-Sender: <xms:0GXyaHFucCu4VyxCi452ZuJ8K_0ekCinwXNTqL0UMUT5HClzx-Tupo8>
    <xme:0GXyaLNycWvs2unZQU1MKXPXpu1oquYmBvumahEhIjD88MKY9W9gysKzXx49g3Pdr
    EVooJCxa_pbZNIQ_sFi2f4I_17WE85n3iRq6uihNoDUwZghgAhbCw>
X-ME-Received: <xmr:0GXyaBc7cUYRZXwR2niEyZpzwqcg-uJ4XSGKqBrxxutkwlfGmXLOsm5jvTiswCNNLM4JJ1WtfhVId0pyh9hSkgtHR7wJNdxNmQ4GAA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetie
    ehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhv
    nhhsrdgtrg
X-ME-Proxy: <xmx:0WXyaAv9IaoDTc3R4vpzlT4kMj4i8hayGq6fOhGJAsh1-oC0MM1PEA>
    <xmx:0WXyaKlcCv-CYc1JTUVk0mDWNKl0o4XgBJCH0OdO1ZEUq_e_9ZsZVg>
    <xmx:0WXyaKyjceTZKvH-8wVeZ4QUAtA0Pb6L9LdKpWeDLO5nrxXqEKZJyg>
    <xmx:0WXyaEOAOL6R2huXwuyAw_LCCoRpYuZh8_RQi24XXti0bCHvjUE3Cw>
    <xmx:0WXyaP_6z0rcjIn5a1_T8CSzTp34Y7aOkSoiNXv_wWnUkHZYb3rOb4dA>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 11:50:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: kristofferhaugsbakk@fastmail.com,
	git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	julia@jvns.ca
Subject: [PATCH v2] doc: git-checkout: fix placeholder markup
Date: Fri, 17 Oct 2025 17:50:12 +0200
Message-ID: <v2-cb38c701537.1760716150.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.1.498.g8f0801f1c10
In-Reply-To: <54bc6875cc5.1760652634.git.code@khaugsbakk.name>
References: <54bc6875cc5.1760652634.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The placeholder markup is underscore (_), not backtick (`) as well.

The inline-verbatim markup (backticks) handle interior formatting. This
means in this case that it applies HTML `<code>` to the underscores and
`<em>` to the placeholder.

That is the effect, anyway; we can see from the rest of 042d6f34 (doc:
git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
an unintended mix-up.

Acked-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Add Ack.  I also considered removing “probably” from “mix-up” but
    left it alone as a point-in-time note.  The msg + ack makes it clear.
    
    v1:
    Since this has landed in `master` now.

 Documentation/git-checkout.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 431185ca0ba..6f281b298ef 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -61,7 +61,7 @@ uncommitted changes.
 `git checkout -B <branch> [<start-point>]`::
 
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -155,7 +155,7 @@ of it").
 
 `-B <new-branch>`::
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
 `--track[=(direct|inherit)]`::

Range-diff against v1:
1:  54bc6875cc5 ! 1:  cb38c701537 doc: git-checkout: fix placeholder markup
    @@ Commit message
         git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
         an unintended mix-up.
     
    +    Acked-by: Julia Evans <julia@jvns.ca>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v2:
    +    Add Ack.  I also considered removing “probably” from “mix-up” but
    +    left it alone as a point-in-time note.  The msg + ack makes it clear.
    +
    +    v1:
         Since this has landed in `master` now.
     
      ## Documentation/git-checkout.adoc ##

base-commit: 83a9405e59e9cdfb587b19c50f0c040f346dd4ea
-- 
2.51.1.498.g8f0801f1c10

