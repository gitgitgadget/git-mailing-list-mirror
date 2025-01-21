Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F22E57D
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486371; cv=none; b=qIdUs04+AGFEMt1AsMjCTV/vQKpVcHjAz/7wkfuIOr8QSgFOaG8TS/Qqgjfba7rDq+aIDeMPmE15rOotuzjcmMUgf5dY2RLi4qmP402KlFcPzLYBSbXW9xMbdwfSRq4ov+jyO27spMHekM2ax2mgsjhYQ5GRKy0naUHJQinZZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486371; c=relaxed/simple;
	bh=MUjUBwaO7yk38AK/9Hk1K5WfErj9PX3nksZQ9plIQv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YgeuU4zyy5DQZNolKqpTr8KA+VIeO6Osfo61IeomIqNW89xxVk61cFbeowgWjbmYfsJcSrWMUGGxsg67E6N7i1VJjqMqqXHrSqEr7mn++OHu6GTKAoSVePtfO4CbZlLU05TTulV92WmMA0nBoZT3MdMovPC3RwUqfcuKp7lIYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AV0E6boc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0jpIDZ4x; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AV0E6boc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0jpIDZ4x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3871725401E4;
	Tue, 21 Jan 2025 14:06:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jan 2025 14:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737486365;
	 x=1737572765; bh=iXDWsJBMzfjaRWfyyz2d8Wn7W3s9DTiz2ADMMZdO3Fk=; b=
	AV0E6bocXUBFLlrjnrr2QO5pTU51Wnz/G5X+5LShEXJdF/4gfk47DfBKm0NouiHK
	6yHpr670RAMLfkT8ETXfOV57E5eGi7yH4IMoBXEeLfBvgXGO7O8UvRQLNjLuBRXe
	KBf/etDC9WqJML5pnHtrdy6IadMDQFaEvxicSfv421oLmFfXFdB30DBY8Ziny0Xc
	at3y0hem4Zr7WJNeClZ7cg6DXpt6VEl0YsD33LCoNvYvOmiyg4CVlaYJuW7tkyjB
	GI+W5yizDSH5uXQrSN0PbzbEKQnBP2MYo5fsk4aPs9Igz8rKHyZe3cp1KI68UCod
	PgwBXwhNvxKdNgzCV0qojw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737486365; x=
	1737572765; bh=iXDWsJBMzfjaRWfyyz2d8Wn7W3s9DTiz2ADMMZdO3Fk=; b=0
	jpIDZ4xlmWLeBSFCaN9coZTYxuScCIzrGWjO6SCqEK5+XLr6XLMIfYAo1Zo+MptP
	Puk+kI5ZNzHj0bG9o+he4o1ENjpdVIVRDlGOwZnvHw5JlSvbodsfS8V8xj33csWo
	cn53q4Hg8udZb52LXROfDuEfqy3yMNRy9NqVb60GRijMlpLk5h+PsRq38CVQjnt+
	Lh84C8HKA3HFlUCt7P1/a9y8d/yYIL4eO2pntfWbPcTMOyDX13Fj91S0YVU1cC78
	hUG1j482Lp3ggEhAzFKsLlWdjaoT9mvu2ne+PuRsHk61Cy3Nc7W12JeG3bkZ7a3Q
	0s6BosskBG8ei42ICsAzg==
X-ME-Sender: <xms:G_CPZxma2pnhpbYtCNOGazqQ6GsbkV8RnXPQHksG_erEWcII5g_wRw>
    <xme:G_CPZ80uiO2xOqfbkwRKFGth8aG8ai3RmjOCADytHI5b8gTLDE1-pJ62pB5k0AucC
    UzwEF0zPlLGaxdkWQ>
X-ME-Received: <xmr:G_CPZ3pzZF87Wxvaz7ZKuqZ1yGZq49Sy_u7abRsWuOgEo7TBbf59mv8GJf--aZtuXEuDspT004mAXbc56Agol16lzc4hHX-06s7D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:G_CPZxkz4GID3qYE-XXGM6hPYKS3CsVkoFtyK3r1x7aDGsLrwJ0yQw>
    <xmx:G_CPZ_37rYzKPpVH9_QHdtu6ON3m6AgOCGz3aD5Kw7DHh-Y0UClSvA>
    <xmx:G_CPZws1nGom4VnykYT-l_4gExYtmVw5NC_CPJBZfpGxHdPpWzY0-g>
    <xmx:G_CPZzUJ7J65YyqZcPMcpiMe2UctIH7o1ao-H0tEQtNpy652abfcnA>
    <xmx:HfCPZ9PAsORAU1R3WsLNJ911BS0aeqegrhFh98lVJ5Nm0Nb1rMk5ycFL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 14:06:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/6] connect: advertise OS version
In-Reply-To: <CAPSxiM__kNH7+itsiOHzztJZZvpw-AcR1s=ZfSm=OLv4p0POsw@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 20 Jan 2025 23:45:00 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-6-usmanakinyemi202@gmail.com>
	<xmqq4j1xjd2m.fsf@gitster.g>
	<CAPSxiM__kNH7+itsiOHzztJZZvpw-AcR1s=ZfSm=OLv4p0POsw@mail.gmail.com>
Date: Tue, 21 Jan 2025 11:06:01 -0800
Message-ID: <xmqqr04w0yxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Sat, Jan 18, 2025 at 3:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>>
>> > As some issues that can happen with a Git client can be operating system
>> > specific, it can be useful for a server to know which OS a client is
>> > using. In the same way it can be useful for a client to know which OS
>> > a server is using.
>>
>> Hmph.  The other end may be running different version of Git, and
>> the version difference of _our_ software is probably more relevant.
>> For that matter, they may even be running something entirely
>> different from our software, like Gerrit.  So I am not sure I am
>> convinced that os-version thing is a good thing to have with that
>> paragraph.
> Hi Junio,
>
> What could be a better way of describing this ? Also, user-agent capability is
> already sharing the information about the version of Git.

I dunno.  I only said that what you said does not convince me that
os-version is a good thing.  Try harder, perhaps, to be more
convincing?  After all it is your itch.

An alternative that may be conceptually cleaner is to encourage
people to include not just Git version but OS variant information in
the existing "agent" capability, making it easier to do (which
probably means an addition to configuration knob), and encourage
implementors of other Git-compatible software to also let their
systems identify themselves via the "agent" capability.

As we have documented that "agent" strings are purely informative,
there shouldn't be any problem if we started identifying the version
of Git running on one end as "git/2.47.0 Linux" (instead of
"git/2.47.0").

>> And among these four combinations, only one of them results in "send
>> to each other", but the description above is fuzzy.
> Yeah, describing the four combinations would better right ?

I do not think readers necessarily would want to hear about the four
combinations; a paragraph that makes it clear that the configuration
is independently set on either end of the connection will make it
obvious to them without being told.

>> So the question is again, do we ever need to use os_version() that
>> is a raw string that may require sanitizing?  I do not think of any
>> offhand.
> In this case, I guess there has to be a conclusion on what to do.

As I didn't hear any concrete use cases of the version string before
sanitizing, I would suggest to make os_version() to

 - ask for a string from the underlying system layer (like uname(2)
   or its emulation), 

 - immediately sanitize it,

 - cache the result from the above (just like the
   os_version_sanitized() in the posted patch does with a variable
   of type "static char *" in the function scope), and

 - keep returning that sanitized version to the callers.

to simplify the API surface.

Thanks.
