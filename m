Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B73427A10
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012263; cv=none; b=H66O+KmDGsqc1Yb8XyVTuP93Mtw5LodtTkbuQIs4kPbkosoDF87k7IOqKDozXI7fCpKf01XUFKoQs6CaCqne6N+FvkrO3XduM9RzqBPY029GjFcV0T16KAmF2/wQmOsAc0x98Xv5yuo4MOuVvsmgK7MYA5YE0Ilh6Zq0TB0qZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012263; c=relaxed/simple;
	bh=4HRO62HLjtuL9bKmHYoxIqIgzeeZAmj2Fxln2fCJpi4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qHZMtImEeKuEgPFpPKhudV1r6hQFacleDSoIyh1pjYHe2qVLC0XuoIKMB4pW3OqvL8I7v3F+hzSo0jm8wjp2w4nAQ/MfJ2j5NekNU4aErJ5EUl9/HAI1dVEfIg591IlExVgE8QCt28KYyJU3W6uSUubZpZ7Ncn72LlEliryZZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Fv9QIxBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMB0BK5w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Fv9QIxBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMB0BK5w"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C12FEC022A
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:11:00 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 17:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792012260;
	 x=1792098660; bh=1VD8o6ihnMp/2khhu60T1nnyFP93UBQnp/RLWoAEPDk=; b=
	Fv9QIxBMDNaDyRQtRzX8Q7QSYODqEU+qcykDX7pu5typEvm4mJh+vLZp+/QJtBbD
	o6EUQYQxUdaiupMhJZ+Mz9QAN1jDsCG6knOQgbVj6dkfFZf5iibI3y7IDmKo/S2l
	ys7IHCc7DwRoqfPVKIjoh2T77kbDND9hZgLFPzIOqjUORkip1FZAQlNbX55S3f4M
	576h/JVTmrCpCKFejMPzZiTTmuJnSwwTlKcSHH6jkfMOn26m0f5waOVARnfdygSs
	XFrtrbvDqw0ZU3L9zPL2MrG3TXL87+b8LiGS5aFmIuR2oJgXeO/YIbLl883FG6F6
	k/tw7WfYhZogMfo9qXJCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792012260; x=
	1792098660; bh=1VD8o6ihnMp/2khhu60T1nnyFP93UBQnp/RLWoAEPDk=; b=f
	MB0BK5w+HKT3Uwfs5mEc8URdhGU2nyOqjMkXPB+ePtZ74AgBN80MGCweGTEbpZ8v
	GfzBcjR0spYwe3vmRhamzuwRivt9z+W2MB8WUDyxfBIp3q1zDe3nDdywoNe4QCUG
	/P0eeiq6P+ZSYWkIsdCe6Lsg1o7GEmD5OlktrWd5dLrmmpS75k7LA9rWqD5yELF6
	DgmXhMUWHn1oiGEcYy3JyyDzO5temIFndjaffD5UWDn6rhU9+odjBiPl/6uXLTyA
	Yy88brIvgwUhqDMxqxIccDpz59icmQkz0Gk4OVLlC6BUihbIRxYRfH7s6NOnehfV
	MCNu8MlyM6F8QypNOxiZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792012260; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:W+2ulRh9Ze9KCEQ3g6hJGjKod/Sj/QqHB+ywq838Rli9o8O
	U2uO1xjX7kdUmVGcisB72Ht79itbV947zvK/yCRasgDJezXAp6BFv00RgAr8rESs
	llT55S3VyB4+tSDYPFkS+H2Wo9i4wdpPb1zvUS7PxRRWag4NYtvf0UxRTmlT0+VE
	lKFaOfVup1RedCEVHoIOPi1DFfj9UXIwDuIjJqkjbkTxdSwOxZLd78SZ8H8cojxH
	1XsOdvt7QoYjQNxsnerUs88LMDexzBxYagNAAuT5Zao37xPQtlrIvor3cH4z7C3h
	+EjMx81bkhwqWZrKc0U9BuPsRWhBfNWtnvUAkDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+JA8hsE96xJh5w7p+aza3ZzghGVz2K19NNCtlbiCoVg=:4HRO62HLjtuL9bKmHYoxIqIgzeeZAmj2Fxln2fCJpi4=;
X-ME-Sender: <xms:5O_PalBnyx_2dERPNu58ZdEGpYAp8YFi9KVx6cRlGxwatLTLehVitg>
    <xme:5O_PauWwu8FRDjvK4lIM_ZuPSukeeOUKkeiCjFvCcyEUjMQwdk2PiYrjupdiBuu_w
    NtiAb7ukbvQgXMMkieLckyCRjGzJ-niFgCd-g4WUtplCUkiH9Py8TcA>
X-ME-Proxy-Cause: dmFkZTGbr4uZZ2FpQeReqCwdrAOW0tU3Zq0GWfgySLlpvyhA75Dz4doHjizip817YbgCef
    tljf6/iw6SryVX7dS+HQfJw0b3NBZpXIId2I6v+oRPL1MH6PTmM7E7tioOR3YlTTkFP4BC
    gyKMjSrKdaQAQcMnWwDyEkZilbTYo3/hmxx6q0r0g1c5wsjAsguye0+mM+d2BCLkqlOPQK
    SugBIHF6oUTIC1nvgUdWTq1N8wW29NP2hUN5W0heF/8sTkPt56/MC3IXzA7ALQcy0AtqQs
    meMhFLG/ZUuVLAQSvHWF6NusLN/DSlIwVu1a3gMTthL8jK4fA5vsOVROYVuY9B7f6j0BJz
    UF+XXdi971Ix0dR/VSOaiRFgiV+o2PFxwfxfGU1BCLrhFzb6cbdMQsKUnC3xfHUzxD5OKe
    8v6DgqwQszRAjTxvIjRHFlucSg7SiGS5yjWRjyMTTZd6zYxI/F41g29QY8KTJlns/cpsNs
    EyhBBWITW7qW1kZnk6l3/YAm0KXdmwbz+OYhHNdPfxWAerZtAQfX3hRNkw1L92aC8jw6lr
    twIboorqzpOVLLaUEPl83OWzlF0QTX5jjkqQc//9eNv8CDrP4lxitn9UGcCNkLSncrq4bP
    e9IDdc6a3k0oJ8rGsKIoiACEejIOU+UrJXykANffIJi1fQJsmNqZXILbV/Ww
X-ME-Proxy: <xmx:5O_PavrPIdz06g3YwRP3H8D-7QlkxjaFDwMJb4VC4hMr99NbcgGykA>
    <xmx:5O_Panc32HqKL1tw7GB0TBW_80nvz-ghAXqZ2pJ8htHAVDOgWuqJnQ>
    <xmx:5O_Pamq92ZBYEVtoIpOX0nX37geuvyBRG_sVryEQ1ZrkKUEeqz_c3A>
    <xmx:5O_PagEwMSUXUewAsiFEINEqiiYtTo2GaSpRT2tfffVktO-xdENaiQ>
    <xmx:5O_PatNNRSfkD4sAbxrLWZXbY-yS6GmPzhJuft5FGL6tmpaRkiG8yAKj>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 541FA78273C; Wed, 14 Oct 2026 17:11:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Wed, 14 Oct 2026 17:10:40 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <18556e31-d85b-4b28-b01f-91ae99cbe9cc@app.fastmail.com>
In-Reply-To: <xmqqecdsru6l.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v2.git.1791896486100.gitgitgadget@gmail.com>
 <xmqqecdsru6l.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 14, 2026, at 2:52 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Write a new explanation addressing these issues, and put it in a
>> standalone guide so that we can easily reference it from advice
>> ("see `git help detachedhead`").
>
> Isn't it 'git help detached-head' in this edition?

Will fix.

>> Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>
> Can the other author also sign it off?

Will do.

>> +Git will eventually permanently delete those "garbage" commits during
>> +garbage collection. Those commits will be deleted after 90 days by
>> +default, see linkgit:git-gc[1] for more.
>
> Does this say 90 days because that is the gc.reflogExpire retention?

Yes, I wasn't sure how it works exactly.

> If you create a commit, change your mind, rewind the tip of the
> branch (e.g., with "git commit --amend"), and then keep working, the
> original commit before amending would be unreachable from the tip of
> that branch.  Its reflog entry would then expire after
> gc.reflogExpireUnreachable, which defaults to 30 days.  If your
> commit were created on a detached HEAD, I am not sure offhand how
> the thresholds for gc.reflogExpire and gc.reflogExpireUnreachable
> come into play for HEAD, as HEAD by default flips back and forth
> regularly across branch tips that are not reachable from each other.
> When "gc" kicks in, the commit HEAD currently points to is unlikely
> to reach the abandoned commit.
>
> It might be safer to either say "after 30 days by default" or
> generalize it to "after a few weeks by default" to avoid being
> overly prescriptive.

Will change to "30 days", I think "30 days" makes it a tiny bit easier
for someone to figure out where that number might come from.

>> diff --git a/advice.c b/advice.c
>> index 401d047391..43f86c2eaf 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>>  	"\n"
>>  	"  git switch -\n"
>>  	"\n"
>> +	"Run `git help detachedhead` to learn more.\n"
>
> "git help deatched-head" here, too.

Will do.

>>  	fprintf(stderr, fmt, new_name);
>> diff --git a/command-list.txt b/command-list.txt
>> index 63ae2a67c9..922a1dbd84 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -218,6 +218,7 @@ gitcore-tutorial                        guide
>>  gitcredentials                          guide
>>  gitcvs-migration                        guide
>>  gitdatamodel                            guide
>> +gitdetached-head                         guide
>>  gitdiffcore                             guide
>>  giteveryday                             guide
>>  gitfaq                                  guide
>
> This seems to be manually aligned with SP, so compensate the
> addition of "-" between detached and head by removing one SP before
> guide on the same line.

Will do.
