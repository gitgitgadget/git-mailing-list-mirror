Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505131E7C05
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856458; cv=none; b=hVyR0tT/HAfL7pSZavZ86sKJBsuhvjTnTSgbcdjkw/cYS6wMEGy/0A0ltP572ECZWvALdL12iY9ud9SSbyn1O9m8lzoVm2hzRFGDzTqL3MDRLyzSKNbV2AaqE03bbf9zIIeuj/6D41gaMZAyJORCRZqidv5/gsd411oTHaHNVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856458; c=relaxed/simple;
	bh=LnLHg2TNqTzgIrOr6GzwFS/GjVpxBIrZLthJ9iBAXS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdkW2SNymgxjUCv+yB1OZDKFV/IXPWAuczNOe9jjgZ8pJzgzWjWsuRSh/qBvv9UdYLg/Cm3fRuEg0U9Xjr1azWjtSBn4uf66laonMUTzK8QNh6vnwrhAXaUCc8KwQU5fIAgVAhbwZd2sZ6FH7vF7rN2m0YrquTYuz8bFc7MNpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TMmiVdzV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjdRXWqA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TMmiVdzV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjdRXWqA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D0037A2378;
	Wed, 30 Jul 2025 02:20:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Jul 2025 02:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753856455; x=1753942855; bh=tp0LFF4bFm
	LIwBH+fS4hAwq2VUMDPEW1JNXTQmDNuyE=; b=TMmiVdzVc1SCAMGniIs+nz3177
	DjCCEpYvqGTPitKUFJhfYJDNbS623q9Z+qcWPMmCexgav0W9zi6tjeXjND6PSpV7
	s18hUH2ZFB5yyZJLprWVtLuMblwjSw14X6cpFbG9Z/8UcSdmM33VlRkSznJeVuUK
	Sk99la5TXjnCGUIRhRwq5yE7m2u47esUBshgsuxleVIwvxgGsxRoALGFjjdtE1fw
	syrR014pxeBdf37NS2f78HgbCSwUS1KHBAwBeezjTwPJPAbxOJ961pCjqJsYFKFo
	PMIWrv50lbgOvEgJqTMrLkNRMUiw90H/ruExXqIdcQvUzIfwbRp5gHwHOYoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753856455; x=1753942855; bh=tp0LFF4bFmLIwBH+fS4hAwq2VUMDPEW1JNX
	TQmDNuyE=; b=WjdRXWqAl9ZolAKNHCTz9lZJXB7ErLvnV4ktEsQ1QTsf8hZdxxk
	aOeF0FTndGSDCVtgXca58WMTqQfBnDW/OsRx3AbqMaq/sHa+5dndey+HZPnCZ2LB
	Q9eZnHet3uCCg644OhDh7s+45koDipLXaGfHAKcuvax1T8EcaC1oQNtP82rO5/7s
	yUMJB8FvHEUOiJLXWKdYisFiQW4uZAdi10Dp8mx9qZev24lLLovAko/nRkFLqPJ0
	PykjTxy9uOi4ABs6Lmceta4uBLwiJpsvbEn1lftalrrr7Iy7SYVEYkqZGgbhaFa0
	AiYX/t4XfwwbP8iQGD4aTFkuNg+eHuS1wRQ==
X-ME-Sender: <xms:xrmJaBR9z_C0QDUvZGukprQGbFfF1weEjonbnRCG7mBKAIJlmCbUqg>
    <xme:xrmJaFVHEgchHzlzX_jv2p9cecEFMgHGSpXIifxp5lzcpQjud6CP19eekzwdfMXGm
    Yj_oUOpsUK_cP-mgQ>
X-ME-Received: <xmr:xrmJaDbLWsDXyIigMXcY6gZCHAKvb9n6JUBsTdWuIyAfcB4-lvuIdzsgtpcnKYBOEYlGi2XiG8XWr_wSef7YnTkl8MxNCDhPjGbd33Vq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xrmJaL0_RFBSmI1jemPgDkNg0lIce_8nwrwsgLBbZtlFSe6mL60jlg>
    <xmx:xrmJaFg_JXUiHn8blCmV28_pE5gMsgI6qZ36jG-CYMFapH5n5Sz0rA>
    <xmx:xrmJaPYb0JQ_YeV-pgcJfvROTAW5HzwkziJEPjL5_-37tSrvmI2C4Q>
    <xmx:xrmJaFTSr4vmtmoQ3TE6FDMcbxuvpizSn1fsor5ROUqmdpGWqk3sPA>
    <xmx:x7mJaBhtRv0AwW_jh8pMCE8cuPGCfgoNJ02vhYUuCVaV7W7Wmjxa0ZSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 02:20:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35037af6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 06:20:52 +0000 (UTC)
Date: Wed, 30 Jul 2025 08:20:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/3] within_depth: fix return for empty path
Message-ID: <aIm5vMeTLSLD-6Fz@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250729-toon-max-depth-v1-2-c177e39c40fb@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-toon-max-depth-v1-2-c177e39c40fb@iotcl.com>

On Tue, Jul 29, 2025 at 08:57:43PM +0200, Toon Claes wrote:
> From: Jeff King <peff@peff.net>
> 
> The within_depth() function is used to check whether pathspecs limited
> by a max-depth parameter are acceptable. It takes a path to check, a
> maximum depth, and a "base" depth. It counts the components in the
> path (by counting slashes), adds them to the base, and compare them to

s/compare/&s/

> the maximum.
> 
> However, if the base does not have any slashes at all, we always return
> `true`. If the base depth is 0, then this is correct; no matter what the
> maximum is, we are always within it. However, if the base depth is
> greater than 0, then we might return an erroneous result.
> 
> This ends up not causing any user-visible bugs in the current code. The
> call sites in dir.c always pass a base depth of 0, so are unaffected.
> But tree_entry_interesting() uses this function differently: it will
> pass the prefix of the current entry, along with a `1` if the entry is a
> directory, in essence checking whether items inside the entry would be
> of interest. It turns out not to make a difference in behavior, but the
> reasoning is complex.
> 
> Given a tree like:
> 
>   file
>   a/file
>   a/b/file
> 
> walking the tree and calling tree_entry_interesting() will yield the
> following results:
> 
>   (with max_depth=0):
>       file: yes
>          a: yes
>     a/file: no
>        a/b: no
> 
>   (with max_depth=1):
>       file: yes
>          a: yes
>     a/file: yes
>        a/b: no
> 
> So we have inconsistent behavior in considering directories interesting.
> If they are at the edge of our depth but at the root, we will recurse
> into them, but then find all of their entries uninteresting (e.g., in
> the first case, we will look at "a" but find "a/*" uninteresting). But
> if they are at the edge of our depth and not at the root, then we will
> not recurse (in the second example, we do not even bother entering
> "a/b").
> 
> This turns out not to matter because the only caller which uses
> max-depth pathspecs is cmd_grep(), which only cares about blob entries.
> From its perspective, it is exactly the same to not recurse into a
> subtree, or to recurse and find that it contains no matching entries.
> Not recursing is merely an optimization.

Okay, well-explained.

> It is debatable whether tree_entry_interesting() should consider such an
> entry interesting. The only caller does not care if it sees the tree
> itself, and can benefit from the optimization. But if we add a
> "max-depth" limiter to regular diffs, then a diff with
> DIFF_OPT_TREE_IN_RECURSIVE would probably want to show the tree itself,
> but not what it contains.

I haven't yet read the cover letter, but I guess that the scenario where
we'll care about this is in git-last-modified(1) if we want to teach
that command a `--max-depth` parameter?

> This patch just fixes within_depth(), which means we consider such
> entries uninteresting (and makes the current caller happy). If we want
> to change that in the future, then this fix is still the correct first
> step, as the current behavior is simply inconsistent.

So... do we end up with this now?

   (with max_depth=1):
       file: yes
          a: yes
     a/file: no
        a/b: no

I think it would be nice to include that in the message to show the
change in behaviour at a glance.

> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index 02873f59ea..900ee5e559 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -277,7 +277,7 @@ int within_depth(const char *name, int namelen,
>  		if (depth > max_depth)
>  			return 0;
>  	}
> -	return 1;
> +	return depth <= max_depth;
>  }

Just for my own understanding: the only difference is when we don't have
even a single matching slash, as we don't verify `depth > max_depth` in
that case. So in theory, we could modify the function to the following
equivalent:

	int within_depth(const char *name, int namelen,
				int depth, int max_depth)
	{
		const char *cp = name, *cpe = name + namelen;

		if (depth > max_depth)
			return 0;

		while (cp < cpe) {
			if (*cp++ != '/')
				continue;
			depth++;
			if (depth > max_depth)
				return 0;
		}
		return 1;
	}

(Not saying we should, I'm just double checking my understanding).

Patrick
