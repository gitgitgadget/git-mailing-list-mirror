From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/resent 0/9] Sparse checkout (first half)
Date: Wed,  1 Oct 2008 11:04:00 +0700
Message-ID: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:06:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kksyg-0001Eq-BC
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbYJAEFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 00:05:04 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYJAEFE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:05:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYJAEFC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:05:02 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=kgR9n+frja6A2xF2JgJhaoJQAA37z2ZY3C5tPVv7QRI=;
        b=xXMO/akaJ0IaGLIkZdmW7Thi/4AOaUgj0f35ZzuhRqaTKpOeOQyiP/0qy6R0OcZ+ET
         YrJtuypycT3GS68k2wBvkP3oo7ix68/dtVvILcvUjBKFACJ4p0/s51TWRgiDaghp0BLt
         RAs27k3qbb7hYK7wqVIJjOZBMFj+sdnfeegRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TU/P9VagY+hKjdC2hH4g7/HuZAYMGnrycWkbEl9Bh81w9U1o+MSy9YPkK2Da0WdHu9
         k/gH/SQM+aCcU8ZnFFM6xQeyKrExvFWY7YUMbnqU+EjvCCzIZPB9BVVFGXp4YkW8dqOi
         XkD1MLL1gRQaWPSYuKjm8NTGOj36VqHfGIVxY=
Received: by 10.141.29.21 with SMTP id g21mr4022184rvj.225.1222833901453;
        Tue, 30 Sep 2008 21:05:01 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id k41sm3352429rvb.9.2008.09.30.21.04.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:05:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:04:09 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97191>

This is the first half of the series, making git ready for sparse
checkout. The only difference from the last (first half) sent
series is safeguard bitmask fix in 1/9

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Extend index to save more flags
  Introduce CE_NO_CHECKOUT bit
  ls-files: add options to support sparse checkout
  update-index: refactor mark_valid() in preparation for new options
  update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT
    bit
  ls-files: Add tests for --sparse and friends
  Prevent diff machinery from examining worktree outside sparse
    checkout
  checkout_entry(): CE_NO_CHECKOUT on checked out entries.
  grep: skip files outside sparse checkout area

 .gitignore                            |    1 +
 Documentation/git-checkout.txt        |   34 +++++++++++++++++
 Documentation/git-grep.txt            |    4 +-
 Documentation/git-ls-files.txt        |   24 +++++++++++-
 Documentation/git-update-index.txt    |   13 ++++++
 Makefile                              |    2 +-
 builtin-grep.c                        |    7 +++-
 builtin-ls-files.c                    |   41 ++++++++++++++++++--
 builtin-update-index.c                |   40 ++++++++++++-------
 cache.h                               |   66 +++++++++++++++++++++++++=
++++++--
 diff-lib.c                            |    5 +-
 diff.c                                |    4 +-
 entry.c                               |    1 +
 read-cache.c                          |   57 ++++++++++++++++++++++---=
---
 t/t2104-update-index-no-checkout.sh   |   36 ++++++++++++++++++
 t/t3004-ls-files-sparse.sh            |   40 ++++++++++++++++++++
 t/t3004/cached.expected               |    5 ++
 t/t3004/deleted.expected              |    1 +
 t/t3004/everything.expected           |   10 +++++
 t/t3004/modified.expected             |    2 +
 t/t3004/no-checkout.expected          |    2 +
 t/t3004/orphaned-no-checkout.expected |    3 +
 t/t3004/orphaned.expected             |    1 +
 t/t3004/others.expected               |    2 +
 t/t3004/sparse-cached.expected        |    3 +
 t/t3004/sparse-everything.expected    |   11 +++++
 test-index-version.c                  |   14 +++++++
 27 files changed, 385 insertions(+), 44 deletions(-)
 create mode 100755 t/t2104-update-index-no-checkout.sh
 create mode 100755 t/t3004-ls-files-sparse.sh
 create mode 100644 t/t3004/cached.expected
 create mode 100644 t/t3004/deleted.expected
 create mode 100644 t/t3004/everything.expected
 create mode 100644 t/t3004/modified.expected
 create mode 100644 t/t3004/no-checkout.expected
 create mode 100644 t/t3004/orphaned-no-checkout.expected
 create mode 100644 t/t3004/orphaned.expected
 create mode 100644 t/t3004/others.expected
 create mode 100644 t/t3004/sparse-cached.expected
 create mode 100644 t/t3004/sparse-everything.expected
 create mode 100644 test-index-version.c
