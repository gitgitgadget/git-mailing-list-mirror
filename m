Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC592347532
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844902; cv=none; b=MwUPaO9J0oKH818eYlFAaB8imsm6/MUfmXx5QXf0o6w8DCj2L3Csp2GSr+V7WgyTiTDv+HPayYIeFNSIo7pIvL2elAXriY14FtFwF2iRcfDwlUoKDNYgLZsuA4XdZpqtyZfizZZx0EyYzEayxAvgtuOGGUj+UMmKw2TC42fUV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844902; c=relaxed/simple;
	bh=1tzxCpixirWSqyyQVx0Aii78xyraCjpMDxOdt8LQOuQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D/Df7tePxxOGj28BLzRqwxRKdABy5ol+2RTWrIrGiUw6Q2XPXKB/X1YbHmooibzIPjl/EgHC4GJ1ya21R7W0AmQZ7TbJvp6oDnAb1YZ6w5OX6hkn4UzFjQXYGh9F3+S5V92vziSofy/Iz4TFOvpuF6cx8AHJfOypUslba47L8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRL6nfpB; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRL6nfpB"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb6b726b5so4694878a12.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790844899; x=1791449699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=On2QSdcPatp4luj2nU3zp7LTbqLmA1jsEYS2wrQee0w=;
        b=WRL6nfpBFaJGb2RJ2QJvLnCjTiL4nBSN4u+HoqYqlhU3aK8ZOm4yc4rbWXF8L++Kfg
         DZ0w0aWbhyXAtETed2Izi5y1ovkqAH7dyTnrhJa/odulLbKS/TYreBQzAFgta64PQXyC
         H6fWsnI2TG+TcFCMEGX36l41bDgA4aNMp147GlT3hthYdOq8DW9xIHFvbAV/9Jwsh2Ep
         sNTbRzgnm5xTxkcVDgXe0tJxPUHtAtqhL7wgiQT+kSEM99b1nFHLFbpS25bW+1B4AIRz
         qzorJbFd6vRQoHYSVDFTYIuHlBOP8d+J9bFygtmYUxLgsgKAwLomkf8UfybAIHReoRim
         Eb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790844899; x=1791449699;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=On2QSdcPatp4luj2nU3zp7LTbqLmA1jsEYS2wrQee0w=;
        b=WYs6X30/UenUF/mEHIzvK2ZC+Rq7U5aIZviT7qt4Jo7RkXF+ysMzU+gSvoOGSjhdJ+
         YgigozaJVoUUv6OxP3pJX/b8x+oFX/m32Edstkp2vnHSn2TK5zON5fdygbdr2V19yueV
         T9xnu62B6WhXRr4Bz/N7A9xMaG+kBWteIMWaJTmb6BZIInxGjUC7mthhfeEIQSev0k/O
         DOD7MIpSA6nLHhtWDtBxzl/6NOF9ZTQwk6OJi6WstbpF9YMqTk0BDqFgviNUheqXadwU
         xEqFhLlrt/Tlrthp5wGg4Cm8xcqJu15YbE1E3bfaiK6WlQRPc1T8df5MBNTucfLzL9nq
         /+SQ==
X-Gm-Message-State: AFuF++llbiIL2kkICp8y80Jq9qnxUsxv13Gr37MZiVZXPIA+YSlh3kF8
	4tAY0Ev1xFtAZSrHSkAM9Q1R8Ps+4BfBZrnREf0cce2Gpvzu9065rLUpljJRxyHk
X-Gm-Gg: AYBFou0eC/coal4mtgzf+1sW6AWrE+MeLSJcvhH5KcTq4KoPuzds3Ee7Sr+0+kB2cf/
	wiehZCxbSydRZHcP/5UysZPKM5ah8LPQdspHfiOy2DKgNJ9XaCmWus5Cu5dvjBVHkbE0YQv42CB
	Kkc4kZFEVY+doOp9ODyKw0G7/atGsE5D3H8QQi0W/CZpNm+3q8SotXfMnq4mCIPmGTN+FwwaI7n
	VAtTX/7hcumhZN9hAbpWRB2tC/YvSS6LzO5YQFkWMe2Aecy9+wDrpE0lOm6vv9wPUBoNq3kFdYS
	DzNLwojHQPHAicFHZN5mieNAgHiuB0czyl7rCOeu5yGeumJhu6RitrOPGWCcAf/VFArVAb6wbth
	bzheGfnAvmjQfO/nBfR1gINlgsjwAFFicosmncSl3eWLjt/42uR60zZ4gsILZSmmjYK00rsUHzX
	I5EOFrqcyuUabXCAI+hy+S8J50VF4JZbaQ/3tfIsLh/1wkEgo2+c4QUUVZVoEtJvektOpFviZdO
	QOP4/uPw7PAzLM/eYwLOPFspU5hK22eUz1cpue9g1QQhxy6QubDkTifJShBepR9
X-Received: by 2002:a17:907:7b82:b0:c29:f5d8:9c7d with SMTP id a640c23a62f3a-c2e23d403f1mr335590166b.44.1790844898803;
        Thu, 01 Oct 2026 01:54:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e41d5aa32sm23332066b.75.2026.10.01.01.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 01:54:58 -0700 (PDT)
Message-ID: <6e028692-447c-4a21-a9bb-739e42f1c9aa@gmail.com>
Date: Thu, 1 Oct 2026 09:54:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <fdaf3da993366878b51bd0b2a950888710cafb8a.1790761727.git.phillip.wood@dunelm.org.uk>
 <xmqq1paad71z.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq1paad71z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 30/09/2026 17:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When recreating merge conflicts with "git checkout -m <path>" the
>> original conflict labels are lost. For commands like "git merge" and
>> "git cherry-pick" we could use the presence of the related root
>> ref (MERGE_HEAD and CHERRY_PICK_HEAD respectively) to recreate the
>> labels. However, if the conflicts are from "git stash pop" or "git
>> checkout -m <branch>", then there is no ref to deduce the labels from. To
>> ensure the labels are always available, the merge machinery is updated to
>> write ".git/MERGE_LABELS" when it updates the worktree and
>> there are conflicts. The labels are then read from that file by "git
>> checkout -m <path>" when recreating the conflicts.
>>
>> As "git checkout -m <branch>" calls remove_branch_state() which
>> ordinarily removes the labels file, we need to pass a flag down
>> to optionally prevent that so that the labels are available for any
>> subsequent "git checkout -m <path>". Note that merge_switch_to_result()
>> we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
>> order to get a pointer to the private struct as result->priv is void*.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   branch.c           | 11 ++++++--
>>   branch.h           |  1 +
>>   builtin/checkout.c | 24 +++++++++++++++---
>>   builtin/commit.c   |  1 +
>>   merge-ort.c        | 19 ++++++++++++++
>>   merge.c            | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>>   merge.h            |  4 +++
>>   path.c             |  1 +
>>   path.h             |  1 +
>>   repository.c       |  1 +
>>   repository.h       |  1 +
>>   sequencer.c        |  1 +
>>   t/t7201-co.sh      | 21 ++++++++++++++++
>>   13 files changed, 143 insertions(+), 6 deletions(-)
> 
> Where do we talk about MERGE_HEAD and CHERRY_PICK_HEAD in the
> current documentation set?  Do we want to mention MERGE_LABELS
> alongside them?

We talk about those in gitrevisions, the "refs" section of gitglossary 
and in the merge documentation. As this is not a ref I don't think it 
fits with MERGE_HEAD, it is more like MERGE_MSG, or MERGE_MODE. The 
merge man page mentions MERGE_MSG in passing but never explicitly says 
what it contains and MERGE_MODE is undocumented as far as I can see. We 
would perhaps benefit from documenting the common files like 
COMMIT_EDITMSG, MERGE_MSG, SQUASH_MSG, MERGE_HEAD, FETCH_HEAD and 
MERGE_LABELS somewhere in gitrepository briefly explaining what they 
contain and how they are used as a separate series.

>> +static int parse_merge_label_line(const char **p, char **line)
>> +{
>> +	const char *eol = strchr(*p, '\n');
>> +
>> +	if (!eol)
>> +		return -1;
>> +
>> +	*line = xmemdupz(*p, eol - *p);
>> +	*p = eol + 1;
>> +
>> +	return 0;
>> +}
> 
> 
> OK, this reads one line at a time from the file contents already
> fully read by strbuf_read_file(), as seen below.
> 
> Which means that the CRLF fprintf() may have written in
> write_merge_labels() will come back to this function, and our 'ours'
> may become 'ours\015' after stripping only the LF at the end?

That's a good point, I've changed it to use strbuf_getline() instead.

> Thanks for working on these patches.

Thanks for reviewing them, I'll send a re-roll in a couple of days

Phillip

