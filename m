Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BA135417
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210775; cv=none; b=Tx2XzXfZxmktr7iXi68qyF+H/f6v1bo/fQku2AC8cgWWJJHXiUwLsDM9cGEbjrgbstsZa7LaNwP6bId2nPbk0WMbXWWFsRD+0ySjCPJcATHI0IwRmzL+dQ6qxFyMiJxvLVuz3Kv55xMV+X1lFImyU0NcG/1Ntdd63WvEgbC/rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210775; c=relaxed/simple;
	bh=z1lLZf4g2R7vo7icc0sUSgmoyNcOns1KD9PetDkxYvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsSjQi1RTg9NMuSSDANDhQADz2cAHP2sx0ai+4xs6gxHcTCTLtZO0f/JxEwd8fplJAe2dZCQwF/NZrQoazl/hu5niqKSB/4qsF2a/Ea7gX7iR9NXG57n5zE9eziXGaGOjuBthtNtgL1LDLTqYTjq//KUUOla5mwHlJkSbwSx+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=WapYsLdr; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="WapYsLdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1720210764; x=1720815564; i=antonin@delpeuch.eu;
	bh=z1lLZf4g2R7vo7icc0sUSgmoyNcOns1KD9PetDkxYvk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WapYsLdruHr3V5AsQvB+xxWlDDJNlSH65D1gINNIF3YfBtVMkk9ez5sDioP0LBdY
	 RJoTC3f9TEIlrLGctod5HtfW+7mK360ziQgoKVQUafIYWPWue60dS2bAHyKpygQmJ
	 SAH9HDDdnjVh54ozoI653U68FInbbMXUXfTaYTJ4qZ9NUGVgWKPoZ2LqaJbiFDMIB
	 aQGt8CA94WgbixKwRK9mrIhP85lYItck5PZ1wA0tQQ7oC1DqF1+NGPUgup3Y1WPMw
	 V5qM5ezxyAX/ZW1mpLwgMmWJNtGk6Jhha2z90n/bnWXQGA/Bq+nAJUqevmUKWTISL
	 MvOd0KU6unomLpD6xw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.42] ([84.184.30.43]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MryKp-1s5M5L32BR-00hfP6; Fri, 05 Jul 2024 22:14:06 +0200
Message-ID: <1fd4be07-47ba-4db4-b8aa-860c23b5dd39@delpeuch.eu>
Date: Fri, 5 Jul 2024 22:14:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
 <xmqqmsmycriv.fsf@gitster.g>
 <dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
 <xmqqr0ca9qkj.fsf@gitster.g>
 <CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XRaoQPjYC22rrNjf5tmJ/6PTO6YFNqHC06NfEjjkiRSR3oeMxdn
 WPFL+YjexGQA5gXmXo6d8u+WQnZk5wQTJiue9BzvsBu+PE0sW0MQtIwqQ/hYmgr4J0KGC78
 r982GirXTMLc7AkAZSWaFtMqksuxXXXJSFcKWrqxs4Fms/68XlaJ67w9npnI+Rtm86eGpnO
 AsuYL85wAH54E63kwC4zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LzQLm8nepC0=;/sdwnGz4bIUlEUiJ6YfxvpsI48y
 baq1D+XiLwXE5Rf/oeq8ddAiIw0trVNcDsIQ9YxlkSsmtGrZnqD/lLM5PXdTGwOZvV/tDuqF7
 MurQkFdB3cRsQLqCVLcRdZzThtqoDXdJ9YbiyFNRIPg2Dvv2WZoZlIfJXP/+fZBPXOfBg987r
 kPn5WDHUvjtrgyVwsFq+VSKTxT+OFMlJzEQZR31GVV5EMr0ojkLVYZLzFD56hgNQUys81maBE
 8dc+PdPUFN6Up9zC3aViNzvHHqIaF4QmNYc9IIeVjSTed8DdgnoRXzjZFUFOPGPtp2uLIrctp
 GsSFFJKUEIQ3AOT5tK2sdUvIoSRG1ONLXlUJBO4R4wpLhXS9Cs5CAanXVWEyXK9yXM/3gQ677
 7usqN0rCHhZcfrkhx9UgKiKZP3ikbc2dZ08wZB1TV22Hv0ZIt+WqT2rbxworl3SnzCqUVDot5
 4rOtooKVm2XNnudfYXnzxQCC4Ss9OC/UL2Akkb7zcZ4O6PfFrnRd1F6TyAV87CnSSItP7ZxWN
 XEu+JD5dBSLlSLPf+lL8JrPGD6/0qX0C3pwGc/BikomCR9REUkYudFm+zgY7L+vpC+YS5AMSB
 S3SvFpJqhGpALwnhZ9ueYdgZLFMbSArQ18sxwz/E29cGHFe3/YcWlpVse2T7j0NW0B7Ch8q33
 Z35cuseFpwf8a3Zuvi7yaF2ADlebdW4k4YBhbtNwLgH9Nstln0fDv4ohtkmSBXG61jtnXQbva
 KK9as/O9iYTjB5U9/BcbDFz5o2x3MyzqSbMmArYr9eMP2R2Bf4xxRg=

Thanks both.

It sounds like there is a strong case for at least making "merge-file"
honour the `diff.algorithm` config variable, possibly with more
fine-grained config variables as suggested by Junio. I'll try to make a
patch for that.

Elijah, if any of your work on improving the histogram diff can be
shared (for instance by writing down a description of the issues you'd
like to address), I would be interested to have a look and perhaps help
out if doable. But as far as I can tell there seems to be a lot of fans
of the existing algorithm already, and such heuristics can never be
perfect, so hopefully we can make the switch in a not too distant future.

Best,

Antonin

