From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 0/5] Allow git log to use mailmap file
Date: Tue, 11 Dec 2012 23:21:28 +0100
Message-ID: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDS-0001Il-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab2LKWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:00 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44833 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab2LKWV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:21:59 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1887158wey.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Um0HSQ4kIupP7HYrLYcyemWVRbKJ5hDgMve/Fuyr2HQ=;
        b=VwYe5+eYi4ApHyzoC4k79IplglgovniCpI/JLc+awDuoM3uIap6MXfSR4Kuah1A6wG
         bhWfUA9bXBEre5Umw6z9n+wtBHArhAyehLjHhmISVsY/HuyV8GATaNMR4PGkdPL3fcKL
         IiantIm8oBhrFjrOtyOjBfbmhSfijoDGhqLB9drwf+Spq6fKoxlxZ7LJ1C7osms2IQbI
         BjzskJMTB+MEBJckGKUTxLX3RvwD80OYLwxQiNODlzP721RIukgIPsbAjK1PKOMjAOeK
         3DbouhEm3zT2sfkm4Lp3Z0p1T76sXpkYSQf56a5p71+A70trBrEy8Qx2HDTYJocSPxFH
         VHhQ==
Received: by 10.180.33.202 with SMTP id t10mr19339126wii.3.1355264517984;
        Tue, 11 Dec 2012 14:21:57 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.21.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:21:57 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211303>

Implement the feature suggested here [1] by Rich Mindwinter
and Junio C Hamano (and following his advices)

This is a pre-version so there are a bunch of things still missing,
among them:
 - There is no tests
 - Grep search for mailmap author/committer is not available
 - There is no documentation of the new option

[1]: http://thread.gmane.org/gmane.comp.version-control.git/211270

Antoine Pelisse (5):
  Use split_ident_line to parse author and committer
  mailmap: Remove buffer length limit in map_user
  mailmap: Add mailmap structure to rev_info and pp
  pretty: Use mailmap to display username and email
  log: Add --use-mailmap option

 builtin/blame.c | 59 +++++++++++++++++-------------------------------
 builtin/log.c   |  9 +++++++-
 commit.h        |  1 +
 log-tree.c      |  1 +
 mailmap.c       | 16 ++++++-------
 pretty.c        | 70 ++++++++++++++++++++++++++++++++++++---------------------
 revision.h      |  1 +
 7 files changed, 84 insertions(+), 73 deletions(-)

--
1.8.1.rc1.5.g7e0651a
