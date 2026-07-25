Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C61FBC8E
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992395; cv=none; b=sA9pwbX5NbJNbeNcvxTXeoB+jZfhzhxsf3n9VkVsFIcxP2tnD6PP6KloMHJuPwRQ/vQcRf92HdVT30nwH1D623PiN+kaJ2W/0cypXY2JcBSZX12bvnQrbzJOhPwHwGAtCTHIipYUZUcb/UDvGO0IhawaDzyNEkmZeWZvihG2UF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992395; c=relaxed/simple;
	bh=r0Ai2WX62nAHLEKBw8KAH5iICD+Ip2YboybWC843jfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RVUMp3nAK3rOVjK2/W1etyrkXHKgVGlcF/D+diyleMpv+VH2TCvM6uKJBnkLZsLNDlgtDS7LVNFVZEgBlpFxioeu0oHn1scHf82mjQwYiD2GTu7wkZFrh38rL/npQNVUyO8TNJS21vBDaLf+7KvCnApu31kjEXQuXMiSyKfNyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LM8gol7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aa84xb4v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LM8gol7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aa84xb4v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 136E5EC00CE;
	Sat, 25 Jul 2026 11:13:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 25 Jul 2026 11:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784992392; x=1785078792; bh=oFpKFHN/eR
	udZlcUTk9TI9jTFEoqb61tPIYm6OIg4Dw=; b=LM8gol7jj1dDKUpExGzmUVsO2+
	i81ILMN78oIKjhGvJhtAdTtaCOQ3sJmMpwFjFhIQRkCAdAmKqUIcSbqVuZPQvqrS
	hhG6msuNg/yCFfOQBBkklhc/y5pmd0k2vzmOfesCPdeuyWTd4pfiGQwZYZTnOVof
	YV++ZYIs4MP2KtnDD66rDNWcZoKPHVAo/i7cp3URm1XnipbdR4VknXDGYPFJiFA0
	vcAqMMUhNWrRCqFlP0Kh7ljTYFeVmIJG+fi97nUu072eovro3w1yYEzpjnDcsilW
	fI0qKPBgpo3wT9hiuC3Bc4Opr/KaZRJrV/RGH7Kj08Joc22Y+7SXy/cwtacw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784992392; x=1785078792; bh=oFpKFHN/eRudZlcUTk9TI9jTFEoqb61tPIY
	m6OIg4Dw=; b=aa84xb4vO0PsnkeRshilal+OsfiIMVuVwAZx1MyYVUoYCLrU37N
	LVVwtwQUVsT3eWGIReaoTMNomMPdS2sRNxdkHHA077N1qNEZBrcRhIr8TW+Smn40
	ROhZ8XVAHRJZ6fsLyVF1Y3JSQwkdtMFycCIzxs7T68gxCnJBmAp+hBFBqbyvp272
	64jXXa3cBVjjo/6wBlYeEo6cjxookV+diwSgD42N1Db3kLWP/7pqoN/cT+u1P/F9
	917qQ/R4O8eM7CIeomNO23vXRCIEv7U0LsBP0/xOwqOVYmLLWu/RtHc+4doCfoY5
	A3f4K/mUX60SvIADgQFeq/16G+GV3NjNXXQ==
X-ME-Sender: <xms:h9Jkao1sTVyV5IdVLeO6x2wR2PLbWOwDDUH_nwvQBK6ZF0N94JEiyg>
    <xme:h9JkalXqRzOfN9xvHpIiZvpIRZRUD1SsMwvrgBFv33vh4S7FVV8gzBxSqKNQk-dTW
    MYEnKnkkz9HvJ9b9jU_Edg1x_ll9OOYWksqc9IeUHwkwqXUXP82wQ>
X-ME-Received: <xmr:h9JkajIAxxk7ctXKa0WnsA-5KumRlV2GfScY2UvvUJRP7vCXaYKcBZNwTZPc_jl5Utt6OWZV0dSY_jrT2vIPHvqfGzUUIFGyTw>
X-ME-Proxy-Cause: dmFkZTEUNt0j9oXKYys4jWS36F02oC+ttVd/psFpWhUur7N1proFV1CbYqFp9omSF3qVs0
    ZCeM053VOGlleC/0yuA2KvhtBzFAYbzmP5dB7e48MqbNIsNydyc7wFQ5OFgQ3XJlpmm+vo
    +5Qf4m4Tvx/9Rj9M8lPOj7RHbHJGEkhgimaW0RSkL5WoBpsbuvrQxrfnGvkOeM77iL780Q
    a5U0KxgBgdnUmvNkq+sD0izLSzBw5odWXf42MDzWXNxB6FiLzkqFwVBfWONQ8hufzb5Ygh
    Zunm7CyOb/MuntRTgOlK39cPBQ5L3PJS/bPqt62X0RBVOTxSs4FHZUkeR7bBeW0eBbUrml
    dgiZdy0BOb9u7ZoFnbksFGdnRydbiamb0Wa1mJnxeaGNrP+EaxFZkSBWI/PNpL+nQ+bBfX
    Q1Yu4GaLjKEfDjU+dZl+Oqb0KIbqlRlE//W8xfy4RE5RVYCdgEi4Wr4TR+DANXuWMXL5oc
    iD+X4EBo0zTvpbJtT5UbiTkjjQaa6Xsaw24OPVhaGptyG+DJFzjEdFp9Kw4ZDIijW53Jw7
    bkf4DJTnjfEHMYP/nS9MJGqbzhIzG6aV4bmSJcd9XEqNC7g0ngRprOutpkU9H23unigWx3
    MnOTd0F4r5QJMaWFRarw9mkFWMBWVcnkYUwQEiTJh53VdrazX+e10gU7C/yg
X-ME-Proxy: <xmx:h9Jkan1vr9zyoLfTr_16jPBJz0REAByLB6kR10j2N8kIvl_2081BMw>
    <xmx:h9Jkap6azQkcTfPlk8mVckMe_HF2QkHgVqImJJtgbndrUpbvIvqoGg>
    <xmx:h9Jkag8pasUa8PQQ00Ide7W-UYDCNUncnx5QspDk-d9BYMU7sBARKQ>
    <xmx:h9JkagVRxb6FzPkN3vLidDdopuFNnCC5nMupSO9-Rv8yxqYMRFQHGw>
    <xmx:iNJkahgghevyi7BQUIkyMTqaWyKhQbXk1YpU_JUVpvXuv1x9ATHH2KkN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 11:13:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v23 0/7] branch: delete-merged
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 25 Jul 2026 11:32:09
	+0000")
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 08:13:10 -0700
Message-ID: <xmqqy0ez14s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Delete branches that have already been merged on upstream.
>
> Changes in v23:
>
>  * Use a loop-local size_t iterator for --forked patterns.
>  * Simplify upstream-prefix stripping into an explicit fallback.

That was quick.  I have no more comments to add.

Thanks.
