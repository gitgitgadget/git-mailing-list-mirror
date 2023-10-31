Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5B2232E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r7YO94A9"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D2BD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:54:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AA62288B4;
	Tue, 31 Oct 2023 19:54:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xUv01QohJceyQSf+zkF29YiAtgPJRAyY38fFr3
	6uylA=; b=r7YO94A9ji6Jym0yJDgoerIC7G1uREAqozW2loXTHjiz8Xg6HNHTZi
	BDTy+nMeHXB+X3YO16OJCI0oE5K862HIZaw8c4flCgE621/RpNJw60jFwDV6F7GR
	5ek0G9cRivQos72EwLzmCZm5yWX5gX7N3ql4/TckEstRW2d7dQ7c0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 64AA2288B3;
	Tue, 31 Oct 2023 19:54:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02C1128899;
	Tue, 31 Oct 2023 19:54:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH 2/3] strbuf_commented_addf(): drop the
 comment_line_char parameter
In-Reply-To: <20231031222400.2048688-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Tue, 31 Oct 2023 15:24:00 -0700")
References: <20231031222400.2048688-1-jonathantanmy@google.com>
Date: Wed, 01 Nov 2023 08:54:19 +0900
Message-ID: <xmqqpm0uz6tw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D026AC4C-7848-11EE-851E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> This moving of the helper function does not belong to the "fix
>> commented_addf() not to take the comment_line_char" step.
>> 
>> The series should be restructured to have the two patches from me
>> first, and then your moving some stuff to environment.c, probably.
>
> This means that #include "environment.h" will be added and then removed
> in the same series,

I do prefer it that way, because that is exactly what we are doing.
First we fix the duplicated parameter in the API by relying on the
global, and then we move things around to hide the dependence on the
global.

Thanks.
