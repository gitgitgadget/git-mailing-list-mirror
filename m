From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] merge_file(): add comment explaining behavior wrt
 conflict style
Date: Mon, 15 Mar 2010 02:56:37 -0500
Message-ID: <20100315075637.GE8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5HE-0002cv-AY
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759767Ab0COIDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:03:47 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:43429 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759762Ab0COIDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:03:44 -0400
Received: by yxe29 with SMTP id 29so1378731yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jjNP20nvCnPMJlFaQrRDRwleRzcehslbV0UoPnmLdAg=;
        b=Dws3lluxYXNnZJjIeeIjw7kP8/0fxYXEyQ0Vs0sQagNoyKolgOu5HiwCULobPyOJQG
         ueoZgNCLtVbPWckeihAPJ33fz+Uhn3mqIXupBA9esrT/yqZV9p3oRLOIIwsgTVhLsrFT
         uzzsXaqDpDUaKcjEPDkSq1YI0uX4UaMJuWrfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FQ+teBwh1FnzxyzgZIicnX4kJG7AhHwuhOwhPAwSkawLkIrQ5gMEGPG50fc7UqH6VC
         Um2g63L1g8OOn/zS49fkH6I1QOsrq+qlSvX2gXS5HgBYeAt0X1Q2Ngr+A2ZOabEh1Cc1
         B0VIDPZPTz9tWz3iWCmaK804YERbtqTVDNYTM=
Received: by 10.100.24.39 with SMTP id 39mr1504603anx.20.1268639795195;
        Mon, 15 Mar 2010 00:56:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4004028iwn.7.2010.03.15.00.56.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 00:56:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142184>

The merge_file() function is a helper for =E2=80=98git read-tree=E2=80=99=
, which does
not respect the merge.conflictstyle option, so there is no need to
worry about its ancestor_name parameter for ll_merge().  Add a comment
to this effect.

Signed-off-by: Jonathan Nieder <jrnieder@mgila.com>
---
There are more non-changes (e.g., in builtin/merge-tree.c), but none
of them seemed nonobvious like this one.

 merge-file.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/merge-file.c b/merge-file.c
index 07cc0c9..c336c93 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -30,6 +30,12 @@ static void *three_way_filemerge(const char *path, m=
mfile_t *base, mmfile_t *our
 	int merge_status;
 	mmbuffer_t res;
=20
+	/*
+	 * This function is only used by cmd_merge_tree, which
+	 * does not respect the merge.conflictstyle option.
+	 * There is no need to worry about a label for the
+	 * common ancestor.
+	 */
 	merge_status =3D ll_merge(&res, path, base, NULL,
 				our, ".our", their, ".their", 0);
 	if (merge_status < 0)
--=20
1.7.0
