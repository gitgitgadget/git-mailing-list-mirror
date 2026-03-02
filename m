Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DA390991
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487934; cv=none; b=SzQeD6tZkvrut+dZpddq1/Q3d+TjcRRB0DFudDAAP7OPjPw9dnpoHj5M9KkUsQnHDewK1cNeLlxZxx1r3BsrA2jbnkYDgjH5ZbBI+VdPiPoUJrvWrmSgvKqbURys+/C0h7W7wzzck97VQt+r7GOQVXxndBk/HqaBcoavIPzDs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487934; c=relaxed/simple;
	bh=1zsu8Kb7gtOv55/t2FrpLFclHUXUzy8u+kOs3M6dBZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrCyFUYxY/vWqd8TrwM6Fp2PmZIL2cnXWCgFqPaw8YjPYrL8DGBb1IjbsGU0tXHt/cFBSWHnPk76tk7XKsmBnyWCed+/rwNq+fkvsBVQlI5nKh6yeLQ7dHTFeTU5KsvdYsRMGPngcaezcVHg3VxX2TnmGtK33R80I8UAY/utyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsz2Qw5H; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsz2Qw5H"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679aebf4e56so3612318eaf.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487931; x=1773092731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpWPdW3tkGWFztbanDa3NpHl6r30adPXKFRgz05qpwE=;
        b=Xsz2Qw5HLJB+jWEDcB/VBRqoDzET5tVzMaytYrF70OfiOChsgbybxYq1OlQF7d0aeT
         A/wtHVQha3aTkTRx6hZumyUkrkdWC37PhBpCld4b73qXvnrHtrRN51wnpnx+imIZqDSs
         6byQWL/A7BkMW5EfXxoaAxv2Cfi/CZfuRvEdhJgCK4OUxqXh0nyWcylY6Z6h2BF6/Sl+
         g7ddJZOM7m8K5cgzTlDpOTHMheRh9Jn2blF58yRJhVjf7/Uti6wURNZ0qRBe8odz7U4R
         lL4ZXmLPh5BxwiooKyFPaTMb+5yElsj9LDZ0vwi+qAifjYkTz5GUDUZzsfWoak2xSbaW
         2QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487931; x=1773092731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpWPdW3tkGWFztbanDa3NpHl6r30adPXKFRgz05qpwE=;
        b=kMA8fqufNIbqMM6A60NAJ8ovXynavObQbXynqqBvWrgidnCMRV/0rv8eYieK67cuo3
         Dbkm34LzjXWVHYE+HaWmyIlhovXZJlseUXntfJSogmuQtfnLJbvDGFmI7Fq7CHWI/Ib3
         k1jMs4ovrmkQZXKr1ysufH1Pw5xJYWzJrSXyge+2HVvELuzCC46JvS3A4IrsmY3UiVTj
         UN/LHKWI5dmDbUpLj2LqAkx/PsQmZR+zxzjLPp6ptOOc8up3bYZdk22kEsmQPVzIh6Px
         9ttUCdJDEcJRGRG0cZRYTwOrptHEvzR5q7NCuJKoB5fP7qdZhsb9/D1CcqS9Bm9VQXsO
         gDyw==
X-Gm-Message-State: AOJu0YyjGoELyc1BOeHqhBsYx4RZFhmTSRLm5UUoBhCQkD7zTWl+0P79
	JPAcwRi7xN5WekOqk8Y28Ax+wmIRpmDe6l8eO6gjWKLIEzaEnAwlSY/3uyNXPA==
X-Gm-Gg: ATEYQzxhVl3EvdW8Z1cNbr/JzXNjE3+thF8mZH5kA/v7ptBJc7Nplbsb8S60okJjdrI
	6HDaHcOl7RC2iy5weHWcwb+B3F9tejuFQYVNugxs1k7p9mq6Bfko8udqT4FK/sQejk+pX1mJ6K0
	ooYwig3bNPmwR2Xh7fbJEMeW9uRzQAVeZQqPywvCSuzu4aXtsfW4lKuvqwpC54Hf+ElpwIiDsI0
	qgZf1r7TvGIE9I+koJM6W1n3kqNjZQQTYkbdRvllCRRLW8lD27oJCRwbBAuAUhXM8NKMOEJUQMH
	jyJl5gCAjyGMd5zO1FZY73Q9j//4coBW9yV5ojmZgFBEM+/Zk+K+tXGIQAaMj8w5c2HvOhcWY2v
	NZj4nWLuzxmVyuAWac7eR5OgRWI0wq6rCOqRYGN3qc6OukNZVhzvYfu+fCGa1jt/Ie2eEaJbfpO
	MA1ErvoGUDhsWXJymvZZ2jav8XVKTve8Y=
X-Received: by 2002:a4a:e707:0:b0:67a:467:b2b9 with SMTP id 006d021491bc7-67a0467f755mr4418672eaf.21.1772487931312;
        Mon, 02 Mar 2026 13:45:31 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:30 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/6] builtin/repo: include largest object information
Date: Mon,  2 Mar 2026 15:45:20 -0600
Message-ID: <20260302214526.2034279-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223174120.2356504-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The "structure" output for git-repo(1) currently provides count
information for references/objects as well as total inflated/disk sizes
of objects by type. Info regarding the largest individual objects in the
repository is not yet collected, but would be useful to users wishing to
identify such large objects.

This patch series adds the following data points:
- The OID and size of the largest objects by object type
- The OID and parent count of the commit with the most parents
- The OID and entries count of the tree with the most entries

Changes from V2:
- When checking for largest objects, zero valued objects were not
  recorded even if they were the "largest" object. In this version, if
  an object ID has not been recorded yet, it is always added even if its
  value is zero.
- Added some helper functions for printing keyvalue info to cut down on
  duplicate code and hopefully make it a bit easier on the eyes.
- Moved the for-each loop that printed table OID annoations inside the
  preceding if-block making it a bit easier to reason about.

Changes from V1:
- Avoided duplicating the annotation string by handing over ownership.
- I decided to leave the `struct object_stats` structure alone for now
  as storing the various object values per-type does make it convenient
  to calulate the various totals. I may revisit this in a future series
  though.

Thanks,
-Justin

Justin Tobler (6):
  builtin/repo: update stats for each object
  builtin/repo: add helper for printing keyvalue output
  builtin/repo: collect largest inflated objects
  builtin/repo: add OID annotations to table output
  builtin/repo: find commit with most parents
  builtin/repo: find tree with most entries

 Documentation/git-repo.adoc |   1 +
 builtin/repo.c              | 323 ++++++++++++++++++++++++++++--------
 t/t1901-repo-structure.sh   | 143 ++++++++++------
 3 files changed, 352 insertions(+), 115 deletions(-)

Range-diff against v2:
1:  94a44e0e0f = 1:  94a44e0e0f builtin/repo: update stats for each object
-:  ---------- > 2:  36c11351ae builtin/repo: add helper for printing keyvalue output
2:  92dbf34f2c ! 3:  90e71c058d builtin/repo: collect largest inflated objects
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      }
      
      static void stats_table_print_structure(const struct stats_table *table)
    +@@ builtin/repo.c: static inline void print_keyvalue(const char *key, char key_delim, size_t value,
    + 	       value_delim);
    + }
    + 
    ++static void print_object_data(const char *key, char key_delim,
    ++			      struct object_data *data, char value_delim)
    ++{
    ++	print_keyvalue(key, key_delim, data->value, value_delim);
    ++	printf("%s_oid%c%s%c", key, key_delim, oid_to_hex(&data->oid),
    ++	       value_delim);
    ++}
    ++
    + static void structure_keyvalue_print(struct repo_structure *stats,
    + 				     char key_delim, char value_delim)
    + {
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
    - 	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
    + 	print_keyvalue("objects.tags.disk_size", key_delim,
    + 		       stats->objects.disk_sizes.tags, value_delim);
      
    -+	printf("objects.commits.max_size%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.commit_size.value, value_delim);
    -+	printf("objects.commits.max_size_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.commit_size.oid), value_delim);
    -+	printf("objects.trees.max_size%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.tree_size.value, value_delim);
    -+	printf("objects.trees.max_size_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.tree_size.oid), value_delim);
    -+	printf("objects.blobs.max_size%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.blob_size.value, value_delim);
    -+	printf("objects.blobs.max_size_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.blob_size.oid), value_delim);
    -+	printf("objects.tags.max_size%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.tag_size.value, value_delim);
    -+	printf("objects.tags.max_size_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
    ++	print_object_data("objects.commits.max_size", key_delim,
    ++			  &stats->objects.largest.commit_size, value_delim);
    ++	print_object_data("objects.trees.max_size", key_delim,
    ++			  &stats->objects.largest.tree_size, value_delim);
    ++	print_object_data("objects.blobs.max_size", key_delim,
    ++			  &stats->objects.largest.blob_size, value_delim);
    ++	print_object_data("objects.tags.max_size", key_delim,
    ++			  &stats->objects.largest.tag_size, value_delim);
     +
      	fflush(stdout);
      }
    @@ builtin/repo.c: struct count_objects_data {
     +static void check_largest(struct object_data *data, struct object_id *oid,
     +			  size_t value)
     +{
    -+	if (value > data->value) {
    ++	if (value > data->value || is_null_oid(&data->oid)) {
     +		oidcpy(&data->oid, oid);
     +		data->value = value;
     +	}
3:  1457d5d59c ! 4:  938c36df91 builtin/repo: add OID annotations to table output
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      		printf("%s\n", buf.buf);
      	}
      
    -+	if (table->annotations.nr)
    ++	if (table->annotations.nr) {
     +		printf("\n");
    -+	for_each_string_list_item(item, &table->annotations)
    -+		printf("%s\n", item->string);
    ++		for_each_string_list_item(item, &table->annotations)
    ++			printf("%s\n", item->string);
    ++	}
     +
      	strbuf_release(&buf);
      }
    @@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     +	string_list_clear(&table->annotations, 1);
      }
      
    - static void structure_keyvalue_print(struct repo_structure *stats,
    + static inline void print_keyvalue(const char *key, char key_delim, size_t value,
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      {
      	struct stats_table table = {
4:  f4e92e3f09 ! 5:  ab9870f06e builtin/repo: find commit with most parents
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      	stats_table_object_size_addf(table,
      				     &objects->largest.tree_size.oid,
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 	printf("objects.tags.max_size_oid%c%s%c", key_delim,
    - 	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
    + 	print_object_data("objects.tags.max_size", key_delim,
    + 			  &stats->objects.largest.tag_size, value_delim);
      
    -+	printf("objects.commits.max_parents%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.parent_count.value, value_delim);
    -+	printf("objects.commits.max_parents_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.parent_count.oid), value_delim);
    ++	print_object_data("objects.commits.max_parents", key_delim,
    ++			  &stats->objects.largest.parent_count, value_delim);
     +
      	fflush(stdout);
      }
5:  af404fcc6c ! 6:  2884cb451c builtin/repo: find tree with most entries
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      	stats_table_object_size_addf(table,
      				     &objects->largest.blob_size.oid,
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 	       (uintmax_t)stats->objects.largest.parent_count.value, value_delim);
    - 	printf("objects.commits.max_parents_oid%c%s%c", key_delim,
    - 	       oid_to_hex(&stats->objects.largest.parent_count.oid), value_delim);
    -+	printf("objects.trees.max_entries%c%" PRIuMAX "%c", key_delim,
    -+	       (uintmax_t)stats->objects.largest.tree_entries.value, value_delim);
    -+	printf("objects.trees.max_entries_oid%c%s%c", key_delim,
    -+	       oid_to_hex(&stats->objects.largest.tree_entries.oid), value_delim);
    + 
    + 	print_object_data("objects.commits.max_parents", key_delim,
    + 			  &stats->objects.largest.parent_count, value_delim);
    ++	print_object_data("objects.trees.max_entries", key_delim,
    ++			  &stats->objects.largest.tree_entries, value_delim);
      
      	fflush(stdout);
      }

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0

