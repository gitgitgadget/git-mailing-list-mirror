From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/16] merge_file(): add comment explaining behavior wrt
 conflict style
Date: Wed, 17 Mar 2010 07:05:46 -0500
Message-ID: <20100317120545.GF25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:06:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs0D-0006g7-UF
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab0CQMF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:05:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:26722 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0CQMF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:05:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so187472qwh.37
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J//3W5Iy9xy+Ah2gITy/2mNbnzah6Fs7M6+iBa+0BU8=;
        b=Bsytofuufmax12HysgBccyaEekHWeKLTIXyTv805Afwz0C1QekeOKbaBspEeY2HbWC
         hGPG8Wklrd+LaRDi+1DuASQtktDlmdxo8LNvX814PwWifTOs+pixTHH5VQzaPPoby55E
         h0H2/i/uuFIi8Lcs5GQZQbvPJx2gk0skHQWao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZdBNlAAHp2Tm76f35x9ldWtPewNiRrX3RvUSaNr0aCHVAnIxc6f0o+/dhOEi0yGpUs
         /ARJMJCeU125HEUUkzoFbR3GxQLuqKj+hx47BR6IjWju5cDagbXUtrCvWY6Rb+ZnqzTq
         Q74XNUALmwPEXy4o/Gd+S3aLfztMosvwKu6Vk=
Received: by 10.229.191.76 with SMTP id dl12mr469361qcb.97.1268827521245;
        Wed, 17 Mar 2010 05:05:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6376101iwn.1.2010.03.17.05.05.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:05:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142381>

The merge_file() function is a helper for =E2=80=98git read-tree=E2=80=99=
, which does
not respect the merge.conflictstyle option, so there is no need to
worry about what ancestor_name it should pass to ll_merge().  Add a
comment to this effect.

Signed-off-by: Jonathan Nieder <jrnieder@mgila.com>
---

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
