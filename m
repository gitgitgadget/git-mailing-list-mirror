From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v3 0/5] Patches to avoid reporting conversion changes.
Date: Mon, 10 May 2010 11:51:45 +0200
Message-ID: <cover.1273482409.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 11:52:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPee-0002yU-4X
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab0EJJv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 05:51:57 -0400
Received: from mail.roxen.com ([212.247.29.220]:41459 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805Ab0EJJv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:51:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 1C0C56280FC
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:51:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZUfN7jTdMfa for <git@vger.kernel.org>;
	Mon, 10 May 2010 11:51:52 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C24206280FA
	for <git@vger.kernel.org>; Mon, 10 May 2010 11:51:52 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o4A9pqSO016647;
	Mon, 10 May 2010 11:51:52 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o4A9pqPx016646;
	Mon, 10 May 2010 11:51:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146784>

This is the third go at having the git index keep track of
conversion mode changes for files.

Changes since last time:

  o The normalized sha1 is gone and replaced with a single bit
    (CONV_NORM_NEEDED).

  o The index extension "NORM" has been replaced with "CONV",
    since the only data to be saved is the conversion flags,
    and the format has been changed incompatibly.

  o The cache entry is now smudged on conversion mode change
    when relevant.

Henrik Grubbstr=C3=B6m (Grubba) (5):
  sha1_file: Added index_blob().
  strbuf: Added strbuf_add_uint32().
  cache: Keep track of conversion mode changes.
  cache: Added index extension "CONV".
  t/t0021: Test that conversion changes are detected.

 cache.h               |   11 +++++
 convert.c             |   31 +++++++++++++++
 read-cache.c          |  102 +++++++++++++++++++++++++++++++++++++++++=
+++----
 sha1_file.c           |   19 +++++++++
 strbuf.h              |    4 ++
 t/t0021-conversion.sh |   54 ++++++++++++++++++++++++++
 6 files changed, 212 insertions(+), 9 deletions(-)
