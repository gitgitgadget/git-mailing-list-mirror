Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD15129A78
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901947; cv=none; b=KX0VFptBcXXymYfNkaEkA+kuyOR8JjfR+eW6jRPQmbimYuDXsffQT6qiMuotiLVV9bTm8/KAULMRR7nl0T6zIUupbqK44+UYYPWOdWsghq1A03eX6xXYGZwjTDsEI6cl2z1N5DbPQtJcJtCC0QLl/+Dqapf0lr1NXq1ur6/zOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901947; c=relaxed/simple;
	bh=x42bG4dSqMxd48eisA6rtkL/Znb6TN60EA0bf37ynXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fC/H2vzsuwZJ7fQgSnq47rYg4aDVpqfwXhaYAYPaC0y395xInFf3BT3451Xp0f2N+IQf8CZWaUQqFD4MF22Pl3XlkAOnif/odgnO8tKw2hpCCuljD5+p2VAZyBEmAWmliEWDY45TT27UcunUQDM1o3ttAM52kbjZghUrcOwzZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b0zPceUe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCZLQefy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b0zPceUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCZLQefy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E6631D00114;
	Fri, 26 Sep 2025 11:52:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 26 Sep 2025 11:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758901944; x=1758988344; bh=jFk3zOO+f+
	GD3xamexUqMCu3LEJFxCObasQ/8y9s/6o=; b=b0zPceUeu9JeEn+Ak7MSz7679S
	T4IR/GredO1zrywGFbnfh03zrNu95xoKZIsfjmx0ARcu1wqQ1BHoz7FCnn8C5RPR
	AdntG6U6fFkUFWhjQ4kFc4PMARcUaGVLECD9gwD9tKHaMuiIC75TDXcUFjhkrP7H
	0NmqqQqbIaM5lmriI49KCysHK0n0gR+rSHGpyqmsNvIWEPGDAItN0LEdIlGkncwy
	iSu0Rh1O/MmRIuDnddDaINr7/F7ybsEKWWgpVibNIURKaN2tUOWdfJwiMn3wfU0/
	hlvBaFIYDe0csJplV4Vh32f1sSm759tdDnB/vt6+aKuBtCUg/rVt4yP5SVFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758901944; x=1758988344; bh=jFk3zOO+f+GD3xamexUqMCu3LEJFxCObasQ
	/8y9s/6o=; b=cCZLQefypd5Sq3BYqRglqzGAxOEyFyXfR5d0dWpvIsqKtLkkTUG
	4nTEwWGEKSAj0n66cJnoNpOXybMjPFuquBwcU8uxXXM3CQrPSkR+kLPhPk9KElrx
	EO6gTW6Iz26Wm6oEjtrJqIM/0sea+suBBrkmwvV8OytzLUE0CCVWCdoArL5VHJzN
	cDVLfiNuOHPOTxar7DFR7g5IDZL/CsnRPYSNMHR0NWxnVP2meNreCGwco1+1tsdd
	zbwW6WtaxXWVCwnpzvd/sMRQTsa7eqlAB/0zfow+n2zVR2Tx2mQE4h9Sgr0hpvUh
	j0lvJBnNRO/As1NXe6qsClkNprOxZ81PK1w==
X-ME-Sender: <xms:t7bWaPtqd6A6zAj3qoZjhb8xqOnZNfqLd7bbQycYo1TDsIdbRKLHeA>
    <xme:t7bWaB85-2vmwYBnAPk93ONk5pFbG6p345MivJreTQcqBpppw_TObK5FdUeKGd-Td
    rto7iK-oRTp4vX0B2VEpq4d4DPoHR46dzD69kHyh_iEQDNFZqw>
X-ME-Received: <xmr:t7bWaC3p8m6vIiJ09Tfhwn-rDLXJTIyyI3SHDuvbiv2ZNqVx7UjhgmA692rX6Tq3SYGuhMF2fhqkErlOa8smAnmgz7FWGhGz4ZnF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeffedtheevhefffeettdeuleejveetkedvleettdeujeejkeekgfelteekkeff
    geenucffohhmrghinheptghhrhhomhhiuhhmrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t7bWaOAPZHqagVMgLXwuiofm5geA1varOelBkCUfyS2vZ2QVNPua0w>
    <xmx:t7bWaGdKlzt6DtYPtXCZh3FygjSdhUYMqHUWmLFhwn-QCYrefQydJw>
    <xmx:t7bWaD55qCwaL1xRKax5Pm9nE87ZFs6_Y70wfkhwpY5c7HbD526dnA>
    <xmx:t7bWaBWulDJmN5T7epGEiP6YWfKN_ThMu1J8UrJGaqI3iANaHWNxjg>
    <xmx:uLbWaI56PWDnwOcpbN3WMF8Thv7BP1xLFC1VuqUwdLtsF8lErdRH5oe9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:52:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
In-Reply-To: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 26 Sep 2025 01:28:05 +0100")
References: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 08:52:22 -0700
Message-ID: <xmqqfrc9citl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Documentation/technical/commit-graph.adoc | 34 +++++++++++------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Are these the issues?

 - Use ={n} prefixes instead of underlines for the section headers.

 - Use ={n} not #{n} prefixes for the section headers.

 - A blank line between a leading text before a numbered list.

 - Mark-up of displayed materials.

The majority of our pages (I think all of the manual pages) use
underlines.  Are we getting warnings on them that we'd need to
change?  I personally find the underlined style easier to read
in the source text (even though I understand why people would
prefer to use the ={n} prefix style---having to adjust the length
of the underline is a bit more work when retitling).

The remainder of this message does not have any comment from me,
but is left as a reference for others.

> diff --git a/Documentation/technical/commit-graph.adoc b/Documentation/technical/commit-graph.adoc
> index 2c26e95e51..15396f58ab 100644
> --- a/Documentation/technical/commit-graph.adoc
> +++ b/Documentation/technical/commit-graph.adoc
> @@ -1,5 +1,4 @@
> -Git Commit-Graph Design Notes
> -=============================
> += Git Commit-Graph Design Notes
>  
>  Git walks the commit graph for many reasons, including:
>  
> @@ -39,6 +38,7 @@ A consumer may load the following info for a commit from the graph:
>  Values 1-4 satisfy the requirements of parse_commit_gently().
>  
>  There are two definitions of generation number:
> +
>  1. Corrected committer dates (generation number v2)
>  2. Topological levels (generation number v1)
>  
> @@ -122,8 +122,7 @@ can be stored in the commit-graph file using the 30 bits available
>  to topological levels. This presents another case where a commit can
>  have generation number equal to that of a parent.
>  
> -Design Details
> ---------------
> +== Design Details
>  
>  - The commit-graph file is stored in a file named 'commit-graph' in the
>    .git/objects/info directory. This could be stored in the info directory
> @@ -149,8 +148,7 @@ Design Details
>    helpful for these clones, anyway. The commit-graph will not be read or
>    written when shallow commits are present.
>  
> -Commit-Graphs Chains
> ---------------------
> +== Commit-Graphs Chains
>  
>  Typically, repos grow with near-constant velocity (commits per day). Over time,
>  the number of commits added by a fetch operation is much smaller than the
> @@ -158,7 +156,7 @@ number of commits in the full history. By creating a "chain" of commit-graphs,
>  we enable fast writes of new commit data without rewriting the entire commit
>  history -- at least, most of the time.
>  
> -## File Layout
> +=== File Layout
>  
>  A commit-graph chain uses multiple files, and we use a fixed naming convention
>  to organize these files. Each commit-graph file has a name
> @@ -170,11 +168,11 @@ hashes for the files in order from "lowest" to "highest".
>  
>  For example, if the `commit-graph-chain` file contains the lines
>  
> -```
> +----
>  	{hash0}
>  	{hash1}
>  	{hash2}
> -```
> +----
>  
>  then the commit-graph chain looks like the following diagram:
>  
> @@ -213,7 +211,7 @@ specifying the hashes of all files in the lower layers. In the above example,
>  `graph-{hash1}.graph` contains `{hash0}` while `graph-{hash2}.graph` contains
>  `{hash0}` and `{hash1}`.
>  
> -## Merging commit-graph files
> +=== Merging commit-graph files
>  
>  If we only added a new commit-graph file on every write, we would run into a
>  linear search problem through many commit-graph files.  Instead, we use a merge
> @@ -257,14 +255,14 @@ lock-file.  When the file is flushed, we rename it to `graph-{hash3}`
>  according to the computed `{hash3}`. Finally, we write the new chain data to
>  `commit-graph-chain.lock`:
>  
> -```
> +----
>  	{hash3}
>  	{hash0}
> -```
> +----
>  
>  We then close the lock-file.
>  
> -## Merge Strategy
> +=== Merge Strategy
>  
>  When writing a set of commits that do not exist in the commit-graph stack of
>  height N, we default to creating a new file at level N + 1. We then decide to
> @@ -289,7 +287,7 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
>  number of commits) could be extracted into config settings for full
>  flexibility.
>  
> -## Handling Mixed Generation Number Chains
> +=== Handling Mixed Generation Number Chains
>  
>  With the introduction of generation number v2 and generation data chunk, the
>  following scenario is possible:
> @@ -318,7 +316,7 @@ have corrected commit dates when written by compatible versions of Git. Thus,
>  rewriting split commit-graph as a single file (`--split=replace`) creates a
>  single layer with corrected commit dates.
>  
> -## Deleting graph-{hash} files
> +=== Deleting graph-\{hash\} files
>  
>  After a new tip file is written, some `graph-{hash}` files may no longer
>  be part of a chain. It is important to remove these files from disk, eventually.
> @@ -333,7 +331,7 @@ files whose modified times are older than a given expiry window. This window
>  defaults to zero, but can be changed using command-line arguments or a config
>  setting.
>  
> -## Chains across multiple object directories
> +=== Chains across multiple object directories
>  
>  In a repo with alternates, we look for the `commit-graph-chain` file starting
>  in the local object directory and then in each alternate. The first file that
> @@ -369,8 +367,8 @@ their custom environment:
>      access to the new chain until its chain is updated to reference those files.
>      (This may change in the future [5].)
>  
> -Related Links
> --------------
> +== Related Links
> +
>  [0] https://bugs.chromium.org/p/git/issues/detail?id=8
>      Chromium work item for: Serialized Commit Graph
