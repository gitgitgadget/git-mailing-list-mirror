From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 0/5] replace signal() with sigaction()
Date: Tue, 27 May 2014 23:14:10 -0700
Message-ID: <1401257655-6043-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 08:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpX8W-0007Cb-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 08:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaE1GOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 02:14:48 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46332 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaE1GOs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 02:14:48 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so10437876pab.17
        for <git@vger.kernel.org>; Tue, 27 May 2014 23:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=jfIUvduCottZuGo//yvkSzYSTN7d8nIv6SvoziauCWE=;
        b=VJOPdblCbrmh5tM1xYrY9o+4FUe6G4jfBiDB3HdSjldds3qvqPtsX+YCvGpBqTP61j
         Fwp9QCxXcMhZxY4MzRz6A3FsheDJ2lbi7M7e4xbB2juxGb0+r2dS6xJvNv+cgwZ6FH32
         8ZZAt+MmfBz9LzBBYxIFL6rRZ1BshZ+rz3Zjp8FcC9bkUduyW/JLOLrvPWVen/5Cp1GW
         VkV8TMLWA7vleQCnaHWXDAQGCJtBU2YwDUxRNTsN71yYbEOp6WMEDGOf7V66hF7+/oXr
         v6fRfkAJMxXspGAQiDgyNgI2evKMo3FOrknLoBpA8vmrLjWK7dK3jhb4RsxQ3G9A5L0H
         X25A==
X-Received: by 10.68.237.228 with SMTP id vf4mr43401905pbc.131.1401257687607;
        Tue, 27 May 2014 23:14:47 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gu11sm26462606pbd.38.2014.05.27.23.14.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 23:14:46 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 23:14:43 -0700
X-Mailer: git-send-email 2.0.0.rc4.6.g127602c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250262>

=46rom signal(2)

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.  See Portability below.

This patch set replaces calls to signal() with sigaction() in all files
except sigchain.c.  sigchain.c is a bit more complicated than the other=
s
and will be done in a separate patch.

Jeremiah Mahler (5):
  progress.c: replace signal() with sigaction()
  daemon.c run_service(): replace signal() with sigaction()
  daemon.c child_handler(): replace signal() with sigaction()
  daemon.c service_loop(): replace signal() with sigaction()
  connect.c: replace signal() with sigaction()

 connect.c  |  5 ++++-
 daemon.c   | 15 ++++++++++++---
 progress.c |  6 +++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

--=20
2.0.0.rc4.6.g127602c
