Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B715AC4
	for <git@vger.kernel.org>; Fri, 10 May 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360621; cv=none; b=KdGmr7/+gzzqsEYTxuYT9WxnuRyRN04aD2AMJTYZ5WIjdnvr7uF54qsKLjzBJ65kr1Oygm5eQpu62EaIo1xD9fsRWxgoxHVsAx+fyOKpBugapVynDDfV/vTn40nL7bpxJeMDhRNypa6g2WSSomMNuShc1OmlA7Qy0kvGoVRJs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360621; c=relaxed/simple;
	bh=NFDyD32yBHL7pZ/ptUWlhFUhunkIOpPZLY/PCPJYEO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VLAie9GcpG9eZq0N/fgpwv32zeQv8lnDB4FotZOZx805IOCDpN2V4F8bIpIT65RD4iWbFFxZAdzh2tICjcc34KNDuuDwrl3pvv3XTa7xP19VN8ItZzgFKmX1oD6MBwumJTy9LuqVfCL4UvQFpKFUVeMp2ruNkKNfGJQ3tlw7ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=d7E2pK+Q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d7E2pK+Q"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 75697252E6;
	Fri, 10 May 2024 13:03:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NFDyD32yBHL7pZ/ptUWlhFUhunkIOpPZLY/PCP
	JYEO8=; b=d7E2pK+QYya1l8G5derRCyPt80AkYRPkYVAt0gzOX7ijoPNdLFyAPM
	SBcIt8pr2nZfPZYV6gXlGFwyEiofLHTczKmlhNfw7FOMJDxSTiWYxY65xs0Maa4t
	1ThkHmyq+mR4YJDnfKT8ki7qEvVr9crotACPapEPHsyC4Q7VzJoW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CC46252E5;
	Fri, 10 May 2024 13:03:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFE77252E4;
	Fri, 10 May 2024 13:03:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>,  git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
In-Reply-To: <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com> (Phillip Wood's
	message of "Fri, 10 May 2024 11:00:31 +0100")
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
	<xmqqv83mqxg3.fsf@gitster.g>
	<kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
	<9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
Date: Fri, 10 May 2024 10:03:31 -0700
Message-ID: <xmqqcypt61lo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B6C6D7E-0EEF-11EF-AB0C-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>>      $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
>>>        git am -3
>> Hmmm, I hadn't thought of that; very interesting!
>> Although I have some concerns with git-am(1); basically that it's
>> almost
>> clueless when there's a conflict.
>
> "git am -3" should be fine here as you're guaranteed to have the
> necessary blobs available to create conflicts - this is what "git
> rebase --apply" does.

Good thing to point out.  "am -3" is just as good for this purpose
and "almost clueless" is a derogatory comment that requires an
apology ;-)

> As far as the implementation goes I haven't thought too deeply but I
> suspect we'd want to create a couple of trees based on the commit we
> want to cherry-pick and its parent filtered by the pathspec and use
> those in the tree-way merge with HEAD.

If we were to use the ort machinery, it may not be too bad to use
the pathspec only at the final writeout phase.  That is, perform a
full cherry-pick in the in-core index, reset all the entries in the
in-core index back to HEAD that are outside the given pathspec, and
then write out the result to the working tree.  That way, an old
change that was made to paths at the original location can be cherry
picked to a much newer tree after these paths have been moved to a
different location.  Doing the same with the recursive machinery
would be missier but perhaps the more recent merge-tree that uses
the ort machinery to work purely in-core might be a good way to go.




