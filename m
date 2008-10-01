From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] checkout_entry(): CE_NO_CHECKOUT on checked out entries.
Date: Wed,  1 Oct 2008 11:04:08 +0700
Message-ID: <1222833849-22129-9-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
 <1222833849-22129-7-git-send-email-pclouds@gmail.com>
 <1222833849-22129-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:07:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkszi-0001Sc-DT
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYJAEGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYJAEGF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:06:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYJAEGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:06:03 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BUuiiNW2tg08gtOX7K5JcbR7uiWHBXVi5SXv3NjLVbs=;
        b=qT1jsxKVhupFri3oiwZz/sOzsC0lsBaqDSBZKKUxcoiT4kevXd87gEuPj9sHALRDzv
         M+Oe9r2hBvbYfzExOssBC9dEXC1sORJbuLgsOH1xbBkxcEkSpaQ2MPPqXE1GaJ5MUM4q
         zjkAs9IRCJgoTvkHC042dNXmQ96QwTJKT8Gus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WnGdIKpxcMah/KChCyDflKIXr5QPD1L2DtbL8Z+qTjsCPbnAQJQ57gGnDqO0gLtRqL
         3bUJORFCuLHxnlR6SgtvUCWXTW5PMjyxTEL0SVdFPkzZPFRx/fHWDREvIj1sHckXuTjx
         Qls5IbtnFEDYxX5Kj6OoFNASs1Sez+dAO5LG4=
Received: by 10.140.201.1 with SMTP id y1mr4024734rvf.246.1222833963560;
        Tue, 30 Sep 2008 21:06:03 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id g31sm3938712rvb.7.2008.09.30.21.06.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:06:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:05:56 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97199>

With this you can just do "git checkout some-files" to
widen your checkout. One caveat though: caller must save
the index.

=46or all of its callers (unpack_trees(), checkout-index, checkout
and apply), only "git apply" does not write index back.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index aa2ee46..305f8d3 100644
--- a/entry.c
+++ b/entry.c
@@ -230,5 +230,6 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, state);
+	ce_mark_checkout(ce);
 	return write_entry(ce, path, state, 0);
 }
--=20
1.6.0.2.488.gf604a
