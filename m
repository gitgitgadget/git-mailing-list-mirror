Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD252E7162
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167061; cv=none; b=hdc0QwiCcTZAlTupqfse6IOALc1MIyfAaPtkD58zqSx04TzTcOzbx429d/K36zxZSzPMFUYxNpRXjT3DcG4cBDmqFgbmmfQielke8OlsJCLj5BGP85IUub/s7ZR5ItRCRHh2Pterj8MExHVelYutqo/UTKmjzBczYs5/eK0riLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167061; c=relaxed/simple;
	bh=MibBpseYHy80xKyYEeH23nmHUfUQIBX3sktcFGgPZNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEv/PtkWVaYWg5ugsXXlF93yXlt6hBTyYL2/N73NtcqVNurnYJfMoMDvqqYy9jpAWRmycu8J8LhrljFVWiVvi3VV3E1iDr545MQgm34KmrFDtOHXGQY3URQnxBPXK5Kmq4sEUSRkJIDhV48aOBjeoK/9wX+QvRptLcZ5GqkH1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jFmmVd+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnNNxxXX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jFmmVd+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnNNxxXX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC6AB2540199;
	Tue, 17 Jun 2025 09:30:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 17 Jun 2025 09:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750167058; x=1750253458; bh=bpaqcevNIv
	f2HpA2AYBDoFXEdBgqCI3nXb+CPqGwFy4=; b=jFmmVd+QzMRtWM6EhJyKVeQRpF
	6cVB/+nIsmRt9gNohwIEHpTjkkRav00HV6YaXVed1mHCIjkvv8+1wmUiqf5lAP/R
	thUTYelrE+zGlNCVVbzWwCzF4GwhhU1zFkgmu6o3p+rN/hwLoOQVZyhSD3POhrnU
	r/xgxUE3/2LdPZMLo3YyDjc+CPMbMcLQ5T+CNjm8fvrmrNbynkf5CiNEDBeAK4ot
	Qu0eutFJdFSPJLDKJh/6JUAIE8cv66hU18mRHMOeGMRcbA7dUTuyY6zXJtq43Ehg
	VLtT+CXX6M7pjG+92FOEiBliJNCD8A3Wbyeg/9z8ClTnhNIPeGoZvN3LpRWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750167058; x=1750253458; bh=bpaqcevNIvf2HpA2AYBDoFXEdBgqCI3nXb+
	CPqGwFy4=; b=BnNNxxXXQLTSEb6CdX4SwJcxQC+IPmrhIyLn26txYnQowACkK8d
	GcAdpxNmRHCG2QB/oQ2V0PJIO4VUWQqJxXUK/zfsCn9z49iIjm/Pe7wrmKCj0OUD
	/4C26oBJaRAI3zNoBDu19fIXoIs0kCLkknY78gvVYEqeUrYVi9euWnzpX3jediDK
	OG8ND2syeyIqPiOr/4m5DM87BRfh/GVIm6z9onna0Rvp2/k28NGJN2wzfWutVpHa
	MCnpam02zbvbpafh1YdW2WPCr5JziT+G8hQDghl84PDM8ahIr7Jg7BeqxH7EQcYN
	mHsrUGo0V5QCsWuEWuHYH8ji2I1ixA0q2aA==
X-ME-Sender: <xms:Em5RaHzTnJE1peI9l_RdZ0ScLLr4JPlOuwXfUyioOda-6GpnIh0fPw>
    <xme:Em5RaPSPDaww2B92BAP9RiJWVCYoIP22rR4F_uc-DHhwyo-RGc8-MXx5JlebAdH96
    h-O5rhzBo-Rr0ucjA>
X-ME-Received: <xmr:Em5RaBXba7VC5RLtxsj5zHCQEV7JOG1vR7NncZULGBCxT7pysRk032jrOry6SC4bBBFwCqEv5uQv3FjNzc7gHU6H6Urdun7BP5HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvg
    hllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:Em5RaBiSAJglajzYOXezXI_sppXrijoBSu7yX4SXnr3esKVi1BdDqw>
    <xmx:Em5RaJCI4_VbKn9P4XeaXY3OcYXfRVFq0DlD1Gnv6VHMqKtRMT4yBA>
    <xmx:Em5RaKIhOWRr28zE7Gmkht-1ncnDAgYatl6hwVu8PW_rCkmFH7Sclw>
    <xmx:Em5RaIBvgPCcaJ79uTZ0X3y5wt60-_RFYbHDO-2SWtsZsN1e4nuQgA>
    <xmx:Em5RaJcZmhrR3vuse52jzjmqFH_aRE8npbG7ouofWs-Htnq8psFVxSz7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 09:30:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/6] submodule--helper: improve logic for fallback
 remote name
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
	(Jacob Keller's message of "Tue, 10 Jun 2025 17:52:18 -0700")
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
	<20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
Date: Tue, 17 Jun 2025 06:30:56 -0700
Message-ID: <xmqqecvixzov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/remote.h b/remote.h
> index 7e4943ae3a70ecefa3332d211084762ca30b59b6..ef0de4aa64e9ccd32cc2eea076c00386dcba1161 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -338,6 +338,8 @@ const char *remote_for_branch(struct branch *branch, int *explicit);
>  const char *pushremote_for_branch(struct branch *branch, int *explicit);
>  char *remote_ref_for_branch(struct branch *branch, int for_push);
>  
> +const char *repo_default_remote(struct repository *repo);
> +

This breaks "make hdr-check" because nobody up to this point
mentions "struct repository".

It seems doing an opaque forward declaration is in vogue at least in
this file?

 remote.h | 1 +
 1 file changed, 1 insertion(+)

diff --git c/remote.h w/remote.h
index ef0de4aa64..86020ae2d3 100644
--- c/remote.h
+++ w/remote.h
@@ -9,6 +9,7 @@
 
 struct option;
 struct transport_ls_refs_options;
+struct repository;
 
 /**
  * The API gives access to the configuration related to remotes. It handles
