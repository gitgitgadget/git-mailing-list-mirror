Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646E253939
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340215; cv=none; b=EJhfu+Lb37P6/TyR3xQVOZ5rbdD+juCa/Md0kiN+sdsiYF/K9k9nnewZiNeaFYzjQ/f8lyTS+9IsmqZx88gLCTS9bvmqwzo+Agkqus3zPD+QqY9jR3OyMAF0p/QXoCdz/q97U/Np+rgQM34LWGOtavKVXZFhLmkGpnQvqfsohuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340215; c=relaxed/simple;
	bh=5Felg2xIYESUEgtEN36rUuLZUMwhCSYA6idiqs1s8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjcWNJ1wm6qW2UNqdeKpkAtX9og+z20kU2OusDAmfRwjbGULutplmg7Ms7ACZGlQEfbfDMZbSRTpnWoItB8G4MDHRr+B6cV+SbgJ7+rCauOeeKfwQWDsweLRRblJz9g6hKAuZCtlDwMHA/cEoakPVlv0cDrxIneLSVnLyLUIMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs9u+ABb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs9u+ABb"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54690d369so821945f8f.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750340211; x=1750945011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++VzAIQMCT/B3nT6q365eZkE1Qy9ZSCpC8jWYbztVqs=;
        b=Xs9u+ABb2FOhMLHDjSPeHd3EiMt0zAC8nYnWgRr5bZEl7EXQ+CQ0X1pxfl/wZ5HhiJ
         u8n+vjbYe0TkwXtFHGnSz19+Ew2M1o4bx1xmVEHW9BtFthcuXdbdRSOTJfXT8naQNdKA
         vJ4H12Ad4vYb48/vDTJEFqqia24KoDXmPXqsy2lMhWie6musuCrLpUsMbUGZ0rN7WzFJ
         Wl67uBrkS36HXGD71MsWRr5X9O9QkcJwKoGCraRZ6Srpi7ir+bUZX6YvgHiP/eJv6oe2
         R473EGLBwcLeLDm26iroJB0l/ni4JDznN7sMoK/ZxSsyUJsA6IRMtu5hjoHQSEQYjvXG
         ABLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340211; x=1750945011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++VzAIQMCT/B3nT6q365eZkE1Qy9ZSCpC8jWYbztVqs=;
        b=O9UqDdF/GoNYg9FclKiuQ0RS0jGcJ9ySoIV4WBdT3pav3BaCy1yBqoLj7WhwxdtMDe
         zrWvl5ePxLY9WbQiTXhNnCIMpwMq/52LMpOGOtBS3hBCHSoLvOC4GV6RpVlqWwzTaq6/
         OddZFyK2YHV0k3zUjFB+2LbfYPFWSc5Jl+5fHj3RWV0KGuMvU4cAXj608abYIkXv5b7E
         PHG0BQJaoq/oNoaeDMVhq+CmYEN1C3AdyuEdkh7gEL3bdl5YBPgrWWTY+/EKx7aYTSPa
         BsLFEo5EdrTY2nEEhsK15tar1oyXm15BMvwqvliXYrr+0rf1l560RqTUnhXsDKPD3YKm
         WCxA==
X-Gm-Message-State: AOJu0Yxc2PIpaxOr5yt4WaNkUGnj8wAQ+1iQcMChcFRZSyFew9ogwkiJ
	Cdzfvob0C8GuZp+qnalSNKHpFuEJUUrtZ2Kyh4S5FP6o5ZcthR3LD9jgYyo6CQ==
X-Gm-Gg: ASbGncs+jiv6boERs/OXYDXtjGnb/AzMh434+B2PgLCfvhVfq5cIoODkxo9NbcWizJJ
	g8XxWtliNoOKzS8Zqclfe74xYQYZgi2tRNgRtRToDRh7j/EnRKTbpKrzoCwxxSc7azpwkANdegu
	85K1cmOPxdM3MxxLmbe8x3Tsw1wqIBul8nrsFcPFBaYf8fGuqk7JYXHjHmGreINKbSH9qTIM5nC
	bWI9Gcs+fIm4VTHN6SQ+T7RYqX9cpQdntG8wxHwhx6Ok6wNm1bwhu5klxHnDVafc4i6fIZCwYW2
	9OaQ/YeCG08YvCVos6loNQ4sOwXWs549WHiZbTdIyoh1rgSzPUAkXNge15HQGAYZvTPg1icZaFt
	yQT80WkUPLLn2qt0VDVw1fwWBuLYGcmVEPiJCX99yhTFR
X-Google-Smtp-Source: AGHT+IGzYOuM8Rer7P8wuejduCcM2FN7hLLA7pzztEazWOCx8zxRTikBeEBPvgbccvsO9tU4tJbXLw==
X-Received: by 2002:a05:6000:2582:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a5723a3b64mr15267665f8f.30.1750340210277;
        Thu, 19 Jun 2025 06:36:50 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b0898fsm20040205f8f.54.2025.06.19.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:36:49 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4] fast-(import|export): improve on commit signature output format
Date: Thu, 19 Jun 2025 15:36:30 +0200
Message-ID: <20250619133630.727274-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.2.g875523421d
In-Reply-To: <20250618151821.528627-1-christian.couder@gmail.com>
References: <20250618151821.528627-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
signed-commits, 2025-03-10), added support for signed commits to
fast-export and fast-import.

When a signed commit is processed, fast-export can output either
"gpgsig sha1" or "gpgsig sha256" depending on whether the signed
commit uses the SHA-1 or SHA-256 Git object format.

However, this implementation has a number of limitations:

  - the output format was not properly described in the documentation,
  - the output format is not very informative as it doesn't even say
    if the signature is an OpenPGP, an SSH, or an X509 signature,
  - the implementation doesn't support having both one signature on
    the SHA-1 object and one on the SHA-256 object.

Let's improve on these limitations by improving fast-export and
fast-import so that:

  - both one signature on the SHA-1 object and one on the SHA-256
    object can be exported and imported,
  - if there is more than one signature on the SHA-1 object or on
    the SHA-256 object, a warning is emitted,
  - the output format is "gpgsig <git-hash-algo> <signature-format>",
    where <git-hash-algo> is the Git object format as before, and
    <signature-format> is the signature type ("openpgp", "x509",
    "ssh" or "unknown",
  - the output is properly documented.

Note that it could be even better to be able to export and import
more than one signature on the SHA-1 object and on the SHA-256
object, but other parts of Git don't handle that well for now, so
this is left for future improvements.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This v4 is just about fixing a few bugs in the tests using the SHA-256
object format compared to the v3. (I had issues with CI tests on v3,
so I sent it without waiting for the results.)

The v1 of this patch series simply replaced the generic "sha1" or
"sha256" in the 'gpgsig' command that `git fast-export` produces and
`git fast-import` consumes with the signature format (e.g., openpgp,
ssh).

In the v2, a different approach was tried in the direction of possibly
making `git fast-export` check signatures to be able to get more
information from them.

In this v4 and in v3, the approach is more similar to v1, but takes
into account what was learned from the previous approaches. The
signature format (e.g., openpgp, ssh) is added to the 'gpgsig'
command, while both a SHA-1 and a SHA-256 signature from the same
commit can be processed and a warning are emitted for each additional
signature with the same hash type.

There are no tests in this v4 and in v3 with both a SHA-1 and a
SHA-256 signature on the same commit though, as I am not sure yet how
to best generate a commit with such signatures. Suggestions welcome!

Thanks to brian, Elijah and Junio who commented on the v1 and v2.

Range-diff with v3:

1:  d28cf238fb ! 1:  b3d8b13c0e fast-(import|export): improve on commit signature output format
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=warn-strip' '
     +test_expect_success GPGSM 'round-trip X.509 signed commit' '
     +
     +  git fast-export --signed-commits=verbatim x509-signing >output &&
    -+  grep "^gpgsig sha1 x509" output &&
    ++  test_grep -E "^gpgsig sha(1|256) x509" output &&
     +  (
     +          cd new &&
     +          git fast-import &&
     +          git cat-file commit refs/heads/x509-signing >actual &&
    -+          grep "^gpgsig " actual &&
    ++          grep "^gpgsig" actual &&
     +          IMPORTED=$(git rev-parse refs/heads/x509-signing) &&
     +          test $X509_COMMIT = $IMPORTED
     +  ) <output
    @@ t/t9350-fast-export.sh: test_expect_success GPG 'signed-commits=warn-strip' '
     +test_expect_success GPGSSH 'round-trip SSH signed commit' '
     +
     +  git fast-export --signed-commits=verbatim ssh-signing >output &&
    -+  grep "^gpgsig sha1 ssh" output &&
    ++  test_grep -E "^gpgsig sha(1|256) ssh" output &&
     +  (
     +          cd new &&
     +          git fast-import &&
     +          git cat-file commit refs/heads/ssh-signing >actual &&
    -+          grep "^gpgsig " actual &&
    ++          grep "^gpgsig" actual &&
     +          IMPORTED=$(git rev-parse refs/heads/ssh-signing) &&
     +          test $SSH_COMMIT = $IMPORTED
     +  ) <output


CI tests:

They have all passed:

https://github.com/chriscool/git/actions/runs/15758360209


 Documentation/git-fast-export.adoc |  17 +++++
 Documentation/git-fast-import.adoc |  31 ++++++--
 builtin/fast-export.c              |  67 ++++++++++++++---
 builtin/fast-import.c              | 117 +++++++++++++++++++++++------
 gpg-interface.c                    |  12 +++
 gpg-interface.h                    |  12 +++
 t/t9350-fast-export.sh             |  60 ++++++++++++++-
 7 files changed, 274 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 43bbb4f63c..64198f2186 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -50,6 +50,23 @@ resulting tag will have an invalid signature.
 	is the same as how earlier versions of this command without
 	this option behaved.
 +
+When exported, a signature starts with:
++
+gpgsig <git-hash-algo> <signature-format>
++
+where <git-hash-algo> is the Git object hash so either "sha1" or
+"sha256", and <signature-format> is the signature type, so "openpgp",
+"x509", "ssh" or "unknown".
++
+For example, an OpenPGP signature on a SHA-1 commit starts with
+`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
+starts with `gpgsig sha256 ssh`.
++
+Currently for a given commit, at most one signature for the SHA-1
+object and one signature for the SHA-256 object are exported, each
+with their respective <git-hash-algo> identifier. A warning is
+emitted for each additional signature found.
++
 NOTE: This is highly experimental and the format of the data stream may
 change in the future without compatibility guarantees.
 
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 250d866652..db5e5c8da5 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -445,7 +445,7 @@ one).
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
-	('gpgsig' SP <alg> LF data)?
+	('gpgsig' SP <algo> SP <format> LF data)?
 	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
@@ -518,13 +518,32 @@ their syntax.
 ^^^^^^^^
 
 The optional `gpgsig` command is used to include a PGP/GPG signature
-that signs the commit data.
+or other cryptographic signature that signs the commit data.
 
-Here <alg> specifies which hashing algorithm is used for this
-signature, either `sha1` or `sha256`.
+....
+	'gpgsig' SP <git-hash-algo> SP <signature-format> LF
+	data
+....
+
+The `gpgsig` command takes two arguments:
+
+* `<git-hash-algo>` specifies which Git object format this signature
+  applies to, either `sha1` or `sha256`.
+
+* `<signature-format>` specifies the type of signature, such as
+  `openpgp`, `x509`, `ssh`, or `unknown`.
+
+A commit may have at most one signature for the SHA-1 object format
+(stored in the "gpgsig" header) and one for the SHA-256 object format
+(stored in the "gpgsig-sha256" header).
+
+See below for a detailed description of the `data` command which
+contains the raw signature data.
+
+Signatures are not yet checked in the current implementation though.
 
-NOTE: This is highly experimental and the format of the data stream may
-change in the future without compatibility guarantees.
+NOTE: This is highly experimental and the format of the `gpgsig`
+command may change in the future without compatibility guarantees.
 
 `encoding`
 ^^^^^^^^^^
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index fcf6b00d5f..332c036ee4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -29,6 +29,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 static const char *const fast_export_usage[] = {
 	N_("git fast-export [<rev-list-opts>]"),
@@ -652,6 +653,30 @@ static const char *find_commit_multiline_header(const char *msg,
 	return strbuf_detach(&val, NULL);
 }
 
+static void print_signature(const char *signature, const char *object_hash)
+{
+	if (!signature)
+		return;
+
+	printf("gpgsig %s %s\ndata %u\n%s",
+	       object_hash,
+	       get_signature_format(signature),
+	       (unsigned)strlen(signature),
+	       signature);
+}
+
+static void warn_on_extra_sig(const char **pos, struct commit *commit, int is_sha1)
+{
+	const char *header = is_sha1 ? "gpgsig" : "gpgsig-sha256";
+	const char *extra_sig = find_commit_multiline_header(*pos + 1, header, pos);
+	if (extra_sig) {
+		const char *hash = is_sha1 ? "SHA-1" : "SHA-256";
+		warning("more than one %s signature found on commit %s, using only the first one",
+			hash, oid_to_hex(&commit->object.oid));
+		free((char *)extra_sig);
+	}
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  struct string_list *paths_of_changed_objects)
 {
@@ -660,7 +685,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	const char *author, *author_end, *committer, *committer_end;
 	const char *encoding = NULL;
 	size_t encoding_len;
-	const char *signature_alg = NULL, *signature = NULL;
+	const char *sig_sha1 = NULL;
+	const char *sig_sha256 = NULL;
 	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
@@ -700,10 +726,28 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	}
 
 	if (*commit_buffer_cursor == '\n') {
-		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
-			signature_alg = "sha1";
-		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
-			signature_alg = "sha256";
+		const char *sig_cursor = commit_buffer_cursor;
+		const char *after_sha1 = commit_buffer_cursor;
+		const char *after_sha256 = commit_buffer_cursor;
+
+		/*
+		 * Find the first signature for each hash algorithm.
+		 * The searches must start from the same position.
+		 */
+		sig_sha1 = find_commit_multiline_header(sig_cursor + 1,
+							"gpgsig",
+							&after_sha1);
+		sig_sha256 = find_commit_multiline_header(sig_cursor + 1,
+							  "gpgsig-sha256",
+							  &after_sha256);
+
+		/* Warn on any additional signatures, as they will be ignored. */
+		if (sig_sha1)
+			warn_on_extra_sig(&after_sha1, commit, 1);
+		if (sig_sha256)
+			warn_on_extra_sig(&after_sha256, commit, 0);
+
+		commit_buffer_cursor = (after_sha1 > after_sha256) ? after_sha1 : after_sha256;
 	}
 
 	message = strstr(commit_buffer_cursor, "\n\n");
@@ -769,7 +813,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
-	if (signature) {
+	if (sig_sha1 || sig_sha256) {
 		switch (signed_commit_mode) {
 		case SIGN_ABORT:
 			die("encountered signed commit %s; use "
@@ -780,19 +824,18 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_VERBATIM:
-			printf("gpgsig %s\ndata %u\n%s",
-			       signature_alg,
-			       (unsigned)strlen(signature),
-			       signature);
+			print_signature(sig_sha1, "sha1");
+			print_signature(sig_sha256, "sha256");
 			break;
 		case SIGN_WARN_STRIP:
-			warning("stripping signature from commit %s",
+			warning("stripping signature(s) from commit %s",
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_STRIP:
 			break;
 		}
-		free((char *)signature);
+		free((char *)sig_sha1);
+		free((char *)sig_sha256);
 	}
 	if (!reencoded && encoding)
 		printf("encoding %.*s\n", (int)encoding_len, encoding);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b2839c5f43..48ce8ebb77 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
+#include "gpg-interface.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2718,15 +2719,86 @@ static struct hash_list *parse_merge(unsigned int *count)
 	return list;
 }
 
+struct signature_data {
+	char *hash_algo;      /* "sha1" or "sha256" */
+	char *sig_format;     /* "openpgp", "x509", "ssh", "unknown" */
+	struct strbuf data;   /* The actual signature data */
+};
+
+static void parse_one_signature(struct signature_data *sig, const char *v)
+{
+	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
+	char *space = strchr(args, ' ');
+
+	if (!space)
+		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
+		    "got 'gpgsig %s'", args);
+	*space++ = '\0';
+
+	sig->hash_algo = args;
+	sig->sig_format = space;
+
+	/* Remove any trailing newline from format */
+	space = strchr(sig->sig_format, '\n');
+	if (space)
+		*space = '\0';
+
+	/* Validate hash algorithm */
+	if (strcmp(sig->hash_algo, "sha1") &&
+	    strcmp(sig->hash_algo, "sha256"))
+		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);
+
+	/* Validate signature format */
+	if (!valid_signature_format(sig->sig_format))
+		die("Invalid signature format in gpgsig: '%s'", sig->sig_format);
+	if (!strcmp(sig->sig_format, "unknown"))
+		warning("'unknown' signature format in gpgsig");
+
+	/* Read signature data */
+	read_next_command();
+	parse_data(&sig->data, 0, NULL);
+}
+
+static void add_gpgsig_to_commit(struct strbuf *commit_data,
+				 const char *header,
+				 struct signature_data *sig)
+{
+	struct string_list siglines = STRING_LIST_INIT_NODUP;
+
+	if (!sig->hash_algo)
+		return;
+
+	strbuf_addstr(commit_data, header);
+	string_list_split_in_place(&siglines, sig->data.buf, "\n", -1);
+	strbuf_add_separated_string_list(commit_data, "\n ", &siglines);
+	strbuf_addch(commit_data, '\n');
+	string_list_clear(&siglines, 1);
+	strbuf_release(&sig->data);
+	free(sig->hash_algo);
+}
+
+static void store_signature(struct signature_data *stored_sig,
+			    struct signature_data *new_sig,
+			    const char *hash_type)
+{
+	if (stored_sig->hash_algo) {
+		warning("Multiple %s signatures found, ignoring additional signature",
+			hash_type);
+		strbuf_release(&new_sig->data);
+		free(new_sig->hash_algo);
+	} else {
+		*stored_sig = *new_sig;
+	}
+}
+
 static void parse_new_commit(const char *arg)
 {
-	static struct strbuf sig = STRBUF_INIT;
 	static struct strbuf msg = STRBUF_INIT;
-	struct string_list siglines = STRING_LIST_INIT_NODUP;
+	struct signature_data sig_sha1 = { NULL, NULL, STRBUF_INIT };
+	struct signature_data sig_sha256 = { NULL, NULL, STRBUF_INIT };
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
-	char *sig_alg = NULL;
 	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
@@ -2750,13 +2822,23 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	if (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
-		sig_alg = xstrdup(v);
-		read_next_command();
-		parse_data(&sig, 0, NULL);
+
+	/* Process signatures (up to 2: one "sha1" and one "sha256") */
+	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
+		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
+
+		parse_one_signature(&sig, v);
+
+		if (!strcmp(sig.hash_algo, "sha1"))
+			store_signature(&sig_sha1, &sig, "SHA-1");
+		else if (!strcmp(sig.hash_algo, "sha256"))
+			store_signature(&sig_sha256, &sig, "SHA-256");
+		else
+			BUG("parse_one_signature() returned unknown hash algo");
+
 		read_next_command();
-	} else
-		strbuf_setlen(&sig, 0);
+	}
+
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
 		read_next_command();
@@ -2830,23 +2912,14 @@ static void parse_new_commit(const char *arg)
 		strbuf_addf(&new_data,
 			"encoding %s\n",
 			encoding);
-	if (sig_alg) {
-		if (!strcmp(sig_alg, "sha1"))
-			strbuf_addstr(&new_data, "gpgsig ");
-		else if (!strcmp(sig_alg, "sha256"))
-			strbuf_addstr(&new_data, "gpgsig-sha256 ");
-		else
-			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
-		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
-		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
-		strbuf_addch(&new_data, '\n');
-	}
+
+	add_gpgsig_to_commit(&new_data, "gpgsig ", &sig_sha1);
+	add_gpgsig_to_commit(&new_data, "gpgsig-sha256 ", &sig_sha256);
+
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
-	string_list_clear(&siglines, 1);
 	free(author);
 	free(committer);
-	free(sig_alg);
 	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..6f2d87475f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -144,6 +144,18 @@ static struct gpg_format *get_format_by_sig(const char *sig)
 	return NULL;
 }
 
+const char *get_signature_format(const char *buf)
+{
+	struct gpg_format *format = get_format_by_sig(buf);
+	return format ? format->name : "unknown";
+}
+
+int valid_signature_format(const char *format)
+{
+       return (!!get_format_by_name(format) ||
+	       !strcmp(format, "unknown"));
+}
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
diff --git a/gpg-interface.h b/gpg-interface.h
index e09f12e8d0..60ddf8bbfa 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -47,6 +47,18 @@ struct signature_check {
 
 void signature_check_clear(struct signature_check *sigc);
 
+/*
+ * Return the format of the signature (like "openpgp", "x509", "ssh"
+ * or "unknown").
+ */
+const char *get_signature_format(const char *buf);
+
+/*
+ * Is the signature format valid (like "openpgp", "x509", "ssh" or
+ * "unknown")
+ */
+int valid_signature_format(const char *format);
+
 /*
  * Look at a GPG signed tag object.  If such a signature exists, store it in
  * signature and the signed content in payload.  Return 1 if a signature was
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 76619765fc..3559a33c72 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -314,7 +314,7 @@ test_expect_success GPG 'signed-commits=abort' '
 test_expect_success GPG 'signed-commits=verbatim' '
 
 	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
-	grep "^gpgsig sha" output &&
+	test_grep -E "^gpgsig sha(1|256) openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	(
 		cd new &&
@@ -328,7 +328,7 @@ test_expect_success GPG 'signed-commits=verbatim' '
 test_expect_success GPG 'signed-commits=warn-verbatim' '
 
 	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
-	grep "^gpgsig sha" output &&
+	test_grep -E "^gpgsig sha(1|256) openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	test -s err &&
 	(
@@ -369,6 +369,62 @@ test_expect_success GPG 'signed-commits=warn-strip' '
 
 '
 
+test_expect_success GPGSM 'setup X.509 signed commit' '
+
+	git checkout -b x509-signing main &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo "X.509 content" >file &&
+	git add file &&
+	git commit -S -m "X.509 signed commit" &&
+	X509_COMMIT=$(git rev-parse HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSM 'round-trip X.509 signed commit' '
+
+	git fast-export --signed-commits=verbatim x509-signing >output &&
+	test_grep -E "^gpgsig sha(1|256) x509" output &&
+	(
+		cd new &&
+		git fast-import &&
+		git cat-file commit refs/heads/x509-signing >actual &&
+		grep "^gpgsig" actual &&
+		IMPORTED=$(git rev-parse refs/heads/x509-signing) &&
+		test $X509_COMMIT = $IMPORTED
+	) <output
+
+'
+
+test_expect_success GPGSSH 'setup SSH signed commit' '
+
+	git checkout -b ssh-signing main &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	echo "SSH content" >file &&
+	git add file &&
+	git commit -S -m "SSH signed commit" &&
+	SSH_COMMIT=$(git rev-parse HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSSH 'round-trip SSH signed commit' '
+
+	git fast-export --signed-commits=verbatim ssh-signing >output &&
+	test_grep -E "^gpgsig sha(1|256) ssh" output &&
+	(
+		cd new &&
+		git fast-import &&
+		git cat-file commit refs/heads/ssh-signing >actual &&
+		grep "^gpgsig" actual &&
+		IMPORTED=$(git rev-parse refs/heads/ssh-signing) &&
+		test $SSH_COMMIT = $IMPORTED
+	) <output
+
+'
+
 test_expect_success 'setup submodule' '
 
 	test_config_global protocol.file.allow always &&
-- 
2.50.0.2.g875523421d

