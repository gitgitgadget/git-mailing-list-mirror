Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8920281358
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893042; cv=none; b=u/mtb5+6/sw6hHZbAMEbFA+aIo3lRDbP7R/fcI9b1nxsHB4NnPk8pK4/wZ0E2DAXSKZsngcV1BpZRoZuJ6JOlIf8Cdov/df2W84563QnDNW/aq5ewEuAPyF740RAiTIcrHUvnxgr6RHmWoo2s7kKiSuT3tc3ZYkfKVG9C4TgG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893042; c=relaxed/simple;
	bh=vrWWtFRwjCi1rhHKk2TdJwKxahzlrw9B2nzir4JL5c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uab9vjdhQDmSRfbpxAquZSNel4aLouexUzk6y2QI/BV/+R+e91OEq7etg6xAfaDaJ08Hfa3CzmXT6zAEqJQxOXjV6iplKmnpMq0kDvnlJFZFX/48cneVFAf7g3WERFZj7h7uiy7FpOw+P15OJJg9V9zbJUOOGeyNHLE/lNVSsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDyBYX0x; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDyBYX0x"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso72739375e9.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770893039; x=1771497839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LxUY7K99je2Y4PuLqvZCVa3b9H2t/7THj/aOM7AugDo=;
        b=DDyBYX0xDFiJxVB4g9gM2EDpL/s0Bx5jKQPxr3zf5fNL+HfnHKYsZKvtkly9Cai75W
         dSztup7sPMYD3bMB5AaHx+uxqU7xZaSGUMgrU66VBXeWYPqMV6/bydQl1VVVj2Vzufhs
         aqdtJlIreR3hOAChcEzuU/GCvx6Z1oF5aZrAernowAVujiXd7X3D+sxIdX32tyrhhW8H
         3TOJx6J65BIlDpan5IsRF7zeg6bIXNTDT0XdeVqbBOFECD5usPKRlKKzO+HwVWjeCs+P
         jIz3QEoI4ZqisJM5Gd+bLp2aRjJPosWXktMUMdZCNq8/J40ISHOO5+k9/K+bhzPBGEwO
         Dpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770893039; x=1771497839;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxUY7K99je2Y4PuLqvZCVa3b9H2t/7THj/aOM7AugDo=;
        b=VglgiPYKLvkLAYbpD3WdOlAP6HsKh9QDCEcHHGAJ9ImHqi3eZD3T/qOgf4oScSp/ZH
         dstKVn75Z2w+/33Fgp6vEPqQ1ifiZRajTvgsTE0jYtAV2UF8ZRGxTuozGx+/XVd1KzvL
         BeLoE83lshdXZ3guqnKIIRrRYpQlgGgjHFFEwNcXB8vlHkRBcHC+/lzHKyyl5Gg+zn3i
         IEOBjB/YJIMm+iTiG15089ZrjbL9ytJ6ItgJlZhMiX+Q3+f3O+IQK+jYujXmdRjwIBq0
         yJib1l8mUln4gqSOE33EHQgKyAHTzlSGvItrvWIaDcIOfeW8iYQD7yO5jsQYE8q29Hyx
         nh0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+bsXMnewSeKw8fKY7bni0CGjFTNdfNAJF7SbqdhG8iPAvKcn9YwQM56r9RxkPbPEWU8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkgdpytbQ79Z5Y2XUtxi05j8ceNrsgCnqsLTRu/yYy8j+JS8l
	e8GBZp7TnVi0nQnxKF+/dxnG5/Uo/GBedaVbA+o3zpVJnnP8iQyr5b8a
X-Gm-Gg: AZuq6aIqLZExvcd/KVSYpRARyIOLI2HbYyBEuRIOqSyQPdyPfkUP5+GM6BPne/vxvwQ
	9I/X8QSgNra2mhDscR4y4oVrsLcX1cNmFTLTG7Yz7kGHUHK/EAWJShDqLN5D0NaUicDZSmX6OXD
	rhBbDpeHMnEO0HKBErvKpT80kCTXNrjXiXRDUkdKUM+Vo0xqa5XqjnO1K5LsreONd9DLYJI+Eza
	t8aPodVeSijLwmKh4HW6/R+dEF1AFMA55SrhyOQrMnMzDi7N7uzA+/+Age711h8b1pSHznAmxDn
	ad8FVoQj4Ap+FdNGicuEevsDS4sP9eLHl4JBypX9YmmXP3I5TWkPmVYY4PIYclCDZOQYIlO9JvP
	6L3W13wFkCXKQz4HpmNHQGYmZ9j1ojG9lTCtNQpMMqow8fTP3OVPSpn5GcixVDiasbmLBZDJS/X
	rILkwXL62mj9xHSonprBueEBzYK/bRrtgX5No6zcnexhjWZToZQkHdKcTCwIBNXF4O2yJoHbHM9
	ZA1Ww==
X-Received: by 2002:a05:600c:4e91:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4836571fdd4mr33638135e9.35.1770893039014;
        Thu, 12 Feb 2026 02:43:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e15bsm90107475e9.13.2026.02.12.02.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:43:58 -0800 (PST)
Message-ID: <eedde9c3-2aff-433b-9dc3-f8593d53dec0@gmail.com>
Date: Thu, 12 Feb 2026 10:43:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] Run hooks in parallel
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian

On 04/02/2026 17:33, Adrian Ratiu wrote:
> Hello everyone,
> 
> This enables running hook commands in parallel and is based on the patch
> series enabling config hooks [1], which added the ability to run a list
> of hooks for each hook event.
> 
> For context, hooks used to run sequentially due to hardcoded .jobs == 1
> in hook.c, leading to .processes == 1 in run-command.c. We're removing
> that restriction for hooks known to be safe to parallelize.
> 
> The parallelism enabled here is to run multiple hook commands/scripts
> in parallel for a single event, for example the pre-push event might
> trigger linters / spell checkers / unit tests to run at the same time.
> 
> Another kind of parallelism is to split the hook input to multiple
> child processes, running the same command in parallel on subsets of
> the hook input. This series does not do that. It might be a future
> addition on top of this, since it's kind of a lower-level parallelism.

There's quite a lot of prior-art on parallelization from the various 
hook managers - is there anything we can learn from them? For example I 
know some of them serialize the pre-commit hook by default as it may 
update the index but allow the user to configure a subset of scripts 
that can be parallelized. They also allow for parallelization where 
different scripts update different files (e.g. code formatters for 
python and C can run in parallel). We don't need to implement all that 
now but we should design our config so that we can support it in the future.

> The pre-push hook is special because it is the only known hook to break
> backward compatibility when running in parallel, due to run-command
> collating its outputs via a pipe, so I added an extension for it.
> Users can opt-in to this extension with a runtime config.

In the past we had a regression report [1] when the pre-commit hook 
stopped having access to the terminal. I've not been following the hook 
changes, is this series (or any of your preparatory series) in danger of 
reintroducing that regression?

Thanks for working on this - both config based hooks and parallel 
execution are really nice improvements.

Phillip

[1] https://lore.kernel.org/git/xmqqr15rr9k6.fsf@gitster.g/

> Suggestions for alternative solutions to the extension are welcome.
> 
> Again, this is based on the latest v1 config hooks series [1] which
> has not yet landed in next or master.
> 
> Branch pushed to GitHub containing all dependency patches: [2]
> Successful CI run: [3]
> 
> Many thanks to all who contributed to this effort up to now, including
> Emily, AEvar, Junio, Patrick, Peff and many others.
> 
> Thank you,
> Adrian
> 
> 1: https://lore.kernel.org/git/20260204165126.1548805-1-adrian.ratiu@collabora.com/T/#mdb138a39d332f234bc9068b7f4e05b10c400e572
> 2: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/parallel-hooks-v1
> 3: https://github.com/10ne1/git/actions/runs/21680184456
> 
> Adrian Ratiu (3):
>    config: add a repo_config_get_uint() helper
>    hook: introduce extensions.hookStdoutToStderr
>    hook: allow runtime enabling extensions.hookStdoutToStderr
> 
> Emily Shaffer (1):
>    hook: allow parallel hook execution
> 
>   Documentation/config/extensions.adoc |  15 ++
>   Documentation/config/hook.adoc       |  14 ++
>   Documentation/git-hook.adoc          |  14 +-
>   builtin/am.c                         |  10 +-
>   builtin/checkout.c                   |  13 +-
>   builtin/clone.c                      |   6 +-
>   builtin/hook.c                       |   7 +-
>   builtin/receive-pack.c               |   9 +-
>   builtin/worktree.c                   |   2 +-
>   commit.c                             |   2 +-
>   config.c                             |  28 +++
>   config.h                             |  13 ++
>   hook.c                               |  51 ++++-
>   hook.h                               |  20 +-
>   parse.c                              |   9 +
>   parse.h                              |   1 +
>   refs.c                               |   2 +-
>   repository.c                         |   1 +
>   repository.h                         |   1 +
>   sequencer.c                          |   4 +-
>   setup.c                              |  17 ++
>   setup.h                              |   1 +
>   t/t1800-hook.sh                      | 270 ++++++++++++++++++++++++++-
>   transport.c                          |   9 +-
>   24 files changed, 476 insertions(+), 43 deletions(-)
> 

