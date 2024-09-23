Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D9624
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054584; cv=none; b=udMm3uKsKOG7q3YwQQ0lCjLhwhLlo01k2OdbaxVtRCCZRfWv/OUGg0HzgSG6iq4NhuDzfH+AAji4p4h5d506QanvJ3PGsc585EzLMXYgIJjmnHeDT05dOzwjWMJnZoRS56qZZyUOvg3ZKBCgcOLpz7X600H8SkEgXg1KZbJwi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054584; c=relaxed/simple;
	bh=l2aLIQYYvkkRnNLoFa56sP8MqzMUtZOkoegN6YqzUsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+ITyoXtmwb9xPLN3jnWPhFrtNbGWD2B8pU8XBAOHFs0UPfzRvjDT40BVJz+3PVVownbiN/nstPdLjuDXt2osauJ3kwdCrpjba8HXpwlZltdcwtl72lwghRSoexZx8tRTHSIbnK3bqY75uQng/OmfjIK8ieSWwtS7y1YUKU2s40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDMCWoT2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDMCWoT2"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e039889ca0so2080129b6e.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727054582; x=1727659382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCYNK+ouVwbvq0fx/ym9z3lCho5QcgM/m3dxnP58rhU=;
        b=JDMCWoT2yjZvYVVedrDi9ZDvq8dS6enF92+0kE7U4lrGPJoIEukhynzKrwnJQyt0Td
         SyAx16D77STcyTnpUTEVsn7khbLkyC69QjPQJzMyws8pROKaGNuxmy7aphb9tCBgnkiu
         u7lll39RUgC/Lm0YwLsF2jI5tQ92zjM+oZE9Nc18XjsV+4cW7+vohAxFuP/H0Q5E71RL
         wKcGYN7A18Av80Q1mh8ZlqtUxgOOwtvmgCMhgM4RtdDvTMwUJSanz6raLKXewEMiFSCJ
         jqusf7n1Gd+kNQYgNClsDSOttsFESrZbWbmpyv1v51kQvWShs/Hl1rCk2LfJcPPdfop3
         Z/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054582; x=1727659382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCYNK+ouVwbvq0fx/ym9z3lCho5QcgM/m3dxnP58rhU=;
        b=QdfklsahnhDKvRfEjkJ6lEQYMjzce8jBsag4Ab6dNjYTX12TeTUyubjtdcveNCHHrG
         wqTxZ74TbdHNG2JLsnNIriOwS/acZaE95h97jdPjBC8oZIEAEos/d9D6SmBUoJ6GTQuP
         S+jqTkcexcS63EqThwk8LUfZKQSwjr2TiRS50Yc/u3UQrJf62/D0e4hwd+0HBQ/MCCol
         ODYH9RheEsGF8h/9Nl9csSAuoqxkfHVuFMcPLW2sU5KTyBkpMMbj/ah3xfPBW+AQyc8r
         vJ0LER89b0CW5Xst7jkBJ0PoT9P/LajbGmh10aTbM6DhVi/Ah0xtNW0FmubBMiNUolll
         BaWA==
X-Forwarded-Encrypted: i=1; AJvYcCXtifBVZI8AgCy5KsTlIjEMaO3Qs0HsERDYmFiFO9iFOpPzV+773bwcUO+fUoBQn1GywAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuzXd/mOjwImrOZQK/IgwN0nI4Ianiy+I32ZPjpaXTbmxZzsb
	ElpgpBceWI7PvliebrW5U3vPzAa910WkUv0rUEjBImXCv2fKBU7d
X-Google-Smtp-Source: AGHT+IHkeZ0Vhdf7Ycn+CH4u7/z5EsOwEJUpWqFwUARvcil6oGtUSEFh2XT+a89DUsLxzy1eWtltdQ==
X-Received: by 2002:a05:6808:199e:b0:3e2:657d:7a4 with SMTP id 5614622812f47-3e271cd5b89mr7776971b6e.47.1727054582136;
        Sun, 22 Sep 2024 18:23:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e26b6bbd03sm1961369b6e.25.2024.09.22.18.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:23:01 -0700 (PDT)
Message-ID: <6b672771-4016-49e8-a045-0a48bc8c1522@gmail.com>
Date: Sun, 22 Sep 2024 21:22:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
 <CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
 <53dc17f8-82e5-40fa-81b7-af89f987928b@gmail.com> <xmqqplov7cw8.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqplov7cw8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/24 2:37 PM, Junio C Hamano wrote:
 > Derrick Stolee <stolee@gmail.com> writes:
 >
 >> Combining the two features actually ends up with very similar performance
 >> to what `--full-name-hash` already does. It's actually important that the
 >> `--path-walk` option does a full pass of the objects via the standard
 >> name-hash after its first pass in groups based on the path.
 >> ...
 >> I was not clear about this, but the RFC is 30 patches so it's possible to see
 >> the big picture, but I will be breaking it into at least four series in
 >> sequence for actual review. They match the four sections described above, but
 >> will be in the opposite order:
 >>
 >>   A. `git repack --full-name-hash`
 >>   B. `git pack-objects --path-walk`
 >>   C. `git survey`
 >>   D. `git backfill`
 >>
 >> (It's possible that `git survey` and `git backfill` may be orthogonal enough
 >> that they could be under review at the same time. Alternatively, `git backfill`
 >> may jump the line because it's so simple to implement once the path-walk API
 >> is established.)
 >
 > I actually was hoping to hear something like "since it turns out
 > that --path-walk gives a better performance and it does not regress
 > small incremental transfer like --full-name-hash does, the real
 > series drops --full-name hash", i.e. without part (A).  That reduces
 > things we need to worry about (like having to either keep track of
 > two "hashes" per object, or making small incremental transfer more
 > costly) greatly.

I believe that the --full-name-hash version still has some benefits, in
that it could better integrate with reachability bitmaps and delta
islands:

  1. The .bitmap file format would need a modification in order to signal
     which hash function is being used for compatibility reasons, but
     this does seem within reach without too much work.

  2. The delta islands feature integrates seamlessly with
     --full-name-hash and seems difficult to integrate with the
     --path-walk feature. Either we would need to have a second object
     walk to get the delta island markers, or somehow put the passing of
     the object markers into the path-walk API itself (similar to how it
     needs to push the UNINTERESTING bit around during the walk).

I'm not recommending any version that requires tracking two hash values
per object, as I have not been able to demonstrate any improvement when
doing so.

But, it would be helpful to know if the --full-name-hash feature should
not be pursued due to the --path-walk feature being prepared shortly
after it. I can see an argument for either direction: having a new hash
algorithm provides a smaller change to get most of the results for the
full repack case, but gets worse performance in many push scenarios.
This is the point of an RFC, to get questions like this worked out based
on the "big picture" view of everything.

Perhaps I should pause the --full-name-hash topic and focus on getting
the --path-walk topic up and running. I am curious to hear from folks
who are currently running Git servers about their thoughts on these
trade-offs and potential uses in their environment. My needs on the
client side are solved by the --path-walk approach.

Thanks,
-Stolee
