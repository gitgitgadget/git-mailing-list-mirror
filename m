Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7820C027
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452893; cv=none; b=uVqkIjNdj9aXfZeNWABEbxuEkW8LQmMTCi3llLbq/efQLJaEzLRIWFAjDWAtQ8a8A2agcuXW66h+ZlB/VMJO+aDVUtKzKYCquhWIjNT5ouHUo/v3ptipyFDnOYUMQTR15jpvoZFYxRphmbQRRcnZXlAlpAB3eOz1/6YiizgMEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452893; c=relaxed/simple;
	bh=kjSgrXqmQ1Eqnh5+3dm7Jmw4fOxv+Qw9I/3zDFKm2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBzRicFh+4zwhfkfBsq62IWOgXB/De6ycldV+eNzb/MIx+NxiEQRY2jXI/32XI9zESk5xdZTDczLPyJ3QX0odMYk4SfrX4aYJUmwfm1nNMlV0GTNOi8uFYo6D85dkih9z+aqlLv+4LseI2sucMGT7OO0Y6w49EtV0I0fjd7adnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OOagsfGb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjrlCXaU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OOagsfGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjrlCXaU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A66C51140144;
	Thu, 13 Feb 2025 08:21:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Feb 2025 08:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739452889;
	 x=1739539289; bh=v32SO7zNbyPupGJLk5U2zVVr8Es2maEtTgy0VqL5OOE=; b=
	OOagsfGb3RtslE+Nj8HRr7lLyMfD7r1B97SGv6W7CnpnX9Ij6LIXA3SQEagmFun5
	O3s0JFRoHEaHa2C1zu5FTATHT/qtbUf9vLFFtN+0j+vCAgiffylO6WOBZ/Wx/Xfb
	+DEtbaT3qib+At3NIV4mx/eDTTkVOFDuP4SGKh9WfV5J2rg9GA2BmUXyMo6jonUC
	+doiQx7pCeDWHxr9DSpX6hB1eQ3mHhmkghsPA2gyb7HDo2hyaf33MWxUBmdpwNLw
	WwiFEEcKEjbBArHNxUpi+ItSei4yvlM/8z1E3Oc5gYjIzd4wUy4o59QaMT6OprIP
	epztxZGoZFSEcEVoAhuPbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739452889; x=
	1739539289; bh=v32SO7zNbyPupGJLk5U2zVVr8Es2maEtTgy0VqL5OOE=; b=I
	jrlCXaUAAPRO96GBB2aun1YM+P5EfqiDdj7U7doURUK2H01csbpFxvjgGkcPv51b
	KNZ0Ic4STbCqdfIFMZ283J3gqSyPjSOw7bk6/DK1vzrSWbMYhbkNGu46PSIDpw+V
	BHzjxxWbl5u0cj4W+/Ro/vv5VaHz6ESHvr5dzJL9lBinFnfrjgCml1A9lwSOl7Qn
	NybA0NMnEeXS531foLSodIGoyki+aPn3LpW8gLp9EZGJ5FA1RuyUhhZMEo3sMtxT
	VNr2a08+FHU6u5s2PzczxSe7ykkhl4VO8sBZtTpdAYk6yygyRwm6F38+ghyxmDl6
	zbEY75+5T8Ykewiw8lqkg==
X-ME-Sender: <xms:2fGtZ_w6VBYQexGeBi5YhPZGRh4jBzwlgPTB7a24NqYFVSdPUMxSuQ>
    <xme:2fGtZ3ShIV-e7tVzEvA-IQPgV4zqc7E0BXRImwrOhHSBl64Nwp3CKM_WE_TGGAP54
    Fo_xOg693spZ7KYog>
X-ME-Received: <xmr:2fGtZ5VOsB7Gg8ImtLxAs183kBoBAweLuHSzIjFYxn69WZOmYPgVuR0_snokzp3ndYzaW0ylHayusEV-jYN3k5QjlXMXe4dHJvgKjOWX9CkEPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2fGtZ5i_6mNA-tcPxt3PxxoHSD-z-zd7N0Do7eEatErm6QvpKLjtVQ>
    <xmx:2fGtZxDoeR8lmYyyL9pSp8qJwhCjuvkHl52UsNGNcfKCIT5YMOKGUQ>
    <xmx:2fGtZyLLDD02wzGrO3omRdn5bpCB7c-dN2Hdq3P8qGpK6llcoqrRnw>
    <xmx:2fGtZwCb6K7Hhdifmw88cZDFkvkSoEaaQO9bJNeJadO229N3ltF-Fw>
    <xmx:2fGtZ8-JMsA9xRVI9SNIMLg8j1cSBO4_Y6G-6zpJFeq6sqyfFjZS6kBN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 08:21:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ad1f01e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 13:21:25 +0000 (UTC)
Date: Thu, 13 Feb 2025 14:21:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z63x1MTZfVfI7Q1a@pks.im>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <CAP8UFD3E8_mTwneUgNkC_hZbkaeznAT-dG9njT5wjnm-=iMmcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3E8_mTwneUgNkC_hZbkaeznAT-dG9njT5wjnm-=iMmcw@mail.gmail.com>

On Thu, Feb 13, 2025 at 10:27:39AM +0100, Christian Couder wrote:
> On Thu, Feb 13, 2025 at 8:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > We end up with two tables: the first one has been created when cloning
> > the repository and contains all references. The second one has been
> > created when deleting all references, so it only contains ref deletions.
> > Because deletions don't have to carry an object ID, the resulting table
> > is also much smaller. This has the effect that auto-compaction does not
> > kick in, because we see that the geometric sequence is still intact.
> 
> Not that I think we should work on this right now, but theoretically,
> could we "just" count the number of entries in each file and base the
> geometric sequence on the number of entries in each file instead of
> file size?

In theory we could, and that may lead to better results in edge cases
like these indeed. And I think if either the header or footer of
reftables contained a total count of contained records that might have
been a viable thing to do indeed. But they don't, so we'd have to open
and parse every complete reftable to do so.

Because of that I think the cost of this would ultimately outweight the
benfit. After all, this logic kicks in on every write to determine if we
need to auto-compact. As a result, it needs to remain cheap.

Patrick
