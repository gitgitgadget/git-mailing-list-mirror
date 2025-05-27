Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22387211484
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380809; cv=none; b=Ncj7/+LLpl9xz2+YYY8PgO1YsUrNRDDWqAwZAflKEAggT3sAT+Vc+LZLCV9nf9AVQ+CiLLW2jgO8yFV7Xpyte1r1W1oewTisxV8TbSVRGpj5nXhH86Sw52h1jgWs5AKdtf0uZN7aVRCaz+3LbznfGFWTL8K73kq6GANu9LBLiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380809; c=relaxed/simple;
	bh=1cKnwGOc2GPlx5yA/EOHZeq2xuPr5pHiPHe6w90g2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltgiHSJTxXoY+t3LSDtx2BpiO81bXwV2MGZ6IRFJogz8jQPBVoMkDEkTWIvnxzbKv3PqRHAqpb6qLnUiJAZz0ZS0cSwMQcFa3FVtpHqMag28qYIV9mBU99c/l3ySnL4DbzlA1pfLeMTWAu69oNHQtmQcFjXQd8R1c9glwCRj3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RZZ1Fx6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IP2ECkHw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RZZ1Fx6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IP2ECkHw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 24A071140122;
	Tue, 27 May 2025 17:20:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 17:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380806;
	 x=1748467206; bh=wTWV2PM0vD8Ihz0Cq+WCkVE3oNSZj7JyFmVnpodn9Zg=; b=
	RZZ1Fx6f3F/na+D9UghpoM1inYrdl/jqm5CJj+LDAS5KVVpA3T4xS0jjmZiylhBM
	8/gbwUx27mXzQUHb6T/kF53Ss8YfBcxP0s2CnVicVXDTcSIFo0brHsilVt7O3knB
	QptkhOh3WAZkg7YNXZN6wqxnFGgAjm7XdFzWbf2OKu9xX6Ole2n8bSW2RS0e+ccU
	q53forlhPn0MgmZJEurBM54BDkn+iJUNcfQDZF5Jja/NMSgPCf0IJwAuh1/+ykkr
	nvkAFMJ5A3j1yBy4M2sftf7lXQk+wU42OvVe9EGmZ+TZXUau3tGQJ2dXqrGrp/wg
	YBZ8YULgo/7nLcnb3sZvgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380806; x=
	1748467206; bh=wTWV2PM0vD8Ihz0Cq+WCkVE3oNSZj7JyFmVnpodn9Zg=; b=I
	P2ECkHwAvIjLsZzCa3wvA3xs9bmwlG9UOZ4gDVf+yQZg9sYF1LcnDTFgAWHXc6/F
	fZFcxY1HSpc5fvzVx9T239WEmCa2X5uV2KDo+sA0DeAskRhStF+5L9egHnznuvxN
	YjLWCgSHyEWhrL2S51onbNNa2RqFkOTvNgdfPpbhmtbb0RrvN1WzBO51jo2iJGxj
	daHNu4mdIINs8qVNJjDy9MOEAFT85tmW+yGCy5vUrqQwMWeI9f8wMIVKIttESrD8
	ZbLmPHTo05gAv1P6blvVmUNs99NZ4dZVF4Twab26mtGhExEMJBNyWbvUIXFIiTK7
	YYgMYu9sWfd3Rj0jhiP/Q==
X-ME-Sender: <xms:hiw2aEbx7qjErp4q5Y0T8-8bmC5BNMZjdm0lddU1dbfKI3GY1qW94BE>
    <xme:hiw2aPa6_wLZpIAhzHZ7bD3bOjFUSpUyk-kIS_Fnh_8jXbN5E40ADWYiYIpvhHqa_
    ZIDcUYXDcv9JUBefg>
X-ME-Received: <xmr:hiw2aO_2A6-8_AyySaXwDdZm7iP7WZNq6LuVmJXxSlCcf2F-bNLjGBgkrr2JU4zjbC5fCLREWvrDXlJJ_Z4Crnj8FNrVNhyfU_wGromx_ENXGLeZ6yMSWqRkQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeu
    teekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hiw2aOpJwj8sRWLwB3bYDlPbANhV9qmGmtvuqtLawJ7XkDpxWfj3Zg>
    <xmx:hiw2aPp4HQCjgvF9CdoDvEuoSvrWiOXi_R2Lp5saiDcPleRTF4WyTQ>
    <xmx:hiw2aMS6m1qK0RcaOAbXQB_sl53mgm4nzURbjSTvlKfa_WCCep8TnA>
    <xmx:hiw2aPouaBXoE7KdR_21MTrtZeQEA33x77H9pxiYZp65haccBUXnVw>
    <xmx:hiw2aGNbjstm_lWbSAN8NgVzYoh-p76qzXiJ8XoKZOJir0TW77Tl3NaI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 3/9] doc: notes: split out options with negated forms
Date: Tue, 27 May 2025 23:19:32 +0200
Message-ID: <14dc58120e3da564e28e1b442d481d632c28aeab.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
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

