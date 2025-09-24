Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2926B971
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752661; cv=none; b=B4t2/C5+ekYzeRmWevFQVG/k+1MmyEhbUIxKbEjiEb86Fxf8WY60NToq9dED8n7A6QE4ujpEqDr8s/lgUdvGbvdZ9JR6HwvSKd2se1/nK+vu6Qvao4571LUVMEywGVN2zjjvaRqjk499rh1s29bnlyub6X1zkEJLlnr7HaIM3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752661; c=relaxed/simple;
	bh=048ifUTAfUHp0QfPFoLXO3dFB0Lcyf9uJa+aSjL4mEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iYCEa47rvHZUz/WMaEAgdUndg1VNoY2xAulwIibFIBgZb3VwzSalct/Tq4F4Bbhg9CPKidKmbKx0lI3nYNQnR5YzKTCcS8Zu21CcnqHfWiCWZh6ZoNYXa1K0y0LrW6w2EgAMd0chulvXJrFO+oC8+CRsauHvlfmQme66tAyr42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EI/0/B7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ei9jTa/f; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EI/0/B7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ei9jTa/f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E30E140009A;
	Wed, 24 Sep 2025 18:24:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 18:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758752659; x=1758839059; bh=7TTGIRdSIk
	N7qxLcLmWy0E+rm93qD4+pp8xAsfBfdR4=; b=EI/0/B7Sls2ZBYn4v7+HejFpDD
	OoJ0Dd0Hi4ozmKFfbWArFXIPzqt19V6sEEpeLVtbZeJm1kAmsIH9inbuqoUyIFaf
	7Zu2raXuCvGb6K+/7af98z/svh4W2NzTQNiS9SDGE3GHkb/HnMs+8uLH0kYJnaIT
	tyDfwTfrAOy6a3jtPJSX1/hI4OHlY8JyDtH/XUcd43tV1LZP8UJBshOuhqlyJVLF
	ncY3o2/75tbZjHfp1zf3l8J12GICwPE0de+6Sp2jzUq4koVjRwNJ/Oo087x0Noov
	YiKU8tljPDZfUEuNulSasmVnLsf6MJNHzIzjXkSJqi5yGUkYx5LiziAxpm6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758752659; x=1758839059; bh=7TTGIRdSIkN7qxLcLmWy0E+rm93qD4+pp8x
	AsfBfdR4=; b=ei9jTa/fLGXHn0uy4b0Zu/qNw80WpOmPuJOncu+E/kbP3aarTXi
	W6wx9KxveoFnmQubyAEp/iaWrdljjf3WKmEGeKrOn0yaUvNqPH9HuPCK58bIshnG
	c/vq8PHsUkDu2856yofXaaohOdVuTQYkVh66vtBEr8NISNsJF1+Kr89dN/c/1LEG
	W1PVsWvNjCq/pL9plr4aMLJ5wKLRVHzzoMg1b0P21MHdGtn/lUXjrFB8rEbiWATP
	jOl8mbLJNTAsWFAELVlFivYHpF/zp6kDJO4RGJ3M8mGB8xjw5KG+y9FvsIllNOwd
	SKYzQpKw58uEl5pEuuHbpQXddLde8tS3VmA==
X-ME-Sender: <xms:k2_UaG9Yc7BW5hE6cjzm_HhH6heVIo7t8kq9LSgWSX7r_atlfaU2JA>
    <xme:k2_UaNshE-7LOHwSmCCAFAoxaYmqb4DGyBa26flZ3WEi0uGC60YwQFUjbamyP2PL7
    D-qiVOo7GlxMZalcDsLztdgwvn-oS_BVMSp5dYn1qI2ZnrOFtTzyQ>
X-ME-Received: <xmr:k2_UaBA6XhxtBtZtHjWqoL0eUW78uRRX5YXnKKApTtzacHSuHiCvPoeUi3UQvW7Px4KBXILqJ466EtQMjTWo8iXtob5dca7FdHIP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetgfeuffevhfeffffgveeuueevtdehgedvheeujeejteekteejueffffejudej
    hfenucffohhmrghinhepughifhhfqdhnohdqihhnuggvgidrtgifnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:k2_UaNUmKfzV6lbXoknJEl3mvGp9wCv8bYG1N18EIx_lrMkPPoSCXA>
    <xmx:k2_UaHAcBob30A5K0DyjjDxY0SkehoBE9JFwei-SPgqJ56o4C7Ba4g>
    <xmx:k2_UaI8J_TNVfEA-ZcicflnKmmmDwzhsasdy_fLQ7XRpXorvLsdgcA>
    <xmx:k2_UaGGfEtPZ0yCHI1UkJ20w5YVDpWXDbY0pgCBb5Mtx3vVkZVMqSg>
    <xmx:k2_UaLOlOXHfb0xW_kc07R4EmM7lgYA-wrNkFIinyCxzkt2obUn41--r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 18:24:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
In-Reply-To: <xmqqa52jjxyq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Sep 2025 15:18:53 -0700")
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
	<xmqqa52jjxyq.fsf@gitster.g>
Date: Wed, 24 Sep 2025 15:24:17 -0700
Message-ID: <xmqq5xd7jxpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Hence, I think the clean-up code of this function this goto ...
>
>>  		goto out;
>
> ... jumps to would need
>
> 	strbuf_release(&ps_match1);
> 	strbuf_release(&ps_match2);
>
> added after that "out:" label?
>
> If we run this test with leak sanitizer, wouldn't it find leak in
> these (I haven't tried it myself---I just am speculating)?

Now I did, and my speculations were both correct.  The SANITIZE=leak
build fails, and with these two releases the test passes.

You can squash this in, or I can do so myself if you like, if this
is the only change that is required.

 diff-no-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/diff-no-index.c w/diff-no-index.c
index c70f82b805..f320424f05 100644
--- c/diff-no-index.c
+++ w/diff-no-index.c
@@ -436,6 +436,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
 		free(to_free[i]);
 	strbuf_release(&replacement);
+	strbuf_release(&ps_match1);
+	strbuf_release(&ps_match2);
 	if (ps)
 		clear_pathspec(ps);
 	return ret;
