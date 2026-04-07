Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A919995E
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596691; cv=none; b=oPO9NXhAQ/PdpJTPJqmbFnqKo4YOKjz4WavPJ3RA8T04aJumeT+sfI18L+ZiX/mV4uIbhbCnzkrtB7hS0c8YQFGD7LEWal+mG25HF1VWkyaPqrQhU/rhNENb/EduVxiRLdZApHG6PbR9+w0OWwrJur8c/Fo/u7guBCpgdwDsdQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596691; c=relaxed/simple;
	bh=g91li5GUJ2nlzaDLmUUAL0EBioqhLhCGMlK6tINkXas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kny6PfAKbQAozX+lbqtJ56cQa6PzYZVLpxxuHQtDgLEDU+xSy+T3PF+HzFiBR55cAFEUkhv0mfcPM3Zwefjs3+WtRZYBDsYl+AalIMiH8JMw1201PMu7Wzmq4jsSBXkyYH0xV1k+MBbB1QgySUQuxj8tvSVyl/TM4JMeswSZAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kwIXHO6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CB61Xwo6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kwIXHO6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CB61Xwo6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 29E25EC00AE;
	Tue,  7 Apr 2026 17:18:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 17:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775596688; x=1775683088; bh=QxMTxLWSxp
	eGpIGCKMSfFbGj6mgSy1R0AlLB3TqXPCg=; b=kwIXHO6bcdpRAQgZQ+MuWcuYCA
	zIf3y5gEk6yV8IRaR8Zi0ci0/5gi1hj1rxEq04VXrKi0pJJhRvWTvYcRr1powyQf
	olOvI1ev6Vp9fz2msV53928iqK01dQVpSYwPyuFJo3jO+0ZvoErXxrw7/3vKbSI4
	x9iKprUMdL9eJzoFD2viJzM483i8slHVElrbG682TuxcfKP8e7GjgA4u22fZRToo
	wek0mluCS5GxDeKLbBDNsDgHrhXoMq57BB49a7XdW5W0R2eRsgkxC+kc9j0viaLQ
	NqFX7RTWaz2A64hDihbRC5yu67Aa9ZVWAe33teh5UG0gBaZiQ4N0apQYZHaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775596688; x=1775683088; bh=QxMTxLWSxpeGpIGCKMSfFbGj6mgSy1R0AlL
	B3TqXPCg=; b=CB61Xwo6zDrLJShyfcEF3GNRjh2w047w9bGOvzaatgIxUplatc1
	3hoxA/G/XqxAOl5H/Z7yXdF80OhQcUtcOqwTmw5mbD1+YgytrGmMYVyNRvqd9iEg
	2ghl4XMS28vgmsQtNbR8aou/xDZzGBwIPOrYAn7uRGEYbCFqpWpIh2Mm/uR/gepq
	+bCJzdRWKGoW4JaRomdSeTJGZlEiN1iNdX8nZzrfhkP0icGyKbYbvQq5o+lx8aCP
	sb2EG2UukzfrpGD8LiVp+c8Lr32dxR9gO4AB/IEt/4Xk9ZK7b4zvtdp4VXbCuIrY
	KMJJocyjYYYTAza3i/y1tc2B8NziPTlLq0Q==
X-ME-Sender: <xms:j3TVaZ3q56eZF6jE7dFxKrRArUvrhKBPbB8Mw40X8XcFg9cLxr7THg>
    <xme:j3TVaTw0tUAN2WhpFqapDCfLwr64IylRkiHMNmYkTz3jhBl4ANOmlhx3L2y8HSgn9
    nH2_oDSzRQJUqJWNiWPakVajqoCFiR7jblUkl43N9qjQryyzGa5SQ>
X-ME-Received: <xmr:j3TVaTuAKNJMmRL-iiBUUJbKxlymAkeSAIpsMDamCnG0WDDE18uScZiSIO82VaZsbFQo-BDdd_JmxKRdBVh-TO3mM-s6tKeoGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    hutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j3TVadwKxSIOo0wMxhJFoot6Nf5WHMQguBoPDlnDtE79RGk17GRhqw>
    <xmx:j3TVaeAW7Qb-ii9JjWiWI3AjhMKMnROqIp7fqTZxGQRA9LPESvcReg>
    <xmx:j3TVaTccMNuJ2pzmWJPvSpvacjW49AGU1z8nT817mMVVv2uoR4mMAQ>
    <xmx:j3TVaQnkkU_UWyBb2xCJlhyHPXc4OBFo78g3aIRFNKKvXbo1UkS5Cw>
    <xmx:kHTVaUl_rD4ltAkYgz0E2-bmOqKB1VrOPLmUvr7du3s49kb3YthJcJXJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 17:18:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,
  luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
In-Reply-To: <20260407201730.2526914-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 7 Apr 2026 15:17:30 -0500")
References: <20260407201730.2526914-1-jltobler@gmail.com>
Date: Tue, 07 Apr 2026 14:18:06 -0700
Message-ID: <xmqqo6ju31wx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> This patch addresses a bug report[1] where performing git-diff(1) on
> files that exceed "core.bigFileThreshold" outside of a repository causes
> a segfault. Originally this patch was included in another series sent to
> the mailing list[2] as a preparatory refactor. Since it happens to fix
> the reported bug though, I've extracted it from that series with the
> hope of upstreaming more quickly.

OK, so the bug was introduced in fd13909e (Merge branch
'jt/odb-transaction', 2025-10-02) aka v2.52.0-rc0~91 and applying
the test part of your patch alone on v2.52 indeed fails t1517.  The
code change does not directly apply to the old codebase, so I
wiggled your patch to make it apply to v2.52 codebase.

> I wasn't entirely sure if this patch should be based on master or maint.
> I went with master, but am happy to resend if this is incorrect.

So if we wanted to fix the past releases, the attached may be where
we want to start, then adjusting backwards to the shape of the patch
you posted as we merge it up to v2.53 and v2.54 track.

I've applied this to 'maint-2.52' (done and tested), 'maint-2.53'
(done and tested), and to 'master', and made sure that the last one
matches the result of applying your patch directly on top of
'master'.

I'd appreciate it if you can give your eyeballs to the attached to
see if that is how you would fixed the bug in the original context
of v2.52 track.  If everything looks OK, then there is no need to
spend time backporting on your side.  We have everything necessary.

Thanks.

--- >8 ---
From: Justin Tobler <jltobler@gmail.com>
Date: Tue, 7 Apr 2026 15:17:30 -0500
Subject: [PATCH] object-file: avoid ODB transaction when not writing objects

In ce1661f9da (odb: add transaction interface, 2025-09-16), existing
ODB transaction logic is adapted to create a transaction interface
at the ODB layer. The intent here is for the ODB transaction
interface to eventually provide an object source agnostic means to
manage transactions.

An unintended consequence of this change though is that
`object-file.c:index_fd()` may enter the ODB transaction path even
when no object write is requested. In non-repository contexts, this
can result in a NULL dereference and segfault. One such case occurs
when running git-diff(1) outside of a repository with
"core.bigFileThreshold" forcing the streaming path in `index_fd()`:

        $ echo foo >foo
        $ echo bar >bar
        $ git -c core.bigFileThreshold=1 diff -- foo bar

In this scenario, the caller only needs to compute the object ID. Object
hashing does not require an ODB, so starting a transaction is both
unnecessary and invalid.

Fix the bug by avoiding the use of ODB transactions in `index_fd()` when
callers are only interested in computing the object hash.

Reported-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
[jc: adjusted to fd13909e (Merge branch 'jt/odb-transaction', 2025-10-02)]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c           | 49 ++++++++++++++++++++++++++++++++++-------
 t/t1517-outside-repo.sh |  8 +++++++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index 17a236d2fe..0969e27f3d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1599,6 +1599,34 @@ static int index_blob_packfile_transaction(struct odb_transaction *transaction,
 	return 0;
 }
 
+static int hash_blob_stream(const struct git_hash_algo *hash_algo,
+			    struct object_id *result_oid, int fd, size_t size)
+{
+	unsigned char buf[16384];
+	struct git_hash_ctx ctx;
+	unsigned header_len;
+
+	header_len = format_object_header((char *)buf, sizeof(buf),
+					  OBJ_BLOB, size);
+	hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, buf, header_len);
+
+	while (size) {
+		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
+		ssize_t read_result = read_in_full(fd, buf, rsize);
+
+		if ((read_result < 0) || ((size_t)read_result != rsize))
+			return -1;
+
+		git_hash_update(&ctx, buf, rsize);
+		size -= read_result;
+	}
+
+	git_hash_final_oid(result_oid, &ctx);
+
+	return 0;
+}
+
 int index_fd(struct index_state *istate, struct object_id *oid,
 	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
@@ -1620,14 +1648,19 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct odb_transaction *transaction;
-
-		transaction = odb_transaction_begin(the_repository->objects);
-		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
-						      oid, fd,
-						      xsize_t(st->st_size),
-						      path, flags);
-		odb_transaction_commit(transaction);
+		if (flags & INDEX_WRITE_OBJECT) {
+			struct odb_transaction *transaction;
+
+			transaction = odb_transaction_begin(the_repository->objects);
+			ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+							      oid, fd,
+							      xsize_t(st->st_size),
+							      path, flags);
+			odb_transaction_commit(transaction);
+		} else {
+			ret = hash_blob_stream(the_repository->hash_algo, oid,
+					       fd, xsize_t(st->st_size));
+		}
 	}
 
 	close(fd);
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c824c1a25c..c1dbc6359a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -93,6 +93,14 @@ test_expect_success 'diff outside repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
+	cd non-repo &&
+	echo foo >foo &&
+	echo bar >bar &&
+	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
+	test_grep "diff --git a/foo b/bar" actual
+'
+
 test_expect_success 'stripspace outside repository' '
 	nongit git stripspace -s </dev/null
 '
-- 
2.54.0-rc0-282-gaf2821fd49

