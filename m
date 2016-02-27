From: santiago@nyu.edu
Subject: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Fri, 26 Feb 2016 19:27:44 -0500
Message-ID: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 01:28:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSkB-00078s-MY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbcB0A1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:27:55 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33071 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbcB0A1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:27:54 -0500
Received: by mail-qg0-f43.google.com with SMTP id d32so22456123qgd.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 16:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RMdIDf4AVtvqUJoA2KTZh+ZlOUR/e77rCrokX91VnNc=;
        b=YXrYRnL+nhYnzJy2+rEYOegCSHRtSlNqEnRoi550eWzhPZY+VdtIZ04SCKu+4fKyML
         cbGBamXWI4AB1RQ6hfXF+gIHb1lM0lOtcV2EAeWzYWfXhXHHwq/migmjdCDCABFFIzez
         PYslmsvc/Vtdfc6HPQGFZqZbVhbknLhSzsTk5x9+wOSYf659SH9LgcbQiJfLQ93BtulX
         1oeAH7+6ZhsKdfuVcsJ/FyrTacsYNBidswcxKvc7YcftcQRYgl46NY4hEkvnzc9avGbl
         njXDWGBBSH8evFL65DqJkBIU2ba75NVJRFrwoYUiTP6QJRSpIZcD7GEFVS/1uyNk0F8U
         4N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RMdIDf4AVtvqUJoA2KTZh+ZlOUR/e77rCrokX91VnNc=;
        b=V3JKo2TQTQAtKbjjxLCwyS/QRmfK33I5NyKjMUUzffDKKF03N65nUC5U3butAy+Erm
         zEHxiVIFrj1y7/n2UIrYSs4nhWj7pw/kggi3w6/XYRVqR1rGqwWXjf23efOIAhxROfiC
         zA/Y5dJGTms7xI90PoBGSMZ9299iruk7lLTi/DlGbBFHuzZywUwdU/4jc2oZtU5aEI1r
         R2NS/iE0Gym08FqNcAj4OSj84c1o6GwmFYrxwiFa1UBSAkQ3lZ/No/yJf46p9+Lm5/Ez
         CIkdUkdknXhzOgR5YTvApdFqhG2LXseerAzEocDiXw7WffZH2zG97s4vAL2x58yNbEdl
         PB2Q==
X-Gm-Message-State: AD7BkJJLY9yQ0NTU+wtGLoIAouU3Ex6tnECRRcYDtLJFJcqf188SGjQBkbm0idZKDEfrjGfG
X-Received: by 10.140.43.67 with SMTP id d61mr5639677qga.18.1456532873767;
        Fri, 26 Feb 2016 16:27:53 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-06.NATPOOL.NYU.EDU. [216.165.95.77])
        by smtp.gmail.com with ESMTPSA id z132sm6380809qka.14.2016.02.26.16.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 16:27:53 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287649>

From: Santiago Torres <santiago@nyu.edu>

The verify tag function converts the commit sha1 to hex and passes it as
a command-line argument to builtin/verify-tag. Given that builtin/verify-tag
already resolves the ref name sha1 equivalent, the sha1 to
hex_sha1 conversion is unnecessary and the ref-name can be used instead.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..5de1161 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -105,8 +105,7 @@ static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
 	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
+					"-v", name, NULL};
 
 	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
 		return error(_("could not verify the tag '%s'"), name);
-- 
2.7.0.435.g70bd996.dirty
