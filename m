Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DB43E09A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697274; cv=none; b=n+7HoK+GT2XzNSjYVkbS5dKuK3B4Di5MC3oFcJB6PJ9YfcyX37zok7zeXCNljfQpIU4mqb0I2NXjoFBPLMME4zBrxbOK6oFz29r4TQ+pk35AK8ZrzBagbFmUYKFSN6JJ39cFtC7bxv4Lew3Jyi/ZbAiqS1V0kd5IaQlxsoAXawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697274; c=relaxed/simple;
	bh=LbfsJDP1NY20PjbxsSJ6t0cVB0EtME/+1mhTTE2cVME=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WM5tVi4ZjDcP2cIonqvHDFkVzDEaK01QsqCcX+Ie+tKEyc4qJbDVqH5cJbNVRZhjzJkbnMiiNKW1Jbbh63zwEsMgRmKhg9Mo+zeyCrq/QlRoc+WfvXUXhPGWm3ei/F5sSeDKZ3QB6q91LPiAcKkoDKbyi1Z0nmBCpSwaR2rKBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbZMZVaI; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbZMZVaI"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so2564914f8f.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697270; x=1791302070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CyEuMR3WwtUzyxTXLG5x+BGjF8VIHArcvZIVSnZSWRs=;
        b=TbZMZVaIdPvmdr/G6z6zfs7FyqnaTKTAEh/9VwDQ0+TzNyOq+nhL/TbCclMonuSibL
         bud8/zyNHM4U8xTMdh3PLRJacBP9zjv+WS5QjLPwnNbmvMdzrYeXUiKDpNqlVPvzYxyG
         oMkOo0ytk77WyrHs9cqp/+vaa1ASyJhFPu/DpVUPiQWqYQPs/RZ/d3+3nYRzUYSd3TFV
         X2Tq1eUs5XUdXoa0a+bicpr77RErkKHXvc12xYKJOuR6LUal+DqF/A0zKgpVn9YoG4Ik
         0it/pr711ALSM4iSd7gQ558vm/MFsAfo1Xvp58SYW7gtr3zX2JORaKKQHEjmbMuJJeKX
         GJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697270; x=1791302070;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CyEuMR3WwtUzyxTXLG5x+BGjF8VIHArcvZIVSnZSWRs=;
        b=wzwxQllmnz1FwtRjAJh2RvVOACbB6Uk5fsa5x/C7Qw5wouwF7rmJ+fToO4j40vM96t
         xkr0FnE/xHqsECMg7xnPhiWTP2+lizOdM5fzw1A5FeMXqp8KgJKC8Q9NdHEjiI61N40b
         mQR70H+mEY7Bio8BVLpYc6nlgvpP2OI3PIYiYn5V6omEK/HWGbimZPgFpg9YEPi7Jvza
         Uyv5h0kQQPKr3GBktzcR+hBORqRZoC3oCTghzgyvD3TOlBPKxu+BCh+y09FvGl+trL9s
         zIAyGLlJBT6c7Nj3sXZYR7BPPS0YOyshleV3QJYIZTqxczlMbT4kMkdwYCnrcv6bOdUf
         2+LA==
X-Forwarded-Encrypted: i=1; AKwUvBxoPHlLsH5s+Oibo64mlbFvKviWeGBqYf8M/XftopZRNqxfKFV4pPKHCtR0aS6dFSAT0IE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7HwHecMMhf7E8c3OcRFj1/InrEDtuHZD5HF4gajKlsMiOohC0
	R1uf3kBVFFDvYMYIY7+Xiut9dxWeaongl5QLq7BZO+Vnfy+XZYP5cS8F
X-Gm-Gg: AYBFou3ZZiaD6G30TZ3X4H4aOeRd89O0DleNP5n6/jRNCzhMYbhsI03bupseGd7zfK0
	1YXaWJR+d4VN8kICx/iDO/kQzhI2KRuA0xg939GzB1GkR1v/FjqjGrtq1M5j/0ICCQ2htKhDY4v
	Yhohzxw4tshnFMG6NZqNUMcVivdSQ2vP0MakZCbdcyawLptPuTv2TYUb47t/GJ3WIoTw6S+vMoL
	A4p8W0z7GWmWbpd48ipWcGiSAB3DRYB22gdZ/I0yFlMgpDNakZs2iOtffD8R9Bfsl05K3eFlHAC
	Vh5JiAU8jBta8p4N5kiVaCQGyQJzuYzrH2fqCZqirfZNTjH/aUy5FJPZU4lj5uzuLRYhaMA822J
	t0mCo0Tny4UZ+O5VrpKbJk47gxezI4VyqmS3eSCF1GX9bKEleZNJ9kPs+urCD3Wbh3NHoF7F57h
	H5+vE+earDVCQw3lvwdTEtufeLtnPJx0bz+GbADoXAl1IVu7RR0GtvqW5u4V0d5OtzP2AW+MNL0
	39hU2dj//bP00wDd/fvJ3z7trAcS0n+tix8qjcvpGLREwBLs/uWBw==
X-Received: by 2002:a05:6000:4b09:b0:487:218b:bbb0 with SMTP id ffacd0b85a97d-4887db3a9a8mr23896888f8f.42.1790697270083;
        Tue, 29 Sep 2026 08:54:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af50a65f4sm4719914f8f.35.2026.09.29.08.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:54:29 -0700 (PDT)
Message-ID: <54957537-e40d-45b6-886c-5fc433f3d54e@gmail.com>
Date: Tue, 29 Sep 2026 16:54:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Thomas Bachem <mail@thomasbachem.com>
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com, git@vger.kernel.org,
 eli@barzilay.org, ps@pks.im
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com> <xmqqjyo6qz3z.fsf@gitster.g>
 <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
 <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
 <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com>
 <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
 <CALnO6CC-eop86W3VREwGz0seG1pmtd0qS968TyP=mo_G+ZMrSA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CC-eop86W3VREwGz0seG1pmtd0qS968TyP=mo_G+ZMrSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 28/09/2026 16:36, D. Ben Knoble wrote:
> Let me see if I understand correctly…
> 
> On Mon, Sep 28, 2026 at 10:50 AM Thomas Bachem <mail@thomasbachem.com> wrote:
>>
>> On Mon, Sep 28, 2026 at 3:45 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> Oh, when I was thinking about this over lunch I did wonder if that might
>>> be the culprit. Previously we didn't run "git maintenance --auto" after
>>> a rebase with the 'merge' backend but with that topic we do, and because
>>> we set GIT_COMMITTER_DATE to sometime in 2005, if 'git reflog expire'
>>> gets triggered it will expire the reflog entries that 'git pull
>>> --rebase' relies on. As you suggested in another mail, I assume this
> 
>> "git pull --rebase" computes the fork point before it fetches, from
>> the reflog of refs/remotes/me/copy,
> 
> This is described by the manual for git-rebase under --fork-point,
> which is on unless we have an <upstream> or --keep-base (modulo
> config). Put a pin in this.
> 
>> and test 69 needs the entry that
>> test 68's fetch wrote there, copy-orig (f29aa66) to ae98574. With the
>> reflog empty, "merge-base --fork-point" falls back to the ref itself,
>> ae98574 is no ancestor of to-rebase, and pull hands the merge head to
>> rebase as the upstream. That is your "--onto ae98... ae98...", and the
>> four commits from copy-orig up come back, the first of them
>> conflicting with "conflict".
>>
>>> topic has changed something in one of the '--autostash' tests that come
>>> before the failing test triggers which the new behavior. What that
>>> something is I'm not sure; off the top of my head I'd expect the number
>>> of reflog entries in HEAD to be the same but maybe I'm missing
>>> something. Adding
>>
>> It is eight entries fewer, and they come from the failed merges, not
>> from the autostash tests. "git merge" restores a dirty tree with
>> "stash apply --index --quiet", and until Ben's series that spawned
>> "git reset --quiet --refresh", which writes "reset: moving to HEAD"
>> to the reflog. That happens eight times in t5520 before test 68.
>>
>> Auto maintenance expires reflogs once HEAD's reflog holds a hundred
>> entries that the policy would remove, the default of
>> maintenance.reflog-expire.auto, and after the first test_tick that is
>> every entry. Which run crosses the hundred depends on how many entries
>> and maintenance runs came before it. On 'seen' the expiry lands on
>> "git commit -m conflict" in test 68, before the fetch writes the entry.
>> Eight entries fewer move the crossing past that commit, and the
>> maintenance run my topic adds at the end of the rebase in test 68 is
>> the next one: after the fetch, before test 69 reads the reflog. Either
>> change alone leaves it somewhere harmless, and nothing else is going
>> on. The expiry is the usual 90 days applied to entries dated 2005, and
>> the only new thing is one more maintenance run per rebase, the same
>> one "git commit" and "git fetch" run.
> 
> In short, expiry used to happen prior to .68, so the reflog entry
> created in that test which is used by "pull --rebase" in .69 is picked
> up. With fewer reflog entries, expiry happens later, and it just so
> happens to drop the important entry. Darn!

Yes, it is incredibly bad luck that the test broke, though I guess it is 
also fortunate as it means we can fix the latent bug in the test.

> 
> But here's what I can't figure out, returning to that pin from
> earlier: I was a bit surprised to see mention of rebase reading
> reflogs! When I remembered --fork-point, I was even more curious (but
> at least it's obvious that rebase will read the reflogs in some
> scenarios).
> 
> What confuses me is that builtin/pull.c:run_rebase() sure looks like
> it provides an <upstream> to the command invocation, so shouldn't
> --fork-point and reflog use be disabled????
> 
> I'll try tracing that test myself later, I suppose. It's nice to know
> we have a fix available (thanks for the patch), but it sure feels like
> a hack :) oh well?

It is a bit confusing that "git pull --rebase" does not use "git rebase 
--fork-point", instead it calls "git merge-base --fork-point" (which is 
where we read the reflog of the remote branch) itself and then passes 
that as the upstream revision to "git rebase". I think this is because 
fork-point handling was added to "git pull" before "--fork-point" 
existed in "git rebase". "git rebase" only looks for a fork-point if its 
upstream argument is a ref, so as "git pull" passes an object id, the 
fork-point detection in rebase is bypassed.

Thanks

Phillip

