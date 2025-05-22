Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2A238C3D
	for <git@vger.kernel.org>; Thu, 22 May 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912367; cv=none; b=CUAX3hfGuZ6H6xJ2kpggpPqIcctoW9A6ZkJsWRtNvEAISGQEvnhov16y/P/BNntwnGcKy4qAg4KPhYm+ZX0GSkq+232F8k8Am7OB70ulrzFrpJljzuvo++pM0M4uWTHZIssUPpYqSMDGpKzh0HZzqjSGwbvNRV1rKO+Rv8xNaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912367; c=relaxed/simple;
	bh=KZHmUmVhkd7ubHil8LibvZOrsrD0oELphPrLC9/J8XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa+DUy72H91I3rXPvfwxa1KUh42tE83+lgts6bkpKZGlHirPFaAlWadkl7xOdgduw0SDJ0+pRxvIi2fhx5/yLqGJZPIfuefrLi5b69v/wIX1OL5FX9q7WxVIfdfc/I7XlgUXWYuShkDNZKLzQZIWR7+K6+D0r8mR1GYjoW10eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht7/S/rF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht7/S/rF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96790C4CEE4;
	Thu, 22 May 2025 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747912366;
	bh=KZHmUmVhkd7ubHil8LibvZOrsrD0oELphPrLC9/J8XA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ht7/S/rFFJlFLx8GMbF9kns3XwQGKD/hVqEeoLDqEh/fsasMg2Ntoh7zzUsdP+35o
	 NvjGlc4kJvF6DsOKJ9RBWP4B5JvMIFa6kEU9gSA3gNvbzIW7jzb58V7WxFbkZ7Swv5
	 sgH/pPJLysnPeRoJXs+thI57KOkbHomXDXHDQEkJeqzb0dXSAqSJ8tioU8iIRvrHst
	 1aPDzPuThND/n/F7xfvzasxi/nqGJQ9UE1qHiXiyvB5kA8cDDYygtV2kurpij/5rq3
	 h0ketxMLCXtegGPqEHDgmO0gFRuluzqFBDjLPgPtBZVP8pAtH7h8h8ndH3gl/ajH5U
	 zczKJxTazFJuA==
Message-ID: <79398137-999a-4d88-96d5-86d7184a9101@kernel.org>
Date: Thu, 22 May 2025 13:12:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Small patch to add support for MPTCP on Linux
Content-Language: en-GB, fr-BE
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Muhammad Nuzaihan <zaihan@unrealasia.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
 <aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
 <BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
 <aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
 <4YPEWS.J5JRNETKLXF1@unrealasia.net>
 <a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com> <xmqqo6vokvpv.fsf@gitster.g>
 <7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org>
 <xmqqfrgzjnhg.fsf@gitster.g>
 <202e1a66-72af-48f6-9b3b-7d7473db699e@kernel.org>
 <xmqqfrgzgctv.fsf@gitster.g>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <xmqqfrgzgctv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junio,

On 21/05/2025 00:02, Junio C Hamano wrote:
> Matthieu Baerts <matttbe@kernel.org> writes:
> 
>> Sorry, I was not clear. I meant "introducing MPTCP in the Linux kernel
>> couldn't impact other protocols in terms of memory allocated per socket
>> buffer or performances by adding extra checks a bit everywhere for example".
> 
> Ah, OK.  What you meant is that the networking maintainers did not
> allow you to affect the "normal" codepath when adding MPTCP support
> to their subsystem.

Yes, that's what I meant to say, but you better said it :)

> Which is conservative and probably a good thing, I guess.
> 
> But that choice means each and every application need to opt-in,
> which is cumbersome, inconvenient, and hampers adoption X-<.

Indeed... But it looks like it is often the case with new protocols and
extensions...

>> listening socket supporting MPTCP on the server side will return a
>> "plain" TCP socket to the userspace during the accept() call. That's why
>> we recommend enabling MPTCP on the server side by default if supported:
>> the impact is minimal, and MPTCP is only used when requested by the
>> clients -- which are usually the ones benefiting more from MPTCP
>> features. That's in fact the current behaviour for apps written in Go:
>> MPTCP is now enabled by default on the server side, and it is easy to
>> enable it on the client side when needed.
> 
> That reminds me about one thing I forgot to ask.
> 
> The git:// protocol is the only one we have control over what to ask
> to the socket() system call and the posted patch was about the
> client side [*].
> 
> On the other end of the connection, even though you could use the
> dedicatd "git daemon" process sitting and listening on a socket, my
> understanding is it is more common to spawn it via inetd(8).  Does
> it mean that the host needs to run inetd with MPTCP enabled?  I do
> not know how common that is.

Good point. Indeed, for the server side, someone should then also look
at inetd. I don't know how Muhammad's servers are deployed on his side.
From what I see, inetd relies on the /etc/protocols file, which should
already contain an entry for "mptcp", at least on Debian-like and
Fedora-like distributions. So 'inetd' should already support MPTCP.

@Muhammad: do you mind checking this case please?

> 
> Thanks.
> 
> [Footnote]
> 
> * On the public Internet, hopefully nobody is using that protocol
>   anymore, and instead using either https:// or ssh:// that gives
>   better integrity assurances.

Indeed. I already used MPTCP with ssh:// thanks to 'mptcpize', but that
looked more like a workaround. For the client side, if an option can be
set to ask to use MPTCP, this info should be passed to what is being
used for the HTTPS and SSH connections.

@Muhammad: do you plan to look at that too?


For HTTP(S), it looks like the libcurl is used. If yes, then
`CURLOPT_OPENSOCKETFUNCTION` can be used, see:

  https://github.com/curl/curl/pull/13278/files


For SSH, I'm a bit annoyed: we already asked OpenSSH maintainers to add
MPTCP support by sending small patches, but they didn't want it because
it is not officially supported by BSD... It is supported on Linux,
macOS, Windows with WSL, etc. but that's not enough apparently :-/ (or
maybe anyone here is able to convince them to support MPTCP by merging
one of the two patches we already sent them? :-D ). For more details and
workarounds:

 https://www.mptcp.dev/faq.html#how-to-enable-mptcp-support-with-openssh


Hopefully we will find a way to support MPTCP here in git (and SSH) :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

