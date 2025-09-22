Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846834BA39
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523075; cv=none; b=JbFfWqhzby41WjS7Y+JivrB+4T44PLtVzk9Vor7nw/mVdw7PKp5jBeHkvg/NhdU0i5MmFWJO07O/uz6VwVm+aWZwZjLiVqDLWwnxBwuHHa4R7SP6Tyxou3v5cudQBrQwLTCJUVEMYJfEph1NZXgJb1h33nJI+j0qElzu1x1+1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523075; c=relaxed/simple;
	bh=+hRRCQbR6w0g8Elon72ApU4t33NY8fSIVgHifw0BLhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRaosxJ/sjfKBOpITAesEtJRB3ENVekekiXO1HbDoOXbu6RTEiyT/fpw1AAzkR8M0qnew8z5kDlwyiWUH2Ddkp7MnlGignoiAUidW8rQZjdLPLv78/numRAxgkVKaCKUQrTx+GiAgj4s5GFuSRrvYdUrfa/vW+N6f5M7HPJQM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cVYMC1C4WzRpKn;
	Mon, 22 Sep 2025 08:37:43 +0200 (CEST)
Message-ID: <92bdb432-1f6d-43d9-a93b-8cbaf3c4a7fa@kdbg.org>
Date: Mon, 22 Sep 2025 08:37:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] gitk assumes availability of `osascript` on macos
Content-Language: en-US
To: Eric Sunshine <ericsunshine@gmail.com>, lists@humanleg.org.uk
Cc: git@vger.kernel.org
References: <2994140.eGJsNajkDb@alfonse>
 <CAPig+cTRYK+5ezmGxz0d1TwMTu1RKy7Xj05CzDE2-i14aUpSAg@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAPig+cTRYK+5ezmGxz0d1TwMTu1RKy7Xj05CzDE2-i14aUpSAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 20.09.25 um 21:52 schrieb Eric Sunshine:
> On Sat, Sep 20, 2025 at 8:07 AM Robert Scott <lists@humanleg.org.uk> wrote:
>> Tiny one here. On macos, gitk (tested 2.50.1) attempts to call `osascript` so
>> it can focus/raise the UI. But it fails hard if `osascript` isn't present in
>> the $PATH.
>>
>> There are a number of reasons `osascript` might not be available in a
>> particular environment, e.g. if launched from inside a "pure" nix shell, but
>> seeing as it's just a quality-of-life feature it would be nice if failures to
>> call `osascript` could just be ignored.
> 
> A patch[*] was posted to the mailing list years ago which, I believe,
> should fix this problem for you. Unfortunately, the patch was never
> picked up due to the then-maintainer of Gitk being missing-in-action.
> Perhaps the current Gitk maintainer (Cc:'d) will pick up the patch.
> 
> [*]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco.com/

I've picked up the patch:
https://github.com/j6t/gitk/compare/master...es/ignore-osascript-failure

Please test and suggest improvements. Should the links in the commit
message be redirected to lore.kernel.org?

-- Hannes

