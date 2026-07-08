Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4A2DEA68
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555173; cv=none; b=A3Rq31R9q4+2jmL4457WAqzfvfs4mgk4kAadsXpcHZzV4BXwWG2j/vvcVWhwCHUY0R9nj/e76kpsv7Klu79jtmhxTLi0CGNw6QapXSQ5wH+8duAAsLb7ua4katCOQcqSyAaX3YuSi2vNb8D/rG2DW8UsrbYUvugZCGiazlV/H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555173; c=relaxed/simple;
	bh=jdZyOlAa1dU8LHhErdABhdg1M2qvyq1eNjPH58pQuh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1gLu8mbQCeXRtco+BrvUYlgyUlYfniLuRVUIeMwQGkzBPetxxxVXQtbDxEcqlHzwEkgg7GZx2/Ami8TAlxP9aQmtXHKmdIs1AlsczNcKrLgHsnvZUkhZnS7kLxL/30a/zpULN5OQVuIIufx/uMqQx0W3AwvEmEXh5c2uWv2UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG8wzB/j; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG8wzB/j"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb787dec99so731409a34.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555171; x=1784159971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0cV1lwq8d+VznRqnYnMW2RyQRAJ0RGmfiV/3p5BpdI=;
        b=YG8wzB/jzB6oPFhT7iPo050bc37T0pi2Je9vnKJ0AKsfaQtMJOuOxC636fw88hFK5o
         MIiEse98JEnaveUjCyRMtVVlv15ZNaQU29SiF4bb1G7QaRIfQ4ZFCGWW4QoUHDUR/Zrh
         pHGhdBX2lNNQ1j3JckjXmZMKnIfBhttWLyi3v6fOtSVvIDrcTmj6KNeTbtpprnxLtyqD
         6/q6rOljswuXQjDyRGHEMUnEhwZNBH+Yb+LwAmlkZCPl0xv2LE/HM9OOaiZlvNKVXSmZ
         osik1fVQP9oFlWd/18tNX9H6KqiveFLn25xQSFhpSgOPEPNYRSETASp9L7m34Al8po3b
         tLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555171; x=1784159971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0cV1lwq8d+VznRqnYnMW2RyQRAJ0RGmfiV/3p5BpdI=;
        b=D8TwEOdgvD4tu6Am0bQ2gXFr9Yhfjxc8V0Hs0tU3+cDm1C+H/zTGA+upOtrkP7Re15
         MnbrRqFGNbOS3x3r0dHaL0EpcCf5VxH3yf+wKxxQZtcy40bLEonunqZ7XIaKItLVkyMg
         N2OVMcx9RWC5yqDFMGTXDHg9g9kQST1gu9fzLhyos0dHDxYzD7bE0jMskTXeRLN4NVPm
         hhXsz3ldUTN0DGLle2hVuAqLy4ZfUDd+YRIDKqmNJFXK5Bigl0eUN/rTYYYzcsxuQ8Ot
         TMGaFa+ULs4TwwhxLDU71jnLmVj7DdDuqOnT54vLCNPnvS1DkHn2v827wRjEGNpurIj6
         0OPw==
X-Gm-Message-State: AOJu0YypOPnK/YSNxKY/yT1pcBV8cf4XwnzyENeuv0lywc7I2GEIH8rK
	hNB2+LLyJJerCnZ1/MzOQsJyQWUBNP9l/SkiD8aEoWzRA9FDxNqSvCxGhQZkTg==
X-Gm-Gg: AfdE7clhXqBYRMZmcakrpeIDCx7+e60odwUyho/uFPRA5NGDm/M3CzA2+Helck0du5c
	tczvZA0VYEZcqvdDTbamMpym2lrNGH314JHoajRqEK4afWxWlZ9mAw+hE1SOJL4zB8ugHgBGpjN
	VAN7eJSC9MpvqWUD6YttZ0CR6gKbvr8TPaS+LFZMoIojrRWo5FWcdT170XddU280gLG91yanfJF
	XL8fEdu+iTvW/nZft25hjW0wzDJwDRzbjwOQ+mRGa5iKNOcOmdWVFgTjOpgFg8ocR5GYHs7PIvx
	xNFml9dqDS5gtfwy8UtN4HIrnJdfb5vGVDBsgqTpF2P9pTJ8VvZwyUlS4IL0dgac0pN5OcsaHnd
	BbblNMK87fVGI4KiEysIJerOV4lb6vOkngbTEf8kvSghy3xddn+QqGFFTMy76Du4AN3PdpzSj05
	br/kRcddaK7Ve3QK/8qWPT
X-Received: by 2002:a05:6820:f023:b0:6a2:9bbd:367a with SMTP id 006d021491bc7-6a36d8735c1mr3578858eaf.12.1783555170894;
        Wed, 08 Jul 2026 16:59:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/11] receive-pack: use ODB transactions to stage object writes
Date: Wed,  8 Jul 2026 18:59:14 -0500
Message-ID: <20260708235925.3992097-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series replaces direct usage of the `tmp_objdir` interfaces
in git-receive-pack(1) to instead use the `odb_transaction` interfaces
to create/manage a staging area to write objects to. The purpose of this
change is to get git-receive-pack(1) one step closer to being ODB
backend agnostic. For now, the object writes themselves are still
"files" backend specific due to being handled by the git-index-pack(1)
and git-unpack-objects(1) child processes. This will be tackled in a
separate series though.

Changes since V2:
  - Clarified commit log reasoning for embedding
    `flush_loose_object_transaction()` logic in commit function.
  - Started printed some error messages on transaction errors.
  - Removed include statement.
  - Fixed transaction leak on `odb_transaction_commit()` error.

Changes since V1:
  - Adapted other "file" ODB transaction helpers to be more consistent
    with current naming scheme.
  - Removed redundant NULL transaction handling from
    `odb_transaction_files_begin()`.
  - `odb_transaction_begin()` now returns an error if there is already
    an inflight transaction pending instead of setting the `out` pointer
    to NULL.
  - Updated `odb_transaction_env()` to return an error code and append
    environment variables to a strvec provided as an argument.
  - Removed redundant setting of tmpdir environment variables for child
    processes after tmpdir has been migrated.
  - Split changes adding ODB transaction flags into a separate commit.
  - Consistently wire the ODB transaction throughout git-receive-pack
    code instead of reading it from `the_repository`.
  - Updated user facing error message.
  - Updated some comments to better document functions/flags.
  - Clarified some commit messages.
  - Fixed typos.

Thanks,
-Justin

Justin Tobler (11):
  object-file: rename files transaction prepare function
  object-file: rename files transaction fsync function
  object-file: embed transaction flush logic in commit function
  object-file: drop check for inflight transactions
  object-file: propagate files transaction errors
  odb/transaction: propagate begin errors
  odb/transaction: propagate commit errors
  odb/transaction: add transaction env interface
  odb/transaction: introduce ODB transaction flags
  builtin/receive-pack: drop redundant tmpdir env
  builtin/receive-pack: stage incoming objects via ODB transactions

 builtin/add.c            |   2 +-
 builtin/receive-pack.c   |  69 ++++++++---------
 builtin/unpack-objects.c |   2 +-
 builtin/update-index.c   |   2 +-
 cache-tree.c             |   7 +-
 object-file.c            | 159 +++++++++++++++++++++++++--------------
 object-file.h            |   8 +-
 odb/source-files.c       |   9 +--
 odb/source-inmemory.c    |   3 +-
 odb/source-loose.c       |   3 +-
 odb/source.h             |   9 ++-
 odb/transaction.c        |  32 ++++++--
 odb/transaction.h        |  59 ++++++++++++---
 read-cache.c             |   7 +-
 14 files changed, 241 insertions(+), 130 deletions(-)

Range-diff against v2:
 1:  9c14b219ad =  1:  9c14b219ad object-file: rename files transaction prepare function
 2:  5703a9e93b =  2:  5703a9e93b object-file: rename files transaction fsync function
 3:  4c37398ac8 !  3:  76204847f2 object-file: embed transaction flush logic in commit function
    @@ Commit message
         When a "files" transaction is committed,
         `flush_loose_object_transaction()` is invoked to handle performing a
         hardware flush along with migrating the temporary object directory into
    -    the primary. In a subsequent commit, the temporary directory is also
    -    used to write packfiles.
    +    the primary and configuring the repository ODB source accordingly. The
    +    function name here is a bit misleading because the helper is doing a bit
    +    more than just "flushing" the transaction contents. Also, in a
    +    subsequent commit, the transaction temporary directory is used to stage
    +    packfiles and not just loose objects anymore.
     
    -    Instead of maintaining a separate helper function, embed the logic to
    -    flush and migrate the temporary directory directly into
    -    `odb_transaction_files_commit()`.
    +    Lift the helper function logic directly into
    +    `odb_transaction_files_commit()` to more accurately signal to readers
    +    the operation being performed.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
 4:  623c6b02ea =  4:  c97eb7763f object-file: drop check for inflight transactions
 5:  ca59176657 !  5:  1f3a1f7714 object-file: propagate files transaction errors
    @@ object-file.c: static void odb_transaction_files_prepare(struct odb_transaction
     -	if (transaction->objdir)
     -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
     +	if (!transaction->objdir)
    -+		return -1;
    ++		return error(_("unable to create temporary object directory"));
     +
     +	tmp_objdir_replace_primary_odb(transaction->objdir, 0);
     +
    @@ object-file.c: static void odb_transaction_files_commit(struct odb_transaction *
      		 */
     -		tmp_objdir_migrate(transaction->objdir);
     +		if (tmp_objdir_migrate(transaction->objdir))
    -+			return -1;
    ++			return error(_("unable to migrate temporary objects"));
     +
      		transaction->objdir = NULL;
      	}
 6:  717a1ce9a7 !  6:  09d13272d5 odb/transaction: propagate begin errors
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     
      ## odb/transaction.c ##
     @@
    + #include "git-compat-util.h"
    ++#include "gettext.h"
      #include "odb/source.h"
      #include "odb/transaction.h"
      
    @@ odb/transaction.c
     +
      	if (odb->transaction)
     -		return NULL;
    -+		return -1;
    ++		return error(_("object database transaction already pending"));
      
     -	odb_source_begin_transaction(odb->sources, &odb->transaction);
     +	ret = odb_source_begin_transaction(odb->sources, out);
    @@ odb/transaction.h
      #ifndef ODB_TRANSACTION_H
      #define ODB_TRANSACTION_H
      
    -+#include "git-compat-util.h"
     +#include "gettext.h"
      #include "odb.h"
      #include "odb/source.h"
 7:  ff8e133965 !  7:  12833d6773 odb/transaction: propagate commit errors
    @@ odb/transaction.c: int odb_transaction_begin(struct object_database *odb,
      
     -	transaction->commit(transaction);
     +	ret = transaction->commit(transaction);
    -+	if (ret)
    -+		return ret;
    -+
      	transaction->source->odb->transaction = NULL;
      	free(transaction);
     +
    -+	return 0;
    ++	return ret;
      }
      
      int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 8:  264ba94b83 =  8:  f2586f2f34 odb/transaction: add transaction env interface
 9:  1e0a491ef2 !  9:  9d082b5e47 odb/transaction: introduce ODB transaction flags
    @@ object-file.c: static int odb_transaction_files_prepare(struct odb_transaction *
     -	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
     +	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix);
      	if (!transaction->objdir)
    - 		return -1;
    + 		return error(_("unable to create temporary object directory"));
      
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
      			int inflight = !!transaction;
    @@ odb/transaction.c
      	int ret;
      
      	if (odb->transaction)
    - 		return -1;
    + 		return error(_("object database transaction already pending"));
      
     -	ret = odb_source_begin_transaction(odb->sources, out);
     +	ret = odb_source_begin_transaction(odb->sources, out, flags);
    @@ odb/transaction.c
     
      ## odb/transaction.h ##
     @@
    - #include "git-compat-util.h"
    + 
      #include "gettext.h"
      #include "odb.h"
     -#include "odb/source.h"
10:  6c8d878349 = 10:  e11d8a6676 builtin/receive-pack: drop redundant tmpdir env
11:  8db95fef56 = 11:  fee57c2817 builtin/receive-pack: stage incoming objects via ODB transactions

base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
2.55.0.122.gf85a7e6620

