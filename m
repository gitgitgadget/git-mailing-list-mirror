From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] git-sh-setup.sh: use "git rev-parse --show-cdup" to check
	for SUBDIRECTORY_OK
Date: Sat, 27 Oct 2007 14:47:21 +0700
Message-ID: <20071027074721.GA12606@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 09:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlgP1-0008F9-Mp
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 09:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbXJ0Hrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbXJ0Hrb
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 03:47:31 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:61932 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbXJ0Hra (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 03:47:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1009503rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=5DuyzP5vd3/HBYqLOjaeJ2rcFtWeLrSYqGAo5jRGcp0=;
        b=Y6EziaOYhpLxPXy7ylnvxK0nbIHseRQ0DKGR/dBVi0fyKCq+cjmNhO2dsj453xAJzdWZQolAkDntRCA2aRqE80PDSL/zvTEZk0BzkAHP2N/GF6YMLJa0vucf1sCjmQbE8deZNgPlZ0nMvNbAi0CMAn/IeqgL4gWeF2V0ckmVNa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=YfS9iTWzDpN9P9hZVt4MJ+HCeQzM9xBaZtOJ+z9+VuvgtirRLycwxO+yiBu0JuBi4n9aFTzOpwGNriIaMxm5kTm9ryY1/IQjfW6HZ2LuOXtO6N0buCuvLEBjGtMpz6JPcEJ+hEg+UFus/+9ihHaL8Ys3HzELJl54CQ+MPFZb9rQ=
Received: by 10.140.126.14 with SMTP id y14mr1912620rvc.1193471250117;
        Sat, 27 Oct 2007 00:47:30 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id f42sm8234178rvb.2007.10.27.00.47.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 00:47:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 14:47:21 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62467>

"git rev-parse --git-dir" trick does not play well with worktree

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 3c325fd..86d7d4c 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -110,7 +110,7 @@ esac
 if [ -z "$SUBDIRECTORY_OK" ]
 then
 	: ${GIT_DIR=3D.git}
-	GIT_DIR=3D$(GIT_DIR=3D"$GIT_DIR" git rev-parse --git-dir) || {
+	test -z "$(git rev-parse --show-cdup)" || {
 		exit=3D$?
 		echo >&2 "You need to run this command from the toplevel of the work=
ing tree."
 		exit $exit
--=20
1.5.3.rc4.3.gab089
