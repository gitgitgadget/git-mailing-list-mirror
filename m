Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D064C6C
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775385143; cv=none; b=jrpQ3HqNTmx6HYJr/wTm8UV1HqP0NnxL1/PLmNEBKwgELBVJ2321VLZS2i8w/sucgfXt4amYYR97JfZhMgFYi4zFOVUkc3xWfBzkS/yorSvL1l13y8vdmiLtE6GMONUL3WoS10vCVQjFDmfXbUuCZ9R149jbLdqH1E5TYqoZig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775385143; c=relaxed/simple;
	bh=ngfAgaHFs/Jzm8sSDZKouNyIJgzovydIQ/GrrZQPPX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avOgJhmWOHmfjHf9kWCxVUxtQLaznGGX7Nr8E143aotvsupJ8byb7KZo3r9lIzXEYZcex0OtKy4uIaahgLiShfFCzAKrKGzMelFGt0U93N/XWrqrrDVfz1xVtRBXJBr+wGFPbhuzH1/EnjeY3BA4Y4HPx1iBLlPQrN/xmzDVvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SAaJcypY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFfEFGim; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SAaJcypY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFfEFGim"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 533DDEC00C0;
	Sun,  5 Apr 2026 06:32:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 05 Apr 2026 06:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775385140;
	 x=1775471540; bh=JcjtZe2lap7qmNwhtX6TeVKg3Cm+oMHmR5FSr+t0k1M=; b=
	SAaJcypY7aiNvNOAvIAUZ9gsiFk8FIjtjEaM8mCzfO2hQ7HRNbfwMfxQV6EZn+cr
	V8VEycSJSBGk7+AtZhZ3YLc8YaAI2UIx/bkeIHJ0y/tA+uJxVf6XC69TzICRy6xD
	WMoo5W/vmphDV5WMY/zlMcPr1r1glqajtjLWnsTlDCb20pbyE8MLwbzqsBbQQaod
	IPuczBehC0WeB/HLvLMmrRoUufatsfK52hg9X/+QuzgdyIszqrerBJRf3UJ3ohrG
	pdiZ/CdqYvu2C+PsyVIhopv0jwm5ZNvHAddrm+bx7G9dHQ54lLbPsHQAQEShp2+V
	rL8pxaprG17a+gnnP94O6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775385140; x=
	1775471540; bh=JcjtZe2lap7qmNwhtX6TeVKg3Cm+oMHmR5FSr+t0k1M=; b=Q
	FfEFGimNRGLTTYUyNK/mg2lET/tOp0qtEjsMsnuNHX2AsbDTSf392mBqGkQ54f9z
	LlzoARIAG4EJQPQijm6yA2WV3Nt066BY0TrPmh8QZPkEpJVO7VGJCFdal/bf4BSH
	HYz7w0JFz1XU/eOhlLKGSYDb5ErE8hcU8ULvX+bBw2oXnWz7F30tHbJjwbwfAccb
	dFLbf87SapZPIjAXemFd60Jdb4zFVKW4fq4lBy8hhIAlVd2lyktdMNOvmp3lzIw3
	eQR8UdqFGllUDr+Tf3lbyq3kVOYuKGAVislkyh/f1op8WwtrKZheMtXGym+4CBRq
	4vDwmo8D+iaPLwHLotpkw==
X-ME-Sender: <xms:NDrSaTKozAnY-4IhyXBEkbg1rHENm9adiz_QQeRMH3EgEQ7PTvWaylo>
    <xme:NDrSadIo7E08iW5mwovjb1rAcH8k0ADECd1ae7v-eFiQ9xRH8J0-Qv56VRNc-9tRf
    1A8xntsIYLygIiSN0AR6Cut4CM0qy-GyfYA2kgL5i50ggFyUoFXg8o>
X-ME-Received: <xmr:NDrSaZUDG0wktV_LDUGUK_1uIkffOi42pacS4q4eJlNW_Pv277QDECvm1SeebZcACXlvEcfswN-ZIxBKqj779v68khUeJ7fDtO-ChbbVjz4cUH45gI5XGh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:NDrSaXit7ld2-FELXdNdABSREUmlSEruXNipOJV-3s6MFfYBa0CG9g>
    <xmx:NDrSac8p4MSdHE2SdRq2_9xAZ-TptCaH05edNoJnn4lvBVObUAikGg>
    <xmx:NDrSaZCybeMdSrWzcHzEb4TwTxXVo0eD9tUcAm6RRzjIDCMVf5t0Gw>
    <xmx:NDrSaRIad7wsjF7LrnLZrQOCEqswKg2ISUaZ9qftitevtMkraghNvg>
    <xmx:NDrSaWi3471i6krfWmTzR9uLnIh4E9_m99DerS6Ff7jiD_ZB0amPeJ2o>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 06:32:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/2] doc: replace mentions of deprecated git config --list
Date: Sun,  5 Apr 2026 12:31:58 +0200
Message-ID: <V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-config-no-deprecated-list-opt

Topic summary: Replace uses of deprecated `git config --list` with its
replacement `git config list` from topic ps/config-subcommands.

I found `git config -l` in git-var(1) and searched for other occurrences.
I have not considered the other deprecated options.

CHANGES IN V2

Do all the straightforward deprecated-to-new transformations. Then do the
“man page” change. Also drop the faulty admonission change.

See the notes on the patches for details.

[1/2] doc: replace git config --list/-l with `list`
[2/2] doc: gitcvs-migration: rephrase “man page”

 Documentation/git-var.adoc              | 2 +-
 Documentation/gitcvs-migration.adoc     | 3 +--
 Documentation/gitprotocol-v2.adoc       | 2 +-
 Documentation/gittutorial.adoc          | 2 +-
 Documentation/technical/api-trace2.adoc | 2 +-
 Documentation/user-manual.adoc          | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 98f4dc1a479..697c10adedc 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -21,9 +21,8 @@ OPTIONS
 `-l`::
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
-	as well.
-+
-WARNING: Deprecated in favor of `git config list`.
+	as well. (However, the configuration variables listing functionality
+	is deprecated in favor of `git config list`.)
 
 EXAMPLES
 --------

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.32.gf6228eaf9cc

