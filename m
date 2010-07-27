From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/4] Skip tests using 3-arg test_*
Date: Tue, 27 Jul 2010 21:14:09 +0000
Message-ID: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 23:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrTq-0007qP-TA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab0G0VO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 17:14:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42099 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0G0VOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:14:25 -0400
Received: by bwz1 with SMTP id 1so3597805bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=TKNsGvUNjLLz8gkfk2R22qQgvKXwvejV8rC5w/vaK9s=;
        b=Zqo+6pajFkq416ZM+hfURbW1JeB8fvZjw/VFrsTAGFPn0kkRsVukdM/qPxrxvWTc/O
         urlzrotR3f376OxP40Vw28IIYtDKiDoP1wCqsuIaEBmDD8jWq2mQWPru2FOy0l454nXi
         B+Ds6YTy/nkjdgLd9n5fpr3WUMVlFUZYVRuw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EQSyDgtLVaVf3nTAlZLHJCQe+JMJ1kMt+WKagSEVYQOiekyzT4uhd1TURIJu2cbjKR
         griVDVzRPEPyMLEth0INF4xaNVIDcux5hUxwUpJaYMIG3kbVpyLdLCcbIhA3NvMZJZCB
         gQ3x+dDwDK4T5hEZl7y9beRS/rQ48B3OoyyLM=
Received: by 10.204.143.138 with SMTP id v10mr5073934bku.133.1280265264114;
        Tue, 27 Jul 2010 14:14:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id y2sm4172562bkx.20.2010.07.27.14.14.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:14:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151990>

This is a cleanup of the test code that I had on my TODO. We should be
using the 3-arg form of test_* instead of skip_all + test_done to skip
tests.

This doesn't cover all the cases that were using skip_all=3D*. The
remaining ones were too hairy to trivially convert, so I've left them
alone for now.

This also includes a documentation patch to t/README describing how
we'd like tests to be skipped.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  tests: implicitly skip SYMLINKS tests using <prereq>
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
