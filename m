From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] Introduce pathspec struct
Date: Mon, 20 Sep 2010 09:21:48 +1000
Message-ID: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTDH-0007ji-3q
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab0ISXWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:22:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51349 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0ISXWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:22:03 -0400
Received: by pxi10 with SMTP id 10so1010735pxi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=CwmUcEXccDDr9a179xrJ5lqkbuMeYiv6/SMUpEAznZ4=;
        b=ZAio3kRdqh8YHw7hJxkAnOr9T54XvD6F0eXkecAIRiYKGFgFvIILwMLEvjV25dX/WQ
         1yp0W+8Fr9vSV9sejkOdYlHirsm7kof/AdfQHw9vWSrOfFhvbExVJeBhIoEPqtDvtTME
         WT5TpGla/5BNdPfpAGystwcwqutnvFLph3oiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=QThVOJ1VRa1z/A1FetFL5HPLy02rR0z3Qhct6BqewLJiah5KbwkMxD8ztKnqHmRa+x
         5KHl/VMw5yQ2u/+VHYgSEph0J2//xahgEo0F2/IKReJv1QYOwuTH7nAsUwAT/GsAkc3i
         CMg2f6pMlVm/gkeopGkvIxhFYrKYMT5Rj7SxU=
Received: by 10.114.127.18 with SMTP id z18mr9033019wac.171.1284938522026;
        Sun, 19 Sep 2010 16:22:02 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d38sm12264009wam.20.2010.09.19.16.21.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:22:00 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:21:55 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156521>

This is base series for en/object-list-with-pathspec, the upcoming
wildcard support in diff family (i.e. tree_entry_interesting()) and
negative pathspec farther in future.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Add struct pathspec
  diff-no-index: use diff_tree_setup_paths()
  pathspec: cache string length when initialize pathspec
  Convert struct diff_options to use struct pathspec
  tree_entry_interesting(): remove dependency on struct diff_options
  Move tree_entry_interesting() to tree-walk.c and export it

 builtin/diff-files.c |    2 +-
 builtin/diff.c       |    4 +-
 builtin/log.c        |    2 +-
 cache.h              |   10 +++
 diff-lib.c           |    2 +-
 diff-no-index.c      |   13 ++--
 diff.h               |    4 +-
 dir.c                |   27 +++++++++
 revision.c           |    6 +--
 tree-diff.c          |  157 +++---------------------------------------=
--------
 tree-walk.c          |  111 +++++++++++++++++++++++++++++++++++
 tree-walk.h          |    2 +
 12 files changed, 173 insertions(+), 167 deletions(-)
