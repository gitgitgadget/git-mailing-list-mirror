Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934035DA6F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075823; cv=none; b=FF4qbybjV+D1PCjsH1lIbB5cYloZFwDO+67uhxQEh92GLB6ZX3EsQjl+mts15gPL90wLDB5/mn2DoHw8NQi9LS1PEV6IBEVlnJkvKvXFurexuE38ZtVJ3PLrT4xqSR4YgM48yLYtG+pjLaEEjNt9jDSzmewCggwJcPpuO9ZWU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075823; c=relaxed/simple;
	bh=bC3A+Ti18htRyvMokjCQISHv9/hw8G6q7PgOJr71zEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYjRI5aPnbRc09jxMWjBK3Grg+g9wav0AHxmLY02rLVhCdchDRGytXdghK/hVZI4XqO2Sfr0tLMz66yDf+6ufV480KXov4C2SfDJWn9jKimBOK6gW2hSkVxxk/db3TYvXTV/P3ljQBm2uvK5vaUKpDX6bzQ6ZLDRYgB3iuW+onY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Je4rhw+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVLujhWr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Je4rhw+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVLujhWr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 60FA8EC0404;
	Mon, 13 Apr 2026 06:23:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 06:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075821;
	 x=1776162221; bh=rLxLZG4TMJqAiyivtL2fbGnNthzJsJcf42rTRPfFDmo=; b=
	Je4rhw+dzLHPkYtZ4jp29TLVTdl7JIf6820hU0sPir9XGEOvYfEd14VejSCvkdqL
	w4ynLa+ewm3GefBMzp6pd/CB2eCweOGMp60XZLQrdOije5Fqs+fN0Dd24Crb7WfU
	Yt3yRuAEpjdokRSPK9WHBOPw53aAFw/0C7a4THBWGCnMykJtR1554kso+y4SRKuZ
	pvGwI6Ei49Rxqrg5KCkxCpNEltSfiVIimY+HnqF9gOhaNxEXGvRWkWQtDiVs+kpQ
	f9vxIxyH5v8g87eHU0ELSB/oq23oqo08APGJrg0R4DaWY1sazdfVVUUMZCPmJH2Q
	WiHNNx6ktiCQ8JlP2Pu06A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075821; x=
	1776162221; bh=rLxLZG4TMJqAiyivtL2fbGnNthzJsJcf42rTRPfFDmo=; b=f
	VLujhWrUZ5ikfuyqbvyxz7gTcL+4AL3E0wDwk7mwZQBzhwjkabb4FXDI/3BFbZN+
	muIJYI0D8GI8vR7rYxubfyo065zVKQIEAr1SZbI0TT+Ea5KELcFr1/Ku92/Eb4+x
	kJYutgalzfzEszON9k6D5vvvH98apiOtG+cPPA/BH45qyYh0D2mUM1sYiodsMsoZ
	/bq+EJ9YHT48z4PM1ck+7dzKKzFIE+eJ+4O2vb39iG388CQgxKIzApB/ZNNRlmU0
	gOOOYReh3Jw1/VohiEzDE2VzgFHKKVAFJ3iUfBW6aLazfhsuHLQLUuJs3yht6b/v
	Ipf+W7m+szd17DaknfrOg==
X-ME-Sender: <xms:LcTcacDIN0u3i-8S5PG2Z5cTtQ_0-a_LNcXlXY09HvzGQVnLk7-C8PU>
    <xme:LcTcaVbgSdFC1T0fgkeVSy5BhaN9trTHmddesBzLdJ3LW7b9kKpAK5VPMPFwGKkg_
    AGvdaHQFRhsWD9Nwtczu-KqejrCmf_NpsEGEyLTdRD-aqGDjY2W4Q>
X-ME-Received: <xmr:LcTcaX5bXIJgczCHYZg5GujSUkH4ooAcrz54CQ0tI0lTvbG709aSx4zzi6uexd31VwuKTgu4EH9zEuvVvdlMQ-TyXvxr1T0hKxT-6q9LqmlIuNyzRL7Kl8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:LcTcaeZST53e3fCLRoHNhbAnJYl2ySmJRyott02I7p8uL7-pSssJYg>
    <xmx:LcTcaeisXlQEa2SvZwzICiqtF2Kq9O1GQHezH1NpkJ3uIBYgwZSOkQ>
    <xmx:LcTcaX9ohJUTkL0WUSD2-jT7aCxdjSaV2qzod0MXAUJNTzEelfbGOA>
    <xmx:LcTcaRrgj2xeirCr624SxGmYkKI9zDj6d20OSe9BlGnM131shHmwMQ>
    <xmx:LcTcacrSMeFQCJrhW0rhB9HTe34kQ8-T3u1ZOW5gR-CG7IHbw8j4GUpE>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:23:39 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 7/9] doc: interpret-trailers: add key format example
Date: Mon, 13 Apr 2026 12:21:06 +0200
Message-ID: <V2_trailer_key_format_example.61a@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

All of the examples speak of the Happy Path where everything works
as intended. But failure examples can also be instructive. Especially
for explaining again, by example, the key format (see previous commit).

This also allows us to demonstrate trailer block detection with a
concrete example.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index c35fa9c688d..f215cba4bf0 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -405,6 +405,29 @@ mv "\$1.new" "\$1"
 $ chmod +x .git/hooks/commit-msg
 ------------
 
+* Here we try to to use three different trailer keys. But it fails
+  because two of them are not recognized as trailer keys.
++
+----
+$ cat msg.txt
+subject
+
+Skapad-på: some-branch
+Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
+Reviewed-by: Alice <alice@example.com>
+$ git interpret-trailers --only-trailers <msg.txt
+$
+----
++
+Recall that a trailer key has to consist of only ASCII alphanumeric
+characters and hyphens, and this does not hold for the two first
+supposed trailer keys. And now none are recognized as trailers because
+the candidate trailer block has at least one non-trailer line, even
+though `Reviewed-by` is a valid trailer key. Recall that a trailer block
+has to either (i) be all trailers, or (ii) consist of at least one
+Git-generated or user-configured trailer (and some other conditions).
+And (ii) is not satisfied since we have not configured any trailer keys.
+
 SEE ALSO
 --------
 linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1]
-- 
2.53.0.32.gf6228eaf9cc

