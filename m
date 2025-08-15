Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8022FD1CD
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253530; cv=none; b=gQYMSv9EDaNfjqA00Th+TBQTylydaovkuQtaMMFwCeP1Kvg4FeVWo+RU+jkg2UxbH0rXj+s1AvqyIVAzhfZA5lEw7DorRvt+WPt7jAKpdZgY+K7GOipRssK4xA1Dz24nCsaGDbj3OBFzhnvaw4UIRwaoyULXS1+eqZ1nmDbN7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253530; c=relaxed/simple;
	bh=d3x2yAgaczxvu4lFQ+kTZOG4gfi5f6OIJ2hcD8dVxMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7VcJ6HY0TCLSJjjr3aAXZ0RrvICCnM9dokWx4spCekDXnH2W/8mOjfdV9PfYQvDrgPbrTeSnhZGXj4a5aiQzzky2bJ/mGEKmYHHmfVxCzQWQYcBkz5YiZX8GpgQ5BMmo94/fS93rOoURSYiJaO14mbdM1u+5PtS40g4Y0w9JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv4wz1hG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv4wz1hG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so1050152f8f.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755253527; x=1755858327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxHAdJwv6xNybabUPRdu6A0XL03OnPSMRG00NnbUNCc=;
        b=Zv4wz1hGgu20CDBiR69hXMDAvh8MRtV3QvQHb6vb5nEUnXrWedzpJZESv4WjZlTKl6
         7U8sxdZgEnziVtnE3RpDkDSb4vnUjKXSHEiqyWlgkLEKCmLwJr52VwMVVkmvudwdx43D
         m3HgvJOfltgHVbvGYCSNNSxAR30W1JoVH3SimEqA8PB4P6jtqDPe4gCJbOUZEFtDkRfd
         dzol6ypwK9oKmndPYT/jZMJeY3A6AuAAXtwDubuVarygDF4V4h+MpRpEzelfj7FUZCJA
         26s+r53ebO8AfWEufVDXSjy22fKmvOCpJlWbGNrLvWwZHqz+L8vEj8H6327sqe5+S167
         YJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253527; x=1755858327;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxHAdJwv6xNybabUPRdu6A0XL03OnPSMRG00NnbUNCc=;
        b=sNw3n/7hSCq0Vo31/KUPdScnj6YSN7PL2DB3xGxgMmUr0blUXmn2UXKJe+qIDNh3Dz
         uRnpU0G/UZdVxD5GN40gV0X/XQ4EXtQCWs2XsAngiaoSBFtgXwLewQLhq1Bpq85wUCpt
         3eFX1zxWs7mtzlxBCnk2yqTDI8Ogmyt/3zqpl7O2HFEIzVSIVi9URgDSGjjFPFAbnjBa
         sUjnDdeoZJ5KPl+iSHcCJprjGTaMWB6zl8iRDd2DroBOZVHP4ytg+5FF1C9SZXHQZx4S
         p0m21kTVLGHbPqNzD05tXRd/z48a0SrN3g6pU0Uu6D48/QzLW064VfmTmJKmPC4qKll5
         wBog==
X-Forwarded-Encrypted: i=1; AJvYcCWZLetjm6GjQ0KFtufUbva0GF7+Eei/my9aWG4aIlnjexCyZP+RaAYpZGYQnDqfC892Vx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDka/93iPZCUN5TjXNsE14bUS7XlsZ4aaHzlbcU1CLHBDV+0u
	13RaCFAqWUslHByV+2gnRpjl266oc/YiFZeud2LpgoQXVHk2bY4fQm2z
X-Gm-Gg: ASbGncvchmagqpV/Wd7HxePEcytqqBDeFhkv5Z/B4sYlI5KbiFR2JzM4nT9kvmO0KZN
	Z7MrTkeyv5onpNjrl86kloAW0R/W1wA0zRZC038Q+Q/puqE2atYRqOPABJrdmXMfqpzcY3y9SdI
	MlrPFhcXkQyJNyOT5ynE3Lfh4/F4g1kkJRYsYCoUIJFzFOQe+/bwJ307q2mPzUK38mWedxAh7c+
	42cDBixvP4Z++9n4mRlNxzGyn13g/OttOUGDmF5xNv9LLG+VLUKUHti9sUHrFjjmjXy5fyoQkBk
	YkRvwWsIdHfMC80VvZdwiEeIo4JEbquidReXwsfQQfMwchKZ+k54UJo+egAQolcFlH1DfJS3w8j
	05YKtAs9CoUAOf5yDl7QPNrs1EhKXCounyQsTopTJ+Ri44lE7ovcY4Z13hA==
X-Google-Smtp-Source: AGHT+IH52F7K2mQpk6oWQqE3MGS2A0TF5qkm+nU/0oHnSBVBY/D/YodindO5yHSR21SVPG05dMrMOA==
X-Received: by 2002:a05:6000:26c6:b0:3b9:7c00:b6a8 with SMTP id ffacd0b85a97d-3bb68cf8f00mr1073188f8f.41.1755253527121;
        Fri, 15 Aug 2025 03:25:27 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079341sm1378853f8f.50.2025.08.15.03.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:25:26 -0700 (PDT)
Message-ID: <c9a4d7ef-8cdf-4d5b-b0af-f43ffc6b7450@gmail.com>
Date: Fri, 15 Aug 2025 11:25:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>
Cc: phillip.wood@dunelm.org.uk, Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
 <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
 <xmqq5xepzjnu.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xepzjnu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2025 22:18, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
> 
>>> well given they're also both pretty niche. I'd also be very happy to go
>>> with Junio's suggestion to replace steps 1 & 2 with a general
>>> description that does not mention 'git log' at all.
>>
>> I like the idea of leaving out `--fork-point` and `--root`.
>>
>> Now that I know the use case for `--reapply-cherry-picks`: what I like about
>> leaving in the `git log` description is that I think it makes it easier for
>> folks to build a mental model of why a `git rebase` might be slow: there's a
>> "fast step" (the `git log` step) and a "slow step" (the `git patch-id` step).
 >
> But that is not what goes on, is it?  What you wrote as if they were
> two separate steps (1 to enumerate, 2 to filter) is not what happens
> in practice.  Whether it is done via the "format-patch --stdout | am"
> pipeline in run_am(), or via the "rev-list --reverse | xargs -n1
> cherry-pick" pipeline in run_sequencer_rebase(), the upstream of
> these conceptual pipelines that enumerates what is to be replayed is
> run just once, i.e. there is only one step that "enumerates what is
> to be replayed", without a separate filtering step.
> 
> In other words, there is no "a fast step followed by a slow step".

Although the cherry-pick detection happens inside "git log" that command 
has a fast step (find the commits on both sides of the merge base) and a 
slow step (detect cherry-picks) so I think it depends where one draws 
the step boundaries. The cherry-pick detection is known to be slow when 
there are a lot of new upstream commits which was the motivation for 
adding --reapply-cherry-picks in 0fcb4f6b62 (rebase --merge: optionally 
skip upstreamed commits, 2020-04-11)

> Perhaps squashing the first two steps into one and phrasing them as
> a single step is sufficient to give a conceptual overview (what you
> have in v7 as "a simplified description of what the command does").
> 
>   1. Make a list of all commits on your current branch since it
>      branched off from `<upstream>` that do not have equivalent
>      change in `<upstream>`.
> 
> If you want to keep 1 & 2 separate, then rephrase the introductory
> sentence to clarify that we are giving a white lie for the sake of
> easier understanding, e.g.
> 
>      Here is what conceptually happens in "git rebase":

Either of those sounds reasonable to me

Thanks

Phillip

