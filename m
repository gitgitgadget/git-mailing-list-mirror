Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73413F1076
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304738; cv=none; b=ncL6ICwm7zkrSd2PsdFiAxqKvy/eFyz1ZK1yW5qnRP+zwXOcHq4eP3tQMSbrtCT4oCqyYvYbxlMqo/rt3Zu74RxOafCIQ8LTh4g54zUdr8zKf8xcd/37HF6sZ+dTp9fKWQkX0cyxLDFldQfqLjZSQ3BUsFWw2fORItfSR81Wjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304738; c=relaxed/simple;
	bh=QXJ3qcTFEWY/FOJJ/tcg7adnzYbKztyxHrP/0WBVCrk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gqpR2IdDe5WuiizqllkdV44QTX+7jpvEs7FSqEYKRi5dnUNOdQnXS50JZXvoZDHKAOucoLecvysNys+Lgxu7ituJoQgXl1sJBV5sUO0g6t+CKLfn8vDTos4MbIkTEQCHfdZDVAonTZ5t9O2eGImyNwxQloP2fYKxAlrF6sVV7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ji4A4pKY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2Y80PxI; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ji4A4pKY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2Y80PxI"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD0F41400071
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:38:55 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 06 Oct 2026 12:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791304734;
	 x=1791391134; bh=hhACYjkgqygxxpJs7f/AdIwn7ubZp1hNfkozioxA1U4=; b=
	Ji4A4pKYKlaTcmmhYrD4kPpEhehh5bUVd6/nxkKD3Ib11cW0ePwROtd+UiXXp5kZ
	MAe8Jg5GWZMIOJZIzYkXC3bE6vBd1o+KPH0VawajCW6gXZ0mjmLEJ/oE+8F0BjI9
	x6nqcvHBMr4v0D1n94q4NQj8Ixr6zYCu93Q4Fr6zBfTk+60W5IFLAjrSIs3AqG+U
	kMfeSfucoOF7TY/SOkaLtLryiEICv+AwZ4S/hl9HihgczNqawq2V/+wtNwb0gGiA
	m+L5omwdXyevaTPXOQveEAaIJO2HR2YlOWHaRBD82Bl3VMjB1o2x5aewV/UuPkN5
	wNvzmpeoFoMqJUgNHy9JBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791304734; x=
	1791391134; bh=hhACYjkgqygxxpJs7f/AdIwn7ubZp1hNfkozioxA1U4=; b=J
	2Y80PxIF2p9DKwMqrWErOlqhx8FLcAdo0QA7XsJzzxRvoK5yGgH+iqGwP/Z7VKR9
	O/NL6mAVufeHmpMwCpUw5ReUJaW1e2y5Ayp5cRtGvn7/+A2YRAVcVSbAUuEhNc/X
	dPF+5l7RARH3vL6R0RoQaTSzyi+53PumT3MnKw/klPaZ23DpCVPbmnWsK2lZEOWX
	Mk/FV7LuH5Odq0ssbj2gh1yGAO+nkW0c8FAw0d6JqO069nM/0weHOYcSiPlRvp2C
	Xxk7b2J7L5qmdGngDvHGSAEuXHBKWAOOEtawkg6CzYz+Ebl279sY3ItOOlmYEfHI
	kb0kumE4bqoSU/GFy5Xig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791304734; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MPBl1gXICnB6Fv4kijga+9jGv7GeT3JSqpdwC/m7yLaAvxs
	iWbczacoX6OLNhuPEyA44kBpWBnB2csjbNwe/1nLHM+RrvEx1cH03wShcwSVNPfo
	ZcbyMOk2Wx1UkGm7KFHmBYAotJIlY+9APoQY9JZYUtLy3FDpv31uQWhQ0W+tVLXY
	VYj/N2EeI6ObRFmoEGC4EUwgQngtevx/dBUwr+xQO6aMi/4rOeCzaTlhp1ob5Uqp
	SKnfgT3eOXEi8t7xeO/gEWG8yXuPfb8mJsHHuAs3BCHaDyyREJvOjZqKlegPbosJ
	3j/izsKfI/nPqGtpkdNx4dLCRoWgsRtkQ5na4Ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qUjL7/5v1NMduHn9VITQli9p1FdELnj7ePhv5x4RkoQ=:QXJ3qcTFEWY/FOJJ/tcg7adnzYbKztyxHrP/0WBVCrk=;
X-ME-Sender: <xms:HCTFap-WKr8KCvLmzATkIGlblWCffkP4FBfDYx4vsPzwCA7eucWHfUw>
    <xme:HCTFaojPl0D8NKCRkgED_ltP_AbmEJGWZ4A7f2uDW0gErQYmt4rKa-bT_BG4pDT7M
    XNlpQxtxdfi91nUK_O3pYvP5tZ0WnimFNYjgjNwdY6whNqgTE7VG2w>
X-ME-Proxy-Cause: dmFkZTGqyxMaNkHZtDAFZ/yVW7Tvlbl3mmhmYkRT90g1pFO2aGmbps+/FvFuasfKrRDmKU
    6S+06xrluiiVKZSvDuwew37Jt6VPY70uy0TA+hqBogl+xPGPi8QzM2tLXT2HVrvYQUdhrg
    QuH4dJtSaTZEjK63OoODDftkZSe2aPbJF0WMHx5XCPXW7b7smP8SstrPmUbVCxpOpWfKjT
    3nfvfUz0e8NBPS/DQhs7vhAzHgkovEAIRo6deMpAL00WPIqi/SkmvR5IveVQoSz9Ew2k4x
    MXQk2jkh5Ebn2QjhDIEZbSiM5VgOUGq7aVfUlMan3tcGsWBBgTCX4yMKwfAbIMRbAPBFX3
    l/BUHu6u11+euYahmlxfxkrfvgtjsuadRcLRJGiODcXaI27Cf+S08lgU6/hbciGpL47j7r
    8OWi17hxurN4yMx73v+Ktj03j/u/J2Fe7UNJiu/irZaDUKWEJJ4f99sBOMQS31po+S/g+6
    XfD63j9FMeG6sMglT68UrpAfPLon3wD0aoO+8zRtg2C+oni1Sa6/ruRjjzAGLc0BdvqkRC
    IdcuTvEtAY33R8eUJAqT2bB2+T8qKCMnqnCiZjuuw6g1wBo8+JCRd+GEEXRGoNhrRWT/4q
    Csdmkn3Of6S7UynVPnYjM8l4tG9GAVevjxq5m55B35YktXxbR6iK7whAk/GA
X-ME-Proxy: <xmx:HSTFar5e1-lnQ65Wv2031pcXWFYoCZelkZkF61qrnOQUY62eyhQmdA>
    <xmx:HSTFaoqOxBNix-8GnDw1cii0AdkUItRlPizUovwbQN-STHjyHpr15w>
    <xmx:HSTFalgoWoBKHIB6chRMATW6hMRRyDYxsJ-5Q1Zp6Ehw77Uuf0KfkQ>
    <xmx:HSTFaqK-UzJc18JNwFxFfykc422TuSA_mEy-I5hd4MdjQcaYO2Zlzg>
    <xmx:HiTFavRIxyeBQCx0lYPF0F_SuJl3EjRubYtiKGJotDT3ukVkmwX7kCGH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 25BE622C00A0; Tue,  6 Oct 2026 12:38:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5YEOc4Hum2Z
Date: Tue, 06 Oct 2026 18:38:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <c85f5906-630b-4335-a7ae-09af665bb335@app.fastmail.com>
In-Reply-To: <xmqq8q4ew604.fsf@gitster.g>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
 <xmqqeceaa5h9.fsf@gitster.g>
 <533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
 <xmqq8q4ew604.fsf@gitster.g>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with URLs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 4, 2026, at 04:31, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>>[snip]
>>
>> With that I get a regular `href` and a `mailto` href.
>>
>>     <div class="paragraph"><p>cf. <a href="https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/">&lt;<a href="mailto:xmqqa59i45wc.fsf@gitster.g">xmqqa59i45wc.fsf@gitster.g</a>&gt;^</a></p></div>
>>
>> The `mailto` wins and prepares to send an email.
>
> Ouch.
>
> Our primary goal is to give readers ready access to the messages we
> refer to.  With that mailto glitch, it would be unusable, so let's
> scrap the idea of using the Message-ID as the link text for the link
> that leads to the lore archive, unless we can tell Asciidoctor to do
> what we want.  Quite honestly, I did not know Asciidoctor was that
> broken.

Surprised I was not.

>
> Also, if readers do not recognize "Message-ID used as link text" as
> clickable links, that also defeats the purpose.
>
> The secondary goal of my suggestion was to avoid repeating the
> disaster we faced after gmane stopped offering HTTP access to its
> archive.  We ended up with a bunch of references like $gmane/217 to
> refer to their article numbers in our historical commit log
> messages, and of course, once we could no longer rely on them, we
> had no way of knowing what message article 217 referred to [*].  The
> URL to the lore archive does contain an encoded Message-ID, so the
> situation is much better than that of gmane from long ago.

Yes, I find it frustrating to read Gmane-era list messages.

But now these references are already forever in the Git history. So even
if I end up obfuscating them with a URL encoding, it will be clear from
the history... for those who go to the trouble of looking.

But see later in this message about how to retain the original msg-ids.

> However,
> if you live in an environment where it is easier to feed the
> Message-ID directly to your e-mail program or newsreader than having
> to visit the web and then come back to your e-mail environment to
> continue your work, having a readily cut-and-pasteable Message-ID
> that is not encoded as part of a URL is definitely superior to
> having the lore URL alone.

Yeah I suspected that email-only users would have such a slick
setup. Thanks for explaining.

> But the important point is that this was a secondary goal.  If the
> format using Message-IDs as link texts to go to the lore archive does
> not work (either because we cannot bypass the mailto behavior, or
> because readers would not recognize that Message-IDs are clickable
> links), I am perfectly fine with leaving only the HTTP link that
> is so obviously a URL (even though I find them rather ugly, but
> I am not the primary target audience).

What if we used footnotes for all of the original msg-ids?

    <URL>[1]

    [...]

    [1]: <msg-id>

Or maybe just for the ones that need URL encoding? I personally think it
would be better to use them for all if we go for this approach.

>[snip]
