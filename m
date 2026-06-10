Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D491DB356
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103459; cv=none; b=LCq+Y+MktS2UccQSsuToY5tqUv6mSYE6j3pj8ZeNjf5xoAUX17mdgL9674YdAVWZZFjXWS0QJUvsdpZLgauJCxMMoA9xRVJPI9zKYFQ48MpEBHtuwOpaP6ooXgzHjPEWkVlryc0dAI0O96JkJZw81Tp/dJpfvNDIt8sNALnHLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103459; c=relaxed/simple;
	bh=syql5EV2E0fnTz3/XJ0nhzb0YGgn4yV9D+/lglGZBcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9TUWszqkjHLHV/9owUUxvsftJEqkxnsa1MfCJtwWeWjVF1dAal9fep8PzgMuOvbV+Em+SS6gfrr+SY+yNYi4BH7nNrS0unPlfjGVHH6bMOpAph7EDnW2rUeul1ZvMuHHVTwcZaE7d1gnu0TrH0VdNcc3YXhQSwWE8tn8HfJBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sjrhzSKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPCUKyhu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sjrhzSKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPCUKyhu"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 798261400180;
	Wed, 10 Jun 2026 10:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 10:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103457;
	 x=1781189857; bh=VwZaMUsROODjsuP99vXQ+K6wkudMC8pOZS387O+8ZiA=; b=
	sjrhzSKc9n/sUCbDav7CBfASGnN9vMJHgSAWeoYBuZ8a8Iqgc/F8hACh21cs+JoF
	jOPopcQHblGLbddtfbGlh2tgiwKNIHYAi9iVkCkOkWU8XiUBywnPa3hY+1s3wn2W
	JVqM1qR9dkqTGsm9hXZmKCCKpX1JGAIDzn0ypB3xPD494cNJhiSyGMN8kz0PHH2h
	nmSJindOpkSyM9TK9A5QsblxNjtEsQMGHTuHztqGSWsUSbzLWYRQenujRztjwofT
	/mXBybTE/eI423mxoWGziFSlyefyjJIZpyxLy2tnATjqjPX1x0o+JY8Zwh7s4ItB
	LWu9Dxff4xTzg/vue5YL5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103457; x=
	1781189857; bh=VwZaMUsROODjsuP99vXQ+K6wkudMC8pOZS387O+8ZiA=; b=K
	PCUKyhug2NpW75f/RGmVjHKjkTqIuOUXXrfLRbgS8zYqume3L8NxVECx/UhOVJhr
	EapW9LHKSecPkKvrbQIMRxsZ36mJIJ2zf9JdQAUhykjjpVu+hcZI/AxIFE97ENKi
	+PPbLa+h8yYPYpyKDPoFAg7y9vHXBt2J2m8FH26oKHEhRtUn7ki/4OuHuVJDBAz7
	tPVml4FUbAWMuC8U5xUVLzCXas7LyVvjlxOLO9Z0uRAJyO2gIdX0wvIUDOf6djm6
	lynZO4dXm7k7VLOjFQHEUsKEITx8ejScglsk6MOUmzl3Vi7TTG31SVV9D95sFaJD
	MOuANHJNEYcgaQzRVSvOw==
X-ME-Sender: <xms:YXspaitWomLpuK4qptjNTE1-y3TSRN3n8XH3xix3dta9G3HoRRdTIw>
    <xme:YXspatfxwGpR9X7d0KF0oEjzZWmka7wi0sXYO5NI7DzhdQkwfG64dORZPEjuzy_CQ
    Gb5PXx2IgEX4ZVJ26ikJeiSuLGS0GE1ggUHU14sQiAiwL5IYUY04Q>
X-ME-Received: <xmr:YXsparYY62Xmsa6wRIbUWXiYzxm99qifD9_yluxaicNHuMeMWqGpMz2gtVh3NQz5bfWrk20SC57nDSCtKTGifSISTsg8rUFz9jwxi3i71g>
X-ME-Proxy-Cause: dmFkZTGGDIv7UKfdrq0F0Y5ZMusWd3/oSa4L2w5TcrIRi+/tkHyPCKVbzpUd2iWFjE/Vxx
    8WD2y1OL2rZyV87G9Xs/4n79Z5KP5ybBR9lyrra1wdYkKeo6qYpWIMpPWZ/dVSPeuzNjMS
    RdJV9Y1b7bZN0S55WKRUXOFfaWFHeouFPDRlVd9kchWJx2sIaCWwQ4VXGT9dn5u1weO2yB
    qb92gmlCdwx3/C42nJk6sVaQZtpKIjLhjMofqbVbxvg7BRG64J14ZdFG/AgP7hQ2xfAWQB
    Kp3n+P8W5YJbiW1FKaTRqeY8F7INWwtx94q40Vy4NbNFSQ1Im54FdRY5O7LjZt3pYnEkSh
    XlCWAdqD/f6F7NtRdxFbRlWzZH8x5tO77v14KwZYpd6j0EbyFOlKm64ZjBsa90uLX+OpV0
    6sgOgcgxVKu51RkCoAZ8xphE5DzFHWjfYsjcVvtOZvNACqV7ExGNtwBFAsjqzQcvEq+/fk
    p1yEHSHKP3ybGIjInVsLQUXB0BSgnlxQU8SD/VRH/ey1gW8m+KnhcXzkJ18pr+vIgUh+8H
    bzaX3+3tSJZdo9uzOLb0lPZXOAIBijJYbE8feJHnSRQz7tKG+PTNne0/U3Kr4RrWvTtTne
    71FlSO3j+SirSkyJp7fhsJ/xR26HTeFX1cDyHVBaPBOa6jeNy//0Hkp0pEuQ
X-ME-Proxy: <xmx:YXspaoVS72CzAztTh2xKYLbV9qVmZo9yZRH6YV11L8kJyh9__Dyq3Q>
    <xmx:YXspalgebJyHh9CcAZIN17Y8xZg-SuPaZAyADVmDmZhxD-8zsdgX8A>
    <xmx:YXspauXmA6SD-J3nRclC386HtAlQyj9ilPynVYpJs9FwWkcHLte5rA>
    <xmx:YXspakPAy6OAAs9H0K464EoTp2ta3RvJkDkiCfDAMB2mfxiZi6q99A>
    <xmx:YXspatd7VWz-nNjXMUahSelWVyuifNO-70Hno4TjkxOH9BflHjHDZQGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a302542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:12 +0200
Subject: [PATCH 6/9] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-6-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.54.0.1189.g8c84645362.dirty

