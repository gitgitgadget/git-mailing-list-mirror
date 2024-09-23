Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCBBC8C7
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108685; cv=none; b=hPAGnuMlAkWRLlZXYPgsjRzDUZBJefU/uuuSS+PGr96jgpEO1mJnaPXEdUb8CWUIr+doZO1/bMnROnby+GIj39xy70JoiUPKs/i+LJjTPbQna7K07My2aB2xHrJ5IzsaDVCWkHf1sqbQ+J+cGlmD1KdBlngXoLvAUeQK+0O37B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108685; c=relaxed/simple;
	bh=TG4N+RfzOdZQJTm9uVmrMkjijws01ZcyHhSAtPDPtZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dRLK6uOsG3zJ6QwJKXHEwnNRXSQPLTCOIaXziCtHFEKJP0m0yxoySv3LDwp0sU5F2pqjqJlMhmd+2lNjVIf9TpO/VRDj29oN3x3QoX5KYPnqrMOzLuCu6NBhxWMLJuJLXV/moPHmVFBHHF+xnFv9EEq+UVCBI3NGFzneYSlrULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5wvzktx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5wvzktx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7129426C16;
	Mon, 23 Sep 2024 12:24:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TG4N+RfzOdZQJTm9uVmrMkjijws01ZcyHhSAtP
	DPtZ4=; b=h5wvzktxrJXzulC+rLSqO2kFfn7/sY5bFqeOYVTgJ9vq0PiXmNVRtX
	WfSupqk6BODYywD+8zh7bGX40Q4c3dzRmB/n4d795y9n3Xn2datHWK+ku10zZUG9
	RA4mquDMn8C+Qzbb/frhror5BACGW4HcflALLjWdYNB/t2axP+HWs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68E4C26C15;
	Mon, 23 Sep 2024 12:24:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C980826C14;
	Mon, 23 Sep 2024 12:24:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  liuzhongbo.gg@gmail.com,
  Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 0/3] maintenance: configure credentials to be silent
In-Reply-To: <5114e7fa-7858-458a-bc5d-5c82ea663a48@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Sep 2024 21:36:02 -0400")
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
	<xmqqfrpudm51.fsf@gitster.g>
	<5114e7fa-7858-458a-bc5d-5c82ea663a48@gmail.com>
Date: Mon, 23 Sep 2024 09:24:40 -0700
Message-ID: <xmqqsetq49tj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56339896-79C8-11EF-B1FD-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 9/20/24 5:56 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> Add a new configuration value, 'credential.interactive', to specify to the
>>> credential helper that it should not prompt for user interaction. This
>>> option has been respected by Git Credential Manager since 2020 [1], so this
>>> is now presenting it as an official Git config value.
>> So, the other helpers are also supposed to check for the variable
>> and fail when it has to go interactive now.
>
> I would hold off from saying "supposed to" but Git is definitely hinting
> towards that behavior.

I would too.  I didn't mean "they were behaving correctly, but we
changed the rules from under them and they need to be fixed".  With
or without your patch, they would try to go interactive and make the
process get stuck, until they start to check if they should refrain
from going interactive.  With your patch, they have a way to do that
check in a documented way.

> Perhaps I'm just hung up on the idea that we are not adding a new wrinkle
> to the "contract" but recommending a good thing that was previously not part
> of the interaction.
>
> Thanks,
> -Stolee
