Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7393CCA07
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161162; cv=none; b=IwdcacEOm2Rx9jyhvXdMfNlD2EmmoFZAw9kDDkIH8CbPY+gxqJ4yvCJxg2uJXE5jI1Se5JrFW9u7pvQd9k/VuGIXZM76nhwnzehRNoLJ0p7DE9LyIU/syjl0GKYy/7kpl+Jcwuo4cL9+ddJR+J34HfQcX5lOWeZM5aQN5p+/5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161162; c=relaxed/simple;
	bh=Z2VbkPE5UnSdS1Y9v07rrSNUSP3cb2uIOOfLk5n4pgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9WRcpx6ExHNrCgo/5UzoSWqFO8bbULA6QDeeCbz5cyq80AIqP1R+KfO+NURMpHgeyi4KgxefRYwbCpr3npty/cUchwmXydaonhNU5T01S8WSJthBrd1jUsn7y2lzW0beLV/yM4X+QJJzaDcNLiORg6z0WULbrDiJnWiAAPRvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+tR3zYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3AkLmSGn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+tR3zYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3AkLmSGn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D939FEC0FF1;
	Tue, 10 Mar 2026 12:45:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 12:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773161159; x=1773247559; bh=TJyi/YwFvA
	W0PoezvbtT2VJncnY7TQbOCtubGpWT5B4=; b=c+tR3zYt77g50Dla87tOMttzSA
	Qaqy64S86rMb0l8jlcbfSPfRxRS0EfwiWlM1g0LGe99HAQ5AyooqapEx5KOhwcjw
	A9pXvOB4dLsGesbaqyvFeOrsBEaBqafMZ3uQ2e91kgQhT/5xiq2snH8Ib/xL5g5c
	lJtt0qIshJoI4NxTq+dnPjjzng9EWs8zts1tYrWzX0aF6Yib6iGNlEs5krTVXx0V
	dHzdP0jPQkpLw3nbMSjz7QtCoJ/Kqv4KIJegCS87DW9bDIfWh6skNayRxFXt7TK/
	K1C0A6KdMLGItCw9QcWw53VLZk/HLJNbe0j/FiasHxDN9Np7ikYXyzxsPaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773161159; x=1773247559; bh=TJyi/YwFvAW0PoezvbtT2VJncnY7TQbOCtu
	bGpWT5B4=; b=3AkLmSGna0cKHr91IeKz1TOIR2R/ylmiVFAQRxGIGfGoP/C0+AC
	X5WuSeF59J885RndXLX2Q0PeDTPjy8IHR78cIvafgAtW9Vxtf5OJAGyC+lu1gO+a
	D1YAhqT0L2tELaNPctw8hlCO+tKkCsMECKrQOVDQUdMfm1eZzyleLtmI8JNhMooi
	vJ7AY/bt9B1k4E5zcj7jD9yAApW2AOzjL1+kRij37ROBM8XBZg1vKrfjHAKPIabF
	z0XT3Cgx2dcKwCzZ3pAbB6qHARqmff7jaZHi8VIU4iD65ddeXY3wi8NfeOlSWHom
	oeUquJlcEMsvEiIKIUB888yVODC2LfDx1Qg==
X-ME-Sender: <xms:x0qwaZNZlivH7_4pgzZuIAmtbOCsF9TE7-EU72623rFKv16jOMqi6A>
    <xme:x0qwaS0cL8x4_zvI-WgVxSGUD1aFVkUPRsLdpuK45NslBVD1lgi6SGMv4_szDQkx2
    U8Ml7vtlwkpLJ_ZEyJM-TQcurFNp01YBxamtgVjLV53brlweiy2DQ>
X-ME-Received: <xmr:x0qwaQkA7uUyEMmtvh5-Gw4sMAe9WbPJEB1pDmnvyOJGz6u4xrA_880MEb23-1-azzaFwk3VSr3BMYDkljLnh11dNjVhLIsbXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x0qwaRVESxb5eSZ6MbyjeoMQZyb5qlXo-8zBaYwfO_A19bbKsJ-grQ>
    <xmx:x0qwaeuXqEv0qwdE3ctHE4UcIS3iF---cYvx1h837oKnL-VcXJfBNg>
    <xmx:x0qwacYq5oljCpP9q4vpU9LrHt99-5VL5E6O5eVIP-mDQCjVLN9TSA>
    <xmx:x0qwaVViL_pSIpatJ7HVJdY0axtf_5N3E7cvwimS9aewvQ5FOR2QgQ>
    <xmx:x0qwaYHfPX2ZAF6iwaWvvy3Pc6gqD6xLfWNFzyvkZGLCLGbj1AmH81jq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:45:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
In-Reply-To: <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com> (Phillip Wood's
	message of "Tue, 10 Mar 2026 14:34:01 +0000")
References: <cover.1772837832.git.mroik@delayed.space>
	<cover.1772839973.git.mroik@delayed.space>
	<c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
	<6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
Date: Tue, 10 Mar 2026 09:45:57 -0700
Message-ID: <xmqqikb3ws3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Possible values:
>>    - commitListFormat is set but no string is passed: it will default to
>>      "[%(count)/%(total)] %s"
>
> It is unusual for an empty config value to mean something different from 
> it not being set. The reason for this is that it allows
>
>      git -c config.key some-command
>
> to act as though config.key was not set.

That syntax is the same as setting config.key=true; disabling the
feature triggered by config.key is quite counter-intuitive, isn't
it?

We are by default using "shortlog", but use of this configuration
variable is a sign that the user wants to use a more modern custom
format that is not the traditional "shortlog".  It would be quite
natural to invoke the modern default by setting it to "true" (i.e.,
"I want to enable the new format.commitlistformat feature, but I am
not saying which format, and the "log:[%(count)/%(total)] %s" format
is used).

Perhaps "format.commitlistformat = false" should disable the modern
format and fall back to "shortlog", setting it to true (including
the use of "valueless true" syntax) should enable it and use the
modern default "log:[%c/%t] %s" format, and non-bool text should be
used as a custom specification ("shortlog", or "log:<format>")?

I.e.

	switch (git_parse_maybe_bool_text(value)) {
        case 0: /* false */
		fmt_cover_letter_commit_list = "shortlog";
		break;
	case 1: /* true - use the modern default format */
		fmt_cover_letter_commit_list = "log:[%c/%t] %s";
		break;		
	default:
		fmt_cover_letter_commit_list = value;
		break;
	}

Hmm?


> It would be nice to support a default format on the commandline as well.


>
>>    - if a string is passed: will use it as a format spec. Note that this
>>      is either "shortlog" or a format spec prefixed by "log:"
>>      e.g."log:%s (%an)"
>
> Having the config value behave like --cover-letter-format=<value> is 
> sensible
>
>>    - if commitListFormat is not set: it will default to the shortlog
>>      format.
>
> makes sense
>
> Thanks
>
> Phillip
>
>> Signed-off-by: Mirko Faina <mroik@delayed.space>
>> ---
>>   builtin/log.c           | 21 ++++++++++++++++
>>   t/t4014-format-patch.sh | 53 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 74 insertions(+)
>> 
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 95e5d9755f..5fec0ddaf9 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -886,6 +886,7 @@ struct format_config {
>>   	char *signature;
>>   	char *signature_file;
>>   	enum cover_setting config_cover_letter;
>> +	char *fmt_cover_letter_commit_list;
>>   	char *config_output_directory;
>>   	enum cover_from_description cover_from_description_mode;
>>   	int show_notes;
>> @@ -930,6 +931,7 @@ static void format_config_release(struct format_config *cfg)
>>   	string_list_clear(&cfg->extra_cc, 0);
>>   	strbuf_release(&cfg->sprefix);
>>   	free(cfg->fmt_patch_suffix);
>> +	free(cfg->fmt_cover_letter_commit_list);
>>   }
>>   
>>   static enum cover_from_description parse_cover_from_description(const char *arg)
>> @@ -1052,6 +1054,19 @@ static int git_format_config(const char *var, const char *value,
>>   		cfg->config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>>   		return 0;
>>   	}
>> +	if (!strcmp(var, "format.commitlistformat")) {
>> +		struct strbuf tmp = STRBUF_INIT;
>> +		strbuf_init(&tmp, 0);
>> +		if (value)
>> +			strbuf_addstr(&tmp, value);
>> +		else
>> +			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
>> +
>> +		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
>> +		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
>
>
>
>> +		strbuf_release(&tmp);
>> +		return 0;
>> +	}
>>   	if (!strcmp(var, "format.outputdirectory")) {
>>   		FREE_AND_NULL(cfg->config_output_directory);
>>   		return git_config_string(&cfg->config_output_directory, var, value);
>> @@ -2329,6 +2344,12 @@ int cmd_format_patch(int argc,
>>   		goto done;
>>   	total = list.nr;
>>   
>> +	if (!cover_letter_fmt) {
>> +		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
>> +		if (!cover_letter_fmt)
>> +			cover_letter_fmt = "shortlog";
>> +	}
>> +
>>   	if (cover_letter == -1) {
>>   		if (cfg.config_cover_letter == COVER_AUTO)
>>   			cover_letter = (total > 1);
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 458da80721..4891389a53 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -428,6 +428,59 @@ test_expect_success 'cover letter no format' '
>>   	test_line_count = 1 result
>>   '
>>   
>> +test_expect_success 'cover letter config with count, subject and author' '
>> +	test_when_finished "rm -rf patches result" &&
>> +	test_when_finished "git config unset format.coverletter" &&
>> +	test_when_finished "git config unset format.commitlistformat" &&
>> +	git config set format.coverletter true &&
>> +	git config set format.commitlistformat "log:[%(count)/%(total)] %s (%an)" &&
>> +	git format-patch -o patches HEAD~2 &&
>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .* \(A U Thor\)" patches/0000-cover-letter.patch >result &&
>> +	test_line_count = 2 result
>> +'
>> +
>> +test_expect_success 'cover letter config with count and author' '
>> +	test_when_finished "rm -rf patches result" &&
>> +	test_when_finished "git config unset format.coverletter" &&
>> +	test_when_finished "git config unset format.commitlistformat" &&
>> +	git config set format.coverletter true &&
>> +	git config set format.commitlistformat "log:[%(count)/%(total)] (%an)" &&
>> +	git format-patch -o patches HEAD~2 &&
>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] \(A U Thor\)" patches/0000-cover-letter.patch >result &&
>> +	test_line_count = 2 result
>> +'
>> +
>> +test_expect_success 'cover letter config commitlistformat set but no format' '
>> +	test_when_finished "rm -rf patches result" &&
>> +	test_when_finished "git config unset format.coverletter" &&
>> +	test_when_finished "git config unset format.commitlistformat" &&
>> +	git config set format.coverletter true &&
>> +	printf "\tcommitlistformat" >> .git/config &&
>> +	git format-patch -o patches HEAD~2 &&
>> +	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
>> +	test_line_count = 2 result
>> +'
>> +
>> +test_expect_success 'cover letter config commitlistformat set to shortlog' '
>> +	test_when_finished "rm -rf patches result" &&
>> +	test_when_finished "git config unset format.coverletter" &&
>> +	test_when_finished "git config unset format.commitlistformat" &&
>> +	git config set format.coverletter true &&
>> +	git config set format.commitlistformat shortlog &&
>> +	git format-patch -o patches HEAD~2 &&
>> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
>> +	test_line_count = 1 result
>> +'
>> +
>> +test_expect_success 'cover letter config commitlistformat not set' '
>> +	test_when_finished "rm -rf patches result" &&
>> +	test_when_finished "git config unset format.coverletter" &&
>> +	git config set format.coverletter true &&
>> +	git format-patch -o patches HEAD~2 &&
>> +	grep -E "^A U Thor \([[:digit:]]+\)" patches/0000-cover-letter.patch >result &&
>> +	test_line_count = 1 result
>> +'
>> +
>>   test_expect_success 'reroll count' '
>>   	rm -fr patches &&
>>   	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
