Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740F30ACEF
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342605; cv=none; b=fuo87hB9iu2z4LN+Lzrvoy3UOLQwL4rerRBhpLhfr1gvh1yUzJWCB+fPnp1tdJenDpYnvc4QDyx+oOvCDwgcJ8o6SYHh4bmRDcgeLvzdzPB/2KA8FXiElVqxTZHM7P0b36O5cptIqFxP9Wq7eHxAjBqQtEoSCG/QS+peiJLqoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342605; c=relaxed/simple;
	bh=mRU9M5yLYuwDm2KA+vjPHYisbEBb5i3o+HIE+HPdDGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfuYTbvtixX7u628fLYct8AIUA+j4auSlwD8PB4HRq26M83a6apgaktuSv+6xqGEcQjjbipB+jkVzHkXr0XwXUL6UrECqS7+8NU/KDkgTSQjerwS+zccYBX2P+vACA9yo8bVCs7FBiC93WVisdh23GbQgYd6093B3leBU/GC/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a1pQixWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDYXSZh/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a1pQixWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDYXSZh/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 286261D00083;
	Mon,  8 Sep 2025 10:43:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 10:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757342603; x=1757429003; bh=W205tdOqqh
	rrymCO4byzjgGJhehSkal+tdeZedgnDAo=; b=a1pQixWI+gVpciSYcFeErHn9Ep
	TQHsnunBq22Yp4En/DxJ17SmU5yiJaUkxDyEX9XsLqpfWEkgEXqtv37F3tmxD0rw
	qhYZpIwh4hXq+LdNf8A/LPLoU2dU7oFLXSPIobOABBkdC+5l08DQnMqAIQd6BNFy
	EQGGSibjx5WKY2YqfLDBVDyYkdqV9us1keIrJ2++tHCuDJaLJJ3IBrq2lUO3gUTi
	Kcs7egitsAtXI5jPO5zVDg6YzbtHQT/d3lfX4hmtZM/0eXZ23enxq1/OWbLEQqYx
	2j+H5yNzTW7A5X9qqxVwE2s4I5I8f5FVAd7A6OUX294Y68kb1Ed0ai1m1+4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757342603; x=1757429003; bh=W205tdOqqhrrymCO4byzjgGJhehSkal+tde
	ZedgnDAo=; b=SDYXSZh/KB2C36Os/5eBZKacs40rD0a2eSrfU7WlhyK5KbgMybZ
	6KttwkXwZvJrNW3CAONjKc+1JzviMGaGG6C8rPxgXlOgwiX7hRi6MnFU/epS6Myx
	ZYNSQ8BGnB8jQCsKhPMIQB0o3ZNQWN+Vdy5D/BOwtf4/TjdumI9CjiHNWxBtR9AR
	NFs2mcJDtX+YK3NJkRTLBUhStZJo4PTR5FDDzfcjkzuACnapR2Z7hoDU772Pb832
	hvoR8lduSDTrdBVrgYMvJxpYMc3erKpM2rXWoTfjLxIQfyLafotmAJFz0zOxI0x6
	DxCm0EI4sDsz9ZUSYV4R6H2uEtCFljnaRvg==
X-ME-Sender: <xms:iuu-aJIJl5fFuDz9-h_cIXrZzrVuDafn5PT1KE3TeKxpzCiT4S8GCg>
    <xme:iuu-aArSkk977h8tyI6GGn5X4pILJYCwo9ZPEGsxZxj-SOrR3QRU0BhVWnUAOaQvr
    FbBl6nH2XSXqIFLmQ>
X-ME-Received: <xmr:iuu-aIKUEZ1ZVD-akaln_LUr3TDOJg_hgcKW9EIMZVLqfz9eQ2ZY2vEQaC3LTvWpMUz7Pi_ad-xsyNE9iKv0obp5Lxloep72CXrn5HU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhilhgr
    hhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iuu-aFTE1oSn6CyZXs2NqHDXTI5lgMr6RmRGBDEQwNa9jzbt0AJXBA>
    <xmx:iuu-aHtpQV0YVlkxyT6pKhGNeOiPB_hcYxCgFIoVdDeYibjayPKflw>
    <xmx:iuu-aGazO7dMt8Ma8Y8-e6vJWMhGVqsCzqW_n0KdBt3YsdAofzj1yw>
    <xmx:iuu-aNFHEnUGUIhbpJMxBlUAjcPG7FcZ4y3TE0b5NPQxUNzCK4Kegg>
    <xmx:iuu-aJ-Ia5bmGukvZfiX_zuroRE7bz4f_DTvYtGoutYXDFvYwviLBvNU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:43:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Milan Hauth
 <milahu@gmail.com>,  git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
In-Reply-To: <aL6kevExmhesoEWN@pks.im> (Patrick Steinhardt's message of "Mon,
	8 Sep 2025 11:40:10 +0200")
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
	<aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
	<aL6kevExmhesoEWN@pks.im>
Date: Mon, 08 Sep 2025 07:43:20 -0700
Message-ID: <xmqqy0qpxawn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Sep 07, 2025 at 03:07:11PM +0000, brian m. carlson wrote:
>> I will also note that the dumb HTTP protocol doesn't work with reftable
>> and there was some suggestion of removing it for Git 3.0.  It certainly
>> will not work out of the box with Git 3.0, since the default is
>> reftable.
>
> Yes, indeed. In theory though reftables could also be the solution to
> the underlying issue: the client can be tought to read the "tables.list"
> file and then fetch all tables listed therein. The result would be fully
> consistent, unless any of the tables gets garbage collected. The client
> would notice and abort the operation, after which it could restart the
> operation.
>
> In that case there would be no need for git-update-server-info(1)
> anymore. The "tables.list" file sits in a well-known location,
> identifies all other tables we have to download, and there are no
> atomicity issues anymore.

Does tables.list list what pack files there are in the repository?  
I somehow doubt it.

The dumb HTTP transport was meant to be able to operate with a truly
dumb HTTP server, that does not even have to support WebDAV at all,
so there needs some tables at known name that lists _all_ the files
the cloners are expected to be able to download from.  We still need
the output from update-server-info [*] to tell what packs are there
even if tables.list is stored at the known path.


[Footnote]

* ... or its equivalent generated offline and uploaded manually to
  the repository, which was what I did before I got an account at
  kernel.org.  There was a small web space at local ISP provided for
  its subscribers, so my "push" was to ftp upload the loose objects,
  packs, refs, and the info/refs + objects/info/packs files there X-<.
