Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD362BCF5A
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028722; cv=none; b=mjDVBng+yArVOPyCjVFxgt31bWYWkym2OJHP79XMJ/5mVZJKsy8JIY93hzDgqEjGdY2gL8QkPn4zubXxcbCGLppQ5uP4m695Wuk47bmc0RxhaM6aXa3iqBPrzbtXb31U+mWLgGIGKYGmTZFiPvP1nqOizAkB34f4FU32PKc61UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028722; c=relaxed/simple;
	bh=1cKnwGOc2GPlx5yA/EOHZeq2xuPr5pHiPHe6w90g2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaZJzoz2u05DJt1yt/b4SHrwY9fI3G5KiSl+GalUZKElqCWeCQw9fo9K1t+iOFlzl4xZ8dpHVm+qm68GhD+m4OhwvnoiDNS+ETNxmbQ5hTuns4/kFOYEXDqs4BTN2gplEft7IofR4whjyyEBDqewez+dG94Yf09vo/Q3Copa2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=vyabXh0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wn/n9C5G; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="vyabXh0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wn/n9C5G"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C205211400C7;
	Fri, 23 May 2025 15:31:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 23 May 2025 15:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028719;
	 x=1748115119; bh=wTWV2PM0vD8Ihz0Cq+WCkVE3oNSZj7JyFmVnpodn9Zg=; b=
	vyabXh0FtHXQZUZRklF13BeSgU77466K0ONihBUocos+d9smVKdIw2oUx8K/+HA3
	iB7S/6gHn9qQ7h1qfFgLOJ1rMBjDlnEzUAi9cS/ylirX0dew7G36wvHvOEks/qSG
	nEuvmQxW3YiThMctfUbxseg4dCnCL8KbOmOQxzdkv+yIj5akbKV1AyOBNkjcIB2p
	8hKMcRWZNFK1LduM9Es1RbCL9Rzx5fAEsELACQM4wVDbTxsDmXh1n4CFizGQE7SA
	UeUv1dJst2Ho1SJyk8xsOM4tpmSrg/oOkQvmIxS1+guN1kElpCOWR8j+fRFqzWiy
	zff31vIbOBbyQhKLWDOVsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028719; x=
	1748115119; bh=wTWV2PM0vD8Ihz0Cq+WCkVE3oNSZj7JyFmVnpodn9Zg=; b=W
	n/n9C5G180tMBV5zlitCYQf6rw4a1WnYK7cL/+/JammEqIYO1YMwagMX/gRVm2be
	VprxZFFip1GbTLYZJDV4Lqe949vSTygvN6JV5OBHLRAV7O5rzCU/Y01TJpRo3hYm
	9kPfzAZB0kDlxp1Do7mQPdi9JoCzvwIwwrWTE/7GZursvjyDhZhpH/pPQDNCfc3S
	Em5UQjAuoS8J7JYDMUPNGvcYxdDz+BwRPWWkWyRlcQTnvq6vBO4qmgVHBEjqozhs
	J87lAE+NTZNdf7kIbCiFwVrnW6rptlf9AZbgrSp7xgynW51ip81Zkksy9tch2Is5
	Hl/RvKEKiSgEKOHu7xISQ==
X-ME-Sender: <xms:L80waGuHXb792PsZ1tuKlmf3VYtBmv5WyFBRW9YClFlMVknXCDzrcaY>
    <xme:L80waLfmFv6BKb_FNknNTBOxiUQKjIbuV0zIBpNDZl59UlnyWs6NzKw5uaiRm9PNh
    Po6WVmG5vQOUvQ_Iw>
X-ME-Received: <xmr:L80waBz-HB0mrmu3UPEyYsB8rzanBOYUsGCKtPcsRBW1NsGMnKKspmBtsmisIIoZwsDs1HU4j4xvwcGNr1l3Ttul4KVLbcEsEmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgueeiueet
    keelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:L80waBPGWEA3xkwaXgsTDyyRC_YsjpAf9VFCZUua5Vdnx03wa4l-Nw>
    <xmx:L80waG8siXcT6ovcuO_8crz_S7YswPeM5Cmt9g4GZN2jjqwozzNyDQ>
    <xmx:L80waJVBjtz-ALqHLX0RkgiIKp2zPLsuRpmbwvHCfGX4Z9nARKWg8w>
    <xmx:L80waPdbd9XbeCwuiSmgz1aItLzbJmwpF7j119Wf_93csAeUWPLuzQ>
    <xmx:L80waLKRXRog1EbYjKoVZeiHkcvQq1kRtsBvL3FrEBL7sGOhGHJHyVPw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:31:57 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 3/9] doc: notes: split out options with negated forms
Date: Fri, 23 May 2025 21:29:49 +0200
Message-ID: <14dc58120e3da564e28e1b442d481d632c28aeab.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Split these out so that they are easier to search for.[1]

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: Use “negated form” since that seems more typical

 Documentation/git-notes.adoc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index bcfe3dacd3f..8706b33f2ee 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -174,14 +174,16 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
-`--[no-]separator`::
 `--separator=<paragraph-break>`::
+`--separator`::
+`--no-separator`::
 	Specify a string used as a custom inter-paragraph separator
 	(a newline is added at the end as needed). If `--no-separator`, no
 	separators will be added between paragraphs.  Defaults to a blank
 	line.
 
-`--[no-]stripspace`::
+`--stripspace`::
+`--no-stripspace`::
 	Strip leading and trailing whitespace from the note message.
 	Also strip out empty lines other than a single line between
 	paragraphs. Lines starting with `#` will be stripped out
-- 
2.49.0.780.g892193c3f50

