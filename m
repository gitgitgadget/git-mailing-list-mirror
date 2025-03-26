Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425119D88B
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028075; cv=none; b=r/HnoYKwZ8uDn6F3DGUqQ/ocbYZPHc0ZrAZIcClcwAMGu7Fva5XgajnfaHoWY699/mmuTUTxi/uqsfXtAG9lTkdvRkhFdIRHtTaHnyPaW28qOlAMb68N4UAxFC1b+5cJxwMXQtDXIvFqv0RHFfo3FcUNPtuRAShR+arcOVqviLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028075; c=relaxed/simple;
	bh=hvQvJyywavr0H63OfK7lHjJVWaWsdoAkJ4RXehhRscw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5byVDPzuWM6+GWknSUdlP/LPfpYru2gYsrqYPGanKZqWJbI84PVmTbK2PwCC0aa2eudea8aondKU0pESWn53dMyOKYH7AfYVqpgm8bDqwKEIjYlEIwF1tfFSUeCmXkBspacYX7vxp4quMiU6z/NUaA7ifsK3K7h6R7LkjURfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vxCYWvtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejxdbm3H; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vxCYWvtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejxdbm3H"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E9A511401E2;
	Wed, 26 Mar 2025 18:27:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Mar 2025 18:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743028072; x=1743114472; bh=v7ZQyLxn8H
	D2DuXIz7kpDBpF9E0hTVcilJIYaAZ0dow=; b=vxCYWvtZw1HrKErlkIEllvVOgp
	akk0dE6V0U17Mh0yPBE0HqkJkRtqx6XvkP9rXXL+Rkq2plo05DnorhhHDINim8Ts
	XjX4SwVeZ3XxUWi9P9an7V59EUFoJOhTjH57C5ZsqNFogdu7WPzpQHY20xm6sDhK
	UugL9PYRE+UN5fopB/iBImWxt+uyRbUBCiZy1HFrL53bi8/QfpVdGjO/ZSwE6Qbu
	dVlhd+LfCQmK3n0SY/refeKDLqP0uPB/Nk2mufvOwzil+xK0t75h+uIkw5zF+kwl
	M/FTa2jL2W95vu8e0GwjGoJXpsXFrdxajItbBSeIgOyEBA9qZoSZKqRotFhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743028072; x=1743114472; bh=v7ZQyLxn8HD2DuXIz7kpDBpF9E0hTVcilJI
	YaAZ0dow=; b=ejxdbm3HgOhLH48VJ1Ej/WeADpV7D07jDJwugSQLgGSDNMGQexI
	t2S/CEhkZeTknxzJhAADKc+6r5CAiXZt3E6Cjpd9GR/ykiyMCFuoWnWtN5VT0EuA
	lXBmTXhRjyOmBNgn9M0+Hwl/f35vQiSxScChBWACkVZ3MnTusvRyM/Ql3BH2Lkg7
	AgH2/DZcDczprE1X3KWeL6ktGoioCLr3BA7lr7mC6LoIF78IkHHILgKwXlcFDsKx
	xN1fAH/AXtWgIalw64bBPXcf3yD8HkUVkMLp3wZw4UoQo5cfdvTj8070OWCJ2vct
	O+kFUadBHC/4rJDNguvTMlyfG/oSMfUlwdg==
X-ME-Sender: <xms:Z3_kZ4mTdtBKfuQ8ZxrqswXMMfFKBmyCSjedxbjondwXEPmkH79fAg>
    <xme:Z3_kZ30DTGPUUksjomN1v8aX7e7qZbXHaLXosFo6_oDur1iRx8xcZQtDvsGDTGjKR
    4lCol7Xx9EI4ke1nQ>
X-ME-Received: <xmr:Z3_kZ2oiHCfn94vuYJxqnMUH84J6OiPsROI1b0n6obXPJCZudUKkcuPjWso4r1zOVoRrHUFHAI6aaPEwjGuWhXa3YcYKdFrlgagtBdlUivG10JG7gP_t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepiefhudfgueefieeigeetheffieffudejjeekjeet
    teefvdffvddtjeehtddvudetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvrh
    hrihgtkhhsthholhgvvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:Z3_kZ0lPgdjjizZbxtzup6RMVN-J47GkNstiZcMedZgOP7Kzf6FULA>
    <xmx:Z3_kZ20c2v2D-vtdKTjNgIdVUiTAbjWyWI4iCKZ4ErZzfb4GLSi4kw>
    <xmx:Z3_kZ7ukykYWDWkKurJzfK8WrXZmH-Oo9_UrE_sHttO8vHZwI9iR0A>
    <xmx:Z3_kZyW3Sa2smvhvhUIJXLgh_ghTIdZCeP12GIsvLOpFuVF-ig4KgQ>
    <xmx:aH_kZ7zGHtZUnDFBveC88I-mMkV9UGX9gxmjkzDNDNSbmpiEuwB83J2y>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 18:27:51 -0400 (EDT)
Date: Wed, 26 Mar 2025 18:27:50 -0400
From: Todd Zullinger <tmz@pobox.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git <git@vger.kernel.org>, Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>

John Paul Adrian Glaubitz wrote:
> the following commit:
> 
> commit 6840fe9ee29ab51ffd7d924c624dc62da22c50bf
> Author: Derrick Stolee <derrickstolee@github.com>
> Date:   Mon Feb 3 17:11:05 2025 +0000
> 
>     backfill: add --min-batch-size=<n> option
>     
>     Users may want to specify a minimum batch size for their needs. This is only
>     a minimum: the path-walk API provides a list of OIDs that correspond to the
>     same path, and thus it is optimal to allow delta compression across those
>     objects in a single server request.
>     
>     We could consider limiting the request to have a maximum batch size in the
>     future. For now, we let the path-walk API batches determine the
>     boundaries.
> (...)
> 
> broke the testsuite on s390x [1] and sparc64 [2]. The following test fails:
> 
> not ok 4 - do partial clone 2, backfill min batch size
> 
> CC'ing the author which is Derrick Stolee.

I reported this during the rc period.  I didn't hear back on
it, but hopefully your message will arrive at a more
convenient time. :)

https://lore.kernel.org/git/Z8HW6petWuMRWSXf@teonanacatl.net/

-- 
Todd
