Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C22D0C63
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153231; cv=none; b=VL60WVdDGgQwKew+Kqu1zw7YtShbgwGGO4hORKss8fXoNWpKti02t6KtkL58CXunF2TiB1TFjRnusn/sbEKjZg1OH+VOlm58MaDnxKYuJgSCdaHKY6v8FLJWwFT7Or/CxUPmIs+g58LSXDIJcgDSdG1b8DaH/3MWlRA88Ws4JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153231; c=relaxed/simple;
	bh=UpKD7LuKCnw1bh3gbpIZLxf/D5v6kKt7isPPyKTX8x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuH3LUfMlxdBtThMd9pg20sZ9lu0Y9iYkRIgXT1Z6vsx4iTYMKdjRYCdd97bKYlUrZk0O4DUHT0a6q9Ze0gglUAh9v/AcuP7zP4Ya1vq+NkbKNWxtNAHYbnOUZ/jpsN2omIrpmqi33ayiq3xKM9bNy6FvHTtnMVhfxJSDc7Vqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNKWz46g; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNKWz46g"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1467042266b.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153228; x=1773758028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mYKnM0EIIoBjtFuAa+LPOyFPB4Dr0my6M2GF7fWdoGs=;
        b=PNKWz46gvxkND6BadpFv8s+P4oiZhoVn5hrrWB7/1cmGj1suYqAdaxqu5j+hf6vLO2
         ed/sYM5I5z/M+zIG38xHPWC7YngzQZwMGUTepyABsTaE4fDUvkIWih/8X7elxGcMWRQi
         sXY2F8cXsniQ29klnOpmkB2V3zBROcv7dYFAzhamNY4c1dN33l3hIM78l5tFVx6+AEvX
         wKROg2xUdUshGeQ3ExZbkCB7TDv28omYt/TRtmdQ50eTxMNsDoy65LPrLWewQcdfN3EX
         UjyiOXBtUA8J+V7x5zpdEz0qHLLu0sxuTWbz01qzkvDIRqn+dINyLsShX3mNCe0AWRpH
         CCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153228; x=1773758028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYKnM0EIIoBjtFuAa+LPOyFPB4Dr0my6M2GF7fWdoGs=;
        b=jY6nO97YER6pbYU6Px5wO8wABlRa9ajYUq5HXE0b5nnTy6ZyE00n5u27DU1TdNitBn
         CXttXpNuIG9TWvTmEwG3Ph6qa81rupN9x+wfJYMOzPCyVeqAMo+alT0gekVw4OXJ+TND
         Os1vqtkMULGxJTo1sL4VEPtUmEy1s0Ij0jMcbqImwOLQ38jUCnImsUyxJKp1w226BRot
         jhiAGw3aY8oG9Kj83caJRT79Wz6Tclx6pZtjUiROj533/dLdGeYGlN9bU5clBKm7e5RH
         TQAayr+iSlbIFchaGndXmb1eutqrfhgPlJU5GxeyB9dh140hJRHY2xd2h7m7A8RJF1Ej
         SyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoUR622tZ3ONao8mN01TeoV/jTvYfuNg1o2H4F/e2rfrqDnAr5HutU2g1oqJLxl1nn8u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKnHOt8NARxQeWYOrNQEtT8vVqfPn12fQrjbeW9/PlyOv4JGn
	+Gq3CTFNcHhym1o2Y7MCWtjeY8zi1BX/c5crZcVC1NtvXCH8zZaloJMLEykVvA==
X-Gm-Gg: ATEYQzyTCYuFgelg9RuhtLrJDqb/AWqzpU7a+gY4kdCNFay6tuADxcD+R7XdcaiDUa+
	d8DYbGV0JjHNg83prOCc+eHXT9NAomI8yEVI+iY7BMZa10V9NSoEdALakdojiKINgzhexEnt/Wa
	ruAyDG+4j8+CR1PBLd5Mzzizi7zVXbNG2fzvTwXqqyBi/LoFnhdOHkEl3CGYDulyc2QO6PwjJ8U
	J28vxxOw2Odm8/o+EA8YDDwr9O10/1x1bAcAiDgQGL7g5tqU/5ax5iqzN69oaS6oSXNdP1a9DTN
	SIVm1A87p9ln2xj5O+LBwHtFoPZJdBmxQ8FdXMrEdMnh2itzQc0cDsgr6R7t3ErTJGzeCDW3dNi
	SHEnXhRKd2gtZ+reDABzk31FXO5cKkJ+UtnsyJh+8kYZICpmn4MtBb1w1fcsAyssiYKDGvend85
	pr9NpfmGdg960c09yzbmcgMmv43GRJzFYDBDM1GHxRU6Vnq6eYGAmh21u2MvH4U+dtswCGa6R44
	Ddpn7Mq8r9BZkYS
X-Received: by 2002:a17:907:868b:b0:b8a:fa35:989f with SMTP id a640c23a62f3a-b942e0b4bffmr826460266b.38.1773153228123;
        Tue, 10 Mar 2026 07:33:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef48267sm490589466b.3.2026.03.10.07.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:33:47 -0700 (PDT)
Message-ID: <8f49d551-9741-4461-b076-3caba75e6122@gmail.com>
Date: Tue, 10 Mar 2026 14:33:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 3/5] format-patch: add ability to use alt cover format
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772839973.git.mroik@delayed.space>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772839973.git.mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 23:34, Mirko Faina wrote:
> Often when sending patch series there's a need to clarify to the
> reviewer what's the purpose of said series, since it might be difficult
> to understand it from reading the commits messages one by one.
> 
> "git format-patch" provides the useful "--cover-letter" flag to declare
> if we want it to generate a template for us to use. By default it will
> generate a "git shortlog" of the changes, which developers find less
> useful than they'd like, mainly because the shortlog groups commits by
> author, and gives no obvious chronological order.

I think we probably care more about topological order for format-patch. 
In practice that's the same as chronological order by commit date, but 
it does not necessarily match chronological order by author date.

> Give format-patch the ability to specify an alternative format spec
> through the "--cover-letter-format" option. This option either takes
> "shortlog", which is the current format, or a format spec prefixed with
> "log:".

That sounds like a nice improvement over using the shortlog output. 
However it is rather cumbersome to have to type "log:" each time. As 
--cover-letter-format=shortlog is a nonsensical format I don't think we 
need to require the "log:" prefix. --no-cover-letter-format should 
behave like --cover-letter-format=shortlog.

> Example:
>      git format-patch --cover-letter \
>          --cover-letter-format="log:[%(count)/%(total)] %s (%an)" HEAD~3
> 
>      [1/3] this is a commit summary (Mirko Faina)
>      [2/3] this is another commit summary (Mirko Faina)
>      ...
> 
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>   builtin/log.c           | 40 +++++++++++++++++++++++++++++++---
>   t/t4014-format-patch.sh | 48 +++++++++++++++++++++++++++++++++++++++++
>   t/t9902-completion.sh   |  1 +
>   3 files changed, 86 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 0d12272031..95e5d9755f 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1343,13 +1343,36 @@ static void generate_shortlog_cover_letter(struct shortlog *log,
>   	shortlog_output(log);
>   }
>   
> +static void generate_commit_list_cover(FILE *cover_file, const char *format,
> +				       struct commit **list, int n)
> +{
> +	struct strbuf commit_line = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +	struct rev_info rev = REV_INFO_INIT;
> +
> +	strbuf_init(&commit_line, 0);

This is unnecessary as commit_line is initialized in the declaration above.

> +	rev.total = n;
> +	ctx.rev = &rev;
> +	for (int i = n - 1; i >= 0; i--) {
> +		rev.nr = n - i;
 > +		repo_format_commit_message(the_repository, list[i], format,
 > +				&commit_line, &ctx);

This loop is a bit confusing, I wonder if it would be simpler to count up
	for (int i = 1; i <= n; i++) {
		rev.nr = i
		repo_format_commit_message(the_repository, list[n - i], ...);

The shortlog sets some wrapping and indent options, do we want to do 
something similar here?
> @@ -2297,6 +2328,7 @@ int cmd_format_patch(int argc,
>   		/* nothing to do */
>   		goto done;
>   	total = list.nr;
> +

Please don't mix unrelated whitespace changes in with your changes.

>   	if (cover_letter == -1) {
>   		if (cfg.config_cover_letter == COVER_AUTO)
>   			cover_letter = (total > 1);
> @@ -2383,12 +2415,14 @@ int cmd_format_patch(int argc,
>   	}
>   	rev.numbered_files = just_numbers;
>   	rev.patch_suffix = fmt_patch_suffix;
> +

The same here

> +test_expect_success 'cover letter with subject, author and count' '
> +	rm -rf patches &&
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter \
> +	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
> +	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&

using test_grep here would make it easier to debug test failures.

> +	test_line_count = 1 result
> +'
> +
> +test_expected_success 'cover letter with author and count' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter \
> +	--cover-letter-format="log:[%(count)/%(total)] %an" -o patches HEAD~1 &&
> +	grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch >result &&

I'm not clear what new coverage this test adds

> +	test_line_count = 1 result
> +'
> +
> +test_expect_success 'cover letter shortlog' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter --cover-letter-format=shortlog \
> +	-o patches HEAD~1 &&
> +	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&

This just checks that the author name appears in the coverletter, not 
that the patches are formatted with shortlog.

> +	test_line_count = 1 result
> +'
> +
> +test_expect_success 'cover letter no format' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter -o patches HEAD~1 &&
> +	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&

Don't we already have test coverage for the case where 
--cover-letter-format isn't given? Testing that --no-cover-letter-format 
works as expected would be useful.

I think this is a useful improvement to the cover letter generated by 
"git format-patch"

Thanks

Phillip

> +	test_line_count = 1 result
> +'
> +
>   test_expect_success 'reroll count' '
>   	rm -fr patches &&
>   	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 964e1f1569..4f760a7468 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2774,6 +2774,7 @@ test_expect_success PERL 'send-email' '
>   	test_completion "git send-email --cov" <<-\EOF &&
>   	--cover-from-description=Z
>   	--cover-letter Z
> +	--cover-letter-format=Z
>   	EOF
>   	test_completion "git send-email --val" <<-\EOF &&
>   	--validate Z

