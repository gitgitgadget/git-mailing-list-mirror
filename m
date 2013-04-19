From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/6] grep with textconv
Date: Fri, 19 Apr 2013 18:44:43 +0200
Message-ID: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERP-0008P3-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968454Ab3DSQpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39225 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968397Ab3DSQpd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:33 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 080AB20D10
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:33 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 19 Apr 2013 12:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=duGA4555TfmZopPTPI1K7M3alNQ=; b=qPmThanB0fi7cZRcI6fd
	9Ksf9NSrF6PoojTzHTMEImGnR8wCVAeE4o4mHPDe23bnH9bG2pIZM2UpuAWc/y9H
	9fhg49wF0WWx4BAWRWXarUC5ottyz1tHtMXjELi2MKESAve6Bgo7X9l1YLZHqSjw
	3cSc+PAuyw/bBmgUzl49HCs=
X-Sasl-enc: iJDHhZkv0ycOQ+7A5F3YaQxlOkFGizQa61XuiZaarXVS 1366389932
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D9212001C1;
	Fri, 19 Apr 2013 12:45:32 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221770>

This series teaches show and grep to obey textconv:
show by default (like diff), grep only on request (--textconv).
We might switch the default for the latter also, of course.
I'd actually like that.

Compared to an earlier (historic) series this one comes with tests.
Besides, it has been in use since.

Jeff King (1):
  grep: allow to use textconv filters

Michael J Gruber (5):
  t4030: demonstrate behavior of show with textconv
  show: obey --textconv for blobs
  cat-file: do not die on --textconv without textconv filters
  t7008: demonstrate behavior of grep with textconv
  grep: obey --textconv for the case rev:path

 builtin/cat-file.c           |   9 ++--
 builtin/grep.c               |  13 +++---
 builtin/log.c                |  24 +++++++++--
 grep.c                       | 100 +++++++++++++++++++++++++++++++++++++------
 grep.h                       |   1 +
 object.c                     |  26 ++++++++---
 object.h                     |   2 +
 t/t4030-diff-textconv.sh     |  18 ++++++++
 t/t7008-grep-binary.sh       |  39 +++++++++++++++++
 t/t8007-cat-file-textconv.sh |  20 +++------
 10 files changed, 205 insertions(+), 47 deletions(-)

-- 
1.8.2.1.728.ge98e8b0
