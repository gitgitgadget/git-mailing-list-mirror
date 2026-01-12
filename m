Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D413314DE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205883; cv=none; b=Po7+uU8C/lsHSTxZEmKArIekoQFTwI1L3v9OA7xL5KOdHX2Nh6Pr97cMBrMbQUgZjoAqogrC2qNAW64w8AT3SJd3QLi13Xbo1SbETmolCXtjFd0lzVOf9m9rNYJ2cK+rI7EAxBOPWkYIOuMmug8gbAYfQ/ExsooPmLkU0C+2IAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205883; c=relaxed/simple;
	bh=uNV6i4JCfwsoaa8jUH4PiYMvGAHjkQUPQ7gunPObsfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKQ/vJPymd5NOuDh9uvnfK+AqPWrtwfJOX0rLEPV4DzXCSSOJYRJRLu9hXw9D/McdW2qzxouJteK+E2nThnotI3NssruHNpdzdJvQFEznzPRDIsVOdgD5Gj0Hz0wyB2Q+XPbf7te/hBcttPWWsasridzg32dnIKFlIqSHioXCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NMDURZVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzDnaobN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NMDURZVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzDnaobN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EB181D00033;
	Mon, 12 Jan 2026 03:18:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 03:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768205881; x=1768292281; bh=q7pVnvjYjk
	k1+JCoYdzC/gt1Bvclz5GvlvI0F77M1Yo=; b=NMDURZVKTfaubZ/wKQU/Bf9lGo
	qyxfGJzOiUX+QNYIDv65cRaUm4PTqYY5rrxvjR0bwbBoqao/FBeqeKyg54K8zpCC
	+W8j3zzCTerYSO1acSbNwj3OEhcvQel/+acrZh8C3pCIii2VP6KmczDKrO8FH8iU
	B/GFd7otccn2UnEmWRFUEEFd5xLZZCS49fFxagrQhW7n9twgCWxs4MXXtv5h+UkW
	s/88duZXUNpeEGpmYeYMsfEqQUzof1HSOYIav4+a+fXHSGLFHnLS9udJUaZRexfQ
	DUfK3rJyaHUHfJTT2ZhC5yo7jSZG/1jzTQW7+l/W2licfB4MAXlcofc1tXGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768205881; x=1768292281; bh=q7pVnvjYjkk1+JCoYdzC/gt1Bvclz5GvlvI
	0F77M1Yo=; b=HzDnaobNbugZnmh++VJ2128IA268Uh7XtyHlePu1ZRJ0m32raOr
	Pycx25jilKNnJu9k3tw2bOGI0FAGuojxFBoS+SstFYScuqHA9kCI4wdb4RY4JG3J
	W9o+wAL4IEvOtQY1BRkYaDwbTQo3BPobljdic4d+uwBHgXce0dcZ9E0MtS+6bqtP
	Wr/uI/nf/tKeyzxyX6X37Ua6Gx4FnfGRKWLCkpRaSZu/IkXYu8RPtf+A2mgZcHBf
	HuS19Rhb008MVXCYtKZdXstyqMcWJTU0FStIHkNE9SOygi3T/fbT6aOWmlsCL1+8
	vNKWsF+p0QW2x3/wciBcBviBSsm/ZfA8yGg==
X-ME-Sender: <xms:Oa5kaeczRU2Udlae1kVgJpkmbZ12Whyz4K4hOCUa3AOlTMmZrwGrQA>
    <xme:Oa5kafqa3u8ak4NxU7m4wF8z4kVmw5qIxiZacrTenGvy7XWArlvqQrfEC-pDEdqgp
    9yYTO2GWuPX4YAgNxoukAhwNGg43m2bwJxFuvmMhYDdQ1zma7iW0Sk>
X-ME-Received: <xmr:Oa5kac6g-v9NFk5mtloEKmWyxu1lSq76beUKDZ7R4taWh_iWbXFYxD3Acp6Fm1TfpSUUYP4k3sM3K88Zy3I8pzoo8otl0MkCMR7_dQ86jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:Oa5kaVoP4vTUMTgvn-M00XXXq-3qAuXtey1zPhukFGzSNjB6OZyBcQ>
    <xmx:Oa5kaejgZPse3sx_YeY8VLzhihE3I_dVdIWXViJOC4L9LAIX0K016A>
    <xmx:Oa5kafKzdTwJTDJhByQFdwVNwp0Ne01EXgLJv1Boo-Dhpni9WnMIMA>
    <xmx:Oa5kaeATtKrD0K0gJYdZNJ4Ug6ZNlkqQ4OUOTXf0DQeySS-rEsghDg>
    <xmx:Oa5kaeES7q7SdNSgkBAWWb8fS0MlCtQ3rBcHrnFPxr1HU7w8_3NN-23i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:18:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8764ad5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:17:59 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:17:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 10/17] refs/files: introduce function to perform normal
 ref checks
Message-ID: <aWSuNFd6USWqvLQX@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-10-3587dba18294@pks.im>
 <aWJQL3WdZermrAUv@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJQL3WdZermrAUv@ArchLinux>

On Sat, Jan 10, 2026 at 09:12:15PM +0800, shejialuo wrote:
> On Fri, Jan 09, 2026 at 01:39:39PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs.h b/refs.h
> > index d91fcb2d2f..61c56cca36 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -655,6 +655,14 @@ int check_refname_format(const char *refname, int flags);
> >  
> >  struct fsck_ref_report;
> >  
> > +/*
> > + * Perform generic checks for a specific symref target. This function is
> > + * expected to be called by the ref backends for every symbolic ref.
> > + */
> 
> I think above comment is the same as `refs_fsck_symref`, I think we
> should update to say that we perform generic checks for a ref instead of
> a specific symref target.

Indeed, a classical copy-paste error. Thanks!

Patrick
