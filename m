Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76145563C
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685052; cv=none; b=IPQNZe61KOdF7XzncLGCHwcKfu9eaZzyQEOUDKEkfTKHn9WlJD6Zkk8B/zmqcIecmHMqFOzHnS7hR3lvuEqY8X7Br6UUrjDJoNW7b+CHDnLdNRRPDTtNUe2PLAn7OqIF75l5W8MSuruQjACZKC5vsr/DzpX5xrmBGu4sfB2nrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685052; c=relaxed/simple;
	bh=GE9DWn3eGz9f8y1UyuxyU/L5CfvnQg7SJAPJ330eFUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4Vi0xIJB9P06j2f3CsrqmntglbGaGb83L8OYcYCE9eRoPFHiCqp0F7AmcqCLu3oJjgIdqU/0uBGIn6YL9vNJMCv8CEC0gYFbHhi/z3oVzgIzKbHToFg31F1qiTaJMIVvUjLF78WmaX0fI0qgK44uN5mtnJUdEfDLnD73EpYBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=R5NAeKyj; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="R5NAeKyj"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd7695so78624fac.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789685049; x=1790289849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s20RmoEQqk/HbtaOAGQ4puFAITzolFvB5YdsB57V370=;
        b=R5NAeKyjREEsxNahrm5B91F2+cG+rVG/BVAzupLV6oYnUfeTKBhu495JnF8oSEt8O1
         9SWWaamez/0YSK0tVdXDz9JA519Hg86R0vrZdYdxsgxrFAM044OkXB6Gf6+IonH5wgxj
         4zZO535Tou1Uo3YV1tBgUJqXSsPxAyBIpGPPNRd8N2tZyigUGrloNqJoPuVQ9gMHkLby
         VWlC/ms3YgBLMCswSKoBQUOiOQe4fkW4ku5E13Zi5tkJGPCARkQiTAsO4YeepLX/enEZ
         1z3v98wiamvFzJQB9ENBgGw4yD0GxIzuMxBT1idS6K9SHwVlbQnSTIjje2fNkjU0YrGw
         OZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685049; x=1790289849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s20RmoEQqk/HbtaOAGQ4puFAITzolFvB5YdsB57V370=;
        b=TmKTakMePpNufRM3oyfSccrnSYDI7goXfWzkug86HZU+Z5ei5q6NqTQdIm6a3pdacv
         cHhw3FWYIyvjm4tkOkNTHujvZFtkQbnRoG92uMWxyBoKMiQba0iek0Uwx9gm1In2osom
         hwBTQP5LUyqII4kXAJJ7ySCr5Lxvs3bWYV22BTknHlfz5RKqY0Wh2pe97fmymVvA6r4d
         FDr9uT5stwPWkiWzGkOqMNyjox/7dMWO2eijyeLVna5pvtcN0TcUGbi+5SXG0i3mF60g
         xpGJn/l7EDbP9KqeQaQiPNWbcOgUj8qaRKW9ATP+nthaZSM6ITv/6vHSfA07rB/dmG4y
         aEwQ==
X-Gm-Message-State: AFuF++manjcYpq91BWJRlPiF1KHAnReSHYlo29jLtR+KdOSoSPTyYRGb
	cl3zGEXyjEETI6Qmh823NNvkPxTZVIWg39GGjxU97zMyyDJ05NPjoKZjUNZ0zkflt46VaHIzFF2
	AABVAR8o=
X-Gm-Gg: AYBFou1fxLbi4siPZp3XOgys0ZmN5T23YjLud7HJTaDlTrSFKugK1k9bAJotblP3O+D
	kc6E/wDTsdMXfh1Z/PDs0ugbE7ikub/dEmSRIhj1X4pk4+0LOCrNqmWp0HmILUXjdEvhlhgGUzo
	GkUXibmUiFadwQe9WA0wL22XiUml46+aMPNDOdcwzzRJ9SwK8NKe3nDIZuoN2IjUVSWFFFN0I/q
	tuP/pk7qoLtvapH0sOvNKi5V/tP7rzfjS68d73p0vCvRBTYtMZTkPr0qwxlyODD51dcfj6qDw1q
	DA9d0veWh96ZFiqjKvCnIO7yHtixT2zSn+hPqOiBD653cordxVRZzDoSo6FYKN5JVPobbVvbk+j
	ZwLmNVT64wCbi3LwkLl0x+57iBrzHJnXyLGzagft4uwx0x6mEoGIPVeJUeLNcjCLZkqLV6ukmFi
	nD3fJzIcr9cAkPQtNW5xYXgl+O5AUs1u/grXlY7Iya9Ytn9LTya+PV2tduUXFT5oVtkCEuLew=
X-Received: by 2002:a05:6871:3865:b0:45e:d2bc:7b74 with SMTP id 586e51a60fabf-486e4df8cd0mr742115fac.8.1789685048951;
        Thu, 17 Sep 2026 15:44:08 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-4870b586bcdsm72838fac.13.2026.09.17.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:44:08 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 3/3] push: --force-if-includes should allow fast-forward
Date: Thu, 17 Sep 2026 16:43:51 -0600
Message-ID: <20260917224351.57171-4-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917224351.57171-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260917224351.57171-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In set_ref_status_for_push, we apply --force-if-includes's reflog
reachability checks before fast-forward rules. As a result, valid
fast-forward pushes may be rejected when a force push is unneeded; like
when the reflog is expired:

    git clone repo.git repo
    git commit --allow-empty -m 1
    git reflog expire --expire=all --all
    git push --force-with-lease --force-if-includes origin main
    ! [rejected]    main -> main (remote ref updated since checkout)

Rejecting fast-forwards is a mismatch with the --force-if-includes
documentation "Force an update only if the tip of the remote-tracking
ref has been integrated locally."

Instead, defer reflog rejection for --force-if-includes until after
determining if a force push is needed.

Remember the reflog rejection reason as needs_force_reject_reason. If
the fast-forward rules reject the push for a ref, show the reflog
rejection reason to preserve existing behavior. But if fast-forward
rules allow a push (a fast-forward, deletion, or new ref), then a force
push is unneeded, the reflog rejection reason is discarded, and the push
proceeds.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 16 +++++++++++++---
 t/t5533-push-cas.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index b7b5ac0d28..1ea1d2209c 100644
--- a/remote.c
+++ b/remote.c
@@ -1669,6 +1669,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
 		int reject_reason = 0;
+		int needs_force_reject_reason = 0;
 
 		if (ref->peer_ref)
 			oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
@@ -1693,16 +1694,17 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *
 		 * If the tip of the remote-tracking ref is unreachable
 		 * from any reflog entry of its local ref indicating a
-		 * possible update since checkout; reject the push.
+		 * possible update since checkout, then remember the
+		 * rejection in case force push is needed.
 		 */
 		if (ref->expect_old_sha1) {
 			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else if (ref->check_reachable && ref->unreachable)
-				reject_reason =
+				needs_force_reject_reason =
 					REF_STATUS_REJECT_REMOTE_UPDATED;
 			else if (ref->check_reachable && ref->unverifiable)
-				reject_reason =
+				needs_force_reject_reason =
 					REF_STATUS_REJECT_UNVERIFIABLE;
 			else
 				/*
@@ -1746,6 +1748,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
+		/*
+		 * If fast-forward rules rejected the push and we were
+		 * asked to verify the reflog but were unable to, then
+		 * reflog verification is the right reject_reason.
+		 */
+		if (needs_force_reject_reason && reject_reason)
+			reject_reason = needs_force_reject_reason;
+
 		/*
 		 * "--force" will defeat any rejection implemented
 		 * by the rules above.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 38576917e4..53e241c5b1 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -421,6 +421,33 @@ test_expect_success '"--force-if-includes" should allow forced update from HEAD'
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow fast-forward push without local reflog' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		test_commit I &&
+		git reflog expire --expire=all --all &&
+		git push --force-with-lease --force-if-includes origin main
+	)
+'
+
+test_expect_success '"--force-if-includes" should allow fast-forward push from tag' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		test_commit I &&
+		git tag T &&
+		git push --force-with-lease --force-if-includes origin T:main
+	)
+'
+
 test_expect_success '"--force-if-includes" should reject forced update from differently named branches when local lacks remote ref' '
 	setup_src_dup_dst &&
 	test_when_finished "rm -fr dst src dup" &&
-- 
2.47.3

