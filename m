Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD219204C07
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588034; cv=none; b=gnsodJzJDQGfpNys8MSpAHdjov3PhTfK02RTtQWOkqVlasJAc5ZiWkaV/VJHjknPBJqD74lWdYlUoDhzKJY6HV/duQ0qmYygQDkPYtiLdvnaHOob7/PLMQI7Zpm+Q830Ds3LedifGSFqNqoe2YpGmj0oAWFa0tsRXEbRQuKWv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588034; c=relaxed/simple;
	bh=uR7FGAtEwTz49fQoxbYFlm2Qjl23OQqXlTrCRm/dAaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxODvlUUiz/7a97n587B6xJpDRdAiy7L35F9cA8RcgL5MtP1RaqtdKOPB4v3a3B1IvF1Siwcm+2LsmNCgqInFk1YRAHfSuKr6X87UAxQ8sm/4Rctr3mqfDcHs/wZyY7gK1nwe+eMzjScVRkjgXV6o1+z/gWWZAsRA3gkfIWMEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOkBo3oh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yyAlM7cj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOkBo3oh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yyAlM7cj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8253813801C1
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:07:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 08:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738588031;
	 x=1738674431; bh=Qay3CTVtt4yzCtLxpXVy0VO/lhwIfqt46Z9VyXrrXkw=; b=
	WOkBo3ohycge2265m4TcuF1YmuvalzhPVnkBW+u1aU0k2lp3KDtnAdRfJV5hzMHX
	4doqmn6wBUsPc5l/moii0d1K7KX7MfabJc51eoH31J/Qzk7TkipawW2U3QmZl5b5
	zx5Aeu7VqQebgOZIlAL/dYnNF4IF/2bONhM1THMcgVX6fQrYnHLzJv+4f42FWTeS
	kQjmGpuBCFJeUVjHwpAoSyrT+su7Mz8CNtxR+0u8y9g7Vy3BUNpQ2Ehj6wmo9a+U
	na2ZZBD5ihCyBM85O7Qt9QFHO0AtAG8Tv8CbAe8RV2vP5RIZMWqdLHGS4h1ZrTC4
	3qBDuxRwJZHOgXd3x2kCow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738588031; x=
	1738674431; bh=Qay3CTVtt4yzCtLxpXVy0VO/lhwIfqt46Z9VyXrrXkw=; b=y
	yAlM7cjhD7ADcomS31rW211BBYHPjhyLy11H1a7+dKokGgz+/ImUWjRHWsB0FaAS
	MdOaJ/lnMsXZrvc3ZXPZnO4qy9/dEPpOj4BfSDJwtFuGHxc4K4QFFSClHfgQAP5J
	/rJMLdzRyX2u5TQQn1yh4JVktHZcFcebOmqdwxzQQuy659g3Ww0Xo1bgUoJYPr/o
	HupAiEBPCgQwCGqcvG/j7kHMo1MWG0ZdHHWHzozOOBHWPx4D9st8GwQbQAhA/m8n
	JIcgLs+EYxkE9Q4CNqNe6C/w/q4s2W3VNIxBSC2VzVtWbz2zW0XryIinAtRkuQG+
	EvEpDDSx5x4HtIbET8wiA==
X-ME-Sender: <xms:f7-gZ8vxkqk9QhdNSWtjXfSYZwDvi9iOH8hoylxf2BlBRnvi9Sxaag>
    <xme:f7-gZ5dx53EyUOwM82YwLRQlC-B8zpsHX9AGoYz64RBOSlZuIUQ3xnp3OBcG-RBRy
    SXlZn72UF5MuVvJtw>
X-ME-Received: <xmr:f7-gZ3xfLRBH89oWpPfN3PqfNlRhcrZtsO_k3pVN2_C5nsQMPod1vGAI9A7TCJeFyR4PEbk2Iv73g9aDFt0IWRV2eQnqzD1s793qUQ1TGCZmdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f7-gZ_N7Tno8E20J8ZFlAn3R07NlVTBaf8N7r2rxbdAEdbqsUc5JFg>
    <xmx:f7-gZ8_cDtECnXcWXJQh2pIVdPoMHErNvcLidn8ieKZJOlx4MZjtqA>
    <xmx:f7-gZ3WacO8AZW4a0HvyozBtOFe95T2KI_6Khnk_bwfVGQd-CDMs5w>
    <xmx:f7-gZ1dzMGq3ZMxkZOKeuzWE7LjUOmT_RNkGsRFhWwYFSYWA2f_4Bw>
    <xmx:f7-gZ6nyj3UStdguZ2AHinxr4YOuWLkRpzqDDqNIuWqHHNcQN7UQx9Ip>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Feb 2025 08:07:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4645e954 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Feb 2025 13:07:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 14:06:55 +0100
Subject: [PATCH 2/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "--keep-unreachable" flag is supposed to append any unreachable
objects to the newly written pack. This flag is explicitly documented as
appending both packed and loose unreachable objects to the new packfile.
And while this works alright when repacking with preexisting packfiles,
it stops working when the repository does not have any packfiles at all.

The root cause are the conditions used to decide whether or not we want
to append "--pack-loose-unreachable" to git-pack-objects(1). There are
a couple of conditions here:

  - `has_existing_non_kept_packs()` checks whether there are existing
    packfiles. This condition makes sense to guard "--keep-pack=",
    "--unpack-unreachable" and "--keep-unreachable", because all of
    these flags only make sense in combination with existing packfiles.
    But it does not make sense to disable `--pack-loose-unreachable`
    when there aren't any preexisting packfiles, as loose objects can be
    packed into the new packfile regardless of that.

  - `delete_redundant` checks whether we want to delete any objects or
    packs that are about to become redundant. The documentation of
    `--keep-unreachable` explicitly says that `git repack -ad` needs to
    be executed for the flag to have an effect.

    It is not immediately obvious why such redundant objects need to be
    deleted in order for "--pack-unreachable-objects" to be effective.
    But as things are working as documented this is nothing we'll change
    for now.

  - `pack_everything & PACK_CRUFT` checks that we're not creating a
    cruft pack. This condition makes sense in the context of
    "--pack-loose-unreachable", as unreachable objects would end up in
    the cruft pack anyway.

So while the second and third condition are sensible, it does not make
any sense to condition `--pack-loose-unreachable` on the existence of
packfiles.

Fix the bug by splitting out the "--pack-loose-unreachable" and only
making it depend on the second and third condition. Like this, loose
unreachable objects will be packed regardless of any preexisting
packfiles.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c  | 5 ++++-
 t/t7700-repack.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 81d13630ea..8194344b04 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1370,9 +1370,12 @@ int cmd_repack(int argc,
 					    "--unpack-unreachable");
 			} else if (keep_unreachable) {
 				strvec_push(&cmd.args, "--keep-unreachable");
-				strvec_push(&cmd.args, "--pack-loose-unreachable");
 			}
 		}
+
+		if (keep_unreachable && delete_redundant &&
+		    !(pack_everything & PACK_CRUFT))
+			strvec_push(&cmd.args, "--pack-loose-unreachable");
 	} else if (geometry.split_factor) {
 		strvec_push(&cmd.args, "--stdin-packs");
 		strvec_push(&cmd.args, "--unpacked");
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b26566473f..57523db696 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -880,7 +880,7 @@ test_expect_success '--keep-unreachable packs unreachable loose object with exis
 	)
 '
 
-test_expect_failure '--keep-unreachable packs unreachable loose object without existing packs' '
+test_expect_success '--keep-unreachable packs unreachable loose object without existing packs' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(

-- 
2.48.1.502.g6dc24dfdaf.dirty

