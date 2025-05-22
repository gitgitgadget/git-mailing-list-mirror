Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82304178CC8
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936569; cv=none; b=eYFJLrO8DdHqKP0fLIELM/K0Nz7yLAaeSB+QCjdIQYXSxBe4uO7b9LL9lFdFKV/qKCKkZDXG1b0NFCGYk26vX/ur3KAx93vKW4/rW9hrdzmbUAHoNiZ04Yd5z7YDAPcGAoXOoz2X8ZJZVqkvBR2WikKGwZ0Vu76u+ofNMTXR5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936569; c=relaxed/simple;
	bh=8n7EYZ7a+0maw7G/TlJYf6SgDc1RSBDTt9ZKzCcFa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxdwDJLFNUXOHYH6gDm4CZIOx+VkRbTmKhfm+0vXONcQG91WaMcvDc384wtf26ZburVU4MaZYEsC9DINQlzwl91KRVFknD79H+odlZFZekI+xTMLE39cT8sbNmg6nHJIcCXhBC4c3jDDhL+8tIXM+sPl5o6PSBERdUZskgbbE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iDXzLpc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flyeUA4S; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iDXzLpc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flyeUA4S"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 886F71140132;
	Thu, 22 May 2025 13:56:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 22 May 2025 13:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747936565; x=1748022965; bh=9VtMACgEGB
	pxaAOybdr2vrZoomZxjcwDuoh/qFzHUIU=; b=iDXzLpc8IUCP8tzP1u+dFvn9aF
	calG0Vz1TTLGJ7Er6oRw8EVmfktnLm0kE+iMlccUQJhABiUlLPawdwvznndPM1Ec
	vLKdE1QVhyGwV3XO99WtIjBxCp3AlTPnR34Ygi/AFS77/hyGJRixltEI6+4hmVQS
	W4VkolrbBP9WQ+R/siSkKIarrCxOO6kuaHWyZvffQnOvlOcgPTOqfP7rgN6bYTjj
	xarFvQNd+l8X1dBWCTuFWAuA/Ts5KO+ofoxmfRGnPgKeBkhLmSGHF8l64gts+0Sm
	N1ZJoY/qItEuyN/Rr7vRack5gIxXz+gO9ROErQxU2rGF3Tt65rnZ4AApjveg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747936565; x=1748022965; bh=9VtMACgEGBpxaAOybdr2vrZoomZxjcwDuoh
	/qFzHUIU=; b=flyeUA4SiGOwJrhE+l/XrM7EDBTk7IQEDY5qDy6xlloNBmk5enG
	/hLixWTvamIxHsunSu/5Eu92gGQAqqik8cUdSrLytlHUyPazaWs0wiDO7Sw3ZYqi
	7D8fkjpW+kGwVNsUCan+AyFLFC3MwVGwP2FH7UevVKRjaaPAGQIDC6yxvdZW+wcI
	bF/sHxPtcmdO6jUweRbldoT6H1yW1QzS9TONlnG0jaPQ6/KTi4p5bYacrYRMDHeQ
	zORJJItyzqdwenMNH4PiV83/2ey0FoO7Ul8qljtLK8hHODyfgBYwTR5qIkc1voJk
	ciqnx7SzrV/hroNs80z+6IDQjwDBTo2+6uA==
X-ME-Sender: <xms:NWUvaFszStt1dOrpFQeNivRrzg5PjoBvBHavnp9qeucIjOP9YdYuUQ>
    <xme:NWUvaOe7lZLGJADjtGkDiaUEgg0FdBOybxIKqbaiSx83BiKwnuVu8PBWlCukZZBkY
    8LqTPRScUAaW8XoOg>
X-ME-Received: <xmr:NWUvaIzj5nIFUNO_3HENPJzFIceFIVppzmovCriKo-4_qX4SE-0hwEEmDfzb8iTaLcnrtdP-FwYm330LfK5wNzZS2andhRqtbvth0UPqHc3szD63PkoL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiiedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceoth
    hmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfeg
    tefhvdffheefheeuleehieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NWUvaMMWss5FYd6GMPzsN25fZgX_AgkUsU-0x_ueDCMawprYOqqzPA>
    <xmx:NWUvaF-nTlRm9bChOESEpCO8UkgFJuvHKslk7zNulenTKxW-Dnuhgg>
    <xmx:NWUvaMU5V74CrCSc_h-eJSixa6NTNTQNiKXDu_IR_8hre9KXDQMd9A>
    <xmx:NWUvaGcoRPNQle5gZ9nHuUw5rwUXnqrZIk0SILGi2okrYLuJBnskpA>
    <xmx:NWUvaHnMFO9WOykm0fn9bfymMLkEEj8PmvVEF-k8sICsBnDBsoXQ720B>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 13:56:05 -0400 (EDT)
Date: Thu, 22 May 2025 13:56:03 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
Message-ID: <aC9lM12GyntAp2tR@teonanacatl.net>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
 <xmqqh61ear4s.fsf@gitster.g>
 <xmqq1pshc2vs.fsf@gitster.g>
 <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
 <xmqq7c287i7n.fsf@gitster.g>
 <20250522170536.GB1613@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522170536.GB1613@coredump.intra.peff.net>

Jeff King wrote:
> On Thu, May 22, 2025 at 08:55:56AM -0700, Junio C Hamano wrote:
> 
>> Ondrej Pohorelsky <opohorel@redhat.com> writes:
>> 
>>>> What made you send a patch for this program?  Do you or anybody you
>>>> know use git-cvsserver?  Unless I am reading the program
>>>> incorrectly, despite the claim in front of that escapeRefName sub
>>>> that we avoid sending a tag whose name is not something CVS would be
>>>> happy with, we did not sanitize the refs and relied solely on the
>>>> users' repository to use only safe characters in the refs to keep
>>>> CVS clients happy, and the fact that this expression used as if()
>>>> condition is totally broken does not really make any difference,
>>>> since it is in an unused sub.  I have to wonder if (1) it is a
>>>> better fix to just remove the unused sub, and/or (2) perhaps nobody
>>>> uses cvsserver to allow cvs clients to talk to a Git repository?
>> 
>> Below you mention you found it from test failures.  Nice to know
>> that you weren't actually using it ;-)
>> 
>> Still, I would welcome second and third set of eyeballs to see if
>> this is a dead code that the "compiler" is complaining about.  If
>> so, we can remove that unused code instead of fixing it.
> 
> I agree that the code does not appear to be called, and doing this:
> 
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a4e1bad33c..cc891eba67 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -5009,6 +5009,7 @@ sub escapeRefName
>      #   = "_-xx-" Where "xx" is the hexadecimal representation of the
>      #     desired ASCII character byte. (for anything else)
>  
> +    die "foo";
>      if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
>      {
>          $refName=~s/_-/_-u--/g;
> 
> still lets t9402 pass. I suspect the issue is that perl complains to
> stderr while parsing the file (polluting the log), not when actually
> running the code.

Just for curiosity, the only commit found with escapeRefName
is when it was added:

    $ git log -G '\bescapeRefName\b' -- git-cvsserver.perl
    commit 51a7e6dbc9
    Author: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
    Date:   Sat Oct 13 23:42:26 2012 -0600

	cvsserver: define a tag name character escape mechanism
	
	CVS tags are officially only allowed to use [-_0-9A-Za-f].  Git
	refs commonly uses other characters, especially [./].  Such characters
	need to be escaped from CVS in order to be referenced.
	
	This just defines functions to escape/unescape names.  The functions
	are not used yet.
	
	Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
	Signed-off-by: Junio C Hamano <gitster@pobox.com>

A subsequent commit, 658b57ad52 (cvsserver: add misc commit
lookup, file meta data, and file listing functions,
2012-10-13), made use of unescapeRefName; escapeRefName
seems to have _never_ been used.

-- 
Todd
