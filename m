From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] ref-transactions-rename
Date: Fri, 25 Jul 2014 09:58:36 -0700
Message-ID: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAipb-0005al-CT
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934641AbaGYQ6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:58:50 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:61301 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbaGYQ6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:58:48 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so1282094oac.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TkKMSor8pUCKBLmsmVxKLo8DIJ6NO+gWXChseNYTZcA=;
        b=RDT+cf2HXZKnAseI5ZJT19hknFy7ZPbJY9UbM2zSBFdpFd1+0ZtoAAHmd8QMSmgpcd
         ThJ1w41ulxP6CNNwWe0G5MIS1PbWz/F8tIUwcW8JX6MtHdy/zhjiLiWXVhShkkemIswr
         RoJoqmmBCPGIBAmqrLMR0e/ExOzR7qIzIuzkFlqcHmhmi7s7S3puWteYBBl8CwW18O6x
         5GYJaFw/nSDkNGFRYmytEAnIBXswzAJG9Jb3eRbWh2m/9qr1QLVcTFQXX5gO2/vLdRxR
         dI1/XinQJ59NnbDi+5+DpZF60APY4tBKWce7ou0xcHeJ0MMAG8aFKN3kM+g2hK5FEna9
         SKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TkKMSor8pUCKBLmsmVxKLo8DIJ6NO+gWXChseNYTZcA=;
        b=BP6uMT0HKBhstw+MQxNuVkj4MoA1dVTGaHmsimcVEJTLMaZm8o3gO3NhWEvUtzWpAb
         uABkP4kQ6WalIDYomjCKLW3Q0ZYKTocOe8GzzWxGgTaCG7Dw/8rB9VG6UUzcqJF9inJy
         s8CowoJDWsWlUCWhoGCApxjyRTZcwwOHIOfkZdjag3nwCmXZ5+eLAW58ncESf9YUnLnJ
         5y6uh+/mEITTyR1oDqp/+FLrVwOX08BOkHd3lN708CqD5rgNOWa0+c9tutdJDjgbxoD7
         3eL5eTFNHXDwlwjgYlqQPsttb6YHYFVUJVlC/O+QBrIdPW6yjwxfKxgPpQu0U8PXeqKy
         mXTQ==
X-Gm-Message-State: ALoCoQlmR1T1gCqOnvPRvYOveHxVIWi85PamXwGLywEkdIAj0zF/mEttx4QPKR1gsBC9qk8x7dN8
X-Received: by 10.183.10.133 with SMTP id ea5mr8838158obd.24.1406307528245;
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1291206yhp.6.2014.07.25.09.58.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0B1865A42F2;
	Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 99013E0A75; Fri, 25 Jul 2014 09:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254233>

This patch series adds support for using transactions and atomic renames.
It focuses on what needs to be done in order to support fully atomic
and rollbackable renames that may or may not involve name conflicts.

By performing the actual delete old/create new via a single operation to
the packed refs file this process will also appear as an atomic change for
any external observers.

(While this series is "short" it contains a very important change where
we start performing ref changes as operations inside a locked packed refs
file instead of as discreete operations of loose ref files.
This approach will be extended in the next patch series where we will start
using it also to make multi-ref creations/updates become fully
atomic for external observers.)


This series is built on iand depend on the previous reflog series:
  * rs/ref-transaction-reflog (2014-07-23) 15 commits
   - refs.c: allow deleting refs with a broken sha1
   - refs.c: remove lock_any_ref_for_update
   - refs.c: make unlock_ref/close_ref/commit_ref static
   - refs.c: rename log_ref_setup to create_reflog
   - reflog.c: use a reflog transaction when writing during expire
   - refs.c: allow multiple reflog updates during a single transaction
   - refs.c: only write reflog update if msg is non-NULL
   - refs.c: add a flag to allow reflog updates to truncate the log
   - refs.c: add a transaction function to append a reflog entry
   - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
   - refs.c: add a function to append a reflog entry to a fd
   - refs.c: add a new update_type field to ref_update
   - refs.c: rename the transaction functions
   - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
   - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
   (this branch uses rs/ref-transaction and rs/ref-transaction-1.)


Ronnie Sahlberg (5):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs

 builtin/remote.c  |  13 +-
 refs.c            | 369 +++++++++++++++++++++++++++++-------------------------
 refs.h            |   1 +
 t/t3200-branch.sh |   7 --
 4 files changed, 210 insertions(+), 180 deletions(-)

-- 
2.0.1.508.g763ab16
