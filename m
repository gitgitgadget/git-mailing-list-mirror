Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B13BBA07
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294793; cv=none; b=jrR1dk4b1G7XrUfSMLLl8954gh3KsistBPE29XpNHQTySNEdu7ddWoK4vG0oN67rtedVveXLBXLg7iv/K1cuAUJKsdaP79W1pqPRgiYBu1PAI+uft6veGHVfr/rkrC6oGYYdhX3C5iq7nfol8NJ8Y/zY7jM8hpdgGld8CmQYtBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294793; c=relaxed/simple;
	bh=AlGcYiCMCkIN1FbuMEOLe1ZAz++u3nEcCu7QbKHseMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh2xzPynYnZJ81JQwMAER0L86S2nmQGJHp3MloLGPmSFR4GEC9UkjkvPUwQ1MmDEjEFzdxBJjqJUBk5WtQoaOFbE5l3zoOEj2rcGPy10oX2C5INGeNghPb/dhAt4dgOC0XGXW0pC3ohCnCRo+e0qkjRG/dmeJXOX38OwCgu6/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEotlG9A; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEotlG9A"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so1287583685a.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294791; x=1777899591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/K9nHKg2jccJAUDvZZ7UqX6e1C6NpMXkPBfd2A1Be4=;
        b=MEotlG9Aw1EF2Dep9xBMTUmx89pmKHu7y4mEGEmepnwvLrowyZcn1Ihgjp+OSxMjsj
         79ggEYdXbal0Q97Bcr7Oi/yWi5vdoEOf5guinH9yUxe77DhobpmCkRp5EnZNzGpOnXgn
         DtndCvJvIQaufsJhUe6lfoLp9c8bzZCkwxwbXKz/4PclVAssiA83XHEKGZ9X0IZrLHIJ
         mQEBbEq4+P1mUfoKWOBv30fPYegIr82vruege+AVvhi2ZT+6ypRA7nZTJJ6BKh9g1Xi5
         AygnjcrIdBpml25fRm8dyb8HFR+fAY8YgyyHzBl6Yr49dnmZ9VQBKx3rk2BfeHsM0uZD
         Ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294791; x=1777899591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/K9nHKg2jccJAUDvZZ7UqX6e1C6NpMXkPBfd2A1Be4=;
        b=UIMbZ6LLEo0eK6YBkW6EW2r/BXLaLEgx6DACnqWfv1N+kfEHbmosiagdtp95mnHZ04
         fmklsXhaUU5X2wUDHP3hYyPQFtaL/K2xCDpSqXWIwe6P6ZyFlVt8KOOL7ZN9iiif1IBl
         leO4fGQKboq52zK+SloteGKtoEysJIE4WusRQrxylHa3Nerw5lmIt40EogAre9fvFAbB
         C1kYSLLKrrD6I5tVDnf0LT8XzyM+dUncf+uBOz4uqeMV9SDyQerN8mEoy7jSTEDrBKvI
         UgfS2o173QqsCdQ41w/4Yt2Vio0jyJT+Fsqa7A+Y0+w5tcFM/zRQuu0WR8Dzu6kmzpK9
         ZB5A==
X-Forwarded-Encrypted: i=1; AFNElJ9QAh7lyw7nQmSWjyuOMcKN+wzKcvjTuLEWfHnZe/YkCRN1jV+Q7CjTF/rarzht+rQvjPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVv30Uz0jis9AJjEvsIQwmLCD1B0iVASUDQbb2m7pcwwKOSfE
	mfB1P9OCf4Qu7M8ERfV/Ks3WjCsXFhj+Wdham0qek+6N2WrlDpHhuE6K
X-Gm-Gg: AeBDiesK2f9NwWGgTlZNim9G9ES6hPaQOTTz/TllNdRg/UoYjm7CBUCb1n/Fsnhe1TX
	slgtMi8WwBeWQWFbzTveF1s3IaB2mFaQSjRGWrlAIjezRThF7n5Bez7lOdWEaZHBnhlaqx1oZIP
	Yms4ka4ieLuD4Rs/27v2RKbnsuWvw5reoZnaeTrgcedD5hxBIojsM76aTMftcNRv9IJAX2injFm
	wImQsTS8eKgvEX6PZeJg1p2J0eG4+UEIYNX8EbcQE4iRLO5BunlQQkXIUm9cylR0C8E8ATOCB1v
	GTHQ8+FFt3Qp3bI3zt5Cfv4HP1C9eDPyrG9UQBgt9IeXC0FGTPB8BuTMiiTyX9NTTsWTiE6s4iF
	vfXn2TvArgiE5dqKc5X2Is5ACKR5nMBLJzbIozVV8OYVU8dlvEj4LVhXS8yFAGni2DSxxFD+3JU
	RB40JXz2HX+Vh5qwRYZdXr1/njbduzuBMQTIzLCcL7Vff3Far6SyTLGhHR+G//0zl7NUkE639Iz
	TdRycw3
X-Received: by 2002:a05:620a:468b:b0:8f2:31f3:975a with SMTP id af79cd13be357-8f231f3b0e9mr1828075785a.18.1777294790756;
        Mon, 27 Apr 2026 05:59:50 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb428ca90bsm2379234885a.4.2026.04.27.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 05:59:49 -0700 (PDT)
Message-ID: <31763514-2602-4d8e-ac25-70590f090947@gmail.com>
Date: Mon, 27 Apr 2026 08:59:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] grep: prefetch necessary blobs
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <8fbfe69bc4d0c6166967986f24861ffa393ed7cf.1776472347.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <8fbfe69bc4d0c6166967986f24861ffa393ed7cf.1776472347.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/2026 8:32 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In partial clones, `git grep` fetches necessary blobs on-demand one
> at a time, which can be very slow.  In partial clones, add an extra
> preliminary walk over the tree similar to grep_tree() which collects
> the blobs of interest, and then prefetches them.

A log of the code is about walking trees to find blobs matching
the input pathspec, with this being the core method:

> +static void collect_blob_oids_for_tree(struct repository *repo,
> +				       const struct pathspec *pathspec,
> +				       struct tree_desc *tree,
> +				       struct strbuf *base,
> +				       int tn_len,
> +				       struct oidset *blob_oids)

And in your test, you set up a repo to have three blobs with
matches in two of the files:

> +test_expect_success 'grep of revision in partial clone does bulk prefetch' '
> +	test_when_finished "rm -rf grep-partial-src grep-partial" &&
> +
> +	git init grep-partial-src &&
> +	(
> +		cd grep-partial-src &&
> +		git config uploadpack.allowfilter 1 &&
> +		git config uploadpack.allowanysha1inwant 1 &&
> +		echo "needle in haystack" >searchme &&
> +		echo "no match here" >other &&
> +		mkdir subdir &&
> +		echo "needle again" >subdir/deep &&
> +		git add . &&
> +		git commit -m "initial"
> +	) &&

But then the command downloads all of the blobs, not using a
pathspec:

> +	# grep HEAD should batch-prefetch all blobs in one request.
> +	GIT_TRACE2_EVENT="$(pwd)/grep-trace" \
> +		git -C grep-partial grep -c "needle" HEAD >result &&
> +
> +	# Should find matches in two files.
> +	test_line_count = 2 result &&
> +
> +	# Should have prefetched all 3 objects at once
> +	test_trace2_data promisor fetch_count 3 <grep-trace
> +'
I think your code is correct, but I'd like to see a test
here that demonstrates a pathspec filter on the 'grep'
command to help filter out a blob that has a matching string.

Perhaps something like:

* matches.txt (has needle)
* nomatch.txt (does not have needle)
* matches.md (has needle)

and then 'git grep -c "needle" HEAD -- *.txt' would
download two blobs and find one match. A second run without
the pathspec would download one blob and find two matches.

Does that make sense as a test?

Thanks,
-Stolee

