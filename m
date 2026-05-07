Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B76DCE1
	for <git@vger.kernel.org>; Thu,  7 May 2026 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778130561; cv=none; b=dZ6TMKtzXBImkZcHp6RV+e967ImT2ue9F5N4Lv51tgScPL4yX4RoqZfrGesZaHfcUa1/M6Ed66G41IPiN9EX54+UZCL4xnGyJb7ZeRvrlNvJ33q9YIx8ryPq6q4CFdEgXcBEqaCyA2TTg3VHsW75rgd9JwBylc5tJCgHr55egV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778130561; c=relaxed/simple;
	bh=rouzGQLIMLauum0n9EDqd1z27hMpXAcKsQYFxtdE/g8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TElz8216T3DE4N1ghsuI8hbIUC5nBCkptBkjC7tCItGTz5cBZY27xfmYgUTUw82Jkie19kfyX02j+PqZXZTIBQUG0xpzWfb6icjF5Q1VXYpHZ4iNWdU4LEj/D7hClEJKYbWCzH8Qs74cOTW/gPGnM96GaWvfPrHTF+oIXcpJ4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcAfaJBd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcAfaJBd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d560ede296so55323085a.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778130559; x=1778735359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rouzGQLIMLauum0n9EDqd1z27hMpXAcKsQYFxtdE/g8=;
        b=WcAfaJBdM+qQv9AVh0ssazek4WBya2Aq39JcZiBJ94xfSNz+hVcTKbiOjF8vqku04D
         K7ICNIkmMK5Vyl/Op7/NSkSTTs7XL2KY32zerqXtHlboRykEwgIIPEg5yqeV3IuUN8u3
         LuZx0DcdS2eEQEk/b9CKbj0bo89UmIO9GwxE15Uk1Q0xZTZS000VxIgj3eSFp/c0tNEN
         vtmt7ghonIg8V/IXL3ZA12HoC4zC7gWxPbRgxgt36U5I5Cp9EN9tkfVMXWuthKrwouSr
         Xch2Thy/aEZyGY7gGogB5uI5LLtUwtE63RYe6Nstc1PCuv/VLB77w20GREJNDVQ9fIrD
         jadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778130559; x=1778735359;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rouzGQLIMLauum0n9EDqd1z27hMpXAcKsQYFxtdE/g8=;
        b=TytwLqHhJxvJiJzO8wLpgaYWiDAsOGmcsYCgy7o9lz//hIWmRBtEurM6Ua2cDS1N5H
         w4c8+BXlzY4LJa8J7zSdlMB+Y8gLAF7qyZs6YRDrOlUdeSuxVBwlR9czENyE+2JJntai
         MmnnNAfeIKP4r7LP1VpQzVh5ID1rdc+UhSb/34NTwRHvmxZWPik7wSKOvnTpDxmuVuva
         xwumNhuUsAinrIP/KPh12v63j4WJYbtO56uo3VFIQubEcD2xw1AdBDYBbRGnrxS3ISRD
         T0hUkDsCxWJUWObEa2kVVqeLsCWCJ2aOpJuWI0Vjj7T8ugYssQsfdzV2pZv3zISd39iZ
         fmlQ==
X-Gm-Message-State: AOJu0YwOizPGEVFezKliQ3TKs4u/MWtSkLbpxWKAaoZR/WeE0tVjzrcV
	IwaVnrPwUJT4xD5oEBgg/1T0yqYnVm3xyijpK7TAmGh48BECeRNSupbV
X-Gm-Gg: AeBDiev3Jg8Q+Ybf0BDfCtWeaGqaUGJFeAYITF+bALhC3t4vXkjWn883RBfz4nNny0K
	GOaRTQ71e/y0u4ErE8ETcHK5N9dhYGRP5qAXsIorKEqX0wBKdnJlJsoe+IhyX24GUhS6AIcGxtx
	2AC4B/tTECHQN6VjyZHgkJb1OkDaKMJbYRK5IAbDTbv7jwqQDA4kg3KpCwcMKiGcFjpQ0hhGGLQ
	lSfespLi6oCiZHyhdhVnIMU8gK1OS0/ydRcpsnol7RbJL9yeys4+rT8iaZjwLhC7NuR7SomuijS
	aJr1OkWbfVdDu0E9wNgcIfgHnG/s25Ff6/8T5GXT5lcWhmXkqj5INh8eU4VHuuGynEEojPuDjNI
	KXD6rkakbxHzav7f7bjX0fDhTe/lCfGlS/39nfRbHWyav7NxCEac2uX250AUz/F/reFLeww2JJ2
	j1w9vxJzguvvR2yXcLILKH95oqugL7QbtC+X9u0sIZ7PVn
X-Received: by 2002:a05:620a:25c6:b0:8eb:3fa5:7aee with SMTP id af79cd13be357-904d6bd4152mr961531285a.52.1778130559008;
        Wed, 06 May 2026 22:09:19 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253e04sm1826570985a.31.2026.05.06.22.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 22:09:18 -0700 (PDT)
Message-ID: <2bfff1dc-e9f1-406a-9757-25a63761e32f@gmail.com>
Date: Thu, 7 May 2026 01:09:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
From: Mark Levedahl <mlevedahl@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
 <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
 <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
 <f6c7c3d5-1d68-45b5-87a7-ae19b59270f4@gmail.com>
 <9fecbb11-3cc5-4084-bc29-bd948962dca0@kdbg.org>
 <7a963eec-80d2-4605-8cb1-52fb7bc9cf8e@gmail.com>
Content-Language: en-US
In-Reply-To: <7a963eec-80d2-4605-8cb1-52fb7bc9cf8e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/26 10:05 AM, Mark Levedahl wrote:
>
> On 5/6/26 8:57 AM, Johannes Sixt wrote:
>> Am 06.05.26 um 13:27 schrieb Mark Levedahl:
>>> A git repository (gitdir) can have config.bare true | false | not set
>>> git rev-parse --is-bare-repository tells you that whatever gitdir is discovered from the
>>> current directory has core.bare==true. This happens whether the call is from inside the
>>> gitdir, or in the parent dir of a gitdir named '.git', or in a directory containing a
>>> symlink or a gitfile link to the gitdir. This call never tells you what directory you are
>>> actually in.
>> OK. But how does "find out which directory we are in" come into play
>> here? If we find a bare repository, we do not need a worktree. If we are
>> in a non-bare repository, we can find the worktree with `rev-parse
>> --show-toplevel`.
The influence of config variable core.bare in a git repository breaks the design I
contemplated using rev-parse --is-inside-work-tree. core.bare is a strange tri-state item,
usually only set if the repository is explicitly bare. With core.bare undefined, rev-parse
can give different answers inside and outside a gitdir. For instance
      rev-parse --is-bare-repository gives true inside a repository, and false outside,
--is-inside-work-tree is also influenced by core.bare, so results cannot be interpreted as
I initially thought.

Anyway, after some experiments, the minimal sufficient tests I find for blame|browser and
gui|citool are different:

- blame|browser need a readable gitdir, and do not need a worktree. The current directory
can be inside the gitdir, core.bare is irrelevant.

    a sufficient startup test:

        git rev-parse --git-dir returns the name of a gitdir, rather than throwing an error.
               core.bare and being inside/outside of the gitdir do affect error / no error.
                (the return value may be a relative path, so can depend upon current
directory)

    only GIT_DIR should be exported. GIT_WORK_TREE should not be in env.

- gui|citool, require a gitdir, a worktree outside the gitdir, and core.bare is not true

    a sufficient and minimal startup test:

        git rev-parse --show-toplevel returns the worktree root, rather than throwing an
error.
                core.bare = true in the gitdir will cause error in the above.
                being inside the gitdir causes error in the above.

        But, starting in a .git directory supporting a worktree is allowed by the fallback
logic

        git rev-parse --git-dir returns '.', (current dir is the root of the gitdir),
rather than throwing an error.
        the current directory is named ".git", meaning the parent dir is this gitdir's
worktree if core.bare is not true
        git -C .. rev-parse --show-toplevel  returns the worktree root: (will throw an
error if core.bare is true)

    the current directory should be changed to the worktree root.
    GIT_DIR and GIT_WORK_TREE should be exported to env.

Mark
