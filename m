Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222B1AAD7
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736731; cv=none; b=sXunG3POVLALw3GFAspytTmwsMwXQfdQIy8/qp/XUuiXwD8OXuK23VCvwt0odNXjJXUlMj6HnoIKtHaMYcWMfJjIeV6I1bVykob2wcCm2l/lD+rwCH143e04Ix7KAnObqxgGL1QjTqpUYpXGYdE0H3/EhXYerko8lW2BRuqpmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736731; c=relaxed/simple;
	bh=vLSH/kDlHxTtZpHqICs1B2dDGYKR6fuE3MtqiW1U5cA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mk6P3EHe8/ni04N7APvz9LnJ9dlDIJ9GyCDtWJCuMNLiGTzXzfwJ++U2vl7HlgyTxaBarS0BvpGMxa4EN4LEttv7JJojsPDHJrU7NgJAXzq/3BVpDpnqLwrVAVriKeRlOQI+8xDH6XXZAcdckDTvuzHHMsTTkTaoUpmzdJFLRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xXh81MTQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xXh81MTQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A0E629799;
	Mon, 18 Mar 2024 00:38:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vLSH/kDlHxTtZpHqICs1B2dDGYKR6fuE3MtqiW
	1U5cA=; b=xXh81MTQUnts7k1I7x+1fDGBAYQBJNwYPbGbG7wUOfN/58ukjhoUaK
	GxebmVDQR4aappxOEVQtrzL8VtA+bl+x3aM5VelNNSetOFWtI9ic4EgWCH63Pao4
	2hrqjDM4dd9sYTQ6qXqeYvHnAtITlAdIjJ0sSDO87iBnX1Rh+jsxU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7552429798;
	Mon, 18 Mar 2024 00:38:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0840D29797;
	Mon, 18 Mar 2024 00:38:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org,
  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 17 Mar 2024 22:48:14 -0400")
References: <cover.1710646998.git.dsimic@manjaro.org>
	<9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
	<CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
	<9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
	<CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
Date: Sun, 17 Mar 2024 21:38:38 -0700
Message-ID: <xmqqttl4kvch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6488410C-E4E1-11EE-B912-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> >> +       x_to_tab >.git/config <<-\EOF
>> >> +       [section]
>> >> +               Xsolid = rock
>> >> +               Xsparse = big XX blue
>> >> +               ...
>> >> +       EOF
>> >> +'

Just this part.

> My assumption, perhaps incorrectly, was that existing tests already
> verified correct behavior of leading whitespace and that the tests
> added by this patch were about internal whitespace. If that's not the
> case (and perhaps I didn't fully digest the commit message) then my
> question about the leading "X" is off the mark.
>
> If these new tests are also checking leading whitespace behavior, then
> to improve coverage, would it make sense to have the leading "X" on
> some lines but not others?

If "<<-" (I have here-doc but please strip the leading tabs because
I am aligning the here-doc with them) gets in the way for testing
material with leading tabs, the way to write and preprocess such a
here-doc is:

	sed -e 's/^|//' -e 's/Q/   /g' >.git/config <<-\EOF
	|[section]
	|	solid = rock
	|	sparse = big QQ blue
	|	...
	EOF

It will make it clear where the left-edge of the "sheet of paper"
is, removal of leading '|' does not get in the way of using '|' in
the middle of the line if needed, and Q being the least used letter
makes them stand out more in the middle of the line.  As it is
obvious that what is before solid and sparse is a tab (otherwise you
would not be using that '|' trick), you do not have to write Xsolid
or Qsolid there and still the result is much easier to read.

