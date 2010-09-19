From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Globbing support in diff family
Date: Mon, 20 Sep 2010 09:29:55 +1000
Message-ID: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 01:30:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTKt-0001QI-1q
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab0ISXaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:30:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56730 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab0ISXaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:30:10 -0400
Received: by pzk34 with SMTP id 34so1009603pzk.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=+FXv8EPOeH1+YCtXvAIhQO8oBsrlu5UJo1HLXPZuxgk=;
        b=XUk44jBKqEt4u8TQ4bxLfDcB01RklJYCcAMTK9WAHBAVEPrcfz1oDdZW81pXlzUS/v
         M4HUDVU5+/ByBp5FyevNYXZUmcu1ZbgTys6bgHw+UeCDiYjOpfxMkzrpsT6fEfLmW7mw
         LaFe/ZycRTmhVxozZQM9QRqtXmr1Vu4hSDTts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NvpWC0dWvnqIbLVw4/2aF2/LYdJzfiA0qP0YSIb/JjVYaCk/BEvUaQt2WXF2vwuB+o
         TSHC79bs3Y7obJ/T7N/PNea+0sLKg0JCAWoTuD6uRyuTuR7M1BACXBuog1njGF/cA6zd
         WrTcuaouyu45IUdARf3SketoYVFJdzFKt34Po=
Received: by 10.142.230.1 with SMTP id c1mr6993660wfh.16.1284939010017;
        Sun, 19 Sep 2010 16:30:10 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id o9sm6227217wfd.4.2010.09.19.16.30.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:30:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:30:04 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156531>

This is on top of the pathspec struct series

http://mid.gmane.org/1284938514-16663-1-git-send-email-pclouds@gmail.co=
m

One question to document experts: where to document "pathspec", git.txt=
?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  pathspec: mark wildcard pathspecs from the beginning
  pathspec: add tree_recursive_diff parameter
  tree_entry_interesting: turn to match_pathspec if wildcard is present
  Convert ce_path_match() to use struct pathspec
  ce_path_match: drop prefix matching in favor of match_pathspec

 builtin/update-index.c   |    8 ++++++--
 cache.h                  |    5 ++++-
 diff-lib.c               |   10 ++++++++--
 dir.c                    |    7 ++++++-
 preload-index.c          |    5 ++++-
 read-cache.c             |   25 ++-----------------------
 revision.c               |    5 ++++-
 t/t4010-diff-pathspec.sh |   23 +++++++++++++++++++++++
 tree-diff.c              |    1 +
 tree-walk.c              |   18 ++++++++++++++++++
 wt-status.c              |    5 ++++-
 11 files changed, 80 insertions(+), 32 deletions(-)
