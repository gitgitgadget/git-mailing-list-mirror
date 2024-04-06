Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B72119
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367296; cv=none; b=aY3chSWe5JGO3TG1vC2sQ2zKiTthF4Kt5cd4kY94x+mcrkAnn1Wlnm22mVizRkPkADT9Ag3UuwvxwzFwes+ZeL9pApdbBITZ71Jqi/bmeKCKkHrsL8bsTD9XSUQ6VibO5efHhCtePWZrJmizG8HGzpSFqrgsbggnNOgafDA5KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367296; c=relaxed/simple;
	bh=PhlO3dcudkSTKjvBt5jEh56nZW5OCJZqf+qFOs2CnRw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m3FNXX+yDhx1zpEvdkwOPEWngQQ5vB+M3D6d98N8d8vXPY2DQ2xXoS1vkpdFTYqSKlUak7bP4eCApJ9ujGR5nsct5rCm0tMQ9nFZkfwGLY2XJ4mCmV/7EZynUBm2lsQVHM41Cvz0F82vZZskj6n56p53Ix0WcNVZPC77RNcOUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d8K2+JhH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d8K2+JhH"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712367292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khOO0WO7guhsNBS6Ye/SIqF2l/J9nItpbW/m81e/caM=;
	b=d8K2+JhH7TaRMw5SmeVXomkSSYf66aoFIs3NgGandM7m3Aiy736hP6JxRC2I7hOSBdlnIT
	z6u65E3ueZisAyAgaoMws60Dkg3GjDDG6Q6yVPCHBkLIO5kOrm4BsD0d8AOC4Qx6grh94X
	mEDsCn6g1yypNCDBy30MctLVqU+Ss84H4xEDE5r0AB73w7v9lXsRFdcgRMrhh/aPFUe2im
	/haFeK5nOa55yob37lbIE4s/Ahx3pcYT4ShlyN58lbhJ3Cpa0JP2e9suE/T35W8xoDOaE9
	796nmcsjSD1bqFxMxgwacwflP1CTEcAj8A8TnAk6i2dAP+/13lzPsQS2UrtqeQ==
Date: Sat, 06 Apr 2024 03:34:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v3] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqttkfqnvm.fsf@gitster.g>
References: <e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org>
 <xmqq8r1rs39g.fsf@gitster.g> <235fa26a0803f7a8868fe908e4689bda@manjaro.org>
 <xmqqttkfqnvm.fsf@gitster.g>
Message-ID: <cd8ed09c0efa712aa93a45558bf6ad8e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 03:30, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> According to my research, the "->ornaments(0)" call should work in
>> all environments as expected.  It's also officially documented. [1]
>> 
>> [1] https://perldoc.perl.org/Term::ReadLine#ornaments
> 
> Go back to the DESCRIPTION section and realize that it is a
> front-end for different implementations.  The functions are listed
> in separate sections, the first section being "Minimal set of
> supported functions", the other one being "Additional" that may or
> may not be available/effective for everybody.  Which side does
> ornaments fall in that page?

Well spotted, thanks.  Perhaps it's the best to leave the prompts
as-is until I spend some time to cover the possible Perl platform
and package differences properly.

Furthermore, it would be useful to add some color coding to the
produced outputs, so the failures and successes could be spotted
even more easily, but that's perhaps a can of worms that's best
if left unopened.
