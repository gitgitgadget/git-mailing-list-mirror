Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D301A840A
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329397; cv=none; b=oTAINO9dYOt6dKTZmbocOwtI/nf+tLDsNht/wlnpyyqkCpElIUQ/f77rByvsVgwJ3C9RgjD5MJ/tpS1CD6O/EvOC64qZbFSQTfrEANBredcvGpoENY/Gf7DEalAXAnA46X8FTclHiCi+BZE5yeT0h3Yp7U9AvNCRLg87BxeKxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329397; c=relaxed/simple;
	bh=p6Hq9aLM8luRQYee150YSa8yCAGsQ9YHFGq9e2g55Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkNxKgPN0SvitlsxI4v/wvBlHP+a/Di2K8vgzGGIYdNgWcY2g9DUGt9RzaZI9T84aJtkhlRpBC/ISi1UJWFdUzKBsY7RBkn5tUYVomjT6xemotyVXDabTh2Lkxcc3TiWAz7Bwv6t4YRZn43DffcAbz9g4s8MqLyIoKhBi4YDPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GVOz6VxV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfHebqqp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GVOz6VxV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfHebqqp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AA961D0010B;
	Thu, 12 Mar 2026 11:29:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 12 Mar 2026 11:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773329394;
	 x=1773415794; bh=byHVE4AOcXhidmbiI0qYZfOyd5MmSJPoj6FikbRgJZM=; b=
	GVOz6VxVe8m0OtDGrsC4nq670ntFniuq5ZUJG3sVyFJuUqc7ALSJVzf5Nxs0CAnl
	uY3NFIikpxxe71dNIN/OUKBHIGN+FX8HN5d6j6dIfd0M5r9rY6ZKoPAA1r9uEbET
	YpqzkBJ334dKL2BtZGHqcdPi+dFMTBsDfsgpR6zMoIC7HdV/7xpW41bKDTzoh3e1
	5p8lRf7o1vyVmcZ9HHqbCoOKj71vCqMp46CCd5196Z+9Q2g7R7EC+di7eaNUv7vm
	dKcNQPCd7cPrtGsuAGtnJB9mLOU0pnTIwEeCZzF5xTgx7nCzkuv25w+hU/yUOCoQ
	fgvMjA7BEFpBgPmaAwUoag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773329394; x=
	1773415794; bh=byHVE4AOcXhidmbiI0qYZfOyd5MmSJPoj6FikbRgJZM=; b=m
	fHebqqpYteYlhK/aRkbPyE1nqMVVXPxRjSL6mVBrWS5MNoABBYPxYTQlGAJ+bB3A
	XADNLXdFMJbEnKPwtYSeWMFOjCbZGdRxA2qZIls+/ikr2p8aELVJvp+9/qZ4zMaS
	UYlCvj+RLd19k9ErJyJVD3KR2Bq+4GfyUD3bnePnxo0PqLT0fkIatpP6o2/eIhaP
	wXe9z1swkB/sR3DzKEjP4zqrfDK/ITVcgwCYzFmvDQqgxH3EWLFGsyYokhV1E2RE
	TVmp4U2pHzbz5uNcoYtpTIFxR98Px6ZwrGB41B902IBStpgGM/hGKXbX7+BzWFMz
	jCLPu9lDoHWQl5BZ3FiwQ==
X-ME-Sender: <xms:8duyaThnjnr5saN_cGuJa4c2JeUWhjhcgjlWr44sn_sFULwImLhwwQ>
    <xme:8duyaYNTcJnttFgKxBEcko8KjAUE0YN9jVX4d27fNCpn1DBOD2VzdqWidC9tIvWKw
    DxdUYHb0L44VcgnsZRLUAhgw5M4bKsA7lO0E23xGf1CDqJG3ChsGA>
X-ME-Received: <xmr:8duyaeoCGmC6_9Ufpow3lZnE9cvVu6hkONtpuk52IoWM_cxmR_VDJBzBZq_2UV8UjuWYEDOcPtUOP_U_vHZ36-zefcPQbfYSfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghkkhgrrhgrtggrhiesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8duyaa7_4Ue7c0c5SDTdj5if8udUFTy-PkUpeWxon65_EJPCxYDY-Q>
    <xmx:8duyach0pjYkhcpgFQXR3gyGnC2RrZXJqkkPdfATLrOcbmSsKlNEbg>
    <xmx:8duyaQ48EOF9his3_CoWmOwLnTEKJAlKgXrr1_nE3Mp0sgMT8TB5_w>
    <xmx:8duyaRFBkbp2ulYUoHh30NNNyxhrddea3Z3AeUfTYwmXc6CeADFihw>
    <xmx:8tuyaaSZ-7mQBkVf47TrarI7uaYndWUKxW9t4xogVomv6W7Dtqfd4BBU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 11:29:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  l.s.r@web.de,  ps@pks.im,  peff@peff.net
Subject: Re: [PATCH v3 0/2] run-command: stop using the_repository
In-Reply-To: <20260312144437.626392-1-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Thu, 12 Mar 2026 17:44:35 +0300")
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
	<20260312144437.626392-1-bkkaracay@gmail.com>
Date: Thu, 12 Mar 2026 08:29:52 -0700
Message-ID: <xmqqa4wdhxqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Burak Kaan Karaçay <bkkaracay@gmail.com> writes:

> This patch series aims to remove the_repository dependency in
> 'run-command.c'.
>
> The first patch removes the dependency in start_command() by replacing
> the boolean 'close_object_store' flag with a pointer to the target
> object store.
>
> The second patch handles the prepare_auto_maintenance() and
> run_auto_maintenance() functions by passing a 'struct repository *'
> parameter. With no global repository dependencies left, it drops the
> USE_THE_REPOSITORY_VARIABLE macro from the file.
>
> Changes in v3:
> - Added the second patch at the suggestion of Patrick to fully clean up
>   the file.

[1/2] is now exactly as expected from the previous discussion.  The
only miniscule thing I found in [2/2] was a new blank line
introduced here, which seemed unnecessary and not in line with the
existing style in that function.

Otherwise, looking very good.  Will queue.  Thanks.


diff --git a/builtin/rebase.c b/builtin/rebase.c
index c487e10907..8c1316db38 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -562,7 +562,9 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
 	 */
-	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+	run_auto_maintenance(the_repository,
+			!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+
 	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
