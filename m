From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Sun, 16 Jun 2013 14:15:10 +0530
Message-ID: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8cU-0001uf-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3FPIrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:08 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:54599 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3FPIrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:06 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1836471pbc.30
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CCkimqsU6HYKRYUYNg4dM/YOISbfp5vGU/ohLIb4ggk=;
        b=E9quzJEcfaA5DHTYvD6DcONmEmOuajfIpL2kTsIpZLcLmRhJ8wecv6aheaIlhrN5Mg
         ESJ8PZ3ZdU9L21+nXRBPDhBGz1nyJhWj8GsS5o7oMtD86HUltqlCPjXAgTZ2avXDiYz2
         V6he4WlEJhAvon7YsEW38WGwioWtmdKZ4bjRFirMr/+TykPpYoFpnTRWTQT+DCjnORCN
         6D/LwhNWi8L6SfVDK5DBatKsvDdfT5ggni7nkGAwJWAO0jn27P7ec82HDRn6LxtMTBUC
         HhzApdUDe5hhVlGdP0v0VKbAdoLgXXxvQ0u6fb5QdT2TWSc/Smrl0JWj+YziR9C1vpdD
         XfBw==
X-Received: by 10.68.166.229 with SMTP id zj5mr8904614pbb.167.1371372425375;
        Sun, 16 Jun 2013 01:47:05 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227994>

So after extensive discussions with Junio, I have updated [5/6] to
special-case rebase and rebase -i instead of dropping the "HEAD
detached from" message altogether.  Also, [1/6] includes two more
tests, as suggested by Junio.

Junio: The message is now the constant "rebase in progress; onto
$ONTO".  Feel free to tweak it before applying.

Thanks.

Ramkumar Ramachandra (6):
  t/checkout-last: checkout - doesn't work after rebase
  rebase: prepare to write reflog message for checkout
  rebase -i: prepare to write reflog message for checkout
  wt-status: remove unused field in grab_1st_switch_cbdata
  status: do not depend on rebase reflog messages
  checkout: respect GIT_REFLOG_ACTION

 builtin/checkout.c         | 11 ++++++++---
 git-rebase--interactive.sh |  2 ++
 git-rebase.sh              |  2 ++
 t/t2012-checkout-last.sh   | 34 ++++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh     | 37 +++++++++++++++++--------------------
 wt-status.c                |  7 ++++---
 6 files changed, 67 insertions(+), 26 deletions(-)

-- 
1.8.3.1.443.g4fd77b9
