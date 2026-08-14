Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171713BF66B
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717612; cv=none; b=YzyUM2/oBx350aHIa1V65GddCvbDfoGlYmfHNkm+mc1RaWwq3oLUjpCUABRPtMZZfKHvBeePyRF1lchcVBHyOanc1oVCyxOTyZmbIqTMa2blQe/WEIpC5oXnWoucwi499JO/8NdpX/nsYDcNPozM2Yh00S1nR/MOTjPr9/vXJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717612; c=relaxed/simple;
	bh=fETwkVmXdeIa4xkVC1/2nUGoKgyvtNkU1tDp1FHtPhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kv8p4H8d11WtmvsKa2k92fKhc28OENwAF85ewSlr7Ddo/4kbkn+5t9pmpdlUJd4twIZBCXH44064T2QhCUzk+IF0tuT7nGQa75KnKZKAfYih2EwK6zdYSsW2uJZn8Pg8AaS8Tln8+kZGhwlIMXcGkI+2ViuJcp/ovWM49Vgs05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U2HEjCvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNxSBRgT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U2HEjCvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNxSBRgT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 990141400013;
	Fri, 14 Aug 2026 10:26:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Aug 2026 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786717603; x=1786804003; bh=GJk6f/IHe0
	TWiwVq248ObtIzkUT7hNQ/XNDOdupRAbI=; b=U2HEjCvU9M7LZbc1nXIYrPuGae
	OV/ahOQOuIaoTePoMjCA7u6OOvl5WfrSV/MHt/u5a+4PMRghdlQSoBkVNBfY3SOc
	4mjPzVJnLsczyFvJoW/g5HwnAEgbQXUIgqEeQMJPB1VlVOnO5x+h4Eop1anaRDAW
	Q4dQsdkrkuRpqTVCcr37df0Zui3W/cNUkPTkEf5HEtMHKyEK/6XAe/32MSPk2ahS
	H+9qp4SoMG3cL0xSudSfPn1ME2CXjG5H17zaCPv2I3apfDJAw3AwGxi91Nsg1xA0
	fgNe6vWa1G0p2K09sJLDu5tpXyR1G148Rh9/LBQqPgcYqBHR8L4w7wr42uPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786717603; x=1786804003; bh=GJk6f/IHe0TWiwVq248ObtIzkUT7hNQ/XND
	OdupRAbI=; b=lNxSBRgTMbb0MGawqfRM8B5Ak7NI2nkYJfJ5nx9Webz9f9zlRKc
	I+5PMbK6B6QWhWCuWB66BjCfQ17GKvw1+pK5Zeo+PYuG8EsbshffchiYcNFHKLm5
	F3ZfDn4yERJybiR6OE1/dWVT/Sajx61KitxrG1Oq2TN6FZ8IzgiE2imi28Fz3li9
	Yhpb3+1oqnYa3JAgWkN6AEEY5QJ5w5sWnI7zHB1ufoJcXkaC2OT6gtnQT7d/tJfU
	EO/3jwyNe9fiUio5z3K/yqY4zBRoclFqMn2dIWL+rdy8e7KhJXlG+I2Plt+SXEgR
	Wipb41/4Mf7dMbJD+q0DBtxbBFKgFT/loeg==
X-ME-Sender: <xms:oyV_apBGPOwuEm7iJq2Y5Mg5WYaT82dnf33c1pOqMHiFzuKU1Me5Sg>
    <xme:oyV_augr_gyX3J1guiZVkJcubFurtWoZWK8KZzoaRCo4yA8NepGpfWvKjqYEzyOqW
    seK3ApNzD6_Fgs25DeV22wwow-i_Kz8vz6oQlezcAUVXkJ3uPlUn8Q>
X-ME-Received: <xmr:oyV_apkvdfsGsBMJo01UGo15ySRZwF1SsisRI-rAaPPpPMgN4OfBv5AswS6sMrEajL96yu93f5cER_uCdCO8ZGzsw5ZkJC797w>
X-ME-Proxy-Cause: dmFkZTEYz9oFOrUJWqIoCFBxF/YrJiHvJdCe56nkgcufBNZ7czH2MfXePhxcA7LxMmQl2d
    v8hMVgixx53Aii192gEON/+3fN+zZCqJpQL8sQvRRnUagpLXmFPe4Y4QS354C5Nihlc1Vp
    NXh5xpCrjO15AiJ4xXjJ7CHFuMiqU6XJK4n3WQ1aZkN80v4OwhIRHbIeCOSXc94mSJWyFq
    oskU3yJImZNL+MXdr4f1f1of5PQvakEpr3IAGPuv0QHB62gGYW+beMcuK9qle+k7lc7KjF
    aXB/2eeYgowX6nJWRttjajDi43zz3Ok15HA4ryvHVA8SB3NmAeDbXHzRaHcrNJumq7JqPN
    rtohV11k/qdNEPb80xmyPG+W06RbVQEsEBhKoUaUrZ39ThTNOVXlCkH+nP4yq6EM7WatMI
    PXKlROuxb2n7KQ+2V+tgdp6pt8HfqTu2d3bhdi5AVdZPFWCs/V+0pX9RWktl3n5RfLWNES
    sTEwupG5kBYjWcU1umYZwWXc3awmXakKh8JdqNjaE3rJWk6ahgsaUgdmoFywpMzyLyzbGd
    F3UQaQ3BYdpfx0fppiysLpbBPqrZwJbIpnePKQQsNcMITTpRFyNxDFt8M23OF7WOiWJodu
    qFFU+qNep/bBtgF8CY5tnCQQDDO+vt6j2PwSEMz+MAfC8TAbzLDKjxe1LgMw
X-ME-Proxy: <xmx:oyV_airI1MHAYS-jJ1iiv1YtcE2CbdY4Lbgi7hoeeprX_c_a1YYfLA>
    <xmx:oyV_aqEraFMVwuR1OIMX87P5E0BZ3tJLUOl4Y_diwAu_VU89vFYAYg>
    <xmx:oyV_amyHjz_xZq11OzZsREPYnjQ8VAAtT9hyDhL1PIv8rfOY48LhfA>
    <xmx:oyV_anrEQgs_3rMhTmwKFmNuHFLr_GnOT0_AUq2edaVjNsxXruvUPw>
    <xmx:oyV_ahFvXcnhWtU7mxQ5RMD4v5S7r4typKB7JqL6w2gso9yonAVPWx0H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 10:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] diff: avoid misleading statement about -l option
In-Reply-To: <pull.2035.v2.git.1786673186855.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Fri, 14 Aug 2026 02:06:26
	+0000")
References: <pull.2035.git.1786516958048.gitgitgadget@gmail.com>
	<pull.2035.v2.git.1786673186855.gitgitgadget@gmail.com>
Date: Fri, 14 Aug 2026 07:26:41 -0700
Message-ID: <xmqqbjb4rd5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index 589c1969e4..c593066592 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6186,7 +6186,7 @@ struct option *add_diff_options(const struct option *opts,
>  			       N_("continue listing the history of a file beyond renames"),
>  			       PARSE_OPT_NOARG, diff_opt_follow),
>  		OPT_INTEGER('l', NULL, &options->rename_limit,
> -			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
> +			    N_("limit to cheap rename/copy detection if the number of rename/copy targets exceeds this value")),

That is still a mouthful and it does not help that rename/copy
appears twice, but that trait is shared with the original, so let's
leave it outside the topic to improve it.  If somebody is inclined
to, he or she can do so later.

Will mark it for 'next'.  Thanks.

>  
>  		OPT_GROUP(N_("Diff algorithm options")),
>  		OPT_CALLBACK_F(0, "minimal", options, NULL,
>
> base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
