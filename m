Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2211E5700
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957743; cv=none; b=XGRQ6/2pYIUSVd3NEOg2FYiOUQ1eRwR5uVshtvMtbat6vQdExoG1uzlihAPNBW38tst20u4dzQxRDu6caSmaF2sPpDFXww6fwBF5rIdby/4ov23f7pknWz83ADabO0FQmMY/TMaNO9siU1KPdGJbyWJR438pRkGuf65BavfkAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957743; c=relaxed/simple;
	bh=IGuEYvtCuLU4MAmVO5xriyAVuyUau/L+Ze5wbuBLL+8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t3emDhMlKqo22j5NBit3dp8/o4CXhfpl5pxtzI89+Ld6ec40L8dAdwVAIlIFMrutxjWJFZ/Vex+M3K9Aq/WsRiXIOcxAtYyt1TY0Bqe2wXuxsHu/rFpwW9Kj18DdGIbHZCtALT5E5eZ46OMmPdgjHyjDfiJP3e67xscTUYPcB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoJ4kL1B; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoJ4kL1B"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d403b1d050so1030606d6.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731957740; x=1732562540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5cmujUrs0kHwbY1j6DgmIhxmWmWzv0+53hXqHfFGK4=;
        b=HoJ4kL1BTO/9++XYOJGBCYf3TEH8fenBNgPHuBEtEo8WDjzSpAQOCsMwH82Z035efD
         yhISKFOfFBCCOixuWGO0aJx/w/9R8hIp4wZwh/TODrk+sor6o6v0lo5eQ6Q6f6RnlIdW
         wTbzIbjtOloDEgM22pqAHiHCaSC3gcdDs6+MxmNAFHIMri1DyN3UZALmCPwcOJVaL0K4
         j9JI4jEi353Gjldj3Pez3hPpRI7lm37QDyUhrad4sKiVxGZ863MIthXruXXB+dn9qoox
         o9CMvMC1ZuR98j3hYSVydogLsfpdmyLIc5uLqsJ9Sivs8NdgCyBy6PIUTNI0NY58h2pG
         Ktxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957740; x=1732562540;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5cmujUrs0kHwbY1j6DgmIhxmWmWzv0+53hXqHfFGK4=;
        b=joVAjmC837zYm5QylB6278KMGeaczptMXI9macVDAMSoAALhwrfaV6/MsCJRf9doQf
         8pr5eu/bsCseLLFTI1t5MMziiSdfe3Z6zaubN/EwXKPqNnl8iy20c8/u2fUSdldZ923B
         EteTAmnnkejR+yqve05DKmsOT2ZkXuzWpnLc+7tH6e6a54/REtM860ZwfeNiwYeU7lZD
         Hhm8VnAVJsA6tckZblTshQZyEu011rjeJP5R8u6IQsB1OPaofJtsP4xhQ89FjUL1aDmm
         K4S+Hy59C6RzgsQN0u4S5VWLLNDerIuORVPrpBwwZ3jiKrZu7qE+oQ7w827sJsz7mJiN
         JfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpWN2FIAhnKtwIkJDFmK7hHAAWA4TFgZLf4OwMwZcBfrXa6TSYfbuDQClcI7yHE2QqZcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3l4BHHzEeRIX6Mp2p78krn0HCe1rBaM79Bzou1FbJDHqnI1C
	WU2mhVfozzdwqG/cR/Aj4SrYOxJ5g26e8NK1v9KBP4uWKCodNu198cQEzA==
X-Google-Smtp-Source: AGHT+IHN05p+ftRy9UHQuhoqQ7OQxq3kwP7KFEfjDZXQmS+5LCzK43T5VZCePPd4ezIyJDB4g/4rJQ==
X-Received: by 2002:a05:6214:b62:b0:6d4:22d4:f5b6 with SMTP id 6a1803df08f44-6d422d4f83cmr73757546d6.10.1731957740417;
        Mon, 18 Nov 2024 11:22:20 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:6fc4:882f:9015:71cf:9197? ([2606:6d00:17:6fc4:882f:9015:71cf:9197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd1fcdesm39296296d6.77.2024.11.18.11.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:22:20 -0800 (PST)
Subject: Re: Possible bug in Git submodule update --inti
To: =?UTF-8?Q?Bech_Christensen=2c_S=c3=b8ren?= <Soeren.Bech@bitzerdk.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <DB9PR10MB709879A45AABEC017F3E89DF8A272@DB9PR10MB7098.EURPRD10.PROD.OUTLOOK.COM>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8db6eba3-a151-3819-159b-921a6c3f3242@gmail.com>
Date: Mon, 18 Nov 2024 14:22:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB709879A45AABEC017F3E89DF8A272@DB9PR10MB7098.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Søren,

Le 2024-11-18 à 03:14, Bech Christensen, Søren a écrit :
> 
> Hi
> 
> I am trying to replace a submodule of a repository with a rewritten version.
> Somebody added a huge json file without enabling lfs, so I cannot move the submodule to GitHub without the rewrite.
> 
> The path of the submodule is: ./Submodules/Lodam.Standard, which I have no intensions of changing.
> 
> The url of the original submodule is: https://lodamrd.visualstudio.com/Features.Net/_git/Lodam.Standard
> The url of the rewritten submodule is: https://lodamrd.visualstudio.com/Features.Net/_git/Uniware.Standard
> 
> 
> I planned to do a:
> git submodule deinit -f <path-to-submodule>

Here you deinit the submodule, such that the "submodule Submodules/Lodam.Standard" section is 
removed from the config file of the superproject: this submodule is not considered
active anymore.

> git submodule set-url -- <path-to-submodule> <new-url>

Here you use 'set-url' to change the submodule URL. The man page states [1]:
"Sets the URL of the specified submodule to <newurl>. Then, it will automatically 
synchronize the submodule’s new remote URL configuration."

In your case, this modifies the 'url' config in the 
"submodule Submodules/Lodam.Standard" section of your .gitmodules. 
However it does not do anything else, since the submodule 
was deinitialized above. This is mentioned in the doc for 
'git submodule sync' [2]: 
"It will only affect those submodules which already have a URL entry 
in .git/config (that is the case when they are initialized or freshly added)."

> git submodule update --init <path-to-submodule>

This re-initializes your submodule, which copies the new URL from .gitmodules
to the 'url' config in the "submodule Submodules/Lodam.Standard"
section of your '.git/config', as mentioned
in the doc for 'git submodule init' [3]. Note that this is _not_ 
the exact command that you ran according to the trace output below, which is:

> D:\temp\Mjolnir [develop ≡ +0 ~1 -0 !]>  git submodule update --init --remote ./submodules/Lodam.Standard

Notably the '--remote' flag changes what happens next:
- without --remote, Git tries to checkout the submodule commit recorded in the superproject
- with --remote, Git tries to checkout the commit at the tip of the remote HEAD of the submodule [4]

I'll discuss what happens with '--remote' since this is what you appear to be using.

After writing the url to '.git/config' as noted above, Git checks if
it needs to clone the submodule. In your case it does find a Git repository for the 
submodule at .git/modules/Lodam.Standard, so it goes on to the next step.
Next it fetches the submodule remote to get the latest submodule commits
(since --remote was passed). We can see in the trace output that 'git fetch'
is invoked. This will thus fetch the default remote in the submodule 
(usually called "origin"). The URL used for this fetch is the value of
'remote.origin.url', which _still_ points to https://lodamrd.visualstudio.com/Features.Net/_git/Lodam.Standard
because none of the previous commands have updated it.

> But actually the sources for the submodule is fetched from the original (same commit SHAs  as before), whereas if I do:
> 
> git submodule deinit -f <path-to-submodule>
> git submodule set-url -- <path-to-submodule> <new-url>
> git clone <new-url> <path-to-submodule>
> 
> I get the submodule from the new url with the rewritten commit SHA’s.

If you manually do a 'git clone' you indeed to get the new objects from
the new URL, but the Git repository is not put into .git/modules/Submodules/Lodam.Standard
as is the case with 'git submodule'. Plus, you still have the old repository at 
.git/modules/Submodules/Lodam.Standard, so it is not a good solution in my opinion.

I think what you'd want to do is simply:

git submodule set-url -- <path-to-submodule> <new-url> 
git submodule update --init --remote

This will fetch the new URL and checkout the tip commit of its HEAD branch.
You will still have all the objects from the old URL locally though. If you want
to avoid that, you should completely remove the Git repository of the submodule:

git submodule set-url -- <path-to-submodule> <new-url> 
git submodule deinit -f <path-to-submodule>
rm -rf $(git rev-parse --git-dir)/modules/Submodules/Lodam.Standard
git submodule update --init --remote

Hope this helps,
Philippe.


[1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-set-url--ltpathgtltnewurlgt
[2] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-sync--recursive--ltpathgt82308203
[3] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-init--ltpathgt82308203
[4] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt---remote
