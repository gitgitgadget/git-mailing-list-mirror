Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27000175D20
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691051; cv=none; b=garQwvq0xfJGAFWg1Vr3O5TYtuvXyM2dcQPilCWLtPRyznFB8GFtA/rCsiSKkBUXge/X7tH7knMijzJbpds5/ARrtNbe1jkDZxOkLWs3whoRcpua14Mbz6MAewtOAK/L/6wbBvzPpP5vg14TC1UMBGig7P/tumZl4zX6TGDtcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691051; c=relaxed/simple;
	bh=BJf9CkgpTsPVXx3EJQlWQUEtauNjPExEztN7wkgVxdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzGIAQNLczWq3kYt/eUNuZeBlh+XXH8VKJQ+NscG1nVxMjnEWmLNw1c8Kbohgnxb9OL4Ed2PZQQMl+oWAeRZJXe3Y2K+NDpJqUIvXR85YPi4+PJmVrUZtev/W+zE7VHghGa+zDaOzva/jpJdy3bd4pO629l/IUo4qmm3u2tcx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=apB53GhD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="apB53GhD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 094D519285;
	Wed, 18 Sep 2024 16:24:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BJf9CkgpTsPVXx3EJQlWQUEtauNjPExEztN7wk
	gVxdk=; b=apB53GhD0c25udu7sZiq+gpGY8pzuMxiI+vDh0W0LS8H8g2aEagxDO
	NTvkU3XIdG4A/feZLQMvzA9UHK6FRaZe3QLOf6eQRHmIiAgAfnxdtEZYFRIIccaA
	34EGpObMT0Obmzaj6CVLyTeZ8uyGPPbuAbVamL6NImOvDlaOIVcZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01FAC19284;
	Wed, 18 Sep 2024 16:24:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73BB019283;
	Wed, 18 Sep 2024 16:24:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Han Jiang <jhcarl0814@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] remote: check branch names
In-Reply-To: <82a08e44-3822-4a26-ad09-4ca1a9b44c11@gmail.com> (phillip's
	message of "Wed, 18 Sep 2024 14:18:39 +0100")
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
	<dba31245607f85c48947da60fe0955a6ed3e2c43.1726067917.git.gitgitgadget@gmail.com>
	<xmqqfrq686n5.fsf@gitster.g>
	<4915a1ba-eda9-435b-b615-4f78c7fe25f7@gmail.com>
	<xmqqy13vxx3m.fsf@gitster.g>
	<82a08e44-3822-4a26-ad09-4ca1a9b44c11@gmail.com>
Date: Wed, 18 Sep 2024 13:24:07 -0700
Message-ID: <xmqqh6acbti0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F55399C4-75FB-11EF-B8D3-9B0F950A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

> ... Given that "git remote
> set-branches" has only ever supported "real" branch names and patterns
> on the command line and no-one has complained I wonder if we're better
> off doing something like
>
> 	if (strbuf_check_branch_ref(&buf, branch_name) ||
> 	    strcmp(buf.buf + 11, branch_name))
> 		error(_("invalid branch name '%s'", branch_name));
>
> where the "buf.buf + 11" skips "refs/heads/"

Yeah, replacing +11 with skip_prefix() or something for readability,
such a check might be good enough in pracrice.

Thanks.
