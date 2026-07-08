Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFD175A7E
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475285; cv=none; b=KfuhLzgIxJ+oxHrucH4nXGiu+lJ7P8zvqmvKuLmmzU/5Y8znoMTBg0LRb9pVbL5LuxKGFRp5LgRat0oUGpxRUBNU0KIbgoTKlS8WCu6MpdtLbjcn9EA+poCVGc3nGR9yXTJpjsVWlThtzurgaVHLHMlZbXw/chBZJ3MMFR20X+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475285; c=relaxed/simple;
	bh=PgK+ku1gI3RMhclCW7Esm2748/YR12P3k56BsG4evM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSm5Y9zj+lsweEFYssDvGp9A2ZlWwcuXWpvqrMRH4ThSOghXDGC8MnZ71+A8St/FR0paXIPrXDMXxR7yKzcDwampyXo6VfI+2gOC5h4VAMRAh2azckTPQiaOxwTW4cL/cSN3X/0B148AocpgHjlOHoFSnKI6AndhSGlHQzbD/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rk8vXSFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUas04ji; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rk8vXSFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUas04ji"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8364A140008F;
	Tue,  7 Jul 2026 21:48:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 21:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783475283; x=1783561683; bh=Vo6EUtzZ0i
	YTUGIg0R67YMQKlrHnJgBVkD+p1iCgfSE=; b=rk8vXSFiWiCdGM619UivvPxsqD
	9L3kEUnc/q5Sr+j0eqldtH2E1F/eI/TdWoUcgCZQFlwxq8kXaFqRObrT2UaWF53T
	H/rsg3xOyY/HiE99Khgf2Dum7RkJUpYNz3M9Z3sp/tCdtIkWsk7JT4b0mUoNP+0F
	i9XYI0haSRQRBreyTSjL2QrwGhcKF4w8UqPYq2NvTXBz43QIbCFO2gInhKc11lO1
	DIdZ0GfbVaZWyTHeZzVRpl0zfIVFUEK084DYGbDZHqDi9tBKqdE9dQsvxwJIUF6h
	Tk9fOOJwWfxt2/ctsXMqrL5vrBADnuGjPfYFjXJGrMbxMcbh4b8Gt1KY0fOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783475283; x=1783561683; bh=Vo6EUtzZ0iYTUGIg0R67YMQKlrHnJgBVkD+
	p1iCgfSE=; b=AUas04jiCZYA7nRyXn0NEawO7hZ2FEPg4P6G6IVhDn0ZHIzLpUm
	y2WgYFMIZl5aJeGZ/k5f6nB+Tf1SE3qskN3ocki1ZRRMptu85tABYse8jKdOMJWK
	aAJQecX2lm7EMyllWvWr+B/nn17xAyFLvMA0LZlH5BhlkoNHA2qAmCJsIbXZfECs
	6mdQNqbvg3UrsSCDQd80+Pha1OodJY6spw5lxnyZ6w2C1IZv7OWSLo94rCvtyRCI
	rc6wUO56+FqBqtZBaOrOPoe1TobCykNrieWaJN/PkC0djpekwCNOLXlyYjXoWbym
	+/DR3RIm1anJ2THtqqSXHXo1d6o5HCmfo4Q==
X-ME-Sender: <xms:U6xNam7WoFb_nBjoUu2WA36fugVbXLZzs1qvkf-xqry8NWzuJBw7BQ>
    <xme:U6xNanUYXCYfSswiUTy9Oy2T9fWQWXo8gG9Jx8wm4z0UXr86NG5MU0nEghixwTqYV
    DYpNhJ3N1YOXIunNduaEnF9UHEXPQ_cFa7AuuJ-cpWaS6EgvYM2Iw>
X-ME-Received: <xmr:U6xNai2QiUkso1OIIxX7mzb047yHc3DJ5-VzbSxoNF_NpRBvqtppb0ipuURxX2gcAZepYIyxLxrvBnrcDCDzzPTYCNxH3DZlUWIBNug>
X-ME-Proxy-Cause: dmFkZTGF/AGJ4iW38ujjFBV0Vtq9hNhcYGoT+tT5oJwXq1FvtMRG8LLFWRzGWsbeVn4yoD
    BCRPNGeUFI4wUv/CZ4fsIXd6KSPnZLCOgbHGZQE1Fsjk0z93T64lJgiljmzcwaqZ05MYVv
    SfEC14WVJDko0Gv9N11S7Tjz4JRU1OoQTelBU7QyecoijwuuKiwBiJMdIsb/IBucuEN1fH
    zPJbCkIMVpGU43XQ+fNa/goWRJaTG96JUOjOI4qffldgFAZG2jatx+ofStRFZUdcqHY7iU
    J65O1CbbTzAjb+ZbgLSqRrw3grPnAQGbSWoUYKO/76qeoO6FrOW4VDGzU9fGdLniA4XRGx
    c67RBI0TFnZ1NhHHuxt0TRqqWA5KJ2BRqYIL8TRmFld5ewcuX+UJ/4mdX7FCKK3nAIzNlG
    4Rf4KVVF4jPGA2F4nKMFyNtZe8qeJr3TGV+qZ9hxzk9Lj+R0v4+NPwwD43IkO1hpXrUZnM
    F0GtlE/7AVWRq2948ekmndHvUzcjFeUGc7XQJM3nz0fCO5EWez8xxmy7de96TIfgvjKhgT
    8yUtvOLUbBYamlIjnLddzuZT7a7TAuo1pWhmAOKw3bQzbbrfIZr+zwgHsEiI9BDscquQOI
    23UHWSnaWhEAr8r69hOSzYFMEXahHrAXoHK8CpABhNSI4CnRrYYAaPHhlF/w
X-ME-Proxy: <xmx:U6xNas1UYb_A42NxGBugKAEeidM1xrOqyKi82W0mC30_B5gCPVOjcg>
    <xmx:U6xNat_E_kts6vFS5KBHe0PL-IgiqhRQPo5Se9LyT3mBg9VlVdgkWA>
    <xmx:U6xNah2ufypaXTXulyh0gPUi2kn3rSm-h6GyRwVUX1UqCVY0HvKFgA>
    <xmx:U6xNai86WuWt5XXRJvR8UHgyuftQxppeDbtizloraRjuhYO6zMIqHg>
    <xmx:U6xNavUG3M-cdqa464HkFrJOufCzOtfL7TMMVPBz6ee-M3VC7CuxBxOY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 21:48:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t1410-reflog.sh: avoid suppressing git's exit code
 in pipelines
In-Reply-To: <20260707135530.17389-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Tue, 7 Jul 2026 19:25:30 +0530")
References: <xmqqechf8ryu.fsf@gitster.g>
	<20260707135530.17389-1-gatlavishweshwarreddy26@gmail.com>
Date: Tue, 07 Jul 2026 18:48:01 -0700
Message-ID: <xmqqh5maxne6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> Piping git commands directly to wc -l suppresses the exit code of
> git, hiding potential failures from the test suite. Capture the
> output to a temporary file first, then count the lines separately
> to preserve the exit code. Where the expected count is known ahead
> of time, use test_stdout_line_count instead.
>
> Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
> ---
>  t/t1410-reflog.sh | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

The above descripotion looks reasonble.

By the way, Documentation/SubmittingPatches has this:

    Before sending another version, make sure you have answered
    meaningful review comments in the existing discussion.  Also
    give reviewers enough time to comment before sending another
    version.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index ce71f9a30a..8e018d172b 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -244,26 +244,30 @@ test_expect_success 'delete' '
>  	test_tick &&
>  	git commit -m tiger C &&
>  
> -	HEAD_entry_count=$(git reflog | wc -l) &&
> -	main_entry_count=$(git reflog show main | wc -l) &&
> -
> -	test $HEAD_entry_count = 5 &&
> -	test $main_entry_count = 5 &&
> -
> +	test_stdout_line_count = 5 git reflog &&
> +	git reflog >reflog_output &&
> +	HEAD_entry_count=$(wc -l <reflog_output) &&
> +	test_stdout_line_count = 5 git reflog show main &&
> +	git reflog show main >reflog_main_output &&
> +	main_entry_count=$(wc -l <reflog_main_output) &&
>  
>  	git reflog delete main@{1} &&
>  	git reflog show main > output &&
>  	test_line_count = $(($main_entry_count - 1)) output &&
> -	test $HEAD_entry_count = $(git reflog | wc -l) &&
> +	git reflog >reflog_output &&
> +	test $HEAD_entry_count = $(wc -l <reflog_output) &&
>  	! grep ox < output &&

Now, you no longer have new consecutive blank lines in the above,
but the above shares the same "what did the author meant to convey
with this blank line?" puzzlement.

The updated code somehow wanders around in many directions like a
drunken man.  Let's comment on each line.

> +	test_stdout_line_count = 5 git reflog &&

This is "Does the reflog for HEAD have exactly 5 entries?" test.

> +	git reflog >reflog_output &&
> +	HEAD_entry_count=$(wc -l <reflog_output) &&

As we already saw that HEAD_entry_count variable is exactly equal to
5, it is puzzling why we want to perform this computation again and
assign the result to the variable.

> +	test_stdout_line_count = 5 git reflog show main &&

And then we check "Does the reflog for 'main' have exactly 5
entries?"

> +	git reflog show main >reflog_main_output &&
> +	main_entry_count=$(wc -l <reflog_main_output) &&

And recompute what we already know and asssign to main_entry_count
variable, which shares the same puzzlement.

>  
>  	git reflog delete main@{1} &&
>  	git reflog show main > output &&
>  	test_line_count = $(($main_entry_count - 1)) output &&

Now, after a blank line, it goes on to test a completely different
thing, which is "after deleting an entry in main's reflog, can we
count how many there is, and does it match what we expect, which is
the previous count minus 1"?  Why should we even need to do so, when

	git reflog delete main@{1} &&
	test_stdout_line_count = 4 git reflog show main &&

would do just fine?

> -	test $HEAD_entry_count = $(git reflog | wc -l) &&
> +	git reflog >reflog_output &&
> +	test $HEAD_entry_count = $(wc -l <reflog_output) &&

And then it comes back to test what we already know, i.e. "does the
reflog for HEAD have 5 entries?".  Which we tested earlier already.

Are we interested in checking that "reflog delete main@{1}" does
not affect the reflog for HEAD?  If so, doing

	test_stdout_line_count = 5 git reflog &&

again here would be simpler, no?  That way, there is no need to
recompute and assign to the {HEAD,main}_entry_count variables in the
earlier part of the tests.

I guess the same comment applies to the remainder of this test,
where it is checked that a removal from HEAD reflog does not affect
the reflog of main.



>  	main_entry_count=$(wc -l < output) &&
>  
>  	git reflog delete HEAD@{1} &&
> -	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
> -	test $main_entry_count = $(git reflog show main | wc -l) &&
> +	git reflog >reflog_output &&
> +	test $(($HEAD_entry_count -1)) = $(wc -l <reflog_output) &&
> +	git reflog show main >reflog_main_output &&
> +	test $main_entry_count = $(wc -l <reflog_main_output) &&
>  
> -	HEAD_entry_count=$(git reflog | wc -l) &&
> +	git reflog >reflog_output &&
> +	HEAD_entry_count=$(wc -l <reflog_output) &&
>  
>  	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
>  	git reflog show main > output &&
> @@ -319,13 +323,12 @@ test_expect_success 'git reflog expire unknown reference' '
>  	test_must_fail git reflog expire does-not-exist 2>stderr &&
>  	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
>  '
> -
>  test_expect_success 'checkout should not delete log for packed ref' '
> -	test $(git reflog main | wc -l) = 4 &&
> +	test_stdout_line_count = 4 git reflog main &&
>  	git branch foo &&
>  	git pack-refs --all &&
>  	git checkout foo &&
> -	test $(git reflog main | wc -l) = 4
> +	test_stdout_line_count = 4 git reflog main
>  '
>  
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
