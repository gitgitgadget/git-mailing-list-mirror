From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/11] Add transaction support for reflog
Date: Wed,  4 Jun 2014 11:57:41 -0700
Message-ID: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGO0-0007t0-77
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaFDS56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:57:58 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:56025 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbaFDS55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:57:57 -0400
Received: by mail-vc0-f202.google.com with SMTP id lc6so11020vcb.5
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v8NIeOrmx+aafgH8cVuZiEhdE4RUN+SjC9QqbZaW+Qw=;
        b=pknWXQNby0tke4aDlwF4+wQZseDkAagaSqzdh0ldlNc3MLWcQ3G3wt/uk+GGYWeyLm
         yUAsCaETXMlCORnveqdbu5EScYayZot2bRfMgs3XHpMLqEUcmT3ln4w5KpyW7PNBWD8K
         ckx2RFxl43csACYkDwyMbg+fonwsDpvInMshJynPmKWWgu5YVFBZ/qsw1oh7X++1jCU1
         gcDdTGU/RvsAtbfSM8XXz/9bdH3rb1M5a9aT8pmzhkawQq4K4u0bKfHKp4q7famFJhjH
         UxUsyD/NixxGfvGOxCfamP9Ug+XzhG8nxiXBUWnTfzs8hdql8EUN3BYkNAJ60Z1RBIgj
         htSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v8NIeOrmx+aafgH8cVuZiEhdE4RUN+SjC9QqbZaW+Qw=;
        b=Ghsx1jTNx+Zpd4qzUgtJruCQwbXDPobNudpw57xysnVtBwVDDelaCx/kiWKatWFtpT
         /CMEd99ixO/BUaAb4s4q+i7brKuX/SxheoxIn3mupVHKa1G8SmsuyjRXCJqo4YdLSqg9
         TEczXO5ZpBZDtUJ6ylD1vjdvQ2OHM1bjRXlhwHt1va2Mbw/zHAdm8561b9pN1JeNMBvs
         LC7lUzlQKuYm7p4UL1mwpBA/uuqLDWxQhM5RcbvbTm7iDZc3/cd25T31sdes7kyB4Y15
         53m9X48treNDU6ER1oKGgXOAK1zxGTZZleHq6Zqo0j0X2YegUWVep/wXOeGO3TF3fSNw
         tN6Q==
X-Gm-Message-State: ALoCoQlEiaqFq0LeKIXu8rDXsff5J3sQIJx7PF/vGbrLWWfdJ7sigxgo37IHyqJQWAE5AX/qxA8a
X-Received: by 10.236.123.68 with SMTP id u44mr19338347yhh.19.1401908276409;
        Wed, 04 Jun 2014 11:57:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si330863yhp.6.2014.06.04.11.57.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:57:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3F42431D63D;
	Wed,  4 Jun 2014 11:57:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CFA61E0887; Wed,  4 Jun 2014 11:57:55 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250759>

This patch series is based on the ref-transaction series and is available at
https://github.com/rsahlberg/git/tree/ref-transactions-reflog

This patch series adds transaction support for updating the reflog.

Ronnie Sahlberg (11):
  refs.c make ref_transaction_create a wrapper to ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a function to append a reflog entry to a fd
  lockfile.c: make hold_lock_file_for_append preserve meaningful errno
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire

 branch.c               |  11 +-
 builtin/commit.c       |  14 +--
 builtin/fetch.c        |  12 +-
 builtin/receive-pack.c |  14 +--
 builtin/reflog.c       |  84 ++++++-------
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  22 ++--
 copy.c                 |  20 ++--
 fast-import.c          |  23 ++--
 lockfile.c             |   7 +-
 refs.c                 | 317 ++++++++++++++++++++++++++++++++++++-------------
 refs.h                 |  64 ++++++----
 sequencer.c            |  12 +-
 walker.c               |  17 ++-
 15 files changed, 404 insertions(+), 233 deletions(-)

-- 
2.0.0.578.gb9e379f
