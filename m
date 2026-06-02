Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B23C8C71
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390481; cv=none; b=U8eCKnvU0PccHtl0q798hpCG7jgMDTyk+qSv87XH0egpVdAApANMsp6UoWeTbOixzShubr1D3cJnAHq3djtzGPMGTMIdguJ1uv+KagK5v+AMQS59x1jz7S7g6zQmRCEaKqLuK54H8N0VAc5+1bTMcUSKF60QH8dG2boVMWtgt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390481; c=relaxed/simple;
	bh=Za0rpKbI5UnnydOnxLCS4/fIkmtX51xULZpg5+lBUDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDQ3vLg84J9FaGJFD/3VR+2O0Z5lhIPQFYM7C7Q9ql8sHN3NYsdO7hPWfjiqn6ub1cQk1YaGdflslsPwy0f5rrUwUkbUk3SXuAzioMu5qBlabpy1UKzpQEfDyj/K2TRuF+9Ye7YdN2p9dyk5Pr/BQy/Ed+Ujo84EQ/4KwgNUm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=leMJtrbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgtN2VdO; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="leMJtrbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgtN2VdO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5AEEE1D00105
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 04:54:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 04:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780390474;
	 x=1780476874; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=
	leMJtrbPgFDm6j6N2RGoo0Wx2UIJ51S/JPtKSXijJvScawh7nn2Ea1lMpbju4nua
	BLNTneEPRiG8wvVW8u+5dCOzZkhoRTjqwKZstHCXUYG7Wffs8/JBjxSUZq5BfRy7
	/qM4CRZ0AJmNd1nrhPmLTmqZeHqhlvFRxakIZz0j4lccBlbHR8ieugdmPQmjTQJg
	c4Q4HWG0ewHj69iVWCnnb+WouogAjoUN7ed16mmAl6SZRCqmC1kkkvfguF8eDkCc
	7RB2hcQRwTHfO1yfgi+9yEDtQlBFeaAV/XWu2r9rX25r6ClP5uAm0jDBYlN6lJBg
	Y70gNBlgPWaDYBBy7dRUcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780390474; x=
	1780476874; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=b
	gtN2VdO+SIoMopABhMxQHCJ6CvGLwSTivJhTDjExCzZPHjEmTiBphwsbgrRK5Cps
	2PVwsMnoUTNSbvqX9xxRLUOeoWG6ir8/4TA6MYHWbzt67Gp/C0lZLEulGb/vsDdt
	ekaz5ASUOhV8fNMSe3z6gGEV7z6k+ZJ2NUPUPYj9rMP8YOPY0MsGVcA8QExQc9Qm
	AjJZwrSLjZkdEI+yaGb0eSlbCP3snq4gxvDG6FDpsocTgBIFlAjQoNjzaljDrOlx
	8Wy+djVQXyOYhRl/i7zmPZ9A5D2efus9ETnSnMvhjEQ/MM3SnOKwOwK3CFcAa6IY
	lZQ+p2XDvpEuATcWWcp8g==
X-ME-Sender: <xms:SpoeaoGjWV_W7SirhXdKP3fWQ8M1j-HJX6M7wirLm7gfYihfRvCCgw>
    <xme:SpoeaoSYnGE1u_pSigrDHnrghPl-LlxARjMKOQ_JhmUslIPm7CwpXjoFhjTz7gxZQ
    b1hymqXNjuk43f7OnXc0OVzaTDuQTTEhDgOHpm5HXCvvlROUTfiiZM>
X-ME-Received: <xmr:Spoeanzzhc7tI4a9mqgsefeKq9K8I3r80QFVFH0KT1dUwfPxFlT7YuAV8GiQhI9E4geZHGQ2K3PxrCsBBvaD-H97eAJpJi4shT14yaxIaA>
X-ME-Proxy-Cause: dmFkZTFdQn6gsMGq1HJIsMmjFp22ncYSmQVrk8WevwfvWUwjkYP+l0EtrHNsIg01q1ff3X
    E37NE+m178xRjRu99NbLGz5MKMtaeaBs0B6mKzawuRb7yJdBfg6fuvPHSMkn4rlU//Udo7
    lp8Srj327b7nCrzI49ha0BbdGXquGgzds4UZi+QZU8nhaYv6aKiW+qweISXTpOIR99SLYl
    6bkP5qdcDHEc7UjwNeTj0JN7845FSnbKTMtYI5JP2PexlEAE6vNqXu8B60KWNaxxE/knyZ
    poiJyneUoC1Polw3xchqoNSCAebhWyxVCiDQRc09BAQYa6idF5WLfL3AFIUPsQVHQuBNGp
    gcPNYYctI2fyieb9WC2gn40FgeQH4nE0Ph0iyYtauTDSOjA+1tytF9SlDuodwcrXjl5eXu
    5jGn8MytA8CiT7/Bfi3dwUDDJNhzh4Sb6XPc2mdLrTdDASY8B0Sleea2LJlahTL6UWMcnO
    aDx99g3AiumjTxtG08u5hPmp+NFdOjWIlP+wiuMGC1YGcjV+cmZls7/VpC/KYwOjZfTpue
    Fn25iDp71RevZrJBiE7NvIzwpLDpSAo97gzXE4OQYXl04F39QGRO6RqFK8XSV1e/ZSmJ3t
    PAmH5SNVeAY9VkGqauUewRG/i8FJ1gB1SuJqL+LZbo3nwE8mvuageal3X1sg
X-ME-Proxy: <xmx:SpoeavOUj65ODE5q5DbszfDT1P6K3conlJktLHkWqPpwd37wXTgjFA>
    <xmx:SpoeauOyHf4OgfRjP2GTAchu3h6mMbTZMpuY8QReP1GBkdZXNc8uUw>
    <xmx:SpoeapQJTGbVygULBIVbor5_njRl7TF6SkR85z6yWz0dfb21IDkBKQ>
    <xmx:SpoeaoAVahrHrBZJ8U7iKwY5x9KXnW1wcvqC4wkCN9VYnR0bOmOO-g>
    <xmx:SpoeapJW98Gf_F81LVWMq5PWgdARudoNeQl1CjZ0nDWcOAAlCkhliRNC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Jun 2026 04:54:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9ba4d54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Jun 2026 08:54:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 10:54:27 +0200
Subject: [PATCH 1/4] t7527: fix broken TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-t7527-fix-tap-output-v1-1-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Before running the tests in t7527 we first verify whether the fsmonitor
even works, which seems to depend on the actual filesystem that is in
use. The verification executes outside of any prerequisite or test body,
so its stdout/stderr is not being redirected.

The consequence of this is that any command that prints to stdout/stderr
may break the TAP specification by printing invalid lines. And in fact
we already do that, as git-init(1) prints the path to the created Git
repository by default.

Fix this issue by moving the logic into a lazy prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7527-builtin-fsmonitor.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index b63c162f9b..d881e27466 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -25,7 +25,8 @@ maybe_timeout () {
 		"$@"
 	fi
 }
-verify_fsmonitor_works () {
+
+test_lazy_prereq FSMONITOR_WORKS '
 	git init test_fsmonitor_smoke || return 1
 
 	GIT_TRACE_FSMONITOR="$PWD/smoke.trace" &&
@@ -50,9 +51,9 @@ verify_fsmonitor_works () {
 	ret=$?
 	rm -rf test_fsmonitor_smoke smoke.trace
 	return $ret
-}
+'
 
-if ! verify_fsmonitor_works
+if ! test_have_prereq FSMONITOR_WORKS
 then
 	skip_all="filesystem does not deliver fsmonitor events (container/overlayfs?)"
 	test_done

-- 
2.54.0.1064.gd145956f57.dirty

