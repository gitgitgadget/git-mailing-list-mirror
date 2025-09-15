Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1012652A4
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916529; cv=none; b=KScEsXFrRblutsoUNf0jV6vUTBRSQLgRoAYddboF9nSLgoykjpLdvEoZJOkbyswU4Rjacg1Bnfmcpdi0G5u7JbFBYipdHtQlBN3u/IQfIVazGjVxz2I1VIHTJ8wufd2fp7kNj9PSjxwuPdnuDKVKtxqbOPSvcyHjUtu5SZW9GUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916529; c=relaxed/simple;
	bh=MjUf6jeGgpWaIJ1imXL9Sum7uPF+eQhnfBG775F+3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEeNtpAz3YISQUN1IfNnmXhUDBNoq8KKJh1ZIMfKyqSU7/ZvEHEqXaFjzXt8aXurelKxuPyQoKLrmL87Z+7fn5M7AKw+eS2iXODcIqR7varir50vAQzQCiEz6qbok5DjUj0rMoNvHE4xcE2uazgh6y9L8kmbAQQwnI2s059o6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TYxYyq6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTjewE+E; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TYxYyq6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTjewE+E"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3828EEC017E;
	Mon, 15 Sep 2025 02:08:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 15 Sep 2025 02:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757916526; x=1758002926; bh=JFWsLWwQ1W
	7OMLPjgtZV4wdUUPCr4s2QHpDDFZBHuAY=; b=TYxYyq6DN/uy2X1DCD8nWpoiXd
	KrKwixRhExIaB5UozPL5Ub+QK2JSdWdp7amW1hPYHKeMFttSVIzF7OACUMkz13Jy
	iG9U6+urK2ztG5b+BHWlFtMSsGE4SjLC786sLpieT+ESp81nEp5H3DEWFED1qgVw
	fKRq9EFqDQAQ4AxDy5l1Rh2le+TZ4VEVIH3JvYdOQqdLE/HOsz6/yv8vYIUahBWS
	o1cwMSUTMd443ECN/vlALZrz2ly/Q4atOGQ2MTztp79Xopbsv/QpYyQszUVFbn/h
	wkg1ngOZmry6Z3AYRJ0BB8O95WRBIZSSEMAecbll/BoBU+TdP0VzPrmwCI6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757916526; x=1758002926; bh=JFWsLWwQ1W7OMLPjgtZV4wdUUPCr4s2QHpD
	DFZBHuAY=; b=HTjewE+E2l7EJL/emTTqgMGJMmhtqr8Pyt1GBQjRsls7FIfsk6j
	Hv48OP6BdOywg80/w7+GozQuU0VgzUBFJWnee2PBzIXS948CbvdWn1EM0VQcL/va
	LU1tD0OIpDftcaEcWw5wL6guPDClVmFo6BJWrVXgue1BMG+h9KT6AidTmrjeNFuz
	flpVBkuCs9drPDbbTtK/YAXN4juPFJu1HlJP4UJKxw5KQCcr2vKAXLusPa7F2/sq
	cB3qxwmBIgJuzZPkSvD3+/bSnsQFe8qVJ6Yqkdl7OjFfo9Mx5YREYb8Yc1f1FkUF
	G9rLi0gcaxpTdEo4eLF8ip+sBZ7ACXIdDbw==
X-ME-Sender: <xms:bq3HaBRWU_PqApZgwto9pZ9J_KjDocUvW0pAkskTXe7YF2ikwGdvFA>
    <xme:bq3HaK-UimDHUrC6fqPM8tUFSjDVDFgmYgcBfXkmqqQnJyaYhYAnUPrkmCb-El6et
    YjwXl8l1bKdOGorww>
X-ME-Received: <xmr:bq3HaIrRxJcDdX6nGkyl7_uyzPi8MhtWgSy_vL2qQcR59gYtxMbQs9hvFfBnyCIP6NPszc_aaYH9pjiyEAKj7XRut9TJ_HxyaKrplQ8I_WSVVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bq3HaHmxDTTrHZqElAQ6Vgu1O10G3YRhtKW8wEMlNFyrVcTiA3hV8A>
    <xmx:bq3HaPIxa55Vl9L0eMxfFqq7hOE_8bhU9qPjJfCdKHGKiVCFRTpzVA>
    <xmx:bq3HaMxiMIVboRq_LWorkqaa5NvBq4MEx2oO7l8rQiKxcuyRL5c5vg>
    <xmx:bq3HaHtQP9wEu4d0R2mVBi2KXbfMebjRV3BRhJU3h9gnsuCMMSEAWw>
    <xmx:bq3HaCgk4FOS9O4ANq69XzN4jIMcr-zFeu5UB5LRM7WARHS5BQr5S1Ik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 02:08:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee6a3e8b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 06:08:44 +0000 (UTC)
Date: Mon, 15 Sep 2025 08:08:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <aMetaZxCN8CDsr6g@pks.im>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-3-jltobler@gmail.com>
 <aMJu7vPKfnxt9UiC@pks.im>
 <3cmqsfz5j2h36mw7yzwbrgfgchaettcnidvkiboqqktkm3dd5k@h6rmgjnqdmq2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cmqsfz5j2h36mw7yzwbrgfgchaettcnidvkiboqqktkm3dd5k@h6rmgjnqdmq2>

On Thu, Sep 11, 2025 at 10:34:42AM -0500, Justin Tobler wrote:
> On 25/09/11 08:40AM, Patrick Steinhardt wrote:
> > On Tue, Sep 09, 2025 at 02:11:30PM -0500, Justin Tobler wrote:
> > > With 23a3a303 (update-index: use the bulk-checkin infrastructure,
> > > 2022-04-04), object database transactions were added to
> > > git-update-index(1) to facilitate writing objects in bulk. With
> > > transactions, newly added objects are instead written to a temporary
> > > object directory and migrated to the primary object database upon
> > > transaction commit.
> > > 
> > > When the --verbose option is specified, each individual object is
> > > explicitly flushed via flush_odb_transaction() prior to reporting the
> > > update. Flushing the object database transaction migrates pending
> > > objects to the primary object database without marking the transaction
> > > as complete. This is done so objects are immediately visible to
> > > git-update-index(1) callers using the --verbose option and that rely on
> > > parsing verbose output to know when objects are written.
> > > 
> > > As soon as verbose output is requested in git-update-index(1), all
> > > subsequent object writes are flushed prior to being reported and thus no
> > > longer benefit from being transactional. Furthermore, the mechanism to
> > > flush a transaction without committing is rather awkward. Drop the call
> > > to flush_odb_transaction() in favor of ending the transaction early when
> > > the --verbose flag is encountered.
> > 
> > Okay, this interface feels somewhat weird indeed. If we now end the
> > transaction early, does the transaction still serve any purpose at all?
> > Like, do we use it to batch steps _before_ we start reporting stuff?
> 
> We only start reporting updates when the --verbose option is first
> encountered. Options are not all processed upfront. This means in the
> follow example:
> 
>   $ git update-index --add foo --add bar --verbose --stdin
> 
> both "foo" and "bar" are silently added via a transaction. After the
> --verbose option, subsequent updates are reported. At this point there
> is no reason for the transaction to continue as all subsequent object
> writes must be fully written before being reported. Thus the transaction
> is ended early.

That's... huh. I really have no idea, but is this design intentional or
an accident?

Patrick
