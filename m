From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 0/5] TAP support for Git
Date: Tue, 15 Jun 2010 22:32:53 +0000
Message-ID: <1276641178-32420-1-git-send-email-avarab@gmail.com>
References: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:33:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeh8-0005na-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab0FOWdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 18:33:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab0FOWdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:33:15 -0400
Received: by wyb40 with SMTP id 40so5237085wyb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EpqZBMQmh7bVzqt5DlQqG43txGTwzAzVxq52numvXjc=;
        b=sM8p4/aJ44C6E+GfrxDmoWW0V9KzEU/kRSyvfx/BaBgKda7+BWqND0sJZEN57iuIkl
         6NqPOZEnHcgX/f8eZyAilmpHHcAMRFBWkePZ0Q94s+3zK4LXM6ZaEWZAWi5VsbJju1kV
         5nYpJR3iAbWK5ewGbKjBKO6ezjnstZr1zfzek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QiyGaX3is5MgRqRv3nuiso30YKkVhFsjtl8PKXZxxys6P9P6+AEvxrVmVU0+OWBIN7
         Xd9khZIzGwlGzcNzhpSx5gy4BRzpQROLSem2/3WbURtdB30rlJ2+6B4HjSgkYkeCQn68
         x7uCmqH8JGIyWE7xCtejEK+N9Urw/DplkoV1Q=
Received: by 10.227.127.131 with SMTP id g3mr7675806wbs.129.1276641193645;
        Tue, 15 Jun 2010 15:33:13 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id u36sm49368610wbv.6.2010.06.15.15.33.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:33:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149233>

Here's v3 of the TAP support for Git series, which replaces the one
already in pu.

Changes since v2:

   * The tests now run cleanly under:

       prove -v ./t0005-signals.sh :: --verbose --debug

     This required changing 'ok' to 'pass' in a few tests, and
     emitting a newline before ok/not ok under HARNESS_ACTIVE=3D1 as I
     suggested on-list.

   * The Perl tests now properly report failure if they fail via their
     exit code, previously a failure from them wouldn't be propagated.

   * Extra docs in t/README hinting at prove's --state option, in
     particular:

        # Repeat until no more failures
        $ prove -j 15 --state=3Dfailed,save ./t[0-9]*.sh

   * diff --check clean (wasn't before because I didn't want to change
     existing lines, but they deserve to to be changed)

Changes since v2 in diff --stat format:

 t/README                         |   10 ++++++++--
 t/t1020-subdirectory.sh          |   12 ++++++------
 t/t2102-update-index-symlinks.sh |    2 +-
 t/t3700-add.sh                   |   12 ++++++------
 t/t9700-perl-git.sh              |    7 +++----
 t/t9700/test.pl                  |    2 ++
 t/test-lib.sh                    |    3 +++
 7 files changed, 29 insertions(+), 19 deletions(-)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  Make test-lib.sh emit valid TAP format
  Skip tests in a way that makes sense under TAP
  We use TAP so the Perl test can run without scaffolding
  TAP: Say "pass" rather than "ok" on an empty line
  TAP: Make sure there's a newline before "ok" under harness

 t/README                               |   55 +++++++++++++-----
 t/lib-git-svn.sh                       |    4 +-
 t/lib-httpd.sh                         |    3 +-
 t/t1020-subdirectory.sh                |   12 ++--
 t/t1304-default-acl.sh                 |    9 ++-
 t/t1509-root-worktree.sh               |    6 +-
 t/t2007-checkout-symlink.sh            |    2 +-
 t/t2102-update-index-symlinks.sh       |    2 +-
 t/t3300-funny-names.sh                 |    2 +-
 t/t3302-notes-index-expensive.sh       |    2 +-
 t/t3600-rm.sh                          |    2 +-
 t/t3700-add.sh                         |   12 ++--
 t/t3701-add-interactive.sh             |    4 +-
 t/t3902-quoted.sh                      |    2 +-
 t/t4004-diff-rename-symlink.sh         |    2 +-
 t/t4011-diff-symlink.sh                |    2 +-
 t/t4016-diff-quote.sh                  |    2 +-
 t/t4023-diff-rename-typechange.sh      |    2 +-
 t/t4114-apply-typechange.sh            |    2 +-
 t/t4115-apply-symlink.sh               |    2 +-
 t/t4122-apply-symlink-inside.sh        |    2 +-
 t/t5302-pack-index.sh                  |    2 +-
 t/t5503-tagfollow.sh                   |    2 +-
 t/t5522-pull-symlink.sh                |    2 +-
 t/t5540-http-push.sh                   |    2 +-
 t/t5541-http-push.sh                   |    2 +-
 t/t5550-http-fetch.sh                  |    2 +-
 t/t5551-http-fetch.sh                  |    2 +-
 t/t5561-http-backend.sh                |    2 +-
 t/t5705-clone-2gb.sh                   |    2 +-
 t/t6035-merge-dir-to-symlink.sh        |    2 +-
 t/t7004-tag.sh                         |    2 +-
 t/t7006-pager.sh                       |    2 +-
 t/t7800-difftool.sh                    |    2 +-
 t/t9001-send-email.sh                  |    4 +-
 t/t9100-git-svn-basic.sh               |    2 +-
 t/t9119-git-svn-info.sh                |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 t/t9143-git-svn-gc.sh                  |    2 +-
 t/t9200-git-cvsexportcommit.sh         |    4 +-
 t/t9400-git-cvsserver-server.sh        |    6 +-
 t/t9401-git-cvsserver-crlf.sh          |    6 +-
 t/t9600-cvsimport.sh                   |    2 +-
 t/t9700-perl-git.sh                    |   12 ++--
 t/t9700/test.pl                        |   11 ++++
 t/test-lib.sh                          |   95 +++++++-----------------=
--------
 46 files changed, 143 insertions(+), 162 deletions(-)
