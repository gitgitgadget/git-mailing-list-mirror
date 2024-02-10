Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D26364BA
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707590983; cv=none; b=n3i7XNtldTWvpWE5zPdkvx7P9DdXkRxv2M9zSE4R6NMCxDVzlP1SoFMUrVJkrA/zDUnCCgLGY5Yotb/03elayg28XL+ilY1cJmc++bL+hynZX8XPB6j7xuGQVvCMBD8kWJgeRow1v6JkQxRlmGu1bQXqLjlNC8SATfTmdxg16oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707590983; c=relaxed/simple;
	bh=dLa9RzFnNcjL9Qd6SrJO4y//GigFpOR8EMWIV0pWZqM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Oubo1gaZJ/UwqZrqmGkMyJlS4dRtNV8V+Lp1EZ334Lpj0l/rwl4Y73fRrwat+3v8EzYM2xloaVzK0flLGQ+iAdtPdhUCv1n/LBBULA/kIdu9W6500PpKH60Yy+k4rIx7KEM4FPcGwz/IfrT4NNDVqBJXFqhwZK4sDZ0h9Hc1ATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkFA8I6r; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkFA8I6r"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783d916d039so140838485a.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707590981; x=1708195781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsPvR6SGZIUF5xk/aIzB9UDk5YX+qu1iVEtJ44NfrhE=;
        b=mkFA8I6r8L8t0AmLjbmm4sp9OibBcMpHlXVcjN/coDzlI+WzJzqdFjZ/eqh+qiE96h
         J0L6E9rftv+An52aHXgo4dPG5YVz+cFpLkFhOyS8luk4RQXi83yfUI3xiPI8klduvJZR
         6urZ0QMG2CN7Eiq1qKAPg3VVI8TZGNP1hXOjIileTMLon3e/d7/gvcVbvCq7sOK5WGzq
         E5Ke9xURrzHif2P/nuno0FcjYGMsRiT54sl+tXViDdKVw9WkZrH9APcYbhX2ipGstz49
         M7pAfz2YTdjqlRD8VH6U71qSgH2qqdnFloryp9YXdvqvRn3yzbbGo85pEXUarwAPOrPn
         x2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707590981; x=1708195781;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsPvR6SGZIUF5xk/aIzB9UDk5YX+qu1iVEtJ44NfrhE=;
        b=r/J5lvck3vLh0BhfdsRH/hfKBeBTj/avEbYe4kU7ltWkAG71u4EWn0WAFnlBlfXHk5
         E9WtvpESC0Bpcy0ezC8UvdhFQjxUpmlzxXlAgosQfM61A6BtB+QkF/Q1f/L4c0w9tXx1
         JJTqHmmYqKmRtHSQ6pfPEBWFeua1eEuxMRjpizHwV7uzPw30v2EuiRMPJ0nWcrAVZMbT
         45FZtZWUmMnhcYmlZ0K1CGCy+iV7Bcr1yIe8Jhfazt9g2DaQZhzsWYiBumH+V5p0sHqf
         OSXXLZ4w9ZA8WzKY/bjUwGdfDXUw1m3Z6moLRwteVL/b6m2UAj2QTOpUv/muQW8BPCFx
         B7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXGiBGRToBPHiDXVVnCdOR2EYv6ZQSTtCCtOiDzKR8ciDSFwk5St09DrC1ZBHuAym12vYdkSgF/RRHNJR9HdJUU9qY1
X-Gm-Message-State: AOJu0YyCPv8TmJd+WmyomSIpElje58W4pIznPcnbwU+W8f6TLZXuTQBa
	Cik6sue+ZAbmzIlakJPP/fPX7Q5cpkAnREUaCMt9ol05IhACIZrY
X-Google-Smtp-Source: AGHT+IE8pNQK5l/zVBAO8PMDfo6kQyZyYgfN4cUluD/aU5ciRJYkc39tonhcrQVqHnW3BTpV8Ixctw==
X-Received: by 2002:a0c:f291:0:b0:68c:499f:f803 with SMTP id k17-20020a0cf291000000b0068c499ff803mr2923970qvl.30.1707590981365;
        Sat, 10 Feb 2024 10:49:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIkstf8jcb6H7p//52SjcmWtsJcpQDZOaspNBlwUhYE3pu1jHiaDUaHp2YBQNqp+TKxHvUWTnLqHriW0q7uxSS4aZKELaKAaBBagFEXzRdwrjt1tKUX40kDOqwuA==
Received: from ?IPv6:2606:6d00:17:3855:7446:337:f37a:d47? ([2606:6d00:17:3855:7446:337:f37a:d47])
        by smtp.gmail.com with ESMTPSA id mc3-20020a056214554300b0068cc3a7a59dsm1976474qvb.106.2024.02.10.10.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 10:49:41 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2024, #04; Thu, 8)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 mi.al.lohmann@gmail.com
References: <xmqqzfw9h7oy.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <13f08ce5-f036-f769-1ba9-7d47b572af28@gmail.com>
Date: Sat, 10 Feb 2024 13:49:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqzfw9h7oy.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Junio,

Le 2024-02-09 à 12:24, Junio C Hamano a écrit :
> * ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-08) 2 commits
>  - revision: implement `git log --merge` also for rebase/cherry_pick/revert
>  - revision: ensure MERGE_HEAD is a ref in prepare_show_merge
> 
>  "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
>  other kinds of *_HEAD pseudorefs.
> 
>  Will merge to 'next'?
>  source: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
>  source: <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>

I think this is a very nice addition, I've been meaning to do a similar
patch for quite some time.

I think the commit message of 2/2 should be improved, which was pointed out a few
times in the thread. I'll try to send a v4 with a more useful message, summarizing 
the discussion, so maybe hold off on merging to next.

Cheers,
Philippe.
