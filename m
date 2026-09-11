Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FA485CF9
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133262; cv=none; b=NycRpRwsyMIo5JWQ2Pm3Hx6j5evxpSen/9SgrE4Y9pSp8eRkCAeh5o/SeRJvjCZD+B8BHK/+S2XAEhP2p+jzBLPkttEzmhHEurXu4DCqyYyzxIEcSdJMDLbk9k8bWNmpDq2iAinVLbEjJoEm6Mpl/nlEg4UfWxX1DT0BRHomNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133262; c=relaxed/simple;
	bh=NpedClaBYZGn/vgOY+pWp7JHNISD0l/15Ef7rAJx28w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXgdDIBpGleORnTXxq2dkVHMqw+Dui5W8dPeiRwU5oas+OnPnfZZH58+3a90Me3ycHVE0ETvuJM8nkDQF9nVMWZbfL8S78xM0OqHVFVwMPrMaxQcRjKEx1XNokLujmuI34lLUZ/QP5cWPfRkh+lzXBwRwgtYP7S/kQ/xPqx4xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dNO/4bOo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxXjVMhf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dNO/4bOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxXjVMhf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 704FB14001CB;
	Fri, 11 Sep 2026 09:27:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 09:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133260;
	 x=1789219660; bh=NLse10BLpr5H76+yw3cUdYDhuGjzsk8pew66mGHq4oc=; b=
	dNO/4bOoiMfwXNaTnUYjBpajkYCuzVV63sWXJdQYd7fjhrkToB6lxveEgcXcI7jc
	24MrKvpMh+lY8yRt5ko/Wkv0MagAwrYKbe88ymPSohMFbemoLlJI7AB5FjR0gS3P
	28mYI9l5WHej30Jy0n6QXSjC7cmWmYtUClZWceEKo3mP1dBjEQYXrMw/CY28Ybsg
	qAeuBM+DNInjx61wvayS0GW1+qjYOWb6VAqhlHYx5muiNuQhprzK2McGW+pPhIUE
	+WqMMRqoTPI+Wgl9QWMwxZRslCTVPVrhjDqzfe/2kb1ZMVdF5QBbBnzz+6RZWnUZ
	lIzHK/9bwuuFIFi/JnyitA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133260; x=
	1789219660; bh=NLse10BLpr5H76+yw3cUdYDhuGjzsk8pew66mGHq4oc=; b=U
	xXjVMhf+7xHadSzmhZBM6p+vx5qKAiG/4YGYeuS1RqDYJYQY5e2RAXulg+i3YTlp
	OpxlhkNE/VhsoAeFzh+8Hscf2L2KknpTwEzm4lXONP22+/ingcVRLDCWXxFvInoQ
	WnAu6sBfjdACKnO/LoPQx+trm1OYFmE9jp24J2Ux10JOLfAv4MCimmyW+Jbik6ix
	rzupkCRQZW+haP1sDJ9vEcZi3+JqCN/loM9yMNPdI8Bq/rEVYlqUweVxxAc1Foud
	ImyIcl8Y9nctOktr8Hwfi6B215rCopaDPuT8YrXhBVY/TrUQ3XvEznHjP4UN/ltd
	m8Kgh4SKoALMCt9shU2LQ==
X-ME-Sender: <xms:zAGkak3w1L5etJtbOlGmI_r0j6BgygTyGlCFQUYM3Pq23Awoz7GCEQ>
    <xme:zAGkaiWHCRJ96n3n92ltHSXqJotMvM3IUqWuQLcCmLFOvT592oJdgeUQQcx6bkuF9
    F_LL0klCr9LyKsAxQMi_D1-0-IHsyhbGv_C-ipxFXA-982tZ-fPCK7l>
X-ME-Received: <xmr:zAGkamVMYNKiSU5P7HWDCWTML8_yROF38suy8ctuglXHLRMsuPwBr9IwjmpzGo8ZGyvwMQ>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9qG
    rqKXa2ml1P6F+u34ZLUqE74RclJR6zramWxXMPO0phv8kaLCtIG7plWm378TW0t5ZC2+Gh
    04p5IycBoPJoekG9tIKz74fAodlcdnDe95037n0U3RvCVEuaeeOBoOdsdvmqoxBzHWBY++
    v/We1C4eLYAIH+i5YRnMdeOVrqV8Ml8GW3xm31xnu00nmaWzQ0m64DuB2cvBM5HK6RfP9k
    njxjiQA966mkQu4CkBcvB+IyR6e5PB/FL6MQAouVyKbmYZLShkx4IsAXqe88VWLS0e2XFh
    AsgeF7gchz6GqJSU9BEoEbjhPBC6GLSHzOirs+dJfUi+LzT6kvvgaSmuw4wg
X-ME-Proxy: <xmx:zAGkapfAIIWr4Qarsmq4sisM07XneUNPkK6vsvDk0XnoDwX062ienA>
    <xmx:zAGkanUrv6O-HJqM-EmoQAvM8Hvg1RHN2Z1fCJ-X2c1CchphJlmtBA>
    <xmx:zAGkaqeoH22tM0383AIJMBbq18yYNgv66-S8Bv55MDVLtN3lfcxh2A>
    <xmx:zAGkarOZI5dnKBUm1wLCdKV8JpHmGpjiK9RyKM7Gi28tXcfIrfOUMA>
    <xmx:zAGkakTec3wnELnM28kiRoR8Sghqn334tDOwuVGpre8UWhCNmeUac2Bp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 130cd252 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:28 +0200
Subject: [PATCH v3 04/10] builtin/fsck: don't check alternates with
 "--no-full"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-4-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

According to git-fsck(1), the "--full" option behaves in the following
way:

  Check not just objects in GIT_OBJECT_DIRECTORY ($GIT_DIR/objects), but
  also the ones found in alternate object pools listed in
  GIT_ALTERNATE_OBJECT_DIRECTORIES or $GIT_DIR/objects/info/alternates,
  and in packed Git archives found in $GIT_DIR/objects/pack and
  corresponding pack subdirectories in alternate object pools.

So ultimately, it is supposed to control two things: (1) whether we only
check the main object directory, and (2) whether we check packfiles.

In its current state though, the flag only controls whether we check
packfiles or not, and if so we verify packfiles of all attached sources.
But we also have checks for loose objects in git-fsck(1), and here we
unconditionally check them in all sources.

The flag is arguably conflating two unrelated concerns with one another,
and it really should be split up into two flags: one that controls how
thorough we want to check individual sources, and one that controls
which sources we want to check in the first place. So ideally, we would
have:

  - "--include-alternates": check all sources, not only the local one.

  - "--include-optimized-objects": check not only loose objects, but
    also those that have been packed. Note that we explicitly don't say
    "--include-packed-objects" here to be more backend-agnostic.

  - "--full": implies both of the above flags.

This feels out of scope for this series though. So for now, simply fix
the code by honoring locality of the sources for loose objects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c  | 3 ++-
 t/t1450-fsck.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5132ff0f15..3f6056535f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1047,7 +1047,8 @@ int cmd_fsck(int argc,
 				    mark_object_for_connectivity, repo, 0);
 	} else {
 		for (source = repo->objects->sources; source; source = source->next)
-			fsck_source(repo, source);
+			if (check_full || source->local)
+				fsck_source(repo, source);
 
 		if (check_full) {
 			struct packed_git *p;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 77cd96de78..1b4074304c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -844,6 +844,11 @@ test_expect_success 'alternate objects are correctly blamed' '
 	echo "../../alt.git/objects" >.git/objects/info/alternates &&
 	mkdir alt.git/objects/$(dirname $path) &&
 	>alt.git/objects/$(dirname $path)/$(basename $path) &&
+
+	# Without "--full", only the local object source is checked.
+	git fsck --no-full >out 2>&1 &&
+	test_must_be_empty out &&
+
 	test_must_fail git fsck >out 2>&1 &&
 	test_grep alt.git out
 '

-- 
2.55.0.1074.ge7621b4bad.dirty

