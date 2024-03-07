Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725B1D680
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818075; cv=none; b=ZyfWLY+xdErRBYcB43J6yYLnJ+bJFBHXFpAruFXMJzGOJEEb1uiBoix2thBSxXoZYqVsymsi7Jpf1rRNl3mMKVCBu9Wd4yRl5FlxvKrqKFeG6JUNvlWkJCQ0NDR7tIlg1riLftV19enBLr9/XV6JWufe+EZ9nXCfXUGfUH9Ggko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818075; c=relaxed/simple;
	bh=SXBBIcDyZzszojwzBtGcFlQzncgMxzLO88xC5i79By4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GO7eRMmU4rMk0Hm0gaR7nHUK3+pjr37bksTIJUd6ZnmqW3VE0pBwfiiNXHSbiNPIJkTIHHkgI9le+NocDzjn3TcYLnF7BEOv//NSUWdk5kIMXUAG7ZxZ/K7xs22wo2J+wuqrXIJ2EVJcBB7wHZSFeIJFy1oQAPHzC/2MHwAdFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C9FKXGUK; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9FKXGUK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 28A242630F;
	Thu,  7 Mar 2024 08:27:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SXBBIcDyZzszojwzBtGcFlQzncgMxzLO88xC5i
	79By4=; b=C9FKXGUKpzPcVrdP17OB6vYeg5ZLpcKFsZqFjK5vZm4C+YBTeUYmzo
	M5xGBS9SK+qigypCbqeMWkxIh7Ttjve/N2IL2MOifU+h7hei2mdmp+mW67z0Ll1X
	jkycTj9g5pftYf0BU6LohaTLCQJGblgHxWSbKzb7zSetHSCe0AjB0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 218782630E;
	Thu,  7 Mar 2024 08:27:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E5E02630D;
	Thu,  7 Mar 2024 08:27:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <ralph@seichter.de>
Cc: Ralph Seichter <github@seichter.de>,  Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Allow git-config to append a comment
In-Reply-To: <87plw6xld7.fsf@ra.horus-it.com> (Ralph Seichter's message of
	"Thu, 07 Mar 2024 13:44:04 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<xmqqttljtkn4.fsf@gitster.g>
	<2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de>
	<xmqqplw6nsuz.fsf@gitster.g> <87plw6xld7.fsf@ra.horus-it.com>
Date: Thu, 07 Mar 2024 05:27:48 -0800
Message-ID: <xmqqh6hinpd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E3BD784-DC86-11EE-80E1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ralph Seichter <ralph@seichter.de> writes:

> Just as a brief interjection: I am sorry that my inexperience with Git's
> mailing-list based process caused me to leave out details which were
> discussed earlier, be it on GitHub or Discord. However, me not
> mentioning that I am aiming for single-line suffix comments only was due
> to simple forgetfulness, without an excuse behind it. My bad.

Don't feel too bad.  It is not about discord vs mailing list vs
github "reviews on the web".  It is about the end-product, the
commit log messages, what future developers will see in their "git
log" output.

> I think it best I flesh out the commit message before anything else, and
> then resubmit. That should bundle the necessary information.

Yup.  Please do that.

Communicating with reviewers and other contributors is not the
primary goal of the review process.  It is done to help us reach a
better end-product, the commit log messages that will help our future
developers and future selves.

Thanks.
