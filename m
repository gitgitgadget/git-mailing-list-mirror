Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598A28EA5C
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357228; cv=none; b=O1EXmWQvfQCNqb7rt4ztv2X1syRmMNjv0+miEYmIPuLtnJnpAMPpMxgrOpY4GLO7ge1v90stxrkzNKY4ojEZDYhEPoMGYZLjesoUN0n4Xml1cK/Ob2DBLmqCNLnXV86S9Oz03S0T5bNSZQ4D2sWkvNJO4Fzu52LDaQ92xTdMTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357228; c=relaxed/simple;
	bh=n5/9oGxeIUVG2Q2ODAIM9R37Uxm7GzvYUMD9P9QVK+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nN2k+GTUbcy9alF2V0wDd1yUrLVtKCl6mbMjUjsK14Z4nfukTvIcR+gAno9iuQKOrjxVj14XTAb7D687XI+kdwtUY0sWWKoFT5RM83bH1MCQc6B+k8+EF3w2f1wJVKsvZDMhdE5D4XKAla9SdWCpksWa0gVDlPPkC+CMOhxJINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fhsjwGu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAjTw/Bg; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fhsjwGu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAjTw/Bg"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16D102540146;
	Tue, 22 Apr 2025 17:27:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 17:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745357224; x=1745443624; bh=Sk6MuTD6Ln
	IRiwQm5UO5mG6QUBvxP5Nq/Tfag03WzN8=; b=fhsjwGu8NJX2yMGHTbBPGaBelb
	pXRayxa+ObLxCAdg/BGHcpsYTCfrTyQh5aiSk3IQJWW5+bq9Jlkv1m+bww85sNbk
	wcHyQ2ewu62L3gBf62fBGTinG8PWDrjkvoJt8YWc3ydvzqkeZd851waG6KvkWU7u
	kNYM1Hh/CKWWtGaxtXrSAnsDIjUVIM05Aw813hx4ouzso1sdDTxpJ1flu92/wS+O
	J4F42beLyKIv3mNKjPhNRD100yrSfT/pS1klSQ9bvmlx+l2+6jHz4DTxj3eIxlTH
	Nrj1i/GJoR5iP5efR0BvoL79wowUSjTEZhgyft20maRFhdUo7v1nyE5+Vzkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745357224; x=1745443624; bh=Sk6MuTD6LnIRiwQm5UO5mG6QUBvxP5Nq/Tf
	ag03WzN8=; b=lAjTw/Bg+W1MG4LTR6A3w5TShx+m4aUg6pphh0k5u0w1PAwfrv2
	1hJXumbFRfCtq92bYAiMovd2aPmT4YilOVxQsdPdSWZ88KhdedzR5d2RV4Is8haI
	zrIEx9c2Hm+o3ehejajy0zwdgPOfEhmsNPia2uEnnqRh/C6Hovn8oPhd1nYfpmR2
	ah0I9x+68WkR0aDbYXNbBFsnWBq6om81IM/DQYfsjBn5gyhJ22STc1aY6iICDGo3
	GBdmiiNyqWnRufJ7uZvekaQrjiDK9rfxCy5bL0r2P1Zu/beuTAVSlha7Kud4+u+k
	J98K3tgE0Y6geAcMzt9IvY0dW8Ydpuc9hcQ==
X-ME-Sender: <xms:qAkIaNpXbqfebWCTkBuYBYlEnj9xZqaWlPQwT4HsuszkuhSdUkGPNg>
    <xme:qAkIaPpf1705IrTtA9Z3KE0wFbbiMpHNfjwD7QieRh8y_tPr56Ps42d9CzNXrO31K
    Syc9mHyvXYq7fNS3Q>
X-ME-Received: <xmr:qAkIaKPRxpLDpchHYfgFrk2LARj6hTI7nrmyCA5gf3Dbx-Q4BiHUD6m5iYz3PLefjVxBgltEevOGVGvwSc2UU-BEe2r4bP9zetta>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qAkIaI4gJwDHFXmwKDKqfFmt-cwB6DSucR13Owop3GBsCe2HaJhcRw>
    <xmx:qAkIaM40FJu9hsfN3kRMyzd9bExvYMP6RJy_V6yVArMX93x_jFyUGA>
    <xmx:qAkIaAgs2gGRyr2-9xspxldl8Z6QHrq2E6q6R1pgawwyjnPewnSVZg>
    <xmx:qAkIaO6AccehBBTC8LPzKIK8YL3JQldVefnvtY0HXuPqcm2Kn-BPqw>
    <xmx:qAkIaCF8OJyuWoFO6O9osjYZN3jLS2yC37lG92S2YNVmrjzMyY_KgrRB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 17:27:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/5] u-string-list: move "test_split" into
 "u-string-list.c"
In-Reply-To: <aAetv8l8jrxvEywB@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 22 Apr 2025 22:54:55 +0800")
References: <aAetW0dan8S3Fljq@ArchLinux> <aAetv8l8jrxvEywB@ArchLinux>
Date: Tue, 22 Apr 2025 14:27:02 -0700
Message-ID: <xmqqr01j3n15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> We rely on "test-tool string-list" command to test the functionality of
> the "string-list". However, as we have introduced clar test framework,
> we'd better move the shell script into C program to improve speed and
> readability.
>
> Create a new file "u-string-list.c" under "t/unit-tests", then update
> the Makefile and "meson.build" to build the file. And let's first move
> "test_split" into unit test and gradually convert the shell script into
> C program.
>
> In order to create `string_list` easily by simply specifying strings in
> the function call, create "t_vcreate_string_list_dup" and
> "t_create_string_list_dup" functions to do above.
>
> Then port the shell script tests to C program and remove unused
> "test-tool" code and tests.
>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---

This is the most interesting in the u-string-list patches, as it
adds not just a moved test but adds supporting functions that are
shared with test functions added in later steps.

> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> new file mode 100644
> index 0000000000..0c148684ea
> --- /dev/null
> +++ b/t/unit-tests/u-string-list.c
> @@ -0,0 +1,86 @@
> +#include "unit-test.h"
> +#include "string-list.h"
> +
> +static void t_check_string_list(struct string_list *list,
> +				struct string_list *expected_strings)
> +{
> +	size_t expect_len = expected_strings->nr;
> +	cl_assert_equal_i(list->nr, expect_len);
> +	cl_assert(list->nr <= list->alloc);
> +	for (size_t i = 0; i < expect_len; i++)
> +		cl_assert_equal_s(list->items[i].string,
> +				  expected_strings->items[i].string);
> +}

Perhaps call it "string_list_equal()" or something?  "check" is a
convenient name that can mean different kind of validation that is
not limited to "is the actual answer identical to the expected one?"

Wouldn't it be cleaner to read if you wrote it without an extra
variable expect_len?  The compiler would notice repeated reference
of expected_strings->nr and optimize them away anyway, I would
imagine.

> +static void t_string_list_clear(struct string_list *list, int free_util)
> +{
> +	string_list_clear(list, free_util);
> +	cl_assert_equal_p(list->items, NULL);
> +	cl_assert_equal_i(list->nr, 0);
> +	cl_assert_equal_i(list->alloc, 0);
> +}

Validating the result of clearing a list may be a good thing to do
at least once in the test suite, but this is called from many places
in other tests.  Conceptually it feels kludgy to call this from
other places where they should all just call string_list_clear(),
like ...

> +static void t_vcreate_string_list_dup(struct string_list *list,
> +				      int free_util, va_list ap)
> +{
> +	const char *arg;
> +
> +	cl_assert(list->strdup_strings);
> +
> +	t_string_list_clear(list, free_util);

... this place.

> +	while ((arg = va_arg(ap, const char *)))
> +		string_list_append(list, arg);
> +}

To put it differently, you could be calling t_string_list_append()
in this loop, which would 

 - remember list->nr
 - call string_list_append()
 - cl_assert_equal() to ensure that list->nr is one larger than
   the value we remembered upon entry to the function.

which is not wrong per-se, but hopefully you'd agree that it is
overkill.  t_stirng_list_clear() is overkill in the same way.

> +void test_string_list__split(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
> +...
> +	t_create_string_list_dup(&expected_strings, 0, "", "", NULL);
> +	t_string_list_split(":", ':', -1, &expected_strings);
> +
> +	t_string_list_clear(&expected_strings, 0);
> +}

This is a good place to call t_string_list_clear(), just once in
this script.  All other callers are conceptually simpler to call
string_list_clear(), as the point at their callsites is to clear
after themselves, not about testing string_list_clear() works
correctly.

Thanks.

