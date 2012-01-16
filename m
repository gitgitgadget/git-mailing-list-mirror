From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 00/10] nd/clone-detached rebase onto nd/clone-single-branch
Date: Mon, 16 Jan 2012 16:46:06 +0700
Message-ID: <1326707176-8045-1-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:46:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmj97-0002Yj-3G
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab2APJq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:46:27 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61203 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab2APJq1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 04:46:27 -0500
Received: by obcva7 with SMTP id va7so4312998obc.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nNTzdrlA5oNufySQCORWK5gPPbVnGPUIUTcFcAAS5Zo=;
        b=wUW5F9VPY6LhYxfoMEc46LAHFiU6y4cWxc1eHIhpZTRNAxxNJABkiTSjKX9jn9/NJG
         dCu77WJ372MiGwyFCN3wFJ9iJFq/pZmOEdQQ7dYtimwyYEJGv69YkApKvG/YX9kXy65c
         nbqmtD0SdZHTdYDEycS+y+pHywHQSgn2HYGVw=
Received: by 10.50.222.193 with SMTP id qo1mr12308185igc.22.1326707186366;
        Mon, 16 Jan 2012 01:46:26 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uz5sm7062817igc.0.2012.01.16.01.46.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:46:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:46:17 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188615>

There are a few more changes than just a simple rebase so that
"git clone --depth=3D1 --branch=3Dtag" also works.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  t5601: add missing && cascade
  clone: write detached HEAD in bare repositories
  clone: factor out checkout code
  clone: factor out HEAD update code
  clone: factor out remote ref writing
  clone: delay cloning until after remote HEAD checking
  clone: --branch=3D<branch> always means refs/heads/<branch>
  clone: refuse to clone if --branch points to bogus ref
  clone: allow --branch to take a tag
  clone: print advice on checking out detached HEAD

 Documentation/git-clone.txt |    5 +-
 advice.c                    |   14 ++
 advice.h                    |    1 +
 builtin/checkout.c          |   16 +--
 builtin/clone.c             |  297 +++++++++++++++++++++++++----------=
--------
 t/t5500-fetch-pack.sh       |   22 ++-
 t/t5601-clone.sh            |   40 +++++-
 t/t5706-clone-branch.sh     |    8 +-
 transport.c                 |    5 +-
 9 files changed, 249 insertions(+), 159 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
