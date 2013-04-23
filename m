From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/7] grep with textconv
Date: Tue, 23 Apr 2013 14:11:52 +0200
Message-ID: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc4k-00024f-0u
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab3DWMLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:11:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36000 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755361Ab3DWMLw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:11:52 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A6B5920BAD;
	Tue, 23 Apr 2013 08:11:51 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 23 Apr 2013 08:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=Mvm8pbspkF57tLaQybyBjtftx
	A0=; b=kKuZ/Anho5tV/yIVzlh+65yDhTq5AB3B7INmsJGmX56ho+g7667mtjI+R
	HA02+JTUACI27rIdQABsL6BD5wl4t8OKewLpOCEr7Id3xTCT/VAOVzaJSsK8VUAc
	xrvlLdMLalFqMgiM96h5b8ujdrt9LAyoduJjFTEWF3i0mv6US4=
X-Sasl-enc: VW1ESG6BMORIemDiajpAck2Cmk4DmarVQFtW+Fcjpzc+ 1366719111
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 405C72000B1;
	Tue, 23 Apr 2013 08:11:51 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222146>

Here's a reroll, with the following changes:

* Use "honor" for obey".

* Fixed the issue with --textconv and non-blobs.

* Restructured tests as per Jeff's preference.

* Added 7/ which flips the default for git grep to textconv.

Jeff King (1):
  grep: allow to use textconv filters

Michael J Gruber (6):
  t4030: demonstrate behavior of show with textconv
  show: obey --textconv for blobs
  cat-file: do not die on --textconv without textconv filters
  t7008: demonstrate behavior of grep with textconv
  grep: honor --textconv for the case rev:path
  git grep: honor textconv by default

 Documentation/git-grep.txt   |   9 +++-
 builtin/cat-file.c           |  18 ++++----
 builtin/grep.c               |  13 +++---
 builtin/log.c                |  24 ++++++++--
 grep.c                       | 102 +++++++++++++++++++++++++++++++++++++------
 grep.h                       |   1 +
 object.c                     |  26 ++++++++---
 object.h                     |   2 +
 t/t4030-diff-textconv.sh     |  18 ++++++++
 t/t7008-grep-binary.sh       |  43 ++++++++++++++++++
 t/t8007-cat-file-textconv.sh |  20 +++------
 11 files changed, 222 insertions(+), 54 deletions(-)

-- 
1.8.2.1.799.g1ac2534
