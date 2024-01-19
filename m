Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E291D53A
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689957; cv=none; b=T1jGXyw9pt3hauYI569pHMYqFs96J3nZj2yJh5CZQoEvzmDfvu3Dl1X/PYIfNRGu20jgOwMsUNA0er3eQgd7vzOb45U/yLLbvn45hReelhrlEhyGMTEf3hVudU08kaHtRMVyUMrtXmLFjCy2eJa9I8NtV2e2kVvQv/P5Ra24m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689957; c=relaxed/simple;
	bh=i6Lo+VrG1AmVS5kEaK5Srkoi/tfOtDeGl4F31dhHCvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cz+K3pt+GoL7AW8zNgxn4w1wocrWpoNrFt5SSil4629aPjoOdAS9adkTfqLqYmx/Whix7wd+CMvhHxzrobqwcUVShkvRZDyoVSMliKWtSZOcnkJcKNG75zsmGT+D1Eoh2FwTfd1hvLU6dIZukGkhkcX18a4JPC4F8iSIlaAAA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NDi2yjRK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NDi2yjRK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 85FAA32117;
	Fri, 19 Jan 2024 13:45:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i6Lo+VrG1AmVS5kEaK5Srkoi/tfOtDeGl4F31d
	hHCvQ=; b=NDi2yjRK+uQLBUs0pfrWjNA2uLQxIU8SdAHRTvjydSX6GJr5ApVNYI
	Mb8Xt5DnldFvFD8gWJ0tH6UlF9ch8a+ZHmLf/1iS10zEmIFGkBqQdnQZ4DpoT8LQ
	EysdrsgG94c7RS+y0Z2pOsgZXtgQkblEUZeL8HwVqW3eXCZ6CSuHA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DDB432116;
	Fri, 19 Jan 2024 13:45:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18B4332115;
	Fri, 19 Jan 2024 13:45:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Elijah Newren <newren@gmail.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Josh Triplett
 <josh@joshtriplett.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
In-Reply-To: <4421D442-1BB2-4C89-834F-9E70F4CF360B@icloud.com> (Sebastian
	Thiel's message of "Fri, 19 Jan 2024 08:51:26 +0100")
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
	<xmqq8r5gfc3j.fsf@gitster.g>
	<CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
	<xmqqsf3nl2b3.fsf@gitster.g>
	<298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
	<xmqqwms6qwr3.fsf@gitster.g>
	<F214D88E-6837-4EAB-896E-DF8CFC315EE7@icloud.com>
	<CABPp-BF4Bfr3Hfy7atehHvbQds63+GXO9XPJAW3Mb7dvMcCkDg@mail.gmail.com>
	<4421D442-1BB2-4C89-834F-9E70F4CF360B@icloud.com>
Date: Fri, 19 Jan 2024 10:45:50 -0800
Message-ID: <xmqqy1cljh5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F86F0226-B6FA-11EE-B9BE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> I am glad I can pull my initial proposition of 'having both syntaxes' off
> the table to side with this version - it's gorgeous.
>
> It's easy to forget that the search-order when matching ignore patterns
> is back to front, which makes this 'trick' work.

The true gem is not the search-order, though.  It is the "last one
wins" rule.  Back to front search is merely an implementation detail
to optimize the search so that we can stop at the first hit ;-)

> If the insights gained with the last couple of emails would see their digest
> in the user-facing documentation, I think precious files wouldn't only become
> usable but would also allow projects to make the their choice during
> the transition period during which some users will inevitably access the repository
> with a Git that doesn't know about precious files yet.

OK.
