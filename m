Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD31D2223
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156540; cv=none; b=hdnUZDE6C57hoaAV2Z/93L+5mngUARM4ta/H1nZQ6vGa6TrkstGHi7I6MHPc6Ko/DCRBEDvDQI2WPnblA6yaw4NaqW1cZgGi28QZhlQ3WxpDpNG6Vvgi7M00CKk4K6wnpHwT5YPVUZVNPR423tbqcq44+vDkRFJ7vczP+CWP5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156540; c=relaxed/simple;
	bh=9b20McOxkNaJ8Z3fTHRERikH/gqb4JQuiKJ7f3gspfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM7xfxjlwNyNOihtlt7D8cksv211KM38hEFUajHN5dHF8Nb2yAHOfQ41ye3uLYcqeYGVKhZqWeVqcsfAAZkI8UdWyp01ffVXFJMRCP6xvM6ZZDcDyB+XRBXUToSXaVDhEIYIGfD32TlsY+qfthtBantWo7TzbdC7wZhE8F/rYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=rOG8Mikn; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="rOG8Mikn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729156509; x=1729761309;
	i=oswald.buddenhagen@gmx.de;
	bh=9b20McOxkNaJ8Z3fTHRERikH/gqb4JQuiKJ7f3gspfM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rOG8MiknZ2a2o0VcxO4DnFoMjOY0ha3rasqR+FeJXWAWLVjAdupDkmzjKx7S8SN8
	 ri5O9T4qNbLbj64hJ+JuLZhCmSaLNvkNxpuhwCGKf49wa8cPasn6kN+Sc9p3mdZUi
	 JhWTPiwDtZcZlDCSt3zUp0ERqKMrztgmdrNsPZOyhnjjJA+eVg19H/1t7hjqnRURf
	 IqpePyr/YzybJB7DDpawVdoIpiCjde8/u6NcYK5JR02R6M+fbDtJPfkbx4eCtOJyz
	 brdUQfdPHSetKslJt92k1FuxO7J2f7/ChnlKhZiUmGAYaFuSvBXqjFzjBtDEdZUlc
	 sWE3h9jzCLi0MUEGag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1tJASq04LR-00N5fM; Thu, 17
 Oct 2024 11:15:09 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1t1Mb6-sr0-00; Thu, 17 Oct 2024 11:15:08 +0200
Date: Thu, 17 Oct 2024 11:15:08 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	rsbecker@nexbridge.com
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Alejandro =?iso-8859-1?B?Ui4gU2VkZfFv?= <asedeno@mit.edu>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net, asedeno@google.com
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
Message-ID: <ZxDVnGigNP4UUG3a@ugly>
References: <20241014131346.3556163-1-asedeno@mit.edu>
 <Zw23K4zPN9e+JyNA@nand.local>
 <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
 <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
 <20241017065936.GA16141@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241017065936.GA16141@tb-raspi4>
X-Provags-ID: V03:K1:mtMzkwAxERkgnkYHYEnoqGGv645GbH6otSpTlDPAq/XqWPMF/5J
 RWskROGTZPU12Qs29ogsuDvDqGLXMErRaMrUrt04QVUT0C/0P3KfYQHIAzMp9A0wIUuZUy9
 fzo8GU7SG3jqW+54UrWmo6xpXf0U2cNQs4RF3gbZTQcIRZcNB6zw9oaKQRErhPXwi0rkFBG
 9Zz7tYjpJAzkeolvGfqWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ShDdWCmV4Zo=;0xFHAmIpczFvOuD8ZJVlByinzum
 OFv75EXowYvMC8kTRB6Bo/Gq0t2ib/2qG54o/yYrpOU6SwSI2BPqGst6O7GYAEN1cH/Tfp52F
 6gLTcgrJe40jBRHPfTh7mv/vMhIqPynPah7wA+fgOQSSaYIqREKJhxfMnhJkAoBtBLBVeDH4p
 6aptlSSO7E1ir7mHdq074IsiM4JJwuj/pBOxGfDHhB3WgLTHLElW+GDHXmkgmWC2TBVG1UQvC
 r4DKnmm94RNCIVXjFUr9DrFEonxTL/5p/bNUQMWXe5DaB0D0y/IQXaGFOVWJuOJr+4xQjbn2n
 LvrmvZg6zOLtsJ5I45qskt6SCaGky19lz1kiOxdnPx+p+Y7SDgEUoYr9Sq+37cyPbpYVvxhq6
 0Sh1Dc/oDVsB6hOVYHsYY866luLmM9hzhxgzQJ8Q+mESXzn3djz2774aS32XbcghVcNbHLpZP
 bvjbU2MhmQIe+2k3rp1ENjqAf6TUPkDtbsRkKD9KcVwzkY3RZxlSkxaSOACp4H8NEcfC/AAed
 3OUdTOWs/2GK1D3BBgw1QiAgwc29+8ojq//EJ9QWkHLsDa6aKhQ+xLOMCrSIBmQSm180tBZQ5
 nned+xpz0JwIhhmIQHwo0cEmeeVcdhlx4dLXDXDuRn/oakNcQ+PU+qtAfVwe4V3D3hzm671BK
 nlHdZPEdiU2bJDYSVz/oRMgnUFay7kpJ6CPXyCqF6UCFER74CfYcA9sZtLllU2wSW+3ZW6s8R
 65Md28HiWMxwUWuF8WfOh3nPKtjptsf4nMGw8tzUbUuGUk1FwOfrr+S8B05MZ5cgFDIXB1Jrn
 QR/VGXbXq5LjDsRkDUR7MUZw==

On Thu, Oct 17, 2024 at 08:59:37AM +0200, Torsten B=F6gershausen wrote:
>Maintaining production software and hardware, systems using specialized
>hardware with Linux drivers dependend on the Linux kernel is daily
>work.
>
yes.

>And here tools like Git are needed (and appreciated).
>
but why?
why do you need bleeding edge git on these special-purpose systems from
the stone age? wouldn't any sane developer (cross-)build on a modern
system (which usually has about an order of magnitude more computing
power, aside from the newer tools) and then deploy and extract only
what's needed via some mostly automated process? it would only matter if
git was part of the production software (what for?), but then we're back
to square one.

