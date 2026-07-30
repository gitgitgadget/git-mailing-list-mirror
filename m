Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BC3ABD88
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440317; cv=none; b=eRoNbmHYV4mRaJ9YBNx1SPtLKqiHeaFYa4DVnHuVZqjWGjibK4fCffEw6eWfbGCsojDupoGYRSSOmA5gal/gwpo8KxD5ZlXY99CknZlS6Pk6PnP1eDTD4m7dmoxighqAFFm0h+/PN3FdL6rsJwI5diru83z9TaTWFqREcJ3s4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440317; c=relaxed/simple;
	bh=P5Zymxlw8WC/Dz6QDSsWLb/bUQOqk/syCTgoJXA1NZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usW8M2PZWxTWeLLkZ53Wgzz9x4lVvCa6h9+8Z+J36M7wX/MUpVpSJV8UDVO/oXdizP9slBoIhk9+6apxO/I8CdKjbzJ0x6/Q7Dtrjas2J0voG19YJJCS/k3UG3YqN9TPFtrSbLqPAska3D10NIw1XaFPhdtCQBznwmzG7asKlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p0y/zo2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8Mlrhs5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p0y/zo2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8Mlrhs5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D60BE14000E2;
	Thu, 30 Jul 2026 15:38:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jul 2026 15:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785440314; x=1785526714; bh=aO9eHozrLl
	axitd+cbUVhMqBKRaMeUL7cRw1vvDl3Fw=; b=p0y/zo2XSVJz5FLiEN23USPE3R
	NjEQumJK5F1eQXn7fxtLE1IukBupDZA7ZVA+zcC6lcLyWU+Ux2GKwtUEaSE1y6oi
	fV/hoQRg7I4d3tm8wmsIsff4ihneN/WFmq5OKGYD7cZ6RA+3n40XbBDfKJC3RZhf
	hIMREezUqktDsF6N941J0wflzjlNjWoLQm2szIYq9MCzYlaDU4SqOCxYOgLw63yj
	o4Jkc8zoVCnGoGvDrWVXw0JoLMiD/FQv+8UoReQJbClydTHVAMu4auDW7jf2qxVT
	avmZoBC83o6ggE1KR1L5rMx1Pn0rLn9VjciXwskf1Fyl0ZlvonCmQcI9ieqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785440314; x=1785526714; bh=aO9eHozrLlaxitd+cbUVhMqBKRaMeUL7cRw
	1vvDl3Fw=; b=H8Mlrhs5zh1KA1LFjlpXINBARnqR63V+FzXcVl0e8bxpm006t1l
	zXiPIefhT6ghkJxdI4VBkRnySlXbFmFoz0WLKsNI4h87AOF/0wRBOJVwIhVA+kuw
	iL4ckK93CCtx3tWAoWvgSQb7/yS5EOpezaeuG6mXidtRh40gmS6mdhO8tVFY4u07
	PiifSfxXpdwJ5y7Zxd+LR4A8B4wYZnkjK/+fPBX30LD4Bqe6iRi+ybEMMXskL6l7
	YZgBhGtKYvk0rny2oA5BlEZeEOcM6nESUSSKXY3lqsdQHheAu3i9W3LKnY4+vF3s
	/Ile+ApRFJwIsqhPiHGIjsCr8DDaxQjPltw==
X-ME-Sender: <xms:OqhrajxhCIRicfr65R4pWSdPkmCzlZMpMfaEotUIGmGC6ROT05Ds-Q>
    <xme:OqhraitGDxxMC-mTVaQDlp_sSwVgSh1GFSw8yJRi_ZUaXP61M647kZpc260mLsrYV
    vBkG-Ccofjm4LTmpGFyR8hAXALP1Q0tihF_9ndk-oUCSNv9GnLx2qs>
X-ME-Received: <xmr:OqhraquKrdlF-MUGZahPap8OT1aYHfhpcAOzXC-oNvusW79Y09JbkbY3ZKM4_ig--5eCfnM4XaYPkBWJY9vxHTPrTYdumWtFsQ>
X-ME-Proxy-Cause: dmFkZTFRd3AfVofGcEf3iml3dNUtF5Hzj1txwLN3QdKc1yHpoiTX7ZJ7By+7tNd+TuzkqL
    0M232C7nNS1/EpmrRVwbFY8hSHDN4TO8YztFr97K+All66QKgrr1G3CjqpRIxzb1/1g4ev
    g89WE3uqwM3uMwgivzZpVgoFy6mrfaAKNzx5yq8ZwqDpOsGYGzV0QHrmy528dcL+UjUtwI
    WlxMUWZbOSN6QXsxH3IT+/oXPfnhwP5GXSyTUEFlv7IeSTEjMemiTsxv/cZ6hV8EigEjrD
    Q1E+5eyFnFbE6P1bwhmFiv0wjEjE4Fue4YPjtOTAd9mB597drS4M0HPkyVEOeDRJFmmBaT
    h+As4vmny5CWj0R87UIjgy5xliuYubKY68ISr33B+Ytqj1ZiW9qcbw1+FuC6g2O0bN61Qj
    DZZufma4GBgzPPIh9+brS/KdPc99Oa0+dXmIOPcVY5K4gNGCvCOIWXntZuZwIxobOXeuQ8
    quo4+FuYVyFkk9n2ecBNgGN53T6NaaB4tqKDhkUCWmKm9gqPhmpG6lxZNlOlaOhq7+4O34
    24w1lQqhVGYvz1TeX8PtQa6oCxIlnM58V90vIJUKKeQinziiiIzXqJBB/gKTGnToMFb6zM
    tIbaT4xgrLj/rweIblUUZxRPYrir3daq9NLoK6TKts1D2rHZ3oWypmjs2kXw
X-ME-Proxy: <xmx:OqhranMw6KFwVYmm4AL5SFlFbv7FuVL68XOYbZTT-AqL8uT9_Js1nw>
    <xmx:Oqhrao1uyVn4rj7Q9hBtbtiozNnPKCL-eijArBeYsSjLSJ5aL86upg>
    <xmx:OqhrajNBpG4nNtTZ1Al_NZ1Z4Q1vkTgzpWwjpdVQGNB2cwuCL3ft8Q>
    <xmx:Oqhrao2eWnGQgGWi2BjwKgn9-2F-aZlkesF6JLSEdj3obOjs7Ral-A>
    <xmx:Oqhrais0t0i4QawcTZWpwtr6YLc_e9pd4RmcA7knc_EpBA8OhpqUhjhq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 15:38:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t: use commit_body to extract commit message bodies
In-Reply-To: <20260730180207.83197-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Thu, 30 Jul 2026 23:32:07 +0530")
References: <20260727095656.75496-3-diy2903@gmail.com>
	<xmqqpl05o5n7.fsf@gitster.g>
	<20260730180207.83197-1-diy2903@gmail.com>
Date: Thu, 30 Jul 2026 12:38:22 -0700
Message-ID: <xmqqy0esjmj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I would not claim to have checked all of these changes, but I did
>> spot check a handful and they all looked reasonable.
>>
>> Shall we mark the topic for 'next'?
>
> Yes, please.

The qutestion was not quite for you, but for those other people who
are reading the list from sidelines.  We all know that the original
author of the patch wants their work in, so that does not work as a
useful signal.

> * t7600-merge.sh, "merge --no-ff --edit".  The test grepped the raw
>   commit object for a phrase and then stripped the header for the
>   comparison.  The phrase is in the body rather than the header, so the
>   grep now runs against the already-stripped body and both steps share
>   one commit_body call.
>
> * t3900-i18n-commit.sh, in test_commit_autosquash_multi_encoding().
>   The stripped body was piped into "iconv".  Piping commit_body into
>   "iconv" would reintroduce the exit-code hole,
>   so the body is written to a file and "iconv"
>   reads the file.

These are as the log message describes ;-)  All looked good.

Thanks.
