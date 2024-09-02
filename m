Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CA13212A
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282501; cv=none; b=VUomCttU+P+p0p/r8hrQtM+Grw5nJd/VReW0d28UKQMZu5xOc63RdXxjxKQsm8kU69Qp56RDFxixtzgYprgHV8jy7/lb2vZ/+0TsTIFf9BFgVFvBmz+62wFg388z3lyFI3BynfT2j0cCUkkF0irC5D6Pi9CSqsAFtxrPtCYmExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282501; c=relaxed/simple;
	bh=H1FwPKXsMzBPW7HII/tUles5qDnjqDc8uFCb7fVxJ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gss0H3d8FHPmk8giED3mV6kGM/qBz9uXm12EazzU9p0PvnTuc2Jf3cF2Ey0tL4IlOYWK8brE5SGUOUyH8aEb/eP/+6V3OvuL913de0aZh8qCIhD+s9WMAsVX40Wf4UrkWNo5cw2jiLIuq4lN7/LigCbS4+FbgfD9JDHikkXuquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fmgtusJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqfwRCge; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmgtusJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqfwRCge"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 589CC13802D4;
	Mon,  2 Sep 2024 09:08:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 02 Sep 2024 09:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725282497; x=1725368897; bh=33unBbcJuk
	yj2vqdl6rGqip8/M1t2DS0XnGAF73iQ+w=; b=fmgtusJ0wjwUwbNvdZmvxfnyyY
	LFUxED4pu7WZcAgXNRB8kGrVoEcnz0jjm9aNnPf5+O3sFPhfSYNIVrFyotrY0QSl
	wvBLfY5MZqDIg8ehBA70wkzxCmkfeWyXZwQGVznZe2b0mKPvPwYJ1XAN1Ymyy+HE
	6+WxxTHmfrHbt4XrRpZSzkPXFGj9zVv3EnRPgMxc2T7p/rSJp7q2Hw5MVsJXlXSy
	dH59UcB+4lE8dm7Ph5H1jamrEf1nrkrMA6np9l/SzKCo9z2V37zdxOU7bVQjAiIU
	fN57dvdjxfLTflTkjRquLSH28NKS36j01bpqizJnz+HyVZTJhstlNUGuM6Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725282497; x=1725368897; bh=33unBbcJukyj2vqdl6rGqip8/M1t
	2DS0XnGAF73iQ+w=; b=OqfwRCgej9NmLhDTmaQaoZZCGH/LTnKsjzNHwK+nSR8x
	faVIal+qw/o38AgmamwcN5BEexWS+tWpx9ogHK316CrvKUrbCmBBiRdLlvt+RIo/
	yc3cwqFi1J/obRy+yYaDzTxE1xcW32UsNTtMi/qPkm1nAzNLzGZLnSzS3T54iL9g
	udrFUxymp1ByoArJNa4xm/gtxJWlS20hb71/fGxfaxnKmZIXfDwMuDXf0bcOT3D1
	pWxPJvE8UpHddm0wsOhD70XIOr81EQaivcBA8HSLXEOEQAAfgJffbqW6TuWFPlmV
	NTt3/BPffkwfnBqrcbHsnfIMZpUUZE9/pYcMSwdEmw==
X-ME-Sender: <xms:wbjVZmcWPdaKNBkQaAAmD418I2nmF5Tf79GlUqDA-nyZvGIWN-omtw>
    <xme:wbjVZgMwDVtqwJ_2EjNB_CngBPtIrTLu2dV8Bww-QTTxEtAv5YV25vJbPWckAnZJc
    QM7EX51vyNEODHelQ>
X-ME-Received: <xmr:wbjVZnh75HESOocvW5Bvh77-6PU-OP0vIK0xuA4JTVzLQpbtvRH0rCNiTSW199Ss3cHXwhNUahnRQvhABAzUEAKa8gwA5Cn6SPhsX2g6m1WpBPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhnihhlrggv
    vhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wbjVZj_OuewWiZMiea68wR8HeMqEtls_gC-PRtymlF1yavf6bqKOqg>
    <xmx:wbjVZisvwbpRxojRrpVpF5I8MZJ8J0rsfWDC_fGL7n-A026MhEMreQ>
    <xmx:wbjVZqFTLFsFi6HZAW_4HxCFQth0k9jVHFpRVlwdAI77bMkkZkqNqA>
    <xmx:wbjVZhPTC87bzDQ3pIDspUzbqTdBZkLLwz1BAQe7cAkWGjtUJhWPPw>
    <xmx:wbjVZmIslUNN8vOoB1L5ECvObqDtQnwIpTEYpdReveo6JCCKxCd_borl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:08:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96e9969b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:08:08 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:08:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Yuri Karnilaev <karnilaev@gmail.com>, git@vger.kernel.org
Subject: Re: Unpredictable peak memory usage when using `git log` command
Message-ID: <ZtW4vD3j87oVkWKC@tanuki>
References: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
 <20240830210607.GB1038751@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830210607.GB1038751@coredump.intra.peff.net>

On Fri, Aug 30, 2024 at 05:06:07PM -0400, Jeff King wrote:
> On Fri, Aug 30, 2024 at 03:20:15PM +0300, Yuri Karnilaev wrote:
> 
> > 2. Processing commits in batches:
> > ```
> > /usr/bin/time -l -h -p git log --ignore-missing --pretty=format:%H%x02%P%x02%aN%x02%aE%x02%at%x00 -n 1000 --skip=1000000 --numstat > 1.txt
> > ```
> > [...]
> > Operating System: Mac OS 14.6.1 (23G93)
> > Git Version: 2.39.3 (Apple Git-146)
> 
> I sent a patch which I think should make things better for you, but I
> wanted to mention two things in a more general way:
> 
>   1. You should really consider building a commit-graph file with "git
>      commit-graph write --reachable". That will reduce the memory usage
>      for this case, but also improve the CPU quite a bit (we won't have
>      to open those million skipped commits to chase their parent
>      pointers).
> 
>      I haven't kept up with the defaults for writing graph files. I
>      thought gc.writeCommitGraph defaults to "true" these days, though
>      that wouldn't help in a freshly cloned repository (arguably we
>      should write the commit graph on clone?).

It does default to true indeed. There is also an option to write commit
graph on fetch via "fetch.writeCommitGraph", but that setting is set to
false by default. To the best of my knowledge there is no option to
generate on a clone, but I agree that it would be sensible to have such
a thing.

Patrick
