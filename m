Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E183C6A5C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295299; cv=none; b=k/SNHI6mYDfSKN3J1lOGaKZXDRyp391stuMEOFIAmLHjHAS+fJ7w7xcZNVvR3ihoAH89boSVte0YuKwgKuK3BDp5ouIKf6U3bw+c80G7fB1zyS9YxADotfNtXONhhIF2QFYakc6I0j5x5O/6kyJS0NHmJgl+dEB2ZCT6rfoXjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295299; c=relaxed/simple;
	bh=C6bNngB5XR62Fswrr5ur/HSrmd7FQjKrD8J0WN5QbaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KlMJJoLG5bsWZwl+SB5m8B2IjeqLh8Ecp/VEPYw0uMBKIlqXSqP3g6tUmbe6QTF7V8Na0JweZJ9ldS7eVbaG5G0RmIYrskXLE2OE/TPq3SGl9F9ZnKB7cOwTqRE9z3AQuPKXTi5eXbY5z4D64IMt77jJHagLykQGloRT7a7FT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7n25FIT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7n25FIT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0759so635680f8f.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791295295; x=1791900095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWbSn/SU/9hOB40EUzF3OyUVBL3mJtuwqZCXQ65FGBM=;
        b=a7n25FIT6Tsxne0bI775GVVSY/7KaUs6ygPK430Pka5pCgYvQSDS5VT/WJZP87hONH
         BMeuf0Vvt3lGGJ+P+JqpASEqb7n9kbeRM8u2XPE3d8bPnIIp5AFQv4n+vfuDpLAVcdaF
         G7KiyAsOJcmjHne4YMZLPVr5K97Rq6ncspJYb0fI7bKuJBwy+1od+FPHEKJ9V9fSiBlV
         zWWCqG98X6cbSZkkFUO8/KXG0K60Kg79IhtUGA1qr9EErxQ2gzgzZYhQ5UxIr7Wxx4J2
         oQjuJ2nuMmMIfGRGXdsFlWceYzwFI7xcCuE81YjOs4+9tLv5eOFtDbG785gaWKyDUoiq
         UM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295295; x=1791900095;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWbSn/SU/9hOB40EUzF3OyUVBL3mJtuwqZCXQ65FGBM=;
        b=j5RINIfVf/cegDGapB52HLnMJgMfbrgi0fbyrCSeRrsEBmQIQt0ik4r1htm0ZBi0XI
         7+2xhDcZb0L0ZNSRXiaNrRlc2RniGJ4oP6lnbdxcBQCR2CNubn409redRPeYTIfD9WI0
         2jG7+v4mKqNopwENJdua8XunmMgH65/qp3Qc3DOOPV9uhCOUal4y2jl5jcLhL56cdwtd
         ifoRzDll99ETzZ+VfmvdznOtceho1Tj7FgXfynEb6LPTifiGMUDncNXVurcTPWKK5h4b
         7waTdTzKhLbpCSzYn8hEONjZW0KxxqWDVtYcrHc++QXcKIp2ccktd+ocTUVLsQucW0LT
         687A==
X-Forwarded-Encrypted: i=1; AKwUvBxZULj2h1RZLHoUrGLfVP9NIqquHvPD/+d/YJ4hPToGGQEeNB5vjfrdY2o2ZIc5TW+l1F8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCvoiZH3Tuox4o3RqbSwPq+FDHigE4p0qgrCSiF+R07lXZ0y9v
	cAP+sWyxZwnQ+yc6ccRx9bxNVEM2FYvJIvD7BI+FwsIwlNsBxzIEHv8n
X-Gm-Gg: AYBFou0pPeW6jVAnlqikbzWScwm6R7jzj0X/MTm9XYricaQ303IGLA3TEaUMsWJ03QM
	Goxc/Ta1+BmHbPPtq0CMB/YtSZPyiBphRjNEOejvXgGLr1M6jL4zNGFQT5T2HQkL5UmrX3TwrAs
	6C/TghySDn7rAsooztg4aMIOUPAn/K3uZCoZB+9RCZOmQGIbVpygx++s1Rll41PLblVRPRFxu/A
	uFa9/aLxUnZVEQrUnFwvI3Yr0/c8dYC6xokq1KeUIxwI31lr8XB6so3IUozdMampyUkecVrJLAJ
	dznInnvjORU1Y+3UcnTOxNWb4Z6nZX0HoLYx6i8Z9GuDxjJSnhumgP9pxqA4YVtqZXeZ5d539q7
	phUJUssWtPgVRvAovi/NjA4pzrPGOJET30cEHnYdf9FGrfoz2LfoT9v16/HjWRkezEfF5Wu90EY
	1aiGKURYvBzFpHOibrTeTYSUPc7Nu81W4vZzxgKptfUH/oNxF7PqehQwEJIDSSMMoY2ZrIj9o/x
	Fomldly2/TOtPoqUW40F6Tfed8AlkFEXVZXlRoNFX7HjYaMvJiP
X-Received: by 2002:a05:6000:25e7:b0:48c:4f94:2214 with SMTP id ffacd0b85a97d-48c6d0ebca4mr2344234f8f.3.1791295294942;
        Tue, 06 Oct 2026 07:01:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622bb172sm22863117f8f.42.2026.10.06.07.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:01:33 -0700 (PDT)
Message-ID: <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
Date: Tue, 6 Oct 2026 15:01:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-rebase-walk
To: Alejandro Colomar <alx@kernel.org>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Nico Williams <nico@cryptonector.com>
References: <ar5KL4_IKXYbx3Sb@debian> <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian> <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com> <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
Content-Language: en-US
In-Reply-To: <asOnp8ed6AGStH60@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alejandro

On 05/10/2026 14:37, Alejandro Colomar wrote:
>> Date: 2026-10-05 15:28:28+0200
>> From: Alejandro Colomar <alx@kernel.org>
>>> Date: 2026-10-04 11:03:39+0100
>>> From: Phillip Wood <phillip.wood123@gmail.com>
>>>
>>> I agree that would be the best way forward. Adding an "--incremental", or
>>> "--progressive" option to rebase would be useful I think. For ease of use, I
>>> have a strong preference for an implementation where "rebase --continue"
>>> handles rebasing onto progressively more recent bases, rather than the multi
>>> shot approach where the user has to run "git rebase --incremental" multiple
>>> times. Having a multi-shot approach makes it much less clear when we've
>>> successfully rebased onto the desired base.
>>
>> For rebasing a single branch, having --continue do what you suggest
>> wouldn't be too problematic.
>>
>> However, for when rebasing a tree of branches, I really need a
>> multi-shot operation, since I want to advance branches in a very
>> specific order.
>>
>> Below is a shell session performing such a rebase, which hopefully shows
>> why I need this to be multi-shot.

To me it shows that we need to improve "git rebase --update-refs" so 
that it can rebase a tree of branches automatically. Doing it manually 
is labor intensive and error-prone (your example output shows it is easy 
to forget when you're meant to be resolving a conflict instead aborting 
the rebase and checking out another branch). In the example below

     git rebase --update-refs --rebase-merges main B

will rebase A and B, but we don't have a way of including C.
>> On the simpler case of a single branch, I'd still prefer a multi-shot
>> approach where --continue only advances one rebase operation, because at
>> the end of it I want to stop, and check git-range-diff(1) to make sure
>> it all makes sense.

Perhaps we could insert "break" commands after each branch is rebased 
so the user can check the range-diff.

Thanks

Phillip


>> I've indented the output of commands, so that they are easier to
>> distinguish.
>>
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* G ada8aff4f08a (r/B, B) foo j
>> 		* G d6163efdc2db bar i
>> 		| * G 450f3a7f4f25 (r/HEAD, r/C, C) bar l
>> 		| * G f7309b21ebfa bar k
>> 		|/
>> 		* G e949e24ba457 (HEAD -> A, r/A) bar h
>> 		*   G 607b450498be bar g
>> 		|\
>> 		| * G b787bcd373d9 bar e
>> 		* | G c496b325576f baz f
>> 		|/
>> 		| * G dfd9156d099a (r/main, main) foo d
>> 		| * G 4940c7d739be bar c
>> 		| * G cebc8fde25bb foo b
>> 		|/
>> 		* G 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
>> 		Rebase: conflict
>> 		Bisecting: 0 revisions left to test after this (roughly 1 step)
>> 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: success
>> 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
>> 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
>> 		Author: Alejandro Colomar <alx@kernel.org>
>> 		Date:   2026-10-05 14:42:32 +0200
>>
>> 		    bar c
>>
>> 		 bar | 1 +
>> 		 1 file changed, 1 insertion(+)
>> 		 create mode 100644 bar
>> 		bisect found first 'bad' commit
>> 		Auto-merging bar
>> 		CONFLICT (add/add): Merge conflict in bar
>> 		error: could not apply 899eeb5c4e32... bar e
>> 		hint: Resolve all conflicts manually, mark them as resolved with
>> 		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>> 		hint: You can instead skip this commit: run "git rebase --skip".
>> 		hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>> 		hint: Disable this message with "git config set advice.mergeConflict false"
>> 		Could not apply 899eeb5c4e32... # bar e
>> 	alx@debian:~/tmp/brebase$ git rebase --abort
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 655c38e3cee8 (HEAD -> A) bar h
>> 		*   1ababced193d bar g
>> 		|\
>> 		| * 899eeb5c4e32 bar e
>> 		* | 761c9dbcfa5b baz f
>> 		|/
>> 		| * ada8aff4f08a (r/B, B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| * | c496b325576f baz f
>> 		| |/
>> 		| | * dfd9156d099a (r/main, main) foo d
>> 		| | * 4940c7d739be bar c
>> 		| |/
>> 		|/|
>> 		* | cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git switch B
>> 		Switched to branch 'B'
>> 		Your branch is up to date with 'r/B'.
>> 	alx@debian:~/tmp/brebase$ git brebase A
>> 		Rebase: conflict
>> 		Bisecting: 2 revisions left to test after this (roughly 1 step)
>> 		[899eeb5c4e32397f0fe138c5b9f486d4682939cb] bar e
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> 		[cebc8fde25bbe16c0f5f48e39642b3551f4f56e6] foo b
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		cebc8fde25bbe16c0f5f48e39642b3551f4f56e6 is the first 'bad' commit
>> 		commit cebc8fde25bbe16c0f5f48e39642b3551f4f56e6
>> 		Author: Alejandro Colomar <alx@kernel.org>
>> 		Date:   2026-10-05 14:42:04 +0200
>>
>> 		    foo b
>>
>> 		 foo | 2 +-
>> 		 1 file changed, 1 insertion(+), 1 deletion(-)
>> 		bisect found first 'bad' commit
>> 		Auto-merging foo
>> 		CONFLICT (content): Merge conflict in foo
>> 		error: could not apply ada8aff4f08a... foo j
>> 		hint: Resolve all conflicts manually, mark them as resolved with
>> 		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>> 		hint: You can instead skip this commit: run "git rebase --skip".
>> 		hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>> 		hint: Disable this message with "git config set advice.mergeConflict false"
>> 		Could not apply ada8aff4f08a... # foo j
>> 	alx@debian:~/tmp/brebase$ echo j >foo
>> 	alx@debian:~/tmp/brebase$ git add foo
>> 	alx@debian:~/tmp/brebase$ git rebase --continue
>> 		[detached HEAD 2e0b72e7440a] foo j
>> 		 1 file changed, 1 insertion(+), 1 deletion(-)
>> 		Successfully rebased and updated refs/heads/B.
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 2e0b72e7440a (HEAD -> B) foo j
>> 		* a1c6c1fb7ca2 bar i
>> 		* d8fa6c4da463 bar h
>> 		* bef9f1c4da4d bar e
>> 		* 0bac26895b94 baz f
>> 		| * 655c38e3cee8 (A) bar h
>> 		| *   1ababced193d bar g
>> 		| |\
>> 		| | * 899eeb5c4e32 bar e
>> 		| |/
>> 		|/|
>> 		| * 761c9dbcfa5b baz f
>> 		|/
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| * | c496b325576f baz f
>> 		| |/
>> 		| | * dfd9156d099a (r/main, main) foo d
>> 		| | * 4940c7d739be bar c
>> 		| |/
>> 		|/|
>> 		* | cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git brebase A
>> 		Rebase: success
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 5ff93a00f9f2 (HEAD -> B) foo j
>> 		* 01522206a7bc bar i
>> 		* 655c38e3cee8 (A) bar h
>> 		*   1ababced193d bar g
>> 		|\
>> 		| * 899eeb5c4e32 bar e
>> 		* | 761c9dbcfa5b baz f
>> 		|/
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C, C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| * | c496b325576f baz f
>> 		| |/
>> 		| | * dfd9156d099a (r/main, main) foo d
>> 		| | * 4940c7d739be bar c
>> 		| |/
>> 		|/|
>> 		* | cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git switch C
>> 		Switched to branch 'C'
>> 	alx@debian:~/tmp/brebase$ git brebase A
>> 		Rebase: success
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 06d462903420 (HEAD -> C) bar l
>> 		* 20f0a887b83b bar k
>> 		| * 5ff93a00f9f2 (B) foo j
>> 		| * 01522206a7bc bar i
>> 		|/
>> 		* 655c38e3cee8 (A) bar h
>> 		*   1ababced193d bar g
>> 		|\
>> 		| * 899eeb5c4e32 bar e
>> 		* | 761c9dbcfa5b baz f
>> 		|/
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| * | c496b325576f baz f
>> 		| |/
>> 		| | * dfd9156d099a (r/main, main) foo d
>> 		| | * 4940c7d739be bar c
>> 		| |/
>> 		|/|
>> 		* | cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git switch A
>> 		Switched to branch 'A'
>> 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
>> 		Rebase: conflict
>> 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> 		[4940c7d739be44c0ca32c1d610b85fd5650e1528] bar c
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		4940c7d739be44c0ca32c1d610b85fd5650e1528 is the first 'bad' commit
>> 		commit 4940c7d739be44c0ca32c1d610b85fd5650e1528
>> 		Author: Alejandro Colomar <alx@kernel.org>
>> 		Date:   2026-10-05 14:42:32 +0200
>>
>> 		    bar c
>>
>> 		 bar | 1 +
>> 		 1 file changed, 1 insertion(+)
>> 		 create mode 100644 bar
>> 		bisect found first 'bad' commit
>> 		Auto-merging bar
>> 		CONFLICT (add/add): Merge conflict in bar
>> 		error: could not apply 899eeb5c4e32... bar e
>> 		hint: Resolve all conflicts manually, mark them as resolved with
>> 		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>> 		hint: You can instead skip this commit: run "git rebase --skip".
>> 		hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>> 		hint: Disable this message with "git config set advice.mergeConflict false"
>> 		Could not apply 899eeb5c4e32... # bar e
>> 	alx@debian:~/tmp/brebase$ echo e >bar
>> 	alx@debian:~/tmp/brebase$ git add bar
>> 	alx@debian:~/tmp/brebase$ git rebase --continue
>> 		[detached HEAD 2a4fa7fe2f44] bar e
>> 		 1 file changed, 1 insertion(+), 1 deletion(-)
>> 		Successfully rebased and updated refs/heads/A.
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 0954f3d9b9e1 (HEAD -> A) bar h
>> 		*   4f09c21bf2ca bar g
>> 		|\
>> 		| * 2a4fa7fe2f44 bar e
>> 		* | e42246e75159 baz f
>> 		|/
>> 		| * 06d462903420 (C) bar l
>> 		| * 20f0a887b83b bar k
>> 		| | * 5ff93a00f9f2 (B) foo j
>> 		| | * 01522206a7bc bar i
>> 		| |/
>> 		| * 655c38e3cee8 bar h
>> 		| *   1ababced193d bar g
>> 		| |\
>> 		| | * 899eeb5c4e32 bar e
>> 		| * | 761c9dbcfa5b baz f
>> 		| |/
>> 		| | * ada8aff4f08a (r/B) foo j
>> 		| | * d6163efdc2db bar i
>> 		| | | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | | * f7309b21ebfa bar k
>> 		| | |/
>> 		| | * e949e24ba457 (r/A) bar h
>> 		| | *   607b450498be bar g
>> 		| | |\
>> 		| | | * b787bcd373d9 bar e
>> 		| | * | c496b325576f baz f
>> 		| | |/
>> 		| | | * dfd9156d099a (r/main, main) foo d
>> 		| |_|/
>> 		|/| |
>> 		* | | 4940c7d739be bar c
>> 		|/ /
>> 		* / cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 B
>> 		Successfully rebased and updated refs/heads/B.
>> 	alx@debian:~/tmp/brebase$ git rebase --onto A 655c38e3cee8 C
>> 		Successfully rebased and updated refs/heads/C.
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 4a4ba76f55a4 (HEAD -> C) bar l
>> 		* 86350e1490f3 bar k
>> 		| * 4b6b40b14255 (B) foo j
>> 		| * ba5a233ee4bc bar i
>> 		|/
>> 		* 0954f3d9b9e1 (A) bar h
>> 		*   4f09c21bf2ca bar g
>> 		|\
>> 		| * 2a4fa7fe2f44 bar e
>> 		* | e42246e75159 baz f
>> 		|/
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| * | c496b325576f baz f
>> 		| |/
>> 		| | * dfd9156d099a (r/main, main) foo d
>> 		| |/
>> 		|/|
>> 		* | 4940c7d739be bar c
>> 		* | cebc8fde25bb foo b
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git switch A
>> 		Switched to branch 'A'
>> 	alx@debian:~/tmp/brebase$ git brebase --rebase-merges main
>> 		Rebase: success
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 30e2d96b3da5 (HEAD -> A) bar h
>> 		*   01702a5b5d6b bar g
>> 		|\
>> 		| * c961883d543a bar e
>> 		* | e17aadb725c4 baz f
>> 		|/
>> 		* dfd9156d099a (r/main, main) foo d
>> 		| * 4a4ba76f55a4 (C) bar l
>> 		| * 86350e1490f3 bar k
>> 		| | * 4b6b40b14255 (B) foo j
>> 		| | * ba5a233ee4bc bar i
>> 		| |/
>> 		| * 0954f3d9b9e1 bar h
>> 		| *   4f09c21bf2ca bar g
>> 		| |\
>> 		| | * 2a4fa7fe2f44 bar e
>> 		| |/
>> 		|/|
>> 		| * e42246e75159 baz f
>> 		|/
>> 		* 4940c7d739be bar c
>> 		* cebc8fde25bb foo b
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| |/
>> 		|/|
>> 		| * c496b325576f baz f
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 C
>> 		Successfully rebased and updated refs/heads/C.
>> 	alx@debian:~/tmp/brebase$ git rebase --onto A 0954f3d9b9e1 B
>> 		Auto-merging foo
>> 		CONFLICT (content): Merge conflict in foo
>> 		error: could not apply 4b6b40b14255... foo j
>> 		hint: Resolve all conflicts manually, mark them as resolved with
>> 		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>> 		hint: You can instead skip this commit: run "git rebase --skip".
>> 		hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>> 		hint: Disable this message with "git config set advice.mergeConflict false"
>> 		Could not apply 4b6b40b14255... # foo j
>> 	alx@debian:~/tmp/brebase$ git rebase --abort
> 
> Oh, this was a mistake;  I should have resolved the conflict here
> instead of using brebase below.  (brebase produced the same exact
> conflict).  :)
> 
> 
> Cheers,
> Alex
> 
>> 	alx@debian:~/tmp/brebase$ git switch B
>> 		Already on 'B'
>> 		Your branch and 'r/B' have diverged,
>> 		and have 8 and 6 different commits each, respectively.
>> 		  (use "git pull" if you want to integrate the remote branch with yours)
>> 	alx@debian:~/tmp/brebase$ git brebase A
>> 		Rebase: conflict
>> 		Bisecting: 2 revisions left to test after this (roughly 1 step)
>> 		[c961883d543a2393aacfd6a8345e1d29e6857f7f] bar e
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> 		[dfd9156d099ad3507a2850294c7a584b80712f04] foo d
>> 		running '.git/bisect-rebase/git-bisect-run-callback'
>> 		Rebase: conflict
>> 		dfd9156d099ad3507a2850294c7a584b80712f04 is the first 'bad' commit
>> 		commit dfd9156d099ad3507a2850294c7a584b80712f04
>> 		Author: Alejandro Colomar <alx@kernel.org>
>> 		Date:   2026-10-05 14:42:50 +0200
>>
>> 		    foo d
>>
>> 		 foo | 2 +-
>> 		 1 file changed, 1 insertion(+), 1 deletion(-)
>> 		bisect found first 'bad' commit
>> 		Auto-merging foo
>> 		CONFLICT (content): Merge conflict in foo
>> 		error: could not apply 4b6b40b14255... foo j
>> 		hint: Resolve all conflicts manually, mark them as resolved with
>> 		hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
>> 		hint: You can instead skip this commit: run "git rebase --skip".
>> 		hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
>> 		hint: Disable this message with "git config set advice.mergeConflict false"
>> 		Could not apply 4b6b40b14255... # foo j
>> 	alx@debian:~/tmp/brebase$ echo j >foo
>> 	alx@debian:~/tmp/brebase$ git add foo
>> 	alx@debian:~/tmp/brebase$ git rebase --continue
>> 		[detached HEAD e7fdf07fd077] foo j
>> 		 1 file changed, 1 insertion(+), 1 deletion(-)
>> 		Successfully rebased and updated refs/heads/B.
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* e7fdf07fd077 (HEAD -> B) foo j
>> 		* dddf632a735f bar i
>> 		* 7ac284de12ba bar h
>> 		* e4541508ab3e bar e
>> 		* cefec5878c67 baz f
>> 		| * 6c7952d6fec5 (C) bar l
>> 		| * bd43684f73c8 bar k
>> 		| * 30e2d96b3da5 (A) bar h
>> 		| *   01702a5b5d6b bar g
>> 		| |\
>> 		| | * c961883d543a bar e
>> 		| |/
>> 		|/|
>> 		| * e17aadb725c4 baz f
>> 		|/
>> 		* dfd9156d099a (r/main, main) foo d
>> 		* 4940c7d739be bar c
>> 		* cebc8fde25bb foo b
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| |/
>> 		|/|
>> 		| * c496b325576f baz f
>> 		|/
>> 		* 1dcb901ebf60 foo a
>> 	alx@debian:~/tmp/brebase$ git brebase A
>> 		Rebase: success
>> 	alx@debian:~/tmp/brebase$ git log --all --graph --oneline
>> 		* 1201c4f20b19 (HEAD -> B) foo j
>> 		* 44103f51a783 bar i
>> 		| * 6c7952d6fec5 (C) bar l
>> 		| * bd43684f73c8 bar k
>> 		|/
>> 		* 30e2d96b3da5 (A) bar h
>> 		*   01702a5b5d6b bar g
>> 		|\
>> 		| * c961883d543a bar e
>> 		* | e17aadb725c4 baz f
>> 		|/
>> 		* dfd9156d099a (r/main, main) foo d
>> 		* 4940c7d739be bar c
>> 		* cebc8fde25bb foo b
>> 		| * ada8aff4f08a (r/B) foo j
>> 		| * d6163efdc2db bar i
>> 		| | * 450f3a7f4f25 (r/HEAD, r/C) bar l
>> 		| | * f7309b21ebfa bar k
>> 		| |/
>> 		| * e949e24ba457 (r/A) bar h
>> 		| *   607b450498be bar g
>> 		| |\
>> 		| | * b787bcd373d9 bar e
>> 		| |/
>> 		|/|
>> 		| * c496b325576f baz f
>> 		|/
>> 		* 1dcb901ebf60 foo a
>>
>> This would be impossible with an approach that handles all the way until
>> the end.  I need to be able to stop a bisect-rebase operation on one
>> branch in the middle, then do a bisect-rebase on its descendants, then
>> come back to bisect-rebase the parent branch.  Does this make sense?
>>
>>
>> Have a lovely day!
>> Alex
>>
>>
>>>
>>> Thanks
>>>
>>> Phillip
>>>
>>>
>>>> That's of course more involved though, so I understand in case you're
>>>> not interested in doing that.
>>>>
>>>>> If not, I will likely provide it in the man-pages repository as a help
>>>>> tool (which might end up packed by distros as part of manpages-utils).
>>>>> Is that okay to you?  (I ask mainly because it's using the git-
>>>>> namespace for commands, so you should at lease be aware of it.)
>>>>
>>>> I mean overall this is our primary way of extension, by picking up
>>>> utilities that have the "git-" prefix. So arguably you don't have to ask
>>>> us for permission to do that.
>>>>
>>>> Whether it makes sense to distribute such a tool as part of
>>>> manpages-utils is a different question, and one where I myself am of a
>>>> split mind. But that feels more like a question for distributors rather
>>>> than for us in the Git project.
>>>>
>>>> Thanks!
>>>>
>>>> Patrick
>>>
>>
>> -- 
>> <https://www.alejandro-colomar.es>
> 
> 
> 

