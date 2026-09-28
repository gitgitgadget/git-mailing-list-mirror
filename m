Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5484D1781
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603142; cv=none; b=l5Y/0Eb7L8gmOhYX9np8eUV60FaCDFlQVDPaE9H1UVU3hPObFAPbLMBDB2RruBvZRdULNNxOAwL4CbJLEe/5FCpZ4BmdVGlBn0UXa/opuzNMeIlq5bRsU7wGKeH9zlWyytYXeWJkTezIGLZlOnPE+1Au+j3UqDAB2kb/5bnS8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603142; c=relaxed/simple;
	bh=2PiC4WgUKa3Ea2/4K/PtMmWC3iDTVjgj9rH6lcVPBDM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uGgaR9tdlhgj5l0H0nSgXJibOG6tFC5CKjMUZrzNW1BM54BhujWxvXJRAqjiqEasd68RzNW08HXM0JfKX5kBa97EF2th0j/Xxqz954ILjgIhV9k0FEJLjzvlingzlHjzo1Mdd3mx6z6QdCOGyPCCWhmZV8FV09cUSkclXf5NZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvlAFwpy; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvlAFwpy"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf688ebb0so3267027a12.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603138; x=1791207938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xz4PFlthziM2P/6cFIIzRMgzlUYCSAWckft9koLK9xA=;
        b=NvlAFwpylgMTWsiHB0SWZAFk3PTOuiS6KRxXi6xRqS/LDy8WR+ZQmdLj1nxtdOwt4T
         qxsWYSeJ4guGYwy6aF4GTXNU+YpptBZ4nNGxp2VaujU6E2q1rqKYNUGLpGcLcEqZZ9tP
         qzN+ecS9H8lfDzRRw0c/v6F2XhDKzJn+nKV7LHqDF6YsmmOdFh/hcP4qr7ez8d0pEm9a
         By79oUCHFWprH4KwX9b/8Vne1I+NtTKa1A1m+dp38g2xMhM+ysk/fWqboRcb2B+Zq9UC
         NDrjDmTdA7U8UgTAKCAkVjgQWUuAUe9g+QKjM1i/KAYX+xC1e4VPshppkLwCBk9QJ/C0
         Kn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603138; x=1791207938;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xz4PFlthziM2P/6cFIIzRMgzlUYCSAWckft9koLK9xA=;
        b=hyGkUkCYbJVbu0UlbAUC58BCOWodApBbuW2ja/d4cYUJeIfnrfn4x5/vkvURQVdMTJ
         OVLheQMqEISaJyWsYHeJWykJ62PQWPEzuyTe/c3r4qcYPSk3OYk/ZCisLrHGLaftZlZJ
         Xb5ZUcd56+BdxWIyJBrH1Jtl0RuZ6ypO2Xx5COtHWUF6ZHHHdO17bU3eB7yc+cdA9E8P
         fOMOYLL4bePjc976OhgVKKeZhiwZx9UXyQSmIaa2wJcj4TTLb1hg3uwn4VD+pZ9Vnnp/
         M14L0CkocWQqrQl/aOvNAjITX8zzQmftjNydW7nfiA+UlUu6Mw68tkMlKfwbXoNP+NCh
         kjpg==
X-Forwarded-Encrypted: i=1; AKwUvBzucHbaYP8k45j1tQR/xs4MnPsuYLuzrGbVTTNnIX3cE3133ZfJxo6p+MLLv4uz6vbvMYk=@vger.kernel.org
X-Gm-Message-State: AFuF++mDsoXEtCmZUIlpXzgFIVFq8j4hQLhVH+QdFMRvg8oc3eeL+WSW
	iGv/8g3vlZm1dM9RDSo/VbbMZ4aWRx7es+HdPBlg9ItOnoLKmKsw+PRV
X-Gm-Gg: AYBFou1ORsTvcv5D7YRNec8Y1I0EE4cBsULBmuUZ+DgbIgW4RD0IDvYwWE+5z1nH3DB
	2r7P+fo/Gp6RBSD/76qa2QVfX09ISfuSx0Ru2JMsi1D5hcekuN3devOJRnesbHXJRAUHbwPxNqF
	TA3ywmD7F3gEnY2SHGvwwWjc+8K6pgVDnjHwpZ1qQS/c7hB/fokTPW+swWuh2gj8dT4WryEeCKT
	GQkcJSaL1Chnmk29Z9cKFqYt5snTUXOKGP3EH4J4KkiwffErj3ucbQiVaQju4O3Ei852oOKLIow
	B1jzVKMGh81y0thhwL/PwvnYmsCXxOeSXKCHGlHa9fQZUW4URYOHQp6lu+WTME7fCx5vl4osxyx
	IItV1iDRlWUnxFjpIVRxIPWYXaSwjIRKoXEI7G+tRRrtQ5HJbM0hqfjs4bBGURKsbhHQ30eZUAd
	zNBhGz1xTVforSjDW7MOhHfKqsBE3vhvGv6Y/7VMdUXLhHaEjetEyOXWQDRhRDmoG/03AWysrKZ
	vGKFRCaja5IQ5LQRNUvPLZ6hVRBQLr4NxYgnNFaEe8B0GkbpORWRDu5mVI7kJHh
X-Received: by 2002:a17:907:3e10:b0:c2d:bd87:7fa7 with SMTP id a640c23a62f3a-c2dbd878d07mr437604366b.24.1790603137781;
        Mon, 28 Sep 2026 06:45:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7357cf3sm480610966b.17.2026.09.28.06.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:45:37 -0700 (PDT)
Message-ID: <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com>
Date: Mon, 28 Sep 2026 14:45:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Eli Barzilay <eli@barzilay.org>, Thomas Bachem <mail@thomasbachem.com>
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com> <xmqqjyo6qz3z.fsf@gitster.g>
 <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
 <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 28/09/2026 14:00, D. Ben Knoble wrote:
> On Mon, Sep 28, 2026 at 8:33 AM D. Ben Knoble <ben.knoble@gmail.com> wrote:
>>
>> Just leaving some breadcrumb notes…
>>
>> On Mon, Sep 28, 2026 at 8:05 AM D. Ben Knoble <ben.knoble@gmail.com> wrote:
>>>
>>> On Mon, Sep 28, 2026 at 5:50 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>
>>>> On 27/09/2026 20:21, Junio C Hamano wrote:
>>
>>  From my local version of the branch, the following script points at
>> 4f65642eb0 (Merge branch 'tb/rerere-lock-grace' into jch, 2026-09-27):
> 
> And within that topic, bisect points to 2d1fa0323f (rebase,
> cherry-pick, revert: run auto maintenance when done, 2026-09-17)

Oh, when I was thinking about this over lunch I did wonder if that might 
be the culprit. Previously we didn't run "git maintenance --auto" after 
a rebase with the 'merge' backend but with that topic we do, and because 
we set GIT_COMMITTER_DATE to sometime in 2005, if 'git reflog expire' 
gets triggered it will expire the reflog entries that 'git pull 
--rebase' relies on. As you suggested in another mail, I assume this 
topic has changed something in one of the '--autostash' tests that come 
before the failing test triggers which the new behavior. What that 
something is I'm not sure; off the top of my head I'd expect the number 
of reflog entries in HEAD to be the same but maybe I'm missing 
something. Adding

	git config maintenance.reflog-expire.auto 0

to the 'setup' test fixes the test failure, but it would be good to try 
and understand why this topic triggers the reflog to be expired in case 
there is something nasty happening that we've not thought of.

Thanks

Phillip

> in
> t5220.69 as Phillip said.
> 
> expecting success of 5520.69 '--rebase -f with rebased upstream':
> test_when_finished "test_might_fail git rebase --abort" &&
> git reset --hard to-rebase-orig &&
> git pull --rebase -f me copy &&
> echo "conflicting modification" >expect &&
> test_cmp expect file &&
> echo file >expect &&
> test_cmp expect file2
> 
> ++ test_when_finished 'test_might_fail git rebase --abort'
> ++ test 0 = 0
> ++ test_cleanup=$'{ test_might_fail git rebase --abort\n\t\t} || eval_ret=$?; :'
> ++ git reset --hard to-rebase-orig
> HEAD is now at cb9bf26 to-rebase
> ++ git pull --rebase -f me copy
>  From .
>   * branch            copy       -> FETCH_HEAD
> Rebasing (1/4)
> Auto-merging file
> CONFLICT (content): Merge conflict in file
> error: could not apply f29aa66... file
> hint: Resolve all conflicts manually, mark them as resolved with
> hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
> hint: You can instead skip this commit: run "git rebase --skip".
> hint: To abort and get back to the state before "git rebase", run "git
> rebase --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Could not apply f29aa66... # file
> error: last command exited with $?=1
> 
> 

