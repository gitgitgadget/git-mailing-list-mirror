From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 00/22] Some updates since v3
Date: Sat, 24 Jul 2010 23:13:32 +0800
Message-ID: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgQt-0001Th-AC
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0GXPOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:14:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0GXPO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:14:29 -0400
Received: by pwi5 with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=oWYB3MCPZTIUybeB8w2ThYfwid/qIdpqJHYBYeSVkM8=;
        b=QbNgwIDe5idYX3DmVwZTwVq4lsYEW4P/Gv0GB6yzrhBs6poxcbr4X+qS4hYz10dyDv
         oMqNwkm4SIljlf741dhK5V8TIgd3HoRE5KTJi1yRt6bTyxP2GvxTsGyR1Uc/E8fxTo3G
         cVW/h0CIIzsVwJ+2Z8zVfKHPxKYGmoj1F3xTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=SGVzY7X9edV0cn0BavfSt13kaxhhMRzof+vOuro9s9H6QKaCStdhy71A8SB94YOLoN
         PhKTTjK/FWtRenSM0HKYBsX+r1AQjslLQKTKDEaHOwl7fccixIgtLPgj6vn2yfVJdBYL
         N4yx8Bd9B58irzqSdA1ByuaG52rXi31pfbQPo=
Received: by 10.142.192.4 with SMTP id p4mr5863541wff.311.1279984468686;
        Sat, 24 Jul 2010 08:14:28 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:14:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151633>

Most commit messages issues get fixed in this series. The parent rewriting is still in progress and now part of it can be used very well to prune out uninteresting merges. The '--always-print' option is changed to '--full-line-diff', this option can be used by users to get a more detail line evovlment info. And the senmatic of this option will be changed later in the real v4 version of this series.
Notice that, this series will break one of test because of '--full-line-diff' refactoring, just ignore it. :)


Bo Yang (22):
  parse-options: enhance STOP_AT_NON_OPTION
  parse-options: add two helper functions
  Add the basic data structure for line level history
  Refactor parse_loc
  Parse the -L options
  Export three functions from diff.c
  Add range clone functions
  map/take range to the parent of commits
  Print the line log
  Hook line history into cmd_log, ensuring a topo-ordered walk
  Add --full-line-diff option
  Add tests for line history browser
  Document line history browser
  Make rewrite_parents public to other part of git
  Add parent rewriting to line history browser
  Add --graph prefix before line history output
  Add test cases for '--graph' of line level log
  a fast fix
  Make graph_next_line external to other part of git
  some changes
  commit parents prunning code
  A merge should not be printed anyway

 Documentation/blame-options.txt     |   19 +-
 Documentation/git-log.txt           |   17 +
 Documentation/line-range-format.txt |   18 +
 Makefile                            |    2 +
 builtin/blame.c                     |   89 +--
 builtin/log.c                       |  111 +++-
 diff.c                              |    6 +-
 diff.h                              |   17 +
 diffcore.h                          |    1 +
 graph.c                             |   14 +-
 graph.h                             |   10 +
 line.c                              | 1542 +++++++++++++++++++++++++++++++++++
 line.h                              |  141 ++++
 parse-options.c                     |   22 +-
 parse-options.h                     |    7 +-
 revision.c                          |   22 +-
 revision.h                          |   22 +-
 t/t4301-log-line-single-history.sh  |  567 +++++++++++++
 t/t4302-log-line-merge-history.sh   |  163 ++++
 19 files changed, 2661 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line.c
 create mode 100644 line.h
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh
