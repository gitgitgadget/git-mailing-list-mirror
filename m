Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6053D9029
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400636; cv=none; b=dG6ZPiSviww730vY5WDVLNAR75JZXN+ablEnbLZ0pcdU9XiBnwmpYZ78DrZ8ru5ExnNTFW3UdP2OkLi3wry/BPUUYQpWmODDKcN4UWkN0MU/l1STT5vNXe5Cj5qMGx/vl+IHiu+3Mztjpc0tjQoYGo8H+wwBnOL9/bgCRxyaPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400636; c=relaxed/simple;
	bh=DXxN0QWYE67Exe6kZ6ORiE8w7jU9SsSGH7qSeHqcC8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlGoPx5oAEMq18Yq+H6Oy99tEKBGH+tIqREFWQ3N13WzkiMJPf6h0Ft9DMvNZAZ/dxBdyPsztWeiiOqtN1DLCQli/Av04dogVkwQZ2Blxt6Yls7Nc9zjuGI3PncQkTogxvATebtiurivso1fqlx9IjwiTbekJh4VHcbVIghHM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JXUdIbQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XuVPpMMv; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JXUdIbQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XuVPpMMv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AD2E7A0036;
	Mon, 14 Sep 2026 11:43:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Sep 2026 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789400633;
	 x=1789487033; bh=oXPiGkLk9uVS7T9kNnQOVwDjyBjoRJn+DQ1ij3uVELU=; b=
	JXUdIbQvsPD3hyUQsL6J8daLk4Js7FIqB+mZGHbyDchgC8Uktbf5mcbn1TJbUPnd
	8pzSMMnmsE7vnVfMGLiy31ZyPFDl4QZ4/G+TPUMtwdT+lJzS1RhKSnqozL4Ehbrh
	8W3cMTT74ovy9wqOtWNxGGsmcwR3NALzU+XcJRzEPh7p6mTt+EtMBfLvXBhQa7e2
	73s7fBAyFuKDW6Y+GGZrJuFO1+7JWkGjvGGPx9uBy0XZ84tqyO5CnP2V4kObZqqD
	wLA/4XimEU51O1h7mMzA7r/uJaeOVjFaeZ+OoUYgpzxcXXkmBWBjf3Uxio4qwbKc
	4bzHDrgBzJfAa0SWMMzqVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789400633; x=
	1789487033; bh=oXPiGkLk9uVS7T9kNnQOVwDjyBjoRJn+DQ1ij3uVELU=; b=X
	uVPpMMvs7lh0aV0T4mCLzuxK+1urp7p6Z8NRjAwu0/bbCDyasEl+riabzMLlf6bH
	9URhB3H0WhOifWq+agDUkgO/h0gfeamI/TcIlMu747i/ox/BACVKmb40gn27Wngu
	36bSNEzUKjY2eooaWgEC7mR/rj1hFgQ7Li3UG4h3UNrKCfSMp2GJV7xJwZjZKw8+
	UaGM2DVma4FjRbSxwMo68GfBnT9a1CiGMOxwkzbIio5xHeDWJHG0ou3H6jNzcD5m
	WrTFGlYSWNLNVo7fVPi3Fgc6S0yD6JC0N2TT2lbzPNfG+jX6PEgGnbpWn1evPCe/
	o5HOg5xEhEmaAZMaORTgg==
X-ME-Sender: <xms:ORaoag0482tjoH8NbwZ1wERzLA_mbgcC8AVlzce0x2l91TJIkDaGpQ>
    <xme:ORaoauWTZKEW4310ghmIlrfh8iSL1HC8JVAoqGba5hO6fEhZ37dUb9RAmiWW7Mf0_
    EAUO61ciQGxbUfqeOCW2AJZ-xiBeC5a8AvUh1U9LDalEbh1I_9ahco>
X-ME-Received: <xmr:ORaoaiU6meq7xVgl2qt-i-gTZo7GbSWJd0xH9xG-zOrftVFKcxBw7TNckms-HpB-xbap5ir0Mh0qLwi1afSjC-LZvfS0M-w8IUu_g2wgitT_Kz2_3v_xCMY>
X-ME-Proxy-Cause: dmFkZTGB7joZjNr1kMryxyIC1KcdrxC6HofN2iVIURVfH/KuuEmcnK1gmmitKUVVXrb98R
    PD48LrZ8DJHIGnRi8kXtikb/F83v9Hh3QM/RHN450dnJJGCxTA44hA2Ftkhuwxn0h1x/tV
    H3WUjXDKUUnkENQj+cYsdgHZMOexhQymse5TRKU2/jTZHjOHc31ERwh2mnQOrZgZI2/Foj
    6DGIjDsi9WXxejigANBkT7PqOrU+f9EvqcqVtUj0IJB8fnhS3yg9JKVEO5JQkEQXC0cHSm
    ZKfPnsmwB4mKvpeHMS16XmquSJFNfCf173X5gHzHCcWms7A2yRBNkcnArxG+6xEzwOZUGW
    mOiu6UnZMtdFxnnIy4EM1x+rNGb50T9gIdSDYeKrIOogaWez3Wf64INobfUSPepOrGbRdq
    G8fDSGhn395JcUWttztyuPQJOZ/3OOakVK6d4xKR2ZxexEPw5RNAbi0Op9ujwKXqjSDqHW
    NgQV0ky8+AcqP4eDNRyiJTmXhFIKED2ZLdzkgc4KKLpkeXlSGD4PQpYjjZKtgguTvPgHVw
    zY/kNWdjyL3Oo1P7W7UdAv+vWwLn3nbG4JwQwAyCQFgt3rLoVsQb1xMtgaeHyaOybM/zod
    qPzRhkVcAttcGGeXWyU2Ott9as3YkBRQpKeKnZY33AESy5DFeyJdtAxa7iAA
X-ME-Proxy: <xmx:ORaoald7-KeLpSujGFoBUfdBHmWE_Umv5SyaIlPMNxVkM3UB2W3Vfw>
    <xmx:ORaoajUvYvRICiW-A1AD8J_bXpWVvXZOt-oUwu31Od1_xZhrTHC5_w>
    <xmx:ORaoamfB5iwg01s5YyauvIfQW5YimLY9h2pBFsm-EUVQ16hCxNzmFw>
    <xmx:ORaoanOjJXD3itt10uCeOLPTm1HMggwHuLZwtXgUcGxfJw4ScPcNMQ>
    <xmx:ORaoaokn9Aj4KlMcEzSk5LkmVf6YcNi5tGEzDwRlW94nz-9itilg4ZB7>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 11:43:52 -0400 (EDT)
Date: Mon, 14 Sep 2026 11:43:50 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] doc/pack-refs: convert synopsis and options to
 new style
Message-ID: <20260914154350.LjUwy8DF@teonanacatl.net>
References: <20260912191509.844954-1-tmz@pobox.com>
 <20260914124630.154107-2-tmz@pobox.com>
 <xmqqcxuf7svp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcxuf7svp.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Replace [verse] with [synopsis] in the SYNOPSIS block and remove
>> single-quote formatting from the command name.
>>
>> Backtick-quote all option terms in the OPTIONS section and convert
>> the standalone placeholder _<branch>_ in prose.
>>
>> Update the included pack-refs-options.adoc to backtick-quote all
>> configuration key terms.
> 
> Micronit.  I think you backtick-quoted `--all`, `--no-prune`, and
> friends, that are not configuration keyu terms but command line
> options.

Ahh, right you are.  That was due to my re-use of an earlier
example from Jean-Noël's work and an incomplete
proof-reading.  So I'll want to change "configuration key
terms" to something like "option terms" to match what
previous commits have used for similar changes.

Thanks for spotting.

-- 
Todd
