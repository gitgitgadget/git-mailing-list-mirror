Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852A2D3725
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025037; cv=none; b=KfkR4Frw8iYrKtC8vBpf7nwZ4tLX0o9jStaypWBuq1Kw6P7cZAqzyJg726X2PQZGei5Fx74SJe3bZPKr1BKghnPLN0ig5EdQMoyZJ0btM1RYWSo427AF6aBf9lbKLROTkpEmpLYbNqjzooGigJDQzoM4Ky6z+EV0a62UpwlEMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025037; c=relaxed/simple;
	bh=xsZScF3n8cXqZj6PudJsryFYg1wMmzQdyABEwu8yNTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1mr08HULkbCO/UmPSvyjC9Ty4KsN8oWO3YcPBG2qU45xrotwxatPd2+phquzXoWp2Jy0CNkQa83H1AhB+MP2KLbyNbZzaFnpEXU3OIW8wt/HjpKFfUAqxKwbglMOhkOvLeJUIU2RVDo/iezyJkhGRJf0DJvPD5EgdeSunBrxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay4Xnpyv; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay4Xnpyv"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso38517805e9.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770025034; x=1770629834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cmlfSpMEo/YiyLi1oKZgl2QGgr2yIaoUk2MKo/ecEJQ=;
        b=Ay4XnpyvGWVVb9EU8tpHUvKTxWheWYsI8c7wOrbW8ixn80FkbgNQNDd+SZz66jAyCE
         af4O1Kcp0mDD0l0N0npOlBueorteAMYTv5GsCdO0IJDtLIAOYodlLp17zqBoPf3rG2kp
         nUoidyJ8QV0d9RAziL8vldMebWvOPLPEyDQxnpFFcqd2YR2n1ubL+OpK775IY3kJSc6k
         iwhBcgPI+2qKfHo66tPyJKakQwREPClz4R7N15H6oG6FD8uyFDY4pMMlZNVRvzqF7ZEW
         mTa2o1DAItdyCa0disGsk1o1SkCNOCbsc8oZM5Jy45kfo3rNPZheVhhEOvOi1pHv6XwP
         j6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770025034; x=1770629834;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmlfSpMEo/YiyLi1oKZgl2QGgr2yIaoUk2MKo/ecEJQ=;
        b=da8JvvJH/+m6wmTsAyHaadbc1hF74nqDG3yShoygxgqSUKiht2+iJm1U8wjwWEb/l0
         AiddasvKXLmi6hr2fOBkIMtyQ8Aa6Z2Vv0sREMIP1TdhsmvLgFOAhMf4D+yC7MRqBvME
         SXdK+obUI1PwTgbL3XlEEqIqUfRTRiCMVxiHnWle5mNUr/LN6hc/rlbZAtHGjKc7iaLU
         jFovNS9ptowaHnovFL8zxQ1++TQ/ZKbwcby4/Sn0QKuk8SI/A/cxwQsg1r8oJFJb2HHE
         L6pGkUtBz+CBjmJfe9mJaJ+VLm96qyebDUhdlob+oJpPl7oFe0ta1Bcg6Q33rafEwuB2
         ULhQ==
X-Gm-Message-State: AOJu0YzZ+//27e27UFu1Ro2mPAFSWDEqkJ1H+pYgjUREclqy+LMerz9z
	ZbQf7Ig8k3KjMGOWdu5TIXh0O0lSkyQo628pogYpHoQkehOPsNttMiQi
X-Gm-Gg: AZuq6aK1hOMveanzxhN+bjtACvMdJsx89QlYr7NHzHVWWDuhs1Bk4Zngkb+YikC4e4e
	zsPAtv52gSz4xNlcFghbeBgwAjha2DPKbgzszVSiW90OXPtVBqHAmJ6ePXRBhJwPB0Y8JiVzcLK
	ZA7fK0Fb1h3IU41qqw35tXKoNSIM1EcNTH/huuQaGZD68ZSj0WXtEtFBt25DV03yNB2/CHrRQCw
	w8IDN3ozRAEDhjHt+UA0UEJRfTYzgg65tcVyO6DmjTW+4gdlvtoFjYarik3w36rWN1aWRns8Fd0
	4pg7L/g/eekGglvRr9VNYAnWdFNu1w0WaWm5rdSE7I/vW1VIl9hVl3hIr+YrP+Trgw0o4pl1NLB
	BZmx0qoylSRF9gJONuZTqxz8kfmozg0Cu78+AFsDAaL1f8/WSCEyP/AxDBeqLiOLy0QBW08Vq9b
	ASOrIDN8vYnQMAoPaet0T1eiyuWbpulOheobS+DFCFcxPTwagqouVz1f+dftSHatX5Eg==
X-Received: by 2002:a05:600c:1385:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-482db497d9bmr138633035e9.33.1770025034139;
        Mon, 02 Feb 2026 01:37:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353f8bsm40572190f8f.39.2026.02.02.01.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 01:37:13 -0800 (PST)
Message-ID: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
Date: Mon, 2 Feb 2026 09:37:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
To: Harald Nordgren <haraldnordgren@gmail.com>, gitster@pobox.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
References: <xmqqv7gh4mpw.fsf@gitster.g>
 <20260131202232.9213-1-haraldnordgren@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260131202232.9213-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2026 20:22, Harald Nordgren wrote:
>> So in that sense, I do understand why somebody may find it useful if
>> there is a handy short-hand for refs/remotes/origin/main (or
>> whichever branch is pointed at by refs/remotes/origin/HEAD) in the
>> above picture.  And refs/remotes/origin/HEAD already does have a
>> handy short-hand, which is 'origin' ;-).
> 
> 'git checkout origin' doesn't work without resulting in a detached head.

That's expected because it refers to a remote tracking branch. Please 
correct me if I'm wrong but I think maybe what you're asking for is a 
shorthand for the branch "$b" where

	git push origin $b

would update the remote tracking branch pointed to by "origin/HEAD". 
I've not really thought this through but if that is what you want maybe 
we could add "@{local}" to give that branch. Then, with the default 
refspecs and with "origin/HEAD" pointing to "origin/master", 
"origin@{local}" would be "refs/heads/master". If you created a feature 
branch with

	git checkout -b feature origin

and you wanted to merge it into the local branch corresponding to the 
default branch on its upstream remote you could do

	git checkout feature@{upstream}@{local}
	git merge feature

I don't really understand what you're trying to achieve and I'm not sure 
if the suggestion above is a good idea but it might help understand what 
it is you're trying to do. Below you say you don't work directly on the 
main branch but then later on you're then creating a release from it. Is 
"main" just a mirror of "origin/main" or are you merging local work into 
it as well?

Thanks

Phillip

>> As Kristoffer said in another message [*1*], I would too expect that
>> people would not work on their 'main' (or have their 'main' track
>> the upstream's 'main').  So the utility of the piping to sed we saw
>> above is dubious, unless we are talking about quite different
>> workflow, but I do not think of what that other workflow would look
>> like that makes a neutral synonym for 'main' useful.
> 
> I don't work directly on the main branch.
> 
> However it serves and the only starting point for creating any new feature
> branches. This is the command I use, and would be nice if it could be
> simplified:
> 
>      git fetch --all
>      git checkout $(git remote | rg '^(origin|upstream)$' | tail -n1)/HEAD -b new_branch
> 
> The main branch is used in my work frontend project for the app release
> command, so there I do
> 
>      git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
>      yarn release
> 
> I think me as a non-hardcore Git maintainer spend more time in different
> repos than you two do, so maybe the pain of switching between systems is
> more pronounced. That's my motivation for unifying stuff.
> 
> Just for reference, iterating all forked open-source repos on my machine
> these are the different upstream names I work with:
> 
>      99designs/gqlgen
>      refs/remotes/upstream/master
> 
>      amplitude/experiment-react-native-client
>      refs/remotes/upstream/main
> 
>      Antonboom/testifylint
>      refs/remotes/upstream/master
> 
>      cli/cli
>      refs/remotes/upstream/trunk
> 
>      datastax/python-driver
>      refs/remotes/origin/master
> 
>      dependabot/dependabot-core
>      refs/remotes/origin/main
> 
>      derailed/k9s
>      refs/remotes/origin/master
> 
>      elastic/go-elasticsearch
>      refs/remotes/upstream/main
> 
>      git/git
>      refs/remotes/upstream/master
> 
>      gitgitgadget/gitgitgadget
>      refs/remotes/upstream/main
> 
>      github-linguist/linguist
>      refs/remotes/origin/main
> 
>      go-redis/redis_rate
>      refs/remotes/origin/v10
> 
>      golang-migrate/migrate
>      refs/remotes/upstream/master
> 
>      golang/go
>      refs/remotes/origin/master
> 
>      golangci/golangci-lint-action
>      refs/remotes/upstream/main
> 
>      gradle/gradle
>      refs/remotes/origin/master
> 
>      Homebrew/brew
>      refs/remotes/origin/main
> 
>      jwalton/gh-docker-logs
>      refs/remotes/upstream/master
> 
>      Khan/genqlient
>      refs/remotes/upstream/main
> 
>      kubernetes-sigs/controller-tools
>      refs/remotes/origin/main
> 
>      kubernetes/kompose
>      refs/remotes/origin/main
> 
>      kubernetes/kubernetes
>      refs/remotes/origin/master
> 
>      ldez/usetesting
>      refs/remotes/origin/main
> 
>      liushuangls/go-anthropic
>      refs/remotes/upstream/main
> 
>      matryer/moq
>      refs/remotes/upstream/main
> 
>      mhemmings/revenuecat
>      refs/remotes/origin/master
> 
>      ohmyzsh/ohmyzsh
>      refs/remotes/upstream/master
> 
>      prettier/prettier
>      refs/remotes/origin/main
> 
>      RevenueCat/docs
>      refs/remotes/upstream/main
> 
>      RevenueCat/purchases-ios
>      refs/remotes/origin/main
> 
>      RevenueCat/react-native-purchases
>      refs/remotes/origin/main
> 
>      sashabaranov/go-openai
>      refs/remotes/upstream/master
> 
>      stretchr/testify
>      refs/remotes/origin/master
> 
>      vektah/gqlparser
>      refs/remotes/upstream/master
> 
> 
>> Doesn't repo_default_branch_name() do the right thing without being
>> noisy at all even in a repository without that configured, as the
>> function will fall back to the built-in default?  While I do not
>> think of a workflow in which a handy access to the value the
>> function gives would be so useful that it deserves a short-hand, it
>> would be a reasonable candidate of what to be called "@{default}",
>> if it proves useful, I would think.
> 
> I'll play around with this a bit and see how it works. Thanks for the tip!
> 
> 
> Harald
> 

