Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C31F19A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DWn608ES"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E128E95
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 09:39:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D511A7DB9;
	Fri, 13 Oct 2023 12:39:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TeSDM/XO4k1Xz5kd9+OmLuLY0HErvSUtwqX/Ic
	/J6F4=; b=DWn608ESuvw9YzzkKM+bOxsQQkFqwvZ9lUlYS3WrOVVGF39YblwFfr
	3MNjYe1gxj4ESEU+q6ySZi78u2/6Ltx8Vw7Ny33Ynn+LaqAiyrWGsy3H6ZRPj7Zu
	WxotKMdY4rj4IQPJ0bjn/n/aD4OiamTOIPaThofdhsmPE/BEXfTfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D51C1A7DB8;
	Fri, 13 Oct 2023 12:39:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A23301A7DB7;
	Fri, 13 Oct 2023 12:39:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: git@vger.kernel.org,  Josh Triplett <josh@joshtriplett.org>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <9C4A2AFD-AAA2-4ABA-8A8B-2133FD870366@icloud.com> (Sebastian
	Thiel's message of "Fri, 13 Oct 2023 11:09:27 +0200")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
	<xmqqttqytnqb.fsf@gitster.g>
	<0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
	<xmqqttqvg4lw.fsf@gitster.g>
	<9C4A2AFD-AAA2-4ABA-8A8B-2133FD870366@icloud.com>
Date: Fri, 13 Oct 2023 09:39:53 -0700
Message-ID: <xmqqfs2e3292.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 235E17DA-69E7-11EE-B88A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> But if there is now a prefix, I feel that it might as well be chosen so that it
> is easier to remember and/or less likely to cause conflicts.

Another criteria is that it is not very often used in real
pathnames, of course, and '!' and '$' are good ones.

Come to think of it, we might be able to retrofit '!' without too
much damage.  Something like "!unignored" is now a deprecated but
still supported way to say "!!unignored", "!*precious" is new, and
"\!anything" is a pathname that begins with '!'.

> Yes, I think my paragraph above is exactly that but with examples to practice
> the new syntax-proposal.

OK.
