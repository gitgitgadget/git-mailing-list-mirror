From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 00/41] Use ref transactions
Date: Tue, 27 May 2014 13:25:19 -0700
Message-ID: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNws-0001gi-2E
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaE0U0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:08 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:35722 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so1646805yha.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aMAuBPw5nqh1FAzAhfSQGTTWo4RvtozPkHEqdy4WNyE=;
        b=DpPwF78KL/WmI5zVgT2W/7rjOh+/mX8Mc6qkWlABbMpF33LFHwo+X8vKgjwms23FJr
         eBpke/7KaDbAYPTrz04vBxHNLCuI1NZQzKgjXzdlVfVIYqsPM8P/qdleuQmB/WsAbLp+
         eYe/KzhapxLdFtM95k/F4W706wNg3Jozi6P3h74cEfldxMN+vk7LzArET+1uc28yDBjM
         5tGPeOzM+76nGubfob99ftWjYs3UQe5vIIq0JR0B6gCgB9shUlEmIB1ybrm3bH5n/cJc
         xYjYUO9Z+nKMskHyhnnqc9TKszj5mZ77/C+SkmSXmBmoqGOJs4yB82CPpk2Uzk6L63xg
         ADFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aMAuBPw5nqh1FAzAhfSQGTTWo4RvtozPkHEqdy4WNyE=;
        b=Dbaf9ejlEFs++Y0ICS0byUM03FEF5sPAzVYosieRZjUJchMzLf3VQFyY+3ljC4uEcZ
         /ZT8hxJFbocoB5DEpNHC6Kx4ON6zbFZTtr/DL3bornR++4uf1YFuuDTk1r2w2cVJQs7p
         PKTCQIqZq/YwqQg9701WeqSkf1kWoDhjrtgeTrbmMvTIgwkbWysrvBBQ6gaNDoV1QdrT
         /kRsYurRFPMrbxY8NlAdfHDD2r0iV1GCmImlQTh0W6aPrg3arSztfnaMiLRv40aq6FfI
         IAYIGzebyG29vKlmDzQRrL1loPIL+lKsb+EJsZyjNxKesrRrkmCUnQ/mLtAIExj6+N3D
         t1+A==
X-Gm-Message-State: ALoCoQm6NfwgtGBJhSm5Fq3kQ+BPXOHMc6IJi6bYOcN0TU9CfsCMbKIGBtAO74PirYJonfEQE/oC
X-Received: by 10.236.92.204 with SMTP id j52mr12674798yhf.26.1401222363719;
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1574919yhk.4.2014.05.27.13.26.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 797AE2F4AB9;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 131DFE0DE4; Tue, 27 May 2014 13:26:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250197>

This patch series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions


This patch series is based on next and expands on the transaction API. It
converts all ref updates, inside refs.c as well as external, to use the
transaction API for updates. This makes most of the ref updates to become
atomic when there are failures locking or writing to a ref.

This version completes the work to convert all ref updates to use transactions.
Now that all updates are through transactions I will start working on
cleaning up the reading of refs and to create an api for managing reflogs but
all that will go in a different patch series.

Version 11:
 - Updates after JNs review of the series.

Ronnie Sahlberg (41):
  refs.c: remove ref_transaction_rollback
  refs.c: ref_transaction_commit should not free the transaction
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  refs.c: add an err argument to repack_without_refs
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  refs.c: add an err argument to delete_ref_loose
  refs.c: make update_ref_write update a strbuf on failure
  update-ref.c: log transaction error from the update_ref
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: update ref_transaction_delete to check for error and return
    status
  refs.c: make ref_transaction_begin take an err argument
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make lock_ref_sha1 static
  refs.c: remove the update_ref_lock function
  refs.c: remove the update_ref_write function
  refs.c: remove lock_ref_sha1
  refs.c: make prune_ref use a transaction to delete the ref
  refs.c: make delete_ref use a transaction
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: pack all refs before we start to rename a ref
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: propagate any errno==ENOTDIR from _commit back to the callers
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static

 branch.c               |  30 ++--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  25 +--
 builtin/receive-pack.c |  44 ++++--
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   2 +
 fast-import.c          |  42 +++--
 lockfile.c             |  21 +--
 refs.c                 | 420 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 |  80 ++++++----
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   6 +-
 walker.c               |  55 ++++---
 15 files changed, 531 insertions(+), 306 deletions(-)

-- 
2.0.0.rc3.474.g0203784
