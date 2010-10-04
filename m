From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid warning
Date: Mon,  4 Oct 2010 09:21:11 +0000
Message-ID: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@NetBSD.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 11:21:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hEn-000835-Uq
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab0JDJVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:21:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43019 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab0JDJVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 05:21:20 -0400
Received: by fxm14 with SMTP id 14so1561142fxm.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0XySSaGe8VPOjOEY94FUISEBVwunldhqN2ntmSh6Yxw=;
        b=vAd6ItOnPYg+FxUDcg9ekQcqYppdZp4cSGPv5ZZct/ZU8kqy3KAjz6J4I5h2VwxNCB
         R+hb/CvoaEoEhSlw3PlhNo5z+eYabRKgUpJ21PrTsQm7nt+fblrVLxErIjM4VNVexu6m
         o3KJ8NSmw85f297VHOcmNQbmK43vaJ5KmMhvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=GdG1xW8M1KS77hMCk36m4elsy02XU1LCxeCqmZqWyyfSvhbMMkyEsKBqDHUkoixSNV
         5UZh4a+N4+WJkjrCoUreYzj4nOkefoa2PDq9heJefFG/laa1NBuyjNm7w4m0kMkYvnL6
         /6dyuVazdKdSTNuReJjKGvrPZa4oK+bPRD7Ss=
Received: by 10.223.111.11 with SMTP id q11mr8603786fap.5.1286184079284;
        Mon, 04 Oct 2010 02:21:19 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a7sm2046868faa.21.2010.10.04.02.21.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 02:21:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158014>

Wrap "S_IFREG | 0644" in parentheses to avoid a "suggest parentheses
around arithmetic in operand of |" warning from GCC 4.1.3 on NetBSD
5.0.2.

I spotted and fixed this independently on NetBSD, but later found that
there was a NetBSD Problem Report that included this fix.

NetBSD-PR: http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=3D42=
168
Reported-by: Dan McMahill <dmcmahill@NetBSD.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..e8b7e09 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -93,7 +93,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 			      int argc, const char **argv,
 			      struct blobinfo *blob)
 {
-	unsigned mode =3D canon_mode(S_IFREG | 0644);
+	unsigned mode =3D canon_mode((S_IFREG | 0644));
=20
 	if (argc > 1)
 		usage(builtin_diff_usage);
--=20
1.7.3.159.g610493
