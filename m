From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 0/2] Bug fixes regarding diff and "git add -N"
Date: Mon,  9 Mar 2015 21:14:03 +0700
Message-ID: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 15:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUyRt-00055h-07
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 15:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbbCIOOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 10:14:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33661 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbbCIOOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 10:14:12 -0400
Received: by padet14 with SMTP id et14so76445124pad.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WqLFPixzTxmBbb9WcvVh4I50wN+whUZSE0oybBX92T8=;
        b=KsxIuqEvJ9I8rnI9ROm8eGiF8ZuJy18RlSvGA4oauYxtIwNDYdYivcC4cTyVJFoYo/
         ycRpl+6AxuFIR35XECWF7VsBO2kueA3R8ZRFaHRqPWdKqEtiz+/XTCRlcEbbfoOZncu/
         0v+kEDmKom9oEAq9QowmzmDPEZFCxtox0A0fbkW/cMXLDCvsk+F2XjAhIiKF3AYenmG7
         4TOIity2vEUr7y6Z0wgptIZatbYyXSClQITcXJ+LkhiVe/pwSTEtd/NPBBBOF27gQCrD
         5bcxddUHtHfEeWP00mmuuz9U/lLobFXntqUJTPavL/0XuY4fmSBEsSFEDFgLGjPX+hH6
         lVQQ==
X-Received: by 10.70.41.71 with SMTP id d7mr34299214pdl.44.1425910452242;
        Mon, 09 Mar 2015 07:14:12 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id qa1sm19444732pdb.84.2015.03.09.07.14.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 07:14:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 21:14:07 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265167>

The first one attempts to fix "git status" reporting intent-to-add
files as "changes to be committed". The "new file" report is now moved
to "git diff-files" aka "changes not staged for commit" instead.

I just want to check if I'm going on the right direction as core diff
machinery is not really my area. I know these patches break t2203 and
t4011 but from a quick glance, the tests simply rely on the old behavio=
r,
not real breakages.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  diff --cached: do not report i-t-a entries as "new"
  diff-files: mark i-t-a paths as "new"

 builtin/add.c | 1 +
 diff-lib.c    | 7 +++++++
 2 files changed, 8 insertions(+)

--=20
2.3.0.rc1.137.g477eb31
