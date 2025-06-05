Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54142770E2
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138368; cv=none; b=ShWaIM+TP2MfhuLOwNMKrOtQAdeLuJAOkDzxlSbeVhP7zZ4S+SyGkGcwSzYqsPhlI4xGMIAxaGnZsAi6r4q7oHsP22tt88zpLcjFSd5z+iIP7TKkQPcTEOq3AG+NdnVElbddepwEnIUEh0j2KD1YuXvGcXpUaea50XHZIETvnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138368; c=relaxed/simple;
	bh=bxzH6vsZtQY7JbybjjQj0Dtvu5SisfCzOP7v4sQXsYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdTQuTd48UhplO0Lso5v7bbiPi7KF6z17baR44uEwSC3VuE22yTp0oIKHUIihRn6KSndU/OjK1CrOsdmvp2TegSNyU+A6hbwWLYYLUNd9jutq0aIy4VpsigA1apVG95TvBC72Fk39ZDnYbbTmTHfeUx+qSi4ipnpEjNBZPdUvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffQjzXnH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffQjzXnH"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-708d90aa8f9so11638677b3.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749138366; x=1749743166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8uC0Q33DMYA8MRieePp+Zck7eu2i9Ka9vvxLE9fi/w=;
        b=ffQjzXnH+q5vUvwYrIosHkVPMerZ7mm0RYeRapODvtqoJ+yRamF6FVya+V4zwrrsuL
         2/bTYEj30G6Qcx4/rAXgPWqfLmQo8FwVf8VIdfPrzZZgwF1R9KtqmBc2pX6/9IVWBcsE
         ogY3qaQV9gL4lnq9kQOwg3LBobxLM1HCaonOGhH0Sn6fC6s8a6Pn/YVMwY6FVnumsUmA
         0/h7CsWJ7JydhaMysYpjQD6vNROnIA560u5yXYJgTraASvlV4geyKlCuIjzHoOfOf6A+
         szNB54gM+ACoXDTeMXeFEGVyRwtGdAsHJlG7lK/Sh6X2hikt6m9Crg4XNvBqQlrtIjTl
         pqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749138366; x=1749743166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8uC0Q33DMYA8MRieePp+Zck7eu2i9Ka9vvxLE9fi/w=;
        b=dxax+8NqONaU2YWa3pSX6DhGYBPUgx611lpENtHEevqhtzD0AbNsRRS/2UGDtvgDzV
         BuguPl4GgQACuvyCGx1A7GRmE7tyKkSplxPXdIRtCV7pbjKB28xd0JGwRXjD+bBU4ybt
         jXLHwXVSc5VO4W4FvhETsD69nAohqLEgueoIAJjaHftGNRcXGAIExKFVecxqIGwIvwbT
         ShVj3ZXMmBvRrWa7iUF3BiMf5Ep0DcQImn6wN3xduMZtFNRcm7x+8rH80nv+CgCr7eoy
         IcMBoZX3ZE+WVWs91GXHV3W6cInQx3ootLk9d5gIbG/D6g/XHqKLH+iTlu9JPtbBAKQ0
         22fw==
X-Forwarded-Encrypted: i=1; AJvYcCXdzyAgZspP1mhyKP5iuNsUJrN8wF42qyvP+oeFM5h+aTXu0M+RnV3wUUDSYwD8WYbYWm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCoFvFY8Hs/VDTKh1zm237c/jDArIg4lvRHdznyBMv1c0VA1G
	eZAW3QWXzS7L8Ie1oYUAI1b04TRPTiUNxGVcQEV2Q1c1xyz7SXZdzYad
X-Gm-Gg: ASbGncvbSoRnpWgYXQRzLBQIqb1BSmd4/3dPDE1LHoZCudBhoe1TOW/5oLov+bRrC/i
	AsNFv8Z3bXyyaTv16LIOLuYIcqXLZZx83Z/JyLARw4uJ55Fxbp6jR91iW4PbWH8cuVIjrivkiiM
	Lud7DATK7PR6rueaobO6+/+PMLVpQHPuaizf/hSUjgPbuDgalEG4UmDSKbqaQxFejYkb4rZ4f49
	qUZ9Ep0vNBgfeO3mYWUXRVmkEZvNzSYV0rNq+VIY5PqOsoL9KGJopW+FYZwL6BIhBNT4KrddNu2
	VZJOSg9R6uauu7SBHO6z/IIKcmNWWABvjcmnxvgiwRKKtlKQ4RENp9wvQJ/Pq5Hh2u9a4C/lUB0
	zW96CFX72z8SkOIQxH5e51VNhQ/BekgfcL5j3kA==
X-Google-Smtp-Source: AGHT+IEKq4CzlIe3VcfMA9OPuvtNaDvf9OGJAvoFQyP1KbCmvr4mI0pwUWLfrOyC430vlcG6vXsx9A==
X-Received: by 2002:a05:690c:ed4:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-710f1a92246mr20923227b3.3.1749138366165;
        Thu, 05 Jun 2025 08:46:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b0b8:1731:c2b2:54d2? ([2600:1700:60ba:9810:b0b8:1731:c2b2:54d2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710de73be23sm7165517b3.43.2025.06.05.08.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:46:05 -0700 (PDT)
Message-ID: <45805f9d-d59b-46ba-a5d6-040ee60e189b@gmail.com>
Date: Thu, 5 Jun 2025 11:46:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf
 <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Ben Knoble
 <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
 <20250603-b4-pks-maintenance-ref-lock-race-v4-4-52f5cf7b7e99@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-4-52f5cf7b7e99@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/2025 10:01 AM, Patrick Steinhardt wrote:
> The "--task=" option explicitly allows the user to say which maintenance
> tasks should be run, whereas "--schedule=" only respects the maintenance
> strategy configured for a specific repository. As such, it is not
> sensible to accept both options at the same time.
> 
> Mark them as incompatible with one another. While at it, also convert
> the existing logic that marks "--auto" and "--schedule=" as incompatible
> to use `die_for_incompatible_opt2()`.

This is a good change. Please consider squashing in this change to the
documentation to match this expectation:

--- >8 ---

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 931f3e02e85..a901c46ce0e 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -193,6 +193,8 @@ OPTIONS
 	config value. The tasks that are tested are those provided by
 	the `--task=<task>` option(s) or those with
 	`maintenance.<task>.enabled` set to true.
++
+The `--schedule` option cannot be used with the `--task` option.
 
 --quiet::
 	Do not report progress or other information over `stderr`.
@@ -203,6 +205,8 @@ OPTIONS
 	arguments are specified, then only the tasks with
 	`maintenance.<task>.enabled` configured as `true` are considered.
 	See the 'TASKS' section for the list of accepted `<task>` values.
++
+The `--task` option cannot be used with the `--schedule` option.
 
 --scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
 	When combined with the `start` subcommand, specify the scheduler

