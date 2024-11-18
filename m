Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21F1BD9DA
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944048; cv=none; b=HqGfJR9jLVit0p7LJ3s6GtzSnqhmq0nYFhn9EwvsiQeNgLoA6E9J0OOQyxK9EzrwsW27O59aTbH1Ay0Cx9sWwua6h3NbhgRYHsPpCGJGhoqsh3UYLjVR4XDKFvSWwBJh3JhESE+MH3Hxxbhdx1Fp2htQud1PeRQhGnA6nxPCJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944048; c=relaxed/simple;
	bh=5x52Db0w6J+4reS7/8GyZdAdJN85wnSLrjH2wmTPfhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNjO9EqKN8gpVorj0cSSFnbshl536LG+3LbPO8e1pIZu5Eyn4azfm38DJZI4nUGcd+TZ8FbyOBQLCMj4LHde9FSemwyN1TfISs9VRrtA1hGOJG7XI2sAyYkGzxkCDFup0iCKaaLmcYS7JFuGuuUm/qhh5YM0vWV98bRJI8D2AVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFMd4OVX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHRc05H0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFMd4OVX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHRc05H0"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5356114022B;
	Mon, 18 Nov 2024 10:34:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 18 Nov 2024 10:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944045; x=1732030445; bh=uebA21VKiI
	IkAu9Mnh0HKVKcxQKIuZiLf+ZvJ+rN4zA=; b=NFMd4OVX+SVn11Ivu9Ya4JlbES
	NjQa3Wi/Tc2B+9tVur3hLTjS1kBdEWGX0cA8VacjYtwuqzvbCVPe1cgVCzBbAVFp
	5glh6x/6JdFsVBFOXUiWhJ43WJJCY60+Yqt4Xr93+xeSN8ta1ipfc/XC55u4Ez8y
	1NHzgeIOdw4fcy7x7PjLdKl2G8AgjKFF3SMUvoxBvQHR1pvhINvUILJBSavcAMET
	yIFRRCyU1RK/l/oVn7Tp98fIaXIcQYCLEd/qJDoJUWv21hohuuFC5WfxbOAasMti
	M/trQTMND/pD6uG6HwH+DrJBiP+L0pwBcmno9Q5g53G7FFavpJdEpQBtrH5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944045; x=1732030445; bh=uebA21VKiIIkAu9Mnh0HKVKcxQKIuZiLf+Z
	vJ+rN4zA=; b=FHRc05H0SUXlbHySNeYjhnGTUXjpQSMaacgq6AeBccf2l7abbGM
	IVvI1p/8hJSkrV7sMCCb3jhu2MEQguoRCnyvgD0PgZ2ZD5KJOUFyIVKF02YvjQbW
	vsIJ2q183xHm5wLHXwH3iFbLqq78V2c19RbFBAsRd5L00QUrNJpaOvCOozEblo8P
	9YwvnFUja2ZlSMXL4WXpvAJDf2NzDszDbCjwq5iVd3P6i7ggTTFfhEAivpUAShqH
	Y3qSPChBLRyWQTzFUaupiL+dUOPzboIZ3lTzZdb2hLYTJ/fuLuOPlPb++sS8+Eh5
	yjLC1DQx3dLWutPwE75PTBl44GTfPIPyAGA==
X-ME-Sender: <xms:bV47Z-gcs2SIlNELa5e4_wZyz9HFTz0gi0bjdKo8rxLy3X2x0qjQgA>
    <xme:bV47Z_DaEeqj5osmHZdYgyzPwZ8tFjXDgzfESdeCw3cx-OBWqx7-WdIQhcz491QbG
    7-ESijB-E2obLo3aw>
X-ME-Received: <xmr:bV47Z2Ew7qBm4sf7Vd3JcgXy20j-MjDgR7eGmoCzV6VvnGWewquz-o9umjl93kBeeDTXRIjYVMoBr9hQErzbXWgI8rFiJ4XXke9oxSd0f861ZhTq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghr
    ughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:bV47Z3QrMYE5LCJLs4genQZZMuGq3puFab2O0AqYIEHBhUZfhDdNaQ>
    <xmx:bV47Z7x8LRJ7H72xiMv81HfOcHAveNzG1XFWFNf3cB4nrsB_NISDdQ>
    <xmx:bV47Z16gpSH5YydzTp-WnWa7Rqke08TWV4K_l5aPI1yWgfFiepfvTQ>
    <xmx:bV47Z4xN3-769Ul9OU5n4OrDTwVxrCCvJKr8TAcdg0rIGr7PLtTPeQ>
    <xmx:bV47ZymMQbzvVnVQ2ojgAN43uvay5xqUI6CkGNOAnHANn-S_4I1CbwuU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6515377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:16 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:33:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/7] reftable: explicitly handle hash format IDs
Message-ID: <38cfe85bf5b82c70848e4b295ba6cae33dcfd667.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731943954.git.ps@pks.im>

The hash format IDs are used for two different things across the
reftable codebase:

  - They are used as a 32 bit unsigned integer when reading and writing
    the header in order to identify the hash function.

  - They are used internally to identify which hash function is in use.

When one only considers the second usecase one might think that one can
easily change the representation of those hash IDs. But because those
IDs end up in the reftable header and footer on disk it is important
that those never change.

Create separate constants `REFTABLE_FORMAT_ID_*` and use them in
contexts where we read or write reftable headers. This serves multiple
purposes:

  - It allows us to more easily discern cases where we actually use
    those constants for the on-disk format.

  - It detangles us from the same constants that are defined in
    libgit.a, which is another required step to convert the reftable
    library to become standalone.

  - It makes the next step easier where we stop using `GIT_*_FORMAT_ID`
    constants in favor of a custom enum.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h |  8 ++++++++
 reftable/reader.c | 10 ++++++----
 reftable/writer.c | 16 +++++++++++++++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 7aa46d7c30d..bcab0b529b0 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -150,4 +150,12 @@ int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(uint32_t id);
 
+/*
+ * Format IDs that identify the hash function used by a reftable. Note that
+ * these constants end up on disk and thus mustn't change. The format IDs are
+ * "sha1" and "s256" in big endian, respectively.
+ */
+#define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
+#define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)
+
 #endif
diff --git a/reftable/reader.c b/reftable/reader.c
index 90dc950b577..64eb6938efe 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -109,16 +109,18 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	if (r->version == 1) {
 		r->hash_id = GIT_SHA1_FORMAT_ID;
 	} else {
-		r->hash_id = get_be32(f);
-		switch (r->hash_id) {
-		case GIT_SHA1_FORMAT_ID:
+		switch (get_be32(f)) {
+		case REFTABLE_FORMAT_ID_SHA1:
+			r->hash_id = GIT_SHA1_FORMAT_ID;
 			break;
-		case GIT_SHA256_FORMAT_ID:
+		case REFTABLE_FORMAT_ID_SHA256:
+			r->hash_id = GIT_SHA256_FORMAT_ID;
 			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
+
 		f += 4;
 	}
 
diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a..9aa45de6340 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -103,8 +103,22 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	put_be64(dest + 8, w->min_update_index);
 	put_be64(dest + 16, w->max_update_index);
 	if (writer_version(w) == 2) {
-		put_be32(dest + 24, w->opts.hash_id);
+		uint32_t hash_id;
+
+		switch (w->opts.hash_id) {
+		case GIT_SHA1_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA1;
+			break;
+		case GIT_SHA256_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA256;
+			break;
+		default:
+			return -1;
+		}
+
+		put_be32(dest + 24, hash_id);
 	}
+
 	return header_size(writer_version(w));
 }
 
-- 
2.47.0.274.g962d0b743d.dirty

