Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8625DCE0
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748324; cv=none; b=U15E0GK0B7kg1S9TUGiE3BnDmSvR7YWTZlrhrxnY3o9jZL1KWp+Gd5Y+PX/sKeG77/YmhA9gBoSEHuNdA1wABRPfe8WYOLVx+mSr22Tkq4AxYqK8ymLECQNcXi3hW8WUi6Hyf30FJHkpdgyrI2YYHGZRf8mhnlctOO9DVwbPnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748324; c=relaxed/simple;
	bh=8PLWip+POp7NOCDsC44lOpJZwFVWB52OIgwK6RUEO9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I55ZQNMC5TDxp8YyYK5vpqrKi/dbEg9L3NmreSVUi7QY8kXThvzi+ChvhSrSjjnJeFV0BSiZuggbzK/uFuuxgZFU2UxmEZhrvyeC3oxLI+W9qPbr8POWlTulHcI424XhbvK4CgnV4WfRarVNhQ+d2wEwdp8hPYqr27oz/0psfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=DVlgdxoV; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="DVlgdxoV"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1uovki-006OQq-JJ; Thu, 21 Aug 2025 05:14:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Bzqa/iZ32qeBV9/b7HtN2oNPdzp4M4REWi/2CcTnRxs=; b=DVlgdxoVraVDbRm2wpVrRRZMd1
	1d0wUqFYrRW0lSy08N5mhZVWGRN//4rnk2E1KnU8ISwuiAaUsba0WSpG7Y8QX9MpwA31mxA8Tqayv
	05eZFKexnMvL70OiywHFkR/k0eBJnaFO9alF7ZG+t7XrJaTj4yRxQZY1pHnQaEBwxNWwGY73yVBE3
	v2NcQ0rrImOxyFHqtR/fcyRCwopTuAsKchjb81PJdER8yLq2p/bB2IDd3BPLQXvHK9wVSc0KB3Wo5
	7BNefaUmcsugTG22F05DcV+j4YTM4lB5VwrooPwEMrM+/0vEmgGWTm/QSjSqkaI7ax4qdWQ+/aS/J
	YrhgUZyQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1uovki-0003no-8X; Thu, 21 Aug 2025 05:14:12 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uovkS-00EvWB-U2; Thu, 21 Aug 2025 05:13:57 +0200
Message-ID: <c9e8f54f-2594-4092-ae41-f1da73e97f6e@howdoi.land>
Date: Wed, 20 Aug 2025 22:13:53 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: subtree: [v2.44 regression] split may produce different history
To: Zach FettersMoore <zach.fetters@apollographql.com>,
 Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

98ba49ccc247 likely introduces a regression in "git subtree split" [1] 
[2]. For some inputs, the split history is incomplete and does not match 
previous git versions.

For

     git subtree split -P somedir

if the history of `somedir` also contains *squashed* subtree *merges*, 
the split history may be incomplete. MWE follows:

```bash
git init mwe && cd mwe

# create history we will subtree merge later
git checkout --orphan deeper
touch two_deep && git add two_deep
git commit -m 'deeper: a nested subtree'

# create top-level project history with one
# subproject in a directory sub/
git checkout --orphan main
git reset --hard
echo 'A test for git-subtree'>README.txt
mkdir sub && touch sub/README.sub.txt
git add .
git commit -m 'Initial commit'

# add "deeper" branch as sub/deeper
#   the --squash is important here since it omits
#   "git-subtree-mainline:", which 98ba49ccc247
#   looks for in `should_ignore_subtree_split_commit()`
git subtree add --squash -P sub/deeper deeper
```

Now `git ls-tree --name-only -r main` looks like this:

     README.txt
     sub/README.sub.txt
     sub/deeper/two_deep

We can split `sub` off as its own top-level history.

```bash
git ls-tree -r --name-only -- \
   "$(git subtree.sh split -P sub)"
```

Before the patch, that looks like:

     README.sub.txt
     deeper/two_deep

Which is correct. After the patch, there is only:

     README.sub.txt

which is missing the entire `deeper/` directory. (The hash output from 
`split` is also different.)

I suspect the test in `should_ignore_subtree_split_commit ()` 
inadvertently rejects commits that should be kept.

I tested with Git binaries from v2.43 on Ubuntu [3].

[1]: 
https://git.kernel.org/pub/scm/git/git.git/commit/?id=98ba49ccc247c3521659aa3d43c970e8978922c5

[2]: 
https://lore.kernel.org/all/pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com/

[3]: 
http://archive.ubuntu.com/ubuntu/pool/main/g/git/git_2.43.0-1ubuntu7.3_amd64.deb
