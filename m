Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A164A33E1
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529922; cv=none; b=rN5PRqcaootcU1EzFSuwy+5ITlNrMcSXbmRc7m9jaBe3TBlE4PEKDT5DpT2MWugvNdzXkBZPFTTINjUKEGnEVBzjln8IH9VxJdKaWcGdfbmpiMuUwoyyGQpCu+0jwMiqT655BQD73Csy1xY6abvvXmTVsiKwsTpoSejs0yUU9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529922; c=relaxed/simple;
	bh=ixZuQvMdkpARpfjrYZebCisPLH86HjPI+YK4ThAx/bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8eFU23tlqET6shw/SSo+Rg2yPE6LU3sBNNQZGe4YDvGnBY3GzEYuKd39AnLbO2+8kxFG9drCPemuo355Zk95lCnbI9rBKJJMFTWArZdontLs3+CplW3iXwd+wCXKq4pFopuHQsLWjW5Ugza8fRb6qa2ZJ8UxLNPe8E220JL2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd7M2xe1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd7M2xe1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5218927884fso17624621cf.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788529920; x=1789134720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekuKybVhzDSPvtzl4Oc1guYxbZbk3FHlSWFbJGtk9qs=;
        b=jd7M2xe1cVOOyTQo5I9FWqochHSUAny9x5ecVlc+4kUK8A82jAxvCy+r38t5jKytwn
         nfgFf6lfUpX3RqXtsB9d8VrXcHy4Ez5RboAHYsaGB0TaHeRSqdaVHp+VKcq9cLUYPlzc
         6GqJNXybsMFKOG8fKWRElIeNAgbaYhQoG8vbyW2FJhbIVYQSQAX5CUOQHMnB5l6jUUyY
         hgrArtwCjeIOjZn9ZU4YWyMMWlEHk8VhUtdBbW3gKsfHtTrUSUSWsxPmOReC9IjMBsS0
         9awvcJx9uXebah/yfAvZjxdNlLvCDo+BDGRYAXqPTsJ2gpQYOsPF0MIuJUwPwFu1LAS4
         yRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529920; x=1789134720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekuKybVhzDSPvtzl4Oc1guYxbZbk3FHlSWFbJGtk9qs=;
        b=WBdrLoVTcwfDxywOJ1/kG8UHqW8xP07XsHVpIifnek2lmTfHsd2P78CWsFdGIfplFU
         TyKydl6evxOG+SVDwOGuGd9lICo3waH76UnBwtrqTl7aciSQf2GDzeJ8M5IAwFVCvqiI
         ft9BLq0CrYBbdEf+fstGUdEcwF5XowjXxirqy9/alGOqCuNCTsX7sJGx2CRg1L8UhRdP
         kRxmUfMuraLnOAdCMp1nYP9u3U3kQClQplQ71YFzfBNgv7st+qaHW/3M2GRQ2qV0NgGd
         Pry8D1AVQNPqwHNuyLbZrVrHjlLQxJuTCGGuoDLsIFPI1Kbdjbr8NqXpdgmi4OSWXNZK
         zlpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBHewPpw2H2fZCftkDkHnGtVIBeMeXC8fEzPqiGjVwZZgZvhtplJ3rxgpG7P7DOcuDLlU=@vger.kernel.org
X-Gm-Message-State: AFuF++mATtw6M82lf4Jut9sioj8cSYrknJtC+zjTOJi3Ji1aYIwt7Xqq
	upB/yCtrzvas3mF0XULnyZiBDxkEjYqV9ThlC6h72PvHQpEDFH+cJKb4HawfWw==
X-Gm-Gg: AYBFou1pUSHRFkuSKRoWwlMr2Vdmd62iIKBXD19VfN1KXl4EP3U49RCAG+BjIeoMzBo
	8aW8DbVSkfI4qdzHHe69SiGrBjM7HXPe+uHpE5BKD5mTNLZj/G6p5v0yZ19yDVlO1Yop81w1rv8
	zZQCxo04JU52LD3vEvO1d0sHlmhYJFyZPt0S5E4KCzvnrud2Ichp+yRkFnwiAeGUS4jUOjSjNiV
	Y1kR3EmlMB9yID1Z9uMMxP69KuJqCPxYZMLNAG2u1DKCsj78wJ6ktclFzXmMPrgbsrZGztyoNXZ
	phmCKGqbJayzvEJVPD/mtc+OnU1Ohh3a1r0Bjud9uATUhMvAVPSLWfFVUlRG68kdJOF2IZ9lC3V
	LaKchsRYl+idPEg1QxTPCt290DpWEESSBzEQx72HsMOwJ7SSXZO4beXUCTIS23wHaSmKDEqOSYs
	/9uTG143NT39Hvo8wUTaU90w+vqTGowhoyG9uLHaIjsNZAPczcbii5R6Fm0K865SAIfb5B6n9Ux
	yi2Eo60gYLCvEF0MXspE4syHjCMSpxeULjhMmUUUr1D3zPS+vuTIwMoicXfDaryo1/kWunbLf0R
	c7uxw8kP8F40oiwzkBdntQC7e2kD4D3ujcFhZ7J45G1wDVxfZoGxUwh60Q/CHfydC+LvWumqvpA
	+5YrJNoLSDNTplWo9B70Mifsp
X-Received: by 2002:a05:622a:1819:b0:52e:4831:cdc4 with SMTP id d75a77b69052e-530547e1e2emr62663471cf.7.1788529919803;
        Fri, 04 Sep 2026 06:51:59 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104067b099sm20939746d6.28.2026.09.04.06.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:51:59 -0700 (PDT)
Message-ID: <15a488b2-b4ae-4ac8-8cb3-f06ef5bbb52b@gmail.com>
Date: Fri, 4 Sep 2026 09:51:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for "rerere
 gc"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2026 3:03 AM, Patrick Steinhardt wrote:

> Range-diff versus v1:

Thank you for taking the time to respond to my nitpicks. I think
the end result is a bit cleaner, and the patches have some more
clarity, too. 
> 1:  343dbf1c0c ! 1:  1b0b7a7b9a rerere: extract logic to determine whether entries are stale
>     -@@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
>     - 		for (id.variant = 0, id.collection = rr_dir;
>     - 		     id.variant < id.collection->status_nr;
>     - 		     id.variant++) {
>     --			prune_one(&id, cutoff_resolve, cutoff_noresolve);
>     -+			if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
>     -+				unlink_rr_item(&id);
>     - 			if (id.collection->status[id.variant])
>     - 				now_empty = 0;
>     - 		}

I like that this diff is no longer in the patch. Thanks!

> 2:  c8a52f0663 ! 2:  1ceb798cdf builtin/maintenance: improve heuristic for "rerere gc"

>     -+	if (limit <= 0)
>     -+		return limit < 0;
>     ++	if (!limit)
>     ++		return 0; /* never prune */
>     ++	if (limit < 0)
>     ++		return 1; /* always prune */

The extra comments are helpful here, too!

>     -+	return rerere_gc_estimate(the_repository, limit) >= (size_t)limit;
>     ++	return rerere_gc_needed(the_repository, (size_t)limit);

This looks much cleaner, thanks!

This version LGTM.
-Stolee
