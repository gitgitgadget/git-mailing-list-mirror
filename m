Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0F229B1F
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089810; cv=none; b=lkUM/OHUXh+CG9Z9liJtWiXIlaIAEUG6jpP+1X6IqTHXAV9hGpo9PHVIezwKJt12hSeVyc9mwKQ0jM+mwLTcV9HCyYLsj55zEDgPqkl4Fvr4KQiLOdKMQW77tpBpat4qVnENAE7He6xgY54/UcNfz9JPc8GPLf19F/xq9liMA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089810; c=relaxed/simple;
	bh=5lpHHvKs7CMyWpTi3nMg5ZcIrHX9RT2NJH9OLJFjAa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1wBMwno3ID97Rjdl4UxRSKLvNpwMYkWhb1P3O8DK4r93i7ZzQQRzJnyMLQstyiPb5RoqVBbSkYaR2t9KEXVlUSYdfG+mb3JPa6TRo1ToGo+9rjbVnuRd5OpJFeVI/PJb0XZqdTho89YycuySd27Vs/S93WD+27Ki/7bIE0iomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QjkC3W0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQbwGep3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QjkC3W0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQbwGep3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 93726EC15B9;
	Fri,  1 Aug 2025 19:10:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 19:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754089807; x=1754176207; bh=7iwjVoDAlg
	mcKh4YsNorr59ASI83ptT/4dj6J5uM9PQ=; b=QjkC3W0fjwsqwFpVHFFG08VNsL
	ohavvyjZYcXNuC8O3wXWOv+3sxU2dwvYIirhQich4YsPJPhuy0lRFcDk+EAb3RA8
	upyD1ix0pnr3bPgJdNJ2npGHLFqJJgdkDgbwfx4MJ2e1pXiXzO7bGRG/axwFRxNP
	wuHIAhdUmln5pn317w2EpeVvI+tn/x9bT6zxiMdmCvyGcx/I5w+IrOKnoY45Ehhm
	KCgtEy80TyksCwbskFxZKHBcIGE41PW8s0Fv5zyTjNL1VrAIkxkNhG4/YA/kR6e5
	NViVbSfqncaumYrhtAYKzfBYluZuEW109ey48XUQ+2Hu/erq8+Gp3LWOdK3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754089807; x=1754176207; bh=7iwjVoDAlgmcKh4YsNorr59ASI83ptT/4dj
	6J5uM9PQ=; b=MQbwGep37OEteB2AVVmiznm0SqyLgfFt4EulcogKbZ/4dRcCKqA
	v7pT+95D7xjwhDqUoAzwVvlkQ+mbhDLR3JYcTi/wo0krR9cJ0DYDkHutXEMB+gwC
	HemGspg7UXMGTiEx8I3/5VFWsQHaLUkensUSRxl2VoYi5Gv+tmrtt+qtmRvzjnAc
	J6Gt8BGQMLahqS9S0xILvDV4fL+iy7+Q3HPvPnxQIUHs/bDIa2PgpmJ/5hQVyJ9M
	+nzdeBk25nG0D3LIHAPZYchJdl3u9vXNiyy/YIaqMjwJyUfNv3wt612Ws3waU6ON
	Q9ZQet3xjB4E5FgDMEaAsMcZL4NapLa5MXQ==
X-ME-Sender: <xms:T0mNaJjkXddx8zdcH1u5LLWSJ1yKhRrmY9ExbM-kTFZVBUBLroXdtQ>
    <xme:T0mNaBTt-M60A6GmbMjXsmSMQFG2A_vFMDyC74szKHVOoebFWAmLkZYaoe63vH8w4
    3otvfby3McM_9dwpQ>
X-ME-Received: <xmr:T0mNaChtN5TECQfwMIiQJgH-Se5RH2vk5Yphjg2ze9OIvDe2sFy2fFaEInmMH8YwA0rpH21QbjRYX7mccaYi05LkhORwetPEdOXZc7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T0mNaJ7l7KLQ-Z_o-xRiFs0xKYssueCN17wgm8KBeU9bTgUV6b3b7Q>
    <xmx:T0mNaHA5Y_HN3fq6tUAIeKyZX75xdn2hMVd__8axEVAY55NP6pmZcg>
    <xmx:T0mNaIYe7W36ae4OdekshCY1EwJ1HryipeuhBb1Q4dVCc0tWAN5TcA>
    <xmx:T0mNaKYjGZKibucrU9dhIraw-e-u6zPyl8z5SQgJ32gc8gGV8i4oHQ>
    <xmx:T0mNaJ4CnTX0fLA64UniwQaFrqQs4IaZbDwPHMRGwn3KcaT6II16KnV_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 19:10:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
In-Reply-To: <aIw6ojvvDWLPllG7@mbp> (shejialuo@gmail.com's message of "Fri, 1
	Aug 2025 11:55:14 +0800")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-3-gitster@pobox.com> <aIwndQtEoKNXRG5z@mbp>
	<xmqqikj7ogf7.fsf@gitster.g> <aIw6ojvvDWLPllG7@mbp>
Date: Fri, 01 Aug 2025 16:10:06 -0700
Message-ID: <xmqq5xf6lju9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Sorry to make you confused. Because there are some other changes where
> you don't use `static`. That's the main reason why I ask this question.

Hmph, are there new things that are not static but have good reasons
to be?  I am not aware of them offhand.

> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -348,6 +348,7 @@ int cmd__path_utils(int argc, const char **argv)
>  	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
>  		int len;
>  		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
> +		const char path_sep[] = { PATH_SEP, '\0' };
>  		char *path = xstrdup(argv[2]);
>
>> > And I have a design question: by using "PATH_SEP", we need to convert
>> > this character to be string. Should we create a new variable named
>> > "PATH_SEP_STR" or whatever to do that?
>> 
>> Sorry, but I do not understand the question.  You want to see
>> something like
>> 
>> 	#define PATH_SEP_STR "/"
>> 
>> you mean?  I do not offhand see why anybody would want to do so.
>> 
>
> Yes, that's my question. Because I see that we would define `path_sep`
> array in many place, so I wonder whether we could use such macro.

Why would we define path_sep[] in many places?  There is only one
here, and no existing code outside this helper needs one.

If it becomes necessary, I suspect that a global variable, i.e.

    === in some header file, perhaps git-compat-util.h ===
    extern const char PATH_SEP_STR[];

    === in a C source file, perhaps dir.c ===
    const char PATH_SEP_STR[] = { PATH_SEP, '\0' };

would be more efficient than having such #define and use site across
the codebase.

Using PATH_SEP_STR defined as a literal string "/" and sprinkling
many copies of it in the source files everywhere gives compilers
opportunity to consolidate those that appear in each file into one
copy (as these are literals and constant, they can be shared), but
would not give opportunity to do so across compilation units so
easily.  With an explicit singleton global instance, that is
trivial.

If we end up using great many number of them to matter, that is.  As
I said above, we have no evidence that would be the case, and that
is why I didn't make such a change in the first place.

Also, if many code paths need to split a path into pieces, it is
much more likely for us to give them a single well-designed helper
function for doing exactly that, than to have PATH_SEP_STR[] that
can be used by them from everywhere and have them use it to split
their paths individually.
