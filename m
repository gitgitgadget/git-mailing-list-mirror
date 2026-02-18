Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71230B514
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437445; cv=none; b=jSK4MwYEhjMsPS6vxfLxVzCUrwm+pvAinprwxP1MijZaExDPgtD5OPLg1rNU9GdH0H+60sJs/dSrZ4XodC4yOOirxTHPjyuPODg9gh4SjhzlaOhFdfLIA4jFvRUp0WTP3LQjXyMFPE2WVFqMt+9/f2CutV7sj87rdlU2h+k3xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437445; c=relaxed/simple;
	bh=g7HCXNj7x3PX0SxVVxCAWjT/bYftrapt6+1GtvU9wiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvmTQjcMkJf83JP62yXikNYRJY55SuPlbVtAZ0wRAJjBaA/mQ984WxxJnZyWfNsCJwZ6kMW68UFmD2YKdA1qICReBlEmFtXr6YPlG+dnw7rRJ6WM7RWxcKrDaDvH6SFb1WhCh05ULTbjVeXs8oP0QuT6+e2d1SEL0QuwfY8IL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTk1UsVd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTk1UsVd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-823210d1d8eso27007b3a.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771437444; x=1772042244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm/9f+B+xdtEgmcEP/xfT/GgQqkboYpm5Wm+t+omwrI=;
        b=cTk1UsVdpk0mWk63sq+Dna7VSP5BEe1Ic9BlY8OQ5zCBgaDtl8Fhs20RahBdTYmvTC
         DCF6sATm+kPNmKy6RNd6Qmn9d2yYS7esrmlbQKQsklZDonf8LOuqtYPv56E9h1Qpb96p
         nXFsliCgNCXIqH6wLxYQvO5EOOXvPOPFDMvTvfxVDprKwtTDbbTNBBg4S40EGcO60hnc
         T4o2+MxUK8o23liOp+CiLV6bO+PQV1BYPP7/ZprEFe7i/7koR8vtlJ3H4zN+dHHokT9e
         kvAN3MHQiB6tj5ww0SZr1kzrOa/CVVMvbivOIGpO71DYvLGEW1Yu9sD8l5kTGCXgs/v1
         /f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437444; x=1772042244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm/9f+B+xdtEgmcEP/xfT/GgQqkboYpm5Wm+t+omwrI=;
        b=gZgqyQwCYpluNkcM/40U3SLsPZAaxGMLyuBHMasbXBIjG7vkOKWNStUAui+u1kQqTe
         0lD9Tz+12XdrAm4x805V1YU7fIxgaI1LolCCSkLFFrTKgLmDMcxa6/1uPa7Iczyy32lC
         lDP5LlA2hLCWu9/qQs7+/JYbBrZTIdxhRa+e0uTm8U6h5mmRUHB+6SZP6zuCO/zbHhHk
         XNNoe1BZi6W9r8h8V56IXQj8xT59+Xoow2zBcKU/fkyHLS+GrvRN1uj4NxLEe0dpses+
         dGAl9FOy5ugeSZY04pIRQmeyiosoQAqJ2LpvG7s835YPZamX/uVJmNHlZAIsMjXCDjNa
         4DOg==
X-Gm-Message-State: AOJu0Ywnpex2A4QZI1ri6OIt1H8YcOJKEls9pvul0MgJ4pZMo7bJF1aE
	cSmjHTDpcC7TEuvOvFq3/crK1+a2dtNGkjuxA82ZbIjvNEN71sHh17B4DnnH1w==
X-Gm-Gg: AZuq6aIuwoekMIWSNZ0cO7ldcjUgvvYeZX1x37KoSrEHXThF5JM/++OpEhoEbQ1Ig7Y
	QA6Yu70eade0QJapG85qb5/7SAMY2MNWdpebSrPteiHkuU3fFaVMzwT+0o+UuZo5B2wbVG0h/05
	ptBEc8SCVXGKqoCMMwsDNVcB7MCGWozKSnXk65a+lPiSnEfpvGw59d0J5oHd01OG+xsp/nHklAS
	undqmZAJQ1eJzfDgmo5MVBiw50D1pkuqPhCD30kF8TW9Z5cib8jOIC+pn/k8dJSvrWOicUPZTLg
	jYIo2ognXwAyHT66EDzXo9Md0arhXhINTknQuiZMg9WErhhzgkehK20nsiCXXiRml6DpK50e7up
	NsbWd139bolzwR2A3/VBTHKtDpDZ4IkvX45Kyf7joKIFyRemU7AFZ9nQWTWbA8kMye8rL1NaYqk
	fgeaxHyy4EyNk6Mj29s8Qo+nsYe9oguFLqVTYlRfISIkFCEtCNI3eNDd/exw==
X-Received: by 2002:a05:6a00:1d98:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-824d94cedcamr12280590b3a.6.1771437443867;
        Wed, 18 Feb 2026 09:57:23 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e531e6c51sm13440957a12.16.2026.02.18.09.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:57:23 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Wed, 18 Feb 2026 23:23:42 +0530
Message-ID: <20260218175654.66004-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c still uses the global the_hash_algo even though a repository
instance is already available via struct wt_status.

Replace uses of the_hash_algo with the hash algorithm stored in the
associated repository (s->repo->hash_algo or r->hash_algo).

This removes another dependency on global state and keeps wt-status
consistent with local repository usage.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b44b8377e5..264281fb67 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1815,10 +1815,10 @@ void wt_status_get_state(struct repository *r,
 	if (!sequencer_get_last_command(r, &action)) {
 		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
-			oidcpy(&state->cherry_pick_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->cherry_pick_head_oid, null_oid(r->hash_algo));
 		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
-			oidcpy(&state->revert_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->revert_head_oid, null_oid(r->hash_algo));
 		}
 	}
 	if (get_detached_from)
@@ -2630,7 +2630,7 @@ int has_uncommitted_changes(struct repository *r,
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(r, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(r, r->hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
-- 
2.53.0

