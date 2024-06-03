Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A583A06
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407002; cv=none; b=YZGSVpzb2qyHzcSvX7G6e2htuo3GA5Tb7V4ogF9t6qICts62B6W1V6UDfwrSAizhV/BSmznNLdogJL+7Vu3abqS4kiJYqo6CsSMyn1YPez9BHpH8b32uW4UgL80CsXWodUwxl54ldRVRfEsTKCUy+v5ErpqLQAcPyk0gYMRzdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407002; c=relaxed/simple;
	bh=xPJ8Z9MImQdPbzpKBWKpkga3P906zKK6tQ56h58BvU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9kFa+frqGM4BVz0TlvYoSRy7p177Wc9IUCNDQuoId1szJhzdzLrjlpuGqKrfGdZp8jtcnG5+2FYtFv3W5f7hOXwdjiLSKBff5l9n9kK5JJtGDISBp6woLEvHoDAE2YK6xyNWdsTseO9evKIWdatgVuzbiGLVyiM/ykOEDY75Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCn9gRo9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCn9gRo9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a080a171dso27414727b3.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717407000; x=1718011800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KqCXGskhMK8tWGn4JkijtnKtzrKxezeV/9R+M1o1FRM=;
        b=kCn9gRo9ltnvGTXEMxh5I180GHHScQXYDUIvVWRfhDhXHOqwv4wNrNeEE8NxMBG0jM
         2r9HwUMXEIMnro1ZpE0M9tqtTtv1EQpUWsRxZvy7BQVaNRGfEjodJjsN4JyYTPto6obN
         ahERe2UnXJkneYyIBhcV3AYGZRNB8+/to+uyAgsIM/VqMNiO0SZFAHDJah16iCUMJol8
         PdtdNuo2mGrekvagr2yNasQOVuUZL66r4eNNL4zuja20Um/5tzXe4UpMBb/Lc0YFfihw
         kUOQ5q9u52KionI2nPQFXjCtVx227l1u/+e0v5Y2TEf8KgUN/2kNZymjS6QGXxY5dJi1
         418Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407000; x=1718011800;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqCXGskhMK8tWGn4JkijtnKtzrKxezeV/9R+M1o1FRM=;
        b=BoYZV9sqlO/JNUTM1khllyDVBNZD1P/J7nk1XkQg1jVoMdqYisIfZRUxvOhNfsU5kB
         DJl1p6iowP3815FM5qk6N7gLxVhwO8AgTkw0uzuIqHlSG8BX/FLJs1zTFag1GIXafsER
         t0rw70j2RhuGZmOe1p3PioQcHJbkq+NW6lOLPQaHSv6KyMyCqBF9rZEghWSepKQq214T
         fLgsEOt8cZMCnfI9mX5tkuUcPGMyFE/hgXTIaIguAktQyZBS4GJbVxUQV/E2aLJpqYEg
         R91RmXhcX8Po54ApOFOIt8fcgSnQNOiy+MTzsMMicyAFQRSF0pi9RI5PR9hdpDE4uc9Q
         qPmA==
X-Gm-Message-State: AOJu0Yxg7Y25CWtNfmyiA6tPFv7dWFcsEhKvmuPI4YiVpBA9Gh8jj8Pn
	HxGSaoJNgwEdGku2UOZNDtXjHDevCG6DJ2HpBBjDkomFOxasQJKx
X-Google-Smtp-Source: AGHT+IHHaLClQ1Ix56c+k7YIJ7KnE9Oo0JHKeai4L++4TacpJY3gYua/BjB8+UOWwMiETWX0ksEu0w==
X-Received: by 2002:a05:690c:80e:b0:627:ecd3:6223 with SMTP id 00721157ae682-62c797d52aemr84832027b3.35.1717406999897;
        Mon, 03 Jun 2024 02:29:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766b3362sm12630367b3.122.2024.06.03.02.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:29:59 -0700 (PDT)
Message-ID: <e0ea930f-3d43-49de-b2e7-c057d95fd7cc@gmail.com>
Date: Mon, 3 Jun 2024 10:29:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [bug report] git diff --relative not doing well with worktree in
 hooks
To: Eric Sunshine <sunshine@sunshineco.com>,
 Antoine Bolvy <antoine.bolvy@gmail.com>
Cc: git@vger.kernel.org
References: <CADg0FA_9shzJKN=dBfnavu5eTDNhbz=g0WP2sehAjSqHP4WFkA@mail.gmail.com>
 <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cT1pTkKd1A0o_qjP+Oyx+zyCevV8EAg5Ub9guAyd3UjgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eric

On 31/05/2024 22:42, Eric Sunshine wrote:
> On Fri, May 31, 2024 at 7:38 AM Antoine Bolvy <antoine.bolvy@gmail.com> wrote:
>> The path is no longer show relative. This causes issues with more complex
>> scripts.
> 
> I'm not sure there's a satisfactory resolution here. Your hook is
> running afoul of the environment variables Git sets up when the hook
> is run outside of the "main" worktree.
> [...] 
> The relevant portion from the "githooks" manual page is:
> 
>      Environment variables, such as GIT_DIR, GIT_WORK_TREE, etc., are
>      exported so that Git commands run by the hook can correctly locate
>      the repository. If your hook needs to invoke Git commands in a
>      foreign repository or in a different working tree of the same
>      repository, then it should clear these environment variables so
>      they do not interfere with Git operations at the foreign
>      location. For example:

Maybe I'm missing something but in Antonine's example the hook is being 
run in the same worktree as the "git commit" - we're changing into a 
subdirectory of the worktree, not changing to a different worktree so 
why doesn't it work?

Best Wishes

Phillip
