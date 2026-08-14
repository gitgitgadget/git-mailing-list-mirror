Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788547D95D
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718776; cv=none; b=YmDiCfyI/tY6oGIJFbTxs3fZ6GeTal0+s4h5V7fWOLXPGJe9wCf+xWGM5lOx7pvHvvae1YcmQ79p150Ytn4gDVEqFAjj3ODu2ZWRPZ9rM9k7f1H2TJSP9Ry6QjcH7Jxxk114uCvaraMJ8rlrdIcqejqzSnbGNypDllF9vO7cv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718776; c=relaxed/simple;
	bh=Sn4+bsjVWJdP/Rm+f3slWq2T8Oh8LbPa7k1csiduF6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVRpVJfAp5d5CPiPsnyYR27OHGO0o7bjhqFewnRbxTdjRqxVlm+RngeMB9yjo+l9YYqDfByb5EOYoXdKfP9Qj/UXlpaiCkyl57oS+kTS5Bi/+BPuJ9P5Y4UQnM0uncJfWHpt9vrl+0OEzTSZSQFTLYUACD01bmdIO+tKAt4ucNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ImnvG6hA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzsxGsRi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ImnvG6hA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzsxGsRi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A045CEC01FB;
	Fri, 14 Aug 2026 10:46:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Aug 2026 10:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786718773; x=1786805173; bh=4Ez9ho/pcM
	CMCbcqVqvmhHRH4rU15z2aTQTum6WmwB0=; b=ImnvG6hAfmDafnj5VVspn7opy0
	htoATaOzIEnkz1mvHf3KHmZN0i5yuHLJnEzzAb3V8YIGlXPTflNsSBdqccjPmpid
	QKnlbdWf2I437nHNkCHjhfToLhQgaDGJ4c9MjilYxBpa+JLwGppkWA+mvg/NcZIm
	IdbKuHQuM3YtZQUfq8Ia7R/9xEDfXQ4LN/dYbAmY7nz7yR6JWjrW4isDc0xKrWOe
	S2pAibsK+CHNuVCVx9Jp69uL2QcONPVr/lNhZ+fW15ezV5iqNIWyCf+s+oLx5ZQw
	1fxtGHtBf8oZGA5MQUgR4HdxViJn248OnUGn6eymUDoZTl82SHUVzcr1PthQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786718773; x=1786805173; bh=4Ez9ho/pcMCMCbcqVqvmhHRH4rU15z2aTQT
	um6WmwB0=; b=MzsxGsRiWInOkYQZV2mEgyrYhEh8Ft/+BbcuuPW3CKakT6iLpKL
	XAZRMuks7UDY6VqSHikWc9PZL5Sg0E1GqUQviBos4HwYqmB892SSP8FaxWFtsZzC
	anHFWmAPT7drP2CW/mtlr2sUo1VTCjlWVLoNjpBhP1hP2WS3gQxcmOKxp/KZ2JZ/
	dmFaZn8k2IBC6PqdBJG6fmnhJ0Gmwmk4dr3SFsd+rhOpf48iF3rX1A8yks5r1teW
	qciBKJ2s/NlB59nwZuSRBnnfhgQztRn/aVQGpVyGBfiRyNFjPWo3PoS5tQlkTUPG
	W6HCGtZEWmhgmE3jdJn0tnXyENo33V//9hQ==
X-ME-Sender: <xms:NSp_at6UrmMOCQP7LQbLRG7DtH93SebTWP1AizqHXwIvJgx4kVgGqw>
    <xme:NSp_atLaigpJA006KflabfnvoaAPaGcM_tOXzvp-PoxzQ7tAdnZSu2L8lVp8XPxKR
    bdhh47XtY6VdWQNe59qMbqyjM8cZ7QdfrArhtmZ-0hWhbIfb3J2Pg>
X-ME-Received: <xmr:NSp_amuzk_4awRaWZyusb_htydxWPMbtfIvpYbqfqiNvxnJgUb2YEKHI-1hvSVUTDR_aSUw41DqPVGtU8Z_Q0EojD4iWDSNuUA>
X-ME-Proxy-Cause: dmFkZTGJNiLg750EDJT5uUw83k/8ZPjDfFBZGlT8baiyLzC/NdlcRd8GOk7tHR/0ZJ82pR
    S+4ksX5SxS7NXrag7Wwm+I0bxsylhj60GGMJ3NenRWFIpn3BnKWikpc/CGex3l1Ygkv6pf
    k4tnWdTL+Hm2F3FDbGeydYDQC0xRF8GhmY099yMpknbEDrglEoFIeDU5nXGIDwJWuSfKOe
    j7vR9zc6qVqQhCWTxu9J5djgfEak8ZhKPYq4iR0FIt41YVBH1cxtkmA5CGxNIHyAziywsF
    BX3feB3WON1b1HwS5AjeQYCjUQvYr9nQAZ6C+2wuPWOoDCC3AmS6mZHMZLh7mzRh0vEfFl
    RBUxK7eWkkNbwWY0G0EzqyT7tNf1QzrLuiJUKFFwAhT7QJzGYrjjtTVPsntixjMrDbFeL2
    2zoPgbqW890ujNzNYpBpttHaJHaGsShVnCu3I0x/BBvJcMxpybsim44xR8R5e7qCxSVA09
    /qeUW9LmmunqrCVkLqNyde5iwlSQ5K0uQmNbB86/Hi7M7KXfZgjhg2s3jk8v7wk3npZ4mU
    h8CDuqb30fwQwvna6l0QyYo/sVz9OH9ZtXTVTsUq3qQYYF4vaYrydx8dREPZG0o8gk45lR
    9sQEj/cijPJUwmzxAS8fGEqXRRqvvUAQlNyvl7g04DL6h4wYYDxAoRHNJ/DQ
X-ME-Proxy: <xmx:NSp_asL0aNd2vC_Cuvw7T0oYC4T_kdr6kuaQB2j5jWvEx66cQNwOAA>
    <xmx:NSp_av9WIyrdm9cNwQiXvcZrY6MIZaEcchpkuMwiGArl5e-V3AwWDQ>
    <xmx:NSp_alyEllhqlwTyT-PEvZNuarWagfTwegp6mtZTgfsK0xGfHawi4g>
    <xmx:NSp_as5eqzNK5oUTQXn99F3WZn-crOWJnzoPgNMD7PH2ehFFKi_5Jw>
    <xmx:NSp_anawr4jg803uN4Tx5QsGFa5AEgSGgBf690SVGkQqHIpS30ajhfyU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 10:46:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] packfile: fix perf regression with many packs
In-Reply-To: <an7ItVYrKZFXg2ci@pks.im> (Patrick Steinhardt's message of "Fri,
	14 Aug 2026 09:50:13 +0200")
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
	<pull.2202.v2.git.1786633010179.gitgitgadget@gmail.com>
	<an7ItVYrKZFXg2ci@pks.im>
Date: Fri, 14 Aug 2026 07:46:11 -0700
Message-ID: <xmqqy0e8pxos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 13, 2026 at 02:56:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>     Changes since v1:
>>     
>>      * Fixed a typo in the commit message
>>      * Dropped the claim that this patch fixes the CI clone perf regression
>>        that's still being root-caused.
>>      * Renamed the is_new parameter to the more informative skip_dup_check.
>
> Thanks, I'm happy with this version. We can still iterate on the other
> patrs of the discussion after this patch has landed, as needed.

Thanks.  I do not offhand recall if I said anything on this
iteration, but it looked good to me, too.  Let me mark it for
'next'.

