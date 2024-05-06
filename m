Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E584DFF
	for <git@vger.kernel.org>; Mon,  6 May 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715033859; cv=none; b=H2Tmz0d7j6oceThQJn6du7BovUiY59ScL/d3VkM74ins1FEkyQEECugGjIaztmJJXXOIl2lm2UunuMGPomJiTYsbEZOrGGSItphFfBfPU5PWaT7iemsJVsApWAJKaX1eYms+7S06b09+95546+32JHaZPOW7wp9LU9BQPTq+iPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715033859; c=relaxed/simple;
	bh=eRuissJSXfv9s45jX38ivjyzvksIMnaw1TVheOV2Epg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stngQ4okM9ufy6WGz/Ogua4KuxgoTscx/hMu5bbfUPDJi88IW21hk6Gz+1BGZ7MQovok7vpW1petcs4bsAcp/n3CdNX3WPRg2NRkPLw+ynPSVork/7ECYpfwMwTpnJQTuExApjM4ovSb1XhrxPQYv2p1ZKgAZPsVAwCG+BKvEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k8shJZ8v; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k8shJZ8v"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3DE018A48;
	Mon,  6 May 2024 18:17:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eRuissJSXfv9s45jX38ivjyzvksIMnaw1TVheO
	V2Epg=; b=k8shJZ8vj13I+rSQrNdqvY+sDpEK3td9cY7oxVOyxivmlvxDbV/SWB
	3hzaEGxlo0c96gvJB+xKrmvFaKCRXKzg4qZhIiV2taim8qSouL+FvjHb/s8r6iZ/
	+VWlOlSdPDn34qmEfEsr5G0R3583A5uFtR+2UukpV2IiyR5UhxpEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB72818A47;
	Mon,  6 May 2024 18:17:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38DAC18A46;
	Mon,  6 May 2024 18:17:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #02; Fri, 3)
In-Reply-To: <ZjihN01c8gWX0s9H@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 11:21:59 +0200")
References: <xmqqa5l64e0i.fsf@gitster.g> <ZjihN01c8gWX0s9H@tanuki>
Date: Mon, 06 May 2024 15:17:35 -0700
Message-ID: <xmqqy18mwpog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 714D14EE-0BF6-11EF-AF40-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I have just sent out a new version [1] that fixes a few commit messages.
> Other than that I think this version should be ready to go.
>
> [1]: https://lore.kernel.org/git/cover.1714982328.git.ps@pks.im/T/#u

Thanks.

>> * ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
>>  . repository: stop setting SHA1 as the default object hash
>>  . oss-fuzz/commit-graph: set up hash algorithm
>>  . builtin/shortlog: don't set up revisions without repo
>>  . builtin/diff: explicitly set hash algo when there is no repo
>>  . builtin/bundle: abort "verify" early when there is no repository
>>  . builtin/blame: don't access potentially unitialized `the_hash_algo`
>>  . builtin/rev-parse: allow shortening to more than 40 hex characters
>>  . remote-curl: fix parsing of detached SHA256 heads
>>  . attr: fix BUG() when parsing attrs outside of repo
>>  . attr: don't recompute default attribute source
>>  . parse-options-cb: only abbreviate hashes when hash algo is known
>>  . path: move `validate_headref()` to its only user
>>  . path: harden validation of HEAD with non-standard hashes
>> 
>>  Before discovering the repository details, We used to assume SHA-1
>>  as the "default" hash function, which has been corrected. Hopefully
>>  this will smoke out codepaths that rely on such an unwarranted
>>  assumptions.
>> 
>>  Seems to break t0003 with a NULL the_repository.
>> 
>>  Ejected out of 'seen' for now.
>>  source: <cover.1714371422.git.ps@pks.im>
>
> Interesting, I couldn't reproduce this issue when rebasing the patches
> onto "seen". There were merge conflicts though, both with
> jc/no-default-attr-tree-in-bare and ps/the-index-is-no-more. So maybe
> there was a mismerge involved somewhere?

That is very possible.
