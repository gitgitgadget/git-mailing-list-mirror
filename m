Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387A3CEBB8
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487708; cv=none; b=IALV7h+NiDCTJftwXZX1oTeJN+NaTLPD8WGApzYSZqUAsHIAVppCluk6zZaY3crUC2ZkudSR7Qi+PPtiLHCy4tjMFg+Tj3q+8o8yQG9gDqljE1xab4Qd2uxyPkAQNxVu50YYncgEiDugBIdCZn2NvINdJ+/YXZVCCY6jsLKbweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487708; c=relaxed/simple;
	bh=+MsEpiYnTeJjg99pj95EXlVhHambuyC2WmzLN3l6guc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2542ND/bpCB6e6oxXar1AaEX4kt0s9rSoZtYsCQR6HJuJECAq1nGOib3nnp4LXc2UDuyhk4bbNWC6nA9ZIx4HnZFpKLIew7EjXQlxhVZx1MotFwhS0mKm9i6RsWkd3diPqrA7LQ7aKF+J/IvRUh8WOxRXcXwQmeRNKD99Ah0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dltty6M8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkOMFme0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dltty6M8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkOMFme0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDD6214001CE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:28:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 15:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487705;
	 x=1791574105; bh=qVgklB2TiJmdwVsE/M9bZ6+jDICSnP+5wE7dEJ6vFAE=; b=
	dltty6M855ZPveKaiCTG75ww5Yb2mexjgkQopx/TmDSA0okL2sx6cUMCq00qtzwj
	vT7cn9vXNQX2YgNKbjqEo7xYqRKH7d0nC+aFrDR5JmJRWJysr8aYeyIwsI3rGAf6
	KswfliBhVkNEmLcxirJ/IvHPUEMr0l+itvOoB5z0jtGCuKHpWc+VNwr/p8B7aMuD
	Hkqqj3eQfnQ8m4q1hrafAP+iBH26XPPvUKKjS94Xpm3ddHlnpAtzvVdrO7BkqKX+
	ux74/adzASqvmu6apFwb2EzWoJN0BRGeWPVnQrChbtBznZOOYrdE1th6TvAnGN55
	B0xcsynmOGMOkrEQYjMKVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487705; x=
	1791574105; bh=qVgklB2TiJmdwVsE/M9bZ6+jDICSnP+5wE7dEJ6vFAE=; b=S
	kOMFme0seCHi2sJjothU8OZXY4ii2xH0A9smi6he5I/uEQu08gmOHrBVaVhsVcJc
	uYxdKelcf6Mb/on9mFV0gEBONIkyxcL77whflWHQcc9x6LU26Xr9tH4Z34OySDU5
	t3vPcadUHtUwTRKg9C8FsXpb4oebhbSwRHVxJEd3y5/6xZRAahZ9BzX/c6CfOpbT
	QPI2KoS6ZbOQyCC5MVh42cjYC1v6UEzhbYES05T/kCBOhEsyTa1hM+TKqFhvebgw
	OlrenLLOCpGiZLRdbVvBX/7srw+Gheh+Push/DOc9lIdRFtHmffZ7lQ7yC57I7LY
	3BUuOmE6B4h6M77uSl5DA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487705; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:G/uGD1E60Oc3IIfCiOZIgRl6yJFENmncT8tTyC/v5kntP7z
	iRqPTQz4+bgaMhjzzG9+Lmpib7zQ0oFdPJz9BDGXDoMR1j4W9PBoB5t78tqiG4kE
	xQgdAichKXgxLlBAADI5K4ac2VD/QGJbzzdMs1L4usnQH11l7o/AVOKl9mrgn7rZ
	Sskwf7QHTKeRwY/dqqFTl/gksf2bRzgTvJBEpBzbdRGgVWRqG57uI9uJM/D/ALfW
	AgZcBL2gINWxAtUuLUC07UxYjkdmS0oIV6QpE52hwLb+jD/4SB+kakT8SJyGbuuE
	AqKQy6G70kaSZ6OMmzORb7zY/24Pc3dx3VidVtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JSRClnu4gYjA50q0utuJmR34qUM50g86j2tDm6Yl8ps=:+MsEpiYnTeJjg99pj95EXlVhHambuyC2WmzLN3l6guc=;
X-ME-Sender: <xms:2e7HauFrWKafMd-RP5Oz-SDnMdlSzKSa-LkZir6C2Tvh3DdAGlN1i60>
    <xme:2e7HamXVLDm2nU59y-u3lWOvLkxRZ0RmtnD24PnoQtt_C2fhkHP_PCTUkRfA1knkG
    L80su0LvJ2dFZIL8ULchsnYYgGhx2Ub_4fyR3EgKQnP7wbq_zgOopE>
X-ME-Received: <xmr:2e7HatKn1VwdUlP89t4_WWvHJGeU8WbapKeC-r1dWtG0OZiF2IfNB9Z2uPqbhEVgxflxY28XfXbk_BMf6CBAeeG-HnQIk6I8fMdQVFCUpuVhXN0RNsHgIZM>
X-ME-Proxy-Cause: dmFkZTGB+uPsGxAVpx8HDgbPj3bD98k5KeivRy+i3QijGldlr8/eCq09jjeSGKFnTZ/EdV
    YZ2ciL0lynUwGtN8xgfPg/PIc4mbTOw9aA+wSXfSaLpPWqKSylAUxpsTiE3YsEkuRA8fAU
    0kX98vEzlb2E3fwTnmTEIT1be2walK2l2xVLRDJldiOm7K6SCns0vJuPpGHpi6EvCheqHg
    KcuPvaZIul9lZOUaXirjBP4Ct+e0k8aTJ9Iqi7lFSJbTN3UiJ6Ckl+hT77X+A776Fo/FR7
    YZr+JBSFzBkK04+ryJqs+pAL5woi4Xs8Y62XfcsNbYwqZMe/FPuK5Xo3pRk/GUfoBfIfOd
    DIy7y6+NjQH0xFESrpS4QZZmF3Yh1BJf/LOqRsoqtHorYO9kUAiwKRWyz6mKMkJVPjyWok
    uFs/gc1qB9VGtzPQlmKHSa5aG+D63wV9wD1N6ULZWM2FjMqqhDSoviDR+msoD5jIWVIca9
    ZLAFGwf2q04hbd14xKoNGcSVrQX0am1ZMNDD9ph1tzduzOHB1v6L/Fq400rzKkLxd7kwZZ
    tHTd7OvD0YUXp2qFfAK60b5DKlukCXyA06FEE4lXZcQ0+qCKnAVcY5jzojcyZh61fY3geP
    6zGmBQUn9VLRrv87y6TJSEAOdbzfq4EeI4MvnbVTYprPOXKwxXyrkPwk/esA
X-ME-Proxy: <xmx:2e7Ham8udyb5e__7nkaNeZonJlKfcpJIUapfGSX0YkcRUbp7AHB7pA>
    <xmx:2e7HagK1CzL9qRT8LwJXYx-xZbYeWQkE0BE4kiZsqdRjkUbv2b9zzQ>
    <xmx:2e7HarkrCry1DJzNJiEAjxGV6V5auajxXyl-8tWJpypFD6YdyAXbPg>
    <xmx:2e7HakPnE3iJIiTVO0vW2BYOesYzJy-MWivKGH8BUXO9QHFu8fECwg>
    <xmx:2e7HajxtDSj8QcDCFrulT31CNleiWL6AkcR6a7-SNXD_eLtb3HzGpkoa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:28:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] doc: gitbreaking-changes: replace msg-ids with URLs
Date: Thu,  8 Oct 2026 21:27:18 +0200
Message-ID: <V2_URLs_not_just_msg_ids.dc7@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
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

Note that we have to URL encode this msg-id:

     CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com

Lore can handle it just fine, but asciidoctor(1) cannot.

Worse yet, this msg-id can be handled by asciidoctor(1) but not by
asciidoc:

     CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com

URL encoding does not help. So compromise by linking to the only
second-level reply:

    CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com

Which properly quotes the first message. So no loss of fidelity in
my opinion.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Fix accidental introduction of two spaces[1]
      🔗 1: https://lore.kernel.org/git/ar0OltAkeTiCx81c@pks.im/#t
    • Fix two other unintended space changes. I don’t know why the URLs
      after [1] are aligned like that. But it makes no difference to the
      output. So leave them alone.
      [1]: Cf. https://lore.kernel.org/git/2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com,
    • Changing the linking scheme so that the links could use the
      msg-ids as text was discussed. But technical difficulties and
      other concerns lead to no changes on this front.[2]
      † 2: <xmqqeceaa5h9.fsf@gitster.g>
    • ... but, and bad news for my linking scheme: I found out that
      asciidoc(1) (shakes fist) cannot seem to manage to render this URL
      as a URL:
    
          https://lore.kernel.org/git/CA%2BEOSBncr%3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE%2BDiUQ@mail.gmail.com/
    
      And, well see the commit message.

 Documentation/gitbreaking-changes.adoc | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index c6b974b6d8c..2bb9f877256 100644
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
+https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com.
 
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
+cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
 
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
+    https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
+    https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
 
 GIT
 ---
-- 
2.55.0.793.gc667de3f2c5

