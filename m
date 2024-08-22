Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462391D12EA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308764; cv=none; b=ij9+ZEQ2GnbLhI/LbMQ3E7It2AmSSMHb1mmM0AXK7SK395E2tjUambdk2WC5KywOBhHBLJNQOuWuuGjmfSjcL7Es4s7GT05VDGWLyHKshum0cZ3+71Gfxqd2QGDzVn2vRk0fAmhm5AOIxzjC/XgzNNOjWYHLQKpVdJLJEWNmzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308764; c=relaxed/simple;
	bh=g4vFuIcyMICujFzDDcN1eWYdtLKv+wAzHfUbhsAG24s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQW7yjoJOR6PjpYjcLB38zKmO9lVBlNB991xs1OmJ2h4VLo3xY4te8b4hsNpMiy7t2UKFQGaWsMaR7cpGHXhLp14Shz0pmDcGQqAdX4x5kI83ZnAd2l/6EU/EsvWXguGTbFmb6Lhlr7A4mNBbqGvopW8chErmPmn+tO8EaC6H4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a0YAB9xE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLYim/ZU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a0YAB9xE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLYim/ZU"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4A6131151C15;
	Thu, 22 Aug 2024 02:39:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308762; x=1724395162; bh=EHV+pz6HJU
	ASAiamK2JgD05955FWvm0fdy8yaspzaI8=; b=a0YAB9xEi8wTm7DTDfyfgMZVt7
	kvL0avEr4pAThSbERqT8o1Da0Zz3IEB8zXyr4YjW4+QDSS4s6PJMsihWPqWHwHP6
	3T+qR/ni0e053Fe4qGjb0Xic8qObggvQ5TIdpkQijZ05jDpIqzNh1ZfGASXyZmQ/
	P5Gq1zNYo9zSiD7W6ATaR6iNHvWQpJMMQqU59Ln6pbNpVnvf5tvIsCcqZQgcCI3G
	F4Et0wo0KuhYazaz/o/eIMwaNEH7Ebyl9xvezS4aHmqIaefZWD4Y71DShMKwGWEv
	74CLSd5iH4Yj1sOXBlwb51P2vtiPTCRKtnYFmMzSG5xthmI6+umD/u1sE7uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308762; x=1724395162; bh=EHV+pz6HJUASAiamK2JgD05955FW
	vm0fdy8yaspzaI8=; b=sLYim/ZUGbsZe/xunO2vuzFOOEwT5/R+1SwEwGf1XeiR
	n0pqE2RBEwzJ4ZB6MTVLMjM7ma09q5LWH/1fLM+vPWusBieWh6mLPUrO1H7iRj06
	KL4DNRHVsPzg6qD2rDF+tsW0qEW05dFedgh7bxyxGp1nztf72byvzUi/Pq9hlWM5
	4dt6LCzp57yRk+fBzxjRKXPP+8luwdFm7GkeHMjsmwajhaAxOCt8BcO79LMi3ZZ8
	j9EcbpWni7w4oEvO/7jXV46U7EFbKtWuHeOoLQ1l3HkHA10oUWEUt28WvUJULt1/
	MTj5s0jxrjkzA8JjutEGV0jktIHvzTjaJUxKyigQVQ==
X-ME-Sender: <xms:Gd3GZsFcQHeVcWBduS_dWjN6n3v8hI_lShnuIzo9W57sWiGBUdAXbQ>
    <xme:Gd3GZlUAn8G8CACgkvjSrDVBHAvwXowdmPzZY_8YXUVEHtvNYzLzb-vA2G3S1lBgJ
    OIhqpItVaQnCpGtiQ>
X-ME-Received: <xmr:Gd3GZmLau0ay32fGtxOeHBWtNIk1SdwbjanoVgtbFWDvLODl_ExWOwAuhHZh-_Xq4aKQcGDJXZrV8JdY0VrySA1mjKMbdzG1CqneBdart2bl3po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:Gd3GZuFza3f-ATtwv9TnZp9SUyuyop1u9h-dtvOQiqqg1XPckgfsfA>
    <xmx:Gd3GZiVBjJBnCIvJMiee4k2rzNfEeaZmsNKlYLQCB8gQOrpudHqtkw>
    <xmx:Gd3GZhOXQTP3hbHg7SLWlC1DlMnY2tU3V63LTiqOc26-qU2lZfKxFQ>
    <xmx:Gd3GZp32yfKv4iM1v6dY7uoz9j22-DxMad-J-2LjGCg_8Dh7JaEMiw>
    <xmx:Gt3GZhSssOBKIGnN4nQ0gDLGbr497SdGee5zwq3ZiYuRHAwOVi6ewQxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:39:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f30215da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:38:46 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:39:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 00/11] t: port reftable/block_test.c to the unit
 testing framework
Message-ID: <ZsbdFU9aBQvqE3pb@tanuki>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>

On Wed, Aug 21, 2024 at 06:00:50PM +0530, Chandra Pratap wrote:
> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
> 
> Hence, port reftable/block_test.c to the unit testing framework and
> improve upon the ported test. The first patch in the series moves
> the test to the unit testing framework, and the rest of the patches
> improve upon the ported test.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> 
> ---
> Changes in v3:
> - Use block_source_from_strbuf() instead of malloc_block_source()
>   in log, obj, and index block tests (patches 9, 10, 11).
> - Remove a line that causes a memory leak in obj test (patch 10).

This addresses all comments I had on the preceding version and
plugs the memory leak. So this looks good to me, thanks!

Patrick
