Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D88448D02
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513030; cv=none; b=bSsOfqXtsr1Gpz2kfM3skTVAEb9XZc+LxSYIET3dTRbyytQWVko+ZHFHNO0G9gRoQLgwNov/5tM7K8j8U6dF4RR2JUeJ92Vgy9pFaV4BTbr9fH3xANGPwry5yWKklO0QebGE4yZjzhAmjB7gzTCq2YrWOSRZBnZ34/NOUkR9i4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513030; c=relaxed/simple;
	bh=khg4ccgDqmLErcidie9UIdY4USG8q6VqgMCArsED5vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1T16hGzI38DWCRfigMDkCWkgK+f+RsCahNqmt/zlKosjozUlq+3ajNzXxV4gLNaeXsJrgpFIhXZ83kVBrc5W8bDQoSiv5i1DiEMDpezR3MHdb4to2JeYN36GOtmG1InkJ71uhlSYQMvZEkYrcUJeBxtLSKDbJiIJjGPqxTKztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZnzBnSes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4/+pG1v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZnzBnSes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4/+pG1v"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FDD3EC009C;
	Fri, 31 Jul 2026 11:50:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 31 Jul 2026 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785513028; x=1785599428; bh=KpquISPcOf
	V0GbCTdNEPfkzo8lCnp3WLaGhop1XUNGw=; b=ZnzBnSesxacYhL08RT6QRG/jXq
	NvghUjGjtmKqP5bpwO7yCL/giQb6E6qEQUvXlARBkdnHfZqAEMn6JUPe8O8qiXNe
	GapPmupE9btLogn+b10jfKUxLGABCmY8Aw1oF+M29i4/tWZaOcvUihkmTshxvZES
	ybXc0tN9stsiqprxVUlsoIHm4vkrf2s84nC0jl6ADion9SW3kR8ErqoOrwSeWFs1
	1rNa0xi3NbxupurnQbqXS0BkhhdWjxzEM9ub4vRgbE/GRIOBaBawrnpiMojtCBHa
	HppwMzkz79TXFOmkuLDTuPBD0eoq3K0LTfKygDfWuBkxMYQmeV4A2fIU+Tyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785513028; x=1785599428; bh=KpquISPcOfV0GbCTdNEPfkzo8lCnp3WLaGh
	op1XUNGw=; b=d4/+pG1vjJ6a9P6G4A4sXtILhtAeQh7V65GzCzI9dAhzoNv6dLE
	oTYhUyfmZZn1qU3QO53NWiFU4+7j18PxYm2sggIWYO6BpID9BVYNEF9vzj8yPS8f
	VfCsJhCOdWI7B8AbW53XlZDBFV3VowlN3rv/LPTKtBY3v7BqHnN65kzoQTlXQO1U
	J0a2tU3AItnFAVOOph0X7swRtoHI8DM5KDsgiQswdHJnWJDoWGuyZz959o91eIB/
	l4fMzc4Zeoi0noOd0ohyp0gGGDYvwkABWqLtm9CjTNqyeaoafHUBfnNns4lgRUa6
	G5m3ZQFDFGNy67Rsjk1kWEp80xl8n82J5IA==
X-ME-Sender: <xms:RMRsanFoVTVa9c_fqVF-3q2UBf9aeWU3GPFrvqrJsoA5_4Y7gam60Q>
    <xme:RMRsarz1MGnpEsQ4ZhVWWmcK_CEcvB5fCmUDdW0Red2DohUB-uYMtq6scqz3CN2VF
    Tp3k8_Ga3FFl0UmFJsd8yovu0upwU7g8lASc8MPl3pf9nl__HeuRw>
X-ME-Received: <xmr:RMRsamiRbYzcsoB_HDIXr-CXjBI-E0qSrCMiZANC5aqxTkp523XgmSPGSxxBkD5oj2nwG8DtTDiomSw36_FRxbQQ2ghDSBl_Cw>
X-ME-Proxy-Cause: dmFkZTFVYrs9BL6Tk7RN3Z68K2v7rYrpg4OWNhzOUrfQwJXI/xz9Tln7OVe8aWV1UbXEAF
    YJWoxywFwpyud9I9ttdGZ9i85lyo5neqdCN4Niwd0uZUKiejzUeMXGZSslJgBUzS73pZW6
    3h6omxrn9TivSi9Mmm3tiB7BLgQ8tXVEaVGV0rkflfbMQCg7wtCX4YV6xmNO9HJQ6aGsLb
    2roHzRulA6r9AnG8aWZXuklmIDlqh6hYGv8Z8RlS3itYMLx5mYGFNCEwKp8JqYXHWJBeMJ
    aVPoP3Zg7UoPeXNkNfYQ66KN0YmBPEpfec46r1wg4pZ7yj0NTvCLU1t1uXNrGUr7I/lfOW
    xMyU/nDLU/JeBR/iJTyPTXqCJXl5I1X4TrRRk/fvbbmq5PfG9HrClT8ft+KXN+nNJoIrMa
    mTOBg9f/oVUP53nrUCAM0IXV43+xa8s14VUVYAvXYCeIu+WlT6s74SCVl70paZno+D18oC
    L2bk1l1kjeDmMfIVGrt8QOOO1VnFgIlpgsIbBDtFJaaD3xl3vVO/5kd/iZaFgJlBeU7jlD
    RL/fHDkVRxB8rZ/TXFTrE0IZNx2Iqk0geMOqhBQA4bHfbwcCkVDCGL1c/LM+E2XtDNDDMQ
    xLpwcFnLWwI8nSCoZKqgVn48TNZR6jpplyGta0+B2t5Q31wwyoC+394LGBPw
X-ME-Proxy: <xmx:RMRsauzc9F_fyQiHZMCLvG3c1Yc2_CRfGT5Av4BVxho6YnDIesBq5w>
    <xmx:RMRsahKUr5UTBtx_qQZg4U_bUkPicA66qjkgnu6sQYcG3sfVnI8y7w>
    <xmx:RMRsatS486ElJ7WWbGn3lH_PVdVg_gCllqHwSIXCtW2weMsc4Cy81w>
    <xmx:RMRsaho0F5bF4BWWYZlSU2lspq-aY0xjdSirdT5S9Ftu0pIYf0RRZw>
    <xmx:RMRsatZcGUHOohQGVUYGPyImhxNY4pC6sqyoUdqzriJfAQ0Okj3HHlYH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:50:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Nemeth <tnemeth@free.fr>
Cc: git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
In-Reply-To: <6022080.DvuYhMxLoT@cixi> (Thomas Nemeth's message of "Fri, 31
	Jul 2026 12:19:09 +0200")
References: <6022080.DvuYhMxLoT@cixi>
Date: Fri, 31 Jul 2026 08:50:26 -0700
Message-ID: <xmqqy0ercg59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Nemeth <tnemeth@free.fr> writes:

>     Hi !
>
>     I have the habit to keep 1 blank line at the end of my files. To me,
>     it eases the EOF modifications (selecting code blocks, pasting them)
>     in vim.
>
>     Note that I still want to remove blanks at EOL. But I'd like to keep
>     1 blank trailing line. I still can, of course, but the diff still
>     shows me a red "+"...
>
>     Would it be possible to have a configuration option to avoid warnings
>     (because I see that as a warning) about trailing blank lines ?
>
>     Thanks
>
> Thomas.

Would it be possible with the current system?  No.

Would it be possible to add such a new feature?  If designed well,
perhaps.

Things to consider (though not exhaustive) include:

 - What mechanism should this modify?

 - What should the new option be called?

 - Do we only need to accommodate those who want one trailing blank
   line?  What about those who want two?  Three?

Thanks.
