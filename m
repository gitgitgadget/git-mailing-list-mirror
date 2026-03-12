Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D6279917
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275145; cv=none; b=FRoIqhcKdcBc9SRpJl8RhoYZjCSBSHrMP1hMtoiywArDSajSrqDYiSAnWSQDpMocL1hEEBQGYF5psB6u1zon6tkwa9ggG20NLQfrh+s1Tlb4Vw7tiRE6U9mL44zVEKOYHbN4wlIR8fwAT/zn/RoX+GHNLVAnLGasaarCtQcAX6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275145; c=relaxed/simple;
	bh=PZ/8iNPV0cvit+OIzaYOCN471fP6nk8toitarvaWaGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qahHNnwTtk0uvhJdiPZRGv6cq2azxFVGtHXeFAX6t4Wpf9FS/K7LVWi7VnSV1yZK8c5IkFeb5O2Sfmb/+ikpvibSp058ZJwDS85e16QWI0ISel395KINcpffIEYNX8NSDjzD4ew+tkayscUQNa2RvUFa3KKmJZ27+vFfsWpiWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YT4rw33+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pdODqORo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YT4rw33+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdODqORo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 44DA31D001E5;
	Wed, 11 Mar 2026 20:25:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 20:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773275142; x=1773361542; bh=ubdZ4XWpd4
	4nofnquZitirzSW3RFyPd53d9ZYP1QpCg=; b=YT4rw33+uvCsUfARGJog/huDyD
	fK+ooK5yIb7SyY1hQVuMn7DFSHZMpQc782m9xcYZfwqWRFwakIQfUIMdX8ATLmB+
	j8hWpIgheEmGsgb1ZxkywO1jBh8b3+IvWO6ugn2mm+aDoS6KX1C+bjtv7p/pTnYP
	agUM03oaOYWVC9d62GQ1q1Z81aGnDNb0IAMP4MwJoJwfzMisf/LYNQp/azRQYpIq
	pmFSRFYKKNJTt3ezv4HhBjIqSTKJFTvNk6IuF2GatBgOanMLD/aor0ck97KZGSVC
	xHeJyE9IncucLNinoaVAm7h5K2v7Ri9G5pYe3miYzZ4Cj9wVheNDjJXPXSrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773275142; x=1773361542; bh=ubdZ4XWpd44nofnquZitirzSW3RFyPd53d9
	ZYP1QpCg=; b=pdODqORohHt895S/36JG7cDlaWd3IAfXPKiHwbK6ju0nTHuokop
	AqADZ0W5WmXkCsUzOhJEK4tfbGv99SFT3rDmnUS6EZfb5zer9Rtv2nVh/0oy+uSV
	TTPaKJ7hvILnZJcJCMJejQdWjCqhrpt0USYRnsIn+hJVM4KE6PvrvGYBOCJqyQCk
	77cAdcliphIgRITTRxb8zGg/3qeRtRcHvPDexvt3NFNpCWWtUXs7OSY49TpuxHNY
	wJKzc3USOzqAfzOjYzvscHyHF7E61vKJGDMXPrKbUjBcYm6W7ckicuUW/2ujM4q2
	lx2WcFbC5CD5oqgpIuup7KU/3VJ2+BLDRCA==
X-ME-Sender: <xms:BQiyaVO563lQfb6cOkg1o3T-Lu8m2spnJP02XCa0yPKMdFayXEBF8g>
    <xme:BQiyae86kee2d3_ZoDEImKYyqz1wzMOQbwoBxfgwG6MQO2TWqgkugkxB_CHIjJg1K
    7YLP6lV8pYaXmQ-3uEQCClvORo_Frluma6HXKx0LIS32bUHlxeQ_A>
X-ME-Received: <xmr:BQiyaZTfBhi228HWug6zJD-LaRjoh4ZRTKUvR8aUvQaHZ9TJuy9w3QjakKZppy9uq3uVpX7KFFS4TgRBnql5CXvqkuwNObm1hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvhdoghhithesughrsggvrghtrdhlihdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigr
    lhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BQiyaQk4XLWSbxerjb7Gk75EFnBsbeDQ9qr6YGkVo04Id3OC8_ufkA>
    <xmx:BQiyaZQnKTZp22-_y1ENZ6SmORfGMWw8ZVKwW3l-K8RX8lS30h24cw>
    <xmx:BQiyaeMfGyxJ84n5khkOka_WlchTfHXnDwWdEkdpTlNOmD_klpft7Q>
    <xmx:BQiyaSWZYe3-HYZP4QmgYFzVpDbVu1OjL3oTpuLbx1ywzyzKET95HQ>
    <xmx:Bgiyae66wgsnlTURx5ex7NSThpXfW0T3G521iPGOdK3H9T-oRUkLfra1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 20:25:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 0/3] imap-send: modernize the OpenSSL API
In-Reply-To: <20260311221027.1404476-1-dev+git@drbeat.li> (Beat Bolli's
	message of "Wed, 11 Mar 2026 23:10:24 +0100")
References: <20260311121107.1122387-1-dev+git@drbeat.li>
	<20260311221027.1404476-1-dev+git@drbeat.li>
Date: Wed, 11 Mar 2026 17:25:40 -0700
Message-ID: <xmqqsea5lwqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beat Bolli <dev+git@drbeat.li> writes:
> Changes vs v1:
> - keep the check for embedded NUL characters

... which amounts to this difference, which is a lot more explicit
way to express what is going on.  I like it.

Thanks.

diff --git a/imap-send.c b/imap-send.c
index 789055d7fd..af02c6a689 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -222,6 +222,11 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 static int host_matches(const char *host, const ASN1_STRING *asn1_str)
 {
 	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
+
+	/* embedded NUL characters may open a security hole */
+	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
+	    return 0;
+
 	if (pattern[0] == '*' && pattern[1] == '.') {
 		pattern += 2;
 		if (!(host = strchr(host, '.')))
