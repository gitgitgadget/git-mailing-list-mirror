Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB2C698
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678739; cv=none; b=nNOmmEX4kUM2QIkhRSfMNXo0GqiHainvzgaFL/6sI+bvcJXCPbOHqUE5ob9DZtOHVZjJKegTN6+7qjuSIQxM2wozN0uGM3akHj1Io8aCy05AyAXrFQsx3Hwh4aGWghP5cnbduixrMCLoqPYN1e02QYHpU7xwiiZv9ctp9uJetYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678739; c=relaxed/simple;
	bh=LwjV/f7HSXB/HuLlKhNrTnunzc3n69stuDm2ev/mGcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uY1AZ/KDhrJ6bKaiImrJjFkcf8VbpYRiY0nDhRBJI/SiE6HyFLxp29nJeU27C061LNN+npGCLxHsyaK1y20/b3dGwdcG+1Y7LYDOx8tWhzjf/1ATTJah8imaJcq7A5t74CVfPJ3nqgkjzyV0Ry2EN952f1mT7oWOZ1t8OkeyeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gZdLgNOv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gZdLgNOv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2953217D9;
	Thu, 28 Mar 2024 22:18:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LwjV/f7HSXB/HuLlKhNrTnunzc3n69stuDm2ev
	/mGcQ=; b=gZdLgNOvfO89TNu7GaPddqotwNj2g+BmGC8+5I2hkpS+jJjMNQklBR
	nAZ4u8SFdiKN5xUuJthOu4cqwHx8dvJquh42NaU9ag6aUW8HXTerC4LPmtWaBu4w
	gFOtozb1lqND9CWd2laz5eHCAgmtXbMprZ74mU7XrtD1tmnbmQ2BM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE13D217D8;
	Thu, 28 Mar 2024 22:18:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40C5C217D6;
	Thu, 28 Mar 2024 22:18:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Han Young <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] t4126: make sure a directory with SP at the end is
 usable
In-Reply-To: <xmqqh6gqt674.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Thu, 28 Mar 2024 14:08:47 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g>
Date: Thu, 28 Mar 2024 19:18:52 -0700
Message-ID: <xmqqil15srub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0C50CD2-ED72-11EE-A803-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> +test_expect_success 'parsing a patch with no-contents and a funny pathname' '
>  	git reset --hard &&
> +	empty_blob=$(test_oid empty_blob) &&
> +	echo "$empty_blob" >expect &&
>  
> +	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&

It seems that on Windows, this step fails with "funny /empty" as
"invalid path".

https://github.com/git/git/actions/runs/8475098601/job/23222724707#step:6:244

So I'll have to redo this step; unfortunately I think it is already
in 'next', so an additional patch needs to resurrect that prerequisite
trick.

Sorry for breaking CI for 'next'.
