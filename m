Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97FC189905
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268583; cv=none; b=lRpuGyzMBi0dyEq4n8LqgG2foQU/QjpI2cJuCQ3hQlFn4wcb5JTn1zBrlhUFXwMzXZb4p1epMGXiP+u4nCgAdM8ruJXf+/5rj7dErc9Tas0g6pJvee8PI5Xr9E+Jts2VwGHjcmhMqptv70yyAW7hxC3+qytP26myezWdHOYLwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268583; c=relaxed/simple;
	bh=RtIo0MhcYBpR4JDnMd0vLwWqUH/uZtvvx1VtxI2gJus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoQJTgmZhrkTM/aGtkG+jT1np7znHlFLWxv2tyuq5mvK9lkJsxqoLbpBoduVlA57mWiokDLJW9PLeCZWPGoKkvzpJ9BUfgrdBB/hlD/o5I6mQGsXxT6C9Dzb12wbUZNJLPCENOJ7uEYl76GhhNLFz5PCeVJhFgbOBIJIu1e7Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mNQIFA5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WR0DEoFo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mNQIFA5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WR0DEoFo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D7C301140142;
	Tue,  7 Jan 2025 11:49:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 11:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736268579; x=1736354979; bh=OIH/nMf0nU
	VBZKsK6HVm6V6ztnRY9qpTQIyfmZK9Gko=; b=mNQIFA5u7PYkVkaqWIb4itpa7H
	/ZlVsqCFZyFXyCAk9EGXP/QvWzyIMO553mgZZMyXFTowc0iPkf5041dFyhIVhN0p
	qrhI2uFO7NpsFBHkrq300+DmU1N4HSUDLR67Law025gcz0ew/YL4ydsDpi0Cjxli
	DUx5ELM5t2v3cz5UUHwtYP0ioKTuwSe1zReyRv/s/IssRLxxCRJD1sLq+9DWX0i1
	zK2oR8x98w80LmJTwQQaaPfbnyOIWBDzjERlifzALrCZ8e7SgTzyvVzh0KE/xzoZ
	F56mxHYHpwmjgGt+dmyOzzseOAqJVm2+aDbiFs89QM7BB67D727BMzHTMdGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736268579; x=1736354979; bh=OIH/nMf0nUVBZKsK6HVm6V6ztnRY9qpTQIy
	fmZK9Gko=; b=WR0DEoFoGLJTjVbBuiiYyFZntPtuixIpgXItgFlRlHiudd6ft3p
	Le6uRuw4UCPoumuZqj78+e4kDMgwqZ5NLjzC4uA6Rr7H9A72/ynklfk2/gMBRctc
	KwkeeYbNWEFOAhnbAtZ/KDTojT1/URyy5OH7dpKNCBlVH8SDitSGpVPqHaEQnQ3f
	BrmjrxU/fX7zjCbxktEdwa4OhT6/CmotpYuS7EecK0NFCfmi7iJ7Hx8VcxL/2UWW
	ZhyJcz5Z4Y89NMazez5Y2J1tA60pBWZO8bG0ii/hPn8hFO831qwVnTjCe0bWAzZS
	NWQEWIjL+qzG9h4pMcVQmSz8nNlklsu6DFQ==
X-ME-Sender: <xms:I1t9Z_dvk1f4wuR09AYK1etq-wBQC77EvknsjTLucPg3xB3pMpCMgA>
    <xme:I1t9Z1OyCHISpN_qVennQRjdztjznBTy0zOMT-06EHh8ig9f10bo22rcao6ETjTtE
    o9PWN8DAfXrRRfBHw>
X-ME-Received: <xmr:I1t9Z4jXzrMS5HiLEaQdt_Gi21TVyzgdc7n3nIYHwKQVO_FfR2bXwCKc9PvWSNh0LISg1n94gi_UFDQ9m2wv-3BLjCxYyC5BfhPj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepudelieevudetgeelffegudetkedtjeeggeek
    gfeftefhffdvfeegteevgedttdfgnecuffhomhgrihhnpehrvghmohhtvgdrtgifpdhtrh
    grnhhsphhorhhtrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:I1t9Zw9h-UqZxn9KUudGAaatp9XEC9nD3dCCZs0ZCkkKS_U-PDVa8w>
    <xmx:I1t9Z7uRebHPZ9qHE77SOHGma_uTr0mUpCt1Z0tpNXEY83BLSYTJew>
    <xmx:I1t9Z_Gq-8zK8volLzlvz0U2r7XERA8E7_z3ky_V0e-sMBnJoIaMlg>
    <xmx:I1t9ZyPghWm19fIyqr2mFynSnWK50oYn9oyaaoXAi97V98haMmUt9w>
    <xmx:I1t9ZxU1d3XXAdi5xsmkhgYs_3JZ8UKzXkhebEFugeoAUWofqbzMqY9f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:49:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <xmqq8qrmvap5.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Jan 2025 08:40:54 -0800")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
	<xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im>
	<xmqq8qrmvap5.fsf@gitster.g>
Date: Tue, 07 Jan 2025 08:49:37 -0800
Message-ID: <xmqq4j2avaam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Makes sense indeed. We can easily add for something like below diff.
>> I'll roll that into the next version, thanks!
>
> It is a good start, but is probably a bit too noisy.  Can we make
> them appear ONLY when the definitions read from these older sources
> are actually USED?
>
> Thanks.

Something along this line is what I had in mind.  Not even compile
tested, and I am not claiming that all the uses of remote will go
thourgh the code paths to use it with a transport, but you hopefully
got the idea.

 remote.c    | 20 ++++++++++++++++++++
 remote.h    |  2 ++
 transport.c |  2 ++
 3 files changed, 24 insertions(+)

diff --git c/remote.c w/remote.c
index f43cf5e7a4..1cca98215d 100644
--- c/remote.c
+++ w/remote.c
@@ -2904,3 +2904,23 @@ char *relative_url(const char *remote_url, const char *url,
 	free(out);
 	return strbuf_detach(&sb, NULL);
 }
+
+void remote_stale_warning(const struct remote *remote)
+{
+	const char *msg;
+
+	switch (remote->origin) {
+	case REMOTE_REMOTES:
+		msg = N_("Using remote '%s' read from the .git/remotes, "
+			 "whose support will be removed");
+		break;
+	case REMOTE_BRANCHES:
+		msg = N_("Using remote '%s' read from the .git/branches, "
+			 "whose support will be removed");
+		break;
+	default:
+		return;
+	}
+
+	warning(_(msg), remote->name);
+}
diff --git c/remote.h w/remote.h
index b901b56746..e29ceef3e4 100644
--- c/remote.h
+++ w/remote.h
@@ -445,4 +445,6 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+void remote_stale_warning(const struct remote *remote);
+
 #endif
diff --git c/transport.c w/transport.c
index 12cc5b4d96..c153be9100 100644
--- c/transport.c
+++ w/transport.c
@@ -1131,6 +1131,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	helper = remote->foreign_vcs;
 
+	remote_stale_warning(remote);
+
 	if (!url)
 		url = remote->url.v[0];
 	ret->url = url;
