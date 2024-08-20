Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A09FC11
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167376; cv=none; b=YG5zdtbHmGaZEcmePkhsBIpfFWxcUlVmHsx9pnSbjuwHtEiGjVilj+JQBDQFRhGqge3aHJ2uzt8FLeMC2kJKLQjfprpEnWhsVHp81YuEnd1x/A0N4G70OB1yja2cOiPWQz5+lFK68jBBm8aVQI3ZWw2hiOyuZW971eAunaaxYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167376; c=relaxed/simple;
	bh=bLmM62eDBLWCVcxdl4jmaHyjCWqbYnaNOr3CK4keDa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ae52fEI/UtcnQSV+v8ixQ7QkCa0PArchQuotXivsY8gm+RSqgU3BSjU9sCl0BWxy0+7XsJIk7o6RPnMCps9swb/JvqpuyIKpo8KvZv6/wRUG4dCglNNkaA6f8wAspMtWDqsXnC418OLcTbQlquVJ1O5+cncrjf0FC56OHnPPclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vi/Ot+XC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vi/Ot+XC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C63D82D81E;
	Tue, 20 Aug 2024 11:22:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bLmM62eDBLWCVcxdl4jmaHyjCWqbYnaNOr3CK4
	keDa8=; b=Vi/Ot+XCIoZTVdxaKIMYESkzLG0p43U37b3dgSQG35rWT1MMU8/LdZ
	iZyfCkNHgAIe9auuoLSFZxVHoYCOoIZVJC8XmTU7PtdJHAiulEh7qOuoPgoWZKFO
	iE2aIBwTqKsPY4+40GiQIYQRpt9ZSOMXx7fQAcS6jS7EvFMOCf2PM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BEB022D81D;
	Tue, 20 Aug 2024 11:22:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CF752D81C;
	Tue, 20 Aug 2024 11:22:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Update the win+VS build definition
In-Reply-To: <pull.1775.git.1724164270.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 20 Aug 2024 14:31:08
	+0000")
References: <pull.1775.git.1724164270.gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 08:22:49 -0700
Message-ID: <xmqqv7zvb4mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1084FC16-5F08-11EF-A6FD-BF444491E1BC-77302942!pb-smtp20.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> These two patches have been in Git for Windows' fork for quite a while.
>
> While the win+VS builds are not run in Git's CI builds, it is still a good
> idea to upstream these changes.
>
> Johannes Schindelin (2):
>   ci: bump microsoft/setup-msbuild from v1 to v2
>   ci(win+VS): download the vcpkg artifacts using a dedicated GitHub
>     Action
>
>  .github/workflows/main.yml | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Thanks.  

Do you mind if I applied these directly to 'maint' and merged the
result upwards?
