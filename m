Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583466BB3C
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453469; cv=none; b=F3EeKFYCNOWFRM2YYbszGYVnLZzRNrX+LMkY3zW7LlvkJPqyT804lboUNUEQccsVUeJzLZm4Q2FmjWS9SVLV5098Am6VTCDGEyRy0QD9jYOChZWAoKWYpF8CKu5zV3wRXThBDAbIVE2gKy+HrrWcJeBr9X2Ss4rJST8grzvAkjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453469; c=relaxed/simple;
	bh=bsncpxxRYDpNAKNkHK7MNeybnJOGeylUDZIQFW6TtO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhz7wDtsVaiarAS8jIwYIu8yfuT2byO9/gKNJAXEH3XcznvPq0aq9CPOK2ooiXFr6jo2Vdjmjzk7FlmXpx8Q62QWKUt6ljAyRYowyAiKgQbteEpu/lKnWlpb1N3TSGNmjbdXUsFL5ry/qqhZ1511HyV3LfKV027/fOsLIxEc0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hB5lusmp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hB5lusmp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C61F1E99AC;
	Tue, 20 Feb 2024 13:24:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bsncpxxRYDpNAKNkHK7MNeybnJOGeylUDZIQFW
	6TtO4=; b=hB5lusmpAUrv+0BKAEcnYwk2KFtqhXMLdAJ8cifKILVVWJ21ulzrl5
	tKmRhntAj2FBLGqTXFdKtnEL4EufPAKgl4a9Zu8nW05oWXYBXufbqIXk//MbXZnY
	uhc8sYMpiJB8jgdiV1qHgNZAVHHUgNsHbVPD4/FGojfBbAtpGcY6Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 143B51E99AB;
	Tue, 20 Feb 2024 13:24:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 775701E99AA;
	Tue, 20 Feb 2024 13:24:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> (Dragan Simic's
	message of "Mon, 19 Feb 2024 20:55:33 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
	<xmqq8r3lnzp0.fsf@gitster.g>
	<2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
	<ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
	<c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
	<be91f3ad9305366c1385c2da4881537e@manjaro.org>
	<xmqq8r3g8caz.fsf@gitster.g>
	<35738a93f5cbace5b3235ce614b7afbf@manjaro.org>
Date: Tue, 20 Feb 2024 10:24:25 -0800
Message-ID: <xmqqttm3ouxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 475E45D2-D01D-11EE-89D7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> My advice would be to stick to <old> vs <new> that contrasts well.
>
> I appreciate the directness and honesty.  How about using "<oldbranch>"
> and "<newbranch>" instead, which, although more wordy, would be more
> consistent with "<branch>" that's used in a number of other places?

I have slight aversion to non-words like "oldbranch" (not
"old-branch"), but not that much.

Quite honestly, in a document whose primary topic is "branch", I
doubt that repeating "branch" all over the place would be the
consistency we should be aiming for in the first place, when it is
clear from the context that we are talking about branches.

The updates we are making to Documentation/git-branch.txt that (1)
slims wordy description of different modes in the DESCRIPTION
section, (2) make option description of "-m" mention what
argument(s) the option takes, and (3) rmove standalone <newbranch>
and <oldbranch> description are all about making the necessary piece
of information easier to find in one place (namely, the option
description where "-m [<one branch name>] [<the other branch name>]"
is described) without having to jump around all over in the
documentation, so in that sense, I would think the way to go is to
aim for brevity that takes advantage of the local context.

