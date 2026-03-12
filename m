Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2390386C04
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334354; cv=none; b=igF/J6nDvAf1OH041Ye5kCN9OAbs6Cxu9JbrIrF1Uv3jGXzM20av9Ubeu4BC90dXVCNIYZcGb0nPNhS6uU6x1gvnX2tZddlJEa+Isn5D7tiN3J/KICaw0T/ebubQdNTKF99/0pIGROZQQSgZFXyhOnnmrBe4Fe0o/abw8X/wBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334354; c=relaxed/simple;
	bh=wsN/P2OJflT9g3oP0c8SMp1GxUpSPmaiyjrpmyXIaqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BTkmZsgeD8fk70q5lDABnEKt16G64L8/D/8/+70eXUsluPnNeen0xgFTJ98MVXsM6k9iRuMpCdgd8tucPy9zv5FuEb4IaJ8vkf6KWjzE7yPYkUmQpKOj+uHT5s0YTFOHELsOPoZMMO+mHOpGtoLA55nsThCrKM1lYzQAGJokx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F0mW1E8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tEHCuPjC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F0mW1E8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tEHCuPjC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A807B7A008E;
	Thu, 12 Mar 2026 12:52:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 12:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773334351; x=1773420751; bh=8UKFPvqeQM
	szunsj30kR/s/vX7RKKRIUJA6knNVkO1o=; b=F0mW1E8Wi46wjDeLvCXXq3/wJW
	Dut/Dw+H49QZA/5oWYs1Cp2HTPTNSgMkPQ7NDewA6TVvnCZqa0cOqsr6Np+KYqm4
	LK9rK4d3XnXkhilK6Roc/65Tjf5sJ7oQih2hnIRBmeb2bJp2iG7bz3z7jiBQ98ua
	/xxiNhAg2+d7O1v2YfM6rpqVtH+N80wZl2zmo8bFGFOgw0k5Jz9FzNejrqjjeoTL
	mWN0jNGpPARWSggbkap44mD0K5gou4bgm3hCv/LBbbX+YdJZrbQ+9q7ND/ITuiUS
	vf1vquEL1JllgdLlTorTABpiQUqFERtA/wwuQoUB/DDl3EdxD6iDOaez8myw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773334351; x=1773420751; bh=8UKFPvqeQMszunsj30kR/s/vX7RKKRIUJA6
	knNVkO1o=; b=tEHCuPjCQAAsOEU1e8QJao4NqLIl9l1LhodE1o+c8LjhElbIWpc
	sOs5+K46VyzlVGMVvfyk3ypW2uRBntcuy0l5Ebysm1t/g0J+HCzIYmyK7bxJLl7J
	lbCX/9wjDeV6QDQLpLMr6SDw2rPX8gU3vAfmjQaGeNFD3gvOivdX1GmHoPTH1jdE
	YAcUD+SVlouHAXm7WS6O9YozHhbdDBwu/qi6/eJUaFfWwi5Id9XlnV9kAoR0uuA1
	4gLNYCPeg9NzZO5359Wd6bk/szwaY1WRYiYr6v3lwfwytIyOn3hyFci8kggaPV3C
	GIQLD7TZHPVwfQyzyTYtSQmiQB72ahcutHw==
X-ME-Sender: <xms:T--yafWYDKnHNfyqAiSWEKRy8vu0S-S5RbwvBAsadRgPOJHv3xY4YA>
    <xme:T--yabR_FruXlhurHnAthxA4Eo766VjmMMw-qy1LyCdSjBS9nk5t47hzUBPYNE07V
    g1EHppynrvhn4FRhCFbSHWPeWrJ2FJ3M3UuW_H698aeCsbNOSK9>
X-ME-Received: <xmr:T--yaVNyA_qW5nqZAwu4PNv7QaR2Sl4LjgeobgkxDUuv_-_dKWvXcJLWkH4lhwXgF-2-IaYa9lrgarhka7gg1C36zaHiRiZKHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T--yaRSvn86Wz_Z37ssk3oYW-W7rBEZ78UQaHe_wabyqUZDX51Lo8w>
    <xmx:T--yabhSL5awh0RY1PFftQJHtCw7LkGdQ3GcU83bRzE54mpv0ujEDg>
    <xmx:T--yaS-nR9cLo9WK2Xu7nkztoTo6lnvXVLXsZ-VdTXO5hrzvmoVzww>
    <xmx:T--yaaHfEvkiHEApPk5dOl5w6ebQPkI4q0gA04AvQ6MGJ5FEB6DH0Q>
    <xmx:T--yacHfAhxnSou_OWA-2FTnDqEYN3n9XwaJ6gGhlHraDLTGy-F-Q5Gv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:52:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
In-Reply-To: <225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 12 Mar 2026 17:20:09 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
Date: Thu, 12 Mar 2026 09:52:29 -0700
Message-ID: <xmqq5x71gfci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Often when sending patch series there's a need to clarify to the
> reviewer what's the purpose of said series, since it might be difficult
> to understand it from reading the commits messages one by one.

Yes, that is the whole point of having a cover letter.

> "git format-patch" provides the useful "--cover-letter" flag to declare
> if we want it to generate a template for us to use. By default it will
> generate a "git shortlog" of the changes, which developers find less
> useful than they'd like, mainly because the shortlog groups commits by
> author, and gives no obvious chronological order.

Very true.

> To better reference relevant patches in the coverletter this patch
> introduces two new placeholders that can be used in the format spec:

"this patch introduces" -> "introduce" (imperative).

> %(count) and %(total). These are the chronological number of the patch
> in the series and the total amount of patches in the series. Note that
> the width of %(count) will always be the same witdh of %(total).

"total amount" -> "total number"?

"the width of %(count)..." -> "%(count) will zero-padded to the left
to match the number of digits in %(total)".

But the paragraph "To better reference ..." up to this point should
probably be moved a bit low?  The punchline "Give format-patch the
ability" to specify a custom format is the most important thing to
tell readers, and %(count)/%(total) is an implementation detail of
only one possible customized format.

> Give format-patch the ability to specify an alternative format spec
> through the "--cover-letter-format" option. This option either takes
> "shortlog", which is the current format, or a format spec prefixed with
> "log:".
>
> Example:
>     git format-patch --cover-letter \
>         --cover-letter-format="[%(count)/%(total)] %s (%an)" HEAD~3
>
>     [1/3] this is a commit summary (Mirko Faina)
>     [2/3] this is another commit summary (Mirko Faina)
>     ...

The example does not use a format spec 'prefixed with "log:"',
though?

> +--cover-letter-format=<format-spec>::
> +	Specify the format in which to generate the commit list of the patch
> +	series. This option is available if the user wants to use an
> +	alternative to the default `shortlog` format. The accepted values for

The second sentence reads funny.  The option is available whether
the user wants to use it or not.  I'd suggest dropping the sentence,
without which the paragraph reads just fine.

> +	format-spec are "shortlog" or a format string.
> +	e.g. `%s (%an)`

OK, so we are not requiring "log:"?  This robs extensibility from
future developers to introduce something other than "shortlog", no?
If the version of Git in 'next' supports "longlog" and user gives
"--cover-letter-format=longlog" to their version that does not yet
support it, it would be mistaken by the version of the code here as
a "log:longlog" without any placeholder that shows a fixed string
"longlog" for each commit in the series?  We'd rather want such an
input to cause failure, no?

> +	If defined, defaults to the `format.commitListFormat` configuration
> +	variable.

s/If defined, d\(efaults.*variable\)\./D\1, if defined./ would avoid
"if I define --cover-letter-format, why does it default to a
configuration?  do you mean 'if not given'?"

So, "If defined," -> "If not given" would be another possible
improvement.  I think I like it better, actually.

> +	This option is relevant only if a cover letter is generated.
> +

Hmph, an alternative that may make it easier to use is to make the
command line option _imply_ "--cover-letter", so that the user does
not have to give two similar looking command line options.

    git format-patch --cover-letter --cover-letter-format=...

Of course, the presence of the configuration variable should not
imply generation of a cover letter. I.e.

    git -c format.commitListInCoverLetterFormat=shortlog \
	    format-patch -1 HEAD

should not imply --cover-letter.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 21d6d0cd9e..631669c159 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -380,6 +380,64 @@ test_expect_success 'filename limit applies only to basename' '
>  	done
>  '
>  
> +test_expect_success 'cover letter with subject, author and count' '
> +	rm -rf patches &&
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter \
> +	--cover-letter-format="[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
> +	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
> +'
> +
> +cat > expected <<EOF
> +
> +
> +
> +
> +
> +
> +
> +
> +
> +
> +A U Thor (1):
> +  This is a subject
> +
> +
> +
> +
> +
> +
> +
> +
> +EOF

Many issues.

In modern tests (written within the past 10 years), we try not to
execute things outside text_expect_foo blocks.  The golden output
to compare with is customary called 'expect' (not 'expected').  A
redirection operator ">", "<<", etc. has a single SP before but no
SP after it, when there is no parameter interpolation happens in a
HERE document, quote the "EOF" marker to show the intention of the
author of the test that no parameter interpolation is expected.

i.e.,

    cat >expect <<\-EOF
	...
    EOF

and do so inside a set-up test_expect_success block.

Why do we have so many blank lines?  Are the number of blank lines
significant?  Such a hidden and hard to count dependency would hurt
maintainability of this test script.

> +test_expect_success 'cover letter shortlog' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches expected test_file result" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter --cover-letter-format=shortlog \
> +	-o patches HEAD~1 &&
> +	sed -n -e "/^A U Thor (1):$\|^  This is a subject$/!s/.*//; /.*/p" patches/0000-cover-letter.patch >result &&
> +	test_cmp expected result
> +'
> +
> +test_expect_success 'cover letter no format' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --no-cover-letter-format --cover-letter -o patches HEAD~1 &&
> +	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 1 result
> +'
> +
>  test_expect_success 'reroll count' '
>  	rm -fr patches &&
>  	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 964e1f1569..4f760a7468 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2774,6 +2774,7 @@ test_expect_success PERL 'send-email' '
>  	test_completion "git send-email --cov" <<-\EOF &&
>  	--cover-from-description=Z
>  	--cover-letter Z
> +	--cover-letter-format=Z
>  	EOF
>  	test_completion "git send-email --val" <<-\EOF &&
>  	--validate Z
