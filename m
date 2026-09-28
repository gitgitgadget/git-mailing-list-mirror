Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0246EC9F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592135; cv=none; b=EMPP4XxSj/l87KrfERNDR4nnfdSepf1M3L0i0Tc+k70TdUTCenAbSTErqS/tfHOfhyKytBw71j2TXMCj3Y5JjLNhaCp845XmzS+9TF2HPMrmnlAxnFXrwwpKl1PQT9h0DY1H94gkD0coVcF8oAXFDVEIB9oE6w4V/Hxprou7lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592135; c=relaxed/simple;
	bh=u7Ql1QMUtZVRg1sRJ1bw5HZW0EIDELW9zffqDIJbGMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8pG7/C5cBPL6uhqul3P91Q5d8njk+pvD+KFmQFxiaJaH8cWcCX7So2dLDgu5Y0rhTx4rrYe73KvyApFlllBDU/VhYSk9UZAHRq6Z2H0AnwnpsuIaDfH/dpyJ7W34sbz3pBWKEma3O2lTbOyqvWJ5AgnTkyZM/e/v2/ZmCV2APw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HWXZFsTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHP5xLXZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HWXZFsTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHP5xLXZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E03ED14000C1;
	Mon, 28 Sep 2026 06:42:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790592132;
	 x=1790678532; bh=Ncochm9zwPa6k4tvk8ONmgZLlCcOmDIFGJtS6/tAlCs=; b=
	HWXZFsTYYTcFO3VBVZSQVPytaPnCy9OXk7E0l4131juMqsJFuV2BAAx4VRZoTDD/
	xp0sH/49mdloli3aGyte9H4HnLNITfeBXlcIuA/LcMDH1lMmx0FndpxKpscpEXEk
	qA3eW7DUlEbyZhvtTHEjibMZ2M312YKOjvDzlXej6sKfnGFuWTjHl7n7R8gmWSFm
	dtTXpie7zdCEuhdHyQ7UC2zF5W/mcn2NY3C43JE/MiVYHNhjx8YmJ8trXatlQtdG
	+P/HSsnvg/aaHWKF7obAmsoSicxHO9xbrgw4w14XVUyn6XntT2011vF+ZxcLUEE3
	qsM225PROdiIGTsXQlLUzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790592132; x=
	1790678532; bh=Ncochm9zwPa6k4tvk8ONmgZLlCcOmDIFGJtS6/tAlCs=; b=M
	HP5xLXZoT0EYmZSwz+ZbENW7O5coXUJtaFtnNHrwIZMU49b6a6EXkwM7gemvXaIC
	WbRzSn+OlfwfGkQa/nNFH1yHCU1+byTEzYUsOVBcSqTAEMxIbdSEaayeltjZ9tpf
	pmcGBMw1zitYn1USreSc6ZsEwngv/AiO6dibF1A+CL/ATo9Sl/ha/SvscIziCVd2
	5xv3VchmoqsrRKKGzyYLh86P/rJPpbjoNWosaMgtQsH9jsDXMU1+xVZ/LrNPGiF/
	pUdWHGg8bXmSBz7EW2i/D4z+OTqezqCwIj57oDOf9xTbyp/GdJ6DUdVM2Svi+0V2
	eb7NX84ETqFkpsUD8TdQw==
X-ME-Sender: <xms:hES6alx4s60oFT7Giog-s1xxTvPj3GyZutfK132wi9l495cddRfOyb4>
    <xme:hES6asveLqLJuaPK2A29Jo-Lumcqe5lEmgBDjVeK2xJOufDosK1CBGZ970-qqF7zj
    6PKEGhjoD5kGBrPp_OACIJ2KrIxaXLYD7NFsiHnCNbkLAw6icbREiwt>
X-ME-Received: <xmr:hES6astGwcsLdjOJTGYIs6Nkq2K1lfu9-rSh07YAVAaDy7-s6uMUQiSm0JvwSbXGCwsPrpgtrgg0DVqCCLhDTGGHlYhpoymW7YotPQ0>
X-ME-Proxy-Cause: dmFkZTESCA9YTALB4yhwhtKfQyn7qAq9oR3Ti/Sz87GyxAlnryMNW7cxbHaZSEfjr60IW7
    dVxjD/n3CZHclGpo4AWuD2xoDSo21GFTUM6WF6jQ8CCN2QHJhZ3eE/lWzAJKTqsSwzu8OW
    9HAQAjB+PvSKB2M2HESqm7f+X7GonY/wcgsvoMT/cOxXFeP72aX34ptf5d6R6rIouJIcsi
    2XCbNcz1DdyP0y7Ft3ShtLIzsE/Gyegnp/a0K47+Bo8f/Zgf7Oxp/j9ybQlx0Xloc14pib
    PoS51HSD8NBke6r8MrrHQ/PssX5MWei2D4Bs97x6vapSxxMXAd+4+30O3Yp72ydL0fAVXp
    +RDS0IvAnUPMBzFkXs116TaByqOrKwoAxQhfN2/xxn4EL75mfH1lSgUvZLUs8z+ZhnyXxC
    SzrjBg5TJ4r/3NwmRVOhKfpY4ihVEefKnE5b4SGygmzwuv4pjM2hAeeKDk2V0LR5LVnK9Y
    AksEfHgpegg6htKqdmUsw+c6+m4AMcE3U+Fgwqr2hSgojXkUvvT4PSgZ4u85/RDXM/NErs
    sRL7Oj4ODl6CWwipo1cRdiP9Nf6DwW74SgXjb/bvNGYoaDXNCg/2MY0mK26CyirvawsicB
    o8o+fg867Cs0gRY5AHiKAZKcTi3ppBJ3k1gjoz5S9SHCCyYkgLMASs8OCKsA
X-ME-Proxy: <xmx:hES6ahMK1Jx9X-Mb5p2fzmesuJrLxz--sSW2gsm_gdkd5KL4t6353A>
    <xmx:hES6aq3XOnUq3-298fgoehOF9u5M3-kqUzUzV3hObsE5_wp6aKnzjw>
    <xmx:hES6atPD4Kt9S94yQgnR-0rljeZAR_zSwg5hzGaScjP-vgcuAa67Ng>
    <xmx:hES6aq38-QxoJxIBfnJLqAyYChaS2O09v1LRXvHc8JvXeWi1MvzzJw>
    <xmx:hES6ak2OMHerZ8I82ZOCZJPnLrFyYQeJ5aeVnp1pZkSOnuL5goQNu-WV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 06:42:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with URLs
Date: Mon, 28 Sep 2026 12:41:26 +0200
Message-ID: <URLs_not_just_msg_ids.d1e@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This document has used msg-ids to reference emails since its
inception.[1] This makes the text a bit more terse, and is perhaps
also convenient for people who can use msg-ids to link to messages
in their inbox. But we should consider how convenient this is for people
in general, now that this is a more public-facing page (see previous
commit). And I suspect that most people will be forced to paste the
msg-id according to the described URL template:

    https://lore.kernel.org/git/$message_id/

Let’s instead replace all of the msg-ids with complete links. That way
everyone can jump right to the discussions.

† 1: 57ec9254 (docs: introduce document to announce breaking changes, 2024-06-14)

Note that we have to URL encode two msg-ids:

     CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com
     CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com

Lore can handle them just fine, but asciidoctor(1) cannot.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/gitbreaking-changes.adoc | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index c6b974b6d8c..9aba419efc9 100644
--- a/Documentation/gitbreaking-changes.adoc
+++ b/Documentation/gitbreaking-changes.adoc
@@ -59,15 +59,14 @@ make the described change that can be easily understood without having to read
 the mailing list discussions. If there are alternatives to the changed feature,
 those alternatives should be pointed out to our users.
 
-All items should be accompanied by references to relevant mailing list threads
-where the deprecation was discussed. These references use message-IDs, which
-can visited via
+All items should be accompanied by links to relevant mailing list threads
+where the deprecation was discussed. These links use this format:
 
   https://lore.kernel.org/git/$message_id/
 
-to see the message and its surrounding discussion. Such a reference is there to
-make it easier for you to find how the project reached consensus on the
-described item back then.
+I.e. they link to the `Message-ID` of the email on the mailing
+list. These references are there to make it easier for you to find how
+the project reached consensus on the described item back then.
 
 This is a living document as the environment surrounding the project changes
 over time. If circumstances change, an earlier decision to deprecate or change
@@ -129,9 +128,9 @@ applications and forges.
 +
 There is no plan to deprecate the "sha1" object format at this point in time.
 +
-Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
-<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
-<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
+Cf. https://lore.kernel.org/git/2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com,
+https://lore.kernel.org/git/20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain,
+https://lore.kernel.org/git/CA%2BEOSBncr%3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE%2BDiUQ@mail.gmail.com/.
 
 * The default storage format for references in newly created repositories will
   be changed from "files" to "reftable". The "reftable" format provides
@@ -268,7 +267,7 @@ system configuration.
 The grafting mechanism has been marked as outdated since e650d0643b (docs: mark
 info/grafts as outdated, 2014-03-05) and will be removed.
 +
-Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+Cf. https://lore.kernel.org/git/20140304174806.GA11561@sigill.intra.peff.net.
 
 * The git-pack-redundant(1) command can be used to remove redundant pack files.
   The subcommand is unusably slow and the reason why nobody reports it as a
@@ -286,9 +285,9 @@ the user passes the `--i-still-use-this` option.
 There have not been any subsequent complaints, so this command will finally be
 removed.
 +
-Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>,
-    <CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com>,
-    <20230323204047.GA9290@coredump.intra.peff.net>,
+Cf. https://lore.kernel.org/git/xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com,
+https://lore.kernel.org/git/CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ%3DKAKhtpDNTvHJFuX1NA%40mail.gmail.com,
+https://lore.kernel.org/git/20230323204047.GA9290@coredump.intra.peff.net,
 
 * Support for storing shorthands for remote URLs in "$GIT_COMMON_DIR/branches/"
   and "$GIT_COMMON_DIR/remotes/" has been long superseded by storing remotes in
@@ -332,7 +331,7 @@ The command will be removed.
 * Support for `core.commentString=auto` has been deprecated and will
   be removed in Git 3.0.
 +
-cf. <xmqqa59i45wc.fsf@gitster.g>
+cf.  https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
 
 * Support for `core.preferSymlinkRefs=true` has been deprecated and will be
   removed in Git 3.0. Writing symbolic refs as symbolic links will be phased
@@ -369,9 +368,9 @@ those features with newer alternatives.
 This decision may get revisited in case we ever figure out that there are
 almost no users of any of the commands anymore.
 +
-Cf. <xmqqttjazwwa.fsf@gitster.g>,
-<xmqqleeubork.fsf@gitster.g>,
-<112b6568912a6de6672bf5592c3a718e@manjaro.org>.
+Cf. https://lore.kernel.org/git/xmqqttjazwwa.fsf@gitster.g,
+https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
+https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
 
 GIT
 ---
-- 
2.55.0.793.gc667de3f2c5

