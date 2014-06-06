From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 00/40] Use ref transactions
Date: Fri,  6 Jun 2014 15:28:38 -0700
Message-ID: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fl-0003Pw-61
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaFFWbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:36 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:40255 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-vc0-f201.google.com with SMTP id hq11so681296vcb.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2GeOl5yr26tgPTxqSdS05ExymKPuvRS0P5WJKzUPG7k=;
        b=oAdlA/DN1lI7Qn9gyhYYnNeCIdDD7eYXSNZNn9AYtjU/vYn6tYmyo/H053Jrw0sj0x
         sNoTvBIcOidxmXjghS+RP9k5rJILBCSa0erO94eA9Ne+OVKuzxT/UOLrQ9scNtYWQKy0
         v1gZ7pWnQMaEuONmUb/GeP9aQGBM3SXF4/6to1k5Q4NUNo2Y7WvInFbWz+cV7ilzp0yn
         2jNBB4UBmjbmOdADr3lIGK+8nZupwJMfEulEYHCL8DueS5U2pAXAo7Tes2KEMgHKxtgr
         Z9dRLBc6da8dGsbkeIxXrqzso9xs8GZkOwuBrtS+El3uvuf09KuEGpUOZ/0yaVYgJU5+
         PGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2GeOl5yr26tgPTxqSdS05ExymKPuvRS0P5WJKzUPG7k=;
        b=jqp/0tXRp5uYPcLo4C20HSkPY77wobc6w/nroZSeXx23VxIKAvgx4eTS3wxFaUai6y
         JMmNB44xOA88kwyN6YKZbBP7QmEisJBK9PmINy7MG5zBL/uQdihtqCvxP1B9ex/9sCUj
         JFsd3e4BAeBPwOOjV4JZbm5M6fDr88BH3s1ai9bChk4Zlj5cl+awPaSgiFu0lRYvRD5i
         jC4SsAXEJGhXDLPU10PMgAdYHqFouyV8BXAEhM8eQVV146Z5dA/TmNgsnCvRsfG+EWpG
         jLxaA/0C0gxdV9jehgdZ+9UZSRclbAffkXbUoSVHN8rbcForJKWprbis0ekQGwxXVdln
         VrtQ==
X-Gm-Message-State: ALoCoQlAPA4PoqQLKKWRuF/dMPgMLESwwv4ZPjiJW0H1g1f5BV7Zawqk2NuFBmbxmH4PZVBss3Vp
X-Received: by 10.52.170.145 with SMTP id am17mr4176766vdc.2.1402093761664;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751208vda.3.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4D7375A44EE;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E552AE09AC; Fri,  6 Jun 2014 15:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251006>

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

Version 14:
 - Remove the patch to pack the refs before rename. We do not need this
   with the reworked renames that will come 2 series later.
   The rename_ref changes are thus no longer part of this series.
Version 13:
 - This version should cover all of JNs suggestions on the previous series.
   If I missed anything I appologize.
...

Ronnie Sahlberg (40):
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
  update-ref: use err argument to get error from ref_transaction_commit
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
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: propagate any errno==ENOTDIR from _commit back to the callers
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static

 branch.c               |  30 +--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  36 ++--
 builtin/receive-pack.c |  32 +++-
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  34 ++--
 cache.h                |   2 +
 fast-import.c          |  54 ++++--
 lockfile.c             |  37 ++--
 refs.c                 | 500 ++++++++++++++++++++++++++++++++-----------------
 refs.h                 | 118 +++++++++---
 sequencer.c            |  24 ++-
 walker.c               |  58 +++---
 14 files changed, 641 insertions(+), 338 deletions(-)

-- 
2.0.0.582.ge25c160
