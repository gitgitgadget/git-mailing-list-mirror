Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB6747F
	for <git@vger.kernel.org>; Thu,  8 May 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685275; cv=none; b=VYHkS0IaTs34bHEJoJBI41AgiP3xYoP7cWRMCA+kMhxIoZZK3JX9K38LUw69mv1H1+u/cCcwUcOTnlL2Hx7QaEVd6xPQuP3GJ023urB+zcle4WoGx7ftlbwOvB9naWu7lEmRzu35BTUG9RnGbqCbpD+htV7VW95UajaxrumMpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685275; c=relaxed/simple;
	bh=wvbkEI54TRwFpWrBzb5zyBAbF2NtvXAeHEsb2Qeo8Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQfz67v3MbKtIJlmWiwvyIC9SV2xZGpXD+u9NT5QWt8RIuKM+cx+RIE/5z9yFZIxQWozfGuyU0sYDJfFDcVdibTWW6X/IQiYchR3LY9s/oQfQGgoY598hW4Yq86pMfUW3f8g/RYyVxJfvznrtRgRa/GVrFzqKU0v0+Y4noxy9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZtMTL4y4hzRq26;
	Thu,  8 May 2025 08:21:10 +0200 (CEST)
Message-ID: <4ef123de-a338-4c06-8983-aa6c5380ad13@kdbg.org>
Date: Thu, 8 May 2025 08:21:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] gitk: Support of SHA256 repos
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, git@vger.kernel.org
Cc: Denton Liu <liu.denton@gmail.com>, Eric Huber <echuber2@illinois.edu>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Avi Halachmi <avihpit@yahoo.com>, Christoph Sommer <sommer@cms-labs.org>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20250320154136.23262-1-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250320154136.23262-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> Hi,
> 
> I recently stumbled on the problem of gitk with sha256 repo (while
> testing the new openSUSE package git workflow that enforces SHA256);
> gitk aborts immediately with a message "Can't parse git log output:
> {commit xxx..}".
> 
> After skimming over the net, I found the patch [*] posted in 4 years
> ago to add the support for sha256, but nothing happened since then,
> unfortunately.
> 
> So here is the revived patch for gitk to add sha256 support, with
> cleanups and corrections, in addition to the enhancement patch for the
> missing auto-select length config for sha256.
> 
> Only lightly tested on a few sha256 repos.
> 
> 
> Takashi
> 
> [*] https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
> 
> ===
> 
> Rostislav Krasny (1):
>   gitk: Add a basic support of SHA256 repositories into Gitk
> 
> Takashi Iwai (1):
>   gitk: Add auto-select length preference for SHA256
> 
>  gitk-git/gitk | 96 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 71 insertions(+), 25 deletions(-)
> 

Thank you.

After these patches, I still see a  few mentions of "40" that refer to
object id lengths and are not converted.

- a comment above proc longid
- a regexp in proc shortids
- in proc setlink
- in proc mkpatch
- in proc mktag

They should be converted, too, I think.

-- Hannes

