Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2783BED46
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307047; cv=none; b=qtBO7bmlkcReXkAYehRYIq09B3geJqWp5xK62fA9orUBorrpUAxdDt08av3AntWGMOZ7ESNByTEk9FcjB4fsT9eJ8Br4VTrxJlJlCgupbINqBmwqT5V1kD0T+JSDat9CUX8QN89JsEU0QNxLYadDzS4mhcXnhz/Erd8T/g/9YCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307047; c=relaxed/simple;
	bh=vq+6Jbh9yMsgtsURzLYYAJyTs6s1f4yHahY++j+fO+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtnRavK2lcQN9vVsDZ547IG0rH8j8jTMFN815qRXTF/SdpwjgHN83wRGVbaO6juUWFCZfttMIijkwtUsCO6Og935dJqwJKau0RXo4iTgWoVzG0GmEiDR3xlw223MDLTp4Hi446idJ+SqUuEscWlYRkblUzTvJu+MJ8p05xpl+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ILpjQ2T1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ii5nIZc9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ILpjQ2T1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ii5nIZc9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 68770EC0176
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 13:17:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 13:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791307044; x=1791393444; bh=bhBltvDOSc
	bz1BLr38XKMFA7vrRnaaKBdg3e0vD5h3Q=; b=ILpjQ2T1ZDZ1beIqHQBv0/9jLg
	Gr0gwNvcYYo18VglW6nWiHAj8k6tsO7alq9ul4qaIPocPAUSgpjRXf5nMOrsAnrx
	fdRHmYFMXwWZSdRYkPT9hw4wL/SzRodE3YyVzyPnHMmEDmi4uKowAZUITAdhfjKq
	2GRFD/c4mnQXOjzfzpUMjuIDuuim2pNT+kwD4KVkamdLUvmYG1HxXJ7/EJ2vSoPz
	ztf/tMUzHurNMA2PSuh8CbzCttJqQtIgfWfskUAJ5VE8j8GtZnEYHE7qQfelNI08
	Kl8yp8sQSubsp9/q/DIll3BQ8ozTFI61pzZ9SiGKmYndpEX1oMWah/k4a24w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791307044; x=1791393444; bh=bhBltvDOScbz1BLr38XKMFA7vrRnaaKBdg3
	e0vD5h3Q=; b=Ii5nIZc9cvuXBLkb168dawIhUppx8tvD4RT9l0hQWx0g9p0BmMI
	VzSigQwbOmve0ucDkOmWLtFQNR4I5xvk9GxbiM8PmACa422I7sQznem2fKJVOYfs
	39J60YYrjyKYgsv9CyNBjYg/0vbEE43hGRQYE1FUZAZ7LweZthP+6GEPEnOA1sJF
	O4vXrkroPajxf50iq4jO6IKDB73PewFkHJHqKUu+m3fmMrC8FG68UKFheORWO9qH
	yLBIQI93AUucFzymjl9qs8LlMOmxiezkQnLIbYZxKjdpIfcveit34xn9FcW5YE4l
	IqA83Rn0CTPsRtJslSu8eLVIGLamhh2WEKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791307044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oQ1iaoEytXuRZk8ZtThx3ba2t0R7sUyzHvQv+Q5XascYdrP
	WD+Ax3meWmOWwECFVBKdKbwFxVQj1NiZMdYSsfaiVPP5pUHPZ3BkPc+QwmhBlrvq
	a4mIC+nXbqrw01UP3xc0RFgGdsz5UtWM43o8ls9MbSJuc/q7fdO+RrOCM42/T0i+
	Ur+hiEBdktpr9738tREFOPQOVmS5TeCLwQTMXQxBXyrbSF/G+/ceOYoZSvtYy//B
	ROJfIMlTw0uivXRh8KZJ3gHtJBIhwbyJEiW5tLXdDKyBER7UlGLAByoedtrvz0RU
	H3YzfTcUqLvsXXl9sIDyhGnn4jvA338J+Sd7X0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bjnb11TFxeKnqxbRasW7A1efqK3TUFFIS7T5RH7LBTg=:vq+6Jbh9yMsgtsURzLYYAJyTs6s1f4yHahY++j+fO+Q=;
X-ME-Sender: <xms:JC3Fal_HGJBtQ6hh6VcYn0Z6RO4d9DD9PX9yhAaeY6TlTUL7OcmuGA>
    <xme:JC3FatZ-scJQJKfxaYVytTDWxEtigz_yiD9bcJQmPa6u5MJVO1zeL77ksAaCes-LZ
    THLPKwXdaLpHp7SvOjJww8_KhlhgYuGvVytU3iiqCLxn96wtGygehw>
X-ME-Received: <xmr:JC3Fas2fkieztIrsKF0ALLyKDKHLfYDQxqtoV4KeDhpcroNP1LlHvKdn4bZnTrZRoF_XSnj_F0I_nR8-aFdKzjHHizXbN4xxTwUG>
X-ME-Proxy-Cause: dmFkZTEn+lbHeyqvV3ec6OED/0C1P5Sm9+D6DAuSntylfOuFxNm1mgm46P3LoZDvtWqnia
    2a5I0KegeyznFe8FnBgHGE7mNS7vP1tA57xIXQVjGL25mkNPgIvR3yRhDlqzCYtMcWhY3p
    NkZ9x7n61xrBiFLs9ngI34wPU7HWvYbrVJXEVsBMkggmy3dTJr+p0xJkjXMiC49dosUajX
    zJh0L2CYLcdJD9TtWQjV2ULbPucOknhu3lFF0i3bXw8CZJUpAPj97JVFfJ202j0wCIxYC5
    WWG2oLVy19NQLV9cPk8QiN76h00kpBnHlotLc+mGqVhHUX9pneGbYDa2V1lOSlobW0p+ol
    CbKi+D/JrsaOEsM/3QFWH6UFcE9FK4Ewjght2Ha1FJSVhfRin94h+AN/SEH64iFJB624p/
    mkEFITquV80Uo1PYarPBAQpqyu1aWMG02EzvdKfPvOTiXzVWKJUoTbL9U9cnZsEAYts0iE
    0MEpA9e9+X/fY6WoDdHhCD9q7oh7/EA/pHOh6Q/UDkEIdzkNKvLXSsMe7NTU725lpwJ6yo
    FxjYDoAsOKbTmxRqRohs2yjeLPGwrXLE9X72oEOGAYxDuFiruZ6ruoyfThSaCDhV6yq7Ct
    B5JKyYgRhSSn0OOx+0cdigu0Tdlo5SOFper4ajsepXZCFbuRaO3LbLAa3VAQ
X-ME-Proxy: <xmx:JC3Fagao6Y8gHEJrH5nHUEmzmUVUwWd0uTWXw1p4HP6a1CpGzYYOPg>
    <xmx:JC3FasK9b7PHcT5SExvj4lgiLESLTuG3SukBJSQfwQQeanIkJRLNzQ>
    <xmx:JC3FanE2GIUS09sLAhyVjeJDZ4PorUOuwBWx-IGcIDpaP2NYsua1lQ>
    <xmx:JC3FarsqbahBGHbtu3XdNICVKYFinn6HnGxHkcKyudeM-5y9HPzI9A>
    <xmx:JC3Faur4xB7zUQcV4XaFgQGng9pTIMlM9JLdRpbwC7dyIav_FvHYp86W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 13:17:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <20261006055002.M9X9O%taahol@utu.fi> (Tuomas Ahola's message of
	"Tue, 6 Oct 2026 08:50:02 +0300")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
	<20261006055002.M9X9O%taahol@utu.fi>
Date: Tue, 06 Oct 2026 10:17:22 -0700
Message-ID: <xmqqfqyieokd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

>> Changes in v2:
>> 
>>  * Remove changes to .po files (thanks to Junio)
>>  * Reword commit messages to doc: ... (thanks to Tuomas)
>> 
>> To deal with the conflict with 4ce144a1 (which requires that all guides be
>> listed in command-list.txt) I think we need to add another exception to
>> lint-manpages.sh (like Tuomas said).
>> 
>
> Excluding the po/ stuff, the v1->v2 interdiff looks like this:
>
> $ git diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2 -- ':!po/'
> diff --git a/command-list.txt b/command-list.txt
> index 5c649c882e..63ae2a67c9 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -244,6 +244,7 @@ gitrepository-layout                    userinterfaces
>  gitrevisions                            userinterfaces
>  gitsubmodules                           guide
>  gittutorial                             guide
> +gittutorial-2                           guide
>  gitweb                                  ancillaryinterrogators
>  gitworkflows                            guide
>  scalar                                  mainporcelain
>
> That, as can be guessed, causes git(1) to advertize this "obsolete tutorial".
> Perhaps we would like to avoid that.
>
> $ (cd Documentation/ && ./doc-diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2)
> diff --git a/7da429d7fb86fe400c48984ea1506a9e0477e80e/home/taahol/share/man/man1/git.1 b/0bf477ce01b45853195f5f3da63642712dc35579/home/taahol/share/man/man1/git.1
> index efc100186b..57a7f270c8 100644
> --- a/7da429d7fb86fe400c48984ea1506a9e0477e80e/home/taahol/share/man/man1/git.1
> +++ b/0bf477ce01b45853195f5f3da63642712dc35579/home/taahol/share/man/man1/git.1
> @@ -800,6 +800,9 @@ GUIDES
>         gittutorial(7)
>             A tutorial introduction to Git.
>  
> +       gittutorial-2(7)
> +           Obsolete tutorial.
> +
>         gitworkflows(7)
>             An overview of recommended workflows with Git.
>  
>
> And let's not worry about that exception you mentioned.  After this topic hits
> 'next', I can rebase mine on top on of this, and deal with all necessary
> integration work.

OK.  So ...

 - I'll tentatively eject both topics out of my tree,

 - Julia will send in a replacement that does not add gittutorial-2
   to the command-list, which will be merged to 'next',

 - and then your topic will be queued again with an evil merge (by
   me) to add gittutorial-2 back to the command-list file.

... and both topics will be happy?

