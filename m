Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E552557C
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569812; cv=none; b=bG3HYKeIAXcKJbY0jJ0eG5Qre0CRfEXrMkNDKac8S0jzJtxhSTgq50Wxvs88XGZKwXoYnxu+zj2x4tskKkoqagRtn+A8buWqBJnMyQwU1qluxeuiFVmLj5ew3sOI0wWVyLf/kitwf1F48AnXMgNRTuVOKpNhQMOX8JgK9Od/YuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569812; c=relaxed/simple;
	bh=4/2VgVe6cSNepkhorm8ifl1Zb/meGkWZDWriAqK23t0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvBralzDdg2CiDhvrKICzTLwcpo/d/d2UHA/VSODEF0mWc1rEfNhiTbcCAalGrAcJ8/zAiahaG/06guf6zPimsFRXK136U/KcxotApwdu+noIQqK5thfaLfwpaLb2Np41SKVAwQA7T5CuvqCMi7eWX9ZvafmBc+rbZ6eqqeqXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WH/neRIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8UtjRRN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WH/neRIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8UtjRRN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E55111402AE;
	Tue,  6 May 2025 18:16:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 06 May 2025 18:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746569809; x=1746656209; bh=lyGoqrZf/o
	9xX8nc902TF8qNokDRXdNlq4Nfx9TeXHs=; b=WH/neRIw5LZnGzDzgfXmaVBeus
	QiLtRcAWVZzERzqYrMAhzOOnK4hKXun5l4+eaQQof20m+0M4KdyAbEqsMKOeqhk3
	soOhn/qQuPM1jEOv45pzcoCZdfvCQLCAb4J/hF1HncnI3uIik93fA/1BhElbMDz7
	ZKeaGbTZ4kxDnsGw0n4plCgCy7B8FQgIMTBt8Bht7yQpBYymNiFppU3d+J+I4IWm
	PIYt4kW86EJEJiueTVlfJQCOoIPX7HRZb0y/mxVYijwQiamosi8w02iYIRPw1QeJ
	DekcRD7rH9Cl7mOmkNxMwHfQSXdtqTXvLwb90PVxsczw5HzNMbel1eMkPGkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746569809; x=1746656209; bh=lyGoqrZf/o9xX8nc902TF8qNokDRXdNlq4N
	fx9TeXHs=; b=N8UtjRRNldVtB+Ogo/wVglktWRwpuO0pjGDxgXMOnjFYN+4Qa6R
	DJHOT7WM/UxsSJrmoQ4dU/jtaKEgSojZ6IOgMWNW4hG4TgSe0PGjSRQc0meKwq6S
	/600mSfmZpIspG+7yMuQkVWiTcDJPjD5uc0WdEDuJeS54V4dm3Hn4Fa8WcH5Yier
	0JWFnryT4hO9EWtyp9C4GbygeubDRhXnSO3Io3dn/wH3NwcI5hkVYUKgf1aQW6Ly
	J+db9mMfUjpDhk6sWte1xq94+MwfC27qH66rifLh0dqA7heO0no5yaNA+UtMV6Bf
	JcxAkAQthna6F6AoFYE67CIPoZ9kJ2KAuww==
X-ME-Sender: <xms:UYoaaELBzNQOOlHxWHOrc_U_9YICrWmJZUBpH81TikXnOna6fXZXQQ>
    <xme:UYoaaEKxnT1vvS5PFl5b-Qe6a_yA2uckMvkEqNQ7KKQSWEz1aS846J_ml03S6-NjF
    5xfuZAZ3tkjsjxXiA>
X-ME-Received: <xmr:UYoaaEsdnoV_waTiAwbwTv2Ey_peKp3lwD_uzjeDsZGVTKM9SFBTx7eZttgOD9WUrETitLohzXqtxld7VOUR35UndlPL_DwBREqf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:UYoaaBZHq0LlbBgF0rKWKs-SLnA-aBHuB8f4gXrxD7xro-05UMYPUQ>
    <xmx:UYoaaLbMVh1c9Had3Ooah3tTndUqxY1Xj2LhXS__dZzOFcTlXsUPag>
    <xmx:UYoaaNBJj4YpbwdD0eYIyLB1CuLP6g9FjvipGoGfrbztnxKkbJZuzg>
    <xmx:UYoaaBbfsOUc6kuMCd9Zn31ry0M_Kx-1JqSY5KL7lTTDsGVwjrM34Q>
    <xmx:UYoaaMTvpWuPRCdmlczbEepfMNw5DnJgsF3xBhcstB0qdGKH5AzL8ExY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:16:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 4/4] scalar reconfigure: add --no-maintenance option
In-Reply-To: <3e307bf1-52ef-4280-bada-5cc50cc7a817@gmail.com> (Derrick
	Stolee's message of "Tue, 6 May 2025 14:00:02 -0400")
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<6fac9c4c394b9882a2f7af6209af389edf384e4d.1746458844.git.gitgitgadget@gmail.com>
	<xmqqselin30f.fsf@gitster.g>
	<3e307bf1-52ef-4280-bada-5cc50cc7a817@gmail.com>
Date: Tue, 06 May 2025 15:16:47 -0700
Message-ID: <xmqqselhfkq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> What do you think about something of the form --maintenance=<option>
> where <option> is one of these:
>
>  * "enable" (default) runs 'git maintenance start'
>  * "disable" runs 'git maintenance unregister'
>  * "keep" does not mess with maintenance config.

I think it makes superb sense.  

Certainly much less ambiguous than "--[no-]maintenance" given that
we need to handle "reconfigure".  Without the need to deal with
"reconfigure", it certainly is attractive if we can treat it as a
simple Boolean, though.

It is also tempting to just initialize the internal variable to -1
and keep using OPT_BOOL() though.  Then after config and command
line parsing is done, clone and register would turn -1 the user did
not touch into 1 (i.e. enable is default for these two operations),
while reconfigure treats -1 as "leave it as-is".  It would make it
very cumbersome if we ever change our mind and give a default other
than "leave it as-is" to "reconfigure", but other than that minor
downside, it may be easier to use from end-user's point of view.

I have no strong opinion between the two.

Thanks.





    
