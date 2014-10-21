From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/15] ref-transaction-rename
Date: Tue, 21 Oct 2014 13:36:45 -0700
Message-ID: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBS-0000o9-7O
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbaJUUhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:06 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:57152 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529AbaJUUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:04 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so306388oif.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cTdAtL1Zrk2sBSYUXRTta5zyPzpXX3UkST6sVsPTmCA=;
        b=pZR/sizi7arK8S52JJhj3LoebrHxQ5cZ7M0TUlymO+f69K5Y764hGDo71h1+tRNuGj
         g+IPVTzCgA4Tfgw4bUaRuMa5RIB0zYGw9p7ETbPf80oGgb+hynjUVPErlirm1qlp/o3P
         VY2ZgHxr09kkrKrtI0vzhS4SNzwrWQBJdz5hHQDbeQ19dqV10bqpjTdTibiVSxj9iG+w
         kwyD8AX0tmRzEmJ0rwqC5j9v2n86Lfvaaj9bVL/N8MbMOIv1WpVSzpg0GVOk+FZpowN3
         lXeNRIsF4Iwwo0yIOFnFjAn2Z5CRFBncjlnUDxiIKb6oGeRGP+sz8vA4xTqESsGp+05f
         OZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cTdAtL1Zrk2sBSYUXRTta5zyPzpXX3UkST6sVsPTmCA=;
        b=RYcgkUJzza9j8ZVwDhGL6S6T/7Tt0Y51sx28v9e4v904Sv/nt+lvnaUjXAqq3BwXQu
         ZjGEB47nOCVqbHYMHvXZRedd6/Eqo7acCI2hw2KL6ADMsL/+RoJW75y7W4zvJQrtrsh6
         k3cc3XkQL0AtaNDSoTQdbWultcMUnMNpaB/Yu/7wtFR8NdD7uN5XZKXl2jkMV3HT7ZUI
         j2NIKvAn/NoEA+lxQncv1O0D69uZg1+dPwwL09AYwLNOQgi9Eo1fksyb+iOjTNesFc2v
         YSVxE8VIZ5w5Kkle/gtLxEnzIwqFnIhaEcrrnpwTv14t1rM8OflXU6SiUrKYWXe+rnxv
         ydQw==
X-Gm-Message-State: ALoCoQlI+AdiAKatKHYflXBKPAAiIlo7R9DQjm2ilPA/YTn0d4lV6TLiOJUPw41BW9Hc89jApVaK
X-Received: by 10.50.134.166 with SMTP id pl6mr499797igb.6.1413923823188;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si596477yhf.0.2014.10.21.13.37.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 6KoyYKzW.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7688AE0BD6; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

Thsi series builds on the previous series : ref-transaction-reflog
as applied to next. This series has been sent to the list before
but is now rebased to current git next.

This series can also be found at :
https://github.com/rsahlberg/git/tree/ref-transactions-rename

This series converts ref rename to use a transaction. This addesses several
issues in the old implementation, such as colliding renames might overwrite
someone elses reflog, and it makes the rename atomic.

As part of the series we also move changes that cover multiple refs to happen
as an atomic transaction/rename to the pacekd refs file. This makes it possible
to have both the rename case (one deleted ref + one created ref) as well
as any operation that updates multiple refs to become one atomic rename()
applied to the packed refs file. Thus all such changes are now also atomic
to all external observers.


Ronnie Sahlberg (15):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: use a stringlist for repack_without_refs
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static
  refs.c: replace the onerr argument in update_ref with a strbuf err
  refs.c: make add_packed_ref return an error instead of calling die
  refs.c: make lock_packed_refs take an err argument
  refs.c: add an err argument to pack_refs

 builtin/checkout.c    |   7 +-
 builtin/clone.c       |  36 ++--
 builtin/merge.c       |  20 +-
 builtin/notes.c       |  24 ++-
 builtin/pack-refs.c   |   8 +-
 builtin/reflog.c      |  19 +-
 builtin/remote.c      |  69 +++---
 builtin/reset.c       |  12 +-
 builtin/update-ref.c  |   7 +-
 notes-cache.c         |   2 +-
 notes-utils.c         |   5 +-
 refs.c                | 568 +++++++++++++++++++++++++++++---------------------
 refs.h                |  71 +++----
 t/t3200-branch.sh     |   7 -
 t/t5516-fetch-push.sh |   2 +-
 transport-helper.c    |   7 +-
 transport.c           |   9 +-
 17 files changed, 500 insertions(+), 373 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
