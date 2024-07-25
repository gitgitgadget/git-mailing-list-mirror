Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B317588
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925682; cv=none; b=iFE3B/k4Rvp8L6KS+bmYVvV3wd5tBWfWto5990xQjSiq76tb2iBIFSUiDlNXprRfn1zUHmdNHOVJ9n8bmipH3UySiSlvaXUn8TvqUgSUu8wCuIus2mhKLE5XwvhqShChN3LUfF+Im69J9GphBZNgmh6mrgF69y8FgrAe3CKjVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925682; c=relaxed/simple;
	bh=+yb1mAb1QV/WFsePx5KkMmuSYw2TnTjjWraanmsE7eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLdR9j7qS1G+3voM0Mfwd03Xi59aJTLYgzv/RMRlCZz0jnU4mt7n7jhumBB2wAwpjn7Hx7lFA1LfXP223x5pHlR5KSI/Ct3TOFAXjEaqYic+AYnLMxjxTKUdyJziJyluA/+bfFIwOAhePIRT5dr0NYEopBEp1EPuL9P8b6njz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR5aqroT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR5aqroT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36858357bb7so659589f8f.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721925679; x=1722530479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuRKbBHe99m2fHrBoCCDj2K50n0rhcouhy8e/au+WEs=;
        b=kR5aqroTcNtTm6BOpwxsPmAh9WEmlUfJtVSdhpIGxz44zlOBFvbOLRfrom9NTy2kYS
         GzyYw9wc+BepLW4V5cQ2r13xqS3Njux/c5qovMGm4//0zgXHMVFy08IqSm+b5snUpde5
         B/3yIAN+vf/fFg5QO/Md3mLAaMqRHEAoJgWtXD1vC+aGG4aVp7pgT54t5fS/aMa/mS4+
         aBLYNH34LkVTNkGkWd1fQhb7gjldw7xGvEATDbqYGCsSuMJ7a7sVld+vutulw6AlRkri
         sdo/omn/dQ/wl+xxutnTbahyjnWZd3wSKhF7bSLqwySkGDJPYIkjdVR65iRwuFE5pMj2
         U+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721925679; x=1722530479;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuRKbBHe99m2fHrBoCCDj2K50n0rhcouhy8e/au+WEs=;
        b=aDD5gdXWsCxUF/caCi2GER0gBjcec3nfPwktvCZ3uaZ/CiloBojBF8Kj3Dl1ShA9Wp
         eSp71QHX2BtKXPfPEs/SgJjhXLWx1zvpBGLDVsuAbdFqEguxiAsNHsUKGm6HnsCiDQ5V
         eFX0MsqSnApSR2PDYrEKgcIxWrqnLE35ybw4gzkhZd23bU03HR0DxNcWVGOwhGa2QCtk
         ED5awMFYipEXkPydyuc1gVUwIuJxC0Q06LCuM4wBFZHAyfsXqOTYF/iu6iQNhbpwxiMx
         hb59oEY+JgOY1UTwCcYlLLyTvlW7jjI3JKaEp99y5Z4ZWjfFD2Us3kxhLEO6b/K/KXZn
         Ylyw==
X-Forwarded-Encrypted: i=1; AJvYcCX/JXAgTpMCh2ILnqDN8KUODWL8bVJzE6I6zH3nm80WF4+rmQcuUKRiIlU2/uvyTqRHjihuKknfzITYseVhuorXay5P
X-Gm-Message-State: AOJu0YzggKJa66affU4yfcYkpi8Dc8Flxsib7wA4S2sTlkYmQjnN2sbN
	JUn5sFacsGX+rmgEAbht0Zu2QM+xIlOJ2Aku9XdKbwhGmOjq8sS1UuiOfw==
X-Google-Smtp-Source: AGHT+IExWT6wAq9xuA1LCIIIjm5zJERLK9tDG+NifXI7D4sV+YNg93gF8b78ADII8861z/YxbhKQbQ==
X-Received: by 2002:adf:f383:0:b0:368:31c7:19dd with SMTP id ffacd0b85a97d-36b319d0aedmr2516913f8f.5.1721925679067;
        Thu, 25 Jul 2024 09:41:19 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857eb7sm2747932f8f.66.2024.07.25.09.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:41:18 -0700 (PDT)
Message-ID: <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
Date: Thu, 25 Jul 2024 18:41:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re* [PATCH v2 0/2] add-p P fixups
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyn1lcjo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/24 5:24 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... We
>> can add a comment about the dash problem to the commit message when
>> this fixup is squashed. Also the problem is now documented in
>> Documentation/CodingGuidelines which is more likely to be read by
>> other contributors.
> 
> That is a good thing to take into consideration, indeed.

Rubén Justo (2):
  pager: introduce wait_for_pager
  add-patch: render hunks through the pager

 add-patch.c                | 18 ++++++++++++---
 pager.c                    | 46 +++++++++++++++++++++++++++++++++-----
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 32 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 9 deletions(-)

Range-diff:
1:  b29c59e3d2 ! 1:  8a6116ef86 pager: introduce wait_for_pager
    @@ Commit message
         In the interactive commands (i.e.: add -p) we want to use the pager for
         some output, while maintaining the interaction with the user.
     
    -    Modify the pager machinery so that we can use setup_pager and, once
    +    Modify the pager machinery so that we can use `setup_pager()` and, once
         we've finished sending the desired output for the pager, wait for the
    -    pager termination using a new function wait_for_pager.   Make this
    +    pager termination using a new function `wait_for_pager()`.  Make this
         function reset the pager machinery before returning.
     
    +    One specific point to note is that we avoid forking the pager in
    +    `setup_pager()` if the configured pager is an empty string [*1*] or
    +    simply "cat" [*2*].  In these cases, `setup_pager()` does nothing and
    +    therefore `wait_for_pager()` should not be called.
    +
    +    We could modify `setup_pager()` to return an indication of these
    +    situations, so we could avoid calling `wait_for_pager()`.
    +
    +    However, let's avoid transferring that responsibility to the caller and
    +    instead treat the call to `wait_for_pager()` as a no-op when we know we
    +    haven't forked the pager.
    +
    +       1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
    +                       2006-04-16)
    +
    +       2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)
    +
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## pager.c ##
     @@ pager.c: int pager_use_color = 1;
    @@ pager.c: static void wait_for_pager_atexit(void)
     +
     +void wait_for_pager(void)
     +{
    ++	if (old_fd1 == -1)
    ++		return;
    ++
     +	finish_pager();
     +	sigchain_pop_common();
     +	unsetenv("GIT_PAGER_IN_USE");
2:  6bc52a5543 ! 2:  980187854a add-patch: render hunks through the pager
    @@ Commit message
         few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
         this limit.
     
    +    For the tests, avoid the common construct to set and export one-shot
    +    variables within the scope of a command:
    +
    +        VAR=VAL command args
    +
    +    It happens that when "command" is a shell function that in turn executes
    +    a "command", the behavior with "VAR" varies depending on the shell:
    +
    +     ** Bash 5.2.21 **
    +
    +        $ f () { bash -c 'echo A=$A'; }
    +        $ A=1 f
    +        A=1
    +
    +     ** dash 0.5.12-9 **
    +
    +        $ f () { bash -c 'echo A=$A'; }
    +        $ A=1 f
    +        A=1
    +
    +     ** dash 0.5.10.2-6 **
    +
    +        $ f () { bash -c 'echo A=$A'; }
    +        $ A=1 f
    +        A=
    +
    +    POSIX explicitly says the effect of this construct is unspecified.
    +
    +    One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
    +    0.5.10.2-6, so avoid using the construct and use a subshell instead.
    +
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## add-patch.c ##
     @@
    @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
     +	test_when_finished "rm -f huge_file; git reset" &&
     +	printf "\n%2500000s" Y >huge_file &&
     +	git add -N huge_file &&
    -+	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
    ++	test_write_lines P q | (
    ++		GIT_PAGER="head -n 1" &&
    ++		export GIT_PAGER &&
    ++		test_terminal git add -p
    ++	)
     +'
     +
      test_expect_success 'split hunk "add -p (edit)"' '
3:  b7637a9f21 < -:  ---------- t3701: avoid one-shot export for shell functions
4:  4b53ff8c0e < -:  ---------- pager: make wait_for_pager a no-op for "cat"

base-commit: 506f457e489b2097e2d4fc5ceffd6e242502b2bd
-- 
2.46.0.rc0.4.g6f4990c0d4
