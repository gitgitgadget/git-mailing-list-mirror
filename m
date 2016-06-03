From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/6] worktree lock/unlock
Date: Fri,  3 Jun 2016 19:19:38 +0700
Message-ID: <20160603121944.28980-1-pclouds@gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5G-0002oe-MR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbcFCMUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:09 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33456 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcFCMUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:07 -0400
Received: by mail-pa0-f41.google.com with SMTP id ec8so8495488pac.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+SDtobQ0hrr6+CexQh16IwcK6WI6PGcPqrKcQsebx4=;
        b=XllTOcnwV2w78CcoD5+1AdM5mzc+RzvBGCRSC+X/E+QOGMlu8GLifA8rcbufkzufqO
         TwyTYVEbglKLPXLYbNScKR2cvJl+2v2XL5XBSrO6U6s2FiHIBBA6/pe3nhjsP8gXE8iL
         t1VSqDaNvvnpHF5eWTPy9El7lqClNjXCIdf6B4WMBB+PTM0dY6YR77ycB/a6K1G+rD7A
         tP0dMvXGh4LY7L0P1Luo+qxTaO3u6m3x5Tc+i9DPum6/wQAUYdMwjklI+znwUZqaRwQy
         BqZgNE7DtfFDF3An2EpmSBhWG7nk8Fhb6Bz+EM1a2LdxucYQUtJXQlIUr+K6rGlWF8+p
         ibqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+SDtobQ0hrr6+CexQh16IwcK6WI6PGcPqrKcQsebx4=;
        b=QzHkf661/AV0eHxUByOw5OpTztKJA6+Dsx5COCll+vFsJ9QVE3+ge+bu6G/bv97M6L
         Jgyr0xunDYsUnEC/ddO6gAnFIBATeROJeRvUqLY4w05Q42bNjcEVLIpUC2mrl1SSamzZ
         DIAKpEVDW2gJa/Y2x9EJLUflem9MQFxOj8FyY+xyt8iW7Waoejaetm88Jioc2KbEFlLW
         Z2p6JoRzj+vUdw85bGtTNk4Sv5hsEblw4vffHaRsBpnPPtoVuEFpdv45C/cZUIlsYMOo
         pFgczAUnvt2FcA5EpzlywPAkuKGVPXxuZJeKAYSxD9YuivYvLJI0buRNlbZ+sfa+ZprD
         T9pA==
X-Gm-Message-State: ALyK8tIBZMVR0eZe2FlSo+J1j3S6eWyZZnCW62zCahHOnTAMRXRTiRp2799mGYsEnRg0jg==
X-Received: by 10.66.221.66 with SMTP id qc2mr4909096pac.147.1464956406454;
        Fri, 03 Jun 2016 05:20:06 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id t65sm8225802pfj.4.2016.06.03.05.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296307>

v4

 - fixes some documentation bugs in v3

 - updates is_main_worktree commit message a bit

 - brings back is_worktree_locked() as API with value lazily obtained
   and cached in worktree->lock_reason and fixes a memory leak

 - extends basename search to path suffix search. I moved this patch
   to the bottom so that the relevant documentation part is included
   in the patch (previously it was part of the "add lock command"
   patch).

This series is based on nd/worktree-cleanup-post-head-protection

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  worktree.c: add find_worktree()
  worktree.c: add is_main_worktree()
  worktree.c: add is_worktree_locked()
  worktree: add "lock" command
  worktree: add "unlock" command
  worktree.c: find_worktree() search by path suffix

 Documentation/git-worktree.txt         | 36 +++++++++++++---
 builtin/worktree.c                     | 66 ++++++++++++++++++++++++++=
++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh (new +x)      | 62 ++++++++++++++++++++++++++=
++
 worktree.c                             | 75 ++++++++++++++++++++++++++=
++++++++
 worktree.h                             | 20 +++++++++
 6 files changed, 257 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

--=20
2.8.2.524.g6ff3d78
