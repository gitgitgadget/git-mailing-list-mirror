From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/2] fast-import: empty/reset branch bugs
Date: Fri, 23 Sep 2011 01:47:03 +0600
Message-ID: <1316720825-32552-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 21:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6p8A-0004Tz-EQ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 21:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab1IVTkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 15:40:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44362 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1IVTkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 15:40:15 -0400
Received: by bkbzt4 with SMTP id zt4so2807782bkb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=acnSi668GA7IkE2fgPmbeb2siv5TzjX1YcL8GhFwNJE=;
        b=OBW3sFkTPwiaXXjG8JzC5E+wlwMqsFOWwxiSuS1fTkLErxKBaX9yVxNyZPf0pBjfVh
         J7AVha2yaiwWdaiKaKWfKJCaanAxUqstpfRm1PGBpOsrYAepd1GJRATpWASmaF+snTET
         dAnu+bzJG0hlHfrYmEwDxaDHHveJ+F/TReu4s=
Received: by 10.204.133.12 with SMTP id d12mr1874682bkt.227.1316720414130;
        Thu, 22 Sep 2011 12:40:14 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id j16sm3857428bks.3.2011.09.22.12.40.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 12:40:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181915>

fast-import uses null_sha1 for empty branches. It doesn't make a 
null_sha1 parent nor writes out a branch with null_sha1 head. But
for notemodify and tag commands there is no check for null_sha1
and so bad tag/notes are produced instead of a error message.

Dmitry Ivankov (2):
  fast-import: don't allow to tag empty branch
  fast-import: don't allow to note on empty branch

 fast-import.c          |    4 ++++
 t/t9300-fast-import.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

-- 
1.7.3.4
