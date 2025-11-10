Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FC1DE8BF
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790210; cv=none; b=u9aeeSGmm2+Qo9tKCbWvrM4INouxzk5vpYRBW9nUPSEVX+wUKoKOBmZ6+Ple5FZIQZ8EnZnqPuTYIeC8TmrRHBl67fg+dR9oY9yRP3VTQXrGIKGDRvyXA6TVNVCxGhz2suOQC/PbIvbqdQIc3ZzRNh2d+zQutb/iGnY7lHz7eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790210; c=relaxed/simple;
	bh=V4KAV2HIlyavS5YA4xxclhrY6Oa5+J9DdBq9t5oId3E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mCiJlpApDIhfZgh+prGmelKXiZwj2EJ94N/whiK8jzWJogvmEscdXuxdJWzTu3RdwHZIzRmxIsZ2b7gw4b/I3f6S3JuHXfzEJpF2UMFkzkS03Cttw7WWCLwjxKs6c9U2sS9tiV3VVZvUVLp4Brt60UPCXReZds8D/ld6Odv5aFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=MYi/oDAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YkwCB06m; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="MYi/oDAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YkwCB06m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC8F37A00F9;
	Mon, 10 Nov 2025 10:56:46 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 10:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762790206;
	 x=1762876606; bh=GgQx24bO/TDuXAxG6llIZDNZfJwdPh27MXHSi0BkL7s=; b=
	MYi/oDAmsqCz4PRqF7wJ7gS8m0zh2lkQPduBA8/XYLWfQyj/tSbArT4l8irnyIH7
	jq45Bjk7RWdvnJ/Np5Tn2paVTDuqDcD3LcgdOVGEsU6aLs/zGfeTaes1Ogsvxjso
	HDTX9NhIU1Pv/fwpVn5yummSTr6+exfPgKg/u1Kc2OLVqPLJWxxFjCuowr9gNq1z
	EFE/AeFxdY3FvRzC6jKVyEbUVbxEA8UGSntIgk4omZ4RoY1k+Egip4kfHvK/HUUa
	VJbxhbJ3DL5mUPEbBW9qk+Fgu/ZwdILQ7vo9zt8MjVsj598POS2a9zIhhXrjV24k
	DhFXK54OkCTU5HJrbOPgkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762790206; x=
	1762876606; bh=GgQx24bO/TDuXAxG6llIZDNZfJwdPh27MXHSi0BkL7s=; b=Y
	kwCB06mEVbycjNFqTrGYJGErZ9pRb8gAkKYkX5y/wmqe5F7jPoyJ6PQoBVGIWxJ/
	rPz2hvOpSnnsTkwBrC4p0LADQ8+YlM+8IExK8KyjZT1T3xPVdHnnHr39TvlvwFoy
	EmO/j1x91/u2iRh5fDG1RqwhEEp1JRR/A/6j30PxtCAj17RSRqbsKfg7R44WBmRk
	9fr5kqNvIMsH3Gyyf9FPVMhuCkpm1w8pVpFM6N8/yxD0psvwYUEWoPsHbV/aNzIe
	4MleEKBqbCeJTNz9bq3f6RnUX7TjSgs3zAldLandClz3ni2Q/lYOHRh9Sx1lVvwx
	oamHvhHN8HgoG7zFDLlVg==
X-ME-Sender: <xms:PgsSaXt9Ev6uwG4SB6uIZxfB8rFwOAjkV8YolLJyXX8DzI0ydvIudg>
    <xme:PgsSaTTDjv0CYK9lenkmjfOx3_ZV6KRv2298Cr6bfaqa8sn0TeawYKqhtjN3RxngD
    5E54Qsn59tSRKWS7yERYicfIeeqcQbylSZANr5yNfubiH328ra0tYkf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PgsSaRZAocHUJTLXPeJ7L60GG1ANzIpSgBKxNGDUcPNS86CU8GkQDw>
    <xmx:PgsSaRt9cV02zm8NvvOmM8nKuhadiL4sd6EFpm7oc-ca_bsMug8WFA>
    <xmx:PgsSabNVEuUcwkk0HQyV8ZT6KIHH6u16fTeJqRYdapO1keJz6shDfg>
    <xmx:PgsSaQ5uAcz5R0Yft9PPynua0W5UsQn4Iqr4AjAJ84kHdCXvu-mCAA>
    <xmx:PgsSaSiBTw7mKjw_npNcASeeGlHiGzXPSZ0FmQ5SJGFA1Olk9y7w0do_>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4DABF780054; Mon, 10 Nov 2025 10:56:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Mon, 10 Nov 2025 10:56:03 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
In-Reply-To: <xmqqa50v4x8n.fsf@gitster.g>
References: <xmqqo6pde90w.fsf@gitster.g>
 <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com> <xmqqa50v4x8n.fsf@gitster.g>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Nov 8, 2025, at 11:59 PM, Junio C Hamano wrote:
> Ben Knoble <ben.knoble@gmail.com> writes:
>
>> My only other opinion on the matter is: what does making this
>> distinction clear do to benefit readers of this document?
>
> I care about teaching people not just _what_ but _why_, because with
> vague distinction, many tend to memorize _what_ without
> understanding the reasoning behind it.  "Our object names are
> computed as a hash of the contents in it formatted in a canonical
> way" is "what we do to compute an object name", but the reason
> behind the design is because we want to be able to dedup the same
> thing cheaply, detect two objects that are different cheaply, which
> is "why" in this example and it is equally, if not more, important.
>
> The refs and objects record object names, and that is "what"; the
> reason why they do so is to refer to these objects.  If somebody
> comes up with other ways to uniquely refer to these objects, their
> implementation of git-compatible system does not have to make their
> refs record object names---they can draw a line from a circle to a
> rectangle instead of writing the object name of that rectangle in
> the circle---and their system is still compatible with the Git data
> model at the higher/conceptual level.  IOW, what exactly is done at
> the byte level (like file format) is lower part of the "data model",
> but what these byte level details wants to achieve is the other,
> higher half of the "data model".  A data model documentation should
> teach both levels.

Thanks, this is exactly what I was looking for when I asked in what way
this rephrasing helps the reader. I agree that explaining the "why" is
very important.

It sounds like there are 2 "whats" and "whys" here:

#1:
what: object IDs are hashes of the contents
why: this makes it very fast to avoid storing duplicate information,
     and it's extremely fast to check if 2 objects are the same or not

I love the idea of explaining this. I think we could incorporate it very easily
by adding this paragraph in the "Objects" introduction, right before
"Here's how each type of object is structured":

    The reason the ID is a cryptographic hash is that it makes it extremely
    fast for Git to tell if 2 objects have the same contents or not
    (if they have the same ID, they have the same contents!),
    and it means Git will never store duplicate objects.

Will add that unless there are any objections.

#2:
what: The refs contain object IDs
why: to refer to the object

I think this is so obvious that going out of our way to explain it
risks confusing the reader. Spending too much time explaining something
obvious can make the reader feel like they're missing something.

I can't imagine any purpose for the refs containing object IDs other
than to refer to the object?

Like you noticed in the tag object section, I think saying that the tag
object "refers to an object" works well in that context, but in the context
of explaining what a branch is it makes the text more confusing.
