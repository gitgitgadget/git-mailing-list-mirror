Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED61B85FA
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160493; cv=none; b=tVJbO5sFQBHJsxmgNKxoBntip73vzabPtQpfclHZr87W+bqRZXuNx1QnMjj/Y1//JZK0lO/LIshYQM0jMHmJBMQfkH7Ijt3C2+Hx++lQ9LDAe7Q3lULXeoA53EcwZ/opSZuyNICzEzLN94FQUju9/9Rx8VtBY8HTgFD3aWiqeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160493; c=relaxed/simple;
	bh=tWIVCerwslylDIcRYbnQp+zl4G8LTDM+tEA4Nrq/ckE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVxwZJD0d5LXSdSU/ql8VGGRnkazLaXy5v8uHmjg+O/vufaASekHMB/0t/XGr/RAW8UdPIdMPIl78Lt5MCLt5o6eCi7OrGnBd3DcEbay0uqC2n/Oadz8XYnn5sqCn6RKNsx5VJBpskZnvCjmgTIWPXf2h6e5Pb+F9ikgWJNRjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mf49qFOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9BdlwmC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mf49qFOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9BdlwmC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2383A13804B9;
	Tue, 24 Sep 2024 02:48:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 02:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727160491; x=1727246891; bh=S09GDue9sX
	5Q9Yl12WP6tXKoPntALocsfKEbNyxaMcU=; b=Mf49qFOmcudqiBF5l3qc9PnNnQ
	iiYjaDnLVACpU0noPnuzJQidDQakZfhBgC7jC0CP2bQsWqJYvus6KevlcK1laN8y
	2xOnNghKl4cPklf4p1f91fB5cx8EgaW17rmthxw5hzf2Yd+rnl9vDuSk3RZEVQew
	dfwVDgXcZEqrhDoamKEUS4v2FT8BCgXJt7XWNttiNqD11ObsFNxzehUN0Yncsr6q
	Af5Nm49+EbkBucqlRDlXTf6RygfGoVLyZKs0Lk1pURljfpuUEd9mbODHEAcfSosj
	3Ps+1UQgA6HBc5PsfmR2FEjev2/N7JZ6ez9LDhfgv96Ju2Ct7T3bJn9fuaQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727160491; x=1727246891; bh=S09GDue9sX5Q9Yl12WP6tXKoPntA
	LocsfKEbNyxaMcU=; b=i9BdlwmCNKJDHnRTR5rubVO7hJJspCRFSFriaonLX6yq
	1yJvseQfRD4GgRawhKV0BmoY+6bPSKAglkK8TKLg3oFXYAjCCpZuphOvBJR/SQFt
	OvKcuZ5Kv5aFwa6rUMUVTXLIlZC+puQez6F2iFjFVRnXlCzJC3gYvsPgqNVaoDJT
	EtlXLG/yVaQJ4ZQuhv1OFPkCiFf45/3YsbG8LAYESuvu0le99ByfOaDYFDq+FwVz
	k44U4nHSMkM/Biq7RYQjjvJQ6YY9NokLUXyIBfHJ5WBC7rhoVM6hyIiDpB8Z+61f
	Pdv5GuaqdOoYhSFpK4YcRl/1JTKl0N2hUDdE/1XChw==
X-ME-Sender: <xms:qmDyZmp2kuM34PxB7_iE5v0zT-3vvbfDjlkIYE7sj0A-SdITWDzAIg>
    <xme:qmDyZkrDbdm0CtBrUG05aJrmCYEIC16O7slb7QPpkWcbQoJRs-BjXHh97oY1XuOsj
    3g-u28zCQgQh8pbBA>
X-ME-Received: <xmr:qmDyZrP6yFwxEe-Awhgsi2gSGsPSO6JuSAW59NVKbbe6O7VZ9e4UgjZFyVRAUX_WcD2p39r2-w2GYLtKiS9PDzT4K7XjkF4hFy9Mkz6YPIhOiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:q2DyZl78tq4bgGZsoqQJ4nZNXbhVkRi8bdTFxKhUNy9429vcTf72iQ>
    <xmx:q2DyZl6skTEwLR2izH45Utcu9DGWvAd01pcFBuNWfHp0XE8JR1RFdA>
    <xmx:q2DyZlh0cec-YNwwzS0lWplPDRbpc0ac2dOygXmPagrH_5JQ7UJZlg>
    <xmx:q2DyZv4qk30wRqIfWL7iRbMwFp91JUDqVoRa1-n76tAEmeBXANmJMQ>
    <xmx:q2DyZlGnNubXDaSWioM-xii1EE4MIr7UZ1JF0BfgTLThG-BohoaK8lSt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:48:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc06a9a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:47:35 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:48:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] cache-tree: detect mismatching number of index
 entries
Message-ID: <ZvJgnqSwANCXmj0G@pks.im>
References: <cover.1726556195.git.ps@pks.im>
 <595693a6420b2571aabd51ed989bedfa0cfa62e2.1726556195.git.ps@pks.im>
 <xmqqttec8ly0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttec8ly0.fsf@gitster.g>

On Wed, Sep 18, 2024 at 06:35:35PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +	if (it->entry_count + pos > istate->cache_nr) {
> > +		ret = error(_("corrupted cache-tree has entries not present in index"));
> > +		goto out;
> > +	}
> 
> Is it a safe assumption that the if() condition always indicates an
> error?  When sparse-index is in effect, istate->cache_nr may be a
> number that is smaller than the true number of paths in the index
> (because all paths under a subdirectory we are not interested in are
> folded into a single tree-ish entry), and I am not sure how it
> should interact with it->entry_count (i.e. the number of paths under
> the current directory we are looking at, which obviously cannot be a
> sparsified entry) and pos (i.e. the index into active_cache[] that
> represend the first path under the current directory)?
> 
> I guess as long as "it" is not folded, it does not matter how other
> paths from different directories in active_cache[] are sparsified or
> expanded, as long as "pos" keeps track of the current position
> correctly.

It seems like we end up calling `ensure_full_index()` for a sparse
index, which does cause us to signal to the caller that they should
restart verification. So for all I understand, this function shouldn't
act on a sparsely-populated index.

But I cannot see how it could lead to anything sensible when the added
condition is violated because the first thing we do in the loop is this:

	struct cache_entry *ce = istate->cache[pos + i];

And before we do anything else, we dereference that pointer. So if the
condition doesn't hold we _will_ get an out-of-bounds read of the cache
array and act on the garbage data. And that causes the observed segfault
on my machine and in the test.

So I think that ensuring this property is always the right thing to do.
But I wouldn't be surprised if overall this code could require more love
to make it behave sanely in all scenarios. It certainly feels somewhat
fragile to me.

Patrick
