Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1A10957
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743727212; cv=none; b=PdzZCgh3otXsc443tZXPQbLp3xAnE5gb72RNT6n3+2/yyMz57v5HKRb50TL0pSYFsqktnuX3OqG56XKIyTOjyqZatYFxBacuNTQ7NLS3BGYQaotn49iGvUqyvLgH7z/c7t1SmZp5zRKTDTm7g5s5wdwCj2jXv+GU9OW0BXG4UnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743727212; c=relaxed/simple;
	bh=qoJcTP5//DWWc+8/Jn42jMpB+JeBL/h/GNywxBO1D4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S2WMupHbpMAWf+/e/DylXl2AnWxQXBV8oIqW51rr62gE9PJ1oTTwLDlQocc8YJ8RLuUXliZT6jfBl58w+DrD76bAgR6mQAyszlnaifseX6/0X3KZp5TqCIQiBVKKcorNRrEO55dObNH5SH9iOIYJpQUrDSWji3dL3IpSqSihuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eafRoCpj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eafRoCpj"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6feb229b716so15678707b3.3
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743727209; x=1744332009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Drdd/xp8ZeY7fU315kq40Vc157fhS7veLn8pxl0krlE=;
        b=eafRoCpjkILIyuJ/84cCalfHcdYp4jiTcn9lx87BgQKKmAQkmNyrO7OLxXVy1zkYEr
         RS2WTGPBsWUjXy1Z8/3mJb2eRH16Ka8jWq/7u5okW6TtQDdy1VmWxk4k9F2sFyHq3CZ5
         nusG+VGVang36prjplZWiN5/aCeEh3k2fB8+oBmU2FydP67hi2mi+AfSnRDU6hbOqKVz
         Th+NDIK3IbJKWzgiwa0w4am8tlecRhJbYb+HnOwSwPRhcrlYsYgLc0L8B5nxpHqPhqL9
         ghvLMAP+baCtKmXweNZI0x7Nhj28KupXGsl8WBOmJ6MiNfHn1UrPBFB600aJCyccPPdY
         2dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743727209; x=1744332009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Drdd/xp8ZeY7fU315kq40Vc157fhS7veLn8pxl0krlE=;
        b=TSjrN/G0C/uxSCxeZOFe5QXgeKfc8ezVuQNYIYk/dCTFfo2bTyfV02HRA2PT1YsaNX
         lOuholYBJq/CZoEd/yKrskhhe586K+yVfDB8G6YsH3WS2M/sYmpMqhFn7W1OUqyC7caI
         WLbCEAo+27hJjoqbq0e8M+KFtSAnM4Bfnu+tCmWVDA/zY1aigEfiaUq8QZXAavW3CFfd
         CUdqJDFESN3Ty6IWZCnKpQMvumRSIYmZi1eaNL8Y2iKSVD8oeM3fa8AxrJCZr8HoDVJX
         1xA+RRRyGLRAWulnoVDziuVL+zLIkKQQLFP/SVo7CA9PDU2zwUhZ39715OXFbTUXRrAQ
         K1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVx0QxdXXVeZKHjXsnHm2PRDfSORTyQqw2f1+t0G8uwwEMhkfR9BuIWShVPkLz/bsET468=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEinVuHMHkKPp0sYCz4TcJL/aA2sk8zXunIdWbQnwzjBr7V5bZ
	2LLSp2MXma5Z2151tLvFqCjjQqO3hbXwzj3dbBVuRXfARPSjPtEVM6JXhQ==
X-Gm-Gg: ASbGncsIfiwaY7+XBQI3dBO6qv2WtBvXUgxaXESeZX5vXJM0zFUjpdaXAGvMdJ+83Bk
	77dASl1naS1bs4Cd7PtcOhp7RQ7lkBJs5NTvk66PvKszDbIYoix4X60Nd96vBCYq2n8NqzwE8U2
	GhjKhrmme2Mhh8GIv1n8B5zWprB0V7NKIAXybnKWqzZ5KUxYhT31RnQGTdpqfXeU2OED0XGevug
	9IUD5+6HO7aSXIEcuTRaaFEb8Y0/LRM0ZrtjGkvqPVCPtqQBx7E7B7ltHHgaGctQ+m23sYpYmWP
	iZAXv7K7m4+LKg9gd5V/X7ukYBWBOmb3JoJseZisdO1MWH6HSq3Hf72tqwnMEAChW9z9flF+Ibl
	VHj9IVUB0UmAguEBqSOpo
X-Google-Smtp-Source: AGHT+IG09amxoO0EKFmME4KaMYUyRmHXf6JunV2XrwFuPGTrJSsMDm1NsAkqz+BnIwLtliNeZWFzWA==
X-Received: by 2002:a05:690c:6c13:b0:6ff:1fac:c4f2 with SMTP id 00721157ae682-703e1663de2mr25005797b3.33.1743727208796;
        Thu, 03 Apr 2025 17:40:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:4897:35e1:a617:6e11? ([2600:1700:60ba:9810:4897:35e1:a617:6e11])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1f78eaesm6232567b3.70.2025.04.03.17.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 17:40:08 -0700 (PDT)
Message-ID: <c1312cb3-dd2b-4b04-8c6f-2d787125448d@gmail.com>
Date: Thu, 3 Apr 2025 20:40:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git: add --no-hooks global option
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <Z-8Rxy4IK5EHKzLW@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z-8Rxy4IK5EHKzLW@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/2025 6:55 PM, brian m. carlson wrote:
> On 2025-04-03 at 22:38:08, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> To that end, add a new --no-hooks global option to allow users to
>> disable hooks quickly. This option is modeled similarly to the
>> --no-advice option in b79deeb554 (advice: add --no-advice global option,
>> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
>> to subprocesses as well as making this a backwards-compatible way for
>> tools to signal that they want to disable hooks.
>>
>> The critical piece is that all hooks pass through run_hooks_opt() where
>> a static int will evaluate the environment variable and store that the
>> variable is initialized for faster repeated runs.

>>     This is hopefully a helpful feature to more than just the experts I've
>>     been hearing from.
> 
> I think this is functionality that Jenkins wants because they've
> configured `core.hooksPath` to `/dev/null`, allegedly for security
> reasons.  Of course, enabling this feature will also break Git LFS, but
> in a less noticeable and detectable way (currently, Git LFS will fail on
> attempting to install hooks with that setting of `core.hooksPath`, which
> is at least noticeable).

I agree that some hooks are necessary for certain repositories to keep
their data consistent. Another example is the pre- and post-command hooks
that are in the microsoft/git fork that are necessary to avoid issues with
the virtualization layer of VFS for Git. If a user disables those hooks
during a command that changes the index, then they are going to have a bad
time. But maybe they want to disable hooks because all they need is a
'git rev-parse HEAD' or similarly read-only operation. 
> I do think that in general certain types of hooks, such as pre-commit
> hooks, should absolutely be optional.  There are lots of reasons to
> commit WIP data that doesn't meet whatever standard and we shouldn't
> impede expert users from expert workflows, even if there are many fewer
> reasons to do things like bypass pushing Git LFS objects (which are
> important for integrity).

My intention is definitely more on the side of these optional hooks. 
> So I can see the utility of this feature but I can also see how it can
> break lots of things when handled poorly.  Of course, we also have `git
> reset --hard` and there's lots of hand-wringing on Stack Overflow about
> having deleted important data, so we have some precedent for expert
> features that could break things badly.
> 
> I don't otherwise have a strong opinion either way, although I'd lean
> slightly in favour of this series.  I'd of course welcome other people's
> thoughts here.
Thank you for chiming in! I look forward to other thoughts and whetherthe warning in the docs should be strengthened.

Thanks,
-Stolee

