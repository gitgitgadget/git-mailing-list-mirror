Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179D63CF
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766918; cv=none; b=lbVRfIlTa4h4LAYweQ7hNCXZOzSHepDklZ5BY34Z+/kkkSQCtKQBwzITc5VDmx7oawZxdWryiyjoXRGaBlnrM3+ExL8EwUhC9SF99d1bJRZthxKPJEA9t7X7MIzPyBM3XzCmO3TAMOd8WbpH0JvUfqFxRvrCh55HkwCsjk4qlKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766918; c=relaxed/simple;
	bh=hNH6UhZTnF/21uph6MeO5bsLw5artIuXzPdbyVcUCTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNd0hYo5DMEYkm00ngtn8CqJeiSeZRsTX88sO0I5rIiFAgBxI4iRyMc/WmwmzV5Vj0TkjgdGKaHCU9ogkmIivaB4q/Bw3kSmm9UlXoedpWtN/84VeJ1ujCbqOXfZn1VTOzxcshDNFYnegBdlNID69mOsC0IZ8Kqej0r1Iu31G4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fITpUaXa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fITpUaXa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A73BB27AAA;
	Fri,  3 May 2024 16:08:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hNH6UhZTnF/21uph6MeO5bsLw5artIuXzPdbyV
	cUCTQ=; b=fITpUaXawH3eWxkNUB4FxNI4taRcEyVKpCWoHtXMJvu/e2cqLyfBWk
	Nz18igaFpz6wHCWPUEWNNM1eiTPSeFbNM88x/3KClnA4pZz8bgL9b4It91k7V7jI
	rschW13wdcTy8/yU2dSehGdMUt+2g+HfS3Scq5YD0tZhlnC6XNWQo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ECCA27AA9;
	Fri,  3 May 2024 16:08:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C22227AA8;
	Fri,  3 May 2024 16:08:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  James Liu <james@jamesliu.io>,
  git@vger.kernel.org
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
In-Reply-To: <xmqqbk5m65i8.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	03 May 2024 12:48:47 -0700")
References: <20240430014724.83813-1-james@jamesliu.io>
	<20240503071706.78109-1-james@jamesliu.io>
	<ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
	<xmqqjzka7p2t.fsf_-_@gitster.g>
	<CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
	<xmqqbk5m65i8.fsf@gitster.g>
Date: Fri, 03 May 2024 13:08:34 -0700
Message-ID: <xmqq4jbe64l9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EBF4A40C-0988-11EF-ACC9-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> different. Aren't both commands addressing the same use-case of
>> comparing one version of a series against a subsequent version? In
>> your response[3], you seemed to agree with that observation and
>> suggested instead simply increasing the default creation factor for
>> both commands (which sounds reasonable to me).
>
> I think Dscho's use case was compare only single updated series of
> his with seen that has tons of irrelevant other patches, to have the
> command sift the patches belong to other topics away while making
> comparison with the older incarnation of his topic.  I never use the
> command for such a comparison, but I can imagine that in such a
> context lower criteria may help reduce false matches of his new
> commits with unrelated commits on 'seen'.

It seems that Dscho was in agreement that format-patch's use case
should try to be more aggressive at least back then.  In the message
in the thread you pointed

 https://lore.kernel.org/git/nycvar.QRO.7.76.6.1903211209280.41@tvgsbejvaqbjf.bet/

he does not give us the exact reason why he does not think the "more
aggressive" mode is not suitable for other use cases, though.

A similar thread was raised more recently:

 https://lore.kernel.org/git/rq6919s9-qspp-rn6o-n704-r0400q10747r@tzk.qr/

Also, there was an attempt to clarify what the "factor" really
meant, but we did not get a real conclusion other than the UNIT to
measure the "factor" is called "percent" (without specifying what
100% is relative to, "percent" does not mean much to guide users
to guess what the right value would be).

 https://lore.kernel.org/git/85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr/

So, yes, --creation-factor=<value> is messy, I think a very high
value, much higher than the hardcoded default of 60, is more
appropriate for use in format-patch, but we do not know what bad
effect it would have if we used much higher default everywhere.


