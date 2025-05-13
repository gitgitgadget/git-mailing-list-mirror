Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3387188713
	for <git@vger.kernel.org>; Tue, 13 May 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155832; cv=none; b=qyLnnMFqszigVG0cYnqL85bkkpnm5AjkoYvx5jD9gsw/jySbVhKLRkcM07aaSZQSOvur4x3LiXLPUtR0sqrginYkA56oJWiZxzZ7MqoYdb22G5qk6mQqeEIl1fk91ykixMFx8mpZJ2yRh7GDb/FTjwIihUo4DQMM7PlX7CIoP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155832; c=relaxed/simple;
	bh=z4+Ya6umudtNzZJd0cWF26JVXVl92Td2O5020Z5MTSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9jsMTUO4VO1Xq8yxGD50QTklxoYUZDbMy2DQS/4uhFMFSu8Y0XmmRvd4ZJVvNBn6kxnvZIpn5MxWLl9TDh4BOlrMaVdDgv8KGBxiKTwk9mqpEUv6DWzxj7DgiFr7i5Jftv87wS0402skyaGWD0mhopfzSZYNRR5hmCeDpswyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FPMf06+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBT3EPyp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPMf06+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBT3EPyp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCAA125400E8;
	Tue, 13 May 2025 13:03:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 13:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747155828; x=1747242228; bh=Sm8mShyyKk
	dzpXZPpuJ6YKqZSKv/TBPXon7rjtkLgiw=; b=FPMf06+lowR5Bbld3W02x/yAZ/
	vKj8ns8awRlo+n0GM9wSSgLCUjiyuPhebE5DXImf7A0b2z3wdwisT2lDuKGCZV3u
	ZmReiH/Uynhah9pj2i44JRFDpWTvw/tH9ul00FmSFyDsRB/J56elPppOSU5LbNEo
	dSgXdX7JsZEuqiwbbU70NcKF0zbTnZ444LfeHhH7JQw8pnpOirKqILb+aF/WKvc1
	4RUWRuff/fnaBgZgpKvK26yTSIMRz9UEfP+DgfOhtOaLdTfDV8NXwMve1o5+06BA
	5R1BwehFf2bHivnq/QYOHjwTuFUpzmMMAcNe33dYU9QnUnwiAtFNPtr5biNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747155828; x=1747242228; bh=Sm8mShyyKkdzpXZPpuJ6YKqZSKv/TBPXon7
	rjtkLgiw=; b=lBT3EPypzhUNZQd1ChtB2e+94InWGXN0iiDOexTaXOGQenyiTvB
	r5hwarwRNDt5znE0+ESoesL76OQ5vqJnriZ86mVFHb+ruvlGCmSQFHsmbIYMLVxH
	FJ46OSe/xmivSaN1rsFts4kI56ggCSkQstqZvktCzQzWaF2p6c1b3w+YL31VRnsf
	wAGB23jMHVDyDXMPPNGD/l+adIge7hLGRVZjBFVJrF7TSb1a4t9WPJouIQi5VU9g
	AJmk/zBPhABLRWRSICd3n6QSxnUnku0Z+Abc0GO9XvJ/kWLSKCnMxutyfdwCefTn
	R0pyBAcDUDZxuuYD+RPjB0dl5GjgSMey2Yw==
X-ME-Sender: <xms:dHsjaNK8_XI8NiBflcOH_kdJXouhIdoOJP58GPSdvpdkV_NyJkNAag>
    <xme:dHsjaJItPGNWkHj6ViCY9AwoeRXjdoPKhzCpqs9BuO6y3-Iwl8wkc66CkM8Mi-nHD
    xboD9DW7_sg5lGmCA>
X-ME-Received: <xmr:dHsjaFvriOfKXQyxr2SlPAYYAvHP78G06onoayQ5Mj7OZ1HgiXopreFysQ8jTiPbgf1wGzmz3ZDpjns2PjdwSxwCy0-s2B6FdtBYSGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dHsjaOZjh79GVLhKwSd7dp2yeDZ141R8uLlC61TbeP2O44CwqM62EA>
    <xmx:dHsjaEbxsfjKjcDEy_b3HMsfRxurt8yDnnT164Ifs4uyI-NAYtkA9Q>
    <xmx:dHsjaCA792PBA6BQo-BlJMTpdTQQgranU3cXrZk-qWE6-lAQOg2MgA>
    <xmx:dHsjaCZ-gGPeIYalMNvsGSh-U1Y-MTjcHZWocDnubkNOFKRC_v4QLw>
    <xmx:dHsjaKtTuJUSHU9LmPKGbFuvNqVQBAdKTYA_aBPuuGR0z3iD3bW9lI2->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 13:03:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
In-Reply-To: <aCMNGUlfBcafn97s@pks.im> (Patrick Steinhardt's message of "Tue,
	13 May 2025 11:12:57 +0200")
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
	<aCMNGUlfBcafn97s@pks.im>
Date: Tue, 13 May 2025 10:03:46 -0700
Message-ID: <xmqq4ixoh28d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 28, 2025 at 11:32:12AM +0200, Patrick Steinhardt wrote:
>> With 7304bd2bc39 (ci: wire up Visual Studio build with Meson,
>> 2025-01-22) we have introduced a CI job that builds and tests Git with
>> Microsoft Visual Studio via Meson. This job is only being executed by
>> default on GitHub Workflows though -- on GitLab CI it is marked as a
>> "manual" job, so the developer has to actively trigger these jobs.
>> 
>> The consequence of this split is that any breakage specific to this job
>> is only noticed by developers who mainly work with GitHub. Let's improve
>> this situation by also running the job by default on GitLab CI.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> While there has been discussion around whether we can in general avoid
> some duplication in our pipelines, I think this patch makes sense
> regardless to bring GitLab CI in line with GitHub Workflows. I haven't
> seen the patch being picked up yet though -- I assume it fell of the
> radar.
>
> Junio, do you have any concern with taking this patch?

As long as Windows stakeholders are happy with the change, I have no
objection.  I didn't pick it up simply because Dscho didn't sound
too happy, and I do not take "The code seems to be correct, but I do
not like what it does" as a positive endorsement.

Thanks.
