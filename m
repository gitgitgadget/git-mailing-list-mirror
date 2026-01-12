Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794D30EF6C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208466; cv=none; b=Y79HQ/XFo2ZJtwUyga0fQ55V3evZVQQUfQGkdTCsW4Z6rRNE7IiP+o+iaNPwRO1NlAUBJ/xI0RY/+wTtprtBq9XR1UE50UODgeC9TU7UgGTPPRnEZJQWcHFumvICRXikLbAOrkxztz1HYXxTYvSeYlOt3bQddSgBuxQRBb5KC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208466; c=relaxed/simple;
	bh=b261yiBbYbG2wT4EctjVI0W0a9eaUuamFtKNsDV00H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oI7aExTFqvuaO1lDROJebckvhe4gnD+KzOaGYQc2xEt8qSE8g3zwhexyiwhoIYC9K9FJPPTFnXsGpbL1KuGapsvMcpjH675KBoJos+9Gg0F3pdJ+fGjjvzB6m+O4JDLdk1Q4AoDyPbd4yDKgfODm8jCzTQpPQgAzHt95gsEK6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+t4E3GW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zgY0gKhd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+t4E3GW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zgY0gKhd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C7F6D1D000CA;
	Mon, 12 Jan 2026 04:01:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 04:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208461;
	 x=1768294861; bh=BlzBCaQE26S3DuqYoM3QXbmwTfm3Gngq8a8FHWhX86M=; b=
	B+t4E3GWZprsmeaC8TAe3idWRxXkBa2Tqa0fgUi6X7hc1BOoS6TApbqzSH0K2qPa
	h5vDg05y9R90kwown8CyNS3sDcXsrGc+yNSSY0MJledFq5ARNSNxNAPIDQDg2tJB
	SakLnbVo+OBQizNUFfqRVKxHeVuiG88B8DH+XzJ+RwQT66UljthN2LiCSgi2kQ7k
	i6mZQLfOGumihsLHcYEGgvCuN6f4gLNPW7i0shrAByVEk049y/B2uQErlNSVfvkB
	t96H5CRf3oZlTaY9aTiJ8XllayRk1S39KmrBt8pIh8FZBND3KkY8WJ3IVoUxGkqY
	5ITofCufyFU84LUYAQpYJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208461; x=
	1768294861; bh=BlzBCaQE26S3DuqYoM3QXbmwTfm3Gngq8a8FHWhX86M=; b=z
	gY0gKhdG7NFNSgxBDTOyzoXDmV24Rn/7zeluZ58VsGfY8W+/sn403JmIBnTwo+4q
	6Gzjfgy9XJlMU5Z+GcYpuyv3ax+dX3I85/XbhzesUSKbU7pdzD2TCmVfkKbzKLa5
	XE7Rid+OFWk2M8/oo9pT/OHAwa8ZS7V8SabpObibg8j1OUg84NWja68XaxBOgz3i
	e5ahSc5RenXvtepENL8MlgSFT6nI0mTiV3OL7yQpjIsyertFH6MMsmtEFrbYnxbt
	2WRJ62zSFd5l6YoUKJ4ESjCmskdEwBrjUwwFi0rI2ZC2K6dELwF83M4g+QoiUWIS
	wFx9C6U6jfqSPFQQ+b3pg==
X-ME-Sender: <xms:TbhkafMtaOF7q5sBylYA7hGU9PBSe5Gj44USmh2CspvV9PKmCz-IOw>
    <xme:TbhkacPmdadv1ZPpTnl9SKYNURrdm2kWwFrXSNm8IwTFA1dMzxyTStcfk8AsV1g-_
    FBKu7lzH0O3s2eu998ezpiOGay4MsVLrYmPDFpnFTHgUW_pI5HN3A>
X-ME-Received: <xmr:TbhkaQhPjvvBeOTx6DJfEr_b8-MofuNpoyTnHRAqrE-MM0e1rOj3kMZUIhV9ioTqyQlaVF_dG6JvRMDA8WCLIZfJRlNWdiTNw4E0OSBZaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsg
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:TbhkaZtEqFDU-r_lpV7uaAvbTPrCJgmh1alwaKSF1JDRmtApkZXqhw>
    <xmx:TbhkaWRM4XVZ0T5bLGahX7JSLiLd0UY_ir7lytmSHlZ4wW_3cojmgw>
    <xmx:TbhkaV2-DBKdSm2WO1ZLN05y-aux-mcvS-WMdQxVGHPKBUu2ZpyP_Q>
    <xmx:TbhkaTv3CrrZXPbo8tszosWt_uPVp9ePt8BkWOpRbiAMWuN92QwF-g>
    <xmx:TbhkaSTr4UpIgSIxauQLvo3_En0ZFilaHyfw6v6Cx0Ncvv5rGteqESy7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d91145e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:42 +0100
Subject: [PATCH v5 2/7] packfile: always declare object info to be
 OI_PACKED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-2-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

When reading object info via a packfile we yield one of two types:

  - The object can either be OI_PACKED, which is what a caller would
    typically expect.

  - Or it can be OI_DBCACHED if it is stored in the delta base cache.

The latter really is an implementation detail though, and callers
typically don't care at all about the difference. Furthermore, the
information whether or not it is part of the delta base cache can
already be derived via the `is_delta` field, so the fact that we discern
between OI_PACKED and OI_DBCACHED only further complicates the
interface.

There aren't all that many callers that care about the `whence` field in
the first place. In fact, there's only three:

  - `packfile_store_read_object_info()` checks for `whence == OI_PACKED`
    and then populates the packfile information of the object info
    structure. We now start to do this also for deltified objects, which
    gives its callers strictly more information.

  - `repack_local_links()` wants to determine whether the object is part
    of a promisor pack and checks for `whence == OI_PACKED`. If so, it
    verifies that the packfile is a promisor pack. It's arguably wrong
    to declare that an object is not part of a promisor pack only
    because it is stored in the delta base cache.

  - `is_not_in_promisor_pack_obj()` does the same, but checks that a
    specific object is _not_ part of a promisor pack. The same reasoning
    as above applies.

Drop the OI_DBCACHED enum completely. None of the callers seem to care
about the distinction.

Note that this also fixes a segfault introduced in 8c1b84bc97
(streaming: move logic to read packed objects streams into backend,
2025-11-23), which refactors how we stream packed objects. The intent is
to only read packed objects in case they are stored non-deltified as
we'd otherwise have to deflate them first. But the check for whether or
not the object is stored as a delta was unconditionally done via
`oi.u.packed.is_delta`, which is only valid in case `oi.whence` is
`OI_PACKED`. But under some circumstances we got `OI_DBCACHED` here,
which means that none of the `oi.u.packed` fields were initialized at
all. Consequently, we assumed the object was not stored as a delta, and
then try to read the object from `oi.u.packed.pack`, which is a `NULL`
pointer and thus causes a segfault.

Add a test case for this issue so that this cannot regress in the
future anymore.

Reported-by: Matt Smiley <msmiley@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h                  |  1 -
 packfile.c             |  3 +--
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/odb.h b/odb.h
index 014cd9585a..73b0b87ad5 100644
--- a/odb.h
+++ b/odb.h
@@ -330,7 +330,6 @@ struct object_info {
 		OI_CACHED,
 		OI_LOOSE,
 		OI_PACKED,
-		OI_DBCACHED
 	} whence;
 	union {
 		/*
diff --git a/packfile.c b/packfile.c
index 08a0863fc3..b0c6665c87 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1656,8 +1656,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
-	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-							  OI_PACKED;
+	oi->whence = OI_PACKED;
 
 out:
 	unuse_pack(&w_curs);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 961c6aac25..c8c1c5c06b 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -239,6 +239,40 @@ check_zip with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
+test_expect_success 'git-archive --format=zip with bigFile delta chains' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test-tool genrandom foo 100000 >base &&
+		{
+			cat base &&
+			echo "trailing data"
+		} >delta-1 &&
+		{
+			cat delta-1 &&
+			echo "trailing data"
+		} >delta-2 &&
+		git add . &&
+		git commit -m "blobs" &&
+		git repack -Ad &&
+		git verify-pack -v .git/objects/pack/pack-*.idx >stats &&
+		test_grep "chain length = 1: 1 object" stats &&
+		test_grep "chain length = 2: 1 object" stats &&
+
+		git -c core.bigFileThreshold=1k archive --format=zip HEAD >archive.zip &&
+		if test_have_prereq UNZIP
+		then
+			mkdir unpack &&
+			cd unpack &&
+			"$GIT_UNZIP" ../archive.zip &&
+			test_cmp base ../base &&
+			test_cmp delta-1 ../delta-1 &&
+			test_cmp delta-2 ../delta-2
+		fi
+	)
+'
+
 # Test remote archive over HTTP protocol.
 #
 # Note: this should be the last part of this test suite, because

-- 
2.52.0.590.g1f87b77810.dirty

