Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6321350F4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131029; cv=none; b=BS5mAER2Gyikls8WjmuuJIXkogUufr4ka5dy/ToP2RcPYWmxQGMeAq7A2oIUhkqIh/xRFm+lBpnMmnk0Edf6CWfqiCp8n7nDqtkZB4e8AMQmSvcT6GUPRLhVu8l/QIydIKD6FxXiT/KSuypP8/tscQiFL4b1jAwphq6tPAUBakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131029; c=relaxed/simple;
	bh=tdbaS42iO8E36d9+FdJ+teQgpteaRfB0AGjiPoh9OSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lLW0HJhF9n8kCyOFdrmB2W71yJ4pnfgKe5V/3rmPbbKs4GleOfV0zdJjzI3ELhGr/JBjrUUNPXPhqFutwlroCnjBQOI2cTYU0GJJQ80NiAzWeE1K9filGUIxi9rohvXp55iBZJKwgxp1hY8LWzwVf7DqYx5JH7nQrQSPMc31RUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hpdO7DFh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpdO7DFh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97B9E1DB82A;
	Wed, 24 Jan 2024 16:17:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tdbaS42iO8E36d9+FdJ+teQgpteaRfB0AGjiPo
	h9OSg=; b=hpdO7DFh5hDvaC9Zpp4UNlj5W1ITXeqt/9HUc6Sh8B334C7ycKzbYD
	1FJkKv35gT2xPCxFMJsWjdAWZq3ZgWr1y2TFinN9ebIg0iv1vIoyaTlLc2zzfaIv
	Lryz1V6HNV5ywQRHiTGue0lwztP4u2Xi7xzKvAjNIPDjO3gXIOBBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 534261DB829;
	Wed, 24 Jan 2024 16:17:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D65F1DB827;
	Wed, 24 Jan 2024 16:17:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Antonin
 Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v4] merge-ll: expose revision names to custom drivers
In-Reply-To: <pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Wed, 24 Jan 2024
	20:09:11 +0000")
References: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
	<pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 13:17:04 -0800
Message-ID: <xmqqfrymbfe7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECC0EBE0-BAFD-11EE-A2C4-25B3960A682E-77302942!pb-smtp2.pobox.com

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> Custom merge drivers need access to the names of the revisions they
> are working on, so that the merge conflict markers they introduce
> can refer to those revisions. The placeholders '%S', '%X' and '%Y'
> are introduced to this end.
>
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---

This looks all good.

Let's declare a victory and merge it down to 'next' soonish.

Thanks for sticking to the topic.
