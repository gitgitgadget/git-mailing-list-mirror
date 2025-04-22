Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C81DDC07
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307100; cv=none; b=Sj61ZXEuGcZWJiKWqxHqJpX7SNijw+pWDAYKa+UehAkya3SO4FHGNUti/GmPcqhf8tC8DWu3kfS6fN79Z3xxcO2IOlLbz/xcpZoL/IIzLq7rw+cvdHgPwEZLGozxgqX2n3wAKrP8yh/wxHUvLL7LxFoIdSI1ecHgIf1nfbn5LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307100; c=relaxed/simple;
	bh=ROkCISew3Mc60nszVaymzjyD6apzSvv4KhsAskF0RbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoHr4gdohfrJJoLdzMCuGW/EfTFhqRvye79WmoiMug/O5CCJOvykXQSC480ZrwcOTANHRZzKJC/ggCC12xgbflcOAo1IX+oWoLtE8/ypApVHxumk6xGH9G89RlKJ+lCfDJKlc0XcHC9yHwFvZA/o9t5jpMkavNYM3n2gKjCmN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OXtLMYrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZChTnDpg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OXtLMYrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZChTnDpg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 71BAF1140171;
	Tue, 22 Apr 2025 03:31:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 03:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307097; x=1745393497; bh=PS1DMtCP79
	JYmD8VwPFO0e5D3rlBS/4pxYjb6BzM4ek=; b=OXtLMYrDVUleS363Fj4G+LHdvW
	fk3Zo/Q6XtJsDNBzhR3mVlYKGeVTDcK+qrddouV8OBWOKrN4uTvGAR/zro6tdeYH
	fsuLT407PTqiKbbNEgOEedbVzupFk/HwZAQsf/JcYOewl9GmHs/sPLHrN+gWo9uf
	R4L19giKcjA+G8M+MsfjOQdrhVVCRM9j6vOUt4qFNB9cQE6x7abFr46RzfCtIQoi
	rFh7iSz1LDO4YlL1Rh1Ujxp0QuzLfIN2EvJmq6tjYB1DqOc4l6iwPEY0vuLVdEW9
	DGzHPzrRK10fKgDzRR1CbOIK2RhHV0RfzJz7A9/fpGe0Cccm7dieOtPgOFbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307097; x=1745393497; bh=PS1DMtCP79JYmD8VwPFO0e5D3rlBS/4pxYj
	b6BzM4ek=; b=ZChTnDpg+HSTn7tiSuVcr6MX+3SLfDx4P9x0iqp2NJ/Vmm7Vm3p
	b+O6Sja7YZKI/70Nq8iy0DlN79zuMSUS3KW34FW0soz93BQzmkkhhOJD7b2EE7FQ
	mR0+L2+sPqkDVHEw2B2GHPrtaJIMcXC6OpLlki0dSfQWle3HgyNVCcdrterHz3BV
	50J7ksJOfoet3PjZz0AAmo9arrMgNlYp7VOG3WuDyXaNzzBSsw1yarfZPsL6czmm
	pGpVteOWELHmJ3/AtZ4F7ongSLzsjmdo5YbmDempJ7mvm4RUcfVrCzQ4tnOHmvKs
	04fmJUNJNtu3fPqmVMo3HKk4UhUsmyIlI2w==
X-ME-Sender: <xms:2UUHaH9YyufKV3oH0C2OlcVD8j6OLmd0MAN_E_39JLqeuRF9253uUA>
    <xme:2UUHaDvks3ubuY-RynwajJg_Vru3TF1535gqHeVgxtX2YB3Ftc4aHKBe67sUO1yQ1
    oTDEUNKhlDVW7kt6A>
X-ME-Received: <xmr:2UUHaFCHadLJXTQWQaUItGrbtxd0vUMdDB4nmtCk22w1aS4hdhjpc--AA7Y-Z_kfponKTCMI99aMP6N93uz_j4VD4WREqzV2evb_Yg9VuCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2UUHaDfpI8k79RIjZrzG3SHK3WisdRTgrDjI7q09wcYwYxnyhxr5PQ>
    <xmx:2UUHaMN6ydR4I9aVPWWdxaslHbjvnNjL6-UkGQe57RTAtPjhrul0uQ>
    <xmx:2UUHaFkTv2TuVElhmpNDScqBZBNtqFtDbBkqhxhriHqqy4T8smlu6A>
    <xmx:2UUHaGvEZgdXkXy0hHgapbAS2DeN7iAsAyPvTwQbu1ieFi2wVYNt9A>
    <xmx:2UUHaJxe7aElV232OK4d0GZ1D3O_qfh_wlLwwnwO0cOl75fl-CRSLBfH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9af0613 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:36 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 4/6] meson: add a couple missing networking dependencies
Message-ID: <aAdF138y9wPD-G_t@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-4-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-4-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:48PM -0400, Eli Schwartz wrote:
> As evidenced in config.mak.uname and configure.ac, there are various
> possible scenarios where these libraries are default-enabled in the
> build, which mainly boils down to: SunOS. -lresolv is simply not the
> only library that, when it exists, probably needs to be linked to for
> networking.
> 
> Check for and add -lnsl -lsocket as well.
> 
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 8037e536dd..8fad10379a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1080,10 +1080,11 @@ if host_machine.system() == 'windows'
>      networking_dependencies += winsock
>    endif
>  else
> -  libresolv = compiler.find_library('resolv', required: false)
> -  if libresolv.found()
> -    networking_dependencies += libresolv
> -  endif
> +  networking_dependencies += [
> +    compiler.find_library('nsl', required: false),
> +    compiler.find_library('resolv', required: false),
> +    compiler.find_library('socket', required: false),
> +  ]
>  endif
>  libgit_dependencies += networking_dependencies

Fair. We could extend this check to verify which combination of
libraries we actually require to make desired functions available. But
I'm not sure whether that would really be worth the effort.

Patrick
