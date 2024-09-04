Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEF4D5BD
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430565; cv=none; b=AwxoVrgUr63/pfUCikEZgnqEvP/Lf8A5thyzj0wqRa9Lbd6AZn50RDfeM0t7aio9bkwJeQUZYnwem/8fOXupqe+OFywFtqqKaK7aCW2iALuREGyoAm8UCRqpmWVr+sWYY6TH6VVjdPPbZwjMP6INAQUWkPBnzMnLOtmttKVinP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430565; c=relaxed/simple;
	bh=SzpQrdm1JiOhT5EooIWJhrbBpYc6b7NADlqAO+FDv3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=me42TCd7xg+CX7hqks8nWo76oI7OsDpSXNVY39nTP4JFwZXSkwwKBB9SXBJKwYEqjJi99qxaKxwnGTamUx92WUVvw5IDB7Xw2SlpEhD/TX28nh/zArTRT56gQSN3I1iNXGkk43Ju4mPKPT99d/cLb33Dm/2PeCQQqtPOxQGGIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WzC0q2nFLz5vYd
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 08:15:55 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4WzC0f0QdKzRnmG;
	Wed,  4 Sep 2024 08:15:44 +0200 (CEST)
Message-ID: <a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org>
Date: Wed, 4 Sep 2024 08:15:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IGBnaXQgZmV0Y2ggLS1yZWZtYXA9PHJlZnNwZWM+4oCmIDxyZXBv?=
 =?UTF-8?Q?sitory=3E_=3Crefspec=3E=E2=80=A6_=60_providing_NON-empty_=3Crefsp?=
 =?UTF-8?Q?ec=3E_to_the_--refmap_ALSO_causes_Git_to_ignore_the_configured_re?=
 =?UTF-8?Q?fspecs?=
To: Han Jiang <jhcarl0814@gmail.com>
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.09.24 um 06:09 schrieb Han Jiang:
> What did you expect to happen? (Expected behavior)
> 
> In `git fetch --refmap='+refs/heads/branch1:refs/remotes/server/branch1'
> server branch1 branch2`,
> `remote.server.fetch=+refs/heads/*:refs/remotes/server/*` merges with
> `--refmap='+refs/heads/branch1:refs/remotes/server/branch1'`,

The way I read the documentation of --refmap, I cannot infer any sort of
merging of refspec, only that a replacement occurs.

> so these should be what would be done:
> branch1 -> server/branch1
> branch2 -> server/branch2
> 
> What happened instead? (Actual behavior)
> 
> In `git fetch --refmap='+refs/heads/branch1:refs/remotes/server/branch1'
> server branch1 branch2`,
> `remote.server.fetch=+refs/heads/*:refs/remotes/server/*` is replaced
> by `--refmap='+refs/heads/branch1:refs/remotes/server/branch1'`,
> so these are what would be done:
> branch1 -> server/branch1

So, this seems the correct output, because it is no longer specified how
branch2 should be stored locally.

-- Hannes

