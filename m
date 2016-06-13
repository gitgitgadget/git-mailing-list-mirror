From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 7/8] external-odb: accept only blobs for now
Date: Mon, 13 Jun 2016 10:55:45 +0200
Message-ID: <20160613085546.11784-8-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfz-0007VH-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbcFMI4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33101 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161119AbcFMI4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so13087437wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSrS3cprAS4ZNVEqKsdPJm0kv24WL93Gi844eiL3gH8=;
        b=a6nS4NTb5vfb1EYIyObwMEt+yJaEUvZSJCqFaQ3tjSXxCc8cEZsLfkcrwLmXrNkdNQ
         3DzL9U7PkV7CtBMlbQa2ANZLDj3IZi0xGcYs14EZ7lf88+c4KTEDlFSV+PNkz/ezBUqY
         4T8+HY3Vb3Kh9KmS0XIl/4xkJAD/u+Ji+WpfOxUu1wUlmYIJM8gf98ABifjlcnKrbZmL
         RFmJ0HvBCV7Ee7jj80P86ui54FcIQOAbNE0tIOqSL09Dguf1USMQUnsMw6rDV2BtdFOY
         /ux+MdDCW8WVFiplQ1+lJMjXpTT2KpkIWZUyowDFsAdttSfaNC5IjTNp3yK3Ebc35wN9
         XIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSrS3cprAS4ZNVEqKsdPJm0kv24WL93Gi844eiL3gH8=;
        b=KDzpQ3Bb/Ivw7tl/dxa+gxCc/W0AHOiNRQlfHG2SXuie3G9o1JbhEH+46Ajzro9Dop
         u+jYTQO/N3282A1/jNn2AhojdFHG/QODbgWViFN9aBZXv3CfduUScSfKlUxTNpADdo6Z
         Nf3sRuLNyuVrJue6bic2Wo+XC6ng4TtpRAa/fPOVGkWta31fQx9LDHY7ILZuzFn+cd0U
         M0t7uccFcEutFJJgucalpdA0dNTwIPSbynmWaTgPL5d34Okz65BxeBxz5IrBc7JPleW0
         QnCBW14+yyziTNede6y42cU6G/vjd+9+jaqTNB1U9CJaQpSJeaWf69VzorDSx3ivM3fB
         7wlA==
X-Gm-Message-State: ALyK8tKrwUXQkGIRLuKZqAzcDDP9DiHmjmv7HTGNKrysObRsY2T+HUN0lVOOsgdEbx303w==
X-Received: by 10.28.133.210 with SMTP id h201mr9908808wmd.86.1465808171634;
        Mon, 13 Jun 2016 01:56:11 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297169>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index bb70fe3..6dd7b25 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -133,6 +133,10 @@ int external_odb_write_object(const void *buf, unsigned long len,
 {
 	struct odb_helper *o;
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
-- 
2.9.0.rc2.362.g3cd93d0
