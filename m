Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBD14F62
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458985; cv=none; b=F0LwNd+Ou4w6edgzVjxuGCv3/zlnzcqVIicJqhvZGZoHrMHjb+Ee2jUfVc1+ND/92DSnxUgNQrHLgC1LgliZ+zR96nxphxhuk9aopkfKJ8rfDTSvirodGJMCDQyk4EGvYeuPF8R/mIz9AKK4E+GZNCMGxe6RHmAsT7XctttITdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458985; c=relaxed/simple;
	bh=qeKRz9OoHZppnSRowcyPgYv6sG24eZ2UgX/EsWpOtl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gequdty8dnHiSPZfgQO1yIcdVgyFf/fuc4rh6e/lCo51gCJbEvXa7UCzwwI/mepZeOZ97no/5wRvx5HZJUrQpzzZilFoYnwPxhftvkOcvX7zX/uQ8RZd/K+urV0XvCvi71Sl9Sdn9Zm+XB2ieGTkImSsgy5U5QoAkTbH+fKLO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUxn+bqP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUxn+bqP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5361DABEF;
	Thu, 14 Mar 2024 19:29:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qeKRz9OoHZppnSRowcyPgYv6sG24eZ2UgX/EsW
	pOtl4=; b=pUxn+bqPqZiaUBymf1XrFf3Vwlq729bbAYomd6t6V53RPZXvDpHaD+
	6bvyPPwFvGv0MToKiAh0BXYXUCz7NsekxT0GRaYaddWlLY1HiH6YcP9Nuj3LghYi
	+TJtMkBYf3+5F0mYvizYh99cnFpve5lPfqQrnkUvS82mCj5Y1pmQM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27F6C1DABEE;
	Thu, 14 Mar 2024 19:29:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E9FD1DABED;
	Thu, 14 Mar 2024 19:29:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Christopher Lindee <christopher.lindee@webpros.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date branches
In-Reply-To: <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 14 Mar 2024 22:55:49 +0000")
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<xmqqa5n168nh.fsf@gitster.g>
	<ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
Date: Thu, 14 Mar 2024 16:29:40 -0700
Message-ID: <xmqqv85otmsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB7A92AA-E25A-11EE-AE53-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> A radical counter-proposal for the design is to update the client
>> side to do this unconditionally, without needing any new option.
>
> I'm not sure that would be a great idea.

Thanks.  I was looking for a push-back ;-)

> Since it's a push, that will
> trigger authentication, which may prompt the user (e.g., for a password
> or token or for a YubiKey touch with FIDO2 SSH) and which they might be
> able to easily avoid.

Do you mean we first go unauthenticated to find out what commits are
at the tip of refs at the destination repository, and then switch to
authenticated push after we find out there is something that is
worth pushing?  I somehow thought we need an authenticated access
only for the initial ls-refs exchange.

> As a server operator, I also expect that there
> are people doing lots of needless attempts at pushing in automated
> systems (because with enough users, there will be at least some who do
> bizarre or inefficient things), and I would prefer to avoid serving
> those requests if I don't need to.  (For example, for us, reference
> updates need to go through a distributed commit protocol to update
> multiple replicas of the repository, and if there's no ref updates, then
> we cut out multiple services which we don't need to contact.)

Yes, but if you have an extra no-op ref update in the bunch, that
one is excluded from the set of changes to be synchronised across
replicas, no?

> Note also that no-op ref updates cannot be simply omitted on the server
> side because we need to verify that the old value for the ref is
> correct, or we need to reject the operation as out of date.

Yes, but isn't that something the user would rather want to find out
earlier rather than later?  Your push without no-op update may say
"ah, we are up to date" when we are behind or worse diverged.  If we
do the no-op update more often, we'd have more chance to catch such
a situation where the worldview the end-user's repository has is out
of sync with reality.

> I do think the proposed change is valuable, though, and I'm in favour of
> it with a suitable option.

In any case, I am OK with the feature.  I just was wondering if the
end-user experience may become simpler and easier if we did not have
to have a command line option.

Thanks.
