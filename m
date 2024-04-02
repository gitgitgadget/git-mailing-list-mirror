Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141E65BBB
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066055; cv=none; b=KC+gaqf0gZFjMeNTROGeAfUgiJwQcFpcM3oPatLAjCNGBF1EBDgibQtVX3/3ZBBIvaqjNafuDeJnq7WI6b5FxaobR3xFAbpK8zwiDTZhkcaCZHJYQB/WZG9//2kVoy2XIwvou5ZnxUc8tCUq9wSPgPYIq6gFbXi2agWZuLqe0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066055; c=relaxed/simple;
	bh=3F9lxDeYSZ6na8UIwrCc95dwHHt7uknCVMuSjrfowdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEFxJ5XHvprbbwBwTOnWiPe2G+sGR55kQ/f63no1pqdopIs+kUcylp0iI1EJdwOX+bGawGK0qUyp8+FJRFm1mcp7KoTuOd/Un56X8V3/EraHLbfcdjxDjiheYQIQoSXHIBpSWDKC/ZnyLb3UFLkAJQk5a57O6RmeOOoy7FPUvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=awM+S0XJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="awM+S0XJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712066045; x=1712670845; i=l.s.r@web.de;
	bh=2UpthESSUDIxZEquoTXqQbRzfhUaF3wotQY03rBV2HM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=awM+S0XJw1x5XzEs+4nElZ3V/5qtm0mQqTGtY3hdYq1cQucKOUrtxs57fQPLQzGq
	 aEL5oCwG8MbjDPOvJ3d3VzSMPl/+eP8bEvh6AZyld9HNzmG61xR/+DT55NxGXz+v3
	 UnNNgDx2fbe7ThahuMAO5wBDCbAL1RT13t+95oZ7iT+QqewHkDJV7mgEHAKxIu87g
	 nBsr0SL3oSoE+DVRvfZN4bVQphha1YKtJUIH7PX9/eji0cd+7s3tkM1IiWz0hUlZ8
	 RYcQJqD5MUyLXJ81iu/L4Pk9o6ZI73hXgilwC3Bfiycbj0QQF14vnlour8g5qO2z3
	 0vSM8pPPk6SzQCa0ZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1scrCv0csF-00pJ0j; Tue, 02
 Apr 2024 15:48:46 +0200
Message-ID: <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
Date: Tue, 2 Apr 2024 15:48:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240401033642.GB2639525@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h4cz+qSLSqDG2hnN5vs3USiM6JHDNCbZKUCMjdq+mqg+V0UVHVb
 kmiBZ3JHexHg8iWXe0L5AccWmbTFvNN6INnYJY/P491Ym5OOfxFhLePUV62Y5UcrGWdVr8t
 OOxHxlGhr3mvB8cTp6WEqenU27qeCfDIFOQFCt9keQZgd1Pme8C6S2ol3kshiL05HtQyZ6+
 m1kD1uEmszKCPKXGQvhvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TR/fyrpjo7k=;UGLm4EIbQyTclEe+4EX+rkiOBPj
 MF6vYie5HIargnrdjRbwAbNyRLVNYyD/vImAPTj3iRg6ndglsQwVRvdRAzi+l7/oGHTlyEPnH
 w6aUhmH+TEOeONkBP7oh6Mr4+NTP3jtm9lY0F9zPN3FueZrS/gehxLuENgu3E8w+qxgpK737E
 kHJSzYzVKMVIcs83oZ2xiddCwMIuQ7LqXoWFef1Vvvk8j7SSSNlbCCIwmb+/6AoXO6/cqymhm
 ++AazpP276qsr3EvUpDUeMhAFvJKMVPsUIiW1V1Wv8OPJVvJEm/me2vK5Uw6z7ziHfKXSIuPR
 JC9fRIkGWhTWBx7fdjHLKqQRuLWII3Lzg9x835o8j2rEw54LExzE58XJsr8uHpIcgAoSQWoTw
 Qs2Ans36NJfWfSTM1nzas8P485vrVhdBle0SIICbn2WFclB6MMVmn4+cFj8JVF+OtrGa16FfT
 E7cFXr0tecCHB9WeHK3O2LmYWd7lozlYKiRULo5XBZC+K5KCFdeJnm84TsZ9QbwC4TLGU5Wyr
 y8VcJWl0XuYkU/8ro2w27fGXvWcWVu8/iQ3XSH+zKKPCztPo/zI/P+NQILVS92loOZ+obNXmB
 oSCAWDzlytlWSwyaUZPibqIN+jS16MuKOmNrPYtAa1mLa3dnxCozJE+y1wvKF12rxm9ud3JMC
 EfN9PLkG9+6dvk9U9WVV+VAptU8D7Dc9Mz3PYmuG/CuA/xXeSPpjkcUmkOd86oB/gdS8Q9qnj
 ZS3FGYMP4d9ZTBTziKKo/ywuKGdmmxDeLg9X8jQVg2618BJUZvMPMuXFgqKS1kHhPUC8f+42o
 7bhull70CjYQzcH+nb+lncJRwFWRUgvf42quBrIv7E6pM=

Am 01.04.24 um 05:36 schrieb Jeff King:
> On Sun, Mar 31, 2024 at 08:53:07PM +0200, Ren=C3=A9 Scharfe wrote:
>
> Which, by the way...
>
>> @@ -123,13 +124,14 @@ static char *mem_pool_strvfmt(struct mem_pool *po=
ol, const char *fmt,
>>  	if (len < 0)
>>  		BUG("your vsnprintf is broken (returned %d)", len);
>
> Not new in your patch, and I know this is copied from the strbuf code,
> but I think a BUG() is probably the wrong thing. We added it long ago to
> let us know about broken vsnprintf() implementations, but we'd have
> flushed those out by now, as nothing in Git would work on such a
> platform.
>
> And meanwhile there are legitimate reasons for a non-broken vsnprintf()
> to return -1: namely that it is the only useful thing they can do when
> the requested string is larger than INT_MAX (e.g., "%s" on a string that
> is over 2GB). This is sort of academic, of course. There's no useful
> error to return here, and anybody who manages to shove 2GB into a place
> where we expect a short string fully deserves to have their program
> abort.
>
> I don't have a good example of where you can trigger this (it used to be
> easy with long attribute names, but these days we refuse to parse them).
> But in general probably calling die() is more appropriate.

Makes sense.  Could be rolled into a new wrapper, xvsnprintf();
imap-send.c::nfvasprintf() could call it as well.

There are also callers of vsnprintf(3) that use its return value without
checking for error: builtin/receive-pack.c::report_message(),
path.c::mksnpath() and arguably imap-send.c::nfsnprintf().

> There's a similar call in vreportf() that tries to keep going, but it
> ends up with lousy results. E.g., try:
>
>   perl -le 'print "create refs/heads/", "a"x2147483648, "HEAD"' |
>   git update-ref --stdin
>
> which results in just "fatal: ", since formatting the error string
> fails. Perhaps we should just print the unexpanded format string
> ("invalid ref format: %s" in this case). It's not great, but it's better
> than nothing.

We can throw in errno to distinguish between EILSEQ (invalid wide
character) and EOVERFLOW.  And we'd better not call die_errno() to avoid
triggering a recursion warning.  We can open-code it instead:

        if (vsnprintf(p, pend - p, err, params) < 0) {
                fprintf(stderr, _("%sunable to format message '%s': %s\n")=
,
                        _("fatal: "), err, strerror(errno));
                exit(128);
        }

But when I ran your test command (on macOS 14.4.1) ten times with this
change I got:

fatal: unable to format message 'invalid ref format: %s': Invalid argument
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0
fatal: unable to format message 'invalid ref format: %s': Invalid argument
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0
fatal: unable to format message 'invalid ref format: %s': Invalid argument
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0
fatal: unable to format message 'invalid ref format: %s': Invalid argument
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0
fatal: unable to format message 'invalid ref format: %s': Undefined error:=
 0

Which scares me.  Why is errno sometimes zero?  Why EINVAL instead of
EOVERFLOW?  O_o

Ren=C3=A9
