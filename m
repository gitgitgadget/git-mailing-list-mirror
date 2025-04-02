Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BACE1EF37D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592411; cv=none; b=n/4i7ejEpWpGUVrQ1P3L0wlBMKq1of3xMtUpfw0shw7F7kcCR3H9WnaAhN7XttFB06xUdq67y1w8xVtNz2/DVdoqdcbLWaZedZLCJwoersVLWar+BKYUGy3jhLEEbelwdAWlBWw4Tm1TKhfWByTGciyKjjvBj+3O7sJiS0zWTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592411; c=relaxed/simple;
	bh=oAEYTER024N994GA1Jk5u27IjM1g6ztXZvlh5OHYncs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZvUiBGtXtlC6ILYvg5SpBCWIBEAzYCclJPqEatvJ6U/QBkJAzarFS4GIi1XE/10OT2c/7VVxIl1qDvIXW3Jg9plefAVK8GaBbDXZlkxwxY/Nf3iKtcqFaE3KgylyJDmIrrp0hVSjhiJoFC9kc9ckKHr7o4DKfapf/hhGxnQFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=quB1GgwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1UCxPPv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="quB1GgwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1UCxPPv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03E1225400EE;
	Wed,  2 Apr 2025 07:13:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Apr 2025 07:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592408; x=1743678808; bh=xBlX+DUQBs
	eglQV1wmKwvinxqn8fWdjIAEmLg5/71h4=; b=quB1GgwAgvrLYjJvx9KVt+SLxf
	mhSXt/Bo7GazZb/gd309LtFl+di90ouVh6A/xTYDoR/a8/11FQUcR0UA2IFprQGB
	y9A7EiBf9p6wt6uEG2xGbEqH1F4hjnk9GW1zm8jOqs/kqq/kgJfjLKxbjMCXPjfx
	Y81/1qVwGKSX6sakJeLqovUHYr4UjODWWYuGk3L45E7LOlsA4xABTY2cXwSd1rY8
	wZoSTRtqTZ0z+EjXgHn7waOzCCYtkf0DMRfSWr2xXYXLEatG0uLs1QBHYiEf+ZXi
	p1LP2eZghUydq+j+jvTNt4jhmH01ffgSdt2f/gse4qqvDPjyRM1b72xDrteQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592408; x=1743678808; bh=xBlX+DUQBseglQV1wmKwvinxqn8fWdjIAEm
	Lg5/71h4=; b=O1UCxPPvmH0D726aXibNfOhJ/OOJsI3QWDrffQCauTgrFhY5E42
	eqodXID10H3s5FY/mjY81D6sTwoFLP2BNGVJRN02dRKSeVI6Yvjsglv8gfNXIhZl
	K/cnsqOSfyS8A+SeKddtC3IZdnE8YsScRDj/hUkQ+31sCvxCSNfzWIfYyO+7ai7+
	9vcH0BbEJlk24wy8RiycewxLzbfL1+kGuGd4vYunrzYZ1xiDufP+xo96MW6/n/2f
	XQffFiK2e8aboG61vRvZYSV5pVbshi5l91c7ddpFnS1NT23Kt/1qdqwxHl21oUq3
	guVu1AcZc4D32j3YkcAN2pOxsYqaau385Gg==
X-ME-Sender: <xms:2BvtZ6p4ilQs-aHWMMIt2Ldum7BHR8-DTgypH9A503fiT-JzjWKq6g>
    <xme:2BvtZ4o4DFgJVdpdSfSQy4iALyIG8M92DLMCnKra1035sclKTwVyfj6yIvCzh1WEj
    bs1V9R_o6YGBozXug>
X-ME-Received: <xmr:2BvtZ_NmmDq_8oycH0_uXFCdh6dW3VFPaTWmLdaUSPLGnVxPuHzkoB2n_f1cNjnNMe8UMBfBHMtJG4d-7VeU_zk2A1bsgGtWUtKpkNw9SFe70Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:2BvtZ56TScatyTGEbayn-yiDkFrs-6I97J_MX5nKpRb8JYAFAMNukw>
    <xmx:2BvtZ56S390TPloOovXvCpMqeXGZPwvMQU7KcQj1y3WfOFGJnT5K3w>
    <xmx:2BvtZ5j9eQScrBpCYIuCHv5imkkvmMuYTg1qdGRoCg5H9piKuYG-SA>
    <xmx:2BvtZz4bhYwQ3pm6JB0TJVKqp_viC3Hq7Kjie0nXyODKcQfk14nFkg>
    <xmx:2BvtZ1L_YqyKS5H4UmsjInVu7sJa4AmT6xZ_RuE84qNIn-kg9vRpY1HH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c194397 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:26 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/10] builtin/cat-file: wire up an option to filter
 objects
Message-ID: <Z-0b1l3Q-lYH5z3E@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
 <CAOLa=ZTgU+E3Y6DRCA0EOg9uOvNoggCRPBNYjDZTOinaDVj95Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTgU+E3Y6DRCA0EOg9uOvNoggCRPBNYjDZTOinaDVj95Q@mail.gmail.com>

On Tue, Apr 01, 2025 at 05:05:17AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In batch mode, git-cat-file(1) enumerates all objects and prints them
> > by iterating through both loose and packed objects. This works without
> 
> Nit: I assume you're referring to the `--batch-all-objects` mode. So
> would be nice to specify here perhaps?

It's not though, the filter works with all batch modes.
`--batch-all-objects` of course is the most likely usecase as it may not
make much sense to use a filter in other contexts. But they still work.

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 8e40016dd24..940900d92ad 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -15,6 +15,7 @@
> >  #include "gettext.h"
> >  #include "hex.h"
> >  #include "ident.h"
> > +#include "list-objects-filter-options.h"
> >  #include "parse-options.h"
> >  #include "userdiff.h"
> >  #include "streaming.h"
> > @@ -35,6 +36,7 @@ enum batch_mode {
> >  };
> >
> >  struct batch_options {
> > +	struct list_objects_filter_options objects_filter;
> >  	int enabled;
> >  	int follow_symlinks;
> >  	enum batch_mode batch_mode;
> > @@ -487,6 +489,13 @@ static void batch_object_write(const char *obj_name,
> >  			return;
> >  		}
> >
> > +		switch (opt->objects_filter.choice) {
> > +		case LOFC_DISABLED:
> > +			break;
> > +		default:
> > +			BUG("unsupported objects filter");
> > +		}
> > +
> 
> Okay here it seems like it also applies to other batch modes. So it
> would be nice to perhaps clarify how this works when not used with
> `--batch-all-objects`?

The filter works the same in all batch modes: if the filter says that an
object should be excluded, it's just not printed at all. So none of the
modes get treated specially, and the documentation already says that the
filters apply to all batched modes.

But this does raise an interesting question: when using `--batch` we
basically follow a request-response schema. So when the object gets
filtered, we'd skip the response altogether. Which raises the question
how the script would learn about this in the first place, because they
would continue to wait for the output.

Maybe we should do something similar to what we do for missing objects
and also print excluded objects.

I'll implement this and update the documentation accordingly.

> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index 398865d6ebe..1246d3119f8 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -1353,4 +1353,36 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
> >  	perl -e "$script" -- --batch-command $hello_oid "$expect" "info "
> >  '
> >
> > +test_expect_success 'setup for objects filter' '
> > +	git init repo
> > +'
> > +
> > +test_expect_success 'objects filter with unknown option' '
> > +	cat >expect <<-EOF &&
> > +	fatal: invalid filter-spec ${SQ}unknown${SQ}
> > +	EOF
> > +	test_must_fail git -C repo cat-file --filter=unknown 2>err &&
> > +	test_cmp expect err
> > +'
> > +
> 
> Would it be also worthwhile to test the `--no-filter` option?

Yeah, let's.

Patrick
