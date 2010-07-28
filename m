From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/5] Skip tests using 3-arg test_*
Date: Wed, 28 Jul 2010 10:34:54 +0000
Message-ID: <1280313299-721-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 12:35:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3z6-0006o8-2K
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab0G1Kfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 06:35:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54625 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0G1Kf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:35:28 -0400
Received: by bwz1 with SMTP id 1so3849953bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zUWAqP8ZEg8uKUICc/C9FJ2Lr8XDcdW+X/nPYoc/EMA=;
        b=pMMdfJf+zxTjlUyPz/ylybKSt0lZiEkxnBvKrmF6dj7n+LsibXJ1xJWT2fID2pFdWy
         wnIGoA8mUlwBcpUbb0EIggWHN62Dou0GEcb49iLv/7DLPH6d7B+jGsHvFiGQM12Oiw+E
         H+UlMERvBamZErgaUB8lCB6dh8+Q6KG58buHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=rAs38zSdDGVCvTe93jh/xQifQxbqLLW9G+hrq/96oi2VPMCxXu6NnipyFNOhmDAcJm
         acgcMiCN1OeAJYkkQ+hMP6mdj07BcsfNcmkh5eLJbRY1jOmza3o9DoGtLflp51SbqhN/
         Zyv5B3YHGC8OQF2uHZchfaNvkiVOXYaz1stRU=
Received: by 10.204.25.145 with SMTP id z17mr7685063bkb.104.1280313314610;
        Wed, 28 Jul 2010 03:35:14 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id g11sm4661233bkw.22.2010.07.28.03.35.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:35:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152072>

This is just like v1 aside from:
   =20
    diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-s=
ymlink.sh
    index 85a77b3..92a65f4 100755
    --- a/t/t4004-diff-rename-symlink.sh
    +++ b/t/t4004-diff-rename-symlink.sh
    @@ -38 +38 @@ test_expect_success SYMLINKS 'setup diff output' "
    -    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >curr=
ent
    +    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >curr=
ent &&

But I also split the change I made to t/t4004-diff-rename-symlink.sh
from the "tests: implicitly skip SYMLINKS tests using <prereq>" patch
as suggested by Jonathan Nieder.

It was the only one in the aforementioned commit that didn't just nuke
skip_all=3D* + do 's/success /success SYMLINKS /', so it deserved a
separate patch.
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  tests: implicitly skip SYMLINKS tests using <prereq>
  t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
  t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
  t/t7800-difftool.sh: Skip with prereq on no PERL
  t/README: Update "Skipping tests" to align with best practices

 t/README                          |   21 +++++++++++++--
 t/t2007-checkout-symlink.sh       |   14 +++-------
 t/t4004-diff-rename-symlink.sh    |   18 +++++--------
 t/t4011-diff-symlink.sh           |   18 ++++---------
 t/t4023-diff-rename-typechange.sh |   14 +++-------
 t/t4114-apply-typechange.sh       |   28 ++++++++-------------
 t/t4115-apply-symlink.sh          |   12 ++-------
 t/t4122-apply-symlink-inside.sh   |   12 ++-------
 t/t5522-pull-symlink.sh           |   14 +++-------
 t/t5800-remote-helpers.sh         |   24 ++++++++----------
 t/t6035-merge-dir-to-symlink.sh   |   20 +++++----------
 t/t7800-difftool.sh               |   49 ++++++++++++++++-------------=
-------
 12 files changed, 100 insertions(+), 144 deletions(-)
