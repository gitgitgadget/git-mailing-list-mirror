From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v5 0/3] merge-recursive: option to disable renames
Date: Sat, 20 Feb 2016 23:34:29 -0300
Message-ID: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 03:36:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXJtC-0007Ss-2A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 03:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcBUCgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2016 21:36:12 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:32801 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbcBUCgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 21:36:09 -0500
Received: by mail-qg0-f50.google.com with SMTP id b35so89483511qge.0
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=tUtMRbEb+AnkOGi7BUTxXYDwFWcSoPo66EVWiip3XN0=;
        b=Ds+SvlR00yJ+PjuPNCtZfb8e9GpIKiidcQMtbI7s0F4N01e6eebMbKfoH2mzUBhcuD
         SXRAOZgNr99wGYWhEeqIa/9QRd03DXjiaumTVDVL1dxKGGHCSCCkj5EhXql9vcv6y4PP
         xrwLimXiQ5wK0Zr5DkJxdRwBf0ACFQulEKLwmpGgRtzQHR5JS7t7Brn2Z4Cg5rZSTYm4
         31AShPjIly5cbx1RmQ7a/mnCOHf5o4SdrsysVbne6yd7rbfkuh80+rcC+eCUMRPGwE9/
         mtC4Une7YGaqy37qbQVc80ij/p7uYjh69Xkh/2zf0iFmot70u4mcr5ZeAY6JA+3frmXi
         AJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=tUtMRbEb+AnkOGi7BUTxXYDwFWcSoPo66EVWiip3XN0=;
        b=X3aN+8s4gIeN/FfcuSY522MugpLxi3QPT2JGfUHgzpMsl1pzafOIHNnw+WAyPZRfLc
         pLBzQ/Li//r4sBnfYnWusDvAjWIr2hayP4uTcm0HzbFR2OpAUkOuJsiRHDQSCbgiP5Wm
         5AFE8O9bMBjgyU+bNSubjtkRfeKk0V8sYNBLDNajjiSZ0vZIuZImxqfc939RKfMcDzdp
         LW8GGajsrKIks9v8IOCS1L937laryce5sQ104WwqroDo+SY3XmhBDTl2GK9DlPYt1t7c
         EOmzXWJw5rXCnu5mOXGJJG+W/svQgQiWLaWZH0W7nE8pz68RapODne6H/2G5CMCsAV06
         oP+w==
X-Gm-Message-State: AG10YOTZ0WL26hrXx6UhvLhxVFBTq67ORoDqt5YjG1ocojaNr/qLFn/owclWMt8oK5vKAA==
X-Received: by 10.140.99.72 with SMTP id p66mr25847359qge.16.1456022168084;
        Sat, 20 Feb 2016 18:36:08 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id 188sm7618067qhi.1.2016.02.20.18.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 18:36:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.342.gf5bb636
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286795>

Add tests as suggested by Eric Sunshine. Also fixes an inconsitency in =
the last
part.

Since there were no tests for the --rename-threshold option, I added th=
em in a
separate commit, which is useful in itself.

The other two commits contain the previous patches plus the relevant te=
sts.

=46or the last part, I made --find-renames (without =3D<n>) reset the s=
imilarity
index to the default, just as in git-diff.

=46elipe Gon=C3=A7alves Assis (3):
  merge-recursive: test rename threshold option
  merge-recursive: option to disable renames
  merge-recursive: more consistent interface

 Documentation/merge-strategies.txt                 |  12 +-
 merge-recursive.c                                  |  14 +-
 merge-recursive.h                                  |   1 +
 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 200 +++++++++++++=
++++++++
 5 files changed, 225 insertions(+), 4 deletions(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.342.gf5bb636
