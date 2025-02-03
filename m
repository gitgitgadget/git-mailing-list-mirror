Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3C1FBEB3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572043; cv=none; b=UzKQUj3iHaZ2wxmt5/q+bd9XdU/8HJXsh0caki1uY2VqWUXx/MUa6FJ/ER3PzMkU7l3RbLP1YEzwzYhsxUfYCjYjrG51d7jPntMQ6Gu1tv6ZxEB8J9p8WeMvi9K2aOBLcOposh6rrWiiQyktpwjLVgsmHqD1YQcqrrBBdr5cuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572043; c=relaxed/simple;
	bh=4h0ktHCt6txXz4m1y0XdP+R+rvlcGRblVHuoBp5ewDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVhwDJzcSRNHWDgv/O1UdR1YfMBXoyJCMFjVnqVZfTeY/oLsjRatmP7f2fKXDnRKcWswZiRiHSwU41agtW2LS46+cj/zv3uSblkusFGyByG5nuCb8kLQI8EyLQtn4W2zq8X7LBvOkop42LZ/izI1Grih+05vel/gtgSH4ZYans4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=haaqJVLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhuc+KOg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="haaqJVLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhuc+KOg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 584EC1140157;
	Mon,  3 Feb 2025 03:40:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 03:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572041; x=1738658441; bh=rQOGZnil2T
	eYhYY9KNPFDbx3Ndh7/rZOzMxkkzg+wHw=; b=haaqJVLW3krxDWC59m54i4XflR
	sI04kD9JiT6zBAUm7I2FzBC+7BcQFaRpp/zF+cVR77bxoP9qNJROgwFh+lNcZIAt
	huR5i2/t+WbBxuSuFye/7YNawvhbkLEOyjCbtnzaX7CVsC8SnhKFrgf876+y9DjJ
	1b6rRfapXXrMXbnAQ4xlX9Slsz9tBXJb91NnDsmVQalo+ch+QnwUH1koKXpztS9E
	JlYhzvKy1TGUb0rQuIvbyTjH9sHHwLgz5ZDceq8xYq+lysTS3kl/csEXuiuVh0rF
	6BEhT4aZ6Nx8EslJsYGdJedcOV0oV62qyvO8uNIg4v1lvKgmW10rbqazC18g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572041; x=1738658441; bh=rQOGZnil2TeYhYY9KNPFDbx3Ndh7/rZOzMx
	kkzg+wHw=; b=vhuc+KOgusyrjGir9HVfOcKCxcJpGXkx0mtnF+hHZ5NQc08uISg
	I4aMM/FWLq12wE9oKOTdPw6Lom7037IznEmB8ltRaHMHssVzBYRCRgo3iGv2ivwS
	w+QMjqFsUc+r7wygnjR8lXVGwz+j7A9BZPHLUb0uRKIXvggG5gdjaTCKb6xer8OT
	tOs7G+KQm5SCl6Dj3wwShFg904CqMZFfWgE6bS7SGZExj6Y+adOvZ0++nRAMyI1s
	mqT1Cvb/upCkKLjH+zTAxNSKBr3UzlvsXbS3I90B1mvu3GXl5naB/G8c44zUJZeP
	6nyl42ubSAWD9rOn1in0zI3WsF1JP5qz1oA==
X-ME-Sender: <xms:CYGgZ-Nk0HPLeFgHxuXNW9a9Bdw4q2sBWASrsT0lBOXISgmRu2qebg>
    <xme:CYGgZ88Cma02_a-j-Pvywu9pyN3nlee4nfqDyG1v9Nb2iFAKzD9hUgl1hWjwl1O_R
    SOXaqkOg_MEibjeUw>
X-ME-Received: <xmr:CYGgZ1SE4HKjt9Mvse8byRKS4Mp4xGCuqkCWb3Y2ZHJTStlpEg-doPgLct5c0icpcIsp9zuhlQnMM-z1oukKyPhJqoxXY1stUDQs6Ynjjovsxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:CYGgZ-s7z7qxw3X_Was0inQC80jLLdSlkw5NgeEfrWLkXoakSZKyNA>
    <xmx:CYGgZ2dp-fy45UZYURYw4SNoH7ZfEWglNLy0HxMoFEzV85R-sJqRhA>
    <xmx:CYGgZy0Hv8iy_1nT9rFP4we8t3r39PO5GKxhcTPqYGpe5plC6EhUGw>
    <xmx:CYGgZ68N4i9VS-700oy7syn-9Q2P1gdMsnOlGii2u50skmpHTyCLRA>
    <xmx:CYGgZzHZWJ_pf4ol2Myn2Yg9ivytV_lhKc6qdZdxmo5kvaA1b7LmfoHB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72b3acb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:39 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6CBBn6EW2_MXKOK@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7KvL1bvSO4UQY@ArchLinux>
 <xmqqwmecceh1.fsf@gitster.g>
 <Z5zfx0E2neO5MNKs@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5zfx0E2neO5MNKs@ArchLinux>

On Fri, Jan 31, 2025 at 10:35:51PM +0800, shejialuo wrote:
> On Thu, Jan 30, 2025 at 11:02:18AM -0800, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > Makes sense. It has been a source of bugs a couple years ago, and it can
> > silently make you receive wrong results, so this is quite a sensible
> > check to have.
> 
> Patrick, could you please help to explain this. I don't know whether we
> need to check whether "packed-refs" is sorted always. It seems that we
> truly allow refs unsorted. We need to know whether we should tighten
> this?

The context here is that packed-refs sometimes claim that they are
sorted, but indeed they aren't. There are two sources for this that I've
seen in the wild:

  - An invalid comparison function. I think I remember that libgit2 at
    one point sorted them incorrectly, but not a 100% sure anymore where
    I've seen this.

  - A user manually edits the packed-refs file, but isn't aware of the
    sorting.

So we should assert that a packed-refs file is correctly sorted, but
only when the header claims that it should be sorted.

Patrick
