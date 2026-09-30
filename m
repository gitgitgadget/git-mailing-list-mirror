Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE4403B1B
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806071; cv=none; b=pHeBQgFAHJ2ZPUgsR8wyjDzt/p497B4KKPmnidQdE08v1aR9iz+MjkZH+ZXYglkYjqElRzm1gPZWfsnNUh/9V8qh2/h4Wr2fb7LXKxhxNNBxN6B4UiWKHU9HhXBJDCtANhnt3UHlbc4TUtWM7Ju6kg+YStFe0aYZlNEnemRc3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806071; c=relaxed/simple;
	bh=QFbgHmFdP+o5KaFS5xLVOaLsumqXKen4EuKsszMkeW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VtxANLiUexXKvGjqOvU5VOxP/6NcBqEuxcVulEWPOsvsbTMU2m91G5Odr+u3hyY/KrPnS/jw80kQwNoZmGnpmZpqA03Rym+UgxoBAWc33G+lkSdR3UUi7jU0Mp0pUubMrGZFE7jhJ+wuJObT0rDCvXiJl0CouLLkX1SM5uBDIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jYFrlLjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bl5oMAUW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jYFrlLjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bl5oMAUW"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EB6BEC029B;
	Wed, 30 Sep 2026 18:07:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 18:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790806066;
	 x=1790892466; bh=mLuiHzYCMdhw1T9PUXfXO+9TiM04dlO6Uq0LoaMdFFo=; b=
	jYFrlLjFUAeo60rvQefXmxwc7hwxygDjb5UZtjssRdYv1y2J5spYAd7AuSUYzn12
	1OLgT9pzvO1aEQxRFtQOoERkXZN+SgkWsx44oewUh3okszHV4z9d6YicIXLRXg/q
	SZrExf/GY8oCjkcQo3vu2LG3qXwAUBAF1Fh3hQa3azsHNSST7Y/A008IviPBiLeT
	wC5RGJNzDHO1Rw+SM9qNR6QMOWY4aBwI7UCCDkrMNVpwI4ps6SNzj88zIsh/6iEB
	QZ3Uu8kCBTPlZ8fjnz1+Jih71sU4uxWMPdjB7D/Q8R7mgO/l9ncIWnkhA3yugsXG
	0T2g+SJL67XBf1YF5fmsbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790806066; x=
	1790892466; bh=mLuiHzYCMdhw1T9PUXfXO+9TiM04dlO6Uq0LoaMdFFo=; b=B
	l5oMAUWKJB3fz0jqJQ5JRsWJ5ycgwnLZYFXf2/FTt/z7Yj7zIwbA3hiCcpy/hITI
	p2CyCmqhsTQnxOc5VBsW9PkHBO2/7CHxiejOTxsZVix1PtO8VdN86qeLVpLGVKUv
	ke7NgszSjuVF7yLPPaQz3jsP01du5KdIn40m7cVZIdijGCawtDMvCPef6KcpC9If
	BqX0g/fWl6G9UIStzI/BHb+ZXcIxq0+rUj9/74BMkzsMwgnl0+ek2cKZwPBI0kee
	LLUs+4bgSjKWJ2VT1I/yo4XH4IEiRxpctWS+mS6dMoe6g7J6h2eX4GYulM72ZiIv
	bC26hxVuqpNCewtjnA0XQ==
X-ME-Sender: <xms:Moi9akolCbD1g7o7r5oDyGPUDkHnBaKEOLqlHv79pkpUiLezha2eTg>
    <xme:Moi9ahhDytKBF425VoHJnBOsUn2GT5yOk5skfYywmOpNizUeeZLAZCAYCBgeqUPvh
    GggZ4HXz0LD-LFbQqidFGzs6NK16vJokpkobtZGrIqQA3M5ZJprJWs>
X-ME-Received: <xmr:Moi9ahi0mMVPKz8Hm06vV6tqC-lPMxW9cfsBgSLJk-eJ4IoqAHZo7FSIupl0wdvGKIc86KicsXiOobImxv-iI9cdrPtCN5AbNzPc>
X-ME-Proxy-Cause: dmFkZTEh47nuw0p/2WigAatICSMk0Juewkmi4SwJum7EoLtnHfOPRAiES3mdx+vw2HEgNU
    V7SIN1uHkWE/rLGfSOPE7rcR55uehkcjXn8EPYH0Ei7iCZ74nSQPJJRqg12uj6bvHNgwUh
    50sdzXiV094nKTPWpYZHgnYHufeQnDiPSz4B+Q1y+stbnJsY+lnCZt5PdvZqFCQfiPKUKp
    NjAFgJp3uF2gkchWzsaATgY9RMFvMB8W2h1QzAUxiVYN1zVqpQj8rIhcj0EPaWiGoc3E4O
    4a+7/yTbrtmu9jZ3vFzACo10PgUS0djf/eZX9bBcaRe/bmI0jAgi8hXDvqdpUET9qB2RTZ
    bfXy4L5jUd6zGvFb9weHgT23HBu+gEk7I4G4U7RBPA0WjMz8tHhi+PaecAlVf3ylz4hHdg
    ZnTTomEFB6OGOZcIb5wACv2dxVxW1PBZzuz4+9TX1mHmCzOoiZ/wwncfdNlrA/B4yfvim2
    nyaXV4jx8uNNlGeee7b7x67tDqIGVdUW+xf9nxJvq0vZfbvY2EfFl8QY8jl06JmiogOmDF
    2QMxnFf60T896XWOMtL4hamv4vtakb6z2/OdDDuxVIyI9/X57abaV3iJYY4kPiCX3xV1Ar
    DqLArLleRdlc8t4Bzey0UXxeiNeI1+Xp5LN2PUgR7PN/bPxUpD3DKzoPTP+Q
X-ME-Proxy: <xmx:Moi9anhok69eoT43r3Lw0bc8C8dKD4ky2rcWPMmnw6jP4y6N4f79SA>
    <xmx:Moi9ahIIVcX9XDT_fu7l8EaF4miZJdf4VsdbkozsaJ_VntZtD5fjkA>
    <xmx:Moi9amH1CHse2q9cUiLBfZ-Y6lwFEluZ-cA-MYcbXPqGOo9Px1c8Qg>
    <xmx:Moi9alTo6hiEDlT2JUvx-qezAPVSef_KCAjwYm2a_invY3-sqoIMmA>
    <xmx:Moi9aqwQZLoQKwzIowmHuPAmWjS3sBXe9WIyrAg6Dgkr0qsWxsnZZNRy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 18:07:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] object-name: accept @{p} as short for @{push}
In-Reply-To: <CALnO6CBR0XJUJR=2e5kUM8Fk9aV5uz+QxajRpnFFVTEkFfJQ3Q@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 30 Sep 2026 17:39:03 -0400")
References: <pull.2431.git.git.1790797186658.gitgitgadget@gmail.com>
	<CALnO6CBR0XJUJR=2e5kUM8Fk9aV5uz+QxajRpnFFVTEkFfJQ3Q@mail.gmail.com>
Date: Wed, 30 Sep 2026 15:07:44 -0700
Message-ID: <xmqqbj9e8kb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Wed, Sep 30, 2026 at 4:06 PM Harald Nordgren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Typing "git log @{p}.." fails with "unknown revision", even though
>> "@{u}" works as the short form of "@{upstream}". Users who reach for
>> the one letter spelling of the push destination by analogy get an
>> error.
>>
>> Accept "@{p}" wherever "@{push}" is accepted, in any case, just like
>> "@{u}".
>
> I've oft wanted this. Though, I don't have a `p = push` (or `p =
> pull`) alias set, because it could be short for either!
>
> There's no "@{pull}", though, so that reasoning doesn't apply here.

Interesting thing to point out.  Letting @{push} squat on @{p} would
prevent us from adding @{pull} and anything that begins with 'p' in
the future (like 'previous', perhaps?).

> I have to wonder if there's an older discussion around these notations
> that explains why one got shorthand and the other didn't?

But we have lived with only two at_marks in the object name syntax,
for upstream and for push, and nothing else for quite some time.
So perhaps it is OK to assume that we do not have to worry about any
new ones in the future?

Digging the history, @{upstream} came in 2010 and @{push} came in
2015.

@{u} existed since the inception of @{upstream}, as we can see in
https://lore.kernel.org/git/20150331173740.GE18912@peff.net/ which
is the first iteration of the patch set that added @{push}.  It is
unclear what was said during the review of v2 [*] but in the review
of v3 https://lore.kernel.org/git/20150521045233.GA26507@peff.net/,
nobody questioned the asymmetry between @{upstream} having a
short-and-sweet @{u} while @{push} lacked the corresponding @{p}.

I do not know if that was because "push" was so short and easy to
type anyway?


[Footnote]

 * https://public-inbox.org/git/?q=gmane:268185 would have given us
   a good way to find what thread Peff was referring to in the cover
   letter of v3 iteration:

   https://lore.kernel.org/git/20150521044429.GA5857@peff.net/

   Unfortunately, we are getting 502 back X-<.
