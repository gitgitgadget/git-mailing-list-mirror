Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6CA53977F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169981; cv=none; b=Pq14V37wgtGahDrk8Ay0HANddLlMbkvXwWrijH+xzMhuXuVkCmo3UwB7jDuzRwV9CnqgaLKYBBVllOw+jGEkiZky4RVRqj8tXSQ0TdlMjt154lC3qucUffcncFEi6KavJ8KYy7p9m0ednjnGKvEwpJRwK07xH+R+AhTIdpBH80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169981; c=relaxed/simple;
	bh=FNDftTqh1wxsDaETKBTf9b2rf8tjbJfqqTA+LhF/AXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVgHFWlClFFkGehB24yJG+zIkG+i0uB+xvMWrmiFwLPNTG/mX8bweimZLgKQq2B0g2IHvelkwk0OpNnuTm3drVE2/gnHs8E3pSuRAlEQHLqMMmSwgmPRZsi+EqxeOV48oPch+O3vgxlNOU9i1vKN7JEXPK28vLyE4/hlFW6SLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMIJ13Xb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJzt7SfH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMIJ13Xb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJzt7SfH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 587B41400113
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:59:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 12:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792169978; x=1792256378; bh=N5l736NWeQ
	+VVBwFst9JCmwp5w8V+z4oAsgI6ICcVsU=; b=fMIJ13Xb5PBt1BTPvVuUnNa4Sv
	U1RINsuSjkx4y4gUPwA7mIqxclo1tyAYJ447XvEUfYEG2UM7vCtoP98uICQokrEY
	kx1qQTK2uMbBLt8QIh+thivkkNxxjkqyOEID9X+o6oC6Nm5BHIsUA68hzJF+2JDo
	pbq5GJfENRGX/y/N2U2ntOtQxwAzv26LtK5Md11ubD/ZV15afevPDlGQw3++sPJf
	zOFqiDHfFkxWySsutF/LkXr/g0SK5JaF1Xre+XfUhag7CRZX4EJXlYaiK5iLRXdU
	8tTcC6wHcDbmMtCMUiBE0/k6lEKPSOcZneRp9jZMFkXkm2i8fC4KZ6+pyFtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792169978; x=1792256378; bh=N5l736NWeQ+VVBwFst9JCmwp5w8V+z4oAsg
	I6ICcVsU=; b=rJzt7SfHDYDwWota75chWdkFF6RUHt8TqH/34pT/qtDP7BvRYBM
	bUhgP+P245tc8/gudsJg/vkzfoR+d3NQg7KsGM6ohetAHYY4qJSB08bAc7YxmKng
	umbgoxRAOGjw3tgA9ZNSNGVYapWCOgn+GX5r26KlMvZY7YM402XaB2CysqnmZvBo
	0qlAEdX/NAOFgKxHsjCNzOegecWgwcxmJOirb8Uy25MeDBI1bTKWmE0qmzsPiJIm
	rzmwtC1G40VpquguQ4YpJj5UwPTXKkKIUuJLf73l2y7YPrPy34mYi92VmDbjNO9R
	+q3ylRxlhgA9gtCpEpc6+A7ro+nxBwsxukg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792169978; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iKm8ma0EEtKbzrJpV/U7xnJCGaDVc+Efd3kQXdqYnxoiNvd
	k4qSSgDL+nOT9OGyVBMbsTo8qYwo9B3JKBcvi88fr1+VS52pGtqpDIIupQ2McEOp
	Ct5ZHVbtxNU+spgciZOtkAIu9viFz0mxIcxKQ185SXebtccCAazPCPmFIrr9TNvB
	hNfW8ip3NYn6UqWJt4x7KXs8xXk6gR+5B0oPkWqE9rRO27wMvmoxIig7/3RzWr5H
	FSU/w1kfBfBOMRLnAYkhauRUY64iaBTgiX14LZnZ/tc1EfGPK97+dmpzxtwwCEaJ
	daL54RL7oKkHGaKed2BUbHrebVjyus3kbjBn7eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:D3/RHaTm9gTsY26b2QapbYb2+rRs0XcatEdXjloyI1M=:FNDftTqh1wxsDaETKBTf9b2rf8tjbJfqqTA+LhF/AXo=;
X-ME-Sender: <xms:-VfSalJD-DsUbONtX5j3f3yOcyVA87j-ZTpvI_N-D-hM6Qyy_6t5Jw>
    <xme:-VfSak2XObhfhaxsYD0YqSPEsiwOQHYFPiUQHyOYFyx8C-RbeEbUWp_Az25Vzv4Vz
    lti-Hll7snQArF6cszXzD71z7e0wO9nZ4m3FwOv4ydWCk6Ffj-WLU8>
X-ME-Received: <xmr:-VfSanj0M7gsjwDeTw0Eciz-MK1J7OXGwH8nVA71LtLM8DZgBIr9F-9YoRk1tUVRS0uN5vdIyNHNXcHu2f4peuFll6Fy447hofAx>
X-ME-Proxy-Cause: dmFkZTGyEdsBVbAASjolMw6lD2vrMk0QUSu+iTIQ1RgQcnWXgrSYmUknFMgXrd2FpQNR7l
    gclfx+Koty6V5rQXvmvTV1C93WmQlXibTh6x/ABomBwNBZoevmtuwTr2geJyhsyD6tO6Vx
    L0nAzaPVaN8PwzM2hT8nozJ1riatT03YABB9SeEr1wNrZ1zA+6GWh5U3qAfl0dDfP0LeVQ
    vFihaDq3EcX3v0kuMxSvdbhf2EmoNFi0ixqqAEfD5CjQwBkctB0Do2Y4w0d+DI4jLUIRk4
    XnrabGwVP8R/R7H0SrFuNQql5Y4gJA4Q9NUzmyuPc4H5grzdhknwHml3quNwBZf6wlkRWz
    weniq5Wr0UKubVHxuGO2PshHX39m74DFFBTA33k0lxds3/YcGY/o4TPMvdaL86V8bRtb6y
    C5cgiolpB+Wb6V/mJY1NUpIkWxfNjgw+p2M/Y08P7f98AaHIiWOYpPRdu44dF6auy0sqPZ
    2H6MJjU9Y4cxCsYkqNwADaEodfSoz+RfYJ0TOt6Nu1uZQ56rR3gtcio7RdoRKS0F/6F81Y
    5kdrrQHt3h24skFHw3bbSgkmh6rzs7NoRt9A9rQ5eC8ZKN4U7PI/zdiwTbFT+9AeZ7dQVo
    FMOQv+0EXvFn8Aiii6rKN/V/C6tym5TMJDIue7M0mrZ/TrbvrWWj98ZbgELQ
X-ME-Proxy: <xmx:-VfSatVWUG6s-J88COsgjrb31alSycoh4DHp0BGdIFe1aaQCA2ZscA>
    <xmx:-VfSauUlCk_h28OmZHy7DdDySxZTPbxpO5KX7dYMrsY2xcBxxmhACg>
    <xmx:-VfSalj_qdkIBcJLfKikgaB3_Zv0EFsLe-c5WcjE6oFTxUEBFft7hQ>
    <xmx:-VfSahY_8ysVn1SP3h7Ue3EHOAYaKueXDOFr2lB9V1zWNytpntCNaA>
    <xmx:-lfSaufdz0Yn7eQXz_9Sn4kU3ikRiY4370GOZ9cbxetezFBc2RUHtJa6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 12:59:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] sideband: skip unrecognized allowControlCharacters
 keywords
In-Reply-To: <20261016142515.T1gr4%taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 16 Oct 2026 17:25:15 +0300")
References: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
	<20261016142515.T1gr4%taahol@utu.fi>
Date: Fri, 16 Oct 2026 09:59:36 -0700
Message-ID: <xmqq8q3xh98n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>
>> +			warning(_("unrecognized value for '%s': '%.*s'"),
>> +				var, (int)(end - value), value);
>> +			value = end + !!*end;
>> +		}
>
> Reading CodingGuidelines, it seems that `!!` is a construct we would
> like to avoid:
>
>  - Some clever tricks, like using the !! operator with arithmetic
>    constructs, can be extremely confusing to others.  Avoid them,
>    unless there is a compelling reason to use them.
>
> --Tuomas

But here it is compelling.  You want to normalize random byte into 0
or 1, depending on "is it 0 or non-zero?" criteria, and it certainly
is easier to read than (*end ? 1 : 0).

Quite honestly, I do not think !! qualifies as "clever trick that is
confusing" anymore.  Perhaps putting the rule there is misguided.

Thanks.

