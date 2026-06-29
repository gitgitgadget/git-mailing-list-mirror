Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FE395AD1
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769980; cv=none; b=r9OBio57+IT4DG0Q/2HXM278qK7w+VVGbJd8utyasdU+DAqhFBhadoy+oVtcJpHODgIiBEOfr4pxdNXB9aloYS6t/vSBAPH5+azMOOLBhGBCM/skbmBKPmds6KeyXsocAHCGrm6zv7aQEQrzREVWCUv4/beGlXN0bNa7g6+kqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769980; c=relaxed/simple;
	bh=uEKOL2pgF+5ZMrg+HizP0UCERE7G8wfvtp5OZV/87vM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUBRttps017bCAJ14JZyc0hbJrtvafrkTBLuCo6jNEmBRMit4unqsJukKkuecGRq0nbye2LzayX0LgdQGWPhVOsf7rmJ/xhKt6AmN3ITkBwKTu7yMBGGImHcM9POL4c7m575OCEeyLqxzrhKOL4jPE+3ItWLvn7wviE40k9irb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S4GYxfqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJ2Tyqcp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S4GYxfqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJ2Tyqcp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BE0B1D0013F;
	Mon, 29 Jun 2026 17:52:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 17:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782769978; x=1782856378; bh=tAasCXz7ap
	l89m+6bo825lTAFgairKAcFnnBhpTqK1A=; b=S4GYxfqaHeJu9pW3dpHRafMoI8
	Io8x82grQawPb1z7IWBOWOA2V6waJZHAmYlH4PRJ4qWdhnWnU8sAYDgIzqyU6Bsf
	cTTmkAMfJF8XjJDcSYjjhVnAlW+RZksRrItfhMoHuKn6O3JKIfHnTIKU2Udwll5f
	wTnhsOtNZ5v3sBMkJl+kIkYjRBMCDjix674c+06vl5+t0VRu4+OJgSLRUjzXPraz
	Ms21HET0lSxuXA5tVIF9WNtE6A71S4A+KdVx0NjMZ/DPh8x2Ed/0TSm4An9UAEng
	6Ksc9AnLioNEZBqeKsvleB6wR7wwPV3XtgAAskoYgy8/yQR1jmDPcQtjI5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782769978; x=1782856378; bh=tAasCXz7apl89m+6bo825lTAFgairKAcFnn
	BhpTqK1A=; b=lJ2TyqcpZz9F9dHNaSRZdWgEg9bI0hkzQqVpsYBn56IwlGVzWz2
	QblaCC9CUCpVIoC97H6P+HJTwECn3+wB20kHPN/024hhizI+63PqmFRAlwMh0Ldg
	0sOlidcybWZWZlu/5wJHhr3e1SIN41dbfy1TseTxxOc5i7M8VZiEQnNkO9mPwvvo
	I80TZ1+UdJlrT5XMDwKQq9XJEV7jmeA/MPnwnixdEypWwtVxvLn0dKrFXMnBDpqn
	6qzaJDXFivd2xOo7SqRgviwJc1wk+uqIhpE2sbe8KtI8DLts2614PnfCpOsxbF/6
	VMuNkVBEJqybB7fFYsc7IqJBDRAEPXhovOg==
X-ME-Sender: <xms:OulCarcSftBWr_Eg9kGPrFsJBLYL-omdMRYqFgnkk1zXrHE1AkeFTA>
    <xme:OulCaoMiYWCvotshlgUHc5XHrHIQk-n3QYaZ4a2Kdn-qNYcW2zWYTpgGYTVSVpu_C
    VlixrUq8EuksCzLOkIxtUhFvxm9iCQnWO-3B7e0FpyTJiLF50HtmQ>
X-ME-Received: <xmr:OulCaphxCyf_cPGRjNJpS0DMt9q1Fi2ro1eBguKv7kTSHOTr_SknxiY3wWBRlHc6Kw4kPOXkDBle303AKEpKXaG99oSWMZwQxLcVvac>
X-ME-Proxy-Cause: dmFkZTFWqkcU18MoT1iXIqp7qSn2yEEGsk6PIvo1pNbkPpGpraLiTah08mqAvDUWEp/IS0
    tMChDVkYyjI6KIi/2pnpDYgxxAWeXgzTtS3jWqWN9nT5LR/VHeHWGgtwPpFy2Pvg2YDxl3
    HCoA+ep5Xpg8V717QgqPvh1PhyvqfHSo26elHbXiLFGDu9/9xYepDp0iuNPI3a1gMNmBFT
    6Spdyo1ZhaYhFAD0RhEQCk+zpHCbSq4PnoUrTFeAXZvvaFGLBBeVmUrBvR5pR8O+rB/Ofr
    DpBtBvRrj1Q4TMdIBaMgt7CkLqqH/YXWBjYiBfB+LHteKvYQ2loGXlf0QAqg1mA+zt+ajq
    9YuTe66ZTrGfYm+shmgvST0Z/MHbU03r1CeQihTXZsk+GyuF+x/PCfKhbs1NPVnJ7vlUV5
    zS9K3+1iJvfN/zCBLdoNgAo5eyxZ5cQVSi1o5FpY46a5fL5/Qez79O14h4kbPHNmu+Ydf9
    jyFr9eJ4QXKYjQV6VTaOZTL3rIaYwC+IvLJPkDB/kN6Sk++YBp/iC71u9LFl4t2rvCOO/h
    mTent00bQtom33Y+mQT0SiKGlMfiJrm0Mql4uEzyJ9Md/+Fu36aybGz306RSglkWN7+HSS
    ioG5qTuTrO/bcr382K/31yhasQTdB77S0XeXdhbzYF8YE/lTtA63/SL2OsWQ
X-ME-Proxy: <xmx:OulCar37LUnYdOulCRN8AczjZuS9BfQBFA4pVs_zpT_H57sPduEuFw>
    <xmx:OulCajgzPR4bpDIMx0SiZMWDj8slEsjZ5cMHEZ27JABUIWjtUEs-Ew>
    <xmx:OulCardsSfL54NI__E98lwnVvcHrIkcOXzg4DbILY1y9C0buIP1SEg>
    <xmx:OulCamnHjpPcBLRzSQiFMOd9Jjbc1du2s98l_7x8YIzyk0rb6zGssw>
    <xmx:OulCatCFO9fCZpOso7kAlfJpiVORLRFzpd7q7Wwh8UZDBOvZJTYpxzZZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:52:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v3 0/2] completion: hide dotfiles for selected path
 completion
In-Reply-To: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Sat, 20 Jun 2026
	17:55:54 +0000")
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
Date: Mon, 29 Jun 2026 14:52:56 -0700
Message-ID: <xmqqik71t3nr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The completion helper for index paths uses git ls-files rather than shell
> filename completion. As a result, leading-dot paths such as a tracked
> .gitignore were offered even when the user had not started the path with ..

Will we see a hopefully small and final update (v4) to conclude this
topic anytime soom?  No rush, but just wondering...
