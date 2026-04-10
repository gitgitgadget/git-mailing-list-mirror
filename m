Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96531282C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845782; cv=none; b=mnaXNHf+8hQmBcGoD8SH9pW06W+YPsYGkMcnKE1GXn14VUQqw15LOatCtpFLuMA3JOFCZD0sb3hJTLtxaLSEOxKIB/P+I5RmiimazsUP8sBDBATWnd4xCcbeCaIQFpT6hk+Bol95n5ab0JyCiuz5gQ7O4MyJGroKgVNuQO/yLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845782; c=relaxed/simple;
	bh=G7jbPX8LitaaU16yoizd/qDqnR/6v3jzVnP0YwT2vLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjzs94roUZBq579GTvUUNukkYkqhAB0Nfpr1TuIWT3BCT705HWsBIIRmkkm8HK/MHm6/HUKmrTeTbUGZM4FxJixPaK0tNzqbITIX59e0tMskr7YEqmm2L02aWnDFNUKywmLiSaNOOu2migV8vNOgwEeRypbLfl9SNefxpEo36ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VLsWQdWj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DsKV8Zp5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLsWQdWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DsKV8Zp5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 416677A0277;
	Fri, 10 Apr 2026 14:29:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 10 Apr 2026 14:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775845779; x=1775932179; bh=eff6Oj3ztg
	Gq+vpAImOb0hAoLjBhVFub41KwYsc3GV4=; b=VLsWQdWjQ8aQv4VUz+dv7gmORC
	BpAHve3f04JqZlhFb5T7Tf4PkDssUaaI5bhN4wwBXYpfxVy6/kDVO7Voh65fT9JN
	BRJ5/DpLtquNsuXcybG4SIj5TeMtjypr/k3ZBt5tbyi98h4vax1Y6sNgWG7EvXmN
	vjNfTSF0yN9fhiiyxyrqSgU4nxcllPkWR350LJsq99WMF18p1HvqbHD2K2kYyfed
	lxu2BYayu7+4d/dyMpJwA5e6iZhGVeBZq4DjSh81iPANO/wm5Br+8+Tyixgg9aof
	575+FevOKG2YBim9NDhSJj9s1i3dVZ4/vk8pnn6yXwxW7Ynt/G5dWBbn9NOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775845779; x=1775932179; bh=eff6Oj3ztgGq+vpAImOb0hAoLjBhVFub41K
	wYsc3GV4=; b=DsKV8Zp5TYsnFvIzKx2btRNxlVmkMz4xBiZrcqvJV4m69xT15HT
	2p0IXjqNwDuMBHJqCp91a+Wc7pPF22oYqplMwR1U7lN0J6KS7HY0xjDyy4LNSgcT
	fh+3IymXnXCsTWKvlb9sSH5a84BlxxBnZ3+ONgOxB2O7+z5K7Vi5RQzjATAE1lK/
	Dyy9vDTUquYvdUt8rr5yZ7zQ5HfK4xcnGun2tKQt9Grw4Qj34aB3HWCOWeNzkyYh
	QdH1a8oqeFyuSP/e7U00Ag8L2Fu1IOLdgrIXgaArqnTDURv1D8vGEohcivkodijn
	Zie6HuEBfgA0HsS5eGOWT/7Cg3qdi/B3IBQ==
X-ME-Sender: <xms:kkHZadfE2gfTTZVNbD0zqHD7A3hJE8N7ny3RPYtXO9J023z19wv2uQ>
    <xme:kkHZadf9AMxh6jXXfnb7j1AUi6OQkhesLgB0ZiYlLbJ4mhtkgMpHPFvHz4hctbGtp
    SADWs7BPT-XwGXNTECqU0KzU0KPZl2Hywho9oeIfwfAJC4g4byWgA>
X-ME-Received: <xmr:kkHZaYwa8x9lGbV8oOXlNDJ66kxolLhMTIqkBA5ASZdgJ1Pf646XM9W869-MNyiQVXKB34YG83-VG442OMaccGBAq6OV9fGDUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kkHZac-DG3TAzVnfptsaIjbWzGK-gXk66FfFUoqlkmqSJyPebQ7Iyg>
    <xmx:kkHZaYjtq3QRfLcVn-dxwsOe0Q1zlIuAN7FPH7wqGz7Wp0jRFmyjTg>
    <xmx:kkHZabGySWDY-qHFLV-_NA0zhBASzC7eKAa7afCXa7kTBauyxzRodg>
    <xmx:kkHZaf928uKkOllsgzCcwNRiX2cN_tmxFtQNdr3GKHTqIoTR2JBk9w>
    <xmx:k0HZaTEP-a0lsn7px68R0-FApW9GAhOffLrpmx9u_gKjrHlRUcCiKTON>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 14:29:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v3 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <xmqqo6k3ztxr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Mar 2026 12:21:20 -0700")
References: <20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260331121111.9614-1-siddharthasthana31@gmail.com>
	<20260331121111.9614-2-siddharthasthana31@gmail.com>
	<xmqqo6k3ztxr.fsf@gitster.g>
Date: Fri, 10 Apr 2026 11:29:37 -0700
Message-ID: <xmqqv7dyoei6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>> but this option needs to be set when the process is created. This means
>> we cannot change this option mid-operation.
>>
>> At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
>> process and it would be useful if --batch-command supported toggling
>> mailmap dynamically on an existing process.
>>
>> Add a `mailmap` subcommand to --batch-command that takes a boolean
>> argument. The command now uses `git_parse_maybe_bool()` and supports all
>> standard Git boolean values. Mailmap data is loaded lazily and kept in
>
> I do not think you want to say "now uses `git_parse_maybe_bool()`".
> Nobody is interested in the difference relative to what you did in
> the previous iteration.
>
>     ... that takes a boolean argument (usual ways you can specify a
>     boolean value like 'yes', 'true', etc., are supported).
>
>> +static void load_mailmap(void)
>> +{
>> +	if (mailmap.strdup_strings)
>> +		return;
>> +
>> +	read_mailmap(the_repository, &mailmap);
>> +}
>
> This, especially the early return condition, may deserve a bit of
> in-code comment, as "a used string_list has the .strdup_strings bit
> set" is not a generally applicable rule.
>
>     /*
>      * The mailmap is initialized with .strdup_strings set to 0,
>      * but read_mailmap() sets the bit to 1 (this is true even when
>      * not a single mailmap entry is read), so it can be used for
>      * lazy loading.
>      */
>
> or something, perhaps?
>
>> @@ -692,6 +700,21 @@ static void parse_cmd_info(struct batch_options *opt,
>>  	batch_one_object(line, output, opt, data);
>>  }
>>  
>> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>> +			      const char *line,
>> +			      struct strbuf *output UNUSED,
>> +			      struct expand_data *data UNUSED)
>> +{
>> +	int value = git_parse_maybe_bool(line);
>
> As "line" is never NULL, one standard way to spell a boolean True is
> not available to the callers, namely, "mailmap<EOL>" (like how a
> configuration file entry "[core] bare" means "[core] bare = true"),
> but that is probably OK. "mailmap<SP><EOL>" may be interpreted as
> feeding an empty string as an argument, which is "false" to the
> git_parse_maybe_bool() function.  That might be surprising.
>
> Nothing actionable in the above comment (other than perhaps as a
> hint for documentation update).
>
>> +	if (value < 0)
>> +		die(_("mailmap: invalid boolean '%s'"), line);
>> +
>> +	if (value > 0)
>> +		load_mailmap();
>> +	use_mailmap = value;
>> +}
>
> Hmph, why not use use_mailmap from the beginning of the function
> without introducing the local variable "value"?  Nothing in
> load_mailmap() pays attention to the current value of use_mailmap
> so I do not see much point in preserving the current status until
> the last minute.
>
> Thanks.

The thread went dark since this message.

I do not want to see energy spent on a viable topic so far disappear
into a void without achieving anything.  Let's push the topic over
the finish line with futher work.

Thanks.
