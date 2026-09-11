Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D114BEE32
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165299; cv=none; b=C4/jjX9t2UC8i8msEdNNZjrwHUftOB/AwxUEtWZQ2MjZGxCeHPmBjYcZR2t4htH6+fxGHB+TnjEWtJx5cbY3UGG4P4V6NIKJ88iQaXtocBQf7vESf1DQ4N7fTziPYzWaLvWfveJMxO0mgXdA22v+Fp+cbscR6fwJb3mLZLvlZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165299; c=relaxed/simple;
	bh=rLlVfhX8Sdcsm/gLt5ynt3NTzdzlwMZAyzgWXnmxP2g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQaI8MupMXuykv0Yd3FTj7+xfufQL0CRcS15k2LTTQzJk4cifVdw+9Pb3nCdd5hlmTJFM3zjGs6BTWFeaUzPqZ6OLgL2Q/UX2JWLIWMP5I8ovFFZot3PyK+ct9T1lS6nNUYzWDiHLSy5LEvbDTtrDxfJ4tnqjC5Gp6Y8WQdbOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SKvVSZY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JBq4sG27; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SKvVSZY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBq4sG27"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F3771D00091;
	Fri, 11 Sep 2026 18:21:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 18:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789165296; x=1789251696; bh=jE04D5Ip/K
	fGD9u4Si7GJHD00+Ku7GnSMkbbItx9Yjs=; b=SKvVSZY4bDa7Wdy3YEx7PCPGaj
	tG6BtuiUJn2WoDGtwAlax15pmBJKOBtA3HY5+a//C5d7MfTjtsJwBqN34PrGWdz7
	5vsceyeGQg02sVBijahkiH56Ylwrxs1dkipVmnaxzaClZ5gTwO2R19b/PIHc3EtA
	pF/xDgYUtnxjg2gsRe16h9XOzJCVZkWDaNeHzzMKpbBZ2T3qi026k2b37OtGGqko
	8117XpMmSE9LZKRs0r/itlXXFkO0al7wBoHyw52HjJfIYD3ACyOo7L+s+B0V1WL3
	1MyeYcj5L6Krv83UsrdSASjv7NEgTYFUNCjmJ4JZa3qeqe/YnlT+Cz9aMmiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789165296; x=1789251696; bh=jE04D5Ip/KfGD9u4Si7GJHD00+Ku7GnSMkb
	bItx9Yjs=; b=JBq4sG27KAqfWDTL30fX5fwJk8WNt8ldonECbeMjZiU9nMf5uZX
	k2hIWa1iXPIMje66hG6Q9OByPGMcIMsCTW74vPAlZ0mi4cGOw2zgXjiw9ng0Q1G2
	g61RkMHvHnEd9Y8xWY2LIw8JKf7Y9cu65wMFCUnTIyW0sts/ZgldPv6Omlx4HUpJ
	G5V0NCUwZZ6BFkmiWYvzpET1Oew9Pz7FsSh69ccL9OAILFGKDS3nPaivpBB1GAfl
	jkyypyd/DuEzHhDX0bURiSNzpon0Xzo9YPKOrNHFN74vhYrnQdcyPq57xiPqvHSQ
	AASnJUp/hVel48D8Lx2a4UDb+ZLdN++NCTQ==
X-ME-Sender: <xms:8H6kamQnU5I0ienTkzFEnTcvfohCASzmxFpzpb_BewV6RkczcPx1Ew>
    <xme:8H6kahw9j-OnbPWFwVh3TB4L-2wg46KRXAr3xLtvGtsuyKNrCnjkvr9Ku0uoCXaU9
    iJ-k3-o5_8uTdmEzhVO9v_1aTLxqFanca92cu9wmZQW0GkqsUS8>
X-ME-Received: <xmr:8H6kahcj_WY1z7zB94IkEVuUr_eKmO9WQPk5MZHDDxOXd80-Z1SpBglU7djKfXamR7oWUw2xa-fTAWs2BAX8VqU0deFYEJK6AS7m>
X-ME-Proxy-Cause: dmFkZTFd4eyTH+jEfKmpG8DjwY2iSUZO19GSyQSaCzTp6N4anSLbDYcYqao2/O8cY3AgDu
    rwgudqc5v0kzmea56ioLJ5HEJfNNOOuJ2EQxmxYUZvxj0rCRHY4a9lsTGQeJ1JCfW/buyl
    3aqu7lwOvzMVnaeFWi4YJfJDfPejGp0mefz5Kgh8jNqlN1F4Xfl4FOriCWOP1X5Xsm/8iI
    3FcV6dqbLLULHNrjKeSkLOIQkI2DB6Kn3BPYPjnsjlrXRhl3pe69X0UySw1B3txoWft8LO
    Msos12Dk6rIUja5nPx+xcmvhY2LMwiH3OOiMFCgpHK2s7yxsv0OwurNvDQjzPlxyql+rOz
    GopdR8pTogwc3L+OMRwMYc9yxJ5cy4lZcMOMEJmKoa3jDwgStM/s06+vmT0n+11P+m3k6r
    +c5kz/GKJ8O3IU2uSMnmZ9poI6TcnH/71GhYGt2G9jkljnBdPNhVmPMmlXXSusnf9ak3IK
    TSF97+nzDN3L7hTQpusjofROHQnPWnsLLyIlPPEQ3zRADdEK7EfQoHU0CAH6bTROVGxsl3
    VzJE6q8f5O6plmQ7c9RoRCcZS+FDscEXiBFcCQ2bqP+NdYrw4kOkNPfXPpEgIW+ZAQA8DT
    uTi8azI0VCcVeWOG4A11deN2YXOajsmvGiGNE4flDa/SHZ96RsVeF/GUVsmg
X-ME-Proxy: <xmx:8H6katLjXLoqZy_E0u0R5fOJAP07BfdKFqZvFeD0W-Kxds7WRdbK4Q>
    <xmx:8H6kaiEqmtnZ23bKRB5fa6TQvNsfr0e_GDmXTeysqYZaLDrhPlK1CQ>
    <xmx:8H6kanqBgTotVlK828hAUgmamAx79Bd3R9Ybk0u-D2kMJpd4A0cq-w>
    <xmx:8H6karRvhEeyHqJcmeXA7gHSzJf_HlG06oM1PngJ5lfNkyW39l2RoQ>
    <xmx:8H6kapq340DV9-ih4Uri8PpRGbMAo6xizLkpn-hNXJvbBgqQqv-rLRD4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 18:21:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] cocci: FREE_AND_NULL(E) is safe to call on NULL
In-Reply-To: <xmqqld978mok.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	11 Sep 2026 15:09:47 -0700")
References: <xmqqld978mok.fsf@gitster.g>
Date: Fri, 11 Sep 2026 15:21:35 -0700
Message-ID: <xmqqh5jv8m4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Just like we allow calling free(E) without checking if E is not
NULL, it is safe to call FREE_AND_NULL(E) unconditionally.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tools/coccinelle/free.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/coccinelle/free.cocci b/tools/coccinelle/free.cocci
index 3dfaae9dd8..f2af140cfb 100644
--- a/tools/coccinelle/free.cocci
+++ b/tools/coccinelle/free.cocci
@@ -6,6 +6,8 @@ expression E;
   free(E);
 |
   commit_list_free(E);
+|
+  FREE_AND_NULL(E);
 )
 
 @@
-- 
2.56.0-rc0-143-g1fea62d0ca

