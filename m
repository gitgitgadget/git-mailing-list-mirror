From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 0/3] port upload-archive to windows
Date: Thu,  7 Jul 2011 13:43:06 +0200
Message-ID: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 13:43:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QemzJ-0008Um-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 13:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650Ab1GGLnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 07:43:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:32897 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab1GGLnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 07:43:16 -0400
Received: by ewy4 with SMTP id 4so282790ewy.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=cuti7Z/KglUHI91Jo4SHmtpUtZEWySvAhfIQGnl77zg=;
        b=nCwtARU6Je3FRYi2x2TY0xjGRDGMvfDMaHmK2+8qyRPXfES29X5OE8hOnTtw1DPm/l
         6lOIUrrqpqIn0i6A6IJxYKKy7ev39ETvyRI2BNf0Hs+dsl2oRkO+yqw2z8KOlMIGw5cO
         7mnIMqH21/F4bHck8vdcTVGqbSIs+y9DzTOBE=
Received: by 10.14.50.197 with SMTP id z45mr182857eeb.248.1310038995311;
        Thu, 07 Jul 2011 04:43:15 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id n57sm6941268eeb.16.2011.07.07.04.43.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 04:43:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176755>

Upload-archive, while compiled and installed on Windows, never
worked due to it's dependence on fork. This is a patch-series to
remedy that.

While doing this, I found a bug in gnulib's poll-emulation where
it could return 0 even when timeout was -1. This is neither
something POSIX allows, nor something our code is expecting.

So I've submitted an upstream patch for gnulib and upgraded our
copy.

Erik Faye-Lund (3):
  compat/win32/sys/poll.c: upgrade from upstream
  mingw: fix compilation of poll-emulation
  upload-archive: use start_command instead of fork

 builtin/upload-archive.c |   62 ++++++++++++----------------------------------
 compat/mingw.h           |    2 -
 compat/win32/sys/poll.c  |   17 +++++++++---
 3 files changed, 28 insertions(+), 53 deletions(-)

-- 
1.7.6.135.ge14e3f
