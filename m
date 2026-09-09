Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136BE4CCDD3
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979868; cv=none; b=ap2+LmTrKPrGCmr3aU77nV/FvT8f3gXhZFSsIJlaJrDZMWA4cLx63s1MPIDFgYTRJ5lVg55QlYoxqZAR2//OgLvK2gVwAUUGJxt1W3TmscA/TAxqhvIyqEaGddf3DUf0zZU3O6HUYVix2Nsyv3YTmpRM9oortEy/Dsoqt/ENMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979868; c=relaxed/simple;
	bh=6BOXLNPuo/chrzuOoAjF2M0yfMHj4cMQh1w61BLuAJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/UV73XQD4+ii5hL5ovDzxrTddx26zRYtm/uJJH11R6cHZt9598CkmgeMWmXqIkHc2HCGxCSGgFSyOrdYsrPU/tkfICGEWIljq2kAkLeLdIAFvi6r7rjE9s0T44RimEDyIfBocdnSaltCxsi1Qo7p1T51E5W/OW3yHuOx4wVUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rJrTPdmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+daEXu3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJrTPdmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+daEXu3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 21CACEC0192;
	Wed,  9 Sep 2026 14:51:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 14:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788979865; x=1789066265; bh=6wKhcUJyK2
	qeATkxJ+m5yPBkMYM+hYSGFRfsrevE/RM=; b=rJrTPdmmSwumsQSsQCdH5RU1PP
	+AR+qDiH7M5FUAhbj8wn8F1q/LgO+ArkDIZ9ZCRuiOsAaXHltCuvRp+rTmCsbSqs
	s1j4FbsmIQQQtsdasdzKgp4ZvkpmuLKoS4SBeeG69ULn4Jtbcdweew3+JKeJrBhN
	1yBOyU1bARMnFZJym1aDwFhPTUWtf1Pr9jtgOWyg+8PG1MsYTtBoGQ5Jc6uUduMV
	rlfYoCGJ0YkjZr7nr4f+rQVfRSmS9V/19MUtFfbDr4+qGxct7w39AI9ps7RzwEXU
	m2BmGJoYV2679bTwKbEIHKHHtU7uAuS8vGalD6FEc+Ukj52QOghQu6OKpssQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788979865; x=1789066265; bh=6wKhcUJyK2qeATkxJ+m5yPBkMYM+hYSGFRf
	srevE/RM=; b=G+daEXu3Bpbx4zwLWxXu0MVTN5PiB7+n/NNwNiAznT6sQM3nzHg
	rEVtJQ1dpKAvi5A62yO8Yl0Q7/j0kWMUL70CWXYrsEDVRxMsTmh1Y6HqZVhueZ6e
	1vnj9/JMR5Xu7QjSes9UVX9+QpDLOgFTNnDUnSzMaPk1EOrncxNl0+DJvQFwTCPP
	iIrbv+0e0mQFtZWHUY6uuEZ2EvC4I2PWDHMPq9dw0eaXdk3NqBMi4Ah5Y8jJ7XHC
	CFS7o8WosQzoUIAdtgdpZsQ3uOYh8BEldAnKMzwOLcYsUF/Aa9E51nSz3hdD5Psh
	qpk3trTh2YJlDYeIOrA12KxiPgVgrRZtchw==
X-ME-Sender: <xms:mKqhajXW-f2DTmtYZZaeAK2QU3TpFh158pmVe1nEpGvpvWZKoixXcQ>
    <xme:mKqhaie53CM0swoyq06dbd_zuaU4fjYCcp3SF9S1oafj9tUBUzqzXXH6ZunUf_edi
    MSYBd43h2NDBgKPRjq-BgXfRr6uqGjyyJYozfyreuq0g5gOJdTKf3Y>
X-ME-Received: <xmr:mKqhantyWri_K9M2wCZACk_Sdx8S2QqhycG8-G4N6hVshPw9Xmn-Mz2O6k8Zc6Zm33EzmtaaJfNkfZLcJTIoM3Sy1GNhIR887LLN>
X-ME-Proxy-Cause: dmFkZTFEL0a5qwePrNeEqd49NGmozxMYkBQCOLnwe+VDYAJ0fZcxt9MxO2Hdd6dcNyEJ4v
    6udqqfDn3bSbSM0oXjf59+82OLf416+WlUnZQnkjQcccszcAbJbrkGKGDzkBRPVaaXe8yf
    +sfgz99dJPXlhhqmBdY7KrXvSDV/pfqQji3+7unwCPQK8SZoIzg1VLLO0VaYOd/0+FLytL
    k2Rz8Up+YPCsYCNC+f9l8ltXsCr2WGqTVyI4snBK7tJUd7g6ZdFMOmlU6iOoFuL9n6D8w3
    lq2ro2fmzoN5Xema5eOE2Xt6Pz+cE0TS5aH1SvpzVaNTmuY0TuGOTP+HCTJM+gOVYixEAp
    /KuKWKQ++B+Mb7U9g61IGHTi8afldxdpFa/A7LV8nSVOnsPBfnhak8IGTg7TE0X/5Dm6EZ
    vkHkI1uIrzsrRElRxGcX/enw7QTipGzkqXglJ+wlK+WDJeijA/CQpPBnHHq8YLFfBAm0Tp
    Xw4/5im7LxXxPfPVeTDuF+NpfC5ZAAuOQ7mwvBrmzlCZlh/Vhj3h5na5p4otkf8IZBQklP
    HJuYgjC03Swgi+UxsQelOD0G/kzBdM5T84ndeo66jTa0mYRz+sJcKG7h1QyHPSUwwrihRP
    jDR6VflO90vqXtnXHNzZ24Qtg5ldmcYdvarsyvxpjdTyHM5FfIvbyUMSA0KQ
X-ME-Proxy: <xmx:mKqhap9qYnoqXp49LLPoc0rV-zmck6F-xa9jA_5nd52Yp9N9dHO24A>
    <xmx:mKqhaq38W-m1miYTJFCZUULckgEh87JPuExh9ebWxz1rYaIqKMjryQ>
    <xmx:mKqhamBdpvrzfX_xMr1loWQM_NK-qeTAPfq1oQsgg6X0wVaRXCboWw>
    <xmx:mKqhaudJc9t2VA5Ev5bUP6cflkRrgKUCwzx4zJGP-ZlpAaX9g94Q4g>
    <xmx:maqharCPl-qccGRCmEOtYXaidd214IVvad4HFLc8-AqgLn4xymvX1Vsh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 14:51:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>,  ben.knoble@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
In-Reply-To: <20260909155440.GA94069@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 9 Sep 2026 11:54:40 -0400")
References: <xmqqik4fyaav.fsf@gitster.g>
	<20260908213840.37833-1-ub4nal@mail.ru> <xmqqik4fwoz5.fsf@gitster.g>
	<20260909155440.GA94069@coredump.intra.peff.net>
Date: Wed, 09 Sep 2026 11:51:03 -0700
Message-ID: <xmqqv78eqmw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Sep 08, 2026 at 11:57:18AM -0700, Junio C Hamano wrote:
>
>> Vsevolod Myalitsin <ub4nal@mail.ru> writes:
>> 
>> > Yes, I agree that passing the "advice_setting" itself is cleaner and
>> > more future-proof. I will change "vadvise()" to take a pointer to the
>> > corresponding "advice_setting" instead.
>> 
>> One minor glitch is that there is an ad-hoc vadvise() call in
>> advise() that is not tied to any particular entry in the
>> advise_setting[] table.  I think we'd need to give a name to the
>> advice_setting struct type, instanciate an ad-hoc instance on stack,
>> and pass it down the callchain, perhaps like so:
>
> Isn't this a natural fit for NULL?

Perfect.

> As a side note, I think this is revealing some existing shortcomings in
> the callers.  Most of the calls to advise() are doing something like:
>
>   if (advice_is_enabled(ADVICE_FOO))
> 	advise("ask your doctor about foo");

Yes, but all of these callers call advice_enabled() without _is ;-)

>
> Those won't get the "turn this off with advice.foo instructions". Only:
>
>   advise_if_enabled(ADVICE_FOO, "ask your doctor about foo");
>
> will. So there are many missed opportunities for offering the turn-off
> instructions. Nobody seems to have complained, which makes me wonder if
> the turn-off instructions would be annoyingly chatty if we printed them
> all the time. Most of those calls predate the addition if the turn-off
> instructions and advise_if_enabled(), which was added in 2020. I wonder
> how people would feel if we converted them all and started printing the
> turn-off instructions everywhere.

Depends on how we do so, I guess.  Do you mean we should rewrite
advise() call above to advice_if_enabled(), even though the check
for ADVICE_FOO token appear redundant?

> Anyway, UI philosophizing aside, another obvious pattern for advise()
> is:
>
>   if (advice_is_enabled(ADVICE_FOO)) {
> 	/* do lots of work */
> 	advise("try %s", results_of_work);
>   }

Yes, checking with is-enabled primarily for the purpose of skipping
"do lots of work" is a very typical use.  I do not know why you
assume ...

>
> which _wouldn't_ want to convert to advise_if_enabled().

... this "try X" is something the users would not want to learn how
to disable, but assuming it is not, the existing code above as-is
should be what we want.

> If that wants
> the turn-off message, we'd want to be able to pass the advice enum to
> advise(), like:
>
>   advise(ADVICE_FOO, "try %s", results_of_work);
>
> at which point we might need a way to pass the NULL advice marker
> somehow (for those cases which really aren't tied to a config value,
> though arguably that is an anti-pattern in itself).
>
> I guess the caller could just do:
>
>   advise_if_enabled(ADVICE_FOO, ...);
>
> inside the block. We know that it's enabled, but it's not like the check
> is expensive.

Yes, I think we already have some callers that do so, in a pattern
where they want to skip the "do lots of work" part.  Or at least I
think I suggested the pattern in the past for somebody who wanted to
do that.

