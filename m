Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA13DD525
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581072; cv=none; b=n2eJCHkXWDikoHD+K0cQUX8JZzX/9JtRdHBnFu5eKV4/ey+ouU+dTyTvECK6KMYRdBp/r+th70MiZDYp3Di0x9XMS+WfSipSkw2ShMgjqMITqM2Z+zI7YzcNY4WdrguojSOkB09sLkvKgfDH8vsHAnbBQFBLlbSid87kUnLNOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581072; c=relaxed/simple;
	bh=iRp5TMp/W53EgegBP7W/jGFhNP/FGkvv9/zcsI+XVYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hv/70OUUCrxb/pvU4QCh/O/lH7y97kFILJRm88UC668unP0vlaDsE7bQ5u4pjQ1Fswu6KKGwZsQTDqLLZJVfL/QY3qTln8Bg4iBWRQt97MfEpfIXT98KWltHlqL4ZE3oTdLsCUH2oko+FxBwxDZOHdNgB2GvXeOY/HdNao4gnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M1t+gxnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXTLInS5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1t+gxnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXTLInS5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C6C77A0090
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 17:24:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 17:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791581069; x=1791667469; bh=z5g4DSTzYV
	QWj/A3NQtalQZ8gzhqPng1TY1lzvHlZys=; b=M1t+gxnzob6ImTCF/zYgwIJsOR
	BzXf4RKYQT+Hryg2pFLpfRQKMRF7tYtZaCK/S9RD0kqgX4IMczu3EOI//iA3YXXP
	VbMJbAj+3BtCIe9+IGFehDevbYURFxKzLTJhj3tUkQJPmWl2OWUjeyBFtRV/nlJP
	eHkWQMMfzFrn6wWFxfTDQzb7yrRo5P75Rir1vqUk2mEYP3i3+1YfGWK1g0zq8RXY
	flaXi7AiQpdzHGfv5lehgXEZX3ugmgjvRQvxd4/BxCzetn5nKvIjH1RbpaXnFxcd
	cl+/orTihG/B2R0Qe+M/bOKKs9YP2IzZCXdpZ9KKbuN52mYLHHlZnoux8A8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791581069; x=1791667469; bh=z5g4DSTzYVQWj/A3NQtalQZ8gzhqPng1TY1
	lzvHlZys=; b=ZXTLInS5tm8hPyjVVG7gGSxvAnD9tvPqFLH6CoAK3Cvd4Cloghn
	eRLo0Ye5sWKs1OXP0StLPyHgTOiPc/jn+vp9nXDebNq5ETlrf4ozTxXOtZNSTQ4H
	nOiP4m6syosyIcexbhRmcLTeMTWCql1wxaEADbmB1ejLzGtCPCFDIG6AvRyujqsX
	C0p8YC8uqBN05OaOHmSoKEuH39i/ntvNKQbRWEH7gtN2kTA73jorav/5f2bRGGS4
	LB64dhKO6I2RcYA95r+RNWgx6V5JYIDUg4PGEp70DD7PU1DxR85DJEoUidS9EHv8
	pPqVZ+K6lWXCyWpsy8mnSWDDY3YVXNGkYuA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791581069; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:W0rMwMlrrLaGLBlCTk9TYgQnbC0dLTfzGpCrRFKF/0KcCtj
	hCzZjTlqAOPnkuEYTLwNRGmxRUlxvDvxR+83MWZud7LKGNNRbT0X3T/HvQSp5JHH
	QDpMpV6QYlam699RB8J9inmaM03w9YfoehwWn8x7uaYzZg3ZVdEpiahE9+5SVXiB
	zJQxXIE3dhroKRyVRxodLycckTYdHnm6k5rVvhiq2hc2fGDzWy4nIsfKkY3NdH3V
	76MKdRR3UY4MMlRbTkHZY/5LEdO+TYCOkOzYXENb+ypjXJsVhORH0GpWaf00hbw/
	F/lBsV/Gr6lMfzocrKQYefvsEHoE+0JEbM4zzAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hOfTxBG5vOaAd8RDhQ0aHfR4QOqLTAwe6XHm8UnqPjI=:iRp5TMp/W53EgegBP7W/jGFhNP/FGkvv9/zcsI+XVYM=;
X-ME-Sender: <xms:jVvJam5-RTcKzg4QYX0bmZ3d8NlP5eYXD5ce4Ptpqr6LIvv2eFEF_w>
    <xme:jVvJamyPwgQl2FuMIpNdfNLQDfV5QO9SksjOVbMPp8tps58zEIy0BmSclvzy-cjo6
    485kWT8ZIKUihSzN7q4Bgq0s71rXttavlWGE2WMkapO8iFjnr0MfSc>
X-ME-Received: <xmr:jVvJatyrVFb4X5i4THYRDgjwlJMdSjqYr0q8araVLmSdnvoPOXxOq642pPDCpCRpVGREQ2KEHMXm4dsvlPzjSMdhAsz-xKjUcG1y>
X-ME-Proxy-Cause: dmFkZTEbnmSRNr/e7k5RGYzyxY1MxsdwBtDDOl53V8akbj0MN2MpffY/TCuBob/+akxa/J
    n1pQRvJAABshVRCxfliPv1wowO/GQaSCKBuoo25vlXF62O06F5Jm4dQ+hFFJqMLqyLFUAF
    QzTVzUloA9CjaHfHb7pMU92YGSARf+CkqTj9CJPiYMGmrz6aHaMVqU5YM1fS/x68bQLbzg
    JoAp51kTIZVldcrbkAbv9Yr/HiP7oRvVycDTx6T9olAYH9OHqJlzBvtQOpLuFSePpouXoD
    XNRd2xeoc9DuhT3fdp4b/e+OgO5gmwGG8GWGx2sRF1SbpoocHXFG0YyJbqcGtZbBjgC0CL
    xceo5mR79j4T+DEXw8zKO8lTsD0hpvym6DU7b3JhqTS66ov9Sm8OlKbPvn2yJ3EGzsl8j8
    eqPOlM43Qgc8AvLlcOKXIy6ujQecIoOw+QPlLnGXagi52S2NIQl9VndeIMj+tofFw7/xNh
    BeSHU7i5cJ5Rq8WAn0hIi0OsED/CDPUDOMvtgwau6JO+HvwVssdbn8LECBbGxYW5knitjE
    0sH3vT03MW3WIMTinyxdVLtMP43vRNqsawInCClVHfVHHzG1z4yhKlj6WVhrkmzF/mCWQ6
    6TevAUEtIWycejDutIyVtuYA4VJ1Jg5idunQZOPzyLtk+jyVovUZkawQSTJQ
X-ME-Proxy: <xmx:jVvJauz-5ZCRTOOKvLfdX3fdPKI8PdS-2bgfOjusN5YBK5EqU9MGqA>
    <xmx:jVvJanZPmzMxoHBL3mu_4ewbTqG2DdbfEj3gwNtLrSMQ2OInTP4i1A>
    <xmx:jVvJavUySRt8I3eFHXJtaSbAofo1TClLeI2CfPkx9ieswP8f1ZnkEw>
    <xmx:jVvJalgYCCjLWiOuK_GlsEZPB3Won7RDv2H1xD35rZFnyfvAWxI9yQ>
    <xmx:jVvJaiDAc30X8YlSIDqZQqTobQK49vHyaGdP1adhzfbqxPAl8uiL13NY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:24:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 1/1] repo: add filtering options to "repo structure"
In-Reply-To: <20261009180951.1628134-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Fri, 9 Oct 2026 14:09:51 -0400")
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
	<20261009180951.1628134-1-markchucarroll@fastmail.com>
	<20261009180951.1628134-2-markchucarroll@fastmail.com>
Date: Fri, 09 Oct 2026 14:24:28 -0700
Message-ID: <xmqqse2elg8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> diff --git a/revision.c b/revision.c
> index ee1df92d1d..79d44b58b5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2837,7 +2837,7 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
>  	 * NOTE!
>  	 *
>  	 * Commands like "git shortlog" will not accept the options below
> -	 * unless parse_revision_opt queues them (as opposed to erroring
> +	 * unless parse_revision_op	t queues them (as opposed to erroring
>  	 * out).
>  	 *
>  	 * When implementing your new pseudo-option, remember to

What is this change about?

> diff --git a/revision.h b/revision.h
> index e5dabd18ce..63135c5f88 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -125,7 +125,7 @@ struct topo_walk_info;
>  
>  struct rev_info {
>  	/*
> -	 * Work queue of commits, stored as either a linked list or a
> +~	 * Work queue of commits, stored as either a linked list or a
>  	 * priority queue, but never both at the same time.
>  	 * rev_info_commit_list_to_queue() converts list to queue.
>  	 */

Ditto.

Everybody makes mistakes during their editing, and occasionally fat
thumb hits unintended keys while the cursor is in an area one is not
editing at all.  Mistakes happen and that is perfectly OK.

But a hunk like this one in a submitted patch is a clear sign that
even the author is not reading what they are sending out.  And this
patch, among its 16 hunks, two are such hunks that was never
proofread.

Quite honestly, it is beyond me how anybody would expect others to
seriously take their time to review such a patch.

Grumble.
