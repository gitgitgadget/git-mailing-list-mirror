From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 00/18] setup tests
Date: Sun, 24 Oct 2010 19:11:32 +0700
Message-ID: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 14:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9zR5-0008WA-NE
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab0JXML7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 08:11:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48679 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0JXML6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 08:11:58 -0400
Received: by pzk3 with SMTP id 3so478419pzk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=pOXDgOqAIBs8dIpHLrp8/RFVC/1cIHyj7TwBnbjGCxQ=;
        b=tEdacWezQ1/g5VR8CM4yJbvs124EM3TGpjecy35O5m3ZecP8DCUWmY6JJsfV9mxK7z
         98zlsiUnd+7o7BeyN+Uffnpo6JJP57LJqkkbdUqrmeKIUuSeNoSx18OqgMKZPCBIac/s
         wDCpknnjlseJ8Bw1AeSIG+Aat9We7WzpK0SKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NcYPjjr+sH3zLWLk1/0ixXdO9vKL5qJFEgRALi651fSe/nPz9xxYCPZAorf2qT46f2
         utmj8Jf61x3WkvixZ4llLpcBawTYXgOSqyGim2GahGGSC3lSu9KNMnXgF7/v9gbEL7Kw
         Qx+22Eae1bMsiTArMtHFGP2nycADfSDIiqrEk=
Received: by 10.142.192.17 with SMTP id p17mr3772858wff.386.1287922316333;
        Sun, 24 Oct 2010 05:11:56 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p8sm9123587wff.4.2010.10.24.05.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 05:11:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Oct 2010 19:11:51 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159857>

These tests are created according to [1] and its following
discussions. I have yet to create tests for the last 16 cases, which
might be simpler.  Tests from 8-15 are usually copy of 0-7 with some
modification. If you find bugs in 0-7, stop reading 8-15, it's just
wasting time.

The rules are bent a bit the way the code does it, specifically:

 - GIT_WORK_TREE is relative to cwd, not GIT_DIR
 - core.worktree is always effective regardless GIT_DIR/--git-dir

Also I assume that when cwd is outside worktree, cwd should be
unchanged (therefore prefix is NULL). This is the behavior when
GIT_DIR and GIT_WORK_TREE are set. Let's apply it to all other cases
where cwd may be outside worktree.

Adjusting the expected results is not hard. So it's up to you guys.
Once we agree on something, I can update the tests.

Also when GIT_DIR is set, .git _file_ is not recognized because
setup_explicit_git_dir() does not accept it. There are a
_lot_ of failed tests due to this. I probably should fix that,
otherwise tests #8-15 may not be very reliable.

[1] http://mid.gmane.org/20101020085859.GA13135@do

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (18):
  rev-parse: add --internal-cwd and --internal-git-dir for tests
  Add t1510 for setup tests
  t1510: setup case #0
  t1510: setup case #1
  t1510: setup case #2
  t1510: setup case #3
  t1510: setup case #4
  t1510: setup case #5
  t1510: setup case #6
  t1510: setup case #7
  t1510: setup case #8
  t1510: setup case #9
  t1510: setup case #10
  t1510: setup case #11
  t1510: setup case #12
  t1510: setup case #13
  t1510: setup case #14
  t1510: setup case #15

 builtin/rev-parse.c   |   11 +
 t/t1510-repo-setup.sh | 2483 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 2494 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh
