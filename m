Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CF413787
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610008; cv=none; b=l33sfB4TnI+CBIre8HPNOa/z0wFmBFZOUaZqzIncJcRE79L0dKwWs66qaTdFgmar0rwIq/PxKyz+O0E0CgjAR6QQbYIgiyDkDaN5D4XK6ghwdf8Uljki9CsRzTG0ex5pJZUjrk730gJu1N3tfZ8q8JQkyIyr9UZi6h1D+1ssKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610008; c=relaxed/simple;
	bh=clkEvbmQeIPZ+5R1Yjd0bpZ+lQpLIefx3PlCpJyhaL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeOnsjubRrh9U0l9OF8TVgtBtp8BDy62Fx/u0wFVkSXJ76x9FDG+y98QOP3y4DkxDpudoxHeKkKvn8qmyIlFS/wemObdYkgNebPNGKAn8Q8onbfoch1EXI69ITPVjK+avzkUPmkl2A5g7iVshEysun6J6oUmwW+pypkzrTHu94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLxhJW/1; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLxhJW/1"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so11334515e9.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610004; x=1791214804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iU6X2S9y78ygrj1BJjCfgW2kUGB16wDvBUxWWbZ2hGg=;
        b=RLxhJW/1WCuV7iATLhmdM7p6yB2RE4P1d9rntamEmOsGfW2PmCF2Zvr7GQyYeKVHkW
         67YXXpTIYfTlNCMH586VKI3AW4Fplkms8pC4B+LUa/UbBYuAd4/DBnHsIp8e/IzYhjyg
         aM5t8LszuGtE1eVj8HqNHUqABOTIWOlKUbAaTYGLjsKBfJYUhqQgwyO5hcTdG2MhSdk+
         rAeIdt8zuZg3oreBnV43l221Fmp627oG9DnO05XzJ9bwedwetCs/FoSp++XvF8Qhamrs
         dFQ4fwM91IFVkgrSHhJK1lExdhRX5by1vZeRmrFAUHN/K8cFmtfQrZpTQYrfeJbNLznz
         IBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610004; x=1791214804;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iU6X2S9y78ygrj1BJjCfgW2kUGB16wDvBUxWWbZ2hGg=;
        b=sAAuhfnVdOuc3dEhFIZAs7xDw0ofvlVXCCXyTT1uqgg3GLSZToaLVIGS7HFLPmPLsA
         HWoD45dL9AH4kAnoVNraUZGfxng+XxVWjgC37BZm+ypSi/gL3RbBsc0mTtKGWPlk7u4Z
         lxd9xCZ8U+TsmXm6K3YeSO/hPvW5S+kX0ZsoiCad7kZBisak4Rz31tQr4PrZ1Gts5qiP
         0Fi0rosHbysmFWXFipS61/yWXD24q9DnsigTH4Pwwf2gBLnBAYyhYod+6TObcy4ZuNHg
         APspCkf27vMweDsFp5CWXofIr/EIIQctatmi3Voowl6ATMdeChVYAoivof6wi0fmfhzX
         aUpQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0zhxdGlccG1aI9hsGD52q+BPICne+qjfZ0q0q1E8d3N6mUngb6iOHtzlCcIhm0ME7eRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mntms6/Gyh6eXrXoACC8c8vkn00HaQGFKuxahuucmDEIyaRVP+
	mHE+vQDft6j4o2PwIyGidVpNpBJQCWbdCq/9VrIMzzFKBZ5v7XdF0+v9
X-Gm-Gg: AYBFou0/JhWA5wRTkjIx+8uXzedShne1tNOhlUrIWtSafA8EH8SIdeX9cO5v8IX585c
	LLY3wuN2/5R956b7Q+hWesehMLUxJoWYONWK/Sf3ylsplw+X69+cHil73gnlLqaDuPNtsmaUw1E
	lLejbCMwDVTG90Rp5G2ssTyeRgRzT8wfHxQoaqxinB3e4wf5xMYGtAKK5KLebMfh0MQlyuz7QTC
	5uL2Q1NWsh+O6r2g2HXw76dBqbLrhbcZFHTeqKn2Dh8yC7WDvxNCDG7rpVZCp8iwGNIur+zbfra
	Q+iplXeNXPnKBgn/o/YjLyDTkPKMGbw72RqHdbNAsQrC05wIqePi798RmqOn8bcOSba4cOPyoK0
	H2O8CBBtEJJT962pLaGy27OmjcFFtiv6V8in2ax2/eyTPY7zu31Zgd/G6zf2OWDwhlAZIoEHoy+
	iIXa5h2NVAelcLbKP874gKeoTjDk2lN9tccjZcc4rC2VrRbjq53UXSRL52BX0XHYaC53EncSpyR
	o0aEMqacGly48VH325Z62foIEzJKbF1AVUyqPRpQ7LhhuRBMn96EQ==
X-Received: by 2002:a05:600c:1908:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-49fffa2221emr99570485e9.11.1790610004018;
        Mon, 28 Sep 2026 08:40:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00571744csm80234935e9.13.2026.09.28.08.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:40:03 -0700 (PDT)
Message-ID: <ef5e507f-9e26-4e7e-887a-403cf7f282a7@gmail.com>
Date: Mon, 28 Sep 2026 16:40:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: Thomas Bachem <mail@thomasbachem.com>, phillip.wood@dunelm.org.uk
Cc: ben.knoble@gmail.com, gitster@pobox.com, git@vger.kernel.org,
 eli@barzilay.org, ps@pks.im
References: <cover.1790168285.git.ben.knoble@gmail.com>
 <cover.1790425008.git.ben.knoble@gmail.com> <xmqqjyo6qz3z.fsf@gitster.g>
 <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
 <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
 <CALnO6CDOo35HAfqn_h2CUUdux9LeOkjM8OdFLkkS1nVexijUvw@mail.gmail.com>
 <CALnO6CAf491aNhqcb7K7YcNTSTNLAESmqeLwzEGk_S=ZsOjG9Q@mail.gmail.com>
 <a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com>
 <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 28/09/2026 15:50, Thomas Bachem wrote:
> On Mon, Sep 28, 2026 at 3:45 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> topic has changed something in one of the '--autostash' tests that come
>> before the failing test triggers which the new behavior. What that
>> something is I'm not sure; off the top of my head I'd expect the number
>> of reflog entries in HEAD to be the same but maybe I'm missing
>> something. Adding
> 
> It is eight entries fewer, and they come from the failed merges, not
> from the autostash tests. "git merge" restores a dirty tree with
> "stash apply --index --quiet",

Thanks for tracking that down, I couldn't see where we'd be calling "git 
stash apply" with "--index" but builtin/merge.c:restore_state() calls 
"git stash apply --index --quiet" rather than calling one of the 
autostash helper functions which do not use "--index".

> and until Ben's series that spawned
> "git reset --quiet --refresh", which writes "reset: moving to HEAD"
> to the reflog. That happens eight times in t5520 before test 68.

That accounts for the difference in the number of reflog entries. It's 
good to have an explanation for why we're expiring the reflog entries at 
a slightly different time.

Thanks

Phillip
> Auto maintenance expires reflogs once HEAD's reflog holds a hundred
> entries that the policy would remove, the default of
> maintenance.reflog-expire.auto, and after the first test_tick that is
> every entry. Which run crosses the hundred depends on how many entries
> and maintenance runs came before it. On 'seen' the expiry lands on
> "git commit -m conflict" in test 68, before the fetch writes the entry.
> Eight entries fewer move the crossing past that commit, and the
> maintenance run my topic adds at the end of the rebase in test 68 is
> the next one: after the fetch, before test 69 reads the reflog. Either
> change alone leaves it somewhere harmless, and nothing else is going
> on. The expiry is the usual 90 days applied to entries dated 2005, and
> the only new thing is one more maintenance run per rebase, the same
> one "git commit" and "git fetch" run.
> 
>> git config maintenance.reflog-expire.auto 0
>>
>> to the 'setup' test fixes the test failure, but it would be good to try
>> and understand why this topic triggers the reflog to be expired in case
>> there is something nasty happening that we've not thought of.
> 
> I'd pin the expiry itself instead, as ea7d894f44 (t34xx: don't expire
> reflogs where it matters, 2026-02-24) did for the rebase tests:
> 
> git config set gc.reflogExpire never &&
> git config set gc.reflogExpireUnreachable never &&
> 
> That covers a "git gc" as well, which expires reflogs on its own. With
> it, 'seen' plus Ben's series passes t5520 here and no expiry runs
> during the script at all. I sent it as a patch on master:
> <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
> 
> FWIW, any script that reads a reflog after a hundred HEAD updates can
> fall into the same hole. I have not looked further than t5520.
> 
> Thomas

