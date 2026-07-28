Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8974334DB
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263047; cv=none; b=E3sSckLWtzwhmy5ILXC8xaW0uvk+biSzVSX0BRBIfyKipgRJ1fWA8ZD6SMMq6OzJAcKN9lsLOq436UAoOfrK4OZv39QIkMPVgSvGwqI0qA2tQiHV8lS3IJI3tQbjY5m3AerAzWqBP9+TSjoqc62MPg2fTDuDxQHKEnQa41M1PGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263047; c=relaxed/simple;
	bh=lIrtGDFpgiLHl1ZwpAI12LVseznxnl+hDKfOWvlvnyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c0YAIxVoqOYHISD57SdkbKeaj8JTxWyHPuyDnnimJf0SjJQ0t6GnjyPhZfXCcGPl+v60adeoTjYLhz+9MOhsA4O/wLwZwa2btvqMvtluREajJjkZkV3hcyvA5PI4XL++Yy3cKP2BPkFzNuv27biELoFlUXhOKMHmGtWn3llE0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YEhlbOeN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mV4UoC0G; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YEhlbOeN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mV4UoC0G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDECD7A0486;
	Tue, 28 Jul 2026 14:24:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 28 Jul 2026 14:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785263044; x=1785349444; bh=b/Dlf3q9KB
	ScDdgUj03FrKJzcKBUWyMrLzr41Bg36cs=; b=YEhlbOeNONTWLd2IR9EOeApsac
	S7nWbtAsYZHp5gHh6uX8DxfBsuonTf2Pb9PbFvN5HdPdxKEVMJFZ/EHxkrr/RdiN
	KEdMz9L9O2z+cF1jzFuUkQiZnfWv76QfbTtgKmHRP4y7ywNqf/hGwGOfqxkO8qOP
	gEDKDYgzkHqDbBgSDkXrl0c1L87hjmPy+Ftni/kVBtSPSXBfiV7DdE8ez6howba+
	jKfGQ0PidCJJOgNJPVy6mMHCDaY2sKtlRRrM/ZXqXUpKQj7lq3rsuY1Vj1jqUVp0
	ibq33KadmSl+sSYr9ZyiIhHFityFmJW/fGrZv/d8UplI06BgNmoZnIgYKQyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785263044; x=1785349444; bh=b/Dlf3q9KBScDdgUj03FrKJzcKBUWyMrLzr
	41Bg36cs=; b=mV4UoC0GAvtCdMGVN2+xllNJxc4RF1GKCKXE5gFn2HLvq2Pun1g
	TfPLhqsmpwHC2Ev36n44Qq800UY0QQnnt8JJKYOhU7rAMXBC8O0eKMMPeB+yTsRh
	pk5LrXZ4zJcK4LQuEY8glWhCys0sSNRRBOzj31bPbHG0kEqv3zR9B8YZwds6ALAr
	72Ko/DNeoNxLbRreuAnp4WVkYK/an71IMeC52Fz0ezCd7tbR+7M9A1D12Ir/8Met
	9KQiT3iGnUzUekEJkvpnqzRp3iDaUw7if2fhPNqXZbZF0ajBaoL0ViDZSY5PzV+W
	OZltFvgoUbkhSTUUWcR6YrLrmg4iv47RSvA==
X-ME-Sender: <xms:xPNoary0imuk-DxM7BoXjX0PWeVNV3ekXWf2Q5M0PAtstQ2hLykRUQ>
    <xme:xPNoaljgjQyAPXFneG2rddpZETVwgynFxwq1OF3SdWgKPtVEerpbn-CaE2lFZTNbe
    RHzFuoEEhzHLAXeDswg1RWBrdfsYiyDvy3gvQd2z26O5FYGNQvK0w>
X-ME-Received: <xmr:xPNoanlxW9x1pMrUKPF66HOTKwLyf4AVQ8XR02JGFInBShgo87jWqzJmrmzcYJdvN8yyBpsEWpMgZCe2tzFj70v5taaR2DYHZw>
X-ME-Proxy-Cause: dmFkZTGg4AZtzp0jHJYZX74XjeK7ulBuhswMLqipQ17mvUuhxgC7F0TE4nPXrhssUp53Kd
    zClSgoHLbi/7mKfoIEYDB8kuCmo0rXt1CK3QRt/6m49QB9AxkvBE7AHZ9ygipIYqBzkWEf
    9bKHr1H2m0VOCY8f6xA2EPR9poVnxZkTz94voYwaXlHQJptiuQ0FbL+VnmK5IFPbb0n5SU
    wBGDls4FAitB7l7UtOO0VXP+WFBjQxpm81aCMnVxLwVqmpUib8RkUcOSrxkBSbVmRqBYPP
    NZP1wjeRr3RRIF6aUJ4/4Y+HP4A2M4jn7XJMcEp7vtrmRi6vC+R7hhWRkGtVV4uAwKRvpe
    vQwScaLn/NRT79o1Eq/XGGU5b4MkB3/VB91lQ948HGvXe0nSYiLzC6v5iodfwIXV7OXb3E
    /UCGPesOoT1VcnA1ua96r3lXETYsYRVE4uOZgSV3b87O4Yk/FECnjcaIX4mN2Mlc6G7zEO
    zl08sWWMXd9E3cPpurYtVbFotmOnruUOyKhzRoanT8/iwAuiL4XRiAJ2uOki9aj7p7m00Y
    blY0Ky8SQAYAUOTd0fnPKIaOwTQ++gOOiAt7N/ntpbwbjz/sKznmzuglEJYjAexL+Ai5HX
    8zphgmBo8bUwhebyylOGmxbK9lMykwE03JCC4Odnk6t3+u94w2QNQiHP1h2w
X-ME-Proxy: <xmx:xPNoarh0HRNKRn8OaSqu7TqjBz9nwGdYpFKA9fJIezJgBEaJdeHBMw>
    <xmx:xPNoar3WvAsABvjT5dyr46vx1X10Z7JfqAj4tEO08Q6MuAhdu7Unow>
    <xmx:xPNoakKc3tZDC1rzFsCazUXuNW2FtJMZIBXsV1CRHFK159fEg6qTmQ>
    <xmx:xPNoarwv3jlolD-Dzeg_ySyOcNtod1QbQ5DlL97jVW4yXZAUyQenxw>
    <xmx:xPNoatfHbi2C0Xs8ZB2_r8zjP1ZsNxc8r8no1BhUHRyW44pOMXZnmDP0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Hardik Kumar <hardikxk@gmail.com>,  git@vger.kernel.org,  =?utf-8?Q?Re?=
 =?utf-8?Q?n=C3=A9?= Scharfe
 <l.s.r@web.de>,  Patrick Steinhardt <ps@pks.im>,  Pablo Sabater
 <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v4] utf8: replace utf8_strwidth todo with descriptive
 comment
In-Reply-To: <c8fb2eba-c1c8-4f59-b467-e6d4766623d8@gmail.com> (Phillip Wood's
	message of "Tue, 28 Jul 2026 16:41:11 +0100")
References: <20260726123427.173877-1-hardikxk@gmail.com>
	<20260727211520.84289-1-hardikxk@gmail.com>
	<c8fb2eba-c1c8-4f59-b467-e6d4766623d8@gmail.com>
Date: Tue, 28 Jul 2026 11:24:03 -0700
Message-ID: <xmqq33x3dlbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I don't think this comment, or the lines below add anything useful to 
> the message. It would be better to say something like
>
> As we do not want to change the return type, update the comment to 
> explain that and the need for the explicit cast.

Perfect ;-)

>> diff --git a/utf8.c b/utf8.c
>> index 96460cc..1b55bd4 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -227,8 +227,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>>   	}
>>   
>>   	/*
>> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
>> -	 * return `size_t` instead of `int`.
>> +	 * The function is used in multiple locations where the callers
>> +	 * expect the result to be a signed int value. We cast the
>> +	 * result to an int to avoid changing signatures of all callers.
>
> The last sentence does not really capture the reasons given in the 
> message of the commit that added this comment. If you haven't done so 
> already you should read it - see 937b71cc8b (utf8: fix overflow when 
> returning string width, 2022-12-01). The fundamental reason to call 
> cast_size_t_to_int(), rather than relying on an implicit conversion to 
> the return type, is not about changing signatures, it is about avoiding 
> an overflow that caused git to crash.

The comment should also answer why the callers want an int, and
whether that is a legitimate need.  Topics the comment may want to
cover include:

   - Callers want display width; we will never deal with output
     wider than 2 billion columns, so int is adequate, provided we
     do not cause bugs due to integer wraparound.

   - The return value is used to compute width in constructs like:

        printf("%*s", width, string)

     which requires int, not size_t.  Instead of forcing these
     callers to call cast_size_t_to_int() individually, this
     function should return int after ensuring the value is correct
     without wraparound.

This is in addition to explaining why we want cast_size_t_to_int(),
as you described above.

> When you send a new version of the patch please CC everyone who 
> commented on previous versions so they don't have to trawl the list to 
> find it.

Thanks.
