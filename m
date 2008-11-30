From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] Sparse checkout, the last half of the series
Date: Sun, 30 Nov 2008 17:54:30 +0700
Message-ID: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyI-0005Sh-HL
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYK3Ky5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 05:54:57 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYK3Ky5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:54:57 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:6428 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYK3Ky4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:54:56 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1992085rvb.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=PK8g/XTVh5MomWJ0Y5rasqgIgSAS6uWR4Bvvw+fbjMg=;
        b=A9Vmfjw47fA/OCbAnBDlYhsDEhm5MpQOzsJVhC07dOL2LOf2TD+JclGR6fjqqaoIfV
         dXXN9lCK32O3s3r/uAUnUMRfcq+6w4QtF9ODnN5A9IZxrsx0A5RB2toa7z4rMJP8lOjt
         5GvdharRDMB1GUeoCj9oiSlXDlF8e2RTcR/Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KXvgp5tk7GcQFWJAvi28g5QEoyZYwOQ7JHklbyHCmxlEr74tzDCgZthdrgHsD5fCoS
         Wid+HywdlgSqOHWMn+q8pp7fYm0/5PslwPC5L1JLH3F0yREllCZq11xs/CndThTHl0Fy
         NVV5q28f38n4ctopFcfpdBVCh+NE6TbxU79Mk=
Received: by 10.115.33.1 with SMTP id l1mr5698793waj.130.1228042495817;
        Sun, 30 Nov 2008 02:54:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id y25sm3184701pod.25.2008.11.30.02.54.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:54:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:54:39 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101961>

This series is almost identical to my last sent series with bug fixes.
Documentation is hopefully detail enough so I don't have to say more he=
re.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  generate-cmdlist.sh: avoid selecting synopsis at wrong place
  Introduce "sparse patterns"
  unpack_trees(): keep track of unmerged entries
  unpack_trees(): add support for sparse checkout
  clone: support sparse checkout with --sparse-checkout option
  checkout: add new options to support sparse checkout
  Introduce default sparse patterns (core.defaultsparse)
  wt-status: show sparse checkout info

 Documentation/config.txt         |   10 +
 Documentation/git-checkout.txt   |  133 ++++++++++++++-
 Documentation/git-clone.txt      |   11 +-
 Documentation/git-ls-files.txt   |    8 +-
 builtin-checkout.c               |   93 ++++++++++
 builtin-clone.c                  |   16 ++
 builtin-ls-files.c               |   23 ++-
 builtin-read-tree.c              |    3 +-
 cache.h                          |    5 +
 config.c                         |    5 +
 environment.c                    |    1 +
 generate-cmdlist.sh              |    2 +-
 t/t2011-checkout-sparse.sh       |  147 ++++++++++++++++
 t/t3003-ls-files-narrow-match.sh |   41 +++++
 t/t3003/1                        |    4 +
 t/t3003/12                       |    8 +
 t/t3003/clone-escape             |    5 +
 t/t3003/cur-12                   |    2 +
 t/t3003/prefix-sub2              |    3 +
 t/t3003/root-sub-1               |    1 +
 t/t3003/slash-1                  |    1 +
 t/t3003/sub-1                    |    2 +
 t/t3003/sub-only                 |    3 +
 t/t3003/subsub-slash             |    3 +
 t/t5703-clone-narrow.sh          |   42 +++++
 unpack-trees.c                   |  360 ++++++++++++++++++++++++++++++=
+++++++-
 unpack-trees.h                   |   29 +++
 wt-status.c                      |   44 +++++
 wt-status.h                      |    1 +
 29 files changed, 988 insertions(+), 18 deletions(-)
 create mode 100755 t/t2011-checkout-sparse.sh
 create mode 100755 t/t3003-ls-files-narrow-match.sh
 create mode 100644 t/t3003/1
 create mode 100644 t/t3003/12
 create mode 100644 t/t3003/clone-escape
 create mode 100644 t/t3003/cur-12
 create mode 100644 t/t3003/prefix-sub2
 create mode 100644 t/t3003/root-sub-1
 create mode 100644 t/t3003/slash-1
 create mode 100644 t/t3003/sub
 create mode 100644 t/t3003/sub-1
 create mode 100644 t/t3003/sub-only
 create mode 100644 t/t3003/subsub-slash
 create mode 100755 t/t5703-clone-narrow.sh
