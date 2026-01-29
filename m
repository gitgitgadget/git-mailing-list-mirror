Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F02C11E6
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720337; cv=none; b=VkgXlSRppxW5aXQ8dDrH5kIl/5Us+aQdnh9QaabpatJR+A3j74lDnD35SrGvVkkQXBkIHNfqF3K3aKXhSuhECXm9z1moReg8Esi4ZALbLQ8wFIBKsyjXSJWFxUxdqM64X9FC7cWd0qwcPPKm+ubaEDtxk4NNJgqGPatfAUlFGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720337; c=relaxed/simple;
	bh=5hK6G6h2m/U7occfL/DscXe7I/an+n72MbiofVYq8XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1t3bAPNovN7/Zmk4lUe7ivTYbgXUMI9h6dpahqc7JSwYeokHzoamU2ux/fcIkmfrPmn8cgXg+jmHAr6E80lpqmv4zKCC2N9xWtkvLEMzxwqt5NDbz6AuDbCsoXfr8NVuuUqiBVSwsSP682bt+ckYRR91EKfInComsVjct5ydZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2vi6sNgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dR8DhCq+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2vi6sNgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dR8DhCq+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 175A31400177;
	Thu, 29 Jan 2026 15:58:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 29 Jan 2026 15:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769720335;
	 x=1769806735; bh=GVLIbV2wqe/dybBKOF3Xs0+3FNfq1OKv6IEZYm6w3iA=; b=
	2vi6sNgfSpXzDQlko2Cf1WTFH5d1uImairTGIIDBqLRNnFBJkTqLEpX/NuGEBppU
	9GPhNyqfAWVQ3V/Li59jtk21TiuwdjwCPKU57ereSVRam1wZW7caaifZcVzuwEtB
	1SiPAMKQ5isPJALxUxYRGRugbu8NrWgO375ljFrQbVMamY/WRgwuVorfJC7ckEWo
	OvyOL3QNcZnbrZYCrNoCKnO+/wGwbF+EPcyUnqKb959c/dY9kKiZRwDo4s/fgeD4
	l12OaaOVqYRX1478pXQa/6UzmuWvBQ7mgK6yGe++3gnbZvQcfWgfu//1R7KYRIWF
	rGEqD+mRSNBDEkclR4B1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769720335; x=
	1769806735; bh=GVLIbV2wqe/dybBKOF3Xs0+3FNfq1OKv6IEZYm6w3iA=; b=d
	R8DhCq+KKASpV9+yacMlAAGbXJKZvS9EdFpPCqdGHdMRQers8Z+TdJBV2DCSUXJL
	IOiKQ0Q1F44u5jacvymCldRz84Lx5N3WPSTEaJ+1JCI+ylsBOqhuVArA2PoKOWTn
	0NzQmN1du8tC4uv8k34xVQGmFPiw3y02prMpbVtFwl+nLU3fkH3IEFUMQ2W7ee3X
	QTpEhrctwY/JTjve1+DN9aYALr9JPUfNNziNuH/5xiBw+1CDlBvnaw4vsRxqoO48
	+qFMUP/OuZIp/ZTFaaBI5VoICtUfPjFzhNTYE0Ni0sSkHLQkbeCWlaeCZzQJOKP2
	3Lzugq7gJ5rzP6q3eaSjA==
X-ME-Sender: <xms:D8p7abZrEM03eOPPlfka5Nb_inaqqSjZ7qUFobbvd2jMuaEyLwqYxg>
    <xme:D8p7aRRHuEvxNakNuKv4e0U95lrzNIZBLUgc906YfZvqlU5hnBJEbE1eqO4QLEvUO
    wx85KyuWyDze4PyG26lGWgg7cASWO9WSUxEpUN97SZgZBg-asct1w>
X-ME-Received: <xmr:D8p7aWTO1E5v8ExB5KdYCQj1cRLk4_QQwVYE5Pd9pOu-8ww_idFRmp6iYa9Lktu6gazSz_dJxboFtGs_w2lfrpz0FiLpudYD8uxiAmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:D8p7adTi2kORGR31p8e9ZrBDsL8tWw8oPXd3CBAEsnxf3jPOoGfXGg>
    <xmx:D8p7aT7JgrTup6NPq6pqlMG6fxc54nv-pB5lsU2BaskuFue_hNJxmg>
    <xmx:D8p7aR29oakvmbm6g5DZkYz881vDa_vIqC24O_R5VBRjs9wO1BDIzg>
    <xmx:D8p7aWDbulx8m_-99SpGKYPUxJdx6QdDnX7Twq4mFiyJJAr8VQZJ-A>
    <xmx:D8p7aQiWDXlTZFdVGbkX8NFUytUra-nuQIrij5QNmiO-HG9AyCkMuk_z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 15:58:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yee Cheng Chin <ychin.git@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Yee Cheng Chin via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using
 histogram algorithm
In-Reply-To: <CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
	(Yee Cheng Chin's message of "Thu, 29 Jan 2026 08:53:04 -0800")
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
	<xmqqikcusn8p.fsf@gitster.g>
	<4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
	<xmqqy0llk33y.fsf@gitster.g>
	<3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
	<xmqq343sjn4x.fsf@gitster.g>
	<CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
Date: Thu, 29 Jan 2026 12:58:53 -0800
Message-ID: <xmqqsebo9lv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Yee Cheng Chin <ychin.git@gmail.com> writes:

> Thanks for the review and sorry for being a little late in replying.
> Aggregating all my inline replies in one email if that's ok.
>
> On Wed, Jan 21, 2026 at 12:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>> So the idea is to remember the original values in g and go (the
>> location of the group in the file and the other file) and if
>> shifting up and down changed any one of the four ends from the
>> original locations, we always take the fall-back route (if we are
>> doing histogram)?
>>
>> By the way, this appears after the if/else if/ cascade that has:
>>
>>         if (g.end == earliest_end) {
>>                 ... do nothing case (case #1)
>>         } else if (end_matching_other != -1) {
>>                 ... do the slide-up thing (case #2)
>>         } else if (flags & XDF_INDENT_HEIRISTIC) {
>>                 ... do the indent heuristic thing (case #3)
>>         }
>>
>> Am I reading the code correctly that, even though this new block
>> appears as if it is a post-clean-up phase that is independent from
>> which one of the three choices are taken in the previous if/elseif
>> cascade, it only is relevant to the second case?  I am wondering if
>> it would make it easier to follow if the new code were made into a
>> small helper function that is called from the (case #2) arm of the
>> existing if/else if cascade.
>
> That's correct. This condition happens only in the 2nd case. The
> problematic scenario here only happens when the opposite side is
> non-empty. If the opposite is empty (case #3, where we run the indent
> heuristic algorithm), there's simply no need to re-diff anything
> because diff'ing against an empty hunk is pointless.

OK.  In the version posted, it appeard that it is possible, after
not doing the slide-up thing but using indent heuristic thing, to
fall into this compensation codepath because the new code was placed
after the above if-else-if cascade as if it is an independent
clean-up phase.  Encapsulating that new code in a helper function
and calling it at the end of "do the slide-up thing" block will make
the intent clearer.

Thanks.
