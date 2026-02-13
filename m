Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121226FD93
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015947; cv=none; b=hFFepqxCm1CrsrZWAox2tF3IWW2fEwMn9DTVcoiRMNTRjXDMSsvwN4a+W5D3JzoP1gLdxBq1MNy2mmVn+d99bjvsiAgPchMy5Cu1O1hNusgrBxR7dfUeZPm6ryaMGaxwITqhGXELfhogbsjrmO7lkijwPjzdgl8Q0jj3AMtIK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015947; c=relaxed/simple;
	bh=a+pCWV1QBYWLtUHLRR08Zk6R83UhT39gBAKlnDVES6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehJel3J54kuTqz+2VPGBezzsnyxaKBQQr+JwhOZPVUqFs9nU6pZKI1Q7bAFZ7K0q8sD1bRLg7cD1xpvCXmxlg4owhs5KJ6UZb0I9vECqhB4ZpCDXo95ugX04KsWbHHXVuRwbu3i5TxQDjGwfEdQyfxR81/EM2IkwczlqZPiasuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mujz9Kzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfEp2/ze; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mujz9Kzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfEp2/ze"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id AEAF01D000F0;
	Fri, 13 Feb 2026 15:52:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 13 Feb 2026 15:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771015944; x=1771102344; bh=rbVG+r2xGy
	w9uMDSxATFGiGCVP+RgQndEEJ+1Cn/sOs=; b=Mujz9KztJWt0JaARSpwOhSv6C+
	PqL2NiF8UuX4G0OhzyO63MULikpnFvgcKz6c/tRR7ouRSUSSPIsUAIGA9hcrTWxF
	oh7r5Q1DcFclRyh2CJIGtrDvp26KS67j3f4HEwOI+66csgcKfRf/uTd7XLm1XDW5
	6cJFuVI4b/iWsdLPWrlR2j8ZA57zKWc4srZskMruVAZQeL+L6gCunOf1XF7yYGlP
	Y9gN+oFiTv5aYjvtA+OgFTbPA+lEEvoEYbb9a98n5zeKLHvTfB9Cq4N4zTzbx4oP
	Rdi7GBzZwZBudY315uWYdJkPL0mrnDtdhmElhqygeCvZpS1efo2hwDiOD5Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771015944; x=1771102344; bh=rbVG+r2xGyw9uMDSxATFGiGCVP+RgQndEEJ
	+1Cn/sOs=; b=TfEp2/zeA6v5W61+MUjN1QyDQQMCf5u25gL6xYKK6qY//+CKk0a
	kqwnQFQfDhTu3D6bCSnG6TQxYIlR6GA0A4y9qErrnEVu3lW0sc3oG/ToOOGeJnfD
	6Vs3BSHbou88yjHsPL3oD0AGfCZ9YJzloD49hsifChR42hb56CDfgdmRaFyeGEqW
	Ycb/WiZ6R5eHtSgSosXNKbx6/s3xVNNtpsDijpDYBYbCaULiZktSBHaRQ36jD7SG
	w7NW8jHGhot8DQcr65wN7uU4KewQ9TW4Aca++ARL84MYEvlHMCbuQPDdFaQihIBy
	esnC+MDA02n8IQ5yJDByDfDNDNRBsYLps/w==
X-ME-Sender: <xms:CI-Paavt0edPGNVZMN_nVG1mIAvCHtUTCGFtAgGGoYJo2JjCzpXXgQ>
    <xme:CI-PadCv0Z4JGW4w9M1AsuoJAbv1Kvk10pqDgeK5NNvrcQFvxFkBONjD_i2aMKov5
    7iDRFbZ3mw54cQz1TK6eMsauvcfouCnxUo0pNBLvgrGonocZHwXtQ>
X-ME-Received: <xmr:CI-PacMprAWHqhtBIGjiNclDDpLbYAKHyxrP2nxcUlDCWU-h6o6q2mQS5xoVg-tzf44SjYXkAHoOElmBWXoKSTm0uA3qco99ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmjhgthhgvvg
    hthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:CI-PaWzOS_kINsvJ3mJzSYciaxdpIOYhTNhL4jun6ET0CJcMZiV2eg>
    <xmx:CI-PacVLmYYipTa5CFnmQtBSwaAEFWHPi26RjJ27x4kupQigkysJag>
    <xmx:CI-PaYOczix_zENxUQnXOWrkxq4O1blKkxVT2Xdo6lglNDfVp31zfQ>
    <xmx:CI-PaeBQwyVgprAdy8VEqUqgovL1sUePYtXnXp_dk6-B9x0aFZXbXQ>
    <xmx:CI-PacSeH00bv_cSj3zH_WQfypdk6-FrIsK5XuWv47_J2CyKnW-jNxys>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 15:52:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  johannes.schindelin@gmx.de,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Matthew John
 Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v2 4/6] trace2: emit cmd_ancestry data for Windows
In-Reply-To: <6b9054115eddeb08d0e429f1ec45093691dd84d3.1771012500.git.gitgitgadget@gmail.com>
	(Matthew John Cheetham via GitGitGadget's message of "Fri, 13 Feb 2026
	19:54:58 +0000")
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
	<6b9054115eddeb08d0e429f1ec45093691dd84d3.1771012500.git.gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 12:52:22 -0800
Message-ID: <xmqqpl68l62h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Since 2f732bf15e (tr2: log parent process name, 2021-07-21) it is now
> now possible to emit a specific process ancestry event in TRACE2. We
> should emit the Windows process ancestry data with the correct event
> type.
>
> To not break existing consumers of the data_json "windows/ancestry"
> event, we continue to emit the ancestry data as a JSON event.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  compat/win32/trace2_win32_process_info.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Quite straight-forward.  Given the way json event readers are
organized, I suppose that existing readers will not choke on seeing
the same data twice?  Are we officially deprecating the "old way",
or keeping both to serve two different audiences (i.e., those who
have been in the ecosystem long before this change and want to keep
reading in the format they are used to, and those who are writing
cross platform data analyzers that want to stick to a single
format)?  I do not think we need to decide it now, and if I were
asked, I would probably vote for the latter, but just thinking
aloud.

Thanks.

> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
> index aceea05430..6a6a396078 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -172,6 +172,11 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
>  		get_is_being_debugged();
>  		get_ancestry(&names);
>  		if (names.nr) {
> +			/*
> +			  Emit the ancestry data as a data_json event to
> +			  maintain compatibility for consumers of the older
> +			  "windows/ancestry" event.
> +			 */
>  			struct json_writer jw = JSON_WRITER_INIT;
>  			jw_array_begin(&jw, 0);
>  			for (size_t i = 0; i < names.nr; i++)
> @@ -180,6 +185,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
>  			trace2_data_json("process", the_repository,
>  					 "windows/ancestry", &jw);
>  			jw_release(&jw);
> +
> +			/* Emit the ancestry data with the new event. */
> +			trace2_cmd_ancestry(names.v);
>  		}
>  
>  		strvec_clear(&names);
