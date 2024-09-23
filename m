Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37996194137
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082927; cv=none; b=nwJ6uNppKkGFwTnoxDG3PLAuLQJznmJbae8vGEdEXlfEGZ3GIXA18BI+9NYN0OdVO4jLfwJ1a/IlUeP/IQ/4LYoVGSTWLzmobeosOziytZd0blSSuczc0lSbdFcqxmjE6URrEWKGRq/kPwP6EpQR9xRtrqAah7P+LSnW/lanXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082927; c=relaxed/simple;
	bh=+iJE0Svd2rbNixtFam8dV6SXgO8DgGlWDrLDzFSyegQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaXrYnxBIXFWxlzWv7qbs548mDpr2Qska6udQaL0k1M740k2hmC6eQW7CE274lfhwd4rWJuo6fSKArrR3oQzXDdlxKex6BFttPgjSnyvOLqvMIkq49zkt1u73sEoVNR8qrewszNARZ8qESwzjWUrMt0Ed5V/ni7yFIX/xcnTkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXtl+SPG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXtl+SPG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb806623eso33882785e9.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082924; x=1727687724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RhUkpeRrQD49GInmDkX3IaLD1YXzKM6tfhPJlD+Y6R0=;
        b=QXtl+SPGgwFaaI50UEXPYKkdKpp40SEyH9V2E/ZZ9YzBr7pfWLxmiHfUeXjqmoFITQ
         bw9h3mFgNq+W5/ElHov8KcNPnupd3LO6cwjkUakHaLs4yZbzTySFBgg/47Ggq3RKw7+A
         y5LZY4F/BB9KLA63wHSOGB3eTHQTNy2MEG5YtSduEGUqnnD+uz8GZJ7mw8KBSRNKo6DB
         bDBPnfE9crJQ56xoe89exUvahB0aTOddIoZjcSfnW8ufz+aoywEol3KMr7UbPtlGplAm
         g6J9SIj090OZPU/R8Sg4h9YOBvNMGj38l8okicJNTV+u+jgM8WOMZExP54Q0Ux9narW7
         k83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082924; x=1727687724;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhUkpeRrQD49GInmDkX3IaLD1YXzKM6tfhPJlD+Y6R0=;
        b=b/n6TdaynERj/gEP3Gk1d1JgIZPbcoRa6/TXTherVt0GKnydPzxhfA75QtgxhmBmdj
         O8FyJByW1zcsVIfSPjDOfcP8RJmODXij7sCOVm3ns8rKOQvc9MY4Yo5oXl4ntPG3yAty
         qlh3MBtkS9+ebcCupC4k/lpySlIoB2vsMQ0NL36vhSBXd711Cou2/n2Xe1iF271dRJJF
         hSIi+TwC9DrwMu7PHKHTCc/07YOO3mNqTxNHoqvK21tMxJBT3Zk1F12O2ttjNPDyJ9Mi
         LOizOl5X9pnoelDUVguZBWiFJpI6/C1yYZjezEKogQTCnnHjH3a8Vv5zns0gD+jesQGR
         vjng==
X-Gm-Message-State: AOJu0YwKeUQ/GqwLXk13UF/i5mNAhMxtZVqlFAfyleqpCTQN1bpOsI6T
	Vp9HWONy+F8OYf69Q3uCGj+K2kY/+4aN1dMqrtA3ekCO1b0Xe65klmvs+Q==
X-Google-Smtp-Source: AGHT+IG/e0gu0ZatGYCbG+AtrR7hQYTKzjpNXUG5/l1zGD7/FJMnk/fV+sfPyPEjuCUZCt1fRJUW5w==
X-Received: by 2002:adf:c788:0:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-37a4225216amr5574073f8f.11.1727082924343;
        Mon, 23 Sep 2024 02:15:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c5c78sm121295455e9.42.2024.09.23.02.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:15:23 -0700 (PDT)
Message-ID: <25050ad6-bdf8-4b1f-bbc8-cffe6ca15386@gmail.com>
Date: Mon, 23 Sep 2024 10:15:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [TOPIC 10/11] Project Tracking
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2FMQnLCKQ2skkM@nand.local>
 <xmqqployf6z5.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqployf6z5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/09/2024 20:41, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:

Taylor - thanks for posting these discussions

>> * Jonathan: (to Peff) you mentioned sometimes you have a mild negative
>>    feeling about something and you’re good about expressing it on-list,
>>    but for a lot of contributors that will cause some discomfort and it
>>    will cause them to stay away from that thread. If we’re a little more
>>    clear about what’s expected, then conversations can get stalled less
>>    often - e.g. when a thread needs a comment from a refs expert, getting
>>    that comment that supports forward progress.
> 
> Yes, either forward or backward.  Having to keep a series that looks
> potentially worth doing for weeks on 'seen' without getting any
> movement is *VERY* painful.  Would it motivate more experienced
> contributors to review and express either support or refusal if I
> more frequently, say after 20 days since its latest round got queued
> on 'seen', a topic that does not seem to get enough support to be
> merged to 'next' and is not getting rerolled?

I think that sounds reasonable. Sometimes I'm quite slow to review but 
if I haven't managed to do it within 3 weeks I'm unlikely to get round 
to it. I'm also sometimes slow to re-roll if I'm ruminating on the best 
way forward, but even if a patch series gets dropped there is nothing 
stopping the contributor from re-rolling.

Best Wishes

Phillip
