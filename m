Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64032A3F2
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597871; cv=none; b=qzJ12wBZMQKUf7U2RY01Ioofx2MSiG8uzQRFmixqi75Y0fWXIeX80BYtZ14PJSCf2bDRXKyN4WGYIvlGXdmwUOHPPld3qB2dPTnKU0FVMOsGEZF1R4W7aZfo+1tl4Toa3/H4240YSq4PGM/KcJj2x35RcRsL874aFPSJSU4S5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597871; c=relaxed/simple;
	bh=ubRipzTk9UEK4N6FjDchuMiX2siMBslQiNMeFcaqdLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IH+2QqQYFSYwTxTdHuJOpBzRssA01qM1Ou71LmlfLInyW/XeCqjyE1/Z5wsT8DBoqlrUZ1q6MyMnhkBsJmit9OR4I0LjcYhl71nNPjPxQc80R4Xc2V2gaeSfQB3TkDOsMHUiE+jzmlJubJ9OZkIcBfDWuWE8nZ7PLpvHaATuvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlpiDMMF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlpiDMMF"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8127215a4c6so169550085a.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597868; x=1758202668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HeACD6QmSL//ID8CkpQV1qSNfGVAIkzEusAsMtSa4w=;
        b=IlpiDMMFDavkq/5z55uYFy5+xOvSc/d92Xp53TUsae7YC0Uc7nOYiMzej17259wo7c
         92bcPNmtsU3GQ4sJnporGaro1Z+wg6C9p5S5exhakoUpd/uLclOVlNHo46Go3WYIjIKT
         LrKMNoCojXlbP7/cLLxKv7HG3QtKwv0bgUzeUkEfxG3vIPRr134wxF28JECVZCOxxWou
         1CpcdPZF98QOz6WaPJz5qFPidAFjwo4AcQhP2DMwk9e2sfsidQTvHxQs7geHBIIpofd6
         RjlavU6tczK0aW/GILlRa46M5rOHCOsAbZVb3U3cfteoqOgkVIErcw276N7WQWs4mBeU
         I4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597868; x=1758202668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HeACD6QmSL//ID8CkpQV1qSNfGVAIkzEusAsMtSa4w=;
        b=G2E4H1nw8Bz6EBGzW7vvaTtdq4BcffHhlSrlOHsovUv6s+X+O47uWGTMgEz7QKhOO9
         8UBlweMXtjmb66mogFUTt9w+/m8M2bG839dbBt/TwLqRsyIdlwdgel192/wnY4GxY25R
         sS5e1wxS9ubaP0lQeOqJucrP7ax42DFwDsxZGC2+eZcYStxJ5Ut85vxZr832lpPwsCnA
         0040ifyQfeFZyLb7xgunduD7R6r5C2ibfkyWut5Rhy/ROm02nzAeI8q9jDa/GiPG7T6Q
         UK8Fjjj2nSJlqZsD+eEHPlaj5RZMp697uHIz7oIlOlJTG0MeHGGiZd88ol6FAqTb2ofl
         iqkw==
X-Gm-Message-State: AOJu0YynLXDwkMv7tnEyQfq5k1jyWTuDpBWMeO/Xo5b/SsBcuKxv4+9+
	vTCwN0pxInj2fKS7JKC9vAA44/v/rEnTEQQ+TrmpLbsFnVyCT5OoKb+c
X-Gm-Gg: ASbGncsw40OKM8FftiwdX5Jf1RgheJvRC5S94YScngjNuZl6cq/31cXZor1XAnhZQ21
	vnOK5RC0VC+ikQEkAKAlri/HS+opxnvycHvFqZQTvRBEjn0vn4DDLPJ+QhGA/1huvUWG8r5/Lke
	dbclhPszcHnIb/852xHhpsdEeQv5BBDOFvHhwglxyOVbPXoV0d9KHMdQlgbLKY/v2hJEDaAv7/L
	iYnfB6e0ds/8INXsKYtKUHIVXlgL1Us4zJGSmY+0nAOzoWxfz9/gg9d0HTEzyu2NskEJsQyUFDd
	XuRqZdarx0mg0wce5eh7ANQ8ADckLHltbdxz/8siW/pM9baoKnt+PLinNw7BFfvYvKklxwd/TEO
	4RJOL+lKSpsNX6otY/9TKq9zE6upcBwmd08obeHcYjS62sNyhgwfmnXQ+fmS1itxoZotzSp/QxL
	Hr4X9aMAyiXlClv5o5Yhb/EBVYHpRQEq4=
X-Google-Smtp-Source: AGHT+IGpUoRodr1nK+/YXxje0xLU2VnKFnqVYbIXkIKok775zWyyRfKJXTD8EgJaKgzvMgFKF45Z1w==
X-Received: by 2002:a05:620a:3909:b0:80b:bb34:371c with SMTP id af79cd13be357-81ff18133ddmr442229085a.4.1757597867934;
        Thu, 11 Sep 2025 06:37:47 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:d5ef:df1b:dc3e:13b8? ([2605:a601:a6de:d300:d5ef:df1b:dc3e:13b8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab2ecsm10080081cf.30.2025.09.11.06.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:37:47 -0700 (PDT)
Message-ID: <4ce92ef9-61ef-491e-80a3-370e92fd10fd@gmail.com>
Date: Thu, 11 Sep 2025 09:37:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sparse-checkout: add basics of 'clean' command
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <7e8f7c2d6c8c740d42bc6d157fa491b558b9ff6a.1752716054.git.gitgitgadget@gmail.com>
 <CABPp-BFzMLGJwz4QqYtvw3zRYgmC=Mb8T8GCOsrLZqT2z+8H7A@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFzMLGJwz4QqYtvw3zRYgmC=Mb8T8GCOsrLZqT2z+8H7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/25 5:32 PM, Elijah Newren wrote:
> On Wed, Jul 16, 2025 at 6:34 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> Sorry for the long delay in responding...
> 
> [...]
>> Add a new subcommand to 'git sparse-checkout' that removes these
>> tracked-but-sparse directories. This necessarily removes all files
>> contained within, including tracked and untracked files. Of particular
> 
> Nice to see tracked files also being addressed in v2.
> 
>> importance are ignored and excluded files which would normally be
>> ignored even by 'git clean -f' unless the '-x' or '-X' option is
>> provided. This is the most extreme method for doing this, but it works
>> when the sparse-checkout is in cone mode and is expected to rescope
>> based on directories, not files.
>>
>> The current implementation always deletes these sparse directories
>> without warning. This is unacceptable for a released version, but those
>> features will be added in changes coming immediately after this one.
>>
>> Note that untracked directories within the sparse-checkout remain.
> 
> You've changed the wording here relative to v1, but you haven't
> addressed the part that was ambiguous/misleading in v1.  In fact, you
> may have made a different part ambiguous as well, and made readers
> think that this sentence contradicts your above claims that this
> command is meant to clean out untracked directories underneath sparse
> directories.  Perhaps something like:
> 
> "Note that untracked directories in the sparse-checkout that are not
> within sparse directories will not be removed by this command; it only
> cleans up paths under directories that are supposed to be sparse."

Both here and in the documentation, things can get a bit confusing.
In the v3 I'm preparing, I'm taking the following approach:

  * In the commit message, focus on the implementation details and how
    that impacts the behavior of the tool.

  * In the documentation, focus on the list of files that will be
    "considered for removal". Use the most broad definition there:
    in a tracked directory that is outside of the sparse-checkout.
    Add pointers that could explain exceptions and how to remove
    these exceptions, but don't attempt to explain all special
    cases.

>> +test_expect_success 'clean with staged sparse change' '
>> +       git -C repo sparse-checkout set --cone deep/deeper1 &&
>> +       mkdir repo/deep/deeper2 repo/folder1 repo/folder2 &&
>> +       touch repo/deep/deeper2/file &&
>> +       touch repo/folder1/file &&
>> +       echo dirty >repo/folder2/a &&
>> +
>> +       git -C repo add --sparse folder1/file &&
>> +
>> +       # deletes deep/deeper2/ but leaves folder1/ and folder2/
>> +       cat >expect <<-\EOF &&
>> +       Removing deep/deeper2/
>> +       EOF
>> +
>> +       git -C repo sparse-checkout clean >out &&
>> +       test_cmp expect out &&
>> +
>> +       test_path_is_missing repo/deep/deeper2 &&
>> +       test_path_exists repo/folder1
> 
> What about repo/folder2/ ?
> 
> Anyway, this test shows that neither staged nor unstaged changes are
> cleaned up (which at least resolves the conflicting documentation you
> provided on the matter) -- or would if you also checked repo/folder2.
> 
> What it doesn't show is that tracked files with neither staged nor
> unstaged changes are not cleaned up either:
> 
> $ mkdir repo/folder2
> $ echo dirty >repo/folder2/a
> $ touch repo/folder2/untracked
> $ cd repo
> $ git status --porcelain
>   M folder2/a
> ?? folder2/untracked
> 
> # So, we have both a unstaged change and an untracked file; let's undo
> the unstaged change
> 
> $ git checkout HEAD folder2/a
> Updated 1 path from 8cc814f
> $ git status --porcelain
> ?? folder2/untracked
> $ ls folder2/
> a  untracked
> 
> # Both files are still present -- the untracked file, and the
> untracked file with no changes either staged or unstaged -- what does
> `git sparse-checkout clean` do?

It seems that the unstaged modification to a tracked, sparse file
is enough to prevent the sparse directory collapse. This is
similar to how 'git sparse-checkout reapply' will refuse to remove
those modified changes. I'll be sure to update my advice around
special cases to include this (and lock it in with a test case).

> $ git sparse-checkout clean
> $ ls folder2/
> a  untracked
> $ git status --porcelain
> ?? folder2/untracked
> 
> # Absolutely nothing.  Not only does it not clean anything up, it
> gives no warnings about not cleaning up what should be cleaned up.

At this point, the SKIP_WORKTREE bit is still removed because
we've staged the change.

> Let's try sparse-checkout reapply:
> 
> $ git sparse-checkout reapply
> warning: directory 'folder2/' contains untracked files, but is not in
> the sparse-checkout cone
> $ git status --porcelain
> ?? folder2/untracked
> $ ls folder2/
> untracked
>
> # So `sparse-checkout reapply` does correctly remove folder2/a for us,
> while warning about the untracked file.  (If folder2/a would have
> still had changes, it would have warned about it instead of
> removing.).  Let's try `sparse-checkout clean` now...
> 
> $ git sparse-checkout clean
> Removing folder2/
> $ git status --porcelain
> $ ls folder2/
> ls: cannot access 'folder2/': No such file or directory
> $
> 
> I think these cases either need to be a new testcase or part of this
> last testcase, and the commit message and documentation should be
> clearer about tracked-and-staged, tracked-with-unstaged-changes, and
> tracked-with-no-changes files...or at least comment that they'll be
> discussed later in the patch series.  (I have a feeling I just did a
> lot of work to discover as I read your next patches that you cover
> these later...)

No! you found interesting ways to test special cases. Thanks!

Describing the lifecycle of a sparse file (with sibling untracked
change) going from modified to staged to sparse to unlock the
cleaning would be helpful documentation.

I do think there is an interesting extra functionality that we
should consider for the future: "What files are in my worktree
that _should_ be sparse? Why is 'clean' not removing them?"

Thanks,
-Stolee

