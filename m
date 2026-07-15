Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD5377ABD
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147541; cv=none; b=LZki/U6c0ltNlt7D/a2zM4ijWbMcbIzBaMdm3rDZmpzA7u7MxTQtBeyejNlckkTAJUfYSgHmnImGsbixYLFrlyZn1dqbHBFzXXfeUhSF+3xibaEuRfXlYztb82wo1IE7PHwL9brAPE0GO92migKwSGm2VZQ2wtQn69RGbnoWTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147541; c=relaxed/simple;
	bh=ityhvNri7BxKzdjkOINB1kFmPgLRsL/ZYmS0RPVX/b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtyhhgoGqyfrZXUy2XkhuYl44hynU3eJRbQUVkbtWp8rLmfWNV5ZtyltFO2hKzD5p1G8XXwnxpGiMH9r80IXyCi55X4GRNy+g4l2fQPTL6xgCmfLYcFaBbRx+bIaoJPlQCk2xNkz/MXy6fWlWhTleutkhTIXeCWD5rsL8BvhjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=axeKzWn1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyzpUEA0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="axeKzWn1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyzpUEA0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4730E1D000A6;
	Wed, 15 Jul 2026 16:32:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 16:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784147538; x=1784233938; bh=LrhESlyhIc
	4C9MfAh+OQ0GP67XvIrGTJ4fKOrNbTi+A=; b=axeKzWn1suw+LE324poxDjhLdM
	6AVqrpLZS6aKpn2+O7BN3NQWJVQi1gxGrSXjSdJrkDp98YE19TUKSOgJhZo79CUJ
	iBs99WH3MP6WFGGP+EK+we4run0lVeMPxJBxX6CAOcjDYRZDgEfBeYFIm8xWGenc
	Mnn+pdEA0sVkujDM6TLxWeHu5zINNSfmdSEoBjwuhz7tktao++O4VcvtvRjd0R+B
	v4wMhlvgmSLrLIFekQ5Zlw8CHDrl7vPJp4pyRj7YzCdejgzwjvf7v3MOsEYTyJMb
	tQ1LgbcwmwPgOzzFYoUX6O28Dvfzjf8+YZ6TcwD1ovttTtasPwuAUVYpRdww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784147538; x=1784233938; bh=LrhESlyhIc4C9MfAh+OQ0GP67XvIrGTJ4fK
	OrNbTi+A=; b=NyzpUEA0o/FVcYJUVz4ygiV7Orj3RyLJNpz6mSwd8HCFnHGDxJB
	LQYrDhZ3ySBr5/XgmJyyS36Ea8Caj8aiQyxuc1UcbtCry0fPRLk0eHhGD/hi9AXX
	DR1PgJaohINq34mr8N5CUB5NUBMypIqYv7ZrXfBEi+H3RKE5b8c+elv1TvLo/Tj9
	aW1NkCCRtSYmdCNkIAlJCEYlResZoA7oPtYRWRlXHJZ9UzD1q/YT1irlNVJby4R1
	fCsfHxSMZNK38r+LZDB8xQK48U5sroH4aemS2NxvE3rfovJfXbBW/MvoPIef6a5I
	Vclee6QmtcdsBJUxgAXQ0p9De7fhRm3Wf9w==
X-ME-Sender: <xms:Ue5XatJrTeBeHQpXL0-nVPO0EOVHQAyDj_61uxazSOJNYwAbdUIIPQ>
    <xme:Ue5Xalt7OQk01izjjdVOW-57YgSHIeqjAqLWGzVyZT5S6QI3xWBpcgIoVM7tk9MK0
    bybIVAOFnyaUiAkdb-xADgdNdAaUfD7_GVmDXtsbOdOQPdIEVkhEw>
X-ME-Received: <xmr:Ue5XaqKA16exRXA2osBs6R3_YwTRPro4zQ-bnspb7V0XMnZujoddgAvbAfZcehKmQDheKk9jWj1yPxzJj9ClH5Onhxj0JPk2dlLxx4M>
X-ME-Proxy-Cause: dmFkZTGLu6BpFFP/6EMarrVOJkO+7Vs1j3dDuJ8LDAE9LBJRdH0PkSjOlHQm60IFc3DeKo
    t0U0VdSJdzSemWVvhnyC3uj/psdpKElbSvQz4ih5F1nSZoiPn5uVBkvpxUtMVaAa9Q81mY
    HFIMHJTcoXbBlalbIp1JyX4piNyuUxCNrqz+cds7yUnahO07yVZ5qYUvaKwpU/G+wfNom6
    KDNL8TgjTfor2Hp9RJ0qEPjaJ8sIcc4jhyaNnB8tAHgG6zmtYCbpPHormX5YY6YZVvrdir
    tkj9rnqEGGJtEcz4JnZiELT2JZiFt+b6D61+KCLI4RBuFq+gOe6iNfQFCIjr4bo9gQTAYf
    kJU7i6NnovcThgLrY3DsI8uKaCfp5IALW5p6WZ5hF2XeAEKCfLSN2Y+gdzqb4CuESkwB1Y
    SzD1rKhI8NhesRFnVfeM0KJ42IKwd+OZ7vEmTkqKMAO4jSRDuTMizB35qgeUb2PNyZjjYO
    fKj8lkVNjChoOOlNpE/StElMuQ9r150SuRhjAugwJVJpvld7L4o/Wuccg21lI2T+oq1fLq
    n2FZvcHxwQi6RKF+ycVVatUQGGgfGOZp+3wMf6ioOf6pj4maW18WPrpu9LkzTTjlfsvncm
    FWqNTzhlSZH4IF9VdtOiC3mSZBuFZ3nmzUVXxWMdpP1iwbTI1QpDlpolFFpw
X-ME-Proxy: <xmx:Ue5XalNSIFa2UXUf6FuZb19vp5MXs1fqSZYljHmBy8ywJLIbikIJnA>
    <xmx:Ue5XalV3W_BNnX6VzjsUukbSZ54JYJzMqcFDLHTY6xW6ekpc6OMqyA>
    <xmx:Ue5XarmkhhVeBUIMX_BnLF9Qa3kBEpBp0BV_3ZzJcFX1llYGfqNdOA>
    <xmx:Ue5XasPBnv7sPOzMn7_ov9cRum2JRfJ5nUTXcggO1LZq3idCrshz8A>
    <xmx:Uu5XaoTzQzRE67DCbyjo5zvY5YQ-1MQD55eo4CPrDwtgkpn0OIanRVd6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 16:32:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>,  <chandrapratap3519@gmail.com>,
  <chriscool@tuxfamily.org>,  <eric.peijian@gmail.com>,
  <jltobler@gmail.com>,  <karthik.188@gmail.com>,  <peff@peff.net>,
  <toon@iotcl.com>
Subject: Re: [PATCH GSoC v18 13/13] cat-file: make remote-object-info
 allow-list dynamic
In-Reply-To: <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com> (Pablo Sabater's message
	of "Wed, 15 Jul 2026 20:52:40 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-13-34d7adb051bb@gmail.com>
	<xmqqcxwonnkx.fsf@gitster.g> <DJZDEE0G6ZRS.2RT8JTQQ6CUXB@gmail.com>
Date: Wed, 15 Jul 2026 13:32:16 -0700
Message-ID: <xmqqwluwj8of.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

>>> 2. Filters the request in fetch_object_info() dropping any option that
>>>    the server does not advertise.
>>>
>>> 3. After the fetching, the options that haven't been dropped are the ones
>>>    fetched and supported by the server, these supported options are
>>>    mapped and remote_allowed_atoms is populated with the placeholders.
>>>
>>> 4. expand_atom() checks remote_allowed_atoms with the same behaviour as
>>>    the static allow_list had.
>>
>> I am not sure I follow the above entirely.  Could you add a
>> concrete example to the commit message?
>>
>> For instance, if the client wants "%(objectsize) %(objectcolor)" and
>> the server only supports 'size' but not 'color', the filtering in
>> step (2) prevents the client from asking about the color, requesting
>> only the size instead.  When the server says the size is 42, step (3)
>> uses that to substitute '%(objectsize)'.  Would the end result then
>> be "42 %(objectcolor)"?
>
> You've gotten everything right until the last step, because we have only
> size from the server there is no data to match %(objectcolor) and the
> end result is an empty string for %(objeccolor):
>
> "42 "
>
> Note that %(objectcolor) doesn't exists and it would have die(), the
> empty string is only for known but unsupported placeholders.

It was not clear there is a distinction between "unknown" and
"known but unsupported".  The proposed log message needs to be
clarified to make this distinction obvious.

>> And if the request is only for "%(objectname)", an empty
>> object_info_options is given to get_remote_info().
>
> Right now 'name' is not part of the protocol as 'type' or 'size' are,
> 'objectname' is always allowed but only shown if it's present on the
> format.
> If the format is only "%(objectname)" then there's nothing to ask the
> server for.
>
> The current code avoids making the request if there's only objectname or
> nothing supported, but still goes through the connection work. I will
> add an early return to just output the oid back without any connection.

I think you are heading in the opposite direction.  Rather, when
only the object name is requested, I was hoping we would pick
something cheap to retrieve and ask the remote side for it, if
only to catch a bogus or missing object name.

Thanks.
