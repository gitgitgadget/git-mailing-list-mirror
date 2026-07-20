Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581702BE7BE
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524181; cv=none; b=MCDTVjb5YWdysT7eKvFgZoRaY86Ft319RA4s8uX5Wtz+Te8pY3TY4GkQtpnVki0sE33ZR/4I3NbESQqFd/2iL3FuKkagtIkTH+xtrTou0OjubZZ9SyaE5aC4KzlgTIGeVIU83Jgv0AL1AkGW853CiH7VzuuIvYlCiqxVtFGwRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524181; c=relaxed/simple;
	bh=laTcJ0NvtIkvBGQGNdC/IAFQZ7J8nEax/Mwlq4DdXMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kolb6XtH+4JEu169svzddg1HaG3P9/KWKvmj1+jAXGViqtNGidJtwwQF4sj2bJgCcSGrnm2pa2+EaRrHRXpCpalVsYNOdBctXrrEaAAF7BAZexOdtBnnROb+YLgXQ7I1BdkHPAhiIx1+O0AxKWcwNq1N76rhPAIbV45EBpMRPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CPbasPL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJO9cidU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPbasPL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJO9cidU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 59E761D0004C;
	Mon, 20 Jul 2026 01:09:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 20 Jul 2026 01:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784524178; x=1784610578; bh=OWjg2vDNFR
	lvxPj16o2MCoal1KoOq2OCh//5mZYx64A=; b=CPbasPL9qUwz2MjLp1MxYtUpmF
	uThRC6U7mM8KIG7VpuncPJ3tTv9+fe2+pO4J2T/u18nIXFgJTbn+pHWayG6GnjAr
	3EtG9IvDbHy/f7EDUb1xoXMC4epSbIsDPQ/5TZEhqVHq6Vd8F19p4wzaDlurrIWI
	yKilAj+p5W+CPaXVX6YN0pz0xfDKCosuWT/nACNX9gg1YYFLuwGVDdBfQqv9nQ2b
	hglHzhhEUBE/cD/zBbgcqn6TZ6PQ20V1H9IQKuNwPcURP/fFQ8p6QKu9b8XGMRFW
	KQXl8hisz55NfCbBnfL3ikaWi2WO4zRbYennCpmz9i9AlHTECi8f2tF9bYyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784524178; x=1784610578; bh=OWjg2vDNFRlvxPj16o2MCoal1KoOq2OCh//
	5mZYx64A=; b=AJO9cidUOww+P/kCvMNefppaLQQVaNlGlPydPRSHtwsnIo5wNQK
	5ZPk9iSu2gQl9J2pgHp2qbVUI5gVAZApcvB52mHJ0JywgU/YUcshILX30HwAMEc5
	OPvkvEYFeNetZWIXDpm6ao0/vVue6/EA6Ul4D9vlfoefXV8DE+FdrVXPKtBGEBuD
	+XY2wA6NfcQ172NdfZUgEiq9X5ZMHKyai/V7q+yJP1erCCa9WeyT7FMEFuLqFS6c
	VpojO4qlknpdaTI4zJ33wxydXtgt9KJOmDE+EzAdG+QBjd/ypNpp1W0ivTI67sDo
	fpg1PSVL5YroONoaXkx53E7yIp4L35y6R6w==
X-ME-Sender: <xms:kq1darP1lPlQHNsp3P3d_gS50QMijM3tXNCvWS2oaf4YcrFeDw1ivA>
    <xme:kq1das8vXjdeZezfT_RZ3F0gNqfsuU_OsU366XARq9mv8QZEywes63lyXFDpmgwMY
    sqCYJMP_71Kr8Vs09xZ6f41D3--3uo8KuFZE6cD2zS2iVzRrfocPQ>
X-ME-Received: <xmr:kq1davRizDRnpw5tTv85R0jSve1UKjS2R5aU4-vzlygsM5Hx4xvH8PO_laOdXApc0OeZHxNRTbuOmafy_3uVG4eF4SRpsiKUeA>
X-ME-Proxy-Cause: dmFkZTGO/bmvr19MHL6cvyBb6h9I46i1bnRnuLDlhOyuL8EUmGoPMLYYyu7WDKl7ktBnst
    qaAjRw7H52Faq/FjxFS5IRANJgfTmedz5yq6lksztNQiwuxZYBkZTXn/TK+/uQ1qWdak6o
    yKR5qIRBtj8fpeb6LY0YZSncBzXXfd0zdySdSA2JZuoZpaSn22hDv9MY3Np991RmPq+jfs
    vcVOzhm3AnGxszalE2ODfwzerwy5M6OefLikOvDeTvMj8Skk6tILQU+ViMwiHcnUCvN7/R
    4cB7/ZzmPu2r2YvVzeNq/lbhPB0Uq0BRo6Sn9ozJce3laDHzEzYbkfQzsiDhs0Ke6DOmli
    hzxtfx2JnpldOlA8MgCp80bXPhOQH+35EjXIAV50jgtK/n7JD4bMfCtiXjqoojbsd174Ly
    1bhKavlWavpN8sM9+EV2GRyNou6MLHjsSJMv9H/R9SsmjtcyTw2oVybR4S+EACz1HhPpN4
    q0aFGxP3NlPUwgGaWQNC5xbvOGMCaObJXMb6c+hHQkzfuoNl6H3vhpnr/uG6zGP5CyFjB3
    1N5TPbDG36YxzxzXyNVpR5heSK1SoZkbyRUcNjRqheMYN/ZW3Q4tM2e668+kQc/OP9hTuh
    7ZKFY8UekpgOM5ibB6tjw5WJ9Bhv/5UCw8WuPnchIK+RnM5gvYiEZMuojPzQ
X-ME-Proxy: <xmx:kq1dauln_cWSVSGEY4TlNuNiNz8DcmgCBWe01dcaMEknwCyR3SWJUQ>
    <xmx:kq1davTJTX6OsHMT6yEYHO9Zbx361UHG7nIENdryRm-vymd9CtjTlw>
    <xmx:kq1dasOCFr77rn4wLu8rYy3Egb3ZonBuzqB5xjOmYJhfPnRugH9BIA>
    <xmx:kq1daoXyv1aUnff264CtoyjqpIPBGefHlxO4l03g6OhvT75OOOB2bg>
    <xmx:kq1dasq_xspj9AQHh4w5sx0aucL3OlrZ-iGOrOnM6oWHJq89RFuVZXzY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 01:09:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/11] last-modified: handle repo_parse_commit() failures
In-Reply-To: <xmqqldbdqciy.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Jul 2026 18:15:01 -0700")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<f728be4dacb0b9781ef6589a0d2c48009aa31e9e.1784069325.git.gitgitgadget@gmail.com>
	<xmqqldbdqciy.fsf@gitster.g>
Date: Sun, 19 Jul 2026 22:09:35 -0700
Message-ID: <xmqqh5lui6wg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> ...
>> -		repo_parse_commit(lm->rev.repo, c);
>> +		if (repo_parse_commit(lm->rev.repo, c))
>> +			continue;
>
> Shouldn't this be
>
> 			goto cleanup;
>
> instead?  'n' pulled out of not_queue may be unparseable and when we
> ignore it, don't we still want to clean up the active_paths slab for
> commit 'c'?

--- >8 ---
Subject: [PATCH] fixup! last-modified: handle repo_parse_commit() failures

https://lore.kernel.org/git/xmqqldbdqciy.fsf@gitster.g/

'n' pulled out of not_queue may be unparseable and when we ignore
it, we still want to clean up the active_paths slab for commit 'c'.

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index fe012b0c2e..3846244dfc 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -416,7 +416,7 @@ static int last_modified_run(struct last_modified *lm)
 		 * in the '--not' queue.
 		 */
 		if (repo_parse_commit(lm->rev.repo, c))
-			continue;
+			goto cleanup;
 
 		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
