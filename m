Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89022D8391
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524820; cv=none; b=RebHPMm8tC1radCrpU4Hjl4kfDj8srXEpB2s9KU47ygh7MiKZh70OkIIFxpCH/GR3n0cVtCLv+w7oW09Jr5+Kj5BIekyxqT1nsskStCBGEJsuCiFe5aJaU6V3z02q58N9uUFTYKscHrXYCo1i/84Qch4kF+X1m55o88wH78Pd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524820; c=relaxed/simple;
	bh=WA5UpCwnNF0Rv7GMIm/M6VyNqJn3b7GE5fX4rbzbzmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stum3XYPamUd0OwZM5/s94jwQE3usyEx3Ca/k+JW+1GPefxkFdMK8KYIyQbWnNJjYr9OWz/MnHAg3KCz843riPLfa1KwFYNmsupI8gGyr82186f9rHxCL9qCtAGmYFBgYJnsC72rW0r1tTr4FfxS+601SMHc392g7Y0w0KOM+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCCHaPS+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbMNoSQq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCCHaPS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbMNoSQq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D487F1D0007A
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:46:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 01:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791524817; x=1791611217; bh=9HPl1Pe0DA
	Ovpwdo1uF8p8SnCWmyNPQ22qevj9CI2bg=; b=VCCHaPS+cmfqLXxLTpBYJdwJ96
	8QGpvp9l4CqGQGcJ9nkeGL0k34JdDUoVHtswxYu0ug6a0iyMREuUtHhXvg7g+Gcx
	LAbp2WDhTi5UAY+GiiQDCt49qg2DHLoBHi9byi7gYPDLexyvoIyTnhIpVaVN6CMI
	rF7SpoZ25xlXVva1U1TkjntDt29dDYgmG2DekeqQfLOsbLj2e+gCPJ1eYWZzD22P
	nhdxFBOTk/XufRluKVaXL48QC3vKNGWe6JR76qnUvFMVe9OrSVzzqZ+A7F8LhVjS
	vEKEK0s3YGOdp7HZDFR6Q+8RloLS1yL6yvwqBuNFj+nFZgG+JVbIl7x0HSIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791524817; x=1791611217; bh=9HPl1Pe0DAOvpwdo1uF8p8SnCWmyNPQ22qe
	vj9CI2bg=; b=SbMNoSQqzhtcdxUwGuREjf5LTGnDhLdA+acIHIyzzkgJxjSSubP
	i8h32FIQYbl55i6qaoPAJ2T9+tLiu8cu/d8vWemJuYnKhiQecvGmrxJOHWO6Rec1
	72uffuEc2oIsRFPp4qUO93WMWDNIw14k8cXVFLyzqZgn+djps3sldljYxKR3l7Di
	wYrITzvIyvT0uKw8MCYr3LgY+oImAqV6h8P0gc+ur8dOEYSq869bUK30L8DoHc12
	i3Phrem2BNH6R0O7yDH8ImReawpz8yBo7BM/xF4qqrAjERqiZeNsTTCbgCaosrxZ
	6K9kPoKHETheVCl4V4tOtOeKFtn7n9EqlXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791524817; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OyLQmR2gCXo2wxCfhQ8plA9s19veW1L8f3oEtJfq/tvtP3x
	yuNdYoGMqCmZojnRisFlkFVpPwLnxBAC01ps6r1glBdK2CmdKMptA3mdE4K7wSA3
	ZC69T/PwF4Pyh5zGDShny/HT7u2tNFLKpUCP/iXckMNPqqjZYEpngQPLeRLakYBN
	B6kVx1G2j/QdFqhetc8s7gWpjpB709jwCZLBgDi7LK8S4sP4n5jX/iuHUgBf62oI
	SRCjl6Ij14H4qFSCofvcolVc7oPAvE5Yf3QD51/0xY6lcWFnRRKbaSYjaXEVCyoh
	rEjtOfAF5TRbRBeVf4YzUJMnXyD2++uQdiJzfkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:upehxUu4cB0Z/GJp6xdTD45kSWS1sXhJfstADHEmbSw=:WA5UpCwnNF0Rv7GMIm/M6VyNqJn3b7GE5fX4rbzbzmk=;
X-ME-Sender: <xms:0X_Iav5KLx7woLpyPSytXifo1C88sjJRlsQUyTZSwi1k82edGkEL4A>
    <xme:0X_IasUZfW8Gj2lycqk5haQaVe3LGLdD0gyHQyRsWgVc3RuJkztXe03IOqGPY3MT5
    liA47lwk7LKhPsS19-TBx56YLlxOgTICtviKOzJhhoT4izcYENxFDU>
X-ME-Received: <xmr:0X_Iaj3_hKkp7Ke0WzKCOLMi6nj4EoFEJbC2ms3d9NV1o46DwkhjoJ3RW4GmCQ5LtZZlQA>
X-ME-Proxy-Cause: dmFkZTGdWSnQAZuR3Kfn+Cc99+awzeUhS9OmFIBZOVf2vEI9nMFjxB626hGHshUTsjbiw+
    gb0jMVA+BDHZdBbyCoRlB9kYuf3t7kJeR15SnZC0fS9BuY94p1YFq4hrMYahUIbe6QZQJf
    LRS2DN4Gn5IbQiGW9HnDA7CsiVILHUr+tOcFb9pnmNqyRsoo6trRYUme+MobC4krDYJ/iE
    +wfr4ulkFhBgIO6uR5mUf9H3QVmUzwQwK7kUnDXi1cjFPpgsS3i0UEM+ePVnjxIfCuKzKV
    nxDVO0ImeRlnuhVhv2MKDh+n7S7IQlk7VCtiKJJp6uHkheG93Jho2R7ufJfwyI5pQ1gurV
    l1hR0iVM9SXNNy0/OihybcaIgZSBYhJ54fupcDG1squl/KJ562frjy9PSxDDhYfhO8uYtX
    D+T7mzULGPXo7QflT3TZjdi6rnftexTyjiuqo5Wg6hPSqdjw+CpkkgwQMy+Etv/Z2ygTsb
    0mD6DiKmtNyHLrnh89jAuKdwvDM+F5C45hHKjeFJnkvUqp1pWHXJmEwfH2ykCHdpNMGTGv
    YcEQkACF9EmFUi0HuYgI4/iqgKmzRjZBL0PaN1J2pp+wW7aThUeGDtbDHeleIDRQrlMTBu
    l40I+20gJKLq3EvvknIM/6zv4jywrXemyodfAAi7rzK1QCHMR4MXjrGzoUkw
X-ME-Proxy: <xmx:0X_Iap3-98VxSKxqLdgAO3UPcf8R8Nh5UP9bHM4_Fs6NxcSEt3UP3g>
    <xmx:0X_Iam_ydWKwtz-oyEaRVg6o3uZtI_nLxRABogeLwcc-mqiCHq2Hag>
    <xmx:0X_Iam107a5iAwLywW34OjDSh7a-pSr4EAZSDsHxZptT7q7YZw4e6A>
    <xmx:0X_Iaj-KAxon6dXUSiT_XFhqkhXt77iFJUHpGDibFRpYyG9dDFS_iA>
    <xmx:0X_IajEE9SGYJOEMfkfWFz0FY-URckuEZ7T8o7AW-11X3AZi2Aa85lHV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:46:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30ae9b27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 05:46:55 +0000 (UTC)
Date: Fri, 9 Oct 2026 07:46:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Message-ID: <ash_zMOb47cFnvQO@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261008-pks-ci-housekeeping-v1-1-baf015c589c0@pks.im>
 <xmqqa4oo1313.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4oo1313.fsf@gitster.g>

On Thu, Oct 08, 2026 at 11:05:28AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One of the tests in t5004 extracts a ZIP file that contains some objects
> > larger than 4GB and then double-checks whether we can read and archive
> > such an object. That test has a bunch of prerequities: it requires a 64
> > bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
> > enabled. Consequently, not a lot of jobs even exercise this.
> >
> > One of the jobs that does run it though our Fedora-based job, as it
> 
> "One of the jobs that does run it though" IS "our Fedora-based job"?

Oops, good catch.

Patrick
