Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003D17C9FA
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062838; cv=none; b=ayr9G5G9fnec+EGO78Cmz3Ru3NoMTtDhLxJp7QpfraIqSFSyYEUmjv8XdrDSxyoUxy6MsVjKtK5YyOIMS0ta5IjsV8bEY1nRjseI22q7THSboHyzM07VgmePLFozJ/EdWDXT3c1Tkl6kaLQDDM2Qyu3gNIgMPrOrt3KaCXfUfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062838; c=relaxed/simple;
	bh=LStdcgv0Zx7+lAZi46oTmOkmtw5u1AMTA0TcSFEPayY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEtM37jVvdqX15db47Lkbhb68UFb6SDspw0R6O3XaOWLC21FoTdchedcjtCtYh7XByyXvwHVz/Y/CGCmlGT6Sj3Zkb7lODG4UfjSjIV2jg3tGihJO8GAxK4n4ueaN2JXM1uIH8nzmcM9uZ/qnSQUct/G06iO+50mQSIvH+VAzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d7w17CBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Co/I7a+7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d7w17CBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Co/I7a+7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 578ED114013E;
	Wed, 16 Oct 2024 03:13:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 03:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729062835; x=1729149235; bh=YG6vaAvYdN
	cZITrHwU118FsQvkyBhyOpWYdSr/qtUfU=; b=d7w17CBzgJKSh1FK0w9OPPnZxN
	Rfw1eNybNagELFL7ZgWZyXPLJx7bl1rLlTnzv3pCFUodraoxHdkIqF6K2vg4WcXb
	A/V1NcCOBewPAkFFgBQn8SRxfpcTIg9+0t/QKM4bIZM2v2CcqICC/ohBBprL+AYR
	P06nvxm8lSOBglQTcrl9IyLmg/33ES49L68zWNqEYzGqI3OZ/89TBeCEiulmKFeq
	YG1yFomx0QCogYgFE9n4toWYqnBTN50+GozknBWz58MnwsLjuS6Ss2e+P7lXEMpd
	+dsZ3iMTiZNxF6VS/+astEezqxob/hVu+iQOdxPZ4Hh0Rs+3Secc8fLMjlrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729062835; x=1729149235; bh=YG6vaAvYdNcZITrHwU118FsQvkyB
	hyOpWYdSr/qtUfU=; b=Co/I7a+7yAOjadJtr9e+EsvOu5Jxvw6HsPTEi+twTxKo
	Yl4+CNTteOWkBqBomH0pAjJ8J6fXcOwssPySpjkcFT76iZ+SMul57EUvm5W9lQ8+
	2b4Q+VLexeG4B0wBGas44lI/dnja/ih2/tAvn7tICmxlzH88VqYX1qf8tghWGJqH
	AVYyEe//lFp2Bvff+EMoUSPtmsBKc/6L0+aFQlaBKpyOrM5VOeTNmEaZelATupFb
	IG+foyYLO9hHbQ168U4D16A+Tx6B3M9D3NL7NiAmhJ08pKRWV/cQ2mTk8DOYPH5g
	JtTtzBCWwf4dPg7VNSjMmRq4EPyrfHjIQV5+/Oxh+A==
X-ME-Sender: <xms:smcPZ_VPcSrm-5IDi3qZwPJSW9KYydHzOyLcdZsB-kSUbgLc5Sg7DA>
    <xme:smcPZ3lF51MC_Dleb27fCdtVGwe1hGjLGGea_QvEHS9K8UeM__6Dr4HNxYNGX_VcT
    MlBQr3f0QMbCgQ68Q>
X-ME-Received: <xmr:smcPZ7aiz3ImvdE9d37jVVviDe7JTHLSwNKPlkxEOixDSHX0fbKREfqOXwAGGihjjARv_e2Irg51YDh30MOV_Nx1yqkq1WTFHyDkE2k-boUS9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhiuhiihhhonhhgsghordeiieeiieessgihthgvuggrnhgtvgdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhuiihhohhnghgsohdrghhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:smcPZ6U3Q4cqNsah7AUzppVuKLCkXtotSpiGNhhrHux80FaLiLpPDg>
    <xmx:smcPZ5mz_JmajssxzmmgHdVLRN0vFlMRhoMlxDqIaqQNikEgYNgLdg>
    <xmx:smcPZ3eK5llAywElhepi_1env6AyqzXJrw96AdLl2Ya9QAsmcDINNg>
    <xmx:smcPZzFw4bF6hyUasrfwh13ttW3gwTeMoCmGG-j2Zy0kxCmTJHXnDg>
    <xmx:s2cPZyB0xO17uo5VfOGCu7_zK7YKmOm-hR-i9LlvPCvTBnh7LV7XtR1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 03:13:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02b628db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 07:12:34 +0000 (UTC)
Date: Wed, 16 Oct 2024 09:13:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Liu Zhongbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Liu Zhongbo <liuzhongbo.gg@gmail.com>,
	Liu Zhongbo <liuzhongbo.6666@bytedance.com>
Subject: Re: [PATCH] builtin/fetch: iterate symrefs instead of all when
 checking dangling refs
Message-ID: <Zw9npQrbBzddKxaJ@pks.im>
References: <pull.1812.git.git.1728962878717.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1812.git.git.1728962878717.gitgitgadget@gmail.com>

On Tue, Oct 15, 2024 at 03:27:58AM +0000, Liu Zhongbo via GitGitGadget wrote:
> From: Liu Zhongbo <liuzhongbo.6666@bytedance.com>
> 
> refs_warn_dangling_symref() traverse all references to check if there are
> any dangling symbolic references. The complexity is
> O(number of deleted references * total number of references).
> It will take a lot of time if there are tens of thousands of branches in
> monorepo.
> 
> So I first identified all the symbolic references, and then only traverse
> in these references. The complexity is
> O (number of deleted references * number of symbolic references).

Okay. I'm a bit curious here, mostly because I would have thought that
it should be able to make this O(number of deleted refs * logn(existing
refs)): for every deleted ref, you should only have to look up whether
its target exists or not, which typically is O(logn existing refs).

But let's read on.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 80a64d0d269..ec4be60cfeb 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1412,15 +1412,18 @@ static int prune_refs(struct display_state *display_state,
>  
>  	if (verbosity >= 0) {
>  		int summary_width = transport_summary_width(stale_refs);
> +	    struct string_list symrefs = STRING_LIST_INIT_NODUP;
> +	    refs_get_symrefs(get_main_ref_store(the_repository), &symrefs);
>  
>  		for (ref = stale_refs; ref; ref = ref->next) {
>  			display_ref_update(display_state, '-', _("[deleted]"), NULL,
>  					   _("(none)"), ref->name,
>  					   &ref->new_oid, &ref->old_oid,
>  					   summary_width);
> -			refs_warn_dangling_symref(get_main_ref_store(the_repository),
> -						  stderr, dangling_msg, ref->name);
> +	        refs_warn_dangling_symref(get_main_ref_store(the_repository), stderr,
> +				      dangling_msg, ref->name, &symrefs);
>  		}
> +	    string_list_clear(&symrefs, 0);
>  	}
>  
>  cleanup:

Okay, so here we're now iterating through the refs which we are about to
delete. For every such ref, we call `refs_warn_dangling_symref()`, which
iterates through all references in the repository to check whether any
of them resolves to the passed ref.

That feels inefficient indeed, and I agree that reading symrefs once is
going to be way more efficient. But open-coding part of the logic here
does not make much sense to me, as the function itself should know to do
it efficiently.

Can we instead refactor the code to use `refs_warn_dangling_symrefs()`,
which does all of this in a single iteration over all refs? That'd
remove the need for us to do all of the above as we now only iterate a
single time through all refs, wouldn't it?

That still isn't quite O(number of deleted refs * logn existing refs) in
theory. It's rather O(existing refs * logn deleted refs) as before
because we have to also look up the currently iterader refname in
`struct warn_if_dangling_data`, which is using a binary search in the
sorted string list. But I think this should still be way more efficient
compared to the current solution, where we iterate through all refs
multiple times.

Patrick
