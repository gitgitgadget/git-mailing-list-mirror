Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C313C684
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618328; cv=none; b=iRdzTZjozeEy2nTZkLF4Gw9IEPhLNEQ4todC4BoC6IYUVBmcWGILaUFVcQtnShEpW/vi5goiitQYtBMWn/Hc29A9WimsPrB9OXONHsCM1Qxz75TYuR1b3PKcNUcmFpTQTxa6GVW/xyGf++/j+9QNs3mHw+xZTM60DNCqTMm6vGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618328; c=relaxed/simple;
	bh=JUm3lsJilsFV1O2dMe3PbxtbybHfB4GcBuGmCDuimkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0YtQ8bnyopckCLFnwQYNEkZd39oJwcciEEIBgIizHmdhbS5ow4L6tDE+USCTS1lN42olHGxZfe77uftMly8mepmHXuakR3Z22LDVyB19omJbhxc7BYyTsSLss8y5NsJLXho7OGNvp65zMQcXFiHBhLysTAjnoW/y+JOhc5fUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O4Td8bfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3iauNp4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O4Td8bfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3iauNp4"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 474591388210;
	Wed, 14 Aug 2024 02:52:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 02:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618326; x=1723704726; bh=iKG4mzjCkG
	I7jcaSdTJ/I0imjWoGH0ua/2Y5iqWAZio=; b=O4Td8bfFhp96rHNj8UUadjoTir
	UJnOxaiAZxde37cix1fpzrXwtqB32uF+PDWBFsFXSSEuWW56dR0lVF4HSi0G9Mf8
	mRfChb4JQyeyXqDS1XmpHn4bgBmzPpEU506ABuiSVHuEdxX4inxkMSLsa1+4v0XB
	4tAFbwNrai7n/uPaFZHFKXo3jIHRfC7J4G9OhkJYLoGWm8yNdN23EaTA6xQREAsR
	1UPY7I+lRBqAjw74iqyhT/4JVIOa5wDIz3zG3RrtTO+it+tmAva3EirG4EX8nW9t
	u9rZGN2Zd0MOh4zc7uE285R/5suG+839oPgi+vPuyHwP4pZxaMZaM/BPPZ6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618326; x=1723704726; bh=iKG4mzjCkGI7jcaSdTJ/I0imjWoG
	H0ua/2Y5iqWAZio=; b=m3iauNp4xeM1PNNGs51pdz+c03oZY7vAU2pIFO1rPHjx
	wJ/Xjqr6qCAyjfBR1RLTJCe7ddzDHpQjzdNyFXiuUVAEZ52RiUU3ac/S3qJkQOmr
	bgeOA8yYI6FxW6vWP8j8IAlqBiCAYYx9FuEFBDf0G+EkESWd4PtqmteBWdjPXTBT
	xrQt2B8YOp6R3ctKu9HL7GJy3Ax9weBPHeDFlM+wkka6Bve+7ChrqGdM1Vawz4sH
	ZFcK/1G38YWp5BRWRhsRk0op5A62Z4aM08QyXOg0TGZaM4KQ8GyyG/DYNWAX8THu
	H3YNRfvDGHxL1Nn4NR1V8dNWUML1EkkI9FNONYbbIA==
X-ME-Sender: <xms:FlS8ZoXj5VRTWp_wHuZReb5pc5RF4PPGlyipp26XvkPf4CryrypAhA>
    <xme:FlS8Zsl53QyLi3XdtT0Y9DFjLojUGpeSnYCtS4fRVwZYrrcVgew-OLZCXSb8WRJFI
    Rt7Ez5bOSs_4Km7CA>
X-ME-Received: <xmr:FlS8ZsbIYwCDmzAZUQeZcxvKBFBbJCxUzJq256bV59AEWCl9pJkfPjAWK7RXqXNFfLKEwQCgrWKz1vxVGgXJqPa49iGC6gaIogM2Nd5DH_zFeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:FlS8ZnXMSeBEaKucyvcYfRxoPi0ASzuAXsH6qfk2iv7ntzLEwCFLZA>
    <xmx:FlS8ZinwPPtsCpNCusyDsWm2wZ3kEGXWIYCnZJVmYpqlQ7BDG8ds7Q>
    <xmx:FlS8ZsezaS1L0J_uODQ-OkaJpR4s1u6AtpWKCS0Bp-Hhcmx-aqC--Q>
    <xmx:FlS8ZkHnlw3cQVjYmDbt4jDpgX6_1IXyGlC-Y7k9vDZcUXjiWTnN7w>
    <xmx:FlS8ZgY01_2OKJLUtXvTidfsMFrOmoWzGYM_hJOzlIZ4-6ltzzRSpLkO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25cef260 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:46 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 05/22] bulk-checkin: fix leaking state TODO
Message-ID: <276c828ad18c422c7cca0503e336c8aee8aeb149.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When flushing a bulk-checking to disk we also reset the `struct
bulk_checkin_packfile` state. But while we free some of its members,
others aren't being free'd, leading to memory leaks:

  - The temporary packfile name is not getting freed.

  - The `struct hashfile` only gets freed in case we end up calling
    `finalize_hashfile()`. There are code paths though where that is not
    the case, namely when nothing has been written. For this, we need to
    make `free_hashfile()` public.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c   |  2 ++
 csum-file.c      |  2 +-
 csum-file.h      | 10 ++++++++++
 t/t1050-large.sh |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index da8673199b..9089c214fa 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -61,6 +61,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	if (state->nr_written == 0) {
 		close(state->f->fd);
+		free_hashfile(state->f);
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
@@ -83,6 +84,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 		free(state->written[i]);
 
 clear_exit:
+	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
diff --git a/csum-file.c b/csum-file.c
index 8abbf01325..7e0ece1305 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -56,7 +56,7 @@ void hashflush(struct hashfile *f)
 	}
 }
 
-static void free_hashfile(struct hashfile *f)
+void free_hashfile(struct hashfile *f)
 {
 	free(f->buffer);
 	free(f->check_buffer);
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd2..ca553eba17 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -46,6 +46,16 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
+
+/*
+ * Free the hashfile without flushing its contents to disk. This only
+ * needs to be called when not calling `finalize_hashfile()`.
+ */
+void free_hashfile(struct hashfile *f);
+
+/*
+ * Finalize the hashfile by flushing data to disk and free'ing it.
+ */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b024..ed638f6644 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,6 +3,7 @@
 
 test_description='adding and checking out large blobs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'core.bigFileThreshold must be non-negative' '
-- 
2.46.0.46.g406f326d27.dirty

