Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698B19E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685818; cv=none; b=kp+4G/5uLYjWHTMd6ys/GEV8EcubDN2YGqjhtBDWFHp7Z5CT7QfX3g0KoHFHj9enM98OIWC4+kU4ALFBndszZcVuS0PG0m8jjn7RB/jKx+pJoIfPHjr4EVuqH3SOHbbnZBSFaoDFzwMYBv+OP4KlxVERUstf/N5zZa6BwOFiESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685818; c=relaxed/simple;
	bh=25sxCDYwrOVrXlX/78Zdyjyn7jqAgJTz7maQXqznwLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sOWQourHWmZPDiNCEN28/hgFCp7MJX0VLTYK71Elm7oO8EU00FibBA8AIxxdYxpE8GILHhAKyhcgWOfH5uZFxyjMmImkvTk5Ipu1PaJeC4ML5n/dwk7UcSFAyP8n1nSArLFRqjEQWg62nUnFyESHs2o8NUSCOcBWIznBnhuRuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UIbHriwY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UIbHriwY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 829661D177C;
	Tue,  5 Mar 2024 19:43:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=25sxCDYwrOVr
	XlX/78Zdyjyn7jqAgJTz7maQXqznwLk=; b=UIbHriwYMP945aZMtzEpBhFRC7NM
	ycfAkErYN7t7GoIf5s0KTw+RYTlubIdFlJL4mQs7o8yqQl5Ji3vg2w/1JhFD+jEI
	4V0EImT642HXoyNNekMxWpMPTu5uAFZ4onBbfGsIrsJHT4Iu50TQuV2kb11nIWPl
	ewX4U0CRRoidxbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79E081D177B;
	Tue,  5 Mar 2024 19:43:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE1211D177A;
	Tue,  5 Mar 2024 19:43:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>
Subject: Re: [PATCH 14/22] t/t9*: avoid redundant uses of cat
In-Reply-To: <8b9667e5-0d2f-4624-8f7c-f8400250a21e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 5 Mar 2024 23:52:18 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-15-dev+git@drbeat.li>
	<8b9667e5-0d2f-4624-8f7c-f8400250a21e@gmail.com>
Date: Tue, 05 Mar 2024 16:43:33 -0800
Message-ID: <xmqqwmqgw5oq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 904444B4-DB52-11EE-86AA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>>  	test_when_finished "git update-ref -d refs/heads/L2" &&
>>  	git fast-import <input &&
>>  	git ls-tree L2 g/b/ >tmp &&
>> -	cat tmp | cut -f 2 >actual &&
>> +	cut -f 2 <tmp >actual &&
>>  	test_cmp expect actual &&
>
> Nit: Maybe we can avoid tmp.

Piping "git ls-tree" output to "cut" would hide the exit status of
"git ls-tree" if it fails, which is not a good idea, so I do not
think of a way to avoid tmp so easily.

>
>>  	git fsck $(git rev-parse L2)
>>  '
>> @@ -2012,7 +2012,7 @@ test_expect_success 'Q: verify first notes tree'=
 '
>>  	100644 blob $commit2
>>  	100644 blob $commit3
>>  	EOF
>> -	cat expect.unsorted | sort >expect &&
>> +	sort expect.unsorted >expect &&
>
> Nit: I wonder if we can also avoid the cat that just precedes this hunk=
.

The whole thing reads like this:

test_expect_success 'Q: verify first notes tree' '
	cat >expect.unsorted <<-EOF &&
	100644 blob $commit1
	100644 blob $commit2
	100644 blob $commit3
	EOF
	cat expect.unsorted | sort >expect &&
	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >act=
ual &&
	test_cmp expect actual
'

As we are not in the business of debugging system-provided "sort",
I agree that

	sort >expect <<-EOF &&
	100644 blob $commit1
	100644 blob $commit2
	100644 blob $commit3
	EOF

without having to use expect.unsorted would probably make sense.
Well spotted.

This is outside the topic, but this test has different clean-up
opportunities that are not related to the "do not run cat a single
file and send its output into a pipe" pattern.  The expected output
we see here implicitly depends on the fact that the notes tree is so
small that it hasn't been reorganized using fan-out levels.  If the
algorithm to decide when to start using fan-out directories changes,
this test can break.  To avoid that, we may need to do something
like

	git ls-tree -r refs/notes/foobar~2 >ls-tree &&
	sed -e "s/ [0-9a-f]*               / /" -e "s|/||g" >actual &&

so that we will get the commit object name without the slashes that
show the fan-out directories.  Also, the current "actual" generation
hides the exit status from "git cat-file".
