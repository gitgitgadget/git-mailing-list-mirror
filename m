Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3A36D50E
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349462; cv=none; b=oddPZpJ48+tsluUIpiY0fDAYcQoJsiz8B0KkqMD8W6E3lGHVlwylNU9I/tSVn0FAH7gVe/HEaJpw6hyYZJhGxm/ssX27kRKRJBd3A2B24PkoxWUQZjvvh3qjBms3r7hUq23tOI6Ex88OPCXfvxNL9QbuPraQWFImSy8LbfJLp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349462; c=relaxed/simple;
	bh=g7HCXNj7x3PX0SxVVxCAWjT/bYftrapt6+1GtvU9wiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhv0QO5uZKW6IQisjpUTyABj/0g/pJVPednnY6Cwnx0naG42KM2pwErfBOlGS/R09/TFl+5BmEPUFA0+3AoyUQkCneT3Ri+MnGCXBEdSYMy1yfNfd23yELe2/b/LDrD4NjJhSXZXG/1r/FSHGYSxibL9XKBajFfM/dXOTp5qASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKG+0shT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKG+0shT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso2544645a91.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349461; x=1771954261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm/9f+B+xdtEgmcEP/xfT/GgQqkboYpm5Wm+t+omwrI=;
        b=XKG+0shTQN+ylcjNROW9DsZCrK44tNcGO8zU1EJlad99gS7GuuzsaThgSqLIAuX4id
         MeaslFVpQhJWp8i1ESGewMR2nTJ3cq4XwbhoCp2/lisIcjQfnBr5Hf66GZXP9ELErn7o
         x+HhWSBUdayuYqaglFqsxjVPOrs0MymzdGM1Trqsbo+GE2aZvC4YbUBqj9PnQpPI5War
         V1mhn3RlPG9r1BL8ytbQENNl5ZX0T4RRRtLMaJiXkz5CALlT801wF8ikMpbHPRnXXZ6+
         08f+zM7q4TEIlf0xOI01jWhnAla+Jh4YJxs5Ws4OYuvFDU72w3SJfvg3UjRIo84HTPn5
         V5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349461; x=1771954261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm/9f+B+xdtEgmcEP/xfT/GgQqkboYpm5Wm+t+omwrI=;
        b=eM6PBUgMRwsilrwfOVoDU6QepHU8dYGHABLu5gPPWf95SLIrAAublisQmVKI0K/pM8
         YsLOxrJDMKlFkgPUBR7netAzmJYCJBwzz6SOwCGhPNWYWHlgMvsyW8yfQWvMrXdRneC5
         EmXc0MDd1Te2lKGa4ltdEIEGs/dOoVsK4O5c2JKeKQ9aolkPIblduafmI/StYMz/LcZ3
         DqsfiYB0HngnRwHso9CAL9JEkFjuFm0SQGqRKRgmHJ+wGuQ7W2jIJoCeMKBMZfS9uPR3
         +NJBEvgbLOjP80j6ntoCnPg7TDE0PRzva/oKbqo+yHcAMuqMMWHe7YGHlEunE04oFLj7
         R99Q==
X-Gm-Message-State: AOJu0YzmoEp0MjPyS2wFqCH8TlOTz3oc/IUvwX218rpjxVylpvWIXyqZ
	lhGeZ9E57U/mGPZYDfPef6FDB+vArtDYW9iJsybWk0Gc1IDG2b1MHFi1spLL5itWiLc=
X-Gm-Gg: AZuq6aK7TRawXpEi/J8Zteeog/H2wRfQsL0mFy5qnTxpalGYJrg6g2YrmSlKuwvqME7
	g+XT4wOjiXp017ZvLAUiwPM+G3H3DKn1ljVI1gzmzPm6qhatz9bOhqOj52GthIAa6feuDw2a1eY
	vboYzzrPOa+jryCmTN3PWY85N6Oo1edv/TrdhK2+eJA+mZVwcduxiXXgxHq6oEpeVKuMRIs+HWn
	le5VrIJlhsD77lsxqQMsMwISTEyvx+IesblA72KXt4F2Hd2fiVb8q/JE435hEhE3WiKNYgeviK7
	8ufRr3rU5SbTSP1SaY0dd0xPvx7hf5ccE4Lvw9zIvvm3KJcJX0KnqbM4MYAAWQpKY3BDIBpEhve
	Sxje3Da3AyWsar7OqJQm0PTQvxVi3/h/QoCamEhiAAjpWWl+CqmRNY9iSIHc+ZrSrQ6oGlqJwG8
	+U02yCLaOmef0nQPsj9VyQTpfUCaxnzuOt5Wci72n8ofRbsW/PngG5/B7/DA==
X-Received: by 2002:a17:90b:5387:b0:353:5595:3246 with SMTP id 98e67ed59e1d1-356aad3cac7mr12954686a91.21.1771349460680;
        Tue, 17 Feb 2026 09:31:00 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:a392:d36:fa44:db83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cd1esm24135222a91.15.2026.02.17.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:31:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Tue, 17 Feb 2026 22:59:48 +0530
Message-ID: <20260217173037.63438-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
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

