Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7F12FF88
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968080; cv=none; b=TsBccC37AgOjpa5mS9Q+i0mHsolwgdZUtJ2sI6hxasYLeX9iujFCU0lAjNhJUZI0b3NqiVjrhWxQXiPJWON+HI6PA0fHJ5hY0fK+HUIm9q6JlQcHUp91o6ZZJcK6Fj1CBqM40rI+M4a6kJPVE6J824F6GvG1CqYNO1eUyvudJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968080; c=relaxed/simple;
	bh=Xs6VbLeAEG47reF/Kur2FpCTbIPbdoZQgPRwBa5NqSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c7JFQZ39EtY6BtO8Nm4jxu8IqIWBWYH6aRoX9EZEN821ifilamXWIF7MMQYSRTsZyvCCPlOktfj2aF0XrUtUgS0EtD1+iluxFE7oKp+U4hhLP5dR+RdWdwQpaA4RsQn9kBisR1d+Mkaqj/NoCvgo0/Us96z+ZtfsJXmlI1fiXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M0rmPhmw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M0rmPhmw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BDD902C512;
	Mon, 22 Jan 2024 19:01:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xs6VbLeAEG47reF/Kur2FpCTbIPbdoZQgPRwBa
	5NqSc=; b=M0rmPhmwogh4nQuF9zY73R2aoyqeruLEIj76qOF0wsGJhJtS+PnThu
	KYS005J0zdXithKqFz+hqWnvC0ycjPPNE1ktVHv9a+WxZqAdP1Tqo32duuLp15zr
	c7AhP1I8n4HH3pf3iY+xK1SZl7MuDlZiNH1Ee4PihqZA74hwpzhIk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B5D172C511;
	Mon, 22 Jan 2024 19:01:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E2E062C50F;
	Mon, 22 Jan 2024 19:01:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 00/12] Group reffiles tests
In-Reply-To: <Za5TW-q4cKS8pNNc@tanuki> (Patrick Steinhardt's message of "Mon,
	22 Jan 2024 12:36:59 +0100")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
	<Za5TW-q4cKS8pNNc@tanuki>
Date: Mon, 22 Jan 2024 16:01:12 -0800
Message-ID: <xmqqplxsrk8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85F65782-B982-11EE-BBC4-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I've got two minor nits, but other than that this looks good to me. I've
> also verified that all tests continue to pass with the current version
> of the reftable backend.

OK.  I've squashed all the nits from you and Karthik into the copy
in my tree.  If there is nothing else, let's declare a victory and
merge the topic down to 'next' soonish.

> There's a minor merge conflict with db4192c364 (t: mark tests regarding
> git-pack-refs(1) to be backend specific, 2024-01-10). This conflict
> comes from the fact that both patch series add the REFFILES prereq to
> t3210, semantically the changes are the same. So it doesn't quite matter
> which of both versions we retain as they both do the same.

Yup, that is what I've been resolving them.

Thanks.
