Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785881E201E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543695; cv=none; b=FkaSf3WpQUZRZcg/pNvNd0b8F9XivrDV1G94JBvdvaXl6XineS1rqNCcRfgOzNza/97foPYgH9uyksK5+eJ4tWb8aWMkJJgPvSuu83HAd0d5KBTBfNKTuIRh8c77y1js3H1R1j6Ejsuei+X08trHLcuiO4+VbKHQ8jOaDPLjuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543695; c=relaxed/simple;
	bh=LOFUmvTIeQ79yRKAOeaC6r2Y7a/mxnYkPLKMUTjCK3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az/9fNaFyqX8b0Y0EGo7G7Cbp3zKJ+GBRGYrhZsUZ/Yczj/b0i4NUirzN5oH5zJu6PE9iYuzNwc/wn1RMi4IIaa+vtiFyiIjvoKixUw12a9pkdyhU/dQ0+Xpc9ItE/xK1HnEAt7cJIN7AKml9zuS85EPYfbxh7OqOvmpypj7Xlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EMiXYryQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRuNNHpK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EMiXYryQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRuNNHpK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9399B11402B9;
	Mon, 21 Oct 2024 16:48:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 16:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543692;
	 x=1729630092; bh=AvsJTTAgdBFAiOyZLbEAolOen6ZlzpjCFyedxT0psEU=; b=
	EMiXYryQz75o4xTIHSIDPgp22IjGFuKLdVv17KGiOHidd6tzXK086wIlcwzbKjnN
	eunBk1pYDZz5dAkZQjBky7VmOrl/A+IAkSLLQP0lbylTVQxMNGBA2XCdfokrAU9s
	m2LWQeRvPlxP9N/J3InPvvtOaOF6LFZ+Zms33dwXjyKwquWSACw3gaKFLaA+WCM+
	A+lpDgVST6WdpM+j6JT21JFUMD4LAyY32PgetXMHU+MeQLHEcWER29GM5UScehaw
	InascMYf/QiZ/vN1GqEC7vAbpV9Z1Y9mjwq+LO/CTZ27RGGuJFNm6LLBg8BjcL6t
	FT9yFF7i0dVM1kd9tw+QDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543692; x=
	1729630092; bh=AvsJTTAgdBFAiOyZLbEAolOen6ZlzpjCFyedxT0psEU=; b=a
	RuNNHpK8UywNvbT9+qvHuGTqzNJV80osUBdm9+NaUNtAudvDwR0pz/NVn8EpS76V
	EbUMMjzULI9aPQAAUW+6yf91wSj1/XtEL4+jRIZZ+9D83SMRVDRsqdhOq37QFiSK
	hojEZIqpvbpsp3Rgm0/xFARh9jQloUc0s7hYxyA61hZ0QNzqiAmnEBURaDKyUVXI
	GhGp91kq0NGt2Fv860hD7UwWv33yHuKY2ayCmzwJbbZ58ndll5JvctL3yjOPzbFL
	8TxmAXiTVHkmqMfLVaB7E7+po/kTYAbTD+FGbkBDTLVuXByfFApruKyBSTJCSVBl
	FvTss9BAfGl4B3UlaCrpA==
X-ME-Sender: <xms:DL4WZ2nWlRm02OrjI26lmFjs8Aq2LDKqkqzlN5b9lMZJsHEnGj71kLQ>
    <xme:DL4WZ928MIL4iPjBMxfpJXXZIIlnz0sox3D1DNMKUVgT9sEvaqYrAY_U1gJVcsWhP
    uJ_435LPA7Fubx4_Q>
X-ME-Received: <xmr:DL4WZ0pQi_GGlMQTYrU0czqZ0XlcxkEEimVy9oVOgHUZ_RZ7nF1nAoM0e0hgdZVDkKHiUrtDNMTf4MsfHbLON9H9AKZs-rG9iGbC3eg9JDfcn13Am7mkNn48HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:DL4WZ6kXj3dS8FDKzKWcoKPZk-Z869MFJeAXo6Tdm4Ex7CLsyWZFtw>
    <xmx:DL4WZ02tPhGWWP8jem2bivGXvsGog7EraQaGQUvTbPRfGT3Bnz5BCg>
    <xmx:DL4WZxuURbHtotScxwpUIWEGRHIIJEiE6jVI_L0k6bqAGrsemLwRWA>
    <xmx:DL4WZwXjMWPZuIxO_GxEyZVRzv3v_frSJuDXkKf1HCALxShvHZr9dg>
    <xmx:DL4WZ1LfNsQv0OuQx8mE9cBwswrRYbi-RKnxJGHVn58FlSncclddQEAk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:48:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 5/6] Documentation/git-update-ref.txt: discuss symbolic refs
Date: Mon, 21 Oct 2024 22:47:28 +0200
Message-ID: <5033ec82586691065504e429d0c21464abee945a.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name> <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 5033ec82586691065504e429d0c21464abee945a
X-Previous-Commits: ca5ece5336c85a47339537577a4c9131f8938cdc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Add a paragraph which just emphasizes that the command without any
options does not support refs in the final arguments.  This is clear
already from the names `<new-oid>` and `<old-oid>` but the right balance
of redundancy makes documentation robust against stray interpretation.

This is also a good place to mention why `--stdin` has those `symref-*`
commands.

Suggested-by: Bence Ferdinandy <bence@ferdinandy.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: grammar: “robust against”
    • Message: Apparently the first paragraph wasn’t wrapped properly
    • Fix “the the”
    • Credit Bence for this suggestion which I forgot to do in v1
    
      Link: https://lore.kernel.org/git/D4U30MD29CJT.3US5SBR598DVY@ferdinandy.com/
    • Message: “symbolic refs”, not links

 Documentation/git-update-ref.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 61647ee8413..2e85f7ce3ee 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,6 +25,12 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
+The final arguments are object names; this command without any options
+does not support updating a symbolic ref to point to another ref (see
+linkgit:git-symbolic-ref[1]).  But `git update-ref --stdin` does have
+the `symref-*` commands so that regular refs and symbolic refs can be
+committed in the same transaction.
+
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

