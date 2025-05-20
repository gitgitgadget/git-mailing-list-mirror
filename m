Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B128032C
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763907; cv=none; b=YAU8ffS+d8pY5jE9NQAypyhx95seNUwKFYLsS4df/jfGymXPQA2izisDZWEG7NTVM3NSLWGbFpAfQCDA+bbjefgoHNh+YSPz/Fde9ZpxQo90AJN7dV7khZWDqbNyYZ2NtSuTVF7CW0zOvKJ0Yu51nqiYQyrE7FnwG23sYnNYh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763907; c=relaxed/simple;
	bh=68bQx/+zdUijY2K6BU59Di2C8X+MSjVFopRSnzt7TJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFFt4opBIsYNkQ0Ml9qN5N7aUmUu59LSIYIJpU7zKi+HmmMu/f1d9Y2KA+Oihr3YRppSFET09xNlNAjgnX/SKohpW+GlEsTKRAPwek6LWKoLSY9+4jgGjyzOlDpNQp7qDV1LUTlX6vgVSo+IgVMx0nXvZBCrhVtbV1diK9yKMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pyG81Vdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5SqlAo+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pyG81Vdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5SqlAo+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D38CD11400F2;
	Tue, 20 May 2025 13:58:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 May 2025 13:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747763904;
	 x=1747850304; bh=6boaIwnrmFzD6VIERC6rs91YLv/cnHzQSsafXm07HOo=; b=
	pyG81VdfBI9rKylrL/Ojrsy6pVmrA5z0wpqdHUtGGsJCv3DGKR9uHjOWRkHkQZD/
	uTJoST66bBp3XBP22x89QMhTz4oaejdNsJPx+TVcoZMWzthHg30esihEkoa8goSv
	XyevlSosQ8sOZAmdYt4H9c6JcBJqlhBk29BDKa9GGQLo62yndpRATGlNqcU1eekx
	iCWLmjMgL+gbyQunaDvAT9nPe/GqIdhRWZYxjcV3bCHIt/Gd4FUTbgN024rkRLxl
	heJWEeqHYBiOhR+Ms9tMpSV+I5+TL7LCuu7R6cGOZtY8dcFChaJusTSwmHghXfEf
	Vewu04AITlx5ia3P2EUtdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747763904; x=
	1747850304; bh=6boaIwnrmFzD6VIERC6rs91YLv/cnHzQSsafXm07HOo=; b=e
	5SqlAo+LICUyiqeKN8Y4V2XP+uA47NE9Whp10fS5CeN0V/hG96rPIMCzXR+Vd9Je
	rI3c+Zp/bh5pUm2odafG7LRBNa2Us/n2UMfT2iVW1TvkXRqLBeTVOZWf8PTVchgA
	BDbbzwQMX0fzvBEAB5xMMtbDHdSQTi1RsDkGr/n3hDdEvrxrWOUYlnUj5VXeO+LS
	b1kUy/AIuLXep+bE+Rh+MSBj3UVHXFiJER33FHQpa6a4xwxM4xEAM/5D+L/sl6Zh
	tcCcXUxvuVZgDjnNR6o430rqRvD2xVfwzH4QK3s93JwpQcqCU6N4m+1NooLKYW+P
	5r7V5KdfPXF9Lg4ZfoBLA==
X-ME-Sender: <xms:wMIsaHKC6Qoy7ozRzY-I99pUOZih7F7sG-6vDN0BVezLJy8iVE1Hrh4>
    <xme:wMIsaLISrdV43WTEEq_NO4VgZ_wzaU2nrJlQOfZS2-tmmwDfdCnRuF1nmd20nAQwJ
    3WbwI4kzhMhW5kGPw>
X-ME-Received: <xmr:wMIsaPs59QjqbY8vYnNe-YrlP-e2kJseOUySnmKLekyQeKoQfWHgTr1dnAeDSQ4BFG0rcdoF-YZtB3Xy1dRHBeareSSNYuKa9Go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtf
    frrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeet
    udeggffhkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wMIsaAaeyITDlvgfvC1t2F6ygH2-K7LPGC0Pio78BljspGhYLXdwjA>
    <xmx:wMIsaOZwMOVoCEKWS_U7pKLXBdujcDcZC4CLm461Pd4ieDOrDwHwBw>
    <xmx:wMIsaEBS_SN5lTaiU-zYTQYbWZmQay5VTZOYeiXr7ewd206frkJdaw>
    <xmx:wMIsaMYWX7BSL4jgmxgyjutp8bXtRC9wxzjiglYR2_jCctBPM6OT_A>
    <xmx:wMIsaCQgdQYLBaRItLnF1iN1kp7MwSgojX2yTw2OlvgslR7MYZ-BHs3t>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:23 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 6/6] doc: notes: treat --stdin equally between copy/remove
Date: Tue, 20 May 2025 19:57:24 +0200
Message-ID: <68e5eb78040419ba64e256910501c7e37194b222.1747763769.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1747763769.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

46538012d94 (notes remove: --stdin reads from the standard input,
2011-05-18) added `--stdin` for the `remove` subcommand, documenting it
in the “Options” section.  But `copy --stdin` was added before that, in
160baa0d9cb (notes: implement 'git notes copy --stdin', 2010-03-12).

Treat this option equally between the two subcommands:

• remove: mention `--stdin` on the subcommand as well, like for `copy`
• copy: mention it as well under the option documentation

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-notes.adoc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index d2d7dac8d41..1542850eaaa 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -127,6 +127,10 @@ When done, the user can either finalize the merge with
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
++
+In `--stdin` mode, also remove the object names given on standard
+input. In other words, `--stdin` can be combined with object names from
+the command line.
 
 `prune`::
 	Remove all notes for non-existing/unreachable objects.
@@ -208,9 +212,9 @@ See `core.commentChar` in linkgit:git-config[1].
 	object that does not have notes attached to it.
 
 `--stdin`::
-	Also read the object names to remove notes from the standard
-	input (there is no reason you cannot combine this with object
-	names from the command line).
+	For `remove` and `copy`. See the respective subcommands. This
+	option can be combined with object names given via the command
+	line for `remove`. However, this is not the case for `copy`.
 
 `-n`::
 `--dry-run`::
-- 
2.49.0.780.g892193c3f50

