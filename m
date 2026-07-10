Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A43B6BF4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667358; cv=none; b=fB2I4vYCKt3kSwsTRwVcsQMw+bAJGbbtzncYcH69Ptboz0RavOet176BVwLQh7x+yllV19Cbm511DAOR2BTBjrigb7HUc69ILe2KCBRil9DbDAI9rWtvI2AG6lQBWO2cqsYqJGhj7kX9myDYI0uE9GyQYKMri6ufqeZ+fytCR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667358; c=relaxed/simple;
	bh=zwhfLm4hw2lZQQcbylTni2aQVkA5XCpUV1nBzwN9+NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyhzo7fE792JbUXm8hHZ7af5H+ZLYAHBSDz8DxaMrPelX3FwHSC4BYolj+16sbQDIW2eGPmwMwRRbiYFCP9vK7VZn03GhOjKMm+d97T18tTdJNvJoIdddFzbCZz7UTXFqsqPtWV0gUSdQ67arNeKkzkoi3Mb+3hs6z1o5JNm6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kqmTBUac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKSndQkC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kqmTBUac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKSndQkC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A4D914000F9;
	Fri, 10 Jul 2026 03:09:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 03:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783667356; x=1783753756; bh=kztKf2Vbph
	kuolVwuzlW0C5bihHAv/B2BIiApGJRbgY=; b=kqmTBUacRgkC/2cwonoQ+xXcTj
	80hxo5pqOQPeFUjDjWV+i3mwkg7LEDQ6ja8/F/73MdB2KTNduu8JHSRSCjKvLXVT
	GsS0Hc26n32kP2gdSk/7UttN1lQjb6y/Aak5Crs9KL94fevxaD6MQFtJwUi83g76
	hqkAWgiGVlOfe0InBntTI/No7jqAuFW5/muL+EjTkmJQANADmEWNYUQIfzUn5CZu
	96VgDgHdXx2OoxYcnqKe1HgcPL2vkhu+wsh2ndOzTSgADlhy4FYOAd/2YmYW/skm
	wuu4rVkhRLf4mpfKCnByCV9jK4m5EFN784fuKyWIKVHmR02WUhe/0gOaNOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783667356; x=1783753756; bh=kztKf2VbphkuolVwuzlW0C5bihHAv/B2BIi
	ApGJRbgY=; b=bKSndQkCFTnDjig7Kma4h+H4VsSfscpIa0so6sAnq9GowhrXwsa
	hqutVc5sJBNOXxDUi/C1BBdlpCcw3BBRwCCxTaN+If20mYOz2HvKOOMj2qXOmeDi
	Mn6y7LcCq6TPbAn9brru/oRt4wNwkeMInzM+l41NMZ5vKNyhwkCSyjcWSqSyYzr7
	gNP0fgDLviJ98w/t8tRkESl2kblK34puvWLBAnZTrK6kqeKgcTexShfsdlyWVM30
	ja/knfZFhoJfjRLoOg4i+21nByg4LZmp6ON+V48GwMegFvWg5NpQyv6f7VStcjou
	7bENGRD332OhNvYuAVoC+1875cfbPhRY62A==
X-ME-Sender: <xms:nJpQavr6SlCCS3pi2jky2d-v6b6c7VrQIHlQhUr_dnZaysOk0zgptw>
    <xme:nJpQap1uKuwo4S8gJq62TkADjE20tdqxItr08Bvf2sT7bF9VrwVJkFhmt7ihJz3Xp
    X8QlRdeTByX3450S_fwTPR2A3rzF8IZOHEvQBCvMNsS1Rlefr3p>
X-ME-Received: <xmr:nJpQauBvCPQ5uGEJyzZH1MCK_T5dFCxve3j5tRMOiNTPcOltOliuUANepAKBJ6KrN__IPC-Wc2eXMrcRz7JSieaypGTnuLNPYP7dj3QLQU26Qw>
X-ME-Proxy-Cause: dmFkZTFmTNRP0R48P5wb7cO0YdpXGGYfW63f5ZNyVaXq+93LM/EXDPDEGXJziJrlKzoLbj
    WNPjpGbW/ePmtnBZeUA05dbe3uxQr5J4A8WtN9ffBsvDc48ELSYvQd8VgpRqwunlfLwp3n
    mCiFiW+H9XlQzfv7oBRrS5qJ7ZTzxqJd7mpJGwYGgfTGicwWFxJFr9F2L93pen4SGSzqpd
    OP4bcczGDnrKUfw4wj7oHzWqtFVaYSRfxXC14KJ4zOr35EaHtxn5vLcF0iWY2fvwSZtjSX
    RSs2S6rURH/Zg24vduS7JAIAvEIzlprt16R25l7q6aNPVITAL6xaHQBUA1vTCXF0SrsMHR
    pSoGQIBg2G6aw1UxQnLS1//1SilmVOE/qiB7txZlnSAQKVRqY1fNLjakJauQvUoaaPx31A
    Mhvvod/O/cmYilKlJ0z+lIqQgz8mHFM6IxrHS6uaEbSr+4cjOZomwrNWOpADhgPE0qrnSW
    64zUm3o0/sYRURtn/esiJlCwia3r7rm37AwS4xusUGk2IVdrtctqwNOG4gmiZkr//KKgQk
    +OOxQri4rz9KrLZ6mVRC0AhrytMUXBN0jn6westB7d+boxhQ71iIpYAAs/mywqjDGFoQwL
    YAU7YQYxZAdkLKCXk/eQ8BKUopVo6/aQ03gh/ilsthlQweJGLoP79QAV02kA
X-ME-Proxy: <xmx:nJpQahdgYcizXVYwwr7d7lT9xztya00-cJM0buqzL2QtcvbOYzoRog>
    <xmx:nJpQajh_lvK97ABz_RhuZh5nCCfhOW8z4zfqpREhCVmh0iJhEYbjGw>
    <xmx:nJpQapotlTOeTtIQMvGJNasXM8flE9ybwBQD7Pf1_ZYKQGmN2cl6LQ>
    <xmx:nJpQajG-RkVZiCQusd-gTlgFDJbvVhIxSr0bvrr4RuhxQ8RZhv8JWA>
    <xmx:nJpQaqP7hvyrBqapuEZeDQ4foDS44vVHdz9b72J18Tx31lux_VRwpdXE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 03:09:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aacd0418 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 07:09:15 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:09:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] builtin/cat-file: filter objects via object database
Message-ID: <alCamGRrhBJgvMKQ@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-7-82fe014b12b3@pks.im>
 <xmqq33xsoupa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33xsoupa.fsf@gitster.g>

On Thu, Jul 09, 2026 at 11:59:29AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor git-cat-file(1) to use the new object filter option when
> > batching all objects. This significantly simplifies the logic and
> > ensures that we don't have to reach into internals of the "files" source
> > anymore.
> 
> This would become more convincing if you spent a few lines before
> presenting the solution to give an observation of what the current
> code does, e.g.,
> 
>     When batching all objects, git-cat-file(1) reaches into the
>     internals of the object database and manually manages bitmaps to
>     apply object filters. This creates coupling between the command
>     and ODB backend internals.
> 
> to highlight the perceived problem in it.  That would flow naturally
> to the description of your solution.

Good point, will add.

Patrick
