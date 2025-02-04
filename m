Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D74CB5B
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652456; cv=none; b=r5knJXwMk0KnyxXrg6yFG5BjOefWzN6tBghUYpnpr3m/b81gDJkFFqSZ8v3v4eoCsPurx+M5+1aZEpH8f0Z8mdEZ9lFGYqj1cJGj9Z8PeVcxSgbhiR2W/cS3eU/8eeHDBv/llceJMCDb79zSiqC8dIhssKxWP8UBe0mhJZD75Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652456; c=relaxed/simple;
	bh=+XL2E+JZsNaImZEavT3UU1/44voM/m0HeGWFAEoutu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=uJJBqBpr7aNAXB1eJu7mURHA1gZTyRzmuS4dIMTSItcL5dgumcBSj5eEW1cR+4vq8FCHEYOMnQaRxYHnFLowt7A+3XvdltJy0kfl5ATMDSklCIf9HOktVqZ9RxOlmJ+CZIoCod7nfJ7Ov6ESYJFtFE7lQpTggleCgHU2IipcJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H5C7lvnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XZs843RC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H5C7lvnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZs843RC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E1B081380279;
	Tue,  4 Feb 2025 02:00:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 04 Feb 2025 02:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738652451;
	 x=1738738851; bh=OF1sHHKADvkzADiFYFxeXm5U9C9UDiSEHJFvyeXBfes=; b=
	H5C7lvnYXS51fdPN6/AgUZbhkNw+gFZtrKqOouVRnDyHTarluaOw6FF6vg4ViY3b
	ikTGflp0ErgFDFoToDP0A6DoWGWTxNX7ifoztLxSt8KPpNtcjhmCY8WSlak6Gd8D
	rJz4C0V61gXf4bw2NM8hJX2qw76w3dCsSK6+8DaFxaGk38Z0yVUUnkk9fRZ/vqZZ
	4kN/T+iVZ51dfN2k0axrRPgbxyGbPRjHgRnhXJA0fmsweJ9xI6UX4h9mLkmR/wL6
	Ayf+C+6Qren9PPu9A0+l17jQmPOQaacQZCKipo2Rnstwx+u8tTUnOKSQx4i1+0EB
	wyyxrOfie6NWf6sXyiT6YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738652451; x=
	1738738851; bh=OF1sHHKADvkzADiFYFxeXm5U9C9UDiSEHJFvyeXBfes=; b=X
	Zs843RC+pGvMyuXOo3Jo+MwFGyMWqqmlXWItqk/+Po//iCEeQVWX7PA9zK4MZaWo
	kTauNtfZ+dbSIrSqFzhUZRHTx9Q5f2jxK1yoelHm/T0h8ybj54KVAhjKUyEe0Q/l
	2756bGbEKrtIGDIu/sjWlkAzQ98oVL6kM5iExl6amMe+2AQoJK83TSQrIAh07zKG
	WsvE1LH+0asA/7lOODLpGxA/kJ3HMqW2h6axZfqvzNh9Ct1AcHTQfn2B02QfcOIJ
	He36vd+HcvJUNKbIKwohPsgeE9qL3DDClCsTJYCBp1vM2appjQfrv+//o0Zh/1Dv
	uRCZRM7sVDmyvCNBwoPRw==
X-ME-Sender: <xms:I7uhZ8je7DocT7mhTOt8yHJ-hXIflFHS2FHFtGyHnm11Asiq2VEtUQ>
    <xme:I7uhZ1CnWP9xxHoJryX2KX9av_lhSjPHoAZ4rzK3z1685vVRSd_hIzKqRRm5B47ki
    OcWBXcIoOcqP_SnNw>
X-ME-Received: <xmr:I7uhZ0F1MfRdtCsDQ8CaAaPnDs29PaAXTJQo1iYzimJXtbd3PW7pOl6mtK4Dr_Zikq9-shRu7MKLPRyXozXVRchll6LXu7yK941hch9tTx4GrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuddvvd
    efgeduhfetgeeuffejlefhkeehfeekteeuteelhedutdeifeektedtieenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:I7uhZ9S-NiOvP_iD-KQa_5kbMfIxm1fpGYXNl8Kd3fuyJyJsXyOYGA>
    <xmx:I7uhZ5x8dS2DV3RRaIAoRzc6BvKivxUtqPMlQ-FOfFbJIdQap0TgPg>
    <xmx:I7uhZ77SsJFlJR8mlyvOXY9CR-g7VARO117Fe35f1rL8DPmziwngrw>
    <xmx:I7uhZ2wAZmN8mnK7FbVc_kZ-lBPncxDKYllbeI27CgWjmpQIF9kOCA>
    <xmx:I7uhZx-SzfevZCovri8hck6lMI3C30FR2ffQbJjS5rgtp6Qr7QxkVjb9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 02:00:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ae7c765 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 07:00:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Feb 2025 08:00:41 +0100
Subject: [PATCH v2] builtin/repack: fix `--keep-unreachable` when there are
 no packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-b4-pks-repack-unreachable-objects-wo-packfiles-v2-1-1eae23366711@pks.im>
X-B4-Tracking: v=1; b=H4sIABm7oWcC/52NQQ6CMBBFr0K6dkxpoURX3sOwgGGQEaSkg6gh3
 N3iEVy+P//PW5VQYBJ1TlYVaGFhP0Ywh0RhV403Am4iK6NNro22UGcw9QKBpgp7eI6BqlisBwJ
 f3wlngZeH/dbyQALWonHaOcrRqvh0CtTy+ye8lpE7ltmHz8+/pHv6t2pJQUOBWeNOmOvC4CWuj
 /xQ5bZtX0nJ4NTpAAAA
X-Change-ID: 20250203-b4-pks-repack-unreachable-objects-wo-packfiles-33c26066e5c3
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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
Hi,

this small patch series fixes `git repack -ad --keep-unreachable` when
there aren't any preexisting packfiles.

Changes in v2:
  - Merge tests into t7701.
  - Link to v1: https://lore.kernel.org/r/20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im

Thanks!

Patrick
---
 builtin/repack.c                     |  5 ++++-
 t/t7701-repack-unpack-unreachable.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

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
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 5715f4d69a..5559d4ccb4 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -195,4 +195,20 @@ test_expect_success 'repack -k packs unreachable loose objects' '
 	git cat-file -p $sha1
 '
 
+test_expect_success 'repack -k packs unreachable loose objects without existing packfiles' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		oid=$(echo would-be-deleted-loose | git hash-object -w --stdin) &&
+		objpath=.git/objects/$(echo $sha1 | sed "s,..,&/,") &&
+		test_path_is_file $objpath &&
+
+		git repack -ad --keep-unreachable &&
+		test_path_is_missing $objpath &&
+		git cat-file -p $oid
+	)
+'
+
 test_done

---
base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20250203-b4-pks-repack-unreachable-objects-wo-packfiles-33c26066e5c3

