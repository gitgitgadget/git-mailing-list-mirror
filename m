Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA253E13
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951073; cv=none; b=a/x2OqUSrj1zTmxMVs0IqdGyfOMvQVV9oU/EhaxAgJy1FdtnXy2eQDpB+sxqZCt58wR/2NDJ/p9nXpMx+hvOk6V9dL89zZpTqu7v8jba0zo1d1E5C4dF7bt/cchkKdjVNJqCyRmeu+3gLDMNF/EYNxowitspBn76VThJnM2rgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951073; c=relaxed/simple;
	bh=/pNScnJJXi8dvyDkpOzBwaYg9X8eryLcFg2VdErKUmE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=R86KeKIGVdJwRs/Tb15B8UYn3Ifa+uOa8Ghf+jkRK2BqK07Wcq0XvcQ7jdChGa6SM79Rbhvz3u361FdGijN7nzbAzMIpIAYuJQmlhvYokudDADyHnNVqSbB2UpNsFM9WnIcPwpuQJtF9Fy3X5LTNMUPe6lmzaULFOFRAp6VdV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=n7u/8dis; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="n7u/8dis"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710951061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lmTslae0F+tvd6kEmDkEYChcXKxUyoUoDMRqts3t1A=;
	b=n7u/8disHQd6z7TK6cbww7GK2WJmkdHE3eDtn9/GxhTXYu3HVHgX3/tMpBp6Yu6TSXbuaD
	Gld6Sb8fZPhpZjbG1PsOv2j5uQJYjVvRL21Mz/YNiQCJv3TBtjhN8XcL3yq5JoFJXxybxB
	6ILb7crf0xngGOgxlBuHa7Cp41odgaxCQMDacAXk7SeuWqjyQ0J3374HwA6w6NLvv9VD80
	oscE+e0HYOH8DKkYHA6WITCoQdZ6ISMkOhjhVm3DUIyHqRZMc6DknJh0pbtfzssiI14MeD
	JKLotNVfJJ/ymQh+19fBHad0JgzVjRz7tvWvguH+JIx/15CQdcOMjY+wEivGbQ==
Date: Wed, 20 Mar 2024 17:11:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/4] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <xmqq4jd1j7tp.fsf@gitster.g>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <92ddcd1f668906348e20a682cd737d90bb38ddc6.1710800549.git.dsimic@manjaro.org>
 <xmqqzfutjtfo.fsf@gitster.g> <32c4718d09ff6675e37587e15e785413@manjaro.org>
 <c5736219057c73a3a344237257534bdc@manjaro.org> <xmqq4jd1j7tp.fsf@gitster.g>
Message-ID: <1b475b48a88be57efde6d9fc2d8d50c8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-03-20 15:28, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Oh, I just saw that you've already picked this patch up in the "seen"
>> branch.  Would you prefer if I make this change and submit the v4, or
>> to perform the change in the already planned follow-up patches, which
>> would also clean up some other tests a bit?
> 
> The purpose of the "seen" branch is to bundle the branches the
> maintainer happens to have seen, and to remind the maintainer that
> the topics in them might turn out to be interesting when they are
> polished.  Nothing more than that.  Consider that a topic only in
> "seen" is not part of "git" yet.
> 
> The contributors can use it to anticipate what topics from others
> may cause conflict with their own work, and find people who are
> working on these topics to talk to before the potential conflicts
> get out of control.  It would be a good idea to fork from maint or
> master to grow a topic and to test (1) it by itself, (2) a temporary
> merge of it to 'next' and (3) a temporary merge to it to 'seen',
> before publishing it.

Thank you for the clarification.  Hence, I'll send the v4.
