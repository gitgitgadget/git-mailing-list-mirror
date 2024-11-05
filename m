Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94931B6D04
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788090; cv=none; b=MTQqyHcdpQh3KmfoQ6nRF7LEXLd6fQUqy3K7Pz5WGQIsxzt4QCLiWncX63hOvZfdwQdhpn7zXcGLenSt/jl3clGf7Z8oACG+4KHToCjX4Td7LFr04xGPnoMxWAuR+xb7u0okQ1sRYg6cD1swE3wgKmCN+anZuuZwOW6W3WDEdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788090; c=relaxed/simple;
	bh=3roH7pjcqRYgMpBz0xKIqcnQXqkDFp6kthr8zWGrSyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQY0+uxGnmLNuSUyQjK+70zmluMjHgNklUugZfMdfJRH+rQdY3voqctcpD+SJrC5JOk1BIK3ZspvrzoJEgwWmX+HKiVwdWtq9iir072FSFX8sg+nG/7f8NBk/77OAg1nApZ0bSNtnrp2zQ+CqICbDGLurGr0s990EB7H4bJy/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rCY5jfEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTzzh27y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rCY5jfEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTzzh27y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1185254018A;
	Tue,  5 Nov 2024 01:28:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 01:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730788087; x=1730874487; bh=aa1ormc0kF
	2sDDYYpPSxcqgIK/tmNpEa6xuBb4MNmqw=; b=rCY5jfEKJ1mO0eyqGr7T77hueg
	2qSVUn5AzCTq+pixsM1FIN8b9DHlBf0yNeyLXMBGOQRJVRwQO52zxiOwZRuh7Kgg
	e27E5iqJDYWGE6kDYPpGs5+6yy0DtvrDDtWPQKW363rRiKJOwGd6bY7bLyrlWOri
	gAx33tT/YurJp4w7DMtVpaYVGuAietk+5HCALf5/uOiqkS+OkD69JScPFKp+3P9J
	y7rMBFnNWkzb60KZu3iX5DibEIyo4MpwtGvyd9ZnMcv3SPG9Y4Cd6PfZkqiKCMQv
	CMKddVc8/EzID1pGhaeyYbXhdqpohEz4e6BdAQDmxXDGAlDNmfj2/dj7RciQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730788087; x=1730874487; bh=aa1ormc0kF2sDDYYpPSxcqgIK/tmNpEa6xu
	Bb4MNmqw=; b=NTzzh27yToA9igCJSAPRihcqSeTvWFPiGbFbcpBktVj3//G0/0d
	Vg+EymnwvTa9DCNkcvrlWq+j7i+Y8oVnO0yo8+y0Np8cL1yIH3DJ6R7lyXNwpDOu
	f/ot4ceCG550uyR4JXLo4PXQpFcZsgMsCdffDalbGD4Wm99EVC5l2tfHr5YLE4xE
	jjbrcfiuX6fLhfcLUIiK8CZFJG98px/nu17ycYDiGNjxVWVoNV2luQOKhS+xqto0
	iy5cuGiwHpmzwfSsMGDImwcs9UPATQYnP5jAZOH+uK3xXuxLrTzNWOSQhGmI3fMB
	qwwH2t4ekUgAdfZwlv9VfB2kNeDnfnAGV3A==
X-ME-Sender: <xms:97opZ-Cf1axwnNdLCxYQNcJcBbigoH2tp-B3-L71Lp9WKNgYJtc8oQ>
    <xme:97opZ4huDm-ULq-HbBQXDwVlhMFva_d7eDmaG7-XDfLI09zDOXRDonBWfkdLgpmUF
    ETIOS_Kpi57p5z-sw>
X-ME-Received: <xmr:97opZxmYMw3mkA9TNd9mirzYVa3KS8LsrkE6zliGdqOY5GZi6lXjRNAQ3K7FnHiOf3yHrjWY4BUXcEp0MDF5SW6tWdRstLgqF1Ih1J-B-cupOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:97opZ8ykjSMHrwJfN6y2IodGgbhxQKuwhqEpu1Vss0ts8uEzlTIRdw>
    <xmx:97opZzQ3snUTLGi0iFEVg4FV_ptIlpMkrouM6lQT0UcQdxa1AteZ2A>
    <xmx:97opZ3bVULdVe8Gui_phnOMLHddM48LQpaLMoD2nKFBixHRebUB5nQ>
    <xmx:97opZ8R4mDzwzxtDtZWijyHcL4cTz_kCkBdE5DdYrBmTytH6P2F5AA>
    <xmx:97opZ9cztt8zoC8MydG81HaBq-dHRbnmqYirpQ3YbZo7dHaHubDPn00E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:28:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 763fc340 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:27:45 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:27:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] doc: correct misleading descriptions for
 --shallow-exclude
Message-ID: <Zym6723csrUdiC5A@pks.im>
References: <pull.1822.git.1730746964.gitgitgadget@gmail.com>
 <4c7f2dba686266be50cf11420beca633e1691dd4.1730746964.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7f2dba686266be50cf11420beca633e1691dd4.1730746964.git.gitgitgadget@gmail.com>

On Mon, Nov 04, 2024 at 07:02:44PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 59fcb317a68..93fe6d69659 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -147,7 +147,7 @@ static struct option builtin_clone_options[] = {
>  		    N_("create a shallow clone of that depth")),
>  	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
>  		    N_("create a shallow clone since a specific time")),
> -	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
> +	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("ref"),
>  			N_("deepen history of shallow clone, excluding rev")),

We also need to replace "rev" with "ref" here. We already do that in the
other cases.

Patrick
