Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD1227EAB
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556962; cv=none; b=p+Q6Of40DYOI017hn0cPUpf3z9X+3S3wcdionFvoC9yidXJrmJpVXfcvbPyz1p3qFW9hxstghIBfCl9q8p5lznOlRF0eCDqh+AJTFBiXe5G0xiaLRL6OrStIP/ehlVdnbMeyiiHlj+a2QQJy6NITWen4jg9AKQFgSicqq5Abr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556962; c=relaxed/simple;
	bh=PhyirGc8t9fdW/iGUVh+UR36PBeloU50g2CA+9No++A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkRDpzLO+OVqXBOTioj0r3Y2Gh48FGOI205vi0RQrcG6nsH6CMa7uU1/UGMgOm6gTW3gYoZrI4MgzL1pwpZfVqz5BFUH543EEG8267vg5rcuMiACUGJTXIBCIfOdLwQ8asRp3mRbP0D7NZmI+yaukuIYVTfmvltj4Fh5WvrzBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IwDy5RsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdKj9gfx; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IwDy5RsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdKj9gfx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ECA52540244;
	Tue,  6 May 2025 14:42:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 06 May 2025 14:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746556959; x=1746643359; bh=r5YzOomv2+
	uWtPqc7aTYr9cwR7eEJ+4gstD4hHOnrRM=; b=IwDy5RsNmG/XO0AiWr8K7PHI+p
	erc3kcBzLw8FdnswpZyyE70XVel1gweyq4bdOUNgBxG30lw50CGKz1acfDPXXAd8
	2f9ULEzGcb6bE0HqeH8Hm/nJKTp0TSPm1rJ+ulUsvd7wvIO1rY0esIIJqpir8yWn
	QS/6EqKeoQjS1/VnWcyjATIWwc5yDM2ryeCJxeY71entZE2Q5RB4ljuXFKBY7JeW
	9IsfL3va+EK9rAgsVZwu8K4gFaAHc34meVGZoyDhSb4lO3dPrsQqqJT+SNjyqb5F
	+m1AwfDeGvSitLNk7AoxlBns847NaTdPTDDDfzRlX79JTLxumRaBg/lVfWCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746556959; x=1746643359; bh=r5YzOomv2+uWtPqc7aTYr9cwR7eEJ+4gstD
	4hHOnrRM=; b=fdKj9gfxWhTcZXQLMpw9EDnNKcjH9FUFkf+mr++hBDCcHgrl5TM
	9qFDhSRvseAgDi5RnJlUP9Tz8BCt+CggRIw8JlPnUMlBHJWIxKLsPVSBS17Cycn+
	5OjZaozGz+ZvN6/3R3ozZo1UUv8gVKp2zMK/HuALeZk8C95WmHdslLEyNNqADh3l
	3TEwaQxindBkPBt0eiV9ei73wH8xow3VVVvFQns+dR/YCgm0ISUwP2Kt5bjLBcnq
	wgCLtSZwSvt9yETofXmU8HajfaIo2GhQ2E+ppoOImqlhnm1vyCF4VU3AUF7zqrDu
	qEsUG6ACuWbzJ4+fH/nndsTRDiWVVFBBHIA==
X-ME-Sender: <xms:HlgaaDGleq4IYU2bvRShezS0qXcdEnStx8CwZq4A6tJuj82Jo_oL1g>
    <xme:HlgaaAV4xInLncVA-zb3X8_P8DxIK7HLSy_EZd5d8D4GgGzYba2CHv2MfQzEorz6g
    UkDHVp-t58jX8eHXA>
X-ME-Received: <xmr:HlgaaFLwdx6j2WzUbGXXQiqnAryOI6hKKNrG3zVYIK_EDO2l-G0ObvsDBQb3o7TiC8ZxU2d30ZAAWz_Xcf9IPlQ804f0C0kXM4oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HlgaaBFrdqerVGPwKSfTA7KwOcSvTLDBbUKMfqgmoNx0O1ffizWyIQ>
    <xmx:HlgaaJWgjF9YzXbiKCzlkHlHj53MxsPXTv-lpSwWW1qyvhJYgYTHYA>
    <xmx:HlgaaMPZaMdIKU-RNYms1jf3ChBqIXCAfjYgMH5gmSepeinm0nL5CA>
    <xmx:HlgaaI17q2cTq0nIhf7KJPvJq44nZFnsiEUHgixCzGwN3xgaB3_kxQ>
    <xmx:H1gaaPAxJoRa29a7GCUanJguPYaKEhk5rpNsfzMJf7nKgQuY6N1LPo13>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 14:42:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 1/4] packed-backend: skip checking consistency of empty
 packed-refs file
In-Reply-To: <aBo7nBOl18WWYIsA@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 00:41:00 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7nBOl18WWYIsA@ArchLinux>
Date: Tue, 06 May 2025 11:42:37 -0700
Message-ID: <xmqqr011k2ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> +		touch .git/packed-refs &&

Unless you want to signal your readers that you care about file
timestamp somehow, don't use "touch" as a means to create a file.
Readers would have to wonder if .git/packed-refs existed before,
or what git command that follows this part cares about its last
modified time, or what behaviour the timestamp would affect.

What you are interested in doing with this is to ensure that *AN*
*EMPTY* file exists there, hence you should say

		>.git/packed-refs &&

instread.
