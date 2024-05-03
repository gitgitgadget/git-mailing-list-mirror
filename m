Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7DD51A
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765731; cv=none; b=NS7mtghXwPNbEwT2V9JF58h+Nm9zYE2i+pnRV165j+strfHnkVKNVBrtHuXfa0JcLSQ7gS8ce5NKz4UwiFiiTOf9Uk80I7TWi/N6JR/wDrE8ruFyC2PPm+Rm7mnayWbjUyM3h6SI3ZuNEug9edLECVDjl6R/AjvsUZBXRHT6XPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765731; c=relaxed/simple;
	bh=gryci+tPvsX1WM91AqrUl7rye8b8f/4NDrnCSNK6DtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrI2fX+rpafrhLbCyRpiuBRP96h62cQ1Lx1k637el31GZBMbVEovvHfcnogOIP+WM4ngStlDdQF+k26+bDb87nr7KUymqo46meHw9hbeJFPjI+zuh/61U2KjAPpQ2krCDWEeANqNpri7lR0jyLvFzx87nHkkp0eCASeLpCGp2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yIIl1aD/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIIl1aD/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BABDF2B71F;
	Fri,  3 May 2024 15:48:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gryci+tPvsX1WM91AqrUl7rye8b8f/4NDrnCSN
	K6DtU=; b=yIIl1aD/z2kC7xfOADSrhiXeOnE8ptow+3BPrJFMYfZz9jmaf4BPWQ
	27qytwkHD4Nrono+8xLLI9lvxaN5yPEbk2bB3hG4kMXDjjv7+OstRc/LipVDVooO
	qv9EyqXZha9EJwiFeerX4UKwwRQLn1q8hf8dkPzqf8tF8keECXDu0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2C962B71E;
	Fri,  3 May 2024 15:48:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C6502B71D;
	Fri,  3 May 2024 15:48:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  James Liu <james@jamesliu.io>,
  git@vger.kernel.org
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 3 May 2024 15:26:48 -0400")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
	<xmqqjzka7p2t.fsf_-_@gitster.g>
	<CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
Date: Fri, 03 May 2024 12:48:47 -0700
Message-ID: <xmqqbk5m65i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2886E752-0986-11EF-A59C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> different. Aren't both commands addressing the same use-case of
> comparing one version of a series against a subsequent version? In
> your response[3], you seemed to agree with that observation and
> suggested instead simply increasing the default creation factor for
> both commands (which sounds reasonable to me).

I think Dscho's use case was compare only single updated series of
his with seen that has tons of irrelevant other patches, to have the
command sift the patches belong to other topics away while making
comparison with the older incarnation of his topic.  I never use the
command for such a comparison, but I can imagine that in such a
context lower criteria may help reduce false matches of his new
commits with unrelated commits on 'seen'.
