Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD01E7C18
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942095; cv=none; b=iMYOJmOtqx/FeaaoJkkEj8sh+TRgM/MMhce3j93ApCpeH/O+AVU5X7PDAcAc5SZnJM9/C2wzBJ3JYNMHHe7HqwXmapgcMoaiQToKWo6e6K6L9oZm+GwfgL3iDdhm24T8iAgO948c3GCHoZ6RE5Sth6ZwtxK8xMTHAyjPz2CiNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942095; c=relaxed/simple;
	bh=hILz6usJ1gDZ+G6i69cccFsOliimjmCX5uvuZhHEpMA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oN1wDZHTTzVVAtw9v4utYF5Cz2BKa0HprqMkM2avVtLWxpVdHF9IotrhnSczWMkMRRPMjmDCJ/6txVg7Nh4wruPZQ9b6aMdHZsVWcquioKnzYLiNb4mkcinWEk5Hlf0RNRqQKr7+A62TDJgIzespzk3OzthMi1O5m43TN5Yuz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpZAsjfJ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpZAsjfJ"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe1009960so1916948137.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736942092; x=1737546892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/Ba+Qkz8WEG/AghvkphjyVjJKZ7OYUq6WwP2py6Dao=;
        b=hpZAsjfJwhFgs1OL+0HQOBB0Xuke6dc/4eR8ECoohlNPlY/YAo9Mep99w6c/KOFieA
         Itv4hhzPtxYDZw9iQDhDMBSaWSrSsvTZAbTqd+/PldP1SuYYjty50k2Ko0ZaI4u0k2Bj
         I84xBdF9OyBv7t1qW0ghhq0GpS1hhuaia8GiTGPcifD5M8loOsBHL8IEf25b07a1O/1e
         R4Dq4IiFghZdhoe7aRWTaZuFjWmsTvVuTNm66me190bFpbcBj8WD7yQVX5pHQntjkScD
         RYnQovozrpMZ58iTiVorDvCZwGaCVTUYs2mbZawgFaBPZzp3BumGCH2/ctkraiOEQ1w3
         pcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942092; x=1737546892;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/Ba+Qkz8WEG/AghvkphjyVjJKZ7OYUq6WwP2py6Dao=;
        b=nPgRr9uccyQMKIj4SgZlxvzs2t41K70mQz4rzZhgL+tJmoU0nC5Kca99Facqxrjlzr
         yiOZPgtvmwzIdSAO4MCGiNXJNYG8ulpegooNdlMWk0+3ilJZtcQ+x3p9bJvpdOIvthhJ
         NZ43Sxq/nb+qfipnrAja9Hhgy/lP41rwjhi68lrW1gkkH7ZikpsVur+UBZiHxdvbQyAu
         GRrMzakNnW4aQHdfKZ29LiiA8UddOqqXvbX0sEGOyCegSssIaMXrQPGuGS1s0aa2NSEK
         j20BRsGTdT4MbZ1JU6eGOWmrZ/LFpFYkZZ0XT3LHLt5xblGXajcwnLaRM8w8GvB1EqY/
         HIvg==
X-Forwarded-Encrypted: i=1; AJvYcCVPG25f3WmBzhS74JADTUKMlSkSdZkWTufqY/2nmY7aCT4tEvSU5fbSH553k98HwyTEgcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77J5ZHV6Tkd4B4h3O4IDs5ArrfjU8sKnbMBCH392L/u7S/6aq
	u+ep6Q33x+GABJvY5SCm5JtqD1ERI7Ff2me7COjxvaqYESOewi6uoEqZIi1Z3et+bug72nfMsIy
	HiDRwp+kwE3pTZv41NScF5x400uX7xhzI
X-Gm-Gg: ASbGnculHDXraO2iIKgpRqZMcXemori49R8bKSJnQnhSksUnilhT4Hdz6yAoiY8XoRZ
	fTowV4Rw+foXBd98iMAbIadwu1Kk/vnETZlO4usQ=
X-Google-Smtp-Source: AGHT+IFWhhTY8xxxm4w3t99LaStf9jmyFB+w+IyBFSdH3T6KYbwsLKPyl01NQKxknd9WoLkYKdssL6yLbnhx3Got1n8=
X-Received: by 2002:a05:6102:508a:b0:4b6:1ce1:3080 with SMTP id
 ada2fe7eead31-4b61ce13307mr21679718137.0.1736942092185; Wed, 15 Jan 2025
 03:54:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jan 2025 11:54:51 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 11:54:51 +0000
X-Gm-Features: AbW1kvbayHekt-k98a0EPWD39S7V3O3Tqp6BraOhY5tnXNObplORdzI-fJs03U0
Message-ID: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000006696e0062bbd58e1"

--0000000000006696e0062bbd58e1
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

Hello brian,

> Hi,
>
> I noticed that Git 2.48 has support for migrating refs when there are
> reflogs and, as promised at Git Merge, I decided to try it out.
> Unfortunately, I got an error:
>

Thanks for trying it out and reporting.

>
> ----
> % git refs migrate --ref-format=reftable --dry-run
> error: reftable: transaction failure: corrupt reftable file
> ----
>
> Here's a small reproduction case:
>
> ----
> #!/bin/sh
>
> rm -fr test-repo
> git init -b dev test-repo
> cd test-repo
>
> # start first block
> touch foo.txt
> git add foo.txt
> git commit -m +
>
> head=$(git rev-parse HEAD)
> seq 5000 | sed -Ee "s!^(.*)\$!create refs/heads/ref-\1 $head!" | git update-ref --stdin
> # end first block
>
> # start second block
> echo abc >bar.txt
> git add bar.txt
> git commit -m +
> head=$(git rev-parse HEAD)
> seq 3000 | sed -Ee "s!^(.*)\$!update refs/heads/ref-\1 $head!" | git update-ref --stdin
> # end second block
>
> git refs migrate --ref-format=reftable
> ----
>
> I can also reproduce this on the latest master.
>

I can also reproduce it using the script provided here.

>
> If you remove the second block, it does not appear to reproduce.  Some
> investigation led me to the conclusion that the difference is when
> max_update_index is not 1, the header has the value 1 for it but the
> trailer has the correct value, and so we flag the header and trailer as
> mismatching and therefore it gets marked as corrupt.  I believe the
> reason things work when removing the second block is because that value
> remains 1, and so it works.
>

Indeed, you're absolutely correct here, this is because the
`max_update_index` is indeed different between the footer and the
header. This flow is triggered when we have multiple reftable blocks
being written with multiple reflog entries. The multiple blocks is
crucial because we update the `max_update_index` right before writing
the reflogs. So if there are refs being written and they spawn more than
one block, the header is written without the updated `max_update_index`,
causing the mismatch.

> I haven't done anything else to investigate here, for which I apologize,
> but I just wanted to mention it while it was fresh on my mind.
>

I think you've provided sufficient information and also enough to make
it easy for me to debug.

> In case this is helpful, I did see this when attempting to migrate two
> work repositories with lots of reflogs and many refs (the smaller has
> 2983 and the larger, 44832).  I obviously cannot send you these
> repositories or things in them, but I'm happy to test patches against
> them.
>

I'm attaching a patch below which should fixes the issue for me and also
adding a test to test against the same. I'd be grateful if you could
also test the patch against the repositoryies you mention.

> Please let me know if I can provide more useful information.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

-- >8 --

Subject: [PATCH] reftable: write correct max_update_index to header

In 297c09eabb (refs: allow multiple reflog entries for the same refname,
2024-12-16), the reftable backend learned to handle multiple reflog
entries within the same transaction. This was done modifying the
`update_index` for reflogs with multiple indices. During writing the
logs, the `max_update_index` of the writer was modified to ensure the
limits were raised to the modified `update_index`s.

However, since ref entries are written before the modification to the
`max_update_index`, if there are multiple blocks to be written, the
reftable backend writes the header with the old `max_update_index`. When
all logs are finally written, the footer will be written with the new
`min_update_index`. This causes a mismatch between the header and the
footer and causes the reftable file to be corrupted. The existing tests
only spawn a single block and since headers are lazily written with the
first block, the tests didn't capture this bug.

To fix the issue, the appropriate `max_update_index` limit must be set
even before the first block is written. Add a `max_index` field to the
transaction which holds the `max_index` within all its updates, then
propagate this value to the reftable backend, wherein this is used to
the set the `max_update_index` correctly.

Add a test which creates a few thousand reference updates with multiple
reflog entries, which should trigger the bug.

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  7 +++++++
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 20 ++++++++++----------
 t/t1460-refs-migrate.sh | 12 ++++++++++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 0f41b2fd4a..f7b6f0f897 100644
--- a/refs.c
+++ b/refs.c
@@ -1345,6 +1345,13 @@ int ref_transaction_update_reflog(struct
ref_transaction *transaction,
 	update->flags &= ~REF_HAVE_OLD;
 	update->index = index;

+	/*
+	 * Reference backends may need to know the max index to optimize
+	 * their writes. So we store the max_index on the transaction level.
+	 */
+	if (index > transaction->max_index)
+		transaction->max_index = index;
+
 	return 0;
 }

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 16550862d3..aaab711bb9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -203,6 +203,7 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 	void *backend_data;
 	unsigned int flags;
+	unsigned int max_index;
 };

 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 00d95a9a2f..289496058e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -942,6 +942,7 @@ struct write_transaction_table_arg {
 	size_t updates_nr;
 	size_t updates_alloc;
 	size_t updates_expected;
+	unsigned int max_index;
 };

 struct reftable_transaction_data {
@@ -1428,7 +1429,6 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
-	uint64_t max_update_index = ts;
 	const char *committer_info;
 	int ret = 0;

@@ -1438,7 +1438,12 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data

 	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);

-	reftable_writer_set_limits(writer, ts, ts);
+	/*
+	 * During reflog migration, we add indexes for a single reflog with
+	 * multiple entries. Each entry will contain a different update_index,
+	 * so set the limits accordingly.
+	 */
+	reftable_writer_set_limits(writer, ts, ts + arg->max_index);

 	for (i = 0; i < arg->updates_nr; i++) {
 		struct reftable_transaction_update *tx_update = &arg->updates[i];
@@ -1540,12 +1545,6 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 				 */
 				log->update_index = ts + u->index;

-				/*
-				 * Note the max update_index so the limit can be set later on.
-				 */
-				if (log->update_index > max_update_index)
-					max_update_index = log->update_index;
-
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1609,8 +1608,6 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 	 * and log blocks.
 	 */
 	if (logs) {
-		reftable_writer_set_limits(writer, ts, max_update_index);
-
 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
 		if (ret < 0)
 			goto done;
@@ -1631,6 +1628,9 @@ static int reftable_be_transaction_finish(struct
ref_store *ref_store UNUSED,
 	struct reftable_transaction_data *tx_data = transaction->backend_data;
 	int ret = 0;

+	if (tx_data->args)
+		tx_data->args->max_index = transaction->max_index;
+
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
 		ret = reftable_addition_add(tx_data->args[i].addition,
 					    write_transaction_table, &tx_data->args[i]);
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f59bc4860f..307b2998ef 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -227,6 +227,18 @@ do
 	done
 done

+test_expect_success 'multiple reftable blocks with multiple entries' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	test_commit -C repo first &&
+	printf "create refs/heads/ref-%d HEAD\n" $(test_seq 5000) >stdin &&
+	git -C repo update-ref --stdin <stdin &&
+	test_commit -C repo second &&
+	printf "update refs/heads/ref-%d HEAD\n" $(test_seq 3000) >stdin &&
+	git -C repo update-ref --stdin <stdin &&
+	test_migration repo reftable
+'
+
 test_expect_success 'migrating from files format deletes backend files' '
 	test_when_finished "rm -rf repo" &&
 	git init --ref-format=files repo &&
-- 
2.47.0

--0000000000006696e0062bbd58e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c3c57b17e772daff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSG9na1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGFmQy80MnJhbHdMQ0ZIQm9JYmlEckJGQmFPQzIvUQplcENIeFFKcHRa
aGd1L09ZMDVodzBFenQ2d3hFREFWb2lDcHVuTWZZS1pyUzdPQkFPUmJTZHprU0ZiRE9LeXh5ClRM
d2J0MktYcitHWG5Ib042ZkJOQ09OblJBUG9aMUpsMlBoZEsxekRzQk5lU2ZCTi82bUZYaGJIZUdZ
Qm1zRTAKaTIwbFNpaTN2WGlyM292U0FNV2V3QW5qTGpGd0loTVhFRHJvUWdmN1RDTk9TbGRJZlRZ
S1AwRXM3cVhrZkpLQwpZMDV4YzR2VFJKTzNZWTlTOXRIY3hodml1REJnSmFRc1NpM040Z3F6ZGQy
L0RJeU9LcFhOcU12SW5MQ3NHbkpVCkNDcUhUNUtPRm9MeUV1cS9iV3BMQXRiSzdBKzJwajQ4Uy9r
akRPdUpkTkpSQ1p1bUUwNG1NVG9KaERGam1MTVgKVmRFQVFGMzU0V0I3c1ArMHdMY3hBd3JrTDJT
ajAxVDlaR3o3SmMrakpKdXhMMWNaUmRvMkI5OVljWDJrK0krbQovMHVUTU5ZYUxXU1MvcDJaMkh4
Ym52UUxsT0Z3SU0xaFZWTXhjMUdGN2F0Y2I5cmRXaGV6ZmtiSE1nUDZSUDRNCkt3R2FsQzZBOENz
S1c1b1JTQW02MENSNWFDamZTaGZCV3BMYlU2Zz0KPWdlVW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006696e0062bbd58e1--
