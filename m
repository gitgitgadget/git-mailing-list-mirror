Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC91B21B9
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931379; cv=none; b=pBOui8tRLgDEgOTsue+aX4s74IDeOwKMhTmYUlvNqlwGCQIyKuK23acAHrCCV0umbYpbNUJMuP2ewsvOkA+kUbu2P3igK1NbvUQx7t3MJNUCPRVPF6tVPDLtDy/edQ4ote1Y4bAP0xoEhshsK4KuHA7zi0h0rkU5Hy9Ecuu68wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931379; c=relaxed/simple;
	bh=hfjUY0NBQ/Iv2Ozq0n58AQ/XeaPS1ctqypIPFhMcbG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpHKt/Pwnnlkz4qZG07GuEfb7nAYJbfTZYZhBOc0bBCrpKh/mTVjaFdyUG8B6u1eo0JpE65ZuE+aYXBRC+EUwNFsY+QaH2oh1+ZfvJfBCWbG96LZprMy94Bd+3ZQBXfkYXyFd1xlY/qsjZMvihAbqso5uG7L1cwu9e4D39YjByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l19kVLCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ep62sWqg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l19kVLCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ep62sWqg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B52B1140168;
	Fri,  3 Jan 2025 14:09:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 14:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735931376; x=1736017776; bh=d1eG3DBGuJ
	RxCqt0HdXXJHZ/965zzAl5bXX8Kfd4ACA=; b=l19kVLCpG2qObSdFtGLYRhlD5Y
	/H/cv/6IMp/t+4X+WapqxAuD/eIFUsJ6IL+P29kVIqwrGo/z10k8ylPWRSCiPWGN
	9zj30FpUyB8inXrPTIYkuypmGUMS7IdeRHVXyt8gIpvKNMKe78ZlvUd4CRDNZQ5d
	Y4rhAFJZJESyOjOwrcg4Y+zqaHBNGJPNnZ5WFM0opN3yWzRTT5toWrmH936y96Ut
	1zLNAe2Ya45tIoU+/hX3r5JwJY9rj2Q6WEithM8eqSDCcbUHRmg30iICZJuW0RwW
	Hmk/hXZEcQKDYPpXQxk/x4XoLSBOuKWRzu4imu6ir2nCvk05mYMwzsOnVMDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735931376; x=1736017776; bh=d1eG3DBGuJRxCqt0HdXXJHZ/965zzAl5bXX
	8Kfd4ACA=; b=Ep62sWqgSKBxi0BOSOyhpEScVWgI+mZ64bfrHtK1sxaVxhEUFH1
	5IWFSnFykqkd+WtkoNrZe7TrdFZDghFMSh/aCPpz7n7g4Py5jwhYqLW2fCnrDTuZ
	UVUfdNgWLj1X6t86XcIiwOetixHsfxQ0WVXCtl1RLj0Cmtjm6Xd0qewems83p6ig
	aa+Lov7JA21k4JWck8MNwuKTisBh5f9lxBR3SkGugHeZ4w9Ihqe2+YdlHKqBob0N
	ihd5c27tbcBl68MxJW66lc9YHzjq/+/Wo0yP+H3Gq93AjcWZyN3Rhh0PaiEJJkww
	pWHFtGb3NeuvoBLGYxf+Q82BiJ2yNRtZAQw==
X-ME-Sender: <xms:7zV4Z_gTskmPBvUw-1NQD_hIKtSHNlShU1PNW4gS0l_x_h42_ki-9g>
    <xme:7zV4Z8BsWR_7GJ5y1XT8hd5ZTOXrHsumDiNvNyvN6C-19ki1atW0H8SeWI096XSPp
    N3tv_OfNTj8_xts5A>
X-ME-Received: <xmr:7zV4Z_ElKGk8ntWkvHDSgv3RfOPeGad8iVJYu3VCToIkV4214psb3Eyca5SzV4fwPUihDZePTqVNFPMnyiAt3kAiS_sImwufKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7zV4Z8QZPhXBSm88lwrGYnBzjiXOHL39_eyC5MLzjuXYxt4OgCUWmQ>
    <xmx:7zV4Z8zUissuwLN0TOMgsBsw7a_HoS2CATr5NsF3yTK7y8tb2nQlZw>
    <xmx:7zV4Zy5_QvqV1CNys8CN8yJPPOxcel2sPz02WsfARXF69HwyIRX95Q>
    <xmx:7zV4ZxwMmeGZOCdZOQwqWJ2dxCnfZ8G5JG-9IfoNz74pnFAemPAkiA>
    <xmx:8DV4Z49c3mjN8m5A90wur7joYJdsejuA8D7XXRKe3t8Rs9aKJm_8d9Cq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 14:09:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/10] github: simplify computation of the job's distro
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-5-a9bb95dff833@pks.im> (Patrick
	Steinhardt's message of "Fri, 03 Jan 2025 15:46:42 +0100")
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
	<20250103-b4-pks-ci-fixes-v1-5-a9bb95dff833@pks.im>
Date: Fri, 03 Jan 2025 11:09:34 -0800
Message-ID: <xmqq7c7br9xt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We explicitly list the distro of Linux-based jobs, but it is equivalent
> to the name of the image in almost all cases, except that colons are
> replaced with dashes. Drop the redundant information and massage it in
> our CI scripts, which is equivalent to how we do it in GitLab CI.
>
> There are a couple of exceptions:
>
>   - The "linux32" job, w whose distro name is different than the image
>     name. This is handled by adapting all sites to use the new name.

"w whose"???
