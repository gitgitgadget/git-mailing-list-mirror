Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794372144CD
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601615; cv=none; b=QYqxYbVuGIbpzF2fTVWQ3AifzM6OB6IaTyklhA9H35176WXatx3DNoEPrnbnUrB/BmQFbji2Xcqin1J+TJjRcsk4+MIJBjimD7wo608Sj0C3jjCtjTn/1FJjNdYI+t1FM3n8YfaxB13lGFk0pJkMnnLoL9LNFyfinrkS2du0/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601615; c=relaxed/simple;
	bh=witw/uJuDMwcxEHvvJdkC93xtHWXUyK/T80CUBJud5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NshYZls4wDtSHIIEATYualT4FsKjvMiAN0Nb+RDUfAJWpugdab1b++VQnhS3sy2cYQ59zP/QOFQ4YplHbhcAGcz4tOLCgPLUOGStAyjJows4x/rtBylRpkNYtC/RjvpwmBAb3zyeyDVSwNRvb+QV6ebLYPMMgL+bvl41nbdna8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qV4p8BHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwxdA89R; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qV4p8BHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwxdA89R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 450E4114011B;
	Wed,  7 May 2025 03:06:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 03:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746601613;
	 x=1746688013; bh=Mi4cMvzLiub/7yXrgFazMHySar/rahuKf5hGTe4Bpak=; b=
	qV4p8BHWnFFwRuqGds4p/f71P1f9pvoanMQd0kYRYadNwLAZ9rToivPh3oe+sce2
	P2yD1EKi3TaxfLoS4dxWBHgctJnQa8WUs2ESOrW9WUd6q3Ay/reIhZipbhjE9nDr
	qVIe+rZ7XevMGgo3hPQrMvywHgT2boXegRpumjQDgVtZavhJWOzwAbnQf0d1Psou
	hYtAMZ+7qgrIF1ukvn46O2b2JV9KkzvQc/2ceY1YlxVAVzMvo/O2WUjyHC8Hy0F8
	aqzVJC3XeywlkHIj3hWHTSGEZi4UEL1p/8Benyjc8lEgkNYv4hFBi92raHCNrBG1
	+sBOPFstWcgeMYNB/kSaFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746601613; x=
	1746688013; bh=Mi4cMvzLiub/7yXrgFazMHySar/rahuKf5hGTe4Bpak=; b=D
	wxdA89RfFJxPu7ZMJacAMUvrNht88PjuZryTkkrnvoGvKcdjxtxuwdRbMJYYidVZ
	890VkxnAnt2EiymszRJySTSTjvD8Q9vg5x3SDKmhju/N8KaDpXXe/um7wc7TgpzG
	Lp0Fa7AFRDwZrQBuHTqZG3MrxNr1hCsbRj4UPKaFsbr9ffvFfb9soS4YfgSoIf8I
	C4y/HeDYSTtSQLISV4Nk9pFOt7fKFYBzLjkWTosqH/vwzK8rNvvJbAfuHxNi2Mih
	70yH4KXH70KvHi1vn4jiKK/2S11cFJXhsyLqj985hE0D6OsK8BFmaYxFC1rXyhcc
	zxXtZUxFWPI2P4r0rL4xg==
X-ME-Sender: <xms:jQYbaB-h_o2m60RhAM34YXBEDUMN3Cw6LfqxJ2OCHl9QVMSCEuxuQA>
    <xme:jQYbaFuQtuw-9nus9QO9XAF2xsROcatKfywnRlJTu4yKeUOBkepulkFtNNeGBPzZe
    ZzsVhJESlYHDhhU7w>
X-ME-Received: <xmr:jQYbaPCQscSaow3sr7XlsiRy0Zq8Cr1aqIN3RPOd013aWc9bFDPXRWoGX1OBakJYxo7d-FtMrICpsiVUrKx5PJfCQeOWNRqVjJB3iqAAFptyiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jQYbaFfC9UmPqzS-WyIbktG2x23o5CDI30W-BuskZVKuVX4bW0fXsA>
    <xmx:jQYbaGOttSCNT8iKuL_UcSn8xA0RINof5a7RI_fwBZYfVHW7AXNCAA>
    <xmx:jQYbaHlhTFks4_cMELvWzgH-d85dmN4GUzyvGcTBfCiFMZiOF2xeKg>
    <xmx:jQYbaAvIQeGjPpfUI3-3h9XBKhyq79TCineA8-wn2Szkt2TaKT7gxA>
    <xmx:jQYbaK594Y1Y5BgLFt95XOHZcQpDettFITfwUxkrTE22Epj_85apxlxN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:06:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ec8b4f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:06:48 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/7] builtin/gc: move pruning of worktrees into a
 separate function
Message-ID: <aBsGiu3IBIUuYuYU@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
 <20250505-pks-maintenance-missing-tasks-v4-3-141f4df906a1@pks.im>
 <CAP8UFD1ZtYMf0ja75AV_jGJgzAL919zpHoGy0v-G2tNV+OEDwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1ZtYMf0ja75AV_jGJgzAL919zpHoGy0v-G2tNV+OEDwA@mail.gmail.com>

On Tue, May 06, 2025 at 09:50:12AM +0200, Christian Couder wrote:
> On Mon, May 5, 2025 at 10:52 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Move pruning of worktrees into a separate function.
> 
> Repeating the subject at the beginning of the body part of the commit
> message doesn't bring much value.

I disagree with that statement. The way I review commit messages the
subject is often detached from the body, so it always helps me quite a
bit when the body is fully self-contained and doesn't depend on the
subject.

> > This prepares for a
> > subsequent commit where we introduce a new "worktree-prune" task for
> > git-maintenance(1).
> 
> I think it might help a bit to reword in the usual "describe the
> problem first and then say what to do about it" way. Maybe something
> like:
> 
> "In a subsequent commit we are going to introduce a new
> "worktree-prune" task for git-maintenance(1).
> 
> To prepare for this, refactor the code that prunes worktrees into a
> separate function."

But this reads better regardless of that, so I'll take it. Thanks!

Patrick
