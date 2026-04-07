Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B33A5E8C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554909; cv=none; b=pOeO8pBVRaf1BIs6PpC1sOGZS801rdaFFaBIxzcckF/7vo1y8N1YivAmCFHc0PxBCcGoX2H6cfbr+BIrJgoNyjg6ldqhJvrfPW7YamyHZlzuRRK1s1MPWbQyK/dq+p54IpMUqlijagZCdaf+52BZhPVDXqMIbdajmegpMnvhcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554909; c=relaxed/simple;
	bh=dVeWgEI/k8tb84eG+L/ywktWlkbs+p24/c2D5Hm+qPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PcuRJnnJnhyfqS98v6o3g7s9gQ+OneeWJHyD++5WltxAqzUBogRJ21mZBQruSmpk6/SGDr+T0bVVLemOkXkFYCXqZ2EYIBccxJlbtIX1MdKyGFyPoHpNzgIgfEqf7yP4UOr8ldLrVya9pyfPJHszbID5xS6Y5yOAl95HKfG+7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brZnWP1o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZnWP1o"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso25188775e9.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775554905; x=1776159705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gsv83J6i+xGnkG7InojDEwz6xl0fWG5eOTEix8J9Wj0=;
        b=brZnWP1oU6HCfl53aRMkHUgRAJ+9RyNx/wjnDxaO4poE2KnPLiqcfiGLoohKqBvUKU
         SVRWnkaNYHByM+udxZ5XjkZ2RD8K7SN7AG1PV3ponQRuZLXGqN/dFp5Cis4WA/aoSqVA
         O6N+H6S+kknIaDutMnc4hhc0UINS6tJX+lrUeA/7pNMKoQ5OtCCjdd8lhkIOawUEa/4n
         nLinfNkzgjOKMKe7zEzn6qxVr08vE3bdu2Jwu1zbe8jUZ+MQuEBIaIu8kCW2Fv/7Qj4f
         1WfYeRUoyYeggdNfhaQQiPpcUSXjZGFzh1fjZIfRn9rfE2TW2RfesPh3FR5ifN22yJ65
         yi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775554905; x=1776159705;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gsv83J6i+xGnkG7InojDEwz6xl0fWG5eOTEix8J9Wj0=;
        b=p3TA07oNU0nohM4SO/iQyVDULH7iQicY7GyVBJfxjCPSSLwY/QqRlBhu88P1Dd9pB9
         RtUvUQRDC/osXc73UyXGY3mh/peY+LBxbmfX2/xa4fKd83ZG/yhUxcn8PvZONNDKsDZA
         SVG1Mh1zUWL0NJ8oEUGLNS2Il54Rhk4LKXy1on+j2MYJkI/M3Jr6MjFvtJ1QhDk/j5yv
         VZc/FQEsNrMgHsTyNrXqckkHgGRr83JZ+Ban/0tpfnhcsqYynvcRUdS19Kh3V3xD3DpK
         yKXtpS5HfeKcKfjgcYaZRdW4XBX/ACJKp1nDeHxMc0ejyXxmyh3IyBYyFprbpwwUl1xH
         NacA==
X-Gm-Message-State: AOJu0YyHwQqZgS9eoSJRX6iQMCPSSuH5JCuMgzZ86G1ildcicfVVgTdB
	ZjqhH0c8chGWD+/0hA2i73P9Xex0b2DXwxVZT5YHjCYCoO/qT7RgheB4
X-Gm-Gg: AeBDievX2YodRJKhH1Yj+TtIe672yW1umgS9FaNJbRFe/zxaK1hK5UuC5eshM0BgF2A
	/5infz4tnwmIorji4jMdTOhvKxRvq8cYFrg7/c7OADuKhRz9jRjGr6JzagBAnKV9PEpBrM9uNDr
	5La/qBm2/1Sfl3XtzrlANMxEigPIryaK5KniMF62yz2KW2o3XfQqi6DfNKsMYjcLBfN5wNXqsjf
	itSPoMIOLztSpqRI+jC4qt6aGsPfdSPSUgKgX6aZBFyBuM4y15LmvlmjJcsKYuUKHm/yBRoEiWJ
	cII8gNyMDRB2J5QESJnn9gUKCcQycHoHR8AL5egXxFiR82KXalXi30Af6f8a3DPuOBHyDJMGDrd
	ljmFmH0eQjcqfd6rwvfN0x7CdwuM/LFIuRB8zM5Yjzb7rriFmlIVSoCtGrQEO9vezzsmzfd54KQ
	vudYPGx11HoDjT6/jEDXpfUzGqqbN9/VByufM8Mcb7zH8uSMb9xC+mdneH6MHLsz6d5htSbCIub
	pE=
X-Received: by 2002:a05:600c:c8d:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-48899793093mr220288655e9.20.1775554905088;
        Tue, 07 Apr 2026 02:41:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm344618545e9.8.2026.04.07.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:41:44 -0700 (PDT)
Message-ID: <8f485b7f-3f6c-454c-8e87-d96ad8fa616c@gmail.com>
Date: Tue, 7 Apr 2026 10:41:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
To: Junio C Hamano <gitster@pobox.com>, Matt Stark <msta@google.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk,
 Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
 Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
 philipmetzger@bluewin.ch, konstantin@linuxfoundation.org, newren@gmail.com,
 tytso@mit.edu, nico@cryptonector.com, rikingcoding@gmail.com
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqzor76nh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2026 05:09, Junio C Hamano wrote:
> Matt Stark <msta@google.com> writes:
> 
>> In the discussions on
>> https://lore.kernel.org/git/Z_OGMb-1oV0Ex05e@pks.im/T/#m038be849b9b4020c16c562d810cf77bad91a2c87,
>> it seems to be that:
>> * There is consensus that a `change-id` header provides good value
> 
> I doubt it.
> 
> There are multiple people who wanted it, but as far as I can recall,
> I did not get the sense that they had the same semantics in mind.
> 
>> * There is not consenus on what precise format that should take
> 
> Format is one thing, but what it means is much more important.  When
> is it inherited?  What happens when you split a single commit into
> three pieces, which piece, if any, among the resulting three will
> inherit thee parent's?  Should rebase, cherry-pick, and replay
> behave the same way (IIRC, rebase and cherry-pick behaves
> differently while propagating notes).  Etc., etc.

Indeed, copying the header is easy (though the patch does not support 
copying the header when the commit message is edited), but agreeing on 
the semantics seems to be much harder.

Thanks

Phillip


