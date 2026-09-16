Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C054519928
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568761; cv=none; b=euXFzQKuQ7bFpTDU9udedIQszp1k9hmqzuCnRzlht3SlxrdBXpJxfXCisKxUARp9V8aY+EC7qgKfbILB0dafq7VdOdGMybgx+YZbhVmz5vfT/TNetMdFAc6DqgB+Tz5MzG2ykSX0pXKdTwYf2vmUKlf7Hf/Qfo7VkiTVhWIcpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568761; c=relaxed/simple;
	bh=3cATPuqI595eiRsLQtjP8iRqZokSFWAJ9WtgpOn6yuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KghBIHTp+qNUxYIuNaD5Q3swo7uwA6L6nA8xILZlFZyjobAG5KNDmhN3l9PVu8FR4V/DRzwKecdaeaUDSjrfD8kGuKVSj+MHUBt7VK1cCjIb1oYkJc0Dt5EId5Hddus8+miT9fzNpVG9RXzLeyvPMzcgtQd+X7aF4qiMhLNX3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n1Pvcd1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=po2PuAcn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n1Pvcd1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="po2PuAcn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B26414000AE;
	Wed, 16 Sep 2026 10:25:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 10:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789568757; x=1789655157; bh=IylYeONnzc
	+Ofa4qASvyPkiXgO5j3cChNlqHfNrz1qY=; b=n1Pvcd1SyWtXH3toli9R+d2Klq
	EEgVkHdtZaaMXLwbLgUUXiCEw8Ech1vy9a/nTdnWggnxNn0UZcFN1+QVmgd41U3s
	LWGpEof4ttlVIrhiRT/3iILPEGRq11PHJ11U+hTk4f5vnJFx7C7uSLv44Sw2jqIm
	lWZ0Uy/36tQZS3GnnHO4JosLorXJgY1ljr7AP3jF6zM8eV4tW+CNuCZ0tEV2NYy9
	w0XCY/xk3MW8G1VBDMNgKdykev4rA4KVjAidNiBBC7/JwNybMdqeqoleYVGk0+df
	70d5gBCxg0wP3z3aHy3qOEDUmt2UBHyGZQw7LPiXM4bHHuQLfXqxrmh1fgZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789568757; x=1789655157; bh=IylYeONnzc+Ofa4qASvyPkiXgO5j3cChNlq
	HfNrz1qY=; b=po2PuAcnHYjxt91kR3C48pcMRbyD3W7+/2tj5mPKbzztQk5+V2S
	lIuwku7ifjPVS07jgnWhe9BI9KHWnujn0piA0+WbrIfirFyJg/hPhebi53akShQF
	C377rG74vCnfYfQf0kMwORHvDKue6KRBtqb3hBMY3iO5rFSFaTibji9FiQJwT0l2
	ZbrUPMSNUPOLwx5jZrHpdWFTqfDevwMYhqDxeuJmgafuX8UWJaSdq3R3/wxRSIn8
	GN6gyWnz7/1IJPjal+1g2w+I3GONd9fl61nv86WgOZnIMYNSeVlVls82KZLbXnfU
	6jbkprtA9WoWcN+JThHvrHGP6OBai6sf0gA==
X-ME-Sender: <xms:9aaqagqQVcRA8E_V1hEXaJXaPzxYdcjVEE06W8hKO6MNcrNDFq1kpw>
    <xme:9aaqatoQPlAZMXgD7dFrbtZjsHgPgRher9JpGD73_81DcXK8QTmCiO5dD8S-5P1Ka
    mo8Zjx2HiXgorIs_XBB_dQaefwSC862c66ibycYGiil5WzVED6E7Slb>
X-ME-Received: <xmr:9aaqaqMWc_DWOref_NPQ395S-g4a0Tn6U8ftQ-NnEv4cAOmZ-9Ndv_u9LQSAW6CU3t-KY35YmX8jaX-z9KI2mLQ4O03s4LKA3xiT>
X-ME-Proxy-Cause: dmFkZTEJV2wfmYnbDRuUTXKR84mrIOnD/G9xJSPgDWyHW2U4H6IfLy21XnDQZkPp6z9jME
    /MtE8nRsDxjjBRd6KzIawXiS7T9GWzQOMFVqZkbb78GfWqP/cxAmTAzEbEuhmfOUE+HWNG
    +vecn7qXmq/O+7VbUc4LqPdESm1qVyAJ1PQLpQ5H+RIF0ImPgjpwcrvDpsuy0WGNOrv/LD
    vlVBQBl/fgA7sJJgy144vOXyUTBvvvoPrJ41Dj7dk9WhMzxp/YIJwCshlnN576j3myaH78
    hiZ7SwKsNCkVaQGCMHukEKe8lKhLMJJX/o7/TH5Rvuhf+Njc3UHUDFRNRAjLiET5tHK5DK
    SlozHX1x/BnqLK5OaquBAJeBuTC7GnRUOnk9mf6BZmJuIXrVf+ihXWtL0oXOWhCtfYu2V5
    cdPwxIEve9UgMEO6GbOHZiskgZTQF1r7GPYdAz/+Hjtr+eBHyTdfVKsGaS0JhQVafeTLQL
    w5/bNlPAim2gU3OJr+IAmrBVmrM/NsDEPIdfyXrcyLqBxKyqGZfAmPP7WIckLYBxd/O0ZT
    JzLydV3Ln2Ye66STcOOXR5GzjwRHVu0zx8/KV2ndi8Og9rrHEkDQyN9b0tCNU3ok7CE8m5
    K4plAesifpC0hllLuxi8CimPfw/sUmRsNm06YZgfYjjRv/KYDpLMHRiS0Ykw
X-ME-Proxy: <xmx:9aaqamwju9gqIm4KW8XLsdDrRY3zRkoKwiQBa7HQVtZExYMfLVBnqQ>
    <xmx:9aaqartSUmYE0W7ikIFePMCAlyHNPqdvKbXdojuKI_xk6Ey4Zgg-VQ>
    <xmx:9aaqan6JW0SJo8DWo9KrNgbreujZladSdUF62I0F88XvGTjvbCsG7g>
    <xmx:9aaqaiTSk-QxdUUvPRyGdo6BsIYvVYUUpP01HwkCUUU0gM4qAJ0wFw>
    <xmx:9aaqagxF2vxiNLezjl3trv8JX1LTVjRjK6i71dMRuJHSxT6jXGXrvPUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 10:25:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com>
	(Brigham Campbell's message of "Tue, 15 Sep 2026 22:52:23 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com>
Date: Wed, 16 Sep 2026 07:25:55 -0700
Message-ID: <xmqqa4phxogc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

>  # git-send-email --cc-cmd option, and in other situations.
>  #
>  # Usage: git contacts <file | rev-list option> ...
> +#        git contacts < <patch>

Not necessarily a suggestion to change what you already added, but a
mere food for thought.

An obvious (and UNIX-y) alternative design would have been to follow
the popular convention to tell the command to read from the standard
input stream when "-" is used instead of a filename.  Then this line
did not have to change, and the command would have allowed arguments
like:

	$ git contacts patch1 patch2 - <patch3
	$ git contacts patch1 - patch3 <patch2

