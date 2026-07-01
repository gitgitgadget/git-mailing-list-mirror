Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180C299927
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888877; cv=none; b=ZcvNur6V0UiRahSEfF4l1+lnFNux2cBaC8XFHo01xl5SXkImYZFQu+Oayvg59oJNu0R/oH7m7F7qLqWulZlefNVQIq+txXXfFtmYigj8eauf/nkZpItnb6dg28O/ITDrxix2an5IgBe8yO2KEzvATkNti7uHCh0lj4ZdaQ4szFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888877; c=relaxed/simple;
	bh=U/8XBVEBOKLchn1kFdmH2HdfkocQ3Bwpk8B5bVCdELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0058PfCZAuTUVyV+Wd6NvpZzt2WyU9LKtPcjAGdyZIoLOBbQSmh/Hf7nqcOCxgnYi0rzXUpAEwalrXLolEcGZmdjCbrhWp5XqAHB3CNarl0mPRuyIgNtKRHzONcXWj1jcDoShqWU99R//qMjusnaUI5R3DDL/I+XpekKwoDULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GHMPwR62; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FV4iAHHG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GHMPwR62";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FV4iAHHG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEC101400160;
	Wed,  1 Jul 2026 02:54:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 02:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782888874; x=1782975274; bh=zWSdsvtCM1
	XLw3Uop2FNUGkinViE2sNvAKgp6sj+6L4=; b=GHMPwR62nkvfaXZztHlMwPQoEz
	SO0gluHY7DxocK5rycQFcqLwt0uY/gxxf6bW92TwFcMbD2EjSYIvi9PzLTvrU78l
	K7TmymSa49n8f5i0SqO2XmlkoSYxK1NjNwqn1klrRM9s+TZ8I6vmGzRdMi/JlQ/b
	JCfSpyyVohTFBO1xdgn36Jcsv9PJTZ/+S/krargoRTJZNpQtWeUUeUGM+0AM7btc
	eHEcPtrbgfAtjoPNMxVLz73Nz/HoNQhQBQjYslFsE2vVlA9di5gA2jqDlnm6JZVm
	ZWciMIpyuP3sqoIiTp7NJ63skEKC/ASKU6Mmu0G6pipUMfE8yzZHKJqTMOXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782888874; x=1782975274; bh=zWSdsvtCM1XLw3Uop2FNUGkinViE2sNvAKg
	p6sj+6L4=; b=FV4iAHHGRKpXZjiHcKga9HvvyNEyZ/iZSkvyQSvdJcGpYS7p9cE
	9iCZCitPTuDupgReM7ynOjNPImwl2s7KUXX87QyZUXzC4ihSD33z2ag2SfOQN9K4
	ONZwOma6TJn01oLPqaIlsNdZ8qiwVztAd0yI0blavn4FgByts/EgLzP5IR2axrjx
	1Bohsk7fOnbwdwfTFhJ4YDMoHQC1H+Gd3vUBpwROCepEG80wS3CoOKovggFH9BPS
	yrTFb2Ztt/6ElTOJCEoPulVvyYqdjlEOfKbCqp5NHhbFqXqYZ4Dl6HRC/Px6ejbo
	qmS/7Z2pNOElfPIomkJAgehPkj83J2viCFg==
X-ME-Sender: <xms:qrlEaqnILwD_lMhRmHM1U4Fyhh5zneg2utF0pIELXtcZpcgAiCYxiA>
    <xme:qrlEaii0GxsbH7hKoCYB87xjlD4h6uQiqe-McJ7U9rlcNm71wigOI1y_bkwE-kqQV
    rbaecv1IXr6P3KjE0xwUGLhDp9d5i_kTgA0M1ag5fBXZm2KKQUGAw>
X-ME-Received: <xmr:qrlEam15PHvdRH5f1nqRKpMRNnEgIqyV6TZC2wTKEfYsAoBrlyglZlaKvC8Ulnd8yRu4Fy3n5D1SL6igCl4NFm1MXFVI_b5yt74k141EOK4>
X-ME-Proxy-Cause: dmFkZTEu6/4J1WooLnDoGTADEWF6jcpOe23ftbagTIzR3XvgsAS6lNz2KA5XTLreMFTSfu
    R+LwvpR8yzE9gTSMT6T1+CzJB6lug6r30dD/fbyy2JThwjpaA42KVsUnvWFR4UUj4lvg/K
    W3cFE7JrqmikzxgTQkZT2jy7zU0JFYCTFAZdfiI25VwpCuWd0jj/4bhgJE52Io1RbQrp6m
    PVZFwViAMyZg+ZKYIuSi4UDQ6Oq/gIajegB6IfVH6By2OkVuJPAXUpzb+eD96/7vzGRa75
    p2vO1ANQW90GYGV2B7970E3tozIyBsxLsJZwRXQBGfiymY0pUKg5kzsKkPFrCdtPj+9oOc
    P4ONhErS99rhXwkNDDKirEGzZC0nucViT+1CQFEnSqUzouaICD12rdNuKTHe8SQmlv5O3O
    nkZmU9elgddDHNWu3UtDcmKCvxHfKVpuYVzyERKxP1KKqHuivrTS4aslh845+zCCmDutJd
    fCm9G62GLjnM5RVhTa+OJRYpqmQ1JBqzq3c7ISlLZCYMmFowEUkEIZs+Yt1RctZzKKM1W/
    86m2lEqQ91Qke754j1gD7yKmwpcngBWay7EPJj/BaWSqFJt9xAazhOHvtZ0pv8M25MnCD4
    oOPl75c2UiPSiPGBAarb/KGnZFgL664Gb7+j0+GJ+D3ZDItNpATbPLyVCPZg
X-ME-Proxy: <xmx:qrlEajIBoZZyoek1VFba_2AccGZyImTO88iVHZqKMRxkDGViXgIizA>
    <xmx:qrlEauzJkrMQWrv_MqJBFQxXrPtzIr3-yVJGGx2CiJqmRiqWt0b6mA>
    <xmx:qrlEapX84rJZqXPLK7PTkDfump2Q7rfiMN1Xb_reoJJFX4NTyWzasw>
    <xmx:qrlEamgnfLwn8ofHOZpt6nDFxtID4rpbQPSff5LXl0GjDpkGDHVxMQ>
    <xmx:qrlEahT-68Lb3djlpGDP560c4XEtx37-nNMGrBkvNsDnJHPerDVt5Lzy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:54:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55350ab1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:54:31 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:54:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <akS5oKGnbbimA5vy@pks.im>
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
 <20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
 <32bb1cf6-1e37-dc0c-dfb2-e78a30763342@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bb1cf6-1e37-dc0c-dfb2-e78a30763342@gmx.de>

On Fri, Jun 26, 2026 at 06:01:49PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Mon, 22 Jun 2026, Patrick Steinhardt wrote:
> 
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index cf341d74db..a8402babd9 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -179,7 +179,7 @@ jobs:
> >        uses: actions/checkout@v6
> >        with:
> >          repository: 'microsoft/vcpkg'
> > -        path: 'compat/vcbuild/vcpkg'
> > +        path: 'lib/compat/vcbuild/vcpkg'
> >      - name: download vcpkg artifacts
> >        uses: git-for-windows/get-azure-pipelines-artifact@v0
> >        with:
> 
> Please also adopt:

Thanks, will do!

Patrick
