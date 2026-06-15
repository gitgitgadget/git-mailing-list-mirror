Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F1383339
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512646; cv=none; b=ukVhP8fOzo15qiW7qforBBhujW8HWYMkCXDO7GcjLWIomAuXojkoqUA9W2ciGUBkxSpy7XIL9bxIkOuZ4kueHfipGuUzhBxlmTl8ATBYM3Kq0U4H0fGch/jEBe+2L05LsayBnLyf+5KfM+cRvLkaEmmox4MItGmC3I/TETxVQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512646; c=relaxed/simple;
	bh=BPjJLDTCUi+i+DNcadxUBboXh21mzmiWaWTKscThj94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6XW8TLu8Rlffx2p/BQFWxNUh3tbplTZ5TVZBKwRBtvqI0/6O71Sjaq622ylSyygCIzlg7/MQHwYgCE+Id6MRpcXIjO/SE/Rq71grU6x13JSJqLZA+HI3ljoh1kiYqMPYc2PU95px+/HpMyX/5NuegV8zGK2WjtKWyFWNUqSq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=af7V24lt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geKQVzkv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="af7V24lt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geKQVzkv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33D8E7A0176;
	Mon, 15 Jun 2026 04:37:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 04:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781512642; x=1781599042; bh=141bmvxSqq
	wctGGBxK03jnKVXmRzAaHXaL1d0xp25TI=; b=af7V24ltibCWF2awFpRSMdz+ZK
	stWOtsVDRBpuM3Mbn+UCDoVKAwPflXFWmmWme+FdnNQXTuQEXuLD9NuGph31TjDm
	+jIjMH3CUbkNPZVl7+JI+qOqHNPG4Etp8pvpgPhIBQfr3n/7j6IcgVp492m3e7Cm
	3Tjl+nLBEN/8k3XyjIc3jyzd/s4L5frWCpVeVMVtj5WnHd8iLyTrmEgGcYirNQC/
	rilPoBFzwxQyyPK3cqmVPoqtBUrcFR4zhRo8sv/ho0Z/NI0rhuhrHjSY0jJ17xAI
	DmX7FKdtyBd1O5KQWkW4r2uaBE66dXknGeDTw/H5EnbrNQOP0ltA0yAtwauA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512642; x=1781599042; bh=141bmvxSqqwctGGBxK03jnKVXmRzAaHXaL1
	d0xp25TI=; b=geKQVzkv8RkzaNrrGZjRc28lmmH1MdQJswkwKHldR04Su8MF+jo
	HrAVFrHhi0VwqblZO8ygYkWBQkbgZL0mq8l+KMGWuorkFnS4gHOTyvZXPJzJrKZ9
	1PLpYIJZxSB/B3lgkx9Wu/Uag14ed5x4HXkyQ18cpkF+D89Q9Uwhu/ch8tBnp7CK
	CYrjHuo/OQCoLgF8yviHZ4mROUc5FEqUxRXtNj4KF/wyE1+NkcxkVdsQbbOQR9op
	rFvh8FDC8bcyaXaCuvsgMk6C/FQOE9KmppSbvtr2iHMeGHrCvWheq3hWhnFQJ27v
	HkwuukXMpAdfDQ2bOl5mIRprAcd6NiqaK8A==
X-ME-Sender: <xms:wbkvaiUThyzDaOomCaiFmaH9O9D3uFr5CYlt8jlzO1TYF3ud-KZrLA>
    <xme:wbkvamBcpL7Dl4zOfpMbKtCfwTSwj69oX2iL-BWvqCx5jumFHJ8lhh6HsTLj9z2Hu
    gOZyHAzZTVd_ux1rQ3bjan6mH8tkz65jqNvyv1o2bWyWNCqrrlczA>
X-ME-Received: <xmr:wbkvajyd93PeH2udyXZqzMj6ajUwzBUfrs-lxsnt5dHjCT8Cb-Ge3jESklo90GLqCNGp3XcDRn0yxWzmhvXU6YYeduw-3dHpkMZO3H7kKg>
X-ME-Proxy-Cause: dmFkZTFqRGv5BEiS0BniXxYlelXhPhhcdY0WUQePTpB8XnRm3qvarROREyDeyxzVd2oMaJ
    LrOloOjDmJp059w6ohduOAwwB+IAXjfeIrafXRBUYqw3vBa7YHdkDLUCQ1eHU5lNu+TTJB
    19Dfv6e0xXfBsxLhyFk8XTlqLUf6+mwZDbVW0ZdP3OfJbgGRdHcnYSd2atEJd8D3kLdJDS
    hGe+9fb0gLseJOFV22FMmgz9b8MkuShluRa6ttGixDGXXInfSgF0YuiJ7hcmZrYshkKfkO
    3Ay2NswXAxUPAGz1idyBg2/1qbKrJBBBAbCBK4jVusSC4H72P93ovi45wsqYCqTJVYpTUY
    1uZybGC5tAdg2p5mJJIm/3qZEs+Y8oPV0eVRM1m+h8mSNE82lkSJgDzZV1FXW4FaAxCk7W
    xZvCpGZgbyj2apvHb6akOEz0qGiHx3Z5Ok4Ar2pKPt9dQVC52+LLVmUSCb2FcYoOj6/mU+
    0eGCAX2h/drX8iq08m44VUFW2fYHl82c0UYlR7HS83eEpN5FeTcYa6cJ02Y86/X4lICo8Z
    9OA9P31RARrjPu6bgs3UNbMxBJvd3FC78Z4iRqNo0txyeLDgIF1B1bZrpVV2AnAubo9j0Y
    WQnzFyPblLyG2mUpF5eVeur5myCS0gGwm0XBCjKbO14Df7w2XBoPAGuRx1Rw
X-ME-Proxy: <xmx:wrkvajBezLvya5j_P99Pmv8l_7WPv-M-ISiXi0mpXWJyqigcRe7UAw>
    <xmx:wrkvaga2RHHU32znJU24NOmLcQELNsx4-pfbt_Sy8uFWv5zAVthUPA>
    <xmx:wrkvarhl5AG07EPBV45ps6nTCcJE9GJWumxTiqbpTU87MK9yCrwb6w>
    <xmx:wrkvai6pFcW9wMGuCIA9lKe9tDJGUfSvuX2XXeJmVBvtNWaIjMnaIw>
    <xmx:wrkvaqf6uqJOnCAfWy7Ncz4VPxO1OnHVibTnM4gZSWQZP3yvIHf_AjWU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:37:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ea90409 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 08:37:19 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:37:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Koutian Wu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koutian Wu <ktwu01@gmail.com>
Subject: Re: [PATCH v2] gitattributes: fix eol attribute for Perl scripts
Message-ID: <ai-5vfY8D84UhsB4@pks.im>
References: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
 <pull.2151.v2.git.1781510039164.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2151.v2.git.1781510039164.gitgitgadget@gmail.com>

On Mon, Jun 15, 2026 at 07:53:58AM +0000, Koutian Wu via GitGitGadget wrote:
> Range-diff vs v1:
> 
>  1:  92ba4d499d ! 1:  f4b4ca30c7 gitattributes: fix eol attribute for Perl scripts
>      @@
>        ## Metadata ##
>      -Author: ktwu01 <ktwu01@gmail.com>
>      +Author: Koutian Wu <ktwu01@gmail.com>
>       
>        ## Commit message ##
>           gitattributes: fix eol attribute for Perl scripts
>      @@ Commit message
>           Use eol=lf instead, matching the neighboring *.perl and *.pm rules, so
>           Perl scripts are checked out with LF line endings.
>       
>      -    Signed-off-by: ktwu01 <ktwu01@gmail.com>
>      +    Signed-off-by: Koutian Wu <ktwu01@gmail.com>
>       
>        ## .gitattributes ##
>       @@

Thanks, this version looks good to me!

Patrick
