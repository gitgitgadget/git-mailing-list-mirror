Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879E4FDA4A
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025533; cv=none; b=L4K0DoCk+xkuqN1ye3ZTm0lDJqK09DIYN2/PYKkp5E3g+Crq/vxcvKqSfp9yZczBBRYftzOgTrQiPSy+xVtmjw63dYtE6+RKHEv1rIfnEZKCr5VVxeSRSbK8MAOA8JTE3jh4uXO68q0xXykmLVMbblhwmZd+PubwHUDXlilGLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025533; c=relaxed/simple;
	bh=Dr/pgxR0nIMevo45ZoEMlCzP/LIHEE9qGTc+mwcIiKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DfUJkxaQeQXbHgae0h47A6lpTTh5Cw0zRxMooC6skN/KwfU1ylPxyPrO9pfYOVoRBThRPCWJ8vux/InT+Qtjc3xRVTuosM1hGnDy9G8+BnUzg0UFnAU+S+b72gV2fD3rHAi1lBGUS4IVdC7fztree1bfvdXV7Rd1YC5tqz9whP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nwjRMKH2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIVbw6gL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nwjRMKH2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIVbw6gL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 07FC8EC02BB;
	Mon, 21 Sep 2026 17:18:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 17:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790025530; x=1790111930; bh=AL/Guh6fCc
	gfJKqv63J5ZPHySwkF5NHUQTOQO3vivy4=; b=nwjRMKH2NK3MoZiXha0rzHmrC1
	Vado5/nutc2DDsigF5oGaQLx2GnS2bSjRtkU/g3FP/R8YZB0PZaRR4npH8RATZl0
	YDJIEgqAgqF0kb6q6JMue211rvcPyfT9EjW8GPW6DeAILNSDqwqskgFVW/eXnnzo
	ultc2D4nCjcMJuWncSyHBFfcbytIMH+NlyX0BDlaDKLTGEQSe7+KsTcLZrBYoKWw
	jK5y1a4BswrPwheWGNBBasaZUFp/lgb3WZ91JKbcqqEvSvtV/glZcM3RmFW7J2g2
	kTQRULVmCQIsKds8Svhpqy2r6yOQKfuskWhxBlOdrnBKq8WTDkMEbkv093gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790025530; x=1790111930; bh=AL/Guh6fCcgfJKqv63J5ZPHySwkF5NHUQTO
	QO3vivy4=; b=MIVbw6gLnObFfNe1vc+ApQSqgt7lJSDJFKVd4FIMx2S/KnJW67M
	KrtteGsgio/5NzD/N25fV0Kq52QG/Hu8uEevBnVm3q1Gx736OL4lXNzFhnV5vsLZ
	9ongKpocRtEQXpaKgl2H8F89F3xRuHdTMHE2Hac86GlMzW1XEkCXWM3Y83Kc/c/7
	yX11lh/4OElZZiutNEiDDkRaLmu+pfWZg4xnVhnEYDfiGbHYWNQgltI5zUlEoC5n
	w742YLq+nQEN89SV5ULRbDSFGNPC3E/KBNciGWO9woNM8uUVg71wgfytCQDSE5yr
	CzkmMsFBER3+hKJgkVRE3sAqiN4zPa7ohEw==
X-ME-Sender: <xms:OZ-xakjxCWfWWEGmkbcF8zHxW47L-zCaLVeEiByOQUU7KyQbigVSHg>
    <xme:OZ-xagut06Mq7Lvm0s-7WIw0skAJh2_m9Ba8xC3UPT0aoxaFgpFKPcyyqUTx5B-Ay
    DwfCL1J2QBAFr_I7NA_89tjD5mQkXs6evIrYzq40yzBdoV2CvTTPA>
X-ME-Received: <xmr:OZ-xal7qf0eB5A6I17tKxCf85oafNfYxzCdTL52myvuU5vuD1jMpE3g0u7oR2ugDWZvTMcA6LDCN3RXKRBcuZ2THI5Dky6ya565A>
X-ME-Proxy-Cause: dmFkZTEaLx6ffeDxO/e58T5Gap2ZSHe79LR8MMMH03VMD03JX1LlHB4MK9pj3Rny7GrVJE
    +ybK0LTz7VskEGjrnucMT3Q2J0WIo6x7UuUp+2vZgpXWeUQD1K0xItC5zH9HUaUSZsZ77H
    14xfJFYWyvP3iER5Q5R9GWTd31NRiJ1BArQZ3rOW1IxBFlY3AOWEdCvVHpUnjP2iclXCIr
    4kV+YLdSAb0PVJ6uZ/iuSMw4ze6j3LeiztEfm8U63fpkiLY5vMfokgpjh9kxocd3FMo0ZP
    xxlQ5GNKMb1C53ulsi9INfjLw/ACY8+Urg3Xsj01pZp/kdceucncFhBz1msEGI4b15T8Uo
    /WUSdEpXabQPrP7nRXUpCJA2QyiwF8bNQLNW06kUgl/svT8YJREgYjHL7GBizo6jJwaiWd
    n4hjTyOuD3smAwKVaWvuD7ExU35126U0Oy2Ie1rv/A+rnWlAQYpB0c/Z/cldjjdYueBIOo
    /52bocQU3ejkspAY9JcyAp0DU/FxmMWF9JsUiCU+rnF9e6skBOemfs5O4fUn2wATOyhflg
    OAxAzvOXbGfdNnYAUH834GMHbWCkIjQ9G4C6Xa9FNrv4pSOeJvXYWOk83uOtzBVGl59vj/
    w6WtXA5TyF2aWgQoJY2ll/FSBvir+620pmR96mNlGVVRR2NQf2mw01Vjlcxg
X-ME-Proxy: <xmx:OZ-xasOtnNTbk2p5lytkRgP09oCzR9SsC_ck1V4XV-sCRsKjEgMZ2g>
    <xmx:OZ-xajv9DPvhmpgHc_3rbzC-oS7hd09bx8FWRmkVVDsVaQ613O-mag>
    <xmx:OZ-xavbynrtG-g8qtXjalHv-ma0pA-JjWq-hFPCaGXjN8cPKl83N_w>
    <xmx:OZ-xalztxg2KvCq9_XfN0-yuLLPI34idNrsNwdt45EhQxcybR97msQ>
    <xmx:Op-xasRNycq-DO6q4AdK3bb9KQC9fkh1xiIShl1AjzBRuIw4c26X5gSS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 17:18:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 1/6] strbuf: add header for 'safe' API
In-Reply-To: <b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 18 Sep 2026
	13:02:15 +0000")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 14:18:48 -0700
Message-ID: <xmqq4ifimhfr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * NOTE FOR STRBUF DEVELOPERS
> + *
> + * strbuf is a low-level primitive; as such it should interact only
> + * with other low-level primitives. Do not introduce new functions
> + * which interact with higher-level APIs.
> + *
> + * This header file specifically conatins the "safe" API surface for
> + * working with strbufs. The implementations of these methods avoid
> + * using die() and other exits. Thus, these methods are appropriate
> + * for use within lower-level APIs such as trace2.
> + */

I have to wonder if this is somewhat backwards, in that the longer
term goal for us should be to make most of the service routines like
strbuf, string_list, csum_file, etc., free of die() and be "safe".

A recent trend under the label "libification" is to make the use of
the_repository more explicit and pass a "struct repository *" as a
parameter instead more widely throughout the code flow, but it would
be equally if not more useful change to expand the "safe" API surface
so that callers of more service routines take responsibility to act
on errors.

And picking strbuf as the first instance of such generic service
library certainly is a good idea.  Its interface is well defined.

We may want to rename functions that _happen_ to use a strbuf to
return their results but otherwise has nothing to do with strbuf
away from strbuf_ prefix (strbuf_realpath() etc. in abspath.h are
prime examples) as part of this first step, though.
