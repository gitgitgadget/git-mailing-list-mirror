Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D781732
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299447; cv=none; b=ArwvtV51sJ16qusJ+DZY4syRhMB1+7wNT5alt0BeoeYGJe4ZAfno49V0bxSxSaYGhlFe6MJFh9qQliCbKkGu6V1mJD29wioVV9jyG64FC0FdgDgkDuruwWgZ3vRzdDOFeTPSTle/r+xNtxBXHtyJ9xvnvNwkm6+cfqVO5N8omG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299447; c=relaxed/simple;
	bh=EUWF+RC7sXFr9OHuHRo+3rJ+Azvxfm8olvJ49sCwqbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jq5e7InfFugEkY65A6YB+iqGFGjaz8DxNTz/vbR3zDcKXb7dfJSo5BOc1gPUiIkY2SCjaUFS0Q78M7rT6s4HA3LmJo5tLcTWGMrgNjIGwrcHPyywJ2Rp6uQK09kTW85iwh/qnaOvSe5lXDzUk2TsyAXB6YcX9C0OspV2XN4dXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uNMcwe63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DD0WfJNx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uNMcwe63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DD0WfJNx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0269140004C;
	Sun,  9 Aug 2026 14:17:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 09 Aug 2026 14:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786299444; x=1786385844; bh=ePKkzJzNCI
	IFlU+d3S3pI+Z/lttX++Qj36KUsyy/XCw=; b=uNMcwe63lbVVKAXzGwFAKK0l/g
	RXvdj4n/HX7TfopTh1EorIWqRDMEvCYwBdYu31Nsijil5EmCfGh5+gcBvO4etz47
	OOzsCluQzuM8PHHMEwo1aOtH5a++u7oJvwrmzUVJXVTBwSzy2+PyPPYM1W4BsPBa
	KU6RxrxU0B9D05hqItpC5/jGLjZ9SZi7p+8JzOTK/eufO1uipNwmtGSRU1s6vtY3
	6gT96LCJaBGEkxn24GNfH4JqzJuA4BK6621A3MSPF3Ui9zq4RDgJoolGt+jl9MRl
	LWnFD0F+Kyaym2S/WEeCb/+P0staeE/tz1F9dGybB1o5LBLf3y+59LMCYLEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786299444; x=1786385844; bh=ePKkzJzNCIIFlU+d3S3pI+Z/lttX++Qj36K
	Usyy/XCw=; b=DD0WfJNxj1tu3BheQ5qmLh/dVc9NZlJB7KRMoIrI5Q8SPHlhRdm
	lOCakMQpzhfpODcbaQTOYJd6UhDLJnblXBp2nDUu8Bb81Qe1M9ipAIL0q4i/qx07
	KdIiiuI7Dedoh+5aF2FHfBNXasXlSHgdR73pJDh+o5oPVId2Ed8yiGvWORx5DeSj
	+ePW/xzhpyziTBdJeSrBJcOyVbD5c2nFhYGhcE3APOcNR4VMXaN3aaRzZrJfvipj
	auXq6L4SLh4d+rLR1We2WpWlMFxyGuFTQFhVf0ZuKeHKETu4eM0bC2bBHYaAgnaf
	HcDG/R2gLDWw7XDJ8bHwVlgHWIC7I4pp9EQ==
X-ME-Sender: <xms:NMR4ahwRxwoeN0Iv42DJb8eAHJRqmbn2vl8u43NHzeR_4oguONBPNw>
    <xme:NMR4aoQxIOHSVGFZYpCmxug9sl1lOOEq826dNBr5jM3eN9qxC2UJaQG7XF3Vll8_a
    135c2jZ0mhd9zC1CeOF1Z5xjb-6Cut8awmX-pCCvRF9HhAnyp0HDQ>
X-ME-Received: <xmr:NMR4agW7y1JvzXKe9fmudsmJY3E95n9yGgj2KXsao6-odBfcmLR3eSotHV2zj8eyYTMOXxqYzdpmXUGIOwSTaOBPy8bPtv8Nog>
X-ME-Proxy-Cause: dmFkZTGs9e5LmlEJIHb3ML/UN5VqG55C5oCgT1Da6Jp8eRSYLkV46bgDwqCwLkhsn6gnMV
    SMFBDppUy33aOGwM1NAkk0eLe2dikQ8L13AIk9STqhV3hvHvXeV45AjdV1qM8ZcOVCisSj
    8syd2FyEKfwnx1MoHD0mk8wQmcZCbLJGE0ME0aBg8BZmO54Mkb0TxXLdudG3aGoX3dKD8W
    Ul/zVHRw6CCyf7B+3b07tHqdH73xdW3Jc4KzjHVxnaRG4e3ItikzLnXas6zlauJtaTX+Qd
    Rov8cV9ZGPZFeCX6+RoQgEQK/70pEI0xIve8O0LJud0LFIBrusRnjLyr6+UPw7UlmRznVS
    67Ypf4b7mhxg+8q+OvrzbNBSqyZovUm6DKTfzq7IZVlYai6cbruawstDPjVkzYDAuvVp03
    zjCii/mp+ipFqF1uXqlSbNUHCX0rL/1oytUs7C0nqksJsQ5CSv6FRFD1rNoWTTbuk+OJxm
    PHPPPJMmcUBiksmlG3tKj9xoe9Btae2YJNTlC4pjOpLN2txYIa5qSM/tqIxmE4LDIhJiJj
    V2d3HrBplH9UIQ/s5dd0k516W6AvWfP60bbj2a9/Jl/4J8sKjmc1aO0UCntUzkoN4YEudX
    24tuoRmelLDF57NxDFOFa5v+B4u3McNozEd1fGA0F1XwPsUyUuBVIT40E9eg
X-ME-Proxy: <xmx:NMR4aiYtgeKq5unhZojqaVLpALAgTfFyYQWoTcXQlrtVAKMc6AvLFA>
    <xmx:NMR4au2S2b-Ip85Vb1RsvHDwoWgU2kqQBcv2nrvjo7n73KB28iMgxA>
    <xmx:NMR4asjKtnDWvXKIv_gc2OXZwqxe4OSLPbxrHOC1ZmfaZbbvWkGKKA>
    <xmx:NMR4aqYaTyA6kGF8FUHqpYp_tlVX0cckcOdJsK1zrHzk-vCC7TOaIA>
    <xmx:NMR4an35HzNHASU27qs36Tx5FosXdvizK2Mua93-g_Riq3D1A5defZ8W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 14:17:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <xmqqo6fc9swz.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	08 Aug 2026 14:57:48 -0700")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<xmqqzeywa6ol.fsf@gitster.g> <xmqqo6fc9swz.fsf@gitster.g>
Date: Sun, 09 Aug 2026 11:17:23 -0700
Message-ID: <xmqqjypz9n0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +static const char message_advice_ambiguous_remote_tracking_branch[] =
>>> +	N_("If you meant to create a worktree from a remote tracking branch on,\n"
>>> +	   "e.g. 'origin', you can do so by fully qualifying the name:\n"
>>> +	   "\n"
>>> +	   "    git worktree add <path> origin/<name>\n"
>>> +	   "\n"
>>> ...
>>> +		char *remote = unique_tracking_name(*new_branch, &oid, &num_matches);
>>> +		if (!opts->quiet && !remote && num_matches > 1) {
>>> +			if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
>>> +				advise(_(message_advice_ambiguous_remote_tracking_branch));
>>> +			warning(_("'%s' matched multiple (%d) remote tracking branches\n"), branchname, num_matches);
>>> +		}

Sorry for piecemeal reviews, but I just noticed that you have a
terminating LF at the end of a single-liner warning message.  As
die/error/warning ffamily of helpers give the terminating newline
themselves, you must not.  Unless you want to leave a blank line
after your message, that is.

Thanks.

