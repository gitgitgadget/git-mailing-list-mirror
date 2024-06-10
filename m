Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60514277
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053616; cv=none; b=D2Vdp4zAd4Twc+dOeHe4oZ9aCwZDGMm6byqtfHJ0dUv9RjstNsLglCM3tUQnbsHxGY0JXZFFF8QzZoF79VRmUOj0xsDUxwpVv9R1MyxFxVNYKkLfPfjrdEmh48Vhv8el7RQ9glg3Zv8Ar0Dg5nfLKj4SJyVcaD1egSfhVmIdQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053616; c=relaxed/simple;
	bh=mh9LQJC0FoywTuOaispdDhN9Abttlv/2r7/xxMYc0Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DA0sBoxuYkEOVVue335XP9rWQsSCXmOwwhWkwL1LcQJ71eS4Per/DErysu0H5xQAFX4hkwVYv6Y0/fVTCAn0VhFYsOuBbqdCNKCJgkEfdI5iD2hKMAJgAv+n9C8nAhcu5iFKi9qeSFUCVSwy2vkrqajoYhKPriCZwGiD3VKq5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ppu5UAoP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ppu5UAoP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DBDF131141;
	Mon, 10 Jun 2024 17:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mh9LQJC0FoywTuOaispdDhN9Abttlv/2r7/xxM
	Yc0Xg=; b=ppu5UAoPHNHkju94JoYlqnmLiR+PKBHGCMopM8a1YHn9SjmicBzVbN
	tuKH2N1F8bHUod57nJJV6BrI48klljxYY5LPRwx915cGJkBBylxOJ2dZBM4RISvx
	ROQKUAQdqdDfioLYIWnkODh9OpHoLmzWyLOt0JGdQw5h6HeZhWi1c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C79C931140;
	Mon, 10 Jun 2024 17:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 759C13113F;
	Mon, 10 Jun 2024 17:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
In-Reply-To: <72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
	(Ghanshyam Thakkar's message of "Tue, 11 Jun 2024 02:22:47 +0530")
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
	<20240608165731.29467-1-shyamthakkar001@gmail.com>
	<xmqqed944uq7.fsf@gitster.g>
	<72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
Date: Mon, 10 Jun 2024 14:06:49 -0700
Message-ID: <xmqqr0d4zevq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BB01C52-276D-11EF-BD73-8F8B087618E4-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> On Mon, 10 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
>> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>> 
>> > helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
>> > library, which is a wrapper around crit-bit tree. Migrate them to
>> > the unit testing framework for better debugging and runtime
>> > performance. Along with the migration, add an extra check for
>> > oidtree_each() test, which showcases how multiple expected matches can
>> > be given to check_each() helper.
>> > ...
>> 
>> Use "LAST_ARG_MUST_BE_NULL" here, probably.
>> > +static void check_each(struct oidtree *ot, char *query, ...)
>
> I see that you already made this change in merge-fix/gt/unit-test-oidtree.
> Thanks for that.

That is merely tentative.  LAST_ARG_MUST_BE_NULL must be on the base
topic, as it is not something that suddenly becomes required after
getting merged to the integration branch (unlike other changes in
the merge-fix which became necessary in the world order after Patrick's
const string fixes are merged).

I do not know what other fixes are needed, and if there is nothing
else that needs to be done in gt/unit-test-oidtree topic, I can do
"git commit --amend" before merging it to 'next' (unless I forget,
that is ;-)), but if you are rerolling, please do not forget to add
that (you do not need to do the constness changes, which will require
you to rebase on top of whatever contains Patrick's work).

Thanks.
