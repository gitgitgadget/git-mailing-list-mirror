Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65A2E3B15
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056403; cv=none; b=B+Ubcoo1TW2CSFLiuGAqukVjUk+5XeebftebGtwztf2DDOK0MU9/JLYQhw9HKSZnecSrrShQMqLUPQkSU8jSR5G6G3KNxVqkFfhDRctWFSLW37oMJsExhFLLYnNTnJ/l1jGOPCgF/lsUBYw8AwlBuqhDu9jvx96Hpjelr1MYV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056403; c=relaxed/simple;
	bh=fiWiRFEXZYP7uPS+To9oGzgRwJ+bHSD/Qg+kd1DbcQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4tfJgqogiHfP/25Yq7LxqgcYekqkJa9m7rJq22HHzHkLXJfQKI3u5JZtI1KSGhKSYboXhKsW2duY45nq6zD9XIo4VGq4HdjSpGc1/Spf3UcbCIs47Ktnk7RBQqyJjs36egZ+TkXIpl1oisM97n6tjGxPyF1eWuSK2AOIK16DdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uyYqsJZk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOHfX9Iw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uyYqsJZk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOHfX9Iw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CD51DEC05C8;
	Wed, 25 Feb 2026 16:53:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 16:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772056400; x=1772142800; bh=kPKas6+DCx
	VGZng3a3hvmGnxB5O5unihToZUS82CTrc=; b=uyYqsJZkM0cwmMviTJZwQKFR07
	+hVCsblj45Aj8YXRU0jO0xKPFCwiBvyYGj7EP9cCtoRjnukMt6Ykr75BAfPAopb2
	e9abhxXunXwd+3BWkDfItQclQJdadOo8oq0WcCBsjBR+vjZGcIydKejpQdlrBVVu
	m1Rl8qbMPbA4lFeYO4qlxjKGwBVa6zJvive+vPBVwpp5hfaq+j2QpwScnUs/afpZ
	KNsTmBVJeT/8s5hd67ueQc80+lHeo92pxKQcFAZsYc8AupJRB/XHwFAtH31ROESr
	jkS6SBk+d+EyuwXaKGRQEDbYr5bKbVGL9sY3c1dKsfzsbQRsAb/3HYMhs1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772056400; x=1772142800; bh=kPKas6+DCxVGZng3a3hvmGnxB5O5unihToZ
	US82CTrc=; b=KOHfX9Iw1n3hNFB21XtFDA/1ItvvttjLnMDhLMpqygbgdWQXSgC
	/h8fAi60Zk0PaD+5ObxK4U1xhqOk5APa0GlMf72w4V8S8JqmLeW8T3WM5r32a8TA
	kuQOpgo3FJnPsPoJkPVoYmYJu6vgSRmvz/lLnHQPr46ue0kE4schbN3R7s/fRW6e
	VwesJbYy5viwmVS7T3DKA8moctrYMI9CGv0/vY3mwcFyIUVm1FWe/0NEfOoal6RH
	GBAA7U1JDln0OpVIoAh81u0hTQCKS8kzOWxHNIXgBa7oNTmTpCH85BLbxRost5VN
	skfZMZ059On3VJdUM+uw0TifvOVCOM0yOAw==
X-ME-Sender: <xms:T2-faYBxnxbo6cAl7dKIF8RdiBs0NbX9_tFtsdltauf_dQgbWLf5rw>
    <xme:T2-faYzZVOZp3jkknD3-wtFgUIQd9e5Jdzz0egK5JNp6ONxlXAu_KOwW1RHloCFUm
    EpLIq_y5XbfbRrAoBBxbZKFYmwrroHFkYGXJUYaFhLpPLZEqjPt-A>
X-ME-Received: <xmr:T2-faU6s8jnvprPBtFBlU_JsTn1KctcnXQBGPzq1tzXXiPV0VKwG-NkNx4hkMEZNMNafG8wP6-uqPIYPPJ6SORSeEaB4QCdrjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlh
    hmrdhorhhgrdhukhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:T2-faRxE7iUSf-TZRFltDSoCs0E19cNovGzUzMJp8juS8L94ngz_bA>
    <xmx:T2-faQdDPxn6eNXZfDPLsYURvz328ByjHNZyOxG3IVw42Wu6vLONFA>
    <xmx:T2-faeA-zS9qiq1w-xBdOM9xAnX6WDpjchxo9J7gXvoZcoKLdk7_FA>
    <xmx:T2-fac4-sr8yHR0zrb_O-BKkG7CYhKjpiPGt06nIiH8iwGhk13wcow>
    <xmx:UG-fad0k2xd8gYQErnXNHm8Gl82u1mCHXjaTe_MgCvE7emMgmeKvP-kA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:53:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  newren@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  karthik.188@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <87wm07e4ck.fsf@iotcl.com> (Toon Claes's message of "Fri, 20 Feb
	2026 18:01:47 +0100")
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
	<20260218234215.89326-1-siddharthasthana31@gmail.com>
	<20260218234215.89326-2-siddharthasthana31@gmail.com>
	<87wm07e4ck.fsf@iotcl.com>
Date: Wed, 25 Feb 2026 13:53:18 -0800
Message-ID: <xmqqcy1s8p81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> -			   /*
>> -			    * We don't touch pre-existing repeated reverts, because
>> -			    * theoretically these can be nested arbitrarily deeply,
>> -			    * thus requiring excessive complexity to deal with.
>> -			    */
>> -			   !starts_with(orig_subject, "Revert \"")) {
>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>> -			strbuf_addstr(&ctx->message, orig_subject);
>> -			strbuf_addstr(&ctx->message, "\n");
>> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>  		} else {
>> -			strbuf_addstr(&ctx->message, "Revert \"");
>> -			strbuf_addstr(&ctx->message, msg.subject);
>> -			strbuf_addstr(&ctx->message, "\"\n");
>> +			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
>>  		}
>> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>  		refer_to_commit(opts, &ctx->message, commit);
>
> I still find it somewhat confusing we have some the code that deals with
> `opts->commit_use_reference` partly in here and partly in
> sequencer_format_revert_header().

True.  Making sure plumbing commands are unaffected by random
end-user configuration is a good thing, but I am not sure if this
command is truly a plumbing.

> Part of the confusion comes from sequencer_format_revert_header() being
> called with NULL for the commit OID.
>
> Was is not possible to incorporate Patrick's suggestion[1]?
>
> [1]: https://lore.kernel.org/git/aTZ5RrjnwJ2ZnT7A@pks.im/
