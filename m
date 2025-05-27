Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C4211484
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380832; cv=none; b=fJHu9SbuljaCda3pwFb6qsX/MBDwZMQe3zHw/1G/7wbqiNWAh58kIcw3lN6/egkkO0anOTiD04lY/9F/9DUV9nV0jcSksBo7m+WuFqcfv3fLP5tsB6oHV3E+dGA8ctEw9sjDcy3JORQRj/IkLfZUgw5Sy4GqZ8Zmlv+mNgw75Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380832; c=relaxed/simple;
	bh=a7bKQHmhuTKw8T3H98sLkROGxG1tNdq0gpj1UEgZOLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3ERqyVzXqEq0hJP/Z+CpPGvalBlZt8FjuiSwjVGZ9PY5sCT6nA+I6pHj29qt+ASJytncHlWEw/SQi9boLTfMQJjN3uMzNLa07NbtkR8RcvbB+n+MjzoCfrq21mDs+Piw/W1N6Ggeyr805EOUg89LZgFCGESnn1xxwNnnlcDZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tu2YQgIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/FOJVxB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tu2YQgIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/FOJVxB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5457A1140123;
	Tue, 27 May 2025 17:20:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 27 May 2025 17:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380829;
	 x=1748467229; bh=U1UFP0ZE532VoekvpqwiNDq0XI84WzQdEcgU12S3fC8=; b=
	Tu2YQgIfv+w/LVjA2wPnVSl2IO4XRiSRaLz5WbXQxxsFUhAjIWW7TWJcltjMWVZC
	4hjG5qnVu+s5Pxo5DXyHvEGLkC+TyTdvIcexN2owe4ES12SX+rfUfwPrCAWZ//17
	o70BVtwsWgi6K3yiUBuvwmE9MNuNK0y3WZgU91tcx1Lo7Kp7veeUiY8MTSnrzkJF
	wwdA29havVc6JvIgPTNvQ2W0yGD/w+VCV1wNnYQvKQbcT37yad78LeasR18MswRm
	i05YpWMotMzQOM3XZy9RHeZsEoawP4dRscyhy50cfIXcup1zX7L7x370bLO7SJuw
	mpWgEVMZ9wfz4sxBEetqKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380829; x=
	1748467229; bh=U1UFP0ZE532VoekvpqwiNDq0XI84WzQdEcgU12S3fC8=; b=G
	/FOJVxBS0GgfcNqOeVs/g4XY+D5PlyZC9qsjAOX/+YQc18iEe1VDwMvZRBCB8QHK
	iU2G5/m+BZXBDrRnWJkN/UfnU/BxLSsGacjcyILkEH6KOFT/cuunce5DhDDEGbXF
	/y/MmCGdr1GfWNobIyU9ZPsil7OpE889ZA0G9H/ouG6sj0IpfY5q8eCmvP7klqyh
	jO7BJMi8OOVjkZ9vYv+YB/2NhRmgojqx34Rfv5YvixGkqQsnnG4SL9b0wv/xlMID
	3Fcdf/iTRdXkixX6zSnthAie5U5pzDtJ0DK5mRJvyHF2oASm4RKU4csGyRyFhbtH
	eWE+CjvC0a78CHADNYKnw==
X-ME-Sender: <xms:nSw2aOgpOD4AFh83bO28rlVpgB2UdTr5ARyl7_Uly-M0LUQMef3AeFI>
    <xme:nSw2aPBjZg1s6ZP9qxtGdQxBoPYcQeR8_oMDFK3ypjBZPIUF-e1QqRPd6qvib_QLt
    RVT_QHGN02KYlZ6mA>
X-ME-Received: <xmr:nSw2aGGFAuvqJ7YM3tSCliQzuTOssogRoPKLGQMEbwLMkRpkUecHbed_Monux2CzsxuKNwYLA0GzFXTu2LduErbytU5V3OCqrRLuOEDCm-YPMYOs8CjyOijXuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfej
    kefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:nSw2aHRcN6xwvluCaUKRn4isRa24dWJWHgxuFbHkwAnGTy3rxy5VmA>
    <xmx:nSw2aLxZ1h_oQdc0Rhkpzh9zs25DjKKl9rUfp7tIfz_6ldO2tL3DZg>
    <xmx:nSw2aF65GWUvgHmiUPobbRu9wOXBO6UcMgvzAvt2ehP5pY4iLFSNow>
    <xmx:nSw2aIzywwF0FHeXuuiXiwXQ8NX2KegE76wFZYvfHfQE33X2foNLTw>
    <xmx:nSw2aHO-4U00oyU_Z7VugjkBa37P1t7ld-crSoMBDSkcF4UIXsV2E1XW>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 9/9] doc: notes: use stuck form throughout
Date: Tue, 27 May 2025 23:19:38 +0200
Message-ID: <7751330daa4fe28f4c989e9d27e9701bb21bc0f2.1748380390.git.code@khaugsbakk.name>
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

gitcli(7) recommends the *stuck form*.  `--ref` is the only one which
does not use it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • I didn’t spot this in the first round.  Hopefully it’s fine to include
      it as well while we are editing this file.  I would consider making a
      separate thread if I wasn’t editing nearby hunks.

 Documentation/git-notes.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 397f6caa92a..46a232ca718 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -200,7 +200,7 @@ order of similar options. For example, for `-C <object> -m<message>`,
 previous `-C`. This is a known limitation that may be fixed in the
 future.
 
-`--ref <ref>`::
+`--ref=<ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
 	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
-- 
2.49.0.780.g892193c3f50

