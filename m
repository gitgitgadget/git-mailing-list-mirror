Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0013B7A3
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453163; cv=none; b=vEHveIYtOG8wAsU3mo/dYz1CdzAZ5jNgC7kCtPWU4HJN0y7WnI8aktsQowQ98heBbrYo7kGsk+nfy1TnaEKAXS+y3w2pVeipzVA/fzs3Lyt48FsoyeOnqtAlPvR+j8NQgzx8AVXtvlgvjBPgOxTgpHDBpyXt7ReAE49n3wzJHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453163; c=relaxed/simple;
	bh=fqyFXcAvCRsaJsuMCpbS+1v4yqHHcjNpA9ZIe4DAoP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqCmsLFbGvpExhKAa5N+pFsPcRoyKEZSLnVoHr0hGKT7fV5UFAWxmkJmRMN6ggNiToKJQBLkO/REpCIjG37oIh2F4W1BHX/3LLxuEfoRUMRpAqyYEX0ERjpRcNZ9QheRGPuMyJZQ4OYDXCxqGBPSC1eR9x1b2c4Sk2NEy7ui9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vlGCMLYK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vlGCMLYK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FDF41A5CE;
	Mon,  8 Jul 2024 11:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fqyFXcAvCRsa
	JsuMCpbS+1v4yqHHcjNpA9ZIe4DAoP0=; b=vlGCMLYKrGUEYdwvr0vKr0ULK1lF
	EaJwq7zvXT0fN+USExV/PjTDTwRFGMIMVitRvvKzjCnKL2Qzg7wZNLdI7TRM0FR/
	vWERJamapkqsT2kdLcA+fa0Vm57wEKSwf23P8aRXVbAJJE3MFOBREGHWNQmDwi7k
	s5TuolZWYCr+3Yo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 47EDF1A5CD;
	Mon,  8 Jul 2024 11:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CAF271A5CA;
	Mon,  8 Jul 2024 11:39:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Git List
 <git@vger.kernel.org>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
In-Reply-To: <69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com> (phillip's
	message of "Mon, 8 Jul 2024 16:18:16 +0100")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
	<51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
	<97390954-49bc-48c4-bab1-95be10717aca@web.de>
	<8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
	<6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
	<62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
	<69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com>
Date: Mon, 08 Jul 2024 08:39:16 -0700
Message-ID: <xmqq8qyblwpn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3CC49D02-3D40-11EF-96C5-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

phillip.wood123@gmail.com writes:

> Hi Ren=C3=A9
>
> On 07/07/2024 08:20, Ren=C3=A9 Scharfe wrote:
>> Hmm, again.  I can see the appeal.  How to call it?  Given that the
>> foreach macros have lower-case names, perhaps to indicate that they ac=
t
>> as control flow statements, not function-like macro calls, would we wa=
nt
>> lower case here as well?
>
> I'd automatically assumed we'd want an uppercase name to signal that
> it was a pre-processor macro but I've not really spent any time
> thinking about it.
>
>> 	#define test(...) if (TEST_RUN(__VA_ARGS__))
>> 	        test ("passing test")
>> 	                check(1);
>> 		test ("split single item") {
>> 			struct strvec vec =3D STRVEC_INIT;
>> 			strvec_split(&vec, "foo");
>> 			check_strvec(&vec, "foo", NULL);
>> 			strvec_clear(&vec);
>> 		}
>> Can't get much cleaner than that.
>
> Yes, I like it

Yeah, if you squint your eyes hard, it starts to look a bit like
test_expect_success we use in the test suite ;-)

Isn't this introducing a new control structure to the language?

A macro that is a conditional switch (aka "if"-like statement),
having "if" in the name somewhere, and a macro that wrapts a loop
around a block (aka "for/while" like statement), having "for" in the
name somewhere, might be less confusing for the uninitiated.

> For someone new to the project it should hopefully be pretty clear how
> to use it from the existing tests once we have a few more test files
> that use it. Maybe an uppercase name would signal that it is special?

As to the cases, I personally prefer lowercase names whose semantics
is very clear, just like e.g., kh_foreach() makes it clear with
"foreach" that it iterates over the set.  But the above "test" may
not qualify---it is not making it sufficiently clear what control
structure it is creating with its name.

Thanks.
