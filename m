Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C21F4161
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064838; cv=none; b=aakPVUzdbnw1qhHugzsFC+23t6AEPz+8FWwWthqkC+1rARV6WirEQawJ5acusj9Q5eebIZRCJkoHbc/BIl2i1SFQXS9sNgU88XTIu9Z9qE9RrA/orq8jkDF5cg8cfRtGaKySRg6V7Mw+tEmYyX43QMSUi+ZoGesJGE4AKjaJbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064838; c=relaxed/simple;
	bh=vE2VAGQXOHFRqT5R5VJrKn9n2ajLHgtf7ld1QguIfZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LiD1nlVgN63AXPmj1Xs6z3jdfe1Y7T6YIRcjBelZmDqq4UBY8elOnooRlVUPM228JSQBK9QIniY+ib7c2sGdlCzR0jtPjK2spCETkl545wgMeFv45slr7dHwXx8btMOaNVCZkIrzo6g139UDGzGVkqS+s5ovVxDc0ELsMWsmYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HamN7W0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVP5Fp0/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HamN7W0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVP5Fp0/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F2474EC00D0;
	Sun, 24 Aug 2025 15:47:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 24 Aug 2025 15:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1756064834; x=1756151234; bh=Ty
	dKxMTwom1vsIZUvBdhzsR22JUgUZAMjhfOxSXrlV4=; b=HamN7W0LhYs/JpmlBb
	6eGwcDn7MBTc928a9IV12MjM02zOG9EpkdfzWfZiD2J9QB6gT9chvTLSXLETkpI1
	m3oqTgtHGbgbwgqU1Q0cOJS1PNZTJzrkW6lRXsN0GfHtL5Vgf+Bmw4RfoobRvlM2
	L0cC3hvTM1VUTGnEzcWj/vTLvSlUfUfVK8l0tfmWPlOT7xb4LDrTSHRPQybhdYc7
	T48sEfl3kBrgPqeetGqodItm4F4XJKhYBnZd/W79fsogAO5CoQRW6D9467kuNxAZ
	YHdzUCmPnRoUMYC22gpvUF7HsH+LuFGHmih6bYkAZ6MRUFcKyWo6KrMwkBlUZeX6
	YFMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1756064834; x=1756151234; bh=TydKxMTwom1vsIZUvBdhzsR22JUg
	UZAMjhfOxSXrlV4=; b=BVP5Fp0/XN6TAR6CjN6AJFyPOKecuN5X+SKTw4fkYvrU
	33dfYASm8lDILuRoVmeZsZx0cGrDQEurP4UpTYcEwS3wDxmbXaQivllhZqrz70h4
	/YdJMWywkya6XGORGpzklWkWosO5HwkyRT0zosKOLj8UFtog7XRKTCFjBhwNRiCD
	qQAANUghpx1WdGPrLmzwMsoPVZgB9DPmuTc2m6N0y1Et2C7iB/A8ogEsqHTlJKKx
	/VKiGkyL9hdsuynuAnI5cPn+jb4+kmZcHqJm8Du/MAcJ1BiCqPF02C5xOtrUuleg
	igAtx6aTMpAB7U+bNzUYIQ/8WM24kTqp5M0z2eZArQ==
X-ME-Sender: <xms:QmyraF1iogVGSJKPR8RPHlMPD_fIbV0j4yImIhdL1bvRGLGB_YHpKw8>
    <xme:QmyraPV3vdJvtvdU9_33CAhxALLjxjyBg-0dT2CPqdT_cT9ixNsnNVcoeY8ceO-9G
    809tKTl3IeJXAnuaA>
X-ME-Received: <xmr:QmyraPW0GOnMGCllX-il81SCQP3Bw-4LBcVV2H5DwRp8X1DiQjjzNE5eyRGAvxQQ6HJBvteDRde0GLRY1AAPm5_4YzoLiGnIqkqh2TFHNVsICa0JX73iujrVrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeetgfekjeffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:QmyraOelViSN4HcfLrorvNe0Qkr2rWg2chWQFzieuIsKfVlQiZnKKQ>
    <xmx:QmyraIWud59ZCqc9is2WhVH5bgc_onpqQMSPQCIF7f5ZU-YRqbZRxA>
    <xmx:QmyraHfWLxPWWL5vs9exjq7hJnSmE-4T57CKAGZgr-7ArvxlR8ixJA>
    <xmx:QmyraEP773BNhZLz44ZdxdR-snhSPwz3lJ1p7nPqrmm5nbRJPhQH6g>
    <xmx:QmyraJmW9Rbh83LG0HCDQ1RU_T9S-ldjf9DNx3V5f-gBpN7YJE8kHQuV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 15:47:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: config: replace backtick with apostrophe for possessive
Date: Sun, 24 Aug 2025 21:46:51 +0200
Message-ID: <3ec6a00e3046166c7adb593f38c4099921d8ada3.1756064760.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Revert back to “Git's” which was used before d30c5cc4592 (doc: convert
git-mergetool options to new synopsis style, 2025-05-25) accidentally
changed it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I didn’t find any other occurrences.
    
    Demo with this commit merged into ‘master’:
    
        $ git grep -e '`s\b' -e '`re\b'
        Documentation/MyFirstObjectWalk.adoc:block under the `#include`s in `revision.h`. The most likely ones to be set in
        Documentation/ReviewingGuidelines.adoc:cooking" emails & replies can be found using the query `s:"What's cooking"` on
        Documentation/ReviewingGuidelines.adoc:like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
        Documentation/git-add.adoc:You also could say `s` or `sta` or `status` above as long as the
        Documentation/git-mailinfo.adoc:*	Leading `Re:`, `re:`, and `:`.
        add-interactive.c: * It is implemented in the form of a pair of `string_list`s, the first one
        add-patch.c:			 * appended to the strbuf `s->plain`.
        add-patch.c:				 * `s->buf` still contains the part of the
        compat/regex/regexec.c:	string `s' and transit to `b':
        reftable/record.h:/* Advance `s.buf` by `n`, and decrease length. */
        t/t0013/shattered-1.pdf matches
        t/t0040-parse-options.sh:	error: switch `s'\'' requires a value
        t/t1092-sparse-checkout-compatibility.sh:	# The following `git reset`s result in updating the index on files with
    
    On ‘master’:
    
        $ git grep -e '`s\b' -e '`re\b'
        Documentation/MyFirstObjectWalk.adoc:block under the `#include`s in `revision.h`. The most likely ones to be set in
        Documentation/ReviewingGuidelines.adoc:cooking" emails & replies can be found using the query `s:"What's cooking"` on
        Documentation/ReviewingGuidelines.adoc:like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
        Documentation/config/mergetool.adoc:	are the versions of the file from before Git`s conflict
        Documentation/git-add.adoc:You also could say `s` or `sta` or `status` above as long as the
        Documentation/git-mailinfo.adoc:*	Leading `Re:`, `re:`, and `:`.
        add-interactive.c: * It is implemented in the form of a pair of `string_list`s, the first one
        add-patch.c:			 * appended to the strbuf `s->plain`.
        add-patch.c:				 * `s->buf` still contains the part of the
        compat/regex/regexec.c:	string `s' and transit to `b':
        reftable/record.h:/* Advance `s.buf` by `n`, and decrease length. */
        Binary file t/t0013/shattered-1.pdf matches
        t/t0040-parse-options.sh:	error: switch `s'\'' requires a value
        t/t1092-sparse-checkout-compatibility.sh:	# The following `git reset`s result in updating the index on files with

 Documentation/config/mergetool.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/mergetool.adoc b/Documentation/config/mergetool.adoc
index 6be506145c1..7064f5a462c 100644
--- a/Documentation/config/mergetool.adoc
+++ b/Documentation/config/mergetool.adoc
@@ -65,7 +65,7 @@ endif::[]
 	During a merge, Git will automatically resolve as many conflicts as
 	possible and write the `$MERGED` file containing conflict markers around
 	any conflicts that it cannot resolve; `$LOCAL` and `$REMOTE` normally
-	are the versions of the file from before Git`s conflict
+	are the versions of the file from before Git's conflict
 	resolution. This flag causes `$LOCAL` and `$REMOTE` to be overwritten so
 	that only the unresolved conflicts are presented to the merge tool. Can
 	be configured per-tool via the `mergetool.<tool>.hideResolved`

base-commit: b983aaabc8b8cf406686f23689dda7e226f67e44
-- 
2.51.0.103.g04b6f1b0792

