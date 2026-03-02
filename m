Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5F2EB5AF
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469804; cv=none; b=iPhXwgi8q6mh4fd4gaWf4mcDxSjTwGj74NRH6tkl/wnRo19Tn8guPWz/B4Hq7wdghGhbrpDjt4ZdVQ6KBU+hlKBpPAI0zmL270qi8jAamLNEPvRiYdXwn53Ruj/xZbUJjtfgVSl1a/Y7X4BFPnLKJ6mHqKD5A+If/J4L641mrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469804; c=relaxed/simple;
	bh=JxKomQeZCuO4fOML4ZQ4V+ZdoEoWRJwsvv8LxK4aFAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGU5jnLnS9f99zLQGdODhjHZegQA22Qoh3gBzKo+fAHjKPDNeklzNtDqI9Twcw/dUn3PjkuaeMJAlWGhJawpSxEAkLqhCJAzb6HFihRddnNeConnm8N4XJqXrP7egWMsmUZOqF6200Bt5PmZ6Q/T1X4fK9kTg8EPcTuF3LIuKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gz3DlxEI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kfFBdBES; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gz3DlxEI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfFBdBES"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED7737A019E;
	Mon,  2 Mar 2026 11:43:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 11:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772469801; x=1772556201; bh=wkq6m+F5EQ
	W4411of3apkdeJj5nwXrrz/qUYAEGCw/c=; b=gz3DlxEIX4H74Ovw9WvP7Exsfc
	jMQEnjM370mBx9586LnsqfvLwvAfaOaAlkIGqvxarSjKb83KYVituzR6vTajDzCL
	1pK7+8+XfV1RsrjaZHcjUzv9Bab4kC1np4tceBjGElZNV24lPBbSefCxkBjpDLF7
	G1uWpssfUo/bLoa4tNa2kwtgAVbreumWTPXiFgqjYJGKn0/1kHv8LbPuL6scKxlt
	MPqitpSuaOt4yTjYwZFw/1cWnjERRrEwOMJjLIB/V/QEund1mHtIh+IC6CkvEhYw
	T958Gf/W22oI7v941JbpcblGN5lwSozcppdzSKn5mRvO4ZvFW8ggul1lzmSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772469801; x=1772556201; bh=wkq6m+F5EQW4411of3apkdeJj5nwXrrz/qU
	YAEGCw/c=; b=kfFBdBESi8NFcNYZwomRMf8yUmJ9f0bRu7yHypOpoVm0b6i0XjW
	22ucQ9rZiNUTyovdsQFwFtq2+09RKLayrzy+LmBK68ycLKh3eucmeqaGexdiZ64K
	07xy6YllRfRi9A9qYzlG6sDjuoy9Tg3dXzyvXK3X3Qmlhn1NOTOW5qw91PaNcwdW
	yzesQAMntTYR3i7mB7sJJS9ocXJzXTzn/fxF8ew/D8wcdO9HYfq/LQAxBxwS43jt
	PUn8pr5exFsuvwHTKtninyzdFDgo9qy7pEuGmPgH6qpROv4RePNqKCFnOallxQSw
	PBsh9oLzwlu4vXMByCz/E0gKcZ/Upq1+JSw==
X-ME-Sender: <xms:Kb6laYUyTTfRvltL2AdPJN2wyISn5HSeNpwxIdAMgGYjZhOTak7YFw>
    <xme:Kb6laUWEqLh2huOIfRgeUpaCtmDTbNy_WERmRj25dO6lwBlgryG3iV3N5kUjTgahh
    vpV0KAKH5iY5Eq7uFCtBPGoKOFNWek2FBts0FxABv4oq9ilEO__Yg>
X-ME-Received: <xmr:Kb6laffKkzZkRqeJNn5k94vRex6vffSzhnEPq4mnKlPPkZFZ3jTRekt297Mdc1XIsralKMgCWwZ57RVb9fYaAXvVR-7--UvbTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevhefhhfettddvtedukeeihffgud
    fhueehuedviedtudekgeffkeejuefhueevveenucffohhmrghinhepmhgvthgrtghprghn
    rdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegugiguthesuggvvh
    drshhnrghrthdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Kb6laVXWjF11tja1vEWdhoL0I_WsV3GHPNPKsaTopHweDBQwx2shXw>
    <xmx:Kb6laQeqthcYVffF7Ifaogh5lXu7_og_JX9xCcswQFclbsHX8i2GPQ>
    <xmx:Kb6laZNvK2lzKa0Muv75VnCSv7vzWSajc_foJmrS3MSu74Ted3ACfA>
    <xmx:Kb6laWihKpGHajRzwcnkUWnQgHcvBU723zmV0LbMa2dxAMchjzLV0A>
    <xmx:Kb6laV9drzJtsatoqJyK3lgOqtdY9ny-ozr_yiYrufIUqMGiIdPgRbYJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:43:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Timber <dxdt@dev.snart.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] send-email: add client certificate options
In-Reply-To: <20260302032048.260209-2-dxdt@dev.snart.me> (David Timber's
	message of "Mon, 2 Mar 2026 12:16:41 +0900")
References: <xmqqo6lb4fuy.fsf@gitster.g>
	<20260302032048.260209-1-dxdt@dev.snart.me>
	<20260302032048.260209-2-dxdt@dev.snart.me>
Date: Mon, 02 Mar 2026 08:43:20 -0800
Message-ID: <xmqq7bru41xz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> For SMTP servers that do "mutual certificate verification", the mail
> client is required to present its own TLS certificate as well. This
> patch adds --smtp-ssl-client-cert and --smtp-ssl-client-key for such
> servers.
>
> The problem of which private key for the certificate is chosen arises
> when there are private keys in both the certificate and private key
> file. According to the documentation of IO::Socket::SSL(link supplied),
> the behaviour(the private key chosen) depends on the format of the
> certificate. In a nutshell,
>
> 	- PKCS12: the key in the cert always takes the precedence
> 	- PEM: if the key file is not given, it will "try" to read one
> 	  from the cert PEM file
>
> Many users may find this discrepancy unintuitive.
>
> In terms of client certificate, git-send-email is implemented in a way
> that what's possible with perl's SSL library is exposed to the user as
> much as possible. In this instance, the user may choose to use a PEM
> file that contains both certificate and private key should be
> at their discretion despite the implications.
>
> Link: https://metacpan.org/pod/IO::Socket::SSL#SSL_cert_file-%7C-SSL_cert-%7C-SSL_key_file-%7C-SSL_key
> Link: https://lore.kernel.org/all/319bf98c-52df-4bf9-b157-e4bc2bf087d6@dev.snart.me/
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  Documentation/config/sendemail.adoc | 16 ++++++++++
>  Documentation/git-send-email.adoc   | 19 ++++++++++++
>  git-send-email.perl                 | 47 ++++++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 11 deletions(-)

It's a lot of text but quite informative.  Will replace.

Shall we declare victory and mark the topic for 'next' now?

Thanks.
