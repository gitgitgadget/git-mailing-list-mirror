Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2D1E9900
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405855; cv=none; b=Iug4BGS1eC46LqRQ5F/DsAiTFRKuhwuh9/DzzHIQ1dwlMZh0r8/b/TpKBagYoXAjkNu7HHjpqyiG3L91sLBWUTnNBFFTn/hv8simpetO8ULgcCSpdP1cjpa/7Yr60P2jIyolRqjl6wA3V4bKV3mdrxA9QOgqH7ahgqKaXgbuDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405855; c=relaxed/simple;
	bh=urcnLFonQUsOb+KuzBRWsyiUaQaXkP3rF65MlJ8rLjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cTMQ7cd0O4HjBmGo01lIGiAyeDYdgw9vcgboRYZDcrm/wBcS2O1Z+Pzsqz4PIV2pKi5sUGBD5w5MaqkdaJyeXRlWomJSW1oIgAaaRmr/Kn4Q40llvRZXVg7Gd7nveR+tUSvj846/TUc9C+8NbRghmmKqCX/NxamKwb6uZOgnT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YcLw52mf8z7QTtT
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 21:07:01 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YcLvx2VqrzRpLF;
	Mon, 20 Jan 2025 21:06:53 +0100 (CET)
Message-ID: <e2ab3d74-2218-4a42-a2f5-019b306e185b@kdbg.org>
Date: Mon, 20 Jan 2025 21:06:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug-Report: Git automerge merges in old content not present on
 the latest commit of both branches.
To: Postolache Andreas <Andreas.Postolache@pierer-innovation.com>
References: <AM0PR0702MB3555EE09E6BFD34A1F1429E1D8E72@AM0PR0702MB3555.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <AM0PR0702MB3555EE09E6BFD34A1F1429E1D8E72@AM0PR0702MB3555.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The behavior is surprising, because I haven't seen git merge do
something wrong since ages if ever.

Am 20.01.25 um 09:16 schrieb Postolache Andreas:
> A:During the auto-merge it added Text from an 5 month old commit,
> that was the 6th newest commit and the 4th oldest. This text was not
> present on either the up-to date main branch or my working branch. 
> This was text from my first commit on the file, which was an .md
> file.
Without concrete data, it is difficult to asses where you started and
what the result should be. Let's start with some `git log` output so
that we all know what the shape of the commit graph is. We'll have to
work from there or maybe you already know what is going on when you
prepare it.

Show the output of

git log --graph --oneline --decorate --boundary main...mybranch -- file.md

Replace "main" by the branch name that you called "the up-to-date main
branch", "mybranch" by "my working branch", and "file.md" by the
path(spec) of the file in question. Mind the three dots and the dash-dash.

-- Hannes

