From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 00/20] refs backend
Date: Fri,  5 Feb 2016 14:44:01 -0500
Message-ID: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJC-0000lo-PR
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbcBETom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 14:44:42 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34225 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977AbcBETol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:41 -0500
Received: by mail-qg0-f45.google.com with SMTP id u30so76273903qge.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=J21exaBspsYul1z8WeEjKnQuF27W8DgCfO6nrJyp+jc=;
        b=fN8aVeDxJp7grrY5tOnUC2ziNz9XsmzDwo9Q3PBree1DJAUOVF/cVwWYhWEkpxYQGD
         Qdjjo1YxQ757hG5uehklfFCt8NZj3cekZCKoS365MhZd4o4PVZRI5vBqOy8q8hHXyP9K
         FAHeIDNg7yEaNZpt0/LMpTHBNuEcr2+GkgWrOHSlDNEUmtzN2zp9/1SklvO7kYzjgsDh
         i9egXqLVp9AkefR+VdYwpCXtsPX815v49032Bn7fr8n6PLaobdA+hPOA/49jeYi+0d4h
         Ux7X68U+96MiU7T5pR77u/NZVWVDIPdatneX0DWA3yeemOlqOY7xzR+f0Nxn8f+u4wUz
         uhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=J21exaBspsYul1z8WeEjKnQuF27W8DgCfO6nrJyp+jc=;
        b=CmQrwfzH2a/t1U4Kwl5N90MSgtst1qCd1Ij1hroSugNMPJdMJFqPZsL0eXa0Ug0OE1
         l/lJUaA4MHtgcR8gClWZ6GRgOjtZf6xVuLauzgwBRydgMdSDNsJfosMVvqPIq10SBkDn
         YIbsCB4d3Vwy0VgKsIdcLxf0bF79l5cApuTQ2w44vgnx5aZjCFny7ysBmwPOh4VGBuhE
         cL9k9uudw/XmhZ7P/L4Rmcz0kRDv9du45dxbYmH1+UrVQaE/hZrGg5CSD5tnPzWgn9wK
         xuBnINhucbl33TMprdZBg6/lnPVfQ7q2owUH+St+m/XBE0zpaDS8DEALpI+gKInI6rXW
         Pgww==
X-Gm-Message-State: AG10YORlRXiAmIOqJjjT4TotMPbTWv5wH6Yqf1EbZmxk1y94bl25OrqKPvWrqX+QSE1qpg==
X-Received: by 10.140.250.138 with SMTP id v132mr19947764qhc.0.1454701480574;
        Fri, 05 Feb 2016 11:44:40 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285604>

Changes to this version:
re-rolled on top of pu as-of 9db66d9f1aa.

Bug fixes include:
=46or submodules: memory leaks; segfault on bad config. (thanks to Peff=
)
In symref splitting: check that would always succeed (thanks to Peff)
A bogus double-declaration of a var (thanks to Ramsay Jones)
Two memory leaks (thanks to Thomas Gummerer)
An unused var (thanks to Duy Nguyen)

Other improvements are:
Strings prepped for 18n (thanks to Duy Nguyen)
Cleaner submodule handling (thanks to Peff)
Whitelisting instead of blacklisting in git-new-workdir (thanks to
  Thomas Gummerer)
Allow older gits to recognize lmdb-backend git repos (thanks to Duy Ngu=
yen)
Tab completion and cleaner commit messages (thanks SZEDER G=C3=A1bor)
Removed some #ifdefs, moving all backend setup to one place (thanks to =
Duy
Nguyen)

Thanks to all for reviews.

David Turner (18):
  refs: add do_for_each_per_worktree_ref
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: make lock generic
  refs: move duplicate check to common code
  refs: allow log-only updates
  refs: resolve symbolic refs first
  refs: always handle non-normal refs in files backend
  init: allow alternate ref strorage to be set for new repos
  refs: check submodules ref storage config
  clone: allow ref storage backend to be set for clone
  svn: learn ref-storage argument
  refs: add register_ref_storage_backends()
  refs: add LMDB refs storage backend
  refs: tests for lmdb backend

Ronnie Sahlberg (3):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations
  refs: add methods for the ref iterators

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    6 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    7 +-
 Documentation/technical/refs-lmdb-backend.txt  |   52 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |    5 +
 builtin/init-db.c                              |   57 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |   25 +
 configure.ac                                   |   33 +
 contrib/completion/git-completion.bash         |    6 +-
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 path.c                                         |   29 +-
 refs.c                                         |  486 +++++-
 refs.h                                         |   21 +
 refs/files-backend.c                           |  404 ++---
 refs/lmdb-backend.c                            | 2052 ++++++++++++++++=
++++++++
 refs/refs-internal.h                           |  128 +-
 setup.c                                        |   23 +-
 t/t0001-init.sh                                |   25 +
 t/t1460-refs-lmdb-backend.sh                   | 1109 +++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
 t/t1480-refs-lmdb-submodule.sh                 |   85 +
 t/test-lib.sh                                  |    1 +
 test-refs-lmdb-backend.c                       |   64 +
 transport.c                                    |    7 +-
 32 files changed, 4825 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

--=20
2.4.2.749.g730654d-twtrsrc
