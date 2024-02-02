Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F112C7E7
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900563; cv=none; b=LLypZFsTe4v00wGpAorncMs5H4MCyD0dpOIO5Ju/OdvkcNAy2hYMvStJZ1wUYV2A2c9ABUtjVnMenXowDIccgf6cw7boLuAcIjvZmKxdCrIkstO33u6DNPXuG2yWN2fVMUITS2x7J5R5L651vW93CJbwQhLe2qFsvNwPIoKkx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900563; c=relaxed/simple;
	bh=YBHpj4ajvIBrmqTYLNFtfTgQsmpozmLdwmzQgMRqPqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDJz8lftDTNsvNZtePgKhyyNjgayQldDHSgoqCMZGd9i0jO6S1kL1f9OcZ2naQNs8f8l0Scj2u1t9LXV6Jq67eCJ8X5DsizfOnM+nNEO6qlKgPF7AUSJa9AQmI3j3SEUB+qmzXzp8vzOm4mrtI597SwTIJpSj9I1rhx8Cwk+xtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C9yZ0HyM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C9yZ0HyM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 731242601C;
	Fri,  2 Feb 2024 14:02:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YBHpj4ajvIBrmqTYLNFtfTgQsmpozmLdwmzQgM
	RqPqg=; b=C9yZ0HyMuFgstBdVCV4M2qXMaNG5Fw6xejabtzRrymAtvSDVWcmXwJ
	KSZbfWdRFlYHsLqvKeLfKCQHukNw7rEpaKyVwzZnouMLhTL5YKH20gn7CzPYQy5c
	uf7kNElrxsKuxevJBBlnD4NPBEBpbq3nLgWiJXy0HfB60jtHlm7/4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F0182601B;
	Fri,  2 Feb 2024 14:02:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B35426018;
	Fri,  2 Feb 2024 14:02:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  Hans Meiser <brille1@hotmail.com>,
  Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
  git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <6b34d999-3da2-42ef-bfff-37c8f592347f@gmail.com> (Phillip Wood's
	message of "Fri, 2 Feb 2024 11:07:18 +0000")
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
	<DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
	<c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
	<DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
	<691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
	<6b34d999-3da2-42ef-bfff-37c8f592347f@gmail.com>
Date: Fri, 02 Feb 2024 11:02:34 -0800
Message-ID: <xmqqa5oisn91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A0ED0A58-C1FD-11EE-B059-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> While there are some aspects of the documentation that require a
> familiarity with the source I don't think that is true in general. If
> someone has a suggestion to improve part of the documentation that
> they found hard to understand we should be encouraging them to
> contribute a patch. There is no doubt that there are places where our
> documentation could be improved and it is not necessary to be a C
> programmer to contribute improvements to it.

True.  It is even possible to:

 - have a group of document nitpickers, whose charter is to improve
   the documentation by fixing spelling and grammar mistakes and
   mark-up mistakes, while making sure that what the original wanted
   to say is still what the updated version says.

 - have a gatekeeper who makes sure that the output from the above
   group is within the scope of its charter, before it is merged to
   the main tree.

Then, the choice of the collaboration medium among "document
nitpickers" can be delegated to the group, as long as the quality of
their output is tightly controlled by the gatekeeper to meet the bar
of the main tree.  The resulting history should be consistent with
the rest of the system when seen in "git shortlog" output, for
example.

The above is quite similar to how the l10n team works.  There is a
l10n coordinator who acts as the gatekeeper for po/ hierarchy, and
l10n folks coordinate among themselves without much supervision and
review of their output on the list.  We can treat the documentation
work that does not involve any knowledge of what the documentation
describes the same way.

Thanks.

