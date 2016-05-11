From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 87/94] apply: make 'be_silent' incomatible with 'apply_verbosely'
Date: Wed, 11 May 2016 15:17:38 +0200
Message-ID: <20160511131745.2914-88-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5J-0005C3-MM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbcEKNVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34968 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357AbcEKNV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so9415386wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lxehMvFwEPBjd4ZW7lDnBRp0jWYzQJicf+9kOil7Sco=;
        b=L6kTYGR5F3MRFJ+aILcPzdBGJJ+XbWqLPVyOhIvpYiAe0lUD4Xkqts8mzAElE+17bp
         PYi6oHVuqs09OnzLcDNsjHqqvG0G+/Vg3Y1JYVlFYBpSiuLQKJh26EzekXOOTtMm6ebv
         A3asOla/pBg+j7Oi4UPXZKLNLoZxmQllVk/Eyp+lL5aHdXGunVNZ4xehUD/EMnbtxI1E
         3/VJyC9BgrbXmgfp2hj/0rv0AmFEq1K7RWVn4BC58Amyo//w8yGk3CNM0cZtyL4xRjTY
         Tr9KvStAez2B1JlqiMllrWdoxaE4Apx36dneGFYIeKPPJhjhpq1WX0n+kTOrbMLiSkIg
         iqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lxehMvFwEPBjd4ZW7lDnBRp0jWYzQJicf+9kOil7Sco=;
        b=ma5mFrzNxnuIoG6Oq7PhGA3gZPOTBH3dpCH873vmknCEstFnr0CU+r1bjboE5x2/7O
         LkZvuBzqxYdYor/QrB3KSifalIzCwMqeG41c0JQYEfm+EpzFH0EOOP+oaXfb/FW6GN8a
         f5FE/uPy4tzAagS/UMe9Zm3RGtyWDAvCdIBABTeLuS9ktUglPxL3LBcoT2JF841zU6D0
         6+xgns2wn/Ppvba2QeOe4yLivB4aUCdXDj+prR41kthZLHpKUPG0cUekpJWqMCuzemgW
         ZGzfwEXY0O4AVSUbY9sgqZYOW2t0i0RtFn86iCrEKI7CtH78+ZqwRkaaY++WlOCAXD2B
         /Vnw==
X-Gm-Message-State: AOPr4FU8EAq1PgepTYaNwYzyMdTNMrqMDuL0o/2X0fGFhTmu6siVtc0UJh/Pr3TLrae5AQ==
X-Received: by 10.194.66.137 with SMTP id f9mr3803604wjt.74.1462972887141;
        Wed, 11 May 2016 06:21:27 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294309>

It should be an error to have both be_silent and apply_verbosely set,
so let's check that in check_apply_state().

And by the way let's not automatically set apply_verbosely when
be_silent is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index f69a61a..5459ee1 100644
--- a/apply.c
+++ b/apply.c
@@ -113,8 +113,11 @@ int check_apply_state(struct apply_state *state, int force_apply)
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
@@ -126,6 +129,9 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	if (state->be_silent && state->apply_verbosely)
+		return error(_("incompatible internal 'be_silent' and 'apply_verbosely' flags"));
+
 	return 0;
 }
 
-- 
2.8.2.490.g3dabe57
