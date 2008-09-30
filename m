From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2 0/4] Encoding support in GUI
Date: Tue, 30 Sep 2008 15:00:18 +0400
Message-ID: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 13:03:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd0T-000080-NC
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYI3LB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYI3LB4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:01:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13407 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYI3LBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:01:55 -0400
Received: by ey-out-2122.google.com with SMTP id 6so717965eyi.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Av/+OeCGNNOogXkalSU7xpKMOCbtMYftu/BmgFNzrtw=;
        b=H+xljw3pgF4ZfUk+AUMnqa4tScR1K/zp9Cu7V9X6HU2ar0JJ8E1JF1Nskr+6SxBI1L
         /fvucg9zfRVyQXAY0T+u69t/44UWrzqG9/UUriIQKGBkgLQuS8iy0LTBvbfAbrf+LrGQ
         smjxxTqMFwpUTwnZlw6otlb+lzovmUV6nA0DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=H4U1byiVg9ZCd3pGN6nw4uiHUuUxlUEqQNOaLFvIt2cKEo6H5ikiiKvWQrvg9egcfB
         8z1z/JhIKBpejoIAiJYWuVWfHs4qw79xNbZbQskDQ2a7p8qFQF+eLqn69lrmOEig7da8
         NsOOMbiyQrGazZPRPDyiaGBHQR3OA4t0HtQj0=
Received: by 10.103.242.7 with SMTP id u7mr4669015mur.125.1222772514209;
        Tue, 30 Sep 2008 04:01:54 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id y6sm7517378mug.7.2008.09.30.04.01.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 04:01:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97096>

Currently GUI tools don't provide enough support for
viewing files that contain non-ASCII characters. This set of
patches addresses this issue. The git-gui part of the series
is based on patches that were in the 'pu' branch of the
git-gui repository.

UPDATE: the git-gui part of the series is in master.

File encoding can be specified in the following ways:

1) It defaults to the current locale encoding.
2) It can be overridden by setting the gui.encoding option.
3) It can be further set on per-file basis by specifying
   the 'encoding' attribute in gitattributes.
4) Finally, git-gui allows directly selecting encodings
   through a popup menu.

Since git apparently cannot work with filenames in non-locale
encodings anyway, I did not try to do anything about it apart
from fixing some obvious bugs.


CHANGES:

- Wrote better comments for the first three patches.
- Added a patch to speed up loading of very large diffs.


GITK:
	gitk: Port new encoding logic from git-gui.
	---
	gitk |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
	1 files changed, 47 insertions(+), 3 deletions(-)

	gitk: Implement file contents encoding support.
	---
	gitk |   19 ++++++++++++++++---
	1 files changed, 16 insertions(+), 3 deletions(-)

	gitk: Support filenames in the locale encoding.
	---
	gitk |   16 +++++++++++-----
	1 files changed, 11 insertions(+), 5 deletions(-)

	gitk: Implement batch lookup and caching of encoding attrs.
	---
	gitk |   35 ++++++++++++++++++++++++++++++++++-
	1 files changed, 34 insertions(+), 1 deletions(-)
