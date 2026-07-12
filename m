Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C643ABD9F
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863758; cv=none; b=Jrr0g/Z2hs8C+vk6LDNLnP6ZDIl3tM2yj5luONtwutdfSt0O0gDIJYEEv3fY0vBi7ycPa8wWW2YnH33eSwzxS6XtkEuJdw5zD9CfuOTFHBaQpZmvrEk3aU+CBrW1D2WDQSdMcpitqKu8ZF3AVFaFHcKs3TKom2J+OtYSGe97LD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863758; c=relaxed/simple;
	bh=r+RI5Iu+lEbeKWSL8DkHBXLLgCbv8fYPCQnkK9m7RHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n+LATZ4wrV3mjkBeCT31g0BrNwcAPB2ENobsd75O0EyLHfS7QmO868d2tjqMMivFy95jEArOWm54Wlk6TFuO4dcl6TdDmCR2S4/f3ekkFGsZaxegFXvFsxHZFunJ/CLtQsiC9GOil6TDCSgZnSparDvZ6MvCMAwKZz9EuEDH3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0IWARyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ielmTJJL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0IWARyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ielmTJJL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CE75EC0113;
	Sun, 12 Jul 2026 09:42:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 12 Jul 2026 09:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783863755; x=1783950155; bh=mt92hvNXs9
	OAOUtxCZkHXu1FQIOUz/Fx9R1sEq4H6lc=; b=o0IWARyyVZZtFuERXfwIjSpu1p
	l/KnTyT3BUN5+IyfH9WxMQh6+Qdx1Hr1Kt0qvQI56SSTJOo3QJvfi+52AxKeouxl
	rY6uDjcmb3Lo6Y4u83emrLhcrLGbpy1OQ7MjBGdvsZO1Rf71n1RfDUQrtYUE/Nf4
	IqbMhcdFtzC+4u22KJ8PUUWg/HJ9ZkZX04tyWQUsH3EbZEICYEf/B1HETXWHPlLM
	7mD2t2p7q1GQjPSCQ1FEZVxNKPqDxtWBVrhgFguNBF60hQBcRvuSW25a5Y6l/I+H
	L4OzZhQkkl0Yvflh1KRel2fq3FOWRchBByaO+TnhmPtQrRa+ShNOylZLAtPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783863755; x=1783950155; bh=mt92hvNXs9OAOUtxCZkHXu1FQIOUz/Fx9R1
	sEq4H6lc=; b=ielmTJJL/AgQhiwcxvXeN9wOgsx8qW/aeH0EUUVQqEvpP1XK75F
	+aYNSikli891NrdxLhw5jW46YCQE25h7Ey82da8bF8Rr0yRevvSkBlAKkpqK6CVo
	iy3AyJKIZGxdqrZue3Ymw17NLo62BPdHgUEDsUC1vimN/xWD/lKRDGn4AP273pme
	WRSpghmZVrDOy+bfnF0Kso+IjY0mtSBgq2FrMSny0ygeYpipKpmO84ezAAW2wIpd
	azH/6OyZNcYSF1/OrTVvCFOVQz+5CMsyYiDoBPhalpgMg/dWIa1/fkWTt/mOIZG5
	M4lzAiF9QeK8UkXpzZcv31GeUipqQMDECsg==
X-ME-Sender: <xms:y5lTajGqtYOw1_YcUi43rlhsvZGh2UVJQnrtCLYMam3gjCtOtfLkZQ>
    <xme:y5lTapTWabJ-dFbKfLhjiMFILnjgMfNF6t0iY-y_-_-UZzOkGO3_z3gvoQLYVdAAk
    9dklCvRp3VQ1uU0wTSHo1eIPJBkv8PYSBbUmAL2i4Aa98FPJ1D1yg>
X-ME-Received: <xmr:y5lTagudgozaFXnlbirPXNqEfQ1x6jEl1kqJxFsvvC2XnP4qhbFh9PcHixaPAh1LfO2PdVAPkOCu8ghbF277WjvEy3qJ-FHenIGoheg>
X-ME-Proxy-Cause: dmFkZTFBGdfYKMLtVx8BxnNVBNYftpeXn7ZTF/TQCT9TQNIzXGHcbtgPDS0GbVJzYTZEPQ
    DcwP9+MpZNXxq02vkCy+QGsFjtpOhzDwdVkySWWxuNs4rw8DSEjwuVBqjc3HC0aV4fzYpL
    GYyQnL3VBY9f78lDlaPsuT6PCD2HTJmsHsOJhH8T/iVp6gSeKXHMAu4SpB3TyL/6WAIvy7
    ko2TkfxmTj4BnInjrKvGqDwMei6kWQPbQhf+R5f/xkUpMHXVR9ll1LTMQO2EDl/cvStnEh
    7qQZP9Ub/jPxSwDOS017Tk5qdkNT+AWU7AR3YHGYTMhBmbBHsQRvBqvTM1+wUipW+WICpW
    5zzNVfCOENl9q+BqcPtVjH187n3PWwyi3JANHRVddWyjT0x9fIif++svpXx3UylL/+TMB1
    VzdbTuOl/3Z2ybjZ9a2r8FuCpEP/YA62UjJTtzNjzM6DuB1gT2vGFZPMnSRKMnzVEN76Lr
    v8xRPRIADwAVKZ6k+UwsLs8BlO6dw+JjGuUxETRIfvv4FD+Mkxq2QIzAMmwHl7saMJqQK4
    pgVJgahz0eRrBJzHA+87GsFzHBoLKzGpKcGM07t+tspZy+S/6f9hCAVbKgKTP9I/n9+Fhv
    tqUPK70EMliLh+t3IjbkYJQvMv+c6xuVryGqC8eFeP88LtbcsisQXmaXnDfg
X-ME-Proxy: <xmx:y5lTahIBSnRvdn0-JGontEr8D0epJP4WFcmhdY5a9ycteR3WWj8CEw>
    <xmx:y5lTaln70-FlY6kudgGU7ShFu6WDzfTVKOzlBN8B8q-Q53Rt7CX2Cw>
    <xmx:y5lTaqJqDWPco7RosIVMtIzhotZYivYExRXzuZmhjvfvlUgn3iQKMg>
    <xmx:y5lTai7CUWr75RRQGuDffvycE7_BJdeqWqxr_IhSoLuXAswtycx5bg>
    <xmx:y5lTamQ6jogYvZMZLqJ23mJZRBymPx4NDtSYKRMvNc7KNqkmEaonLXSL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 09:42:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <27219.20156.438730.881821@chiark.greenend.org.uk> (Ian Jackson's
	message of "Sun, 12 Jul 2026 09:22:20 +0100")
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
	<xmqqmrvx86wi.fsf@gitster.g>
	<a8c72dcd-f8d7-47ce-a4b2-ebcd4188875e@howdoi.land>
	<27219.20156.438730.881821@chiark.greenend.org.uk>
Date: Sun, 12 Jul 2026 06:42:33 -0700
Message-ID: <xmqq33xo729i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
>> On 7/11/26 18:04, Junio C Hamano wrote:
>> > So, is there a conclusion after reviewing this?
>> 
>> I think we're expecting a reroll, but this looks like the way forward.
>
> Yes.  Please bear with me, I'm travelling for a few days.
>
> Ian.

No worries, and take your time.  I was just updating the status of
the various topics in the "What's cooking" draft.

Thanks.



