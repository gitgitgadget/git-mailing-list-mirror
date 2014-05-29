From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 00/44] Use ref transactions for all ref updates
Date: Thu, 29 May 2014 09:07:42 -0700
Message-ID: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sM-0006TU-BO
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbaE2QII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:08 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:55831 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaE2QH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:07:59 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so105238oag.3
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/ToPhx9ZU9cajrZyUXMRDE8CXfy7b4KlzL8t4ggNdYM=;
        b=ph1LektiWGn8r0T/n06wfeFmdstiXBNNUsmZ3HoFVqTdB7sQe4LQqVjyPjncdDRT0Z
         1lPoVJGyf9aEefqAm3viNF8TaTCUzmpiQro2w+nWfzLmeewZqTrG01Poz7wIxguSxdnR
         cWZHLB+JVW1YI1FIFLk8B2mDffDZb3CH2/P41SeGjbde6RzpqjiZTU/0qyv3NFhWdK/8
         5rPy5cO3rLI5NUJB2rdgpQu1ClRCV8k7kFtcibBQ0bqQ2s+lXRL2u9a4SPwFoUG0WAav
         gM40ClDeq70e4uTqYibBRDu4WcDt3JBDWHOdtWZJn+OitkTQ6htGCtFpXbK7aXH8TpJS
         9hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ToPhx9ZU9cajrZyUXMRDE8CXfy7b4KlzL8t4ggNdYM=;
        b=PJyZ7TUOT7k4wu+kowBfVEplwJ+sZWinW+2uzE76eKn3DiAYZEdXddtxWTxA5sbRTq
         /3KM/aZ10n9EXU+ijwAWQmgXfIsaRerNrXT5oxS4Vb2+440IDD9WF/ZobNCuEFTIPQUE
         R9ScvD866Edg8RNZA5MU0ZK5sRQ6idr1cP0TZ7/241HtKh7pI0HG553gHM1PLUXHRz0H
         Jw2+ysp//fq/4fx0fn0rouJ2org1qQmfvhMrUGIFGS2qrSjhou29XfpwHXZ/P+1GgrmO
         bBERd6mebdOYnp3WDPyX7Gx7TOfEKyK4moibS+v29b60ltM9pZlz2JNkaxCUOCS4d8xB
         LMRw==
X-Gm-Message-State: ALoCoQl60XBnMiH1+a5vr2apMNLJ0wGDj/Dhm0FjuEZupzFqdN8j8XjqGvWuCpfV1w2vsNMfV+0f
X-Received: by 10.182.73.200 with SMTP id n8mr3558321obv.33.1401379679109;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h13si82904yhj.0.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ED34431C3F1;
	Thu, 29 May 2014 09:07:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8D40AE0DDD; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250377>

This patch series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions


Ronnie please review these remaining patches in this series.


 Sahlberg (44):
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
  refs.c: ref_transaction_delete to check for error and return status
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  refs.c: free the transaction before returning when number of updates
    is 0
  refs.c: ref_transaction_commit should not free the transaction
  fetch.c: clear errno before calling functions that might set it
  fetch.c: change s_update_ref to use a ref transaction
  fetch.c: use a single ref transaction for all ref updates
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make write_ref_sha1 static
  refs.c: make lock_ref_sha1 static
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
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
  refs.c: add a new flag for transaction delete for refs we know are
    packed only
  refs.c: pass a skip list to name_conflict_fn
  refs.c: make rename_ref use a transaction
  refs.c: remove forward declaration of write_ref_sha1

 branch.c               |  30 ++--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  29 +--
 builtin/receive-pack.c |  21 +--
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  32 ++--
 cache.h                |   2 +
 fast-import.c          |  42 +++--
 lockfile.c             |  21 ++-
 refs.c                 | 468 +++++++++++++++++++++++++++++--------------------
 refs.h                 |  54 +++---
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   2 +-
 walker.c               |  51 +++---
 15 files changed, 491 insertions(+), 339 deletions(-)

-- 
2.0.0.rc3.510.g20c254b
