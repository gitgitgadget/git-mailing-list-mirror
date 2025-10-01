Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649522877F0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345176; cv=none; b=ZkBEfgLlMPG1E1qynWpYovbBR+ewwyykeEUDpAzwFUqM/gtGHihrZABOvqrw2ITRCbVW0TFOfrty5JNgJ6r1EsdJ3JaoP/DCIx5ijI7s0CbaCU7Q+CGIzVHsQgWsrwNA0tBwYDBSShcJQTtFBsTG9TUx36Wi1a2Cqj8jdWfuS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345176; c=relaxed/simple;
	bh=TTIextTzSoHJFCyDEhZ/YiIpntVYevtAJJJ0rdh8cLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=M86PzRp38A9POyOWjaaISup4zrxAdwPuGImeMrROkPv7S6+bDiDcN898uSrmY6DxOEKnt6c305ii7n7uRmevEzdaQIFwCR4dpviSUtws64+97ks0I9a4fr1/o7FTPGLMByv+2C1ZzpfyhJ9oD9ZoOEZ7I31zze8vClga2LsJuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net; spf=pass smtp.mailfrom=wolber.net; dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b=rW4XzVgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8gYjC/1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolber.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolber.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolber.net header.i=@wolber.net header.b="rW4XzVgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8gYjC/1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 740FC140017A;
	Wed,  1 Oct 2025 14:59:33 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 14:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759345173;
	 x=1759431573; bh=TTIextTzSoHJFCyDEhZ/YiIpntVYevtAJJJ0rdh8cLQ=; b=
	rW4XzVgy+70l8FMhZYWKruI+hR56aoWxZThsuYAJ7i3n8voRVTe+wx1OojPGhwPY
	0k61Gv2JoAYDN0uiy/UO1QWdg0cml6hXH4s4lTwC0KlsYxTDdE40hqVbKRn4UIOp
	J28nEhKWp9U+xjBusAB07n0E88Oi7YgzBcThtw8JlItBDgbiv8Z1UHcMZCLvu7tS
	pfrn+Htrq4v5LG1A9waLzKU7Qj9hGFSZSUcz2fTBViIMnu7b5foLCq+7rjS3qXAY
	X7jw08/te75dhvwah9KANjZqgOny5oz2dfHYRx0UtDkBr4COyzYswS9uJb9lBsoU
	g1oqzTX7hcWJ5sbKKzeACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759345173; x=
	1759431573; bh=TTIextTzSoHJFCyDEhZ/YiIpntVYevtAJJJ0rdh8cLQ=; b=k
	8gYjC/13LuPhDz7mg4jWlfFhVlboSICvhJtbiBGRrPNYHqPkt6Ri2fMmLb+rEipp
	DPW0pIXvp92+KKc15NsOIr7CEqVuVaKGdVC4Hg6i1ds2Lqj9aOCdKFGysp7YBs+B
	ZtLuc7HjyNmzKf9GWrf47axL0c4eeaw7Qwf1A+0j6Q6g1hjl4oozHVrSjuz/lzLq
	O1Zo1oF6Ssz2tsLiqrdnA3p8DgB5RCFKk19mhwGKOLQS94TN7et2jpV85RyqLVHd
	GY7+5LDiEYgijKYoibpBG7zA0nKUpjkEkR7oCOPnyUnf9/bzHKN9rZ9oeTxa7mbc
	EhnVB2ldF7zNCyF1ZCqag==
X-ME-Sender: <xms:FHrdaIo-0Occ3TOCtzzHv-yOTB8Kmns-JZrTjsEIOk2CMidmmIqTOQ>
    <xme:FHrdaJdwofp4lsjb7AF0stSmm5Sl4hhxSe_Kb_Vt3BhIDFarjXz9M436zAuhgvYm6
    Po7P3KywJusfELGXpmHnvdOroaUQ9dtse1fg2mX7aLFFgGzY55HENo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggfgtgffkffuhffvvefofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcuhgholhgsvghrfdcuoegthhhutghkseifohhlsggvrhdrnhgvtheqnecuggftrfgrth
    htvghrnhephfevhfffudeijeehhfeujeejveeigfeitdeguedtffektdeigeegtdelvdek
    gedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptg
    hhuhgtkhesfiholhgsvghrrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehsfhgtohhnshgvrhhvrghntgih
    rdhorhhgpdhrtghpthhtoheprhhitghksehsfhgtohhnshgvrhhvrghntgihrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FHrdaFnXEgn0mtd9iMrsn_1SMNlFnWgSe0WXDn6h3v1lo8vaithhEQ>
    <xmx:FHrdaFxcGIyB8UEhrq4wY8PP_3KoPelcIYS-t_ZcmZ2gf0Zf_8fYtw>
    <xmx:FHrdaP4qqvf13lZZBjW5ULK7o1FwjbhelTRhY8KcbofOWyKEXCibcA>
    <xmx:FHrdaFU43k3oN3-vUqdq4ctkMS-Qn49m5RSdNBGGRLdrirsJ3Xx9YQ>
    <xmx:FXrdaMirJVi5AcOWbMsxNNU_02bVRT8sV8rNFc_4sILhbzK4so2f1E8q>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CA6618E0071; Wed,  1 Oct 2025 14:59:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 18:59:31 +0000
Message-Id: <DD77TA1H1OOO.351R9WDH93UZ5@wolber.net>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
From: "Chuck Wolber" <chuck@wolber.net>
To: "Christian Couder" <christian.couder@gmail.com>, <git@vger.kernel.org>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Rick Sanders" <rick@sfconservancy.org>, "Git at SFC"
 <git@sfconservancy.org>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, "Patrick Steinhardt" <ps@pks.im>, "Christian
 Couder" <chriscool@tuxfamily.org>
X-Mailer: aerc 0.21.0
References: <xmqqcyalm0mh.fsf@gitster.g>
 <20251001140310.527097-1-christian.couder@gmail.com>
In-Reply-To: <20251001140310.527097-1-christian.couder@gmail.com>

On Wed Oct 1, 2025 at 2:03 PM UTC, Christian Couder wrote:

> To mitigate both risks, let's add an "Use of Artificial Intelligence"
> section to "Documentation/SubmittingPatches" with the goal of
> discouraging its blind use to generate content that is submitted to
> the project, while still allowing us to benefit from its help in some
> innovative, useful and less risky ways.

I love the intent here, but it does not seem like that came through in the
proposed patch.

I think this patch opens the door to some concerning issues, including the
potential for false accusations and inconsistent treatment of human (non-AI=
)
generated contributions.

Sticking to a message of self-reliance (e.g. responsible AI use) and making
some technical changes to mark AI content might be a better approach.


> +The Developer's Certificate of Origin requires contributors to certify
> +that they know the origin of their contributions to the project and
> +that they have the right to submit it under the project's license.
> +It's not yet clear that this can be legally satisfied when submitting
> +significant amount of content that has been generated by AI tools.

The legal issues around AI will be resolved in time, but the future will no=
t
stop bringing us a steady stream of things that create legal ambiguity.

Creating one-off sections that cover _multiple_ topics _including_ legal
ambiguity seems like it risks reducing clarity. To get the full picture, th=
is
patch (and patches like it in the future) require me to navigate multiple
sections to understand all of the project's relevant legal concerns.

I also have two specific concerns with the wording:

1. It repeats what is said just a few paragraphs earlier in the document. I
understand _why_ it does this, but moving the essence of this topic up to t=
he
DCO section avoids the repetition and avoids diluting the project's legal
guidance.

2. What am I supposed to do with "It's not yet clear"? This is worse than
telling me nothing. It introduces a vague question with no clear guidance. =
It
is _true_ that no clear guidance exists, but what are the consequences when=
 it
_does_ exist? The worst case scenario is that we have to go back and
rework/remove AI generated patches. So why not just require something like =
a
declaration of AI content like the one proposed at declare-ai.org?


> +To avoid these issues, we will reject anything that looks AI
> +generated, that sounds overly formal or bloated, that looks like AI
> +slop, that looks good on the surface but makes no sense, or that
> +senders don=E2=80=99t understand or cannot explain.

That reads like a full stop rejection of all AI generated patch content.

What if AI were to generate a great patch whose technical quality is exempl=
ary
in every way? How is that any different from a great patch of exemplary
technical quality submitted by a person who is unambiguosly evil?

But perhaps you intended it to mean a full stop rejection of content that
_looks_ like it was generated by the primitive AI we have _today_? Even goi=
ng
with the interpretation you likely intended opens up a concerning double
standard.

What if a patch "looks" AI generated, but in reality was wholly geneated by=
 a
human? Does this mean that patches generated by humans that fit the declare=
d
criteria would be treated as if they were AI generated?

What about a non-native speaker who uses AI in an attempt to bridge a langu=
age
barrier? By definition they would lack the ability to judge the degree to w=
hich
their patch suddenly meets your criteria.

How is any of that fair, and how could you even tell the difference?

And on a personal note, the subjective wording gives me a "walking on
eggshells" feeling. It opens the door for false accusations, and gets us aw=
ay
from judging things _purely_ on their technical merit.

Would it not be more _consistent_ to continue saying what is already true? =
That
your patches _must_ be remarkably high quality regardless of how they were
created?

With the addition of a required AI declaration (again, check out declare-ai=
.org
for an example of what that might look like), I think you cover all of the
necessary bases. And sure, someone could lie. But they can lie about meetin=
g
the DCO as well. The consequences are the same - remove/rework.


> +We strongly recommend using AI tools carefully and responsibly.

Agreed, but I think you lost me here.

Taking your words at face value, the prior paragraph reads as if the Git
project is declaring an outright ban on _all_ AI generated content (and I a=
m
nearly certain that is _not_ what you intended to say). If so, why bother
continuing on with a PSA (Public Safety Announcement)? It reads like a
non-alcoholic drink that has the words, "Drink Responsibly" printed on the =
side
of the can.


> +Contributors would often benefit more from AI by using it to guide and
> +help them step by step towards producing a solution by themselves
> +rather than by asking for a full solution that they would then mostly
> +copy-paste. They can also use AI to help with debugging, or with
> +checking for obvious mistakes, things that can be improved, things
> +that don=E2=80=99t match our style, guidelines or our feedback, before s=
ending
> +it to us.

I think this is very useful guidance. And although it is timely, I think it
stands a good chance of being timeless, even when AI becomes far more compe=
tent
than it is today.

AI is not going away, and we need to find a way to use it productively
_without_ losing our sense of self-reliance. If we fail to develop this abi=
lity
when AI is hardly more skilled than an above average intern, full of hubris=
 and
zero real world experience, imagine how unqualified we will be when AI beco=
mes
competent enough to manipulate and mislead us?


Overall, I feel like an addition to the documentation is warranted, but thi=
s
version makes me uncomfortable if not a little unwelcome. Making a techncia=
l
change to the required declarations and expanding on the theme of self-reli=
ance
and responsible use feels like a more productive way to address this issue.

Putting my "money where my mouth is", I am more than happy to suggest a
revision to this patch if you would like. I wanted to avoid that right now
because it seemed like a dialog was warranted first.

..Ch:W..

