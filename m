From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] nd/branch-show-rebase-bisect-state updates
Date: Sun,  3 Mar 2013 16:41:16 +0700
Message-ID: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 10:41:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5Pi-0000Zx-82
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab3CCJkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:40:33 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:33231 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3CCJka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:40:30 -0500
Received: by mail-da0-f42.google.com with SMTP id n15so2071369dad.29
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Wz4eVrffxNKLYYrTPPNrIb1CM3DKBTZrn54zP05cdcE=;
        b=gkfE88ffCBCy4yfk6OJduLy7mRqvUKtIkkne9pWROx7HfICuuE8AAYm86RRAzG0xHW
         zRK/oBjvcb5h+yU+IYVePOZOZpdzzTpb1dSabvPcQf3zkhRpdIprxJO0B/pvg+8n2pgg
         u360W+rL2WLq4ukxFxRQf6/jbGQbyN451R4xpmlRBVLBxwU7KV8+NPMdcl8b7sfXOS+F
         5qeP4RbLcsRHRAaBQpaRVXy0bwO+gdMdyyk72QEHhORC1u8p0z80obYDbl0vVrBclEwF
         4e8dbXG2WZ6YXUth7lkj2/UiqjJZ9lJRg4/vTDO3NL0Ib4T5TdG89WSU3Uf1ciyT2n2h
         Aykw==
X-Received: by 10.66.9.2 with SMTP id v2mr27053790paa.18.1362303629790;
        Sun, 03 Mar 2013 01:40:29 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id e6sm19670067paw.16.2013.03.03.01.40.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:40:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:41:32 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217342>

This round addresses the code sharing issue in the previous round and
shows a bit more info in both git-status and git-branch. Now when you
do "git checkout v1.8.0" or "git checkout origin/master", you should
see that ref in status/branch output, in addition to detached HEAD
status.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  checkout: record full target ref in reflog
  wt-status: split wt_status_state parsing function out
  wt-status: move wt_status_get_state() out to wt_status_print()
  status: show the ref that is checked out, even if it's detached
  branch: show more information when HEAD is detached

 builtin/branch.c            |  25 +++++++-
 builtin/checkout.c          |  19 +++++-
 t/t6030-bisect-porcelain.sh |   2 +-
 wt-status.c                 | 139 ++++++++++++++++++++++++++++++++++--=
--------
 wt-status.h                 |   6 +-
 5 files changed, 152 insertions(+), 39 deletions(-)

--=20
1.8.1.2.536.gf441e6d
