Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6B4C33EC
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218339; cv=none; b=QM3pqPOhsuwo48NgUAYJifjSyGogPE2xAJzrLiU+YDrqvio4t+LX/td2Pp/2MNhPCGuQ4vG6OYr/HJ5asT18/tu0aNVTzV6ITJNgDgewFKRs0gYKd66eHB588ymJ7ShxGFfqGfd83xyiNVM2+CPX5f/43hJTi1TrTYZCqyQneuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218339; c=relaxed/simple;
	bh=ZlFAp/V2ydPUTIHTyi5RrIDvW2OMXatGlRDKOKw7Qs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVcy4qcQDy/AInKVNlZsBAp2VuW41pmoa0WHuV2hNVXgTT772cbtG3HlbthFrAdOF3Kq/H12cRdbfeqU55M9yE0R2UIZAPkAI7poqWPxBUsVmiLGX92/82scYw4gSZHnWu4sh/MGtg3rWu9cgQe7JG79A3Igj/y63s4cP0lgeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BsWOAZd1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivLk6L9L; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BsWOAZd1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivLk6L9L"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D2341400162
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:38:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 05 Oct 2026 12:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791218335;
	 x=1791304735; bh=J7ISegOjmqE6jOeEW5/YSmXN3Y1f5sv2vNY9Ky0Bbkg=; b=
	BsWOAZd1NrBLcVrpVBgc6aE0h5Xj7vURAEcGz3Vg/pE5jKe9qmHm3prDXNhd8+tT
	SxQYDErCu2v0UuN3WWwzhWFNrcfRHkpRZKGOTFkQnoWLn8TgKguHfhfsBXvB0dcr
	5dy2wYTVFQytv0T48Y8+60K73haEWBFcA7ggf3CqDVOtQvuQscsvTfJwcAgrwoF/
	kZBfJXFY6wc2Q6MmdXtMQCShpY/FdLLBx21K1AD576ZQO8wSKs6oHvMeh/xnS0tp
	xXFr1MlIThYeytxxT8pv35FrVL02V7wtfsIZZcYCnhUJSRd/qgfxN6fUKLLJxewH
	hrfj6plchlrA9eADmnW6GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791218335; x=
	1791304735; bh=J7ISegOjmqE6jOeEW5/YSmXN3Y1f5sv2vNY9Ky0Bbkg=; b=i
	vLk6L9LLGUvwh4Fu8VU5KxWrSB8Bwr/Wb7jmExlnNqxARcCw69nAMk1rVXuCcTPa
	hfKk18QTI7ptJoNa7ZJst2aMAqgv/o2rqGvbu+nS712I2moqqEfziP0BgVn1IK2W
	FmcTDtSE4lGQAeTvV5046xRYjOO72y3Z3LO/MRL4fNxvfeQsE117Ejj6mQGcpXBo
	0pMUjNOef3M0MSE5YaKY1l8SsbWAdKVB5V6uKksDCDcVOJmTRdq1LXu+DnPOeXE+
	Hpv/egy97v4dwQbIJ3lJMlGKu2zAEFLslUEhv6hEOwq91snv67yNRb8vdsKHoSPY
	RYta6twpPxIZM4RtcbjnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791218335; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DYh2HEEpwwBMhdkW5Y7osXRVF/ZFU/UVbd/jBWCwnZkBa7H
	idUfMxJkxSy9g+/F+iKSJn8yHruJFfHolrZ09WJNzMvyVRPZKPYOS9eZfItrSym3
	rMX3tR9KwON46uK7ey94uANUz8lPvoycL1NxM9TVf+XxFaHib+qDeS35o8um4ZLl
	6r7Ke3vpt+ZZSvczTfiX0+lkH6dlDeUMtxySobApT1ch/k3GStk3VWNxEnRSCXEe
	tBuQFuK6PeUK9p92Irr8xoq10aKdXH7/syhofcmIWPO9PDjQHoZteduAWxg+DCZS
	LIu2pkSqK9d1WL8jFH1ytdl/lTwSM9/AgmUpT9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:kkkRgr3olzkMxHbsBrH8S1Ruks+3ST0dl++AeDwH5pc=:ZlFAp/V2ydPUTIHTyi5RrIDvW2OMXatGlRDKOKw7Qs8=;
X-ME-Sender: <xms:n9LDahBjoyHOKXebVKv6YxwTLui5uEe332OgYGTLU2OePZ-O5UR1fA>
    <xme:n9LDamZ0fmuNvVoyQtTuOA23c4iQL2pDIWRKOWRhhuR1zFZhvRAPQSpmdmxh52AmL
    o3F4AQb27CeB3UJoW8vJE3X_-e84mTnT2PZYvApbxctQzfCf_T4tA>
X-ME-Received: <xmr:n9LDak7GhcYfQA2MEgWaTGL8EskKeo_VxR-oKdF7-fIJLQTREo4x5VzBGPhkcZodbqztFLTTIlKm2tcTlDBVf1WOdFCAUuVzQc2_>
X-ME-Proxy-Cause: dmFkZTEwNyoLRcMH9+d6ijP5DPrCWeAcaVLfcl0yidfPaBmYYpiXf6SNCX9yWXqLR8DQOV
    dzkvYdtGhu1XNPiYOjRDoIWrGuTCpD3lZFQxj9529uYSqdr14w0YlXR3qqg+PORGLD4cwC
    jgYLWxl0V3wgQ2AoDYS3oTOkpqo2tiNYiCJ5cVtbx4c7KKOGvW8scLawODnWAsW1ehgFKH
    i18oRXnhp8KEY18qsRGJNC0z/7q1bcCoC2pMZHWChVJHQuCjMPgbc8GfDCUG/4vexVK/Ix
    +4lhI8/xlW0rXfyWjl2oA08Sp9TbzyuF4ObGalLnt3owrZ/wu5bv3RvhwoNgSqha+SPCEM
    RNrml/vYBuPcv3tTZ6QjgQQn4rBZhjIhkYhrOq2Wl9cl+3P14jub+orTxtqyUuQuox3JwZ
    lYJ3r4OhcS4uMz7t+0APATNM4qPMubxdhHzIstuxKBfWruzdZ50Z1h8OpbYFjU1Kej4sAV
    oTrnulJOQZR7CavBvFs5pNC0XikBCtMP9GpNSWeV0knmsLhAWiRkhCOsQha9w1nsYZ8/qV
    3W8lBj3nPlTurTlKkWNiHgxguh0iEHleHq0DSoSOhf1AE2v3mXF8BZNV9iC6HEBLscl1wF
    WI3Pvb5LI7yGRAniBBmOdan5Ug/6F2pVX9HeS+7cPfwS3KkRsbaPoAB78+TA
X-ME-Proxy: <xmx:n9LDanatqLCJOQ5yX_HJAs25rCtZX6oaFKicJUue2YmXkbhgHFQGmw>
    <xmx:n9LDajichzV6DzsW7BX7XB8ggCv4whm0VXA8YDfBO3MopbzS23Htzg>
    <xmx:n9LDao8ttDi2ITlQUXEmSRFIHyTp9RRHu35OhLVh5JB-EXKQqQTP6A>
    <xmx:n9LDauons10zC7c8hdskWVPNmndrPQdViiuj8CCbFXzprDkgk2MXVQ>
    <xmx:n9LDatoMbUDiYWQnJgjYiJn7cTeeyuiWlhoqk_o1dmsB2Pu4G-CNqzWx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:38:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Sphinx" <sphinx9692@gmail.com>,
  <git@vger.kernel.org>
Subject: Re: Question: behavior when reverting a commit from a shallow clone
In-Reply-To: <DLWUB05MOV7T.2XA7NG57870ZD@lfurio.us> (Matt Hunter's message of
	"Mon, 05 Oct 2026 06:41:31 -0400")
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com>
	<asNKZpxiuFhVkVQd@pks.im> <DLWUB05MOV7T.2XA7NG57870ZD@lfurio.us>
Date: Mon, 05 Oct 2026 09:38:53 -0700
Message-ID: <xmqq7bjwkspu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Matt Hunter" <m@lfurio.us> writes:

> On Mon Oct 5, 2026 at 2:57 AM EDT, Patrick Steinhardt wrote:
>> On Sat, Oct 03, 2026 at 02:24:42PM +0530, Sphinx wrote:
>>> 
>>> If an operation is then performed to restore/revert B, I was looking
>>> into the behavior when the resulting working tree/index becomes empty
>>> — effectively causing all tracked files to be removed.
>>
>> Yeah, this can indeed be surprising behaviour. The reason for it is that
>> in a shallow clone, we rewrite the boundary commit (so in your case B)
>> so that it doesn't have any parents anymore. It thus looks like just
>> another root commit that has added all files in a single go. And the
>> consequence of that is that reverting it will then delete everything.
>
> Separate question from the sidelines:  As a non shallow clone user, this
> makes me wonder if/how these boundary commits might be munged to
> preserve original commit ids in the clone?  eg: so a fast-forward
> pull still works for future content

Something similar to "graft" (and now "replace") is done under the
hood, to stop history traversal machinery seeing the true parents
of these boundary commits.  As the commit object itself (specifically
its "parent " lines in the header part) is not modified in any way,
this does not affect object names.
