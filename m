Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35841A80
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594177; cv=none; b=g8uT4JODF9SvPbxhHhiD8HBmz3osInXhbZHLUkWD7inGWVnvEmmtg29fh2l2+dgoi2s2xEfcSq+25F+caZyr3+IfHA/yD/ENAXyysflFod2UD+HGn4O8bjh4JNYV03IgHG+nAW+jQynlTMmDNnA/4+iR57UDAfYTjgG0YLo/QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594177; c=relaxed/simple;
	bh=0c8uPffODKlmSH08Ta2EBndqFdcW+Ckmn+xz0HffdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz0Lv0N/kCGXoGI++TmZt9u2BvR2BRkNMCUV94PHsyKLl4DnhVkHGE06BB3W8znjxeoEFG5/G2dKNXTmHmmEL4BtkJ/i+i0ocomiRP8jh7Qx3uuBUCtf4NUGrELVphZVpEmzjVqBrv4l2sS1XYRyg+KV2wwOYT2y/s/ZPQH96yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1SO5RHH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1SO5RHH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so2642229a91.2
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594174; x=1728198974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJF8VeQL2HjnDfKySzYq6faytJz2JwQhTx1KTxguLek=;
        b=W1SO5RHHJGUpQOCyxSVrIAL8E3RIMLiTgVQVCjYiig+LnlgkBAv5R89kgqLzIOzHq7
         yOCsEstyIEejxVFiev9J53HXk6qb9b2n3dT9UPdn9jS/2KQWXnKuH1acQc0RYr/5F5sK
         vnTRFo31Z6FLuyKzD3ZfsWMnLwi1VZX0heP2Sfcb1sQVafV3qi5duFxq+/ie4PDWTsmQ
         2/JGAHFmoW/seAaj3pvaqwv4/++KZMBsvGNzpYmRxyATz3sYHk+ygC4ytPXWUZOKeaxW
         VvAbUvx1vJzioZaypt2zuWpx1/5Cnr1ihglYBgdQy+czQJVwpPQKbGMhx1TeaAnNeym2
         2Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594174; x=1728198974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJF8VeQL2HjnDfKySzYq6faytJz2JwQhTx1KTxguLek=;
        b=oqNVuoSxboiXBYhj5fV971exkUPzGxAVKs/CLSyyo7+d8xgG2hl6+gRDN9nrDF3ZEt
         TfWqwKSIHAckLQQidaEMJwOxR5ZzLnl9y3PDGAmuiNTLeTW2te76K8XguGVSi0WlnQMj
         EUQrVx2bAePOkjw+v2x1ts5jufgQFqFwt6tv+C4VBs6k3yp+Jj2RXH0CAP7yXCGBR2Tv
         P2NcpqjZuSwAdsghqt4GNox3e1vkzni/1yojKpCPuLopR+DtNjH/ku6SfbFfK+rDjRuf
         /jcSYsgileF7+Sq2iBhwtTVqZAfGQTUuYFiXU+hh0C0WO0XKR7Tt7BXK850RngAKIUu4
         /MRw==
X-Gm-Message-State: AOJu0Yyqn1b0COHOrYTEei4MNleduDY3nXyJLxKVu+2hJo5FGgybSws9
	oqkRsjEcab6qx7ZZvERRO/4GBilNlA/Rs3bEIq6yrtucLuTT6H2RClmg4g==
X-Google-Smtp-Source: AGHT+IHS5+l0qBAuEl7hpn0agWcjmq4gHrQP9jSAeU0DqqHu2c7cyV8A9SygK+dGoEUV7zJDLLvqxw==
X-Received: by 2002:a17:90a:f991:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2e0b8d5b0fdmr10343167a91.24.1727594174429;
        Sun, 29 Sep 2024 00:16:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c73ec3sm5289966a91.17.2024.09.29.00.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:16:13 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:16:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/9] ref: add basic symref content check for files backend
Message-ID: <Zvj-vbvQym1R4KJk@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

We have code that checks regular ref contents, but we do not yet check
the contents of symbolic refs. By using "parse_loose_ref_content" for
symbolic refs, we will get the information of the "referent".

We do not need to check the "referent" by opening the file. This is
because if "referent" exists in the file system, we will eventually
check its correctness by inspecting every file in the "refs" directory.
If the "referent" does not exist in the filesystem, this is OK as it is
seen as the dangling symref.

So we just need to check the "referent" string content. A regular could
be accepted as a textual symref if it begins with "ref:", followed by
zero or more whitespaces, followed by the full refname, followed only by
whitespace characters. However, we always write a single SP after "ref:"
and a single LF after the refname. It may seem that we should report a
fsck error message when the "referent" does not apply above rules and we
should not be so aggressive because third-party reimplementations of Git
may have taken advantage of the looser syntax. Put it more specific, we
accept the following "referent":

1. "ref: refs/heads/master   "
2. "ref: refs/heads/master   \n  \n"
3. "ref: refs/heads/master\n\n"

When introducing the regular ref content checks, we created a new fsck
message "unofficialFormattedRef" which exactly represents above
situation. So we will reuse this fsck message to write checks to info
the user about these situations.

But we do not allow any other trailing garbage. The followings are bad
symref contents which will be reported as fsck error by "git-fsck(1)".

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

And we introduce a new "badReferent(ERROR)" fsck message to report above
errors by using "ref.c::check_refname_format". But we cannot just pass
the "referent" to this function because the "referent" might contain
some whitespaces which will cause "check_refname_format" failing.

In order to add checks, we will do the following things:

1. Record the untrimmed length "orig_len" and untrimmed last byte
   "orig_last_byte".
2. Use "strbuf_rtrim" to trim the whitespaces or newlines to make sure
   "check_refname_format" won't be failed by them.
3. Use "orig_len" and "orig_last_byte" to check whether the "referent"
   misses '\n' at the end or it has trailing whitespaces or newlines.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 40 +++++++++++++++
 t/t0602-reffiles-fsck.sh      | 97 +++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index e310b5bce9..e0e4519334 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,6 +28,9 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badReferent`::
+	(ERROR) The referent of a ref is invalid.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 7420add5c0..979d75cb53 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REFERENT, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b2a790c884..57ac466b64 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3508,6 +3508,43 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_ref_report *report,
+				    struct strbuf *referent)
+{
+	char orig_last_byte;
+	size_t orig_len;
+	int ret = 0;
+
+	orig_len = referent->len;
+	orig_last_byte = referent->buf[orig_len - 1];
+	strbuf_rtrim(referent);
+
+	if (check_refname_format(referent->buf, 0)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_REFERENT,
+				      "points to invalid refname '%s'", referent->buf);
+		goto out;
+	}
+
+
+	if (referent->len == orig_len ||
+	    (referent->len < orig_len && orig_last_byte != '\n')) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+				      "misses LF at the end");
+	}
+
+	if (referent->len != orig_len && referent->len != orig_len - 1) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+				      "has trailing whitespaces or newlines");
+	}
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *refs_check_dir,
@@ -3559,6 +3596,9 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "has trailing garbage: '%s'", trailing);
 			goto cleanup;
 		}
+	} else {
+		ret = files_fsck_symref_target(o, &report, &referent);
+		goto cleanup;
 	}
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 2f5c4a1926..718f6abb71 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -273,4 +273,101 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline-1: unofficialFormattedRef: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-2: unofficialFormattedRef: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-3: unofficialFormattedRef: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: has trailing whitespaces or newlines
+	EOF
+	rm $branch_dir_prefix/a/b/branch-complicated &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferent: points to invalid refname '\''refs/heads/.branch'\''
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err
+'
+
+test_expect_success 'textual symref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferent: points to invalid refname '\''refs/heads/.branch'\''
+	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-complicated: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-1: unofficialFormattedRef: misses LF at the end
+	warning: refs/heads/a/b/branch-trailing-2: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/a/b/branch-trailing-3: unofficialFormattedRef: has trailing whitespaces or newlines
+	warning: refs/heads/branch-no-newline-1: unofficialFormattedRef: misses LF at the end
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.2

