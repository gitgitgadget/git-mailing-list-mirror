Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57041770
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159473; cv=none; b=lw4yjMkBgYRaXDAQmFjCnCREri84D5TKvvrgOqK6Mu7QMNtOP6Vh6+/HbndRE8pp9UrrevoMT2HwRCOeoCXWZH7LKDHkmkfvgrJM1e72/fEoUCNErU6ahX+hCRMpCqyKY2sIY0TRqlrNzBJmzq41zte0AsOj1Gkz8Jri6v0EgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159473; c=relaxed/simple;
	bh=nB7Nvj73k1yUDDiJR6OMAvJEP+Gu6xBZ+X5DdQJQw4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEH94clsuNTixwtD18F60ONoXAgBM1XpwEE2B3BvRlO+tPsySwRvlPr8nFhw9yRXgjxnBwihw7I4MYSYge0KiYE3S1Y4TgGUpQEyP+5G2elQclxP0FiMmD3J9QgStd+5qJZs73CM4eRAnQzT5GmFoSmDnHfv4QJmA++ACQKKNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMrqVGRU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMrqVGRU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so41945735e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159470; x=1707764270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CEb5pp7W+LvPxTHpbv9Kjk92lVUiQg4K+UsTh6vkcvQ=;
        b=eMrqVGRUy5bLms6TMIaIR2LtPivhvbfTzkOlp3Ajyb4Uuk6BUj/ltfk02L+K/Yl0bJ
         tjS7F6t+25LMsuzauJnnUaJuMizrgGSDfJKrfcLFb1T4WmVOlV6yjNbgOnKfPGkx877L
         fbCjpulIBu4ne6LH7LenGJhfPUBh8NDDx6FDacQugNj4hw3XdKEwlE5tkRQtL5ta1KnN
         iZiw4QsOfGJcgTm0MS+7oeQcewhpvIWvvals+ZbBZdCWqp4ewTbMXL5zqnj09zqTYYS1
         KHWdkGWdk8dKhUHyZV7XKv0WSWnqFx6mXW+9ibuhrNy5Tn8QBEzcoG87zX8ydBZrkEPB
         5QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159470; x=1707764270;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEb5pp7W+LvPxTHpbv9Kjk92lVUiQg4K+UsTh6vkcvQ=;
        b=On5QoCWMn0a4Fsr38kRb/TAxhSfqgIBZbxFsGYhyDN6KMT7HmTfk66/lsx44PUdDKS
         skEqHUEMA7NJoBUrqAMzsxjnIiGx7KV8SPh6AeXchlXLg1wgI+i3/5htV2fF+TfDlMBO
         qK47vI1gc1TDQNIyag6bgiwNrYeBLYT5E4PnUVhQvkQn51hswyu24g97qZqNQqZmzfF6
         G/dWarpjF9BvhJmvnklX69wybHm59rcWUkl7iOzsa1AHgpq2VCaWiI5MZcJ8aP33F7vZ
         3RWR0q+8KexmDnOWjvlMMdhu9zpt4rjQnov1OyALA6ZguTowMXyMPFuDJXmGi9TLMHRO
         q2Bg==
X-Gm-Message-State: AOJu0YxIk9zEGjGTZ7+jZF4Kyzhy79ELovrp46bOgNfTvHJ8A2GqdMDk
	uUqKFOo38vsYpbPdbagtouh0QK8c6zIN/eekOnGXph/MniccjjwQ
X-Google-Smtp-Source: AGHT+IFTd9b7ci8gakEWOHIQRYBgNvSDicW2yH1AyfvxvvDcec+aCpYMAcxGc22KCGp5SUiB2cMAmQ==
X-Received: by 2002:a05:600c:3146:b0:40d:484e:935 with SMTP id h6-20020a05600c314600b0040d484e0935mr468196wmo.12.1707159470170;
        Mon, 05 Feb 2024 10:57:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXVOXaGX5yLYEkxR03lbYpy3OBObYdXM4CA0Qw0scPTphL6edLjGI4e5MgW/MaQmz3TtYxhbNQzHDeEMh7YcJKNWDgs
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id i11-20020a05600c354b00b0040fc76ed923sm9474980wmq.6.2024.02.05.10.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:57:49 -0800 (PST)
Message-ID: <087d3438-98a1-46fe-89d9-8e7e1662151b@gmail.com>
Date: Mon, 5 Feb 2024 18:57:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2024, #02; Fri, 2)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmssirm6t.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqmssirm6t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 03/02/2024 08:23, Junio C Hamano wrote:
> * kn/for-all-refs (2024-01-29) 4 commits
>    (merged to 'next' on 2024-01-30 at e7a9234a8b)
>   + for-each-ref: avoid filtering on empty pattern
>   + refs: introduce `refs_for_each_all_refs()`
>   + refs: extract out `loose_fill_ref_dir_regular_file()`
>   + refs: introduce `is_pseudoref()` and `is_headref()`
> 
>   "git for-each-ref" filters its output with prefixes given from the
>   command line, but it did not honor an empty string to mean "pass
>   everything", which has been corrected.

I've been a bit slow to look at the latest re-roll but having done so 
I'm concerned that the UI could use some improvement. If I understand 
correctly the proposal is to make

	git for-each-ref

and

	git for-each-ref ""

behave differently so that the latter prints the pseudorefs from the 
current worktree and the former does not. I can't help feeling that's 
the sort of thing that makes people complain that git is hard to 
understand. I wonder if we'd be better off adding an option to include 
pseudorefs and have an empty pattern behave the same as no pattern.

Best Wishes

Phillip

>   Will merge to 'master'.
>   source: <20240129113527.607022-1-karthik.188@gmail.com>

