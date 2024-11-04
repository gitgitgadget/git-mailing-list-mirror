Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054881C07E7
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735769; cv=none; b=gumWPshheY21/je3uqPjxBLIihW4+RbV/RMetiQ0FMmb4yx9QlnWOylwRDVs3HJtUs/8bC7vQZKbT/UsDLWTPtDMf6jr0AbginB6NYD76rs610Tn/JmZlLmtpB50NMc3hjoMFGbdlmyH8jJFGAESjYQfqBWbGMn92ZtGktegmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735769; c=relaxed/simple;
	bh=ilRd0bKulJWerfN9VPJgwsd8WzPYaLHimOJl7AvwjPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXhg93qfsYNn6fuxT1/ey1CPvz/KbQUnL8Tufo8V3YHjdEfXUeTH2/rAifYr7lI+930/heLj8dxT4VG7dbCI/6wlZWmkY+tbtXIPP7bI9lpEiEhtxzhGWpvLHlCs6d0eYCaDQ69A3Zf2oSwdf69JY0TtwJMbj9Czo53QJd+hRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfZ7GGo+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfZ7GGo+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2e3e4f65dso41992617b3.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730735767; x=1731340567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xse7pt9Eo7vxQYVzRQrBBD5+7b+KekU0W+MjEWVsirc=;
        b=MfZ7GGo+erJwBT9CKvSi6B9dAOfqQ9X1MfL9aE3SIRWWfqaEqSrjruOJPEE3ZNwlUE
         76zviCxNsziL+1SP17/og6PClpyzq41j0eVnfNEE+g4xqcrr42UT/WSxHDM9b2wfe642
         ZWJtoA9+399iVowJ4P94UxH9KhR0oEsdDs5Reo6+mU/eruH4a6Oa5xD5jQOx+ssS8T9M
         pQJwK+oic82cR5BxYz5g8bolCJYETGxYHagjHcZ4Y6vuaeNWCLn6OsX0ACvWKagmIT8k
         vGmJCJqEbdlOrT+3vmLbM0uHOW16prJlD1Er8sBR13JhgoF7OA6bHs0in0vk8tVTcuCs
         1mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735767; x=1731340567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xse7pt9Eo7vxQYVzRQrBBD5+7b+KekU0W+MjEWVsirc=;
        b=Gk9rqCNT0N0//mdSwzYJhmFPyLR6je5awjyHW0NkYFR4pCq6pxZZ3Qqprz1C6EwWRu
         z9NOxQUlNp/F7Gg6RuA7zSFnOpB/ZNVBEsmfXDC1Njes2Pd9vUtidjgTbUd9hHc8kXmj
         WWkamYJ5A8rjlGdy4c88Kht7h0OggvJAvRRB7RN9zqMXHyZxlLFsbdSGxA2YcQsCPNlc
         h4ohoLnrAKIpxffxpQsfJuiUgnFYm/4Tz/LLTdzd3Kiz8Aa/2fOmy6zPFUr7jkBxqoa2
         UcmUYT0iVWDooEzsOUUhjtZ5dfQrJaDqsGU/AIDs0Olrhu/7vFrAamINFmvllpG/k+UG
         3z5A==
X-Gm-Message-State: AOJu0Ywt1GoXBS30Rxl8pebAQM16NHd7iQf3Zn7RdKgPn3HggclNoVu2
	gEaNXIxIxSyrZJEiCKoxINipoTD8+rys4ANGdx9guuUjoVNukO8N
X-Google-Smtp-Source: AGHT+IEaeDM6wIvPvhhKGuzDFhesAQA+Ze2q1Ly99b8ZLNTUDPelvyxOe+3sXMeQjrn1hJBnMdMTvg==
X-Received: by 2002:a05:690c:3584:b0:6ea:84e9:15fb with SMTP id 00721157ae682-6ea84e91ae7mr60357347b3.24.1730735766916;
        Mon, 04 Nov 2024 07:56:06 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2db7:73fd:372e:bf53? ([2600:1700:60ba:9810:2db7:73fd:372e:bf53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55acaadesm18234467b3.19.2024.11.04.07.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:56:06 -0800 (PST)
Message-ID: <58e2e41e-ff67-4d4b-98f0-48be5eb3df27@gmail.com>
Date: Mon, 4 Nov 2024 10:56:05 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
To: Jonathan Tan <jonathantanmy@google.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com,
 newren@gmail.com, christian.couder@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20241101222334.1724050-1-jonathantanmy@google.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241101222334.1724050-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 PM, Jonathan Tan wrote:
> I haven't looked thoroughly at the rest of the patches yet, but had a
> comment about this test. Rearranging:
> 
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +test_expect_success 'all' '
>> +	test-tool path-walk -- --all >out &&
>> +
>> +	cat >expect <<-EOF &&
>> +	TREE::$(git rev-parse topic^{tree})
>> +	TREE::$(git rev-parse base^{tree})
>> +	TREE::$(git rev-parse base~1^{tree})
>> +	TREE::$(git rev-parse base~2^{tree})
>> +	TREE:left/:$(git rev-parse base:left)
>> +	TREE:left/:$(git rev-parse base~2:left)
>> +	TREE:right/:$(git rev-parse topic:right)
>> +	TREE:right/:$(git rev-parse base~1:right)
>> +	TREE:right/:$(git rev-parse base~2:right)
>> +	trees:9
> 
> [snip rest of "expect"]
> 
> The way you're testing this, wouldn't the tests pass even if the OIDs
> aren't emitted in path order? (E.g. if topic:right and base~1:right
> were somehow grouped into two different groups, even though they have
> the same path.)

You are correct that if the path-walk API emitted multiple batches
with the same path name, then we would not detect that via the current
testing strategy.

The main reason to use the sort is to avoid adding a restriction on
the order in which objects appear within the batch.

Your recommendation to group a batch into a single line does not
strike me as a suitable approach, because long lines become hard to
read and difficult to parse diffs. (Also, the order within the batch
becomes baked in as a requirement.)

The biggest question I'd like to ask is this: do you see a risk of
a path being repeated? There are cases where it will happen, such as
indexed objects that are not reachable anywhere else.

The way I would consider modifying these tests to reflect the batching
would be to associate each batch with a number, causing the order of
the paths to become hard-coded in the test. Something like

   0:COMMIT::$(git rev-parse ...)
   0:COMMIT::$(git rev-parse ...)
   1:TREE::$(git rev-parse ...)
   1:TREE::$(git rev-parse ...)
   2:TREE:right/:$(git rev-parse ...)
   3:BLOB:right/a:$(...)
   4:TREE:left/:$(git rev-parse ...)
   5:BLOB:left/b:$(...)

This would imply some amount of order that maybe should become a
requirement of the API.

Thanks,
-Stolee
