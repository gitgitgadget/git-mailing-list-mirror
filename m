Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F650A9E
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027418; cv=none; b=PEso3Ad2Rpw57N+YI1dLfhe4jM4chbSu/+LMyaREYTvCIdyNDhC4kdy72EVq9TqeVXFRhPKJPhjlL8aCBHFqMYdekcwd6O1NB83AZ63BA8dxqad/ttpSBUL9U2ayNKUAGV85qJ//2taaAtZXqla7P5g9uqSBiBgrA/O4J+xhh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027418; c=relaxed/simple;
	bh=4K/6oh8Jy9EQi86vXYJhniarH56sov6yERmq24U7gHs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iUZpU32PBwM1o7A11El/tZdA9mZ5Y7Kx5VzPKMMsOe35kBZ886IhbvwARbZnyh/o39p7nQaMid9ouU6NVQtF8Ns8M9yL+ONm1teo1JQ/2obqhKJ6E9TTKh8xcC2hZq+VU6Tzl3Yybfi8ZU6edF3ln2paceK4/Jn8CYFSLDRb1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcfrymcL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcfrymcL"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33926ccbc80so2724085f8f.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706027415; x=1706632215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EC6awfwCaW8ng77b2xoM/NnDRAb2ukaglwpv3pAPaIw=;
        b=dcfrymcLTp/FYohcjV6HV7Ifu4DEUw9M4oh5N9Zk31UXuBUzGSiFBJ7rxzVtoVNJ4A
         IZFwGOdKua/8vZR70y6LpcWrb5lOJKsUiBQTDJCOqPqGbjE3b29HP/687uAs6TjIHgUL
         R65PwgTnUrWCv+okzqM+OYmxHkGC9MKUA3kO7fkHDz88UlSDcJoDYOjN4y5j2tsyEpxu
         4IHxDMdL+FBQ1SBXytn4j5tKGsvVouoNHaoW4TwQ/ZredDwj1B7KR/swhlMzSo1n/OgT
         TT56pRbT3pwSzIHg6DBzWtNY8fgNzInb05anAtcmdvP8MGupadQ/Osk7MrYSShfitcjj
         n+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027415; x=1706632215;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC6awfwCaW8ng77b2xoM/NnDRAb2ukaglwpv3pAPaIw=;
        b=YEUd9f1db5nJKGdVZUdiJfqozfkdEAuHv0WcTe6qwtyHegdW0wyg1Ens4Q6dPF/UTP
         58RivnGFugyhWgA9WFeRoMlBOzJd9n7NFoGmbmf3Z/z5vtfvcet7Q41P+u0LrWtnxuQP
         XrWLcVJZhSsHMVGaLVi9KyCjkjAhGf/nv1OYavA1eMxyEhUOefPNt6lh9NiHTynqMgvZ
         4h43CQcSreTOj4NyGWezXFX3h2pqr9adao+sAemIwL7JLf5NwrM3Foa6uCMb7M/si2A0
         I6tbo7qkG5m3liSoY1dkTao5xz5eDEBbDfpuCc5i2wuy5ao+pIPN6vQa2JRQAxJ1neYG
         StvA==
X-Gm-Message-State: AOJu0Yw87pib3W6ylO++DK6zqaZrSk82srQ5od1eW5UG566uaE7lmnTD
	MTPTvZyb2GxKroP9jdEcLTlZYRmZb7Me9QL9yz68i2jozhLzpiIG
X-Google-Smtp-Source: AGHT+IFVwER7poLZ2/wD0JjpSaR/8kl1PWLRGS3JGVXpsXqpO1QSqUvQxXwNcNtQYHYuTK4MtFNEAg==
X-Received: by 2002:a5d:4d8e:0:b0:339:372e:771a with SMTP id b14-20020a5d4d8e000000b00339372e771amr2301812wru.52.1706027415020;
        Tue, 23 Jan 2024 08:30:15 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b00337af95c1d2sm16647695wrs.14.2024.01.23.08.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:30:14 -0800 (PST)
Message-ID: <9c800cd5-8d20-4df7-8834-f74ab000695e@gmail.com>
Date: Tue, 23 Jan 2024 16:30:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240119142705.139374-3-karthik.188@gmail.com>
 <ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com> <xmqqplxtrucm.fsf@gitster.g>
 <Za-gF_Hp_lXViGWw@tanuki>
In-Reply-To: <Za-gF_Hp_lXViGWw@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 23/01/2024 11:16, Patrick Steinhardt wrote:
> On Mon, Jan 22, 2024 at 12:22:49PM -0800, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> The list of hard coded exceptions also looks quite short, I
>>> can see MERGE_AUTOSTASH and BISECT_START are missing and there are
>>> probably others I've not thought of.
>>
>> I agree that it is something we need to fix.
> 
> I've taken a deeper look at BISECT_START because I previously missed it
> in my conversion to make special refs become normal pseudo refs. But as
> it turns out, BISECT_START is not a ref at all.
> > Depending on how you execute git-bisect(1), it will either contain the
> object ID of the detached HEAD or the branch you're starting the bisect
> from. This information is used to switch back to that state when you
> abort the bisect. So far this sounds like a proper ref indeed. But in
> case you're starting from a branch it will not be a symref that points
> to this branch, but it will just contain the branch name. This is not a
> valid format that could be read as a loose ref, and thus this file is
> not a proper ref at all (except that sometimes it behaves like one when
> starting from a detached HEAD).

Thank you, I'd missed that

> My first hunch was to convert it so that it indeed always is a proper
> ref. But thinking about it a bit more I'm less convinced that this is
> sensible as it is deeply tied to the behaviour of git-bisect(1) and only
> represents its internal state. I thus came to the conclusion that it is
> more similar to the sequencer state that we have in ".git/rebase-merge"
> and ".git/rebase-apply" than anything else.
> 
> So if we wanted to rectify this, I think the most sensible way to
> address this would be to introduce a new ".git/bisect-state" directory
> that contains all of git-bisect(1)'s state:
> 
>      - BISECT_TERMS -> bisect-state/terms
>      - BISECT_LOG -> bisect-state/log
>      - BISECT_START -> bisect-state/start
>      - BISECT_RUN -> bisect-state/run
>      - BISECT_FIRST_PARENT -> bisect-state/first-parent
>      - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
> 
> I think this would make for a much cleaner solution overall as things
> are neatly contained. Cleaning up after a bisect would thus only require
> a delete of ".git/bisect-state/" and we're done.
> 
> Of course, this would be a backwards-incompatible change. We could
> transition to that newer schema by having newer Git versions recognize
> both ways to store the state, but only ever write the new schema. But
> I'm not sure whether it would ultimately be worth it.

I think that is a really good suggestion, it would bring bisect into 
line with am, rebase, cherry-pick etc. which keep their state in a 
subdirectory rather than cluttering up .git.

Best Wishes

Phillip

> Patrick
