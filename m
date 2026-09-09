Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBA531AFA
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952399; cv=none; b=IBZNQo96ofMHJUHiuMON2GG2E8hJqDN2efkWjJ2FMGzHy3oAjyNbgaG5iUDKiDhHJIE1Nq+GROLZsx0v6+mW8v0/U3m0gnnu4VjQmrJQx1TPKvpWqCqWfCblIwqoIvD39lfjxygg9Cp/yJ2co4QCBVIvmY9yynswLzk4TMyKZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952399; c=relaxed/simple;
	bh=hbLQKk6ydhlQz7e0dDEZJ+4svRzLd3TfacLKgqNlz+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoYaQjtWtraMr7jBasQNpCTVLmiWleMInvN8WOuAIBRJPZEiq6KI2lJ4/ChFNNkQLWdbQbqGVCj41NaAXZ5wS614sOcl4TFEO+cKlN1iawmn0kKR51GqTUNItUad1dHtbnIra93pUcnNSL0cQPt2hILjr2U+serNGS1q6+3FznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t4yqqA5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFeuG6sV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t4yqqA5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFeuG6sV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB19614000A7;
	Wed,  9 Sep 2026 07:13:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 07:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952393;
	 x=1789038793; bh=OU28vtP8jhz/Iy+G6CB7elH9duikebqQSyoPQskpNj8=; b=
	t4yqqA5xVmvFUCWP8pAw1VeZgk5vo4dY80D5iF5psulwVD1Lb8zo2a+ScOuuT+I3
	Safhz107u8i6swcO+s8jcS8XojikkOBEJqcjM7+qdWKIslz/JLH8kEBjE11PDWlf
	NWF4opgCh+7x4xPPMILRHAYqB8lo2zSFIISpnrNT7bw1bO8GbyO1MhW1opGUrm5Q
	RexP1eb3dlV5eD6s/4nywO+SPygYUdIEvCNykQkEoNjgsLSlKDS0ENv+Bk9Xd8pn
	YjwMqtuIxxcNhLGatvkznIrEI7LGpPqEMx+ikIV/JIiGi7SYDRaGA8a+/8nev1fQ
	fYWMqgKB1L5uTlgmrJOt9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952393; x=
	1789038793; bh=OU28vtP8jhz/Iy+G6CB7elH9duikebqQSyoPQskpNj8=; b=U
	FeuG6sVKzli3YnrKQyLAm+U89uwrz+53aj3+grz39rRh7F+93Nr83un41ZHucOWp
	naup/yfRUPDL32xvmXadWs7XBD3sSLCg5kqjVG+eGSboHYoRs8MSW0ckbUnWT+UY
	B6dv2UCSNE7LvBPY+zr5VEERXfae0fJWdb4Anl1GkQUCUe1UsMEXP97gdL1kAtZf
	q8bftMBT+EzDsI+lb3dVoAkTFIMk7jpUmVLxW0tdrnD0idi4Nns66Wcp65Ry+pXz
	26JgHL7SCKbrDzhlaGyGYUqFho+e8MpwEO7+S6PnuAvTdn21+i8bEuLnOho4nKxj
	31sOMruqSF8GIEPhlmIIQ==
X-ME-Sender: <xms:ST-harFbaJGCpm-6X_VavfoOElyI2qKC5JAMelC59xxSlTWIwl_tqg>
    <xme:ST-havXQKhRQ0csBCfoBVh97pdhHxqCVAweiQ-Fbw9xBNHXsjDsn0HGG9aVEq6Cyh
    2rm_qToUisPhx-hctezpjbB5w4LH17BmrowyZ3Aug9I6DKob0VWmTw>
X-ME-Received: <xmr:ST-haiIkvZP2n4_IwQ9Ncht3kj3gvX89XXLFIgVtWTjthFi-ODlwu8OG2Ox7PCWdqxnp9w>
X-ME-Proxy-Cause: dmFkZTE3Kr1NBd8JgUfl84Cb5cL1nWUdKmaXEokJASImL17FtufGP+r88gnlXAgjOipOth
    P0q/MAO7driC9DWr9Pb2NSvnMboXAXQWKqp8q78rYacR0TIfgyDDisWpv4xgCjkfxpilFV
    de0BOcTzvSAwUjVggAVO3f0pp6fIXUozrRPx2JvGzCsepeV8jO3cLnixaA4fSCdk4cUvuV
    rWLiAxUXVbAEgGiBosN+gythNumpxzm2a6dIrhwBK6rKLm4zyqnAIVm4MkYADQfX4sBmuh
    t+6+cjeSCFtzPIC/cVXe+1M7eMImUQxfOX84m9qkFZENNlkxbbgX53FSMd/vtpKdV6ooVK
    RHrjF1oLJZiHTU92gTLeSwwIql3P+3EPaz4Dda19YZx+BWLJ+U0T/r75IDzKRq6jKR6uj/
    CFqRjMUiVVBaJv2ZaR3IKpwqqI+Y6BNYKjON7qg3Ezq5dUhUXClNJGL4EmxhifQrEDnU0q
    PHUQnd1+ZnOzMQfhdZrDSbrFmkFkt8qmhuLZy32IO6Vs3GNg1grC/UbKdpcFxETiaL9LeZ
    xSVR9Qj/erjE3uRDJdC5ByGU1JiwXVqxBq4Zm9y5LfrdtnsBAVnXSy9qmmSo8IuAf4GC0F
    dcXPbixIQzem7Ssyi+5H0FdSOVSXcm366LJZZSVx8PdSVHA2u0FOGPD6LbQQ
X-ME-Proxy: <xmx:ST-han_8dnqYX4VYQnZfHeGlhSJQlOw8caZJe8mXy8EJqWeAn3BGrQ>
    <xmx:ST-hatLR2J-nvZ7RMvZVqiyhqmczAk0pj3ObhNWoMt-tfKLW75xzMw>
    <xmx:ST-haklQArRqMiQQqrWsmG2Ow_3f73JnAT7EpGZGIznj7wXQsodd8Q>
    <xmx:ST-hapPYVJIhLlpXzi5NjwKsxKr72JNJP_UyFiDxls8XE0UDNpMQGw>
    <xmx:ST-hatoISFPbubAqcBynfuUl8p6bXYApzD78Ul70s9ptJn2ZuS_TifSh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d2e777d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:53 +0200
Subject: [PATCH v3 07/13] help: rename "default-ref-format" to
 "default-ref-storage-format"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-7-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

When printing information about how specifically Git was built and what
defaults it has we also print the default ref storage format used when
initializing new repositories. This is to prepare for Git 3.0, where the
default storage format will change from the "files" backend to the
"reftable" backend.

In preceding commits we have adapted "ref-format" parameters to be
called "ref-storage-format" instead to resolve some conceptual
mismatches. The build information is now the only place where we still
refer to it as "default-ref-format".

Rename the field to "default-ref-storage-format" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c          | 2 +-
 t/t0001-init.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 46241492ce..1dd8391eeb 100644
--- a/help.c
+++ b/help.c
@@ -824,7 +824,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			    SHA1_UNSAFE_BACKEND);
 #endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
-		strbuf_addf(buf, "default-ref-format: %s\n",
+		strbuf_addf(buf, "default-ref-storage-format: %s\n",
 			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
 		strbuf_addf(buf, "default-hash: %s\n", hash_algos[GIT_HASH_DEFAULT].name);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b4f19d8077..6f4431bed7 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -668,7 +668,7 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
+	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

-- 
2.55.0.1074.ge7621b4bad.dirty

