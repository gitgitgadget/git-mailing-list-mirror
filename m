Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE93630BF
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204676; cv=none; b=Yj2fV63myKfc8l6ItNLxKwwbKTrLR2OCo43RzlTL+0Oh+KRHaNxIdYIfWX5cpRnOO3Axr5/+dx10WAcnaeq0MurLJztQXwFUBp6yTvnOxLorPfeFphjT+YvCaOHUe6tdK9VPJG4CU6qQVV1E0izc4ys0YRvACsJZ1+dOzra1kI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204676; c=relaxed/simple;
	bh=sY/fq9ALhOLpk3YRWjoSJRQZd3ZWS8FtOoy5UfoXSX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6z/rUlKG1PhmUXxpaaA686upMxNd4HG5bZgvGdh/lEAvgzmjuAp4koqN44m0N+5jMcFCJJDzzAWdquU6FURBsqJ1vq6jjSL9u7YrzKjbGPc3/fvTJEt9Ujqk4safHMZIjCnxC5ANJLMxTJhkTbJnpFhV67yYLyhbId8/ysYYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XpacklFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExUT0jcH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XpacklFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExUT0jcH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 678531D0019A;
	Mon, 31 Aug 2026 15:31:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 15:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788204674; x=1788291074; bh=ktc4qYHuUw
	9YAMG1nSNws8Fo2uWnfxaQNJOWLn3QXAo=; b=XpacklFs7Sh0CN0vVzEDXB5Hwa
	OOd52uLOvOVT1XTlvnfTT58Hh0mO7szSEYpzADYeNuFbSE67vmyfHwrQ6HbdNtER
	zantj1FVGAuw8CWeFwOHT+JrCY4Ezu8kBm84rNtDtyPcEi3HIURz9AMyUkb4F9ej
	5EwXXXXLni1gLrtc9y9CY8huKqcLciwo4UXc23MVfFCMG/LUjms27lSPzlzRNgq+
	s6pC8Yvd7NUwCKhVSQ9DJWjoGxJWEXi47a1rxWjVO20KDFskxfQskys3GWcBw/oX
	qnmh3zVr39GTW+LwlMKiw7DOh8oepF4KCLi7yGAMGGka5+HCPPZtaBb5p90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788204674; x=1788291074; bh=ktc4qYHuUw9YAMG1nSNws8Fo2uWnfxaQNJO
	WLn3QXAo=; b=ExUT0jcHW4TkxbKcplbvbfYPnAdddsTdSE5ncCuwWaZtgBtcxYK
	Kg7z3SAdAgMOr96N4rt51S6kwLOclOtdtjzVMcpXxzB6G/f8xyHv00rVCZtSro1J
	+FaP/wliGlS1JOOt3TQHtms/jXPrD2japlSxFSkk6371A+SAIdc4wjOawLHOzedt
	fKRrXt2pTNunJSjmtV56Kh/VZPiNOEkblgX+3tQ/YZ2TsRpJ5NuvMzqtY4TlyxZv
	6p8kcM5ZbbkTYZiHScDgjLUpDfRTF9W+kmv6ukmWpMo9ARAuMygEouXST/nRhc75
	WP0byEHaF9ePMNsVnHEP1LEfW4u6NMJ6cBA==
X-ME-Sender: <xms:gdaVatH22yZCSlkKzW-pzV0rznnVhOXFKHPd1WWAJahvRakbfRV86A>
    <xme:gdaVapzU5aOQFb3Lri4OYpZOA5fZ0uyX8v72zZOlblMbtWS03w6oWVAIfZJjCkTtK
    mNydTbHChN-Yim-onfIHgRJl06QqEPEqqrk4sgY7TN6fHUztOjxIQ>
X-ME-Received: <xmr:gdaVasi2LcICHf5zmSpLuPTExK8e9Yy59jyVksOTfXLgO2JHNJ63jjlHLjw1dWDmZtlcyR4rBeA-AZ1DGbBzuqrumk1YdiHxQg>
X-ME-Proxy-Cause: dmFkZTFi5Saqn1HKAEpV+NCrKEONAHz3exNH8JU810Hlzc7jyS676GJaEm6hgRKbPXd7ec
    okU9d/eIHIIDj+mDub+UOiiAcwI9DlJsMf+atzg73OAA0H/uOjJFYX4iSYty8ba6Mpc7Qx
    iodXvkuGjaxcAgo7rjg9LwtBLxgegKl6eJbSl3/iS1gIMjU3oZDlvYSdF+BKsHund3wBTY
    vjF4Q9Ozd1rhIIs3rU/I7XkDX+bteNatMv4n4hCsBf2k19IvZD3vqwXg/CfTTfRWS9CcOJ
    /Z1+YvWsEqZ1OiUyjmQVuKMJsqy/nau8Ko/vELiVLr+WcJL+Wxzgji2rvDSiYjUGrl7dJj
    a9UVABEV1d4yPkj+aqDEW/aC6KYqv9Alfkb1sQWIi4TnD0Xq1QIS+tjRmT3flFMssjVi5Y
    AcPBWQEwpI2Q/fTW1OKDzpQzXRCDtFzb3Xa4DZxMVOzZv5EK8a+tmuibpfYmeuC7waziAl
    xHiluVWYgXwUKaDCCxpqJCzSsU2QwOhWdqZe5xee8MiXzs1nDPySiZ+eQCID+wxcnSzOGF
    amrLV6L4wZEq4MSWP81JQ1JawNRHExYldrhNFnb1yx764arnaF7XKyxZH09AVuNJiN01BL
    jG7bDmvUrjc9U58vR/sGpLmNaCv/Uu+NxfNP4cUpYdymjIX1rdN+j5530z/A
X-ME-Proxy: <xmx:gdaVaswG2ZiR7WfG9X0HHTCb7KIVseQXJkuFd2k8j1a-p_6bkX-KpQ>
    <xmx:gdaVanKo9Kaeq4Y2vsWXWQ4DQPpvfR-SrS51tiikXE4_K3u1TP9vOQ>
    <xmx:gdaVarSlKxU05kMGF_TdeTgcnHBuBgyuigwrk3RUyvLCXqfj9MkXgQ>
    <xmx:gdaVanpPOIJo4ANcQjrT0vxgLmdTyJw9fDVt-NUeAGcVF3U7hnbg0A>
    <xmx:gtaVarb1s8J4hcNtEOVTMYk2g66iPb37UX9BKRubj4K9CfVlAWcvvlb6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 15:31:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #12)
In-Reply-To: <87wlt6wbxt.fsf@emacs.iotcl.com> (Toon Claes's message of "Mon,
	31 Aug 2026 17:23:58 +0200")
References: <xmqqy0dp24q1.fsf@gitster.g> <87wlt6wbxt.fsf@emacs.iotcl.com>
Date: Mon, 31 Aug 2026 12:31:12 -0700
Message-ID: <xmqqy0dmulxb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tc/replay-linearize (2026-07-28) 3 commits
> ...
> Sorry it took me some longer because I was on leave. I've sent out v9
> just now.
>
>> * tc/last-modified-bloom (2026-08-07) 6 commits
> ...
> Rerolled v3.

Thanks for both.  Queued and pushed out.
