Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380B17BD2
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539821; cv=none; b=gBR5qkLNH0qk6CZZKaMkqoQRsCA+zOuUBlAw3mbiAotL1JzaRifMBxusJ2w0EBlNStHb1jvZa7s0nD/1bT7duDSSF1WSNTEAMOlDkiOYYC/uGdS2Nj2pAHlqoq7c4QlXlPstYAKovUeHwgV2aCZJaU7HipcVBx31vEi/OsOU4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539821; c=relaxed/simple;
	bh=2B5WbsrZWsiqjozLv6m837bU4uRuFCYROtAYPKjqchw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQpGMyJtmJxlKR45MSbuFSMJhcpkIKtTzqbWWrA6gdsQdkDyOlRj5K0uqmzdEhrOJGTHXGNd8rmvS0EAM4CYQhcN6FzkyCJazaVYL1iV2NxxuQ63y5XDm5k2uFjwdFm+5GoUWJAsJjGZ+SAiqA3TOWvMwDZrSaEJMVUvG+OtITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTxTV2DQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTxTV2DQ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-630640c1e14so857007b3.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719539819; x=1720144619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rXu+MXt4nFz4+flazvlrCn2aWVXo+v8foPD0eFjHBc=;
        b=PTxTV2DQyeDTTz/kkB62LU6srFfaOvBUTWbP6lNVK4CH5PogGhfUTp0nf94JTKiZA9
         4hxIMlWN7W7BqBEoYk8vA5U+b6yGnbTsH8v88tJKpq5yWYbA3a5HO5Al+o+0JaH/nxIB
         72/KH9DMQ21YlmikwJ548XyJA4GYmiFpZxXxFSxAG9qvqR5Mp8qcfdvxtmpji42Hyseq
         jedVnTMQwHyv+pRHyNDPeMsQcIHTBcJcNK7iyQE+EduIL0yar7W4Qp9j+8XIXbwJAXdc
         +Bkm9uAXmKs39yjiVDrluYD8m8vpArqDSJ3CnpWiX8MGtN38t4Y7u59uLzvImZI/7pQj
         XNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539819; x=1720144619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rXu+MXt4nFz4+flazvlrCn2aWVXo+v8foPD0eFjHBc=;
        b=BJN74dH61ITvVFYrAaEIbKB/SysJ6PMZrI+tzZigavvQ64BovwUvRj9q4WGX6TmEWa
         +tqDruZxRooH6vCCMqqygI0nGmqbJ8squYpRbZUcxehBhekQJfI0XKYQar1Wx5A9Y+cY
         +A+0rHj4eUgqEvtRQfDiFAtyIWF9G66J63zBJXvPEotvmdhnLJpYpqTEvUJ2/slhXf17
         aqFembLceldskavnD9b6BNrknqUwiDfBtzzTt7j0k0TBmemLFncQXQ06GmlfLiCFBxCa
         0axEiNLB5JUj6rhgZYqd0WoQY3+Vue1I2hyJ4yGV3L6YUwI4HHuRK4q7VbRZPQ2YJ1eH
         Dj0w==
X-Gm-Message-State: AOJu0YwN85TkTA9YqMWmsN4h6rEhUuuCPmp608AAVlemElMeLw8DCpHb
	3nnAwRedTXu5Z+HZH+kfjYN7SVCT0YLbOfV9zwmGfFg4TpQXYCxm
X-Google-Smtp-Source: AGHT+IFkQM8KmFZGNYnau/fjMVym/+bjqeHh/Jqc4a3HxQ3K0Otu1oVwjWR/lD65c9pEVCQOs+JeNg==
X-Received: by 2002:a05:690c:845:b0:631:2740:3882 with SMTP id 00721157ae682-643ace05438mr125141317b3.51.1719539818557;
        Thu, 27 Jun 2024 18:56:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a803704sm1695267b3.64.2024.06.27.18.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 18:56:58 -0700 (PDT)
Message-ID: <321be5c1-dfb9-485c-ab5f-0c8c64971ec8@gmail.com>
Date: Thu, 27 Jun 2024 21:56:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry
 logic
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
 <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
 <CABPp-BFzxOjGto+1GGk1xq3XX7OQ3mmmRYm0zU+2mCYZ6h_OfQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFzxOjGto+1GGk1xq3XX7OQ3mmmRYm0zU+2mCYZ6h_OfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 8:31 PM, Elijah Newren wrote:
> On Wed, Jun 26, 2024 at 7:29 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
> [...]
>> If users are having trouble with the performance of this operation and
>> don't care about paths outside of the sparse-checkout, they can disable
>> them using the sparse.expectFilesOutsideOfPatterns config option
>> introduced in ecc7c8841d (repo_read_index: add config to expect files
>> outside sparse patterns, 2022-02-25).
> 
> So, I had some heartburn with this paragraph when reading v1, but
> decided to focus on other stuff.  But it still really bugs me while
> reading v2.  So...

Thanks for bringing this up with the details I've omitted from the
context of my response.

> Could we omit this paragraph, or if you want to keep it, reword it in
> some way that doesn't make it look like some tradeoff that isn't that
> big of a deal for non-specialized-vfs users?

Makes sense to delete the paragraph. I could ship a v3, or is this
a commit-message surgery you'd be willing to do on my behalf, Junio?

Thanks,
-Stolee
