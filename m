Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4554501A
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426987; cv=none; b=E+OeRrGFYEEw3ivPCOQ52dPWjUpGbPm44S7XP1SoMzneFBZfiGE6PpvSxtE+1KChnmsFc8c020zXKeE9mh2tC5Zq/xt+rAz/Y5K1dkte9zIeDC2tfw2oCqYndPAl6QklJj2m/n7jxhXqoH+FqDPkbWvL68nvaT5q1iO5oQ3UQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426987; c=relaxed/simple;
	bh=Wcbdm58epJ2FWdCpWXWnjolq4/Hc/XwUmw4hyT+QnKk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Re4HRkDaDGOOmnvkKXEQHU+pc56WcDugeRSD06ujnGihYkDRG9BHzhec5y397423ndQ6CvDWsKe0/C/DbV0UsE94Vxh3E6xBSkf8ZfWyJe9TG0OxvggNvAEXeKWGAZ/NxYjzCu+YdwrEytndD3Dx+43Di+0U642mN92SVv1jkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=i9S5oKLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v1V3blVy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="i9S5oKLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v1V3blVy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 362DA1D00119;
	Thu,  2 Oct 2025 13:43:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 13:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759426984;
	 x=1759513384; bh=5SZKmQOKJvmwB49FYa+WnrLjIabJegKAY3V3rWgo2To=; b=
	i9S5oKLErHLzuzZiioFEgLKdriFC9Sf0MORlR6CGGEyLAvJTkTbxuC+Y65G+r5n8
	H28kktMCvUsCHyayNvYZ1F3nbYk7gRbbUCXPco8sGhHaYzAjyJjptiwW524GG/d5
	2qfVA+WFWENFSg87tESd0hx/0lMLkxnD/DUB029vurJY1BzuHu+nRgfiDiB6h2GY
	45zMjXn2XuU82LpyMlCc3WQ/6+2GV1Lf52SlYreWFf3l1h1sSkg9XE5qMiE6WnWU
	09y/XEhZIVFLmbbjpRuYN/huj/5xylHAdhu59eHs88+YFrx1iAYu0WjeKrEctc9H
	qk9b2NSMXAX30hjioR0/XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759426984; x=
	1759513384; bh=5SZKmQOKJvmwB49FYa+WnrLjIabJegKAY3V3rWgo2To=; b=v
	1V3blVyp2fpzXIJ/AEX2wIaHWx19FWU1nKkP6eF7sqwUZLynra1SRiSRAvc5MXOR
	UPHZ0MTC8et/k+R51uax9kQhRvOuNLsZyN8jVuA3M0KNBOS/gIRLE0WuSZz5qHw0
	gRWf72vtZFiYI6scIk+uJNRaE+t/Gr5fuS0TNTwphSJKf/8imjXbKR8Osio/S3aM
	ea5VaXGVKFFSuh6wHzAKLAmOQqIr7dOY5jjKpbFiAJpyyvAvLS93nTN4lRmOaJE6
	3l67jdML1ctI7qX/yImCERlUZAQ8ZrTlA+bk3SwMH7y7uSQxEr5DYvTQbwc1iA2W
	1PTN110qYQPSqVwmG4Hnw==
X-ME-Sender: <xms:prneaO45twtwCngOi1nB6bLqHZwZIwJtsiIR5-JTNNWv191qJgFTgFU>
    <xme:prneaCtSBkIFDh7-ECVCzSgCboD1XsFimn4GilUAAYDXfn_WV0IDjYXWrP5DTiM6P
    -Pc0Evyoym3dtTsxNi7nMdS5cJc3x0C2BFQVuaIgyuhjfR1uQYyiYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehjtghusghitgesjhgtuhgsihgtrdhp
    lhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjh
    grshhonhduudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmshhutghhrghnvghkse
    hsuhhsvgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:prneaHOrz4JKOaagFWrZUu6lAhh1VnGE42tM8I-r9x8WrcUejZUfUQ>
    <xmx:prneaL9vYoOwA88vevkTnyZb2rZ_0KXISg8J43cxv7oBDxsl9Ap0Cg>
    <xmx:prneaM68oS_90VtT395CQYIlwpHPADTFWrz12K0oARoCFHaWZXi8Mw>
    <xmx:prneaJ51HiryQEBC6D68ygHqcrVMYamoG2Rny8bN7V6c5zdL5DF12g>
    <xmx:qLneaNdfBZX0u60fkWLz5EJRGnAoB0NlP1Gp25_LS5UPmO7NyfuEHo8T>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B6B5F1EA0068; Thu,  2 Oct 2025 13:43:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdBSWMZvhIRg
Date: Thu, 02 Oct 2025 19:42:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Michal Suchanek" <msuchanek@suse.de>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Sergey Organov" <sorganov@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Jason Cho" <jason11choca@proton.me>,
 "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Message-Id: <8fe29842-eb27-47ea-877b-2bfbb3a03bff@app.fastmail.com>
In-Reply-To: 
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
Subject: Re: [PATCH 1/2] doc: git-worktree: Link to examples
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> doc: git-worktree: Link to examples

The initial word after the colon should be lowercase unless it=E2=80=99s=
 a
proper noun.

On Thu, Oct 2, 2025, at 17:51, Michal Suchanek wrote:
> Also add advice to put new worktrees outside of existing ones.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/git-worktree.adoc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-workt=
ree.adoc
> index 389e669ac0..ec31863aec 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
>  $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  ------------
>  +
> +For best results it is advised to specify <path> outside of the repos=
itory and
> +existing worktrees - see <<EXAMPLES>>

This is definitely an improvement.  The current doc forces you to infer
that you shouldn=E2=80=99t put worktrees inside the repository... or jus=
t think
too much.

It might also be nice to have a clause which hints at why?  Maybe just
one or a few reasons, e.g. that you would have gitignore the worktree
directory.

> +existing worktrees - see <<EXAMPLES>>

I was about to recommend a `--` for en-dash but now I see that that
produces an em-dash instead.. :)

>
> ++
>  If the branch exists in multiple remotes and one of them is named by
>  the `checkout.defaultRemote` configuration variable, we'll use that
>  one for the purposes of disambiguation, even if the `<branch>` isn't
> @@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
>  ...
>  ------------
>
> -EXAMPLES
> ---------
> +[[EXAMPLES]]EXAMPLES
> +--------------------

Apparently an anchor on the same line should not be used.

https://lore.kernel.org/git/5044672.31r3eYUQgx@cayenne/#:~:text=3DPlease=
%20do%20not%20put%20anchors

>  You are in the middle of a refactoring session and your boss comes in=
 and
>  demands that you fix something immediately. You might typically use
>  linkgit:git-stash[1] to store your changes away temporarily, however,=
 your
> --
> 2.51.0
