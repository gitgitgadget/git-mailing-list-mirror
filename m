Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371E4BAAD
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965399; cv=none; b=jPwGL3lL5CVSGA6tWUlgWzZc8jxScZHtbw2obCi8W42mAnZ05rDNl3CdOYDE3z9lpugRIgzhrQGub2kJzzgLt7KKDw71BZGhtlYaVbqqUP7r6a3U6zNGLIvMi9u9SS6eVrNIz4CnbD/KJkJE93XsoE9BbI7O1j3j4TxFi6dwLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965399; c=relaxed/simple;
	bh=pgbfttS5yLJrVHowGZGLDFJJtxVx7PUj5uG3axK55kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pcjbCcn90N3bQJ8donxOXQJnV//IZR+RH8rBJL6DeusYROU+R5RIfqbVKnRFDRWOYq6N9WYfHIZ5k6i5bwFkoQm4t/x84/jWQA+ByRf95L1HZQvsJNYTqfP2gnSKsA/OI1G3NZE5+AmD9g6dzB1gutpY2d5yvYISYSa5Yp1KpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ElexXEax; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ElexXEax"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1A761C8CC6;
	Mon, 22 Jan 2024 18:16:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pgbfttS5yLJrVHowGZGLDFJJtxVx7PUj5uG3ax
	K55kw=; b=ElexXEaxk6DVQZXUoJEOSgs3GhikIhKVgqBVn44EH9686fqrU6bA8W
	VtFJuWSc8KkbAdBkPA8RPSbX8neM8YGV4HQdP4pkz4zixYfwRkISsmt61wLBTBuF
	bDOPKw0D9gjmUiBnwATQhI8puun578l1B38u2SRLiZUsouQvpLMQw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 972A41C8CC5;
	Mon, 22 Jan 2024 18:16:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 056431C8CC4;
	Mon, 22 Jan 2024 18:16:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] ci(github): also skip logs of broken test cases
In-Reply-To: <dbe25fff-e1d4-41f2-8f8f-c538e8c2a77e@github.com> (Victoria Dye's
	message of "Mon, 22 Jan 2024 14:41:41 -0800")
References: <pull.1649.git.git.1705808313306.gitgitgadget@gmail.com>
	<dbe25fff-e1d4-41f2-8f8f-c538e8c2a77e@github.com>
Date: Mon, 22 Jan 2024 15:16:28 -0800
Message-ID: <xmqqv87lq7qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 463B0FA8-B97C-11EE-AD67-25B3960A682E-77302942!pb-smtp2.pobox.com

Victoria Dye <vdye@github.com> writes:

> Thanks for making this change, the more focused logs are much nicer to read
> (and ostensibly a bit more performant as well).
> ...
> And the implementation itself is nice and simple. Looks good to me!

Thanks, both.

Queued.
