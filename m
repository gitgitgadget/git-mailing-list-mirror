Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA03E172E
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409307; cv=none; b=qd1HZwBcTJ2GoobGGmGy2ftDTdsg58S/D4kbFuClgxJtWDrQGkmU9M9iBPakbpMkfMIPdK1UrmDbKRupTxz+jKrTitfGTifZaqXqLtg85LUE70vyUEfrsnrzre5kWyjoGdLtaLWbGuMUiwq+VRitFYcUqB78gTwNSSgfS8lemlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409307; c=relaxed/simple;
	bh=DTBsV05jvMQ+JSswLXXTVZRji9fMSyVSn2FK84E/d7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nN4HZHMzwcW0fBVjQHqzSZcJ7p4XIHw3C+JeO6PZ1UXb6pFoPfKas8nZW0XuN1+QSKsJjSFfUyhTi4bG4+NceK9ldr3CNRhr8RpfX9RFyD3a2ZUg9Cyuzt2iz1T+phtrP7aGykwwd26Mqxu61a0SirRPFKRGyVno/8qqyFZLU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=foELp8Sd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LLy1x+px; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="foELp8Sd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LLy1x+px"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17AFE7A00C4;
	Tue,  2 Jun 2026 10:08:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 10:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780409303; x=1780495703; bh=WWwOr5FG23
	RnApm8hFyNV+XQAW8XL8LeBO7DmpbSD1U=; b=foELp8Sdvq6YT+O3vcInz51ajW
	n8KwfLab1N6zdn9tQcJyeEfGERaNzhK6ituoA7Zn3wl7LqZlyIPEkv2Q5AcORHzo
	BepH+Hcg2TtIe9is8yjF0VV7NO4sZYloWPbHqw+TACifKIqDAmoTQl1JkLRRLWVS
	Lezc9yl75Xo9JNr5IKnYEV6XaOnciGw6z1U66oM9te2UYe+yCz3tKLMwzNHO3Hdz
	DqjRWbO+fVo3rGyvVhXdXopThhERnOkgy6zJ8a+QxUdMuIs1RdMFJp3L7He2YrQ3
	6grvXLGOOdUxSGJWuEOqjrCheNuTlwyxXAd/RMC7OUYFrMhAS9nxmRhtkiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780409303; x=1780495703; bh=WWwOr5FG23RnApm8hFyNV+XQAW8XL8LeBO7
	DmpbSD1U=; b=LLy1x+pxMnRRk5oSOyVEkA1BKk74R/jsEzzaxmrQ5HNUjoUMCGy
	+0EHqiLozogy/DHDsDyghzDQsWuuxDcdgIAKav0h+lsWgzwt85K4B12LmOxDlb21
	czWTmlti7DXMBxh4t3PLPga9Z1xAZmAFLcKMzAPCAK/y4Oa6omAjoN57MndczrWg
	kBDtmvZeLI9NsOFCZDrA8qr8VCPCU4y+/mU5JfJLU/hu9VmyYPAGIJUbRQRcQZh9
	b4dQiHhpOlbccD1HcsfuTraEI1bGdOBG/YuB8a3kls2hl7tV5IbU5AS8Su0BsG6t
	A1hLX1Ni4qnj7qrn3lfn2yxD7FVSWObpKVA==
X-ME-Sender: <xms:1-MeasO-JuhD290v9gWIRJ51QvYGZQPPexyjyLzqRBkxgx5oNRqZXg>
    <xme:1-Meap1R07gE9WQBVsstMpjW5XCQsrsAdpJWm4fMOhdNP6w-n7DmYapuDGN7lpxcJ
    4Jz5IJwsG7eyVMUcHSMK3HViuCmzdbYowpdx7Z0-tGg2548eZuo4dE>
X-ME-Received: <xmr:1-MearlgG5M7voajSwjhZBhldWii-W6JQ6a0len26VBLZkpx8DfGJoeHKI7e2DfWTXKmJq4Hm5PT6tyJqNNpqnnGVpOEk0ZL5sZN>
X-ME-Proxy-Cause: dmFkZTFTF63MTYuvjv0BkVnfnukI0Pr5maYWN8l9+IyHf/rLR2CjwHuvbB/nNP2cQtcSM4
    oJg+73aGQkxDgmIY5QzbX2t6X2ypU8ZNwlE5+IREybXlsMJ9MAUgXF0JBGJqyikyeW6fCS
    zj3mF5wDKM6650QpItCMOWuwrj3wwF46QucFlQEolwL0XMOqWmB/8+K4FVkN51uDN/UXTm
    1nEIhTOGxsF7941dTq2pJCmsFCoDFnTkGPq9/X91CwkARJkbaxh+ikwvuGmVnNUYjjacAv
    gOvHWVAi7AVR1LAGVhV9Tb9c+jZjmVURE2CP+U3w6ANrRxaMgHrqKCqvewZ8IP+JHNNsBk
    JCaA1seIdypjnYeq/NrpMN9PAtI0NK1gfWisfdXPB5yqkI2cRApcpIvvqmfPk1oI+XQ/h7
    XQGE5dmVUw1MUXsQJTR2iRLCYzv9yBAY4wb9eVz7hReuQ9seCMfMiTDtyh1Wk+OfZEgFWF
    yzxa69UbibcYhvdZf0ioWxK54vv6RWJFspCczliXL/6rEw73TADkhWEHJcshQs0BebUzUA
    CvpK/7C1bJ2e4j+pk0bCaVynkSpXl9LG2I5KZiIaUfuvKBS0BJsxFsiBodg/UL5/iJjCiV
    Xu8Cbg489J6mqhYZNgTFr036i+UGW+++1KUnw7CDPgWy3mw6BzE9ZQy9HaSA
X-ME-Proxy: <xmx:1-MeagWPu1nZFadlgYD2BNH8MJ14i_YrzXfFy8cbPHliFs_j_kjjsA>
    <xmx:1-MeahsgDBsNgrp8agaIwqk72jlcaMtUJg0KsPPxba6atGruWV4URg>
    <xmx:1-MeajZH4m-FFfrRXry26WOsl2f62aiFgCEbtkpXV5j0Y3qgYcAPpw>
    <xmx:1-MeagUeVL8h6xLLrQdaX4wZ14qoFN8H5U9aBcAaDJ_i6sFC4wUjOQ>
    <xmx:1-MeankJHGGbQcHWVqUOvRSCivbO5wOSNOpd7cc-kDOKdbIk5hon98Y8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 1/2] config: let git_config_parse_key() validate quietly
In-Reply-To: <d938ebf95a817c00a415670c08b839747d711d29.1780407557.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 02 Jun 2026
	13:39:16 +0000")
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	<pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<d938ebf95a817c00a415670c08b839747d711d29.1780407557.git.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 23:08:22 +0900
Message-ID: <xmqqtsrlujah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a "quiet" parameter that suppresses the error() calls, and let
> store_key be NULL to skip the canonical-copy allocation.  Existing
> callers pass 0 for quiet.

Hmph.

The way this patch did this may have been easier to implement, but
is a bit different from what I had in mind when I suggested to
"refactor" the existing logic.

Perhaps the updated "git_config_parse_key()" in this patch should be
renamed to be a file-scape static internal helper, and the existing
"git_config_parse_key()" should become a thin wrapper around that
new helper function, retaining the current external interface,
requiring no changes to existing callers.

Then in the next step, config.[ch] can add a new entry point that
serves the purpose of is_valid_key() in the previous iteration,
perhaps call it is_valid_git_config_key() or something like that
(Patrick or others may want to suggest a better word order in its
name).  That way, we do not have to sprinkle many calls into
this (rather ugly) version of git_config_parse_key() with overly
wide interface that repeats meaningless NULL/0/1 parameters that no
callers want to use (other than for the purpose of differenciating
the real git_config_parse_key() calls from the new calls made to the
same function to ask "is this a valid key or not, yes/no?".

Thanks.
