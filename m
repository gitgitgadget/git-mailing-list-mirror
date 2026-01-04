Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9C290F
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504758; cv=none; b=Ytz/kBPPg910c42gPjh7V80Q/hWP2ir7b443BDPBRKXHj3n2bgFWsljUVuDkuuOsL0WjtL2iCeg+ORaLa2e40yF4ySCbkKjgtnBik8lw3Ky379xct6Bw7WNE5QqwyNlu38IO/GOJxGoF6uPX4JkvkRUmNKVnjhR0eXds0JbVUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504758; c=relaxed/simple;
	bh=h9AA7p7/8sSRfP2/Z8oxSPWWtVJLGQlNIapWv2Fl9bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Df3dq7yZI/8i7uF0u+FVDsXtG0YneisGde1gQEj3kHdeYfXNd5Q2tV4lwXy6C1X2cEAc3TUbDyWUIMDFnSZn6lC4hOFBIyeMzgW4d4zVj3EUG/bekYzZO0KmR0OqegNtt+V0dMEo7M40jjY7GslID2xsM7nNtO8zdpPpK0GhU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ru7vjO/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0EfEm1AZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ru7vjO/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0EfEm1AZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 550161D00090;
	Sun,  4 Jan 2026 00:32:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 04 Jan 2026 00:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767504755; x=1767591155; bh=XaaIBKC852
	K2SQN/WxVYQZScR2EzRvcLme8dN4J+q6c=; b=ru7vjO/ADy6vaQ3p0IxettPAun
	UQqdnScYC/toJQHltxEM1xvOIY2h3bJedC68OfLvYPbc0803HLaDQstAZNnTcQ8U
	DBBaIRtnP1w70UAk/E64Zirw1hZi5mRRjpb4oLPb20ZKDSpDWIHoFjDlj9RUsU+V
	frFF+y5Ye39bjoNrSRyon67yMT8/Hu64KhyR5cyhK89+tSYPhLzJrpLQFdrK/x6f
	6yZhx+QvnYCRc/jvw//73cLYaYZt2ZJj+cwOTBckycweTaSOP1KiKNIWbfTWpbyr
	l/ubw2uA9TZQXK40UAOuVnS2MAMpCV4sxlG8Rgg7b4GuZtmOhFiUgJTb6kIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767504755; x=1767591155; bh=XaaIBKC852K2SQN/WxVYQZScR2EzRvcLme8
	dN4J+q6c=; b=0EfEm1AZmpDzg5fsGuefj8Q3qoLNSNuiW6b6FbKQdUVC47yTB9l
	hv4i3efobHmNwHIFUrw8nSY5zZdp1RnMxGXRVTHpHQ3S7Ng47iLtfgJPEE2xMQXs
	HHrIsGnoOZ9jVwbTLCko7dwv0W54KjjrXTm+GZJkQsInbzwvaGh5oRBSSqTHnRFx
	YqHSPSzvbvMHGkKu2pFgydmi/lbhll6BqYZ/zzI1k40ObRPVWw8YitPHw+TUteDU
	88w5+6KBhcYr9TQK6s+A9YyAj1wjVsqsgW6IUEUA7i2vD9NaVht5M2DO2KtegbgY
	KagB8xZY7dJ/n2we6q2ArZsOpN11kqs7TdQ==
X-ME-Sender: <xms:c_tZaQUUqFCJnVC1_yQJfOJzECZcXt8AljmZvJU13z_8mzEhKdD_Jw>
    <xme:c_tZabnEV4fBPA86osV5QA8OruzwdWxypK4ADAPAJzMRaEUaPuQFhLrWkOCpmNAk_
    KG-JPWSAOU9D-0VcbqWhIYqP2NBPoBej8PiDTpO800FKTmsQ15Exw>
X-ME-Received: <xmr:c_tZaZYGk7EIVrSlnEjJL0gkrwfui4549XES9JLgqqsQGHXVMHgi5jWTCCDj3HAbe-uUkVu7w6XGuGyL-vMKZZ-90Gvkyso2ffEFRKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c_tZaeOf7LLbhpqPY66qCRhF70GpXlf_46Z6SvCrDYLKBUg4KhKONg>
    <xmx:c_tZaWY767KHVEArSTPyccZJcptqpVUgszU3AhngE7NyQqZw-YTuEA>
    <xmx:c_tZaU08JAr-xrrAS3Qowmf0YgvM1ABZ4621ofd7dRf70C2z0_vbpg>
    <xmx:c_tZaUfugcQN2tv7vXGqnFJwooNDd-BJFWQFOwrfnSosShTEicKcBw>
    <xmx:c_tZaU4Ecg8bQqdusXs-QIPCCGtcN82tF3QrKHjH062_5MnkHupbhLis>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 00:32:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
In-Reply-To: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Fri, 02 Jan 2026
	18:52:15 +0000")
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 14:32:33 +0900
Message-ID: <xmqq4ip2ndse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (new_capacity == 0) {
> +		free(self->ptr);
> +		self->ptr = NULL;

	if (!new_capacity)
		FREE_AND_NULL(self->ptr);
	else
		...;

> +void ivec_free(void *self_)
> +{
> +	struct IVec_c_void *self = self_;
> +
> +	free(self->ptr);
> +	self->ptr = NULL;

Likewise.  Otherwise the code will fail coccicheck.

> +	self->length = 0;
> +	self->capacity = 0;
> +	// DO NOT MODIFY element_size!!!

	/* A single-liner comment in our codebase looks like this */

