Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4033BBE3
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268643; cv=none; b=fYZhvR1ZhVfQPbt07jrVOnUKNEK8112LDw8Up31aXbfRw+m2qfZMsFE+2C9w/z0Iu/uv4Y7WHDefVTX6Zh7pbmFfTG6V0sgmWLIQHIqd22L7HErthpvXG5mWXVKKUesyQU0ND6/AB9cuj43QwmGDJlsM0zFuB03zIBxaqLo6QlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268643; c=relaxed/simple;
	bh=zILBce/yZ0EyUYSvX5a+uuffikQH7A7LBoRZYU8NlTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ueWCtKZerRIqOXQNrJmjQjf2ujQeaNPABPxgIR0QTf9jDCLFpNfX3UL5AQ0Q6dpoxdzhLRV+TqWBihjz8Q52Ln3CVhpIJ20M1DDjCT5dLrGX9IxjbghULzQaOODnXR2VW1Cmj669YG3sxIwiR4LqEGfdtOOLGpiiZLEh8tfDSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fG3+Nenu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fG3+Nenu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27E3E370B2;
	Thu,  9 May 2024 11:30:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zILBce/yZ0EyUYSvX5a+uuffikQH7A7LBoRZYU
	8NlTs=; b=fG3+Nenu2Z+KGKrlX2OntNHUklyQqfP81P74Fx/VsRJipzPJUkyVhz
	nS9ATUaKKIRBj2dKBC2sBoQLzrQpOxol3GOO1boIIwaNGK7HHfumnqPbRqwTTf7A
	xtfsYT7MujgnkP4Ilw3Qc4X90EP76aj/zCz4/9f204l7+BUOd5qps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ED02370B1;
	Thu,  9 May 2024 11:30:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79E28370AF;
	Thu,  9 May 2024 11:30:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Fahad
 Alrashed <fahad@keylock.net>
Subject: Re: [PATCH v3] git-p4: show Perforce error to the user
In-Reply-To: <pull.1668.v3.git.git.1715206266214.gitgitgadget@gmail.com>
	(Fahad Alrashed via GitGitGadget's message of "Wed, 08 May 2024
	22:11:05 +0000")
References: <pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
	<pull.1668.v3.git.git.1715206266214.gitgitgadget@gmail.com>
Date: Thu, 09 May 2024 08:30:39 -0700
Message-ID: <xmqqcypvvw80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17A087EE-0E19-11EF-9FB4-25B3960A682E-77302942!pb-smtp2.pobox.com

"Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fahad Alrashed <fahad@keylock.net>
>
> During "git p4 clone" if p4 process returns an error from the server,
> it will store the message in the 'err' variable. Then it will send a
> text command "die-now" to git-fast-import. However, git-fast-import
> raises an exception: "fatal: Unsupported command: die-now" and err is
> never displayed. This patch ensures that err is shown to the end user.
>
> Signed-off-by: Fahad Alrashed <fahad@keylock.net>
> ---

Looking good.  Queued.  Thanks.
