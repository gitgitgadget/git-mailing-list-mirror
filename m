Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5510A18
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644631; cv=none; b=VxUGfaoMKwfd0aKoZ3SsT26V5GMpk9HI0fna9UqgQ2W7cuPVWVun5xwihyZlTldjlYzAhq/PhBO1L0qDTACo/tVyg676h56v32TBxLU9GqQ0RdayM/Jzqv47DlnGxY6iNxcleXlWOu6C1gADct0HMjr5Rb5ACmKUzR9keWLgNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644631; c=relaxed/simple;
	bh=/x/wzZr9u/1NsAh66//kMU3LpVp6k8ENo8YenTdvx3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkN7TBY/bYEQbPHz8uWYYv+77GboCu0qAi549Xov4QIpHaUZ0IBC4XjkWYdbp5buHg6wsHJKTrRmC7JcrwVO3kR+QiIS4s1uTekprQs5r72lnKVwEsq5u5u0N3HKMxkNxWGw9nVEoosAjGOAirgpL4WGf7ZnHBWpZcJ4Ax2NDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4X0k9Y6tBXzRnlK;
	Fri,  6 Sep 2024 19:43:44 +0200 (CEST)
Message-ID: <a8ed352a-bcb8-4e62-945a-ac5d6ff78841@kdbg.org>
Date: Fri, 6 Sep 2024 19:43:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
Content-Language: en-US
To: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
Cc: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
 <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
 <61b9b041-97cf-47ac-84ef-1467aba873e3@kdbg.org>
 <AS2PR08MB828842126285586C19028FB5E19E2@AS2PR08MB8288.eurprd08.prod.outlook.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <AS2PR08MB828842126285586C19028FB5E19E2@AS2PR08MB8288.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.09.24 um 08:32 schrieb tobias.boesch@miele.com:
>> Von: Johannes Sixt <j6t@kdbg.org>
>> While testing I configured meld incorrectly once and got no feedback
>> whatsoever, but I would not attribute this to this patch.
>>
> 
> That's odd. I tested this again by setting merge.tool to "meld" and
> configured mergetool.cmd to "some wrong path". When starting the
> mergetool I got a popup saying that meld was not found in path.
But if the configuration is

   cmd = "meld far too many arguments provided"

and 'meld' *is* in the path, then there is no feedback because meld can
be started successfully, but reports an error only on stdout or stderr,
which is ignored by Git GUI. And the exit code seems to be ignored, too.

But this can be treated in a follow-up patch if necessary.

-- Hannes

