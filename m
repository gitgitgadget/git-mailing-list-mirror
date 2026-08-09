Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2531F9A4
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306037; cv=none; b=tYERs6mEzVaw2w9ZP+pG3Uhd3nrUdS7phbp9of2ILIo7tlS3HYMyCvp/RxHjNeRaBHE8DUaaVqyi263XSIsCPQv8bB6nSWmzzi1aZ+YTc1WrT1mC85nOV9o6dYSmRhgRy//mYS+viHczpVevAfTlmQt3sq157pGg4f9EQmwwoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306037; c=relaxed/simple;
	bh=862iKXuFvUONDXTsYJqHVGgSYbmnJiRae52F94z6lhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8qhZ3Ja9VAPYfBTj5PEMNe2M80yMySCHpdW3HpLnoIet568T2Jpa2SYT+1KZP8XeCJ1c+dd1i7HqzUXm8VUhU6+W+YI+fdo53qWg7vhqAv28adv1gWhyOUCmR8G2eWN59lyQ9G/9eTQOG1M1JK8YvzzUBTBt21nqCsxv/Y/3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eU+sfDf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q8dfR4kx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eU+sfDf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8dfR4kx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 501F31D00028;
	Sun,  9 Aug 2026 16:07:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 16:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306034;
	 x=1786392434; bh=/14t5dchqV+tEHJ9OVyGMNZN24wOARWrgXV9Vg9WOaU=; b=
	eU+sfDf92SIaUhxfgCPGopVi2zeQVkzB7ae46XSwieiwhTp15tgh3T+Fy0dO93UT
	67U7MLsGWBhuJtL+N+W0HZn16CQqR9sIYL+piqZPQY3P92Yn0lzsWlQkP1ZEhmDo
	uIwB7YW412daS/JzVe7VC0A0IogjhDUR2kJho0YNQkCmeWRZPVoC9Q2Zyahm6NdW
	ZJJTbK7MfbaXXT2aQDgHjR1hzlRKBh85qbuQog+aDzad5vK2itTfP6RSScb+BDts
	9teL0nwKwrAPFbJXLXmTuc9XPOfimckrUQlD6EfdUD7eI0gWNn+zkDvsiAp8jOhH
	yQTaRxfyO75Hi5WnZ4EZlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306034; x=
	1786392434; bh=/14t5dchqV+tEHJ9OVyGMNZN24wOARWrgXV9Vg9WOaU=; b=Q
	8dfR4kxeTMCuGeZRMZuvPVVRmJ+3BKm/CGbqkyH50/Ly8r7VwE7doJujjrspDIXo
	OJM7AqspSdv1t0EBNPCZ7h1jhih1hq8U0OmTVM6hdvCs4UT3SKajbSzooU/vX96k
	z4YaHAzutvU9+SmLPsDv5WOjukLq8i4m7Xut/+W4rCdeWij/CTSFl1nZKhy5UaAm
	5BOrYyHZwxq8wYMpAF54sBIq8vzGCnRuP8RYg6tN0gHeaDvKdEYyXXbcBf3LgLEJ
	FAyfK55ESZmlouc5uleLdBJCWvO+eRkjfFHHZHVNkhB0u3FNVtUigXF0y0HEJApW
	GDtkXOOJgXGk1j0UAtWig==
X-ME-Sender: <xms:8t14ako_kymt-hfZpQWI3BVdv_0KfOfKhA5RyLDtJe-ikiI8EPbVtd0>
    <xme:8t14aptpLxGokprPlVvg3LkmuMMgbIw26rcVi509pq1dgBtLWBZ8qAhJSPbNeS-ZE
    _4Z0hYGDBIlemWkLMrRoRDalUic1eKm6Cm0P1AMFzbtb7KYQuJhRGE>
X-ME-Received: <xmr:8t14avb2gUJ581Gmnddp-7ABbbN7zBtjAbwYWe7ykVyO4i1QTFX1mpmWa4VFpfjdnFPa-bGZSk5_LNbJ9cYP0vO_riNWQ44nlt8yXI4V9Cm-6BCnD0YGQ2w>
X-ME-Proxy-Cause: dmFkZTFeqnCslSnr8i5H1YvUsi9MS94aL9oIV8h94CFICeyCkTImgemHOtBmEDLdj4YL6M
    QmfCTYL6YrLhJb/lwW2VC0HrakoWakpWCNE9jFvC+66OlHI19tlK2BZcsyGpjAN3z99T2z
    Be5tJHOKdcV2bO7t91dl6gt9zYDKcCx3eU2iKl3UTikYbFrgIrhmIiuT1CBlgR+3Q9K1YQ
    AnbZHKwswfFWQ4fkEWEeu/Fi9ouMoh67ghpAerMDcnua3v1e7DV9x5J0oUgV8rWCUM9s81
    zOtn96KWnhm/S/REuw8JBDEdSkVCFGkDHfGjLR07DJ6mZf+9i3Vu/hjFDuK6y1z29DPMde
    s8FhBWJxjo7XljChjEtFiWn6u1pra4LkviREeU0TUT8nJ/K4QJMLWxRoUDZoqq55k8p9AA
    RqJ2QpyEjxmhSEe/dw4FYLzMa1Tios25TQEdEPDHolHuVNGIWi0IOjuK7iS0ZGJmq4i8xY
    2TfPQzc3dLoTE3YJ5aV8gdNJjKzUQIQIDghJKGouC4Vf1OmyfiytaF0UVGuFSmtXjsT1a1
    565ml64AqhDn3pG2nBpxn28rWoN4c2LaOASu7rSg1Ysd5ltiZRDWzi8ozMe9yTkcoUpQLD
    k/WY+N+pJLAAeOyNYnB5lYBpktaTtaBSllGFlQbRxihCz30kH2/v2lQ4ouSw
X-ME-Proxy: <xmx:8t14aoZI6IjXg25BwzWQKJKb9d8MUdtSbH4S9rsodgRiI8ZR6vVaFQ>
    <xmx:8t14aonT1TP_iIZ1O_cCgjIHZ2OGIB6SnOV4tKo2BOhN96ubYgKzPw>
    <xmx:8t14aj0lHN8ZR4AJ8t0NFSQzp9e1omjtgf2X3EiSPC6O3eUUJbwgYw>
    <xmx:8t14ao35bwUUNLtUU0vseROLWs30Zay-Upx5oidvZuxL-dI1y8CLkA>
    <xmx:8t14ajHcwxmqZERw7BGaKHx-gY63_1TaHCtgNASEJXQzHKRddgQ62ASM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:07:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/11] doc: interpret-trailers: explain key format
Date: Sun,  9 Aug 2026 22:06:24 +0200
Message-ID: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_doc_int-tr_key_format.533@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-trailers

Topic summary: Explain the format of trailer keys (alphanum and
hyphens). This is important to keep in mind so that metadata is not
lost to simple syntax errors. Also replace some terms and define the
important ones upfront.

Here one change lead to another in order to make sure that everything
stayed coherent. So here’s a linear overview of the changes (as of v4):

• Patches 1–3: remove RFC 822 mentions, “metadata” term
• Patch 4: This command is not just for commit messages
• Patches 5–7: Explain the format in the simplest case, explain
  the “key” format, and add a new example
• Patch 8: join some existing paragraphs that are about the same theme
  since that makes the text flow better
• Patch 9: Also use the “trailer block” term introduced to the doc in
  patch 5 later in the doc
• Patch 10: Rewrite new-trailer paragraphs (relates to patch 8)
• Patch 11: document line comment behavior

Thanks to everyone who has been reviewing these so far. I understand that
these eleven changes are very incremental and piecemeal (see “very
cross-referenced commit messages”). And the commit messages can be quite
long, just to explain (again) very small changes. See for example patch
“replace “lines” with “metadata”” in this version, where I explain why to
write “trailer metadata” instead of “trailers metadata”. But right now I
feel like prose sometimes needs all this ceremony. With code you get
restraints like coding style, then you have all the years of looser rules
about when to use certain data structures, when to make helper methods,
etc. But with prose it seems that you bring much more of your individuality
to it. That means more choices, and many of them are not obvious to the
reader of the document, which means that you need to explain it in the
commit message. Then you also have to consider the writing history of the
document, and this one is twelve years old at this point; see the history
review in commit message “join new-trailers again”, after the thematic
break (***).

§ Changes in v5

Patch “document comment line treatment”: commit message: add missing word:
s/to/to be/.

§ Apologies for very cross-referenced commit messages

(see v3)

§ Cc

(see v2)

https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/

I have also added a new email since the email jackmanb@google.com bounces
for me. There is a Brendan Jackman who has posted messages under a Gmail
address. Hopefully it’s the same person.

§ In-reply-to: v1

The recommendation to reply to the first version/cover letter is from topic
ps/doc-recommend-b4, which is in `next` right now.

§ Link to v4

https://lore.kernel.org/git/V4_CV_doc_int-tr_key_format.ae2@msgid.xyz/

[01/11] doc: interpret-trailers: stop fixating on RFC 822
[02/11] doc: interpret-trailers: replace “lines” with “metadata”
[03/11] doc: interpret-trailers: use “metadata” in Name as well
[04/11] doc: interpret-trailers: not just for commit messages
[05/11] doc: interpret-trailers: explain the format after the intro
[06/11] doc: interpret-trailers: explain key format
[07/11] doc: interpret-trailers: add key format example
[08/11] doc: interpret-trailers: join new-trailers again
[09/11] doc: interpret-trailers: commit to “trailer block” term
[10/11] doc: interpret-trailers: rewrite new-trailers paragraphs
[11/11] doc: interpret-trailers: document comment line treatment

 Documentation/git-interpret-trailers.adoc | 88 ++++++++++++++++-------
 1 file changed, 64 insertions(+), 24 deletions(-)

Interdiff against v4:
Range-diff against v4:
 1:  2419b1a6863 =  1:  2419b1a6863 doc: interpret-trailers: stop fixating on RFC 822
 2:  859ab42ac41 =  2:  859ab42ac41 doc: interpret-trailers: replace “lines” with “metadata”
 3:  ab5b4af970e =  3:  ab5b4af970e doc: interpret-trailers: use “metadata” in Name as well
 4:  b79ddf3b13e =  4:  b79ddf3b13e doc: interpret-trailers: not just for commit messages
 5:  e7101eb1fcb =  5:  e7101eb1fcb doc: interpret-trailers: explain the format after the intro
 6:  557b5b5564a =  6:  557b5b5564a doc: interpret-trailers: explain key format
 7:  eee81fc99fa =  7:  eee81fc99fa doc: interpret-trailers: add key format example
 8:  cd3e47459c7 =  8:  cd3e47459c7 doc: interpret-trailers: join new-trailers again
 9:  c50b6d25170 =  9:  c50b6d25170 doc: interpret-trailers: commit to “trailer block” term
10:  c11a116605e = 10:  c11a116605e doc: interpret-trailers: rewrite new-trailers paragraphs
11:  7d20cb7528f ! 11:  cabbb05a1c4 doc: interpret-trailers: document comment line treatment
    @@ Commit message
     
         Comment lines have always been ignored but this is not documented.
     
    -    The primary motivation here is to reasonably complete in the
    +    The primary motivation here is to be reasonably complete in the
         documentation of how trailers are parsed; this is after all the only
         documentation page that documents this format. However, and going beyond
         that point, we could imagine that someone would want to use this format

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.54.0.22.g9e26862b904

