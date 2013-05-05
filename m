From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/3] fast-export: speed improvements
Date: Sun,  5 May 2013 17:38:51 -0500
Message-ID: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 00:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ7bU-0006lj-DS
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab3EEWkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:40:19 -0400
Received: from mail-gg0-f179.google.com ([209.85.161.179]:39392 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3EEWkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:40:18 -0400
Received: by mail-gg0-f179.google.com with SMTP id i2so547298ggm.38
        for <git@vger.kernel.org>; Sun, 05 May 2013 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=BKzFrKCeQWLwaF0YMWWQpuX/qXN//Cb3XCe2Qq56qOg=;
        b=NatfpMRCpY1BMQ8C9f/7RaTbryW6H2IIwqHdG3A2xJ7VN1KOpRN21SaEeNMcGaq87c
         jYQWdojXxMPGDjaCvi05lFHVNDTgRL/o7p5SA2OS9+vdJcyVTiPCmWF2DmlR/PgJA4AC
         piWeVUehItQv+T9zkkIHBW4LtGNjzwXFuLx2yBne0Vn+WmOgYveH0rHWSOK4bbgD/UX1
         MvTnQSvt793YupYNT/UsOa5FGUYIlSR46iHDdczDDCfYQKGOGL6ZJKoYKn7BCv1VpH2y
         FL4f467OaPFObGonnQv1T0sYCmqqbZrNwM1KAZkaUSM6mF3BsjoKxG1dZuTSkkm1A3le
         oqfQ==
X-Received: by 10.236.112.203 with SMTP id y51mr15758469yhg.85.1367793617533;
        Sun, 05 May 2013 15:40:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v27sm42424220yhj.12.2013.05.05.15.40.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 May 2013 15:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223421>

Hi,

Second try, dropped one fix, and address a few comments.

Parsing the marks of an import of the emacs repository moves fast-export to a
crawl. It takes 14 minutes in my setup, after these patches, it takes 1 second.

The important patches are #2 and #3, the rest are niceities.

Felipe Contreras (3):
  fast-{import,export}: use get_sha1_hex() directly
  fast-export: improve speed by skipping blobs
  fast-export: don't parse all the commits

 builtin/fast-export.c | 22 +++++++++++++++-------
 fast-import.c         | 10 +++++-----
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
1.8.3.rc0.401.g45bba44
