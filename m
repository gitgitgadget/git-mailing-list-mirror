From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 01/10] "git read-tree -m" and the like require worktree
Date: Sun, 2 Mar 2008 17:33:16 +0700
Message-ID: <20080302103316.GA8902@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlWH-00036k-2l
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYCBKdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYCBKdg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:33:36 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:40776 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYCBKdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:33:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6063513wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=8tlK0HTZ2FPP1spa2Al2HJBRqnbGQG7i6lpV4LEEJWo=;
        b=xLiktN1j6mLVjU5kiaVUxcVd6gbzoxgDN4+cqMgDP380jqCe2ssZiBCLy0anoUeyKddbXZv73aECfUKgeSUlDt0Ahaw6c8ZqNfVNXXISTPoCVA4KviLuavL8igzNj1egf3KU4UjCi5kZB8pvlyGb/yaKbSLGzT2sWOWN+rzgzOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=iFg6rXLd59zBAUAcznsOmxmYU73CASRGep91p5nkjW09WBSeeoE2Lh7EY88f2REnSQ9onpNS65GlJUJlwSy5M1zrUjHAzjXTCFA2GRMhjvQmy5dYo+DaIeFtiKPpsOEZbz3Ek7d3lnRpDFudWB5pdQmv8C7+j+NF/K/I1hpUV5k=
Received: by 10.115.73.20 with SMTP id a20mr7722196wal.32.1204454002318;
        Sun, 02 Mar 2008 02:33:22 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id k37sm18488637waf.55.2008.03.02.02.33.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:33:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:33:16 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75761>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 0138f5a..a69bac4 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -220,6 +220,9 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
=20
+	if (opts.merge && !opts.index_only)
+		setup_work_tree();
+
 	if (opts.prefix) {
 		int pfxlen =3D strlen(opts.prefix);
 		int pos;
--=20
1.5.4.2.281.g28d0e
