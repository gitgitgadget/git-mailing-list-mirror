Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA741686A
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425370; cv=none; b=TBYZTXktkChDQC9crVm0E0BzZjAuAK4xO5NrrA4E4rTukYsiNvfZkbLN8C1tjToZkBceqXOe5Xqf5i+H+gd0EePG6VTHcDMGodlUddddlFg5HhpigW9CNlMPL2rzklVUl2JR0B12RM49q3xZK8cJ2KS0f17RhSsH47kcJ263ZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425370; c=relaxed/simple;
	bh=4RapEgoirv8JU+OCMse3A0X+ajEsvkWBm3oeejHgYXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OHD7XwRLcswpgx23yh6uSQL/S2I6QECb38u6AwMVXUcoXuMJsNDcKSrWFvvaKIh2ZyfYhxmQcSE7z7juHOnayE/+FnaSoZ5DXAPI+IaIg+wsHJZUSDGCV3Gy1NP4c26/NsDmYlscOLLnuaeksJpWoiNd1qKCYVGMzHAzrOBvwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MeDJRIUU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rU8iC9FI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MeDJRIUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rU8iC9FI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B0B11D000F0;
	Mon, 14 Sep 2026 18:36:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 18:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789425367; x=1789511767; bh=x8yO9QSjWY
	g+uWHe/XI4PRd6e4lp/V4H4waj2n2rOoI=; b=MeDJRIUU3BsHcRMT2/rdicOQi0
	EjspTAiBmsgeFlJzIIYT9J2qTIkm9twZ3LZxKKDA6L85LyJhjoZRjhGptZyO29Er
	YKj7ok4PYBnWJhZwv2ad5EtOQeOtUnwRBXiWC7qK0XmudPbDdegaiav7jnIBPLcu
	qc+ABBalKgFQCH0YKdIEhVLr4u1AztKCrMVawuKV1qithXM2DF2hxSVdqggI4mRc
	8aZlklH9TcLKDCaVN/3KoCQiBzY3vYaydo9zCEwvtxMjR6/Uga60aXT9OciqOrS4
	rpY1/ATc7OABLayovfsvwRPIGXkvBL3iQoXFlRR+orM5p7VtwguJhzq2R9Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789425367; x=1789511767; bh=x8yO9QSjWYg+uWHe/XI4PRd6e4lp/V4H4wa
	j2n2rOoI=; b=rU8iC9FI3uLJ263UemlMA53IlDxMZq/1BTJF5VW+bNvtSY3hi3G
	qP4XAswvD17EhAwmcbl2/jvgLmS2fmWBpY7yCzjZH1H4IfAlbYU0FhFDtNQTPPBW
	kYrIGfpbwW2MHgpv8bR+t1fFSxIV6e2nzMJ82vQZvAD3V0ssD0ws0ojSfkmM/zXB
	jHfYykC36XlDbjG0XnFroklijCUoCmwclxJeFfNYaOP0dMvTrj0iCXO9XnmR8d0f
	SkbGovhaaJTa3x6HD6tzoOctvwowPtnB6YbSbxEUyb6xBFQ2KPD/lxsBAyTEVddE
	fN749McrYd5iLv+WewjLEktT+WUPZT+/PlQ==
X-ME-Sender: <xms:13aoaoyAGVtcmJu2kSzN2OmVhdE5a0nZ30DityOXXSgL2oheJ3zFnQ>
    <xme:13aoas_xGCv1ISzXes-la-Gl4e06l9wFSVFwyOuoA9qZwCsG_FzyO6CCdfng8h9HM
    u4kSkZ78t7UJS9c5DmaX4U407tXtu-tdSITdN5RECGcNjE3HPRa9vc>
X-ME-Received: <xmr:13aoaojDZ3cjoJ9ZOw_U4kE29Mo0KVwpiu8ct1HChmzNKCZRzn9fRgw1dZRRyMTabVHsGHYMkNi12Sk6KE5TYvWWvC1x8VtFDw3u>
X-ME-Proxy-Cause: dmFkZTFH+i5aKN3acVtPBLzpetr5gmT+txAnK3OnlHjU36jJxIgzdntMqjzGlcIg16VoEM
    hWTZvShzyzf/QEJNhUoix/isk0VzJuYqOX81cRw8bcZCjRhA+/088htl6ha2xY6zGkeLFp
    qdnECmYtL1iAvoh4meWFKDGoHM0sjFzjAk1ph+VW5YoMRy3Q8U+KllC22/6PwLb1evus5e
    UGzBHBsD7C2WCV0hVZuYZLvFRzOM71Cfdy5nn/EGBXAo/hIE4pf3MujBIn6Q+YE9Q9tppj
    RYaJNpWATU4LSe/Tu0eRg/btRHsxOevrK0tpYiceSzaf5vYEcd13joy9/3P4B6pCMpSRKW
    8Jf3a6BLnUlt4OHQOQXyrICtqyGHzGhX/LptkYdrLPODH1yQZDE0TxWAIhOJNuuq/z6pg8
    vnZJtxyjzHUYOFuK1K7uRfcOqmVAx43Y5cIbUvhZYQBoZI1anYjFsx/jBNX2/SV9mI20xV
    Cp9ULtRyfySnFrTt5aim7KPFcxvmHZiDBfubr70zdd5c+keH949qsncu0zKQQihVOpmes2
    OHkKbp4sB1z3TNV3uIHkVMePdlsrhwYvzRqgrQscq6jc4DhYDt7vI2ekHYaU4bvukLJ3DP
    0SUB59Xjr11rmcoaIw4ezgPUUQwGMz52EUkU3/ZXH/iyO2urvg222bP33+YQ
X-ME-Proxy: <xmx:13aoarHQh5RnZi9U0kPPB4GbGFMTMrpG6srFva_KE3U5oXuHRMc1rA>
    <xmx:13aoav88WZgTilVJR9CphRqNOqG9MCasc8jAyQY7D-L7hgu2JARN2g>
    <xmx:13aoaqwNSfb001Crh-1qCEWqCe7zpsRo4RCawSSmmFfs6zv9_jfOLQ>
    <xmx:13aoajMYgNUXY9c9LjFyeOPafwi-rZ_jXeVaEPRW9-LnXrxgrBwFMg>
    <xmx:13aoatP9OKMkPtDnlQs0ym56n2_EZ4fCLD9og-K_fzEhplhQrQUtyYqU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 18:36:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re* [PATCH v10 4/4] hook: introduce the receive-report hook
In-Reply-To: <CAOLa=ZS0PT4bb+k3HR4F_aOoJ5uUuMFx+Dnte4LpPEekFxs9uA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 11 Sep 2026 14:58:15 -0700")
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
	<20260910-758-introduce-hook-v10-4-06f9c506631c@gmail.com>
	<xmqq33vfa2ny.fsf@gitster.g>
	<CAOLa=ZS0PT4bb+k3HR4F_aOoJ5uUuMFx+Dnte4LpPEekFxs9uA@mail.gmail.com>
Date: Mon, 14 Sep 2026 15:36:05 -0700
Message-ID: <xmqqwlsn31gq.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I could send in this patch for coccinelle with the fixup if that's okay
> with you.

This patch until it gets fixed will take the coccinelle updates
hostage, so let's queue the following on top before merging it down
to 'next'.

----- >8 -----
Subject: [PATCH] receive-pack: coccinelle fix

Let's not check the nullness of cmd->error_string_owned before
calling FREE_AND_NULL(cmd->error_string_owned).  It is cheap and
safe to call FREE_AND_NULL(variable) for a variable that has NULL
in it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9ac7717096..1d5b050beb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2452,8 +2452,7 @@ static void update_shallow_info(struct command *commands,
 static void override_cmds_error(struct command *commands, const char *err)
 {
 	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string_owned)
-			FREE_AND_NULL(cmd->error_string_owned);
+		FREE_AND_NULL(cmd->error_string_owned);
 		cmd->error_string = err;
 	}
 }
-- 
2.56.0-rc0-195-g1e3108ffbb

