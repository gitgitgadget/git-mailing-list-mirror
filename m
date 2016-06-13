From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 34/40] apply: make 'be_silent' incompatible with 'apply_verbosely'
Date: Mon, 13 Jun 2016 18:09:36 +0200
Message-ID: <20160613160942.1806-35-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSF-0004Co-8J
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424980AbcFMQLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36277 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424967AbcFMQKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so16002072wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=roYyJapqsC6+hVxm4zCOLQuZCKY99xBlJYK855NNDLA=;
        b=iXcrhU3u5V/7rZFklFJIVoP8FQv7gssry+1g0eqEQ6f2uxYWd5iiS0uqlyiNG3w/Ve
         Tfr84PaQAOSSPxLnOS2gSbgv1z7BRXP6tIDVHM7V4Xb4AacE3ZtExhC6de5b+XXxTfO6
         7IrOt8o/drhUEpQh74aWKzG9xig3lnhZcAiq19EwkhKoTDCDQz77hnPbK46ioVzbPLdD
         cuGew7YNRM3tbJiFYYDVkArUc7DhP5fDeQlWJjVRHfNp4f0l2hLv/jeXfh935XnlDkWj
         0o5+2SAMp/nqfWbg+vLmNWo7B+Z4xf+IXVcMtZ1YQmTNJNGsqTDO4ukvJ64qSZa2V48q
         rq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=roYyJapqsC6+hVxm4zCOLQuZCKY99xBlJYK855NNDLA=;
        b=XMPPZEzPxWNl63D2WU+nQ9+HCArVlUAthQ7o5XTMF5BdcxvQ9LhSdCxKXimuc4LUhY
         XQqEfSzC9kuUn3PfGLT0L9DNzW5dcOCdX/ZIqCC1Eul+S+Bj8dQ0SCTJK96Dxr9+GBqw
         vLV6unvWP1A2RBSOxAONMI04nfLYBu5q23m7cFEMJZW98Dhw9ZbPKN80qiXfh0vUuQp7
         qksIkVzhg7w75dTz9iPzJt63uk7lUa/MiuLzVVzZk7Vvz3AfvNAa/beV4DaaamWH4Pmq
         LgGsdEMKmlw6eGod6iwviqm7CAztxrOx7Rp3B5noOHWGOyE8nDu4pD+dW15TN8GiEMqK
         3e4w==
X-Gm-Message-State: ALyK8tIw0Drhxw4qDbWzdlUX20JoXo+iXyTkCUiTqdsRtIl0AytF/GllioC8G1XRbKlB+Q==
X-Received: by 10.194.81.8 with SMTP id v8mr1886133wjx.155.1465834254497;
        Mon, 13 Jun 2016 09:10:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297210>

It should be an error to have both be_silent and apply_verbosely set,
so let's check that in check_apply_state().

And by the way let's not automatically set apply_verbosely when
be_silent is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index dbb2515..dd9b301 100644
--- a/apply.c
+++ b/apply.c
@@ -122,8 +122,11 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
+	if (state->apply_with_reject) {
+		state->apply = 1;
+		if (!state->be_silent)
+			state->apply_verbosely = 1;
+	}
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
@@ -135,6 +138,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	if (state->be_silent && state->apply_verbosely)
+		return error(_("incompatible internal 'be_silent' and 'apply_verbosely' flags"));
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
-- 
2.9.0.rc2.411.g3e2ca28
