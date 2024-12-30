Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48B139D19
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735554763; cv=none; b=fzAYByX1l6IkK8bqmoMEVn8DQrwjX6nYy8m62v9XMbgWPG0YhjapbCjPdPtoFCrswMhqqrMjHHtuKU00pQNd97CpHIvOnPlObYU07Bxm+opwJanAWi2K4RCFj+QiAIopWKEWfXEsGecfwWB/hXwflCPGJIhJnN4CoNr491MnbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735554763; c=relaxed/simple;
	bh=46PkaCKZD+hQxubR1ik65os5VI17IByBnijWb0/m3kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGa4oj2UUdwSSf4KK2HrSwM8NQP+pmYfJDofUrjbPQUrBZYH1nbaA3CdxMKe28DjAgXoIDqQIS5L0CDbacb27K/PSZwdBvinBAYWcLmwO3bAKEvTS7VhUZUokRdyhWGQ3agZPXj13se2wrtLC5tolys/0kDUB9CGImSwHXeJvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gx9l62rP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rD/di2sp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gx9l62rP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rD/di2sp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D3561140142;
	Mon, 30 Dec 2024 05:32:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 30 Dec 2024 05:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735554760; x=1735641160; bh=sIZ4gTiae4
	jamCZ+uBHKLfbODRrV3mY1Az/VCFp864k=; b=gx9l62rP+u9jZc95bGT5g9M9E0
	7eRtmQ7sNJYhpFHpoPw42bnGEIJdJevpgp6XdoUjmhBUU6LYILhepK7+a3v4qPHe
	2l1lShF+TWR9gQ09V9ilqZYPboezux9f6iZwsyKzf9erqD6EhyJCwOrhX4SHWxr8
	Eb6PoqOUVVXNyIu5mafkEKdcq/ymH4C6kCsAvxF21nnZ9cIAsU45o46zzK0t2QfA
	8/EFl/LMoTdtFSVMk9pvHb49IHuGCAtZycmySv+77577qXcsK4T+xW8i9JYDEm2E
	PYqfz/kMqbSQI2oq/40UufeJHK4ByvAGnpTaGnIhoudfNUW+2KppVQPxdJcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735554760; x=1735641160; bh=sIZ4gTiae4jamCZ+uBHKLfbODRrV
	3mY1Az/VCFp864k=; b=rD/di2sppth/vlBHy83SjfxNFsfSZeji0j8iOSai0aGD
	5wLwxRHd079PopR8k+kIyaRCfocgIRReXqdFi4hg1FbW2DfNjr7JP+KlgFch6+72
	n8PHh1zUuyL+tqrHLTrfv1Wh57FJHEfEC2+tSy/ykvM74hKAkQeJY+uYU7JWGwPv
	CpMPCWNBnbD6l2sAkXtkdg1GQQuTrz0KvgImo3wcZr7Prlv7Bq47WJrmILfEQL5D
	+EVVnpCmQUGSGLCHOd63DDMBhAtZ5SB25MbNrsHBak1UWn02DUI6eZ/rRWn10zNN
	XXpwpa/IWxERzDm2bAdMA1rXFZnEsnmfdunqo+O41A==
X-ME-Sender: <xms:x3ZyZ3ChLedFLLmlRYPQpjVsCFrZxeUNFW0SCwQsRLV2esVOrjAlDA>
    <xme:x3ZyZ9h4rqiVsXiW2mlJdNKBbb4M15wJe3lJ1Rm42-WXATXZ74R8cHVXdYZ8Cg0yy
    Ito0XkNWWfUx1LNxg>
X-ME-Received: <xmr:x3ZyZyncW0EIwovRCWcf8W_Ld91gNrDoqclT9nQEBG60bfSJ5wgVpBwtfG_fVtXNZWi-gtvF-7XpBvI06aBeqrwi130FxSDlmgJp0mQ_pwNv5ecx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffdtudfhtdekgf
    dujeehtdegheefheevteeffeefgfdvgfdvffeuuefgveefueeunecuffhomhgrihhnpehi
    nhgtrhgvmhgvnhhtrghlqdhrvghprggtkhdrrghuthhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:x3ZyZ5z_mCSfvZG9WMya4x7v75xBnCsOav5TTRiM-NXZ4KnAwp6l_w>
    <xmx:x3ZyZ8TB3jIjZ5TIc_5smPcKkZ2RxwKaa9UenqWsCOb6ZxEiL-lHGw>
    <xmx:x3ZyZ8Y0heRSlByud4X0GbbYeSMk8EseZwmKjucZjrT3vTylcezkIw>
    <xmx:x3ZyZ9TtRsc3LP-Fut2q88agDBJWeLb8YhZlm0kZx3i1LLa4DWd3jw>
    <xmx:yHZyZyPjcB6uDNM9b5AR6Hkgu1zU9wliR2Ukq4sg-reFTYbPceGlz4WT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 05:32:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f92b281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 10:32:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 11:32:23 +0100
Subject: [PATCH] object-file: fix race in object collision check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
X-B4-Tracking: v=1; b=H4sIALZ2cmcC/x2NQQqDMBAAvyJ7dsGNVkK/UjzEda1bg5FERBH/3
 uBxDjNzQZKokuBdXBBl16RhyUBlATy55SuoQ2YwlWnI1BX2Da5zwtD/hDcc1QtGxydy8P6xkSf
 hGVvj7EAva4layLU1yqjHc/p09/0H2yGu63kAAAA=
X-Change-ID: 20241230-b4-pks-object-file-racy-collision-check-62a8d1588116
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

One of the tests in t5616 asserts that git-fetch(1) with `--refetch`
triggers repository maintenance with the correct set of arguments. This
test is flaky and causes us to fail sometimes:

    ++ git -c protocol.version=0 -c gc.autoPackLimit=0 -c maintenance.incremental-repack.auto=1234 -C pc1 fetch --refetch origin
    error: unable to open .git/objects/pack/pack-029d08823bd8a8eab510ad6ac75c823cfd3ed31e.pack: No such file or directory
    fatal: unable to rename temporary file to '.git/objects/pack/pack-029d08823bd8a8eab510ad6ac75c823cfd3ed31e.pack'
    fatal: could not finish pack-objects to repack local links
    fatal: index-pack failed
    error: last command exited with $?=128

The error message is quite confusing as it talks about trying to rename
a temporary packfile. A first hunch would thus be that this packfile
gets written by git-fetch(1), but removed by git-maintenance(1) while it
hasn't yet been finalized, which shouldn't ever happen. And indeed, when
looking closer one notices that the file that is supposedly of temporary
nature does not have the typical `tmp_pack_` prefix.

As it turns out, the "unable to rename temporary file" fatal error is a
red herring and the real error is "unable to open". That error is raised
by `check_collision()`, which is called by `finalize_object_file()` when
moving the new packfile into place. Because t5616 re-fetches objects, we
end up with the exact same pack as we already have in the repository. So
when the concurrent git-maintenance(1) process rewrites the preexisting
pack and unlinks it exactly at the point in time where git-fetch(1)
wants to check the old and new packfiles for equality we will see ENOENT
and thus `check_collision()` returns an error, which gets bubbled up by
`finalize_object_file()` and is then handled by `rename_tmp_packfile()`.
That function does not know about the exact root cause of the error and
instead just claims that the rename has failed.

This race is thus caused by b1b8dfde69 (finalize_object_file():
implement collision check, 2024-09-26), where we have newly introduced
the collision check.

By definition, two files cannot collide with each other when one of them
has been removed. We can thus trivially fix the issue by ignoring ENOENT
when opening either of the files we're about to check for collision.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch is the follow-up for [1], where I've mentioned a couple of CI
flakes that happen rather regularly. As it turns out, this race was a
real bug hiding in the newly nitroduced object collision check in case
one of the files got unlinked while performing the check.

Thanks!

Patrick

[1]: <Z2-2dbYVuuLxpNmK@pks.im>
---
 object-file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5b792b3dd42cecde43a1b18abc164fd368cbcd69..f84dcd2f2a7b88716ab47bc00ee7a605a82e8d21 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1978,13 +1978,15 @@ static int check_collision(const char *filename_a, const char *filename_b)
 
 	fd_a = open(filename_a, O_RDONLY);
 	if (fd_a < 0) {
-		ret = error_errno(_("unable to open %s"), filename_a);
+		if (errno != ENOENT)
+			ret = error_errno(_("unable to open %s"), filename_a);
 		goto out;
 	}
 
 	fd_b = open(filename_b, O_RDONLY);
 	if (fd_b < 0) {
-		ret = error_errno(_("unable to open %s"), filename_b);
+		if (errno != ENOENT)
+			ret = error_errno(_("unable to open %s"), filename_b);
 		goto out;
 	}
 

---
base-commit: 306ab352f4e98f6809ce52fc4e5d63fb947d0635
change-id: 20241230-b4-pks-object-file-racy-collision-check-62a8d1588116

