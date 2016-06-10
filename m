From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 36/44] apply: make 'be_silent' incompatible with 'apply_verbosely'
Date: Fri, 10 Jun 2016 22:11:10 +0200
Message-ID: <20160610201118.13813-37-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnQ-0003kw-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbcFJUMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33724 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbcFJUMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1071313wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+GmFvKgdfR1QRg8UDS2woeOOOFXIXE1qn2rqI+fmfo=;
        b=fzYC70orihKqyIdO3+GiWqrTKaAUe4YHK3DxTTrzPdCkBsd1wVpG6VzuHx0Vlsrj0Z
         +hNmgn+WVMY+bcHh2D5/XxkBtniYe/aR7o0sEKmG38EzuTIeKC0/XbPt0yAC+zF3/hne
         e047e6LK2G17yemto2uwhcxQWFF0ypacpS1aWJUOGBWn7T+OOTRh7kuBHMaSHfYp/Ot2
         /3X4Lp5ux1QAd6LbS02Ht+PZYr6Ux2cuEhXeuQi3Our9Y57brhfA9zuw2GpXwQ9UGV4u
         XbIrZ72+svU7g78eqQY0n+OwP8JeF1+i/QcdaeAgrJl89L7KMT2hlbV4fnsHRb6J6cMT
         fSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+GmFvKgdfR1QRg8UDS2woeOOOFXIXE1qn2rqI+fmfo=;
        b=gblaqYxkMsnNIzuxl4axGAnrx6gP/txaxScYQhLeqKkqItwuMAftBrTe69/YziPo7S
         bKe1Wg/8ylQNO/Zz7RU4jQmKhgo4VFqIemsXKAfp1IA5VqFlABn6timDOhKQSw40FaCB
         iPxj0l7ayC1Ulrbda3q+bfkCqwW2YQfVWZxUOEkAQO0gkvqicBaAx1H1gcs5oiDvf9jd
         PR2bBQCmd/Xz23dpQx9Qru8pCuWv9ckWfD5IsBhDCXO5mxQU05RRPFxmWZkWyIMm6U8P
         TmHXkHm4zzgvoZ1pMuQJquU4Mq3IWvoSUdGqh8cVRq+sCDqqqJrDfcHvlHFyP1qLGgYs
         uK+g==
X-Gm-Message-State: ALyK8tI35kDH+NzANyumGBrMivRVlOWQe2PCtroNqPQ3Jhi7XE+uEoPzbLZ8+W5/VneD5A==
X-Received: by 10.194.164.200 with SMTP id ys8mr3705997wjb.79.1465589560270;
        Fri, 10 Jun 2016 13:12:40 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297044>

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
2.9.0.rc2.362.g3cd93d0
