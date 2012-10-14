From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 00/12] nd/wildmatch
Date: Sun, 14 Oct 2012 09:34:58 +0700
Message-ID: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE3M-00056J-PD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab2JNCfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:35:34 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2JNCfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:35:33 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3876368pad.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Q6DSanIs1+CIVpdRsXUNZ532c+J5aYLX6yZQeD4AQmA=;
        b=KaEHavWCaUOy5aP0A26WldOmw25JOcRu0mdEY5EHEJDNcZwXatD2EJBQaxLx9fZc2k
         XDvDO2zf10Fbz/ujC0E2Oot4obCuDQK+3VbaZTaDNX200nh8SqjnIlW6iaYBd94OJYNt
         25uIstaIuj2tR9vjFy/KugWyro3jGXETHRHFOucSrq3Gotz0kb1HT35M/HZ+ev9LAyCu
         ggt4CeS4BxBtQ8AozOpsnqozglEpZqreUY2l5UULIIsuzw0y1o9qtmayg+36HbTsBt7t
         Qg/NlF5gFyxjq+ynx6vVGkRYmiir/+oF80/b15nHVFE6V/1WqDF5+GwArJzMypTpEcpJ
         G2PA==
Received: by 10.66.79.195 with SMTP id l3mr22527510pax.33.1350182133097;
        Sat, 13 Oct 2012 19:35:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id vz8sm6809678pbc.63.2012.10.13.19.35.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:35:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:35:18 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207591>

This version splits fnmatch/wildmatch tests separately in t3070 and
disables a lot more fnmatch tests. It also fixes the "cd .." in t0003
test and a comment in front of dowild(). No functional changes.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  ctype: make sane_ctype[] const array
  ctype: support iscntrl, ispunct, isxdigit and isprint
  Import wildmatch from rsync
  wildmatch: remove unnecessary functions
  Integrate wildmatch to git
  t3070: disable unreliable fnmatch tests
  wildmatch: make wildmatch's return value compatible with fnmatch
  wildmatch: remove static variable force_lower_case
  wildmatch: fix case-insensitive matching
  wildmatch: adjust "**" behavior
  wildmatch: make /**/ match zero or more directories
  Support "**" wildcard in .gitignore and .gitattributes

 .gitignore                         |   1 +
 Documentation/gitignore.txt        |  19 +++
 Makefile                           |   3 +
 attr.c                             |   4 +-
 ctype.c                            |  20 +++-
 dir.c                              |   4 +-
 git-compat-util.h                  |  15 ++-
 t/t0003-attributes.sh              |  37 ++++++
 t/t3001-ls-files-others-exclude.sh |  19 +++
 t/t3070-wildmatch.sh               | 195 +++++++++++++++++++++++++++++=
+
 test-wildmatch.c                   |  14 +++
 wildmatch.c                        | 239 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   9 ++
 13 files changed, 575 insertions(+), 4 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.8.0.rc2.11.g2b79d01
