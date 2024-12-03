Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D66FC3
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203328; cv=none; b=RtXWQE+ZYz4FV1FQzC2TnFD48F8nuBpGzok6aYd/IRhUoVvaZE3c8k9RqIcXWSDUINYihErq+rVhHHrFPRqE1o+wWyVT6+RGLYNpGZ/Cg1GPQMP21zh6bVJX8b0F6YTu8z9Bnd1owcfEJzt6+XPlY1YXncnLJiVo+uowZPp+F40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203328; c=relaxed/simple;
	bh=KNNppHC3KPbKyrn1Wk8wjTf3vIUZOnqGVGQM/Hyxn5A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAJ+N7/bdbenMLiUjq9SQ1dvm323Dz8A6QmhQGHxZ/OHMNQ5FPde7afD9/kwlT8qPDgRTcBXKbYIUnbDeGtPjOBy031TD4QFQ2NhO4InZiP6o6N8yLJSlF4rVZeJQlE1vSydSA9Qg2WCcssziAExE32jByWeWmHaMtA96aH58us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aVzeIXal; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aVzeIXal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733203317; x=1733462517;
	bh=KNNppHC3KPbKyrn1Wk8wjTf3vIUZOnqGVGQM/Hyxn5A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aVzeIXalE8JTToeJNTIdug7ezEDJXpzQH+us9sSh+52TvNaVSb5E0iI4KTdoLBFPl
	 mietQian5dC5PZbb7dugVSmbJwQUmJGNsHhTfisYDta9AxJ6T8LtNSbr0gBOlRi6BU
	 giGgqAElcEW8sS/2e7Kh6+WH7Ujcw1/PHTo8v31H8yUZeWNzzD1OKVrlGSlgdINFa4
	 JrgvJTyqQt+cE7ejOuPfehAxbq9tnWGwGtS6iTY/Bmr5vGbM+UswIbGTbIFn5cFXkc
	 gOzf/yar+vKnNdtHYZSgPvQ/oaHRwUEmK0ZFXLOH+sO73Tyh1E0MxhdXGYbcIHsAr8
	 3UgzPKE7s52EQ==
Date: Tue, 03 Dec 2024 05:21:52 +0000
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D61TAOKLO2ZI.3U0UMVRVO14EW@pm.me>
In-Reply-To: <xmqq4j3le57m.fsf@gitster.g>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me> <20241129-wt_relative_options-v6-0-44e4e0bec8c3@pm.me> <103c7a4d-a74b-4381-a9c7-33a89d5db192@gmail.com> <xmqq4j3le57m.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 27e0c80f1048eb0ff8b718514f1ef5792a710e27
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Dec 2, 2024 at 10:54 PM CST, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Hi Caleb
>>
>> On 29/11/2024 22:22, Caleb White wrote:
>>> Changes in v6:
>>> - Re-add test for extensions.relativeworktrees config setting
>>> - Link to v5: https://lore.kernel.org/r/20241125-wt_relative_options-v5=
-0-356d122ff3db@pm.me
>>
>> The range-diff below looks good, thanks for working on this
>> I think it's ready for next
>>
>> Best Wishes
>>
>> Phillip
>
> Thanks, both.
>
> Let me mark the topic for 'next'.

Awesome, thanks!

