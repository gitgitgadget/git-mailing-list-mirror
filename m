Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9A175A95
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098725; cv=none; b=bZH+XqPfOeShpXmrsKLoENwt6keirRtsrNaFx+BtnHJIR367FjDQ6K2+ptaugS46DAiCgH0SyPeFjbAjTCJE+ScSN4ROmZt+fNL/pShMa9WDSFyDF3Ov/vteg+JaeSypv13pwu1iYPiODtgVmp4MpUw4kbRiDlM2pofdpPcbN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098725; c=relaxed/simple;
	bh=D974bHieiyxM+JQGZsuO60QS/stuqNh0pEolXKnfUYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9332e63W3meUNCtTstIDxTeb7Dk6eeJ8My78phvuoEKiLhyhhdwn/xoHrgrgFxtQhf67lPotdObb6mLyqXFPmp4T4Sjt/8dwhmTZsQFugATj5k85WfoPOSK6FqNtuBwEcz5e0mQaPqPFMf532YTh+3PaKqJe0bBcxnpGilE9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gg00KN2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7hH/f3I; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gg00KN2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7hH/f3I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24A647A0136;
	Wed, 15 Jul 2026 02:58:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098722; x=1784185122; bh=Rh3pwJS0SA
	E3E6JncvNQbu1AeKuUsc0pGRJQvYBMlvg=; b=Gg00KN2s5tM+UQTRsgBCxKQ2iL
	wT/oX6Butj2HEZKMcSJzUhRRhceizBKj8bWsYsdLCIv7EIRAMcl56x9X2mZoHjvE
	m1NWY3xHHiDPgp1qkPKnJhQZWal+zwZat/XiFZJKhbuQg8tk2DbV4PwVMx1PSqhw
	/772NFtYsAB65zkIuJgkQsWskTPSmDXIXNShLpju3K4cNJYMvUbrP7IXtPD7GBHJ
	VGhg+jbOFkxF8xdYYARMhCYa+wJdOytgrP1O/9jfd+QRegl1ialeaaibhef+52Qs
	jF20qelx6ZYLE1EVTPcWkvkMaQTLd3SPvB0VzIPm3ssiIXM//ECLFkZnVELg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098722; x=1784185122; bh=Rh3pwJS0SAE3E6JncvNQbu1AeKuUsc0pGRJ
	QvYBMlvg=; b=S7hH/f3IzwWcu4kICybXAWESXbPqFDf+UQsw6VGYMoG3TzlHVJx
	Qw8g0EAu5e6292nDTMU7b7yHolDKpV/JoD8TCcy0pogD24sbPewoIKQlN6MUspMl
	bBohN46zMqP/TsWEVZ3dgDIjitVWdoQZa5D7KDsXexI4glGReeQzeMx7eJHVEo9P
	x7XhsLc2IYue9rEZx84N5AIObkNNehUjVkA1S3XtdgTgD5j0ENCBDFitkt1HNhne
	iGHRsJvlySjCEl3SYbhUidwHhRcU37XPpZm/zyejQw3eUHHfO8H3ymmcw+CJTe04
	lAvL2+HxmK5WmtiK39yAGtT1OWQialh/rKw==
X-ME-Sender: <xms:oi9XagzpGgQ2viz-2uQcICsphkxe5iEVEnvlAcw49fs57Zdxt6lmOQ>
    <xme:oi9Xarv5t92sIx5bLiQqtG46TxqzTB9GNDU300EPoGNj4KX7HKp8T5NvnWUUP31j0
    qbO_Q41bwqh8BDRSohW1WJGyWkrWuKGy-1NQNgnvBi7zAhz0qJs3Q>
X-ME-Received: <xmr:oi9XavtelUjUTWsMiPY7gMLTmnmL-ONpmgqCqeMNEUrHsOPvm3Z-1dlvPdMrtf1L2ItnS7wLlHz56IKh8qtDTzGzn_FfOEnnKGVsIWhg5hk>
X-ME-Proxy-Cause: dmFkZTG1WWLcByQmmxMSO/Is/1htfmCFwhWIbKc8tIyFwIy51tFCJGhWeULuMmLOXCSBLQ
    MFx1NYf4CviGlxGqPgq43w2i6MMCPtAwKkpA08/2Yta0HdXwCFPrSj0n6YWWjj4yYRMvdj
    m0qyDTj6SufVs3QizVkbE3H4edg3c3M2MnQPEQDOyz5AjnzUcvuGvK++Z5CbADHe0XZePf
    Q6jFCZT8ntJHMp4+oFMZl5p845ZNgpHlDOSm3eoZSpB2FtBvTnTwkfeVjeecBnDY75Aqfh
    XZnCuuGXJnvxOWBdYCMGi+rojKUK1izkSXYOhntYw2Z1/dz+wA/Hwfa0SczX5RCrgIR7Xt
    fCfcQqCvLU4vjYA7LxY9ZHP5gV9pB5JsKYxOWISVohPkO9L5niBByS0hKK/aXOiRncH7eg
    WipBdLHDjkS2Uw+ScVC8/14uhFP7789u8pcnLX5GrBV9sYnUkwFK9xqgZAvMOw/eoUFnJO
    5BbYosJjPyjeSARAkiSHeUIVYwyIEV/oOYC7WZFKUJ4u8qFHkwx5IvlOPNqM36Af0SGt6C
    5zw/qy20Wz8ElbXoqLtAfUJi4Vj1IRl8QScYYzrRWVrhNoyA1owBh+UYel4nJekwMzMy/V
    zYE9s72W8a0YlWUyEjlIzEm/HZi7dQYmhBAyzXH29NsVgfuO0fhrCC6asJEA
X-ME-Proxy: <xmx:oi9XaoN2HT2gkd86z_iZT1QS38isCOOByT_0fRdhGAeUOTT90TAvmw>
    <xmx:oi9Xal2jKsORoNPvqnmZxVCQjIU24_Irw_y-GUM-fbN6JWpi4gkFdg>
    <xmx:oi9XasOdOrLmvipE4RKM-EaWolMHv9A3EQxqWmCRwEi8fvlaiVQ9nQ>
    <xmx:oi9Xat1nSYSUq9kWEZXOHt-slun2w8lesd4bIIIzaRuUX70mpxEvxw>
    <xmx:oi9Xal1sLYLTuCQdGaQVUgguhyj-8hlF3rehbDhslzPHCAvgrs_UjXzQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:58:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0914f0a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:58:41 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:58:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] bisect: handle dup() failure when redirecting
 stdout
Message-ID: <alcvnm0xiOv5W0w_@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <2da452e39cbe1bd53da9d76fa7f7615c1a453634.1784069325.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da452e39cbe1bd53da9d76fa7f7615c1a453634.1784069325.git.gitgitgadget@gmail.com>

On Tue, Jul 14, 2026 at 10:48:44PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 15a2a30f89..801daf8c78 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -1308,6 +1308,11 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  
>  		fflush(stdout);
>  		saved_stdout = dup(1);
> +		if (saved_stdout < 0) {
> +			res = error_errno(_("could not duplicate stdout"));
> +			close(temporary_stdout_fd);
> +			break;
> +		}
>  		dup2(temporary_stdout_fd, 1);

Shouldn't we also verify the return value of `dup2()` while at it?

Patrick
