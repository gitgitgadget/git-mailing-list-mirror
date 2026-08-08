Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD32FC037
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219395; cv=none; b=At2mB/QWGUpTZ6sUK+pj53nJG1XI8ffGo/IoFscfYgGE4QJDZERU6fouuRVQ/k5BLxHpupkIcWoS0HIxr9RRbPgp9VUNjS6ZYBEnAoeG3bkDrsx0WEXF0u9NDgqZFzcdjo/sJdQMirb9Q7D40w0248fdrB1JJ/yKR5wwobYPw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219395; c=relaxed/simple;
	bh=UYg9kFF2reoM8WX9YlBr5F0YcvuXfvckqiKAAOpiPCI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rzEjGn7BwqXZOlyLhrFJLniuzOCGkawEM9t3deEbyRwqdo1bBOkdl+5Vg1rS3sEzXjD0KaZLlq/WpPmCSMceQ6NRbzP3LjTAqt0hW18fbkz5E29mHAithFBUuysm1vbwI0u4ybP4sOVuDpD5uHT/WQtgh1BODQgkEByYa5PjaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PWSaqoX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6av6Fta; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PWSaqoX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6av6Fta"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69FCA140008D;
	Sat,  8 Aug 2026 16:03:12 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 08 Aug 2026 16:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786219391;
	 x=1786305791; bh=a0kqr0WVPtFTITXwiCQaRrjdP1I08gEp3fMfRfd2/cs=; b=
	PWSaqoX6f85VTxAIvAX2eEXlqXvq2I3Cyx9OtjmkyleBPbziETmp05bVNuXNM8Xn
	tkOWr8WfhQo/LDxnD1rwmZb3x21Wq1wwdu2jA/ZGXyw5tzTntNZUmUKDw/1RETE4
	Xk4Tl03n+FA33hpbomzfBgdFV01pYc0LOwHMgxs97q2Sc9MQy1u7GJYL1B1LGZV9
	tEJbJvvItaO+sERABrqqRV5jWXZKLk36R8dM9P6TIyzUiCX/+JbxcEDoW1aZII0C
	FbG2yToMEk3RRFAosQS76qmmwDJnufX8YbAB+fqh2jn2RDLEJr4/60ilxSgMWI1j
	5wkyqDetO/JoNXZv2dKkNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786219391; x=
	1786305791; bh=a0kqr0WVPtFTITXwiCQaRrjdP1I08gEp3fMfRfd2/cs=; b=D
	6av6Fta42R/bgdTnKwusRMYRPjAhqxJCEry/BwQKAJKlJK0t3pTCmo2WgoXT7Cov
	8MZ4iNS+xk1vezYxvVh0OkruP+duxa0kNGx70fwR+TzN3FB/dNJaLm9CneylVp4G
	ir/xLbikcvr+K8iYOc0ezfFM1WCBfrpVUaqBKz2t2rkJAk+Tj1wNDeegPQnYVnSd
	VG0FKnuklIyJcGCZFMXNqYcnFwgMA8R3p5yi8mGRWhJkhxpWO5WoYEHNiz9xOvol
	X+3cx6LKyxKWDm6IME39Ow3+CEeENDzJWTjv9f/oAIjj+4/PQZyxx+6McYMXwqas
	ILPdY772dKO4Mm+lHXxow==
X-ME-Sender: <xms:fIt3alZrzaHoFJvv7yq3HbKlB_NK-H2GN0QDKGfE3wAMV2MHZvyVOCI>
    <xme:fIt3anPLvNVWr-fl1wsiMr6Q01vg80xo4c5fFTAQlVjlob8QSZ9L6jDBIudIiuyyu
    WUI-rpI0FwAxnGsUkxXa-3mGGf3pMWdViJhLeVHQgfJ86HmxPH-0g>
X-ME-Proxy-Cause: dmFkZTF5v8DPC4m6Eito54RbIkqvA/QXSzCjjvYMYOUvDukxY4s/cUYwP2kMVjcc5Jpuqv
    s6IFPU5eUgqb8Ed8eiIBqG1dx54OJLfteugC1fH/+8pS5n1AimUSAofxQ5Eklogs10IvLd
    F8Du+fr1XktEXPvY8SzbigAE6fETWwo1tzVbG8apqqO5Rmuzz6MwpkmenKZ7TPIYnkaoec
    NxDhUTeAj6sSZ8w9jsX0Hh8EOsdhAb8XG5Y8OOGWbpDmJNqLKspAkVVLHjxivh/tlalNZg
    ps/GUO4rHvn7dR8lS4s/UbjOCBpb9S6aFNgGoMHcvBl2IA/e4iafGkCZgVdpkZLyRz6ICq
    4kbuNCgn7WETVHtaGB0aFMavDqhseP0NJ5LTJyU6aAtbM15ytQfT3ApqcxJy89BbkjOZJl
    E9Ng7r3Bu5GSz5fYNJ8yR1m2LMnp9Fou5keIdmO2o4JMw20YyQXgnzjhuBQqydHseOQH8r
    1uFLLct0G/YGIsdFT0oyUvkhlJNzEtB1XMd8NhbFSUdWPTqTtITv97kAMDH5IPGP8L89ZQ
    6za4c8kOL3idjs8DIw2J4tpmzHVxUph+u3/dR4t/uQauQtZDFGx6Eh6hXoCopIpiZSnXxb
    FQj/fGTS8E8BBLEq50xqaBe9887yNZqWe24Soy/5QACvj3dUs8Sb3NTAoyYQ
X-ME-Proxy: <xmx:fot3avQ0HJXX7LLH2ExwbRL-2m0D8CXGTr1rUm0lZ9h1UxcGqO4M6w>
    <xmx:fot3ahcyNcw-8W-uW-3XSEviFfyFgfAvKGsNzzkn2j7l6XKyooZp_g>
    <xmx:fot3ajDSjySDVtOq9eLFMvBIqeyJp429r12vZOl2HKiqEGRhIu7PsA>
    <xmx:fot3ajn-oH7p0flfDGKpmbhH9nfY9hTwm0BhCpC5LYND97W6Csm6NQ>
    <xmx:f4t3avKUdbYf-Crz63Kdj1mPAc4opSf0sNcy87oTZI9p9PNqgejMuCFt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EB86B22C006F; Sat,  8 Aug 2026 16:03:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Sat, 08 Aug 2026 22:02:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "Matt Hunter" <m@lfurio.us>
Message-Id: <d60621cd-79cb-4fac-bc0b-828e29131043@app.fastmail.com>
In-Reply-To: <xmqqldajhv9q.fsf@gitster.g>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
 <CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
 <xmqqldajhv9q.fsf@gitster.g>
Subject: Re: [PATCH v4 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026, at 22:02, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>> One small comment on patch 4
>> ...
>> A few places we use an inline list syntax ("=E2=80=A6 (i) stuff =E2=80=
=A6 (ii) more
>> stuff =E2=80=A6"). In the added example about ASCII trailers it is us=
eful
>> because we make reference to (ii); in the initial part of the manual,
>> I don't see any references to the delimited items, so I'm not sure if
>> it's worth numbering them.
>>
>> Not a strong statement, though, so I'm happy either way. Everything
>> else (that I looked at, see above) looks good to me.
>
> I guess we are gettng very close to the finish line.  Kristoffer,
> how would we want to proceed?
>
> Thanks, both.

I will wait at least one day for any more comments and post a new
version with that fix that Knoble found to the commit message.
