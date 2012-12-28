From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/9] fnmatch replacement step 1
Date: Fri, 28 Dec 2012 11:10:45 +0700
Message-ID: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:11:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRI4-0000bF-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2L1ELD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:03 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:59589 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab2L1ELB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:01 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so4605041dad.27
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=hK2lxGGwp2aeaccqy2voCwQoTFRIn+b/94SUpeWgRGo=;
        b=yR+nxHiJorllFlU7gtaHpdqK21oNBCX+kMRvPL89vDY/HC1gZ6oFKPePJhKmwQNNCz
         59FUfWNC+a2KGL5SucPUcY+MzD/BAkRF5cos0uWscsMCj3tdZVhEgR2g5Xa/8fWBt21P
         xP/ZWZ8FlW+g2iO2BX1Hbd0kv5CHaaPzdIsdw5AgepsbCczGfdkd4GGu/zn0BgjrJZqW
         cTNlgfXLNDnvxXib1qZOlcKCGwJK79r3Gle0SximvE2il9CVoPLsLmuhB6LjXhoKLxnx
         j4nGOEsIiNXke/QBKa5904meTSsM4QK4EGJ0cdhW0D3mqXOUPjxX/G+QUEDJ6TwVrR2L
         Sd0A==
X-Received: by 10.66.81.68 with SMTP id y4mr95360452pax.66.1356667860838;
        Thu, 27 Dec 2012 20:11:00 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id sy1sm18915110pbc.66.2012.12.27.20.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:10:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:10:59 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212223>

v2 has no big changes:

 - 'special' variable in dowild() is removed in favor of two
   new, better named ones
 - fix TRUE/FALSE in comments as well as code in the rename patch
 - some tests for "*/" and "*<literal>" optimizations
 - USE_WILDMATCH patch is moved to the end of the series

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  compat/fnmatch: respect NO_FNMATCH* even on glibc
  wildmatch: replace variable 'special' with better named ones
  wildmatch: rename constants and update prototype
  wildmatch: make dowild() take arbitrary flags
  wildmatch: support "no FNM_PATHNAME" mode
  test-wildmatch: add "perf" command to compare wildmatch and fnmatch
  wildmatch: make a special case for "*/" with FNM_PATHNAME
  wildmatch: advance faster in <asterisk> + <literal> patterns
  Makefile: add USE_WILDMATCH to use wildmatch as fnmatch

 Makefile                 |   6 ++
 compat/fnmatch/fnmatch.c |   3 +-
 dir.c                    |   3 +-
 git-compat-util.h        |  13 +++++
 t/t3070-wildmatch.sh     |  41 +++++++++++++
 test-wildmatch.c         |  82 +++++++++++++++++++++++++-
 wildmatch.c              | 147 +++++++++++++++++++++++++++++----------=
--------
 wildmatch.h              |  23 +++++---
 8 files changed, 251 insertions(+), 67 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
