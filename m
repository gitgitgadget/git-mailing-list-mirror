Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFD344D83
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668813; cv=none; b=oBMkNHuBG41/ts0Q8wdc0IgW97BQMTwfVMHFRb7ibNbh37Ni7G1jBqhJrJFzA8G7cBv6SRT1yoOVkp0VtK2ZNVB57+BjvRjY3fDLt1ZQneb+rU44B0OEIrGXYlmJSVrCXPe7iwdKmTHvwakizXUb3nL8Zedkucj7e4L4yeP8Ikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668813; c=relaxed/simple;
	bh=09U9xXLReRYWus6mxUj4vczzUg55A3y/bypJNN9IThI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBzfjayL+4tJNvIb0jLzZ/3VzHUcHINk6LZeyh6p1zKmRAeLz8GLF5pY7Hcgmv3P6Izy4vioJ7Hc3v2DVH7eDgfqEQMVud5bpLm3LzrgrlU/Cu7PwKWrSouXVQNtvVPQwbNYF4WU6AJU0Xd0qzleV0lVUzlvrcGDLzdnI69hx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rt58bVw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dejh5nh9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rt58bVw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dejh5nh9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C00641400162;
	Mon, 20 Apr 2026 03:06:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 03:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776668811;
	 x=1776755211; bh=7A65lDmEymS48RGtwW+z0MPxzlexY/9iLAbE8VJZEqE=; b=
	rt58bVw191SpupoM+yuRYz4IY8WWyhhAs3tPZoUJI3RLJmLjzlDwEKjyM6GaSvAZ
	wUgwrX8xyLx8lFC1dhLAsPhPglVDesXjlkFFiMAvw82rYf/goSA+ccTWCG8GxM10
	Tv9jYSrCe+hEsQvSSrNo6VogDihBo95gV+9Do72lgUYLQGvCb8GVHEApQUQLsulN
	VvzsBLxJHynDWIkqm1cJHM5XdRMyE2ctzfmY4cFhafMYLTSEHKzuC05hvk8zSyp+
	pBDaIyRklZiMzdZ2vDsggpgwmZZO45lbNKkBJ+vk/v3qteAGB4xIsPeOVxGDo4QV
	+Im+mjcQ8hvj7fHpBkw/8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776668811; x=
	1776755211; bh=7A65lDmEymS48RGtwW+z0MPxzlexY/9iLAbE8VJZEqE=; b=D
	ejh5nh9VJTD+J0/cttVSjWye9efXkS9OiPJ5JP5eghyQxdgIEKbRUJBoodNZTrFa
	hhyMn1lTQemkWJ9AtTBMYpTiUwUwi4xoED+XS3KCPJQCkKI02M5e03vrJrd39y2X
	0JPbghGSehSXbE1Yxc/zuPVjhagMDGQqCGi7ESUm30OXnF7MXi7ljTIeM7Tg0yx6
	bwAAtRmDkRG2A8ZvWbvvG7CwrHokGyso+NysGk94qXIseJJ704qAAj5Rg+6XTQk1
	1rDofPCJ7YwTZUM6kL5Up4kpm+CaDHlg8+km6SSQGROQrZrBxTsQO0B6z3hup6bb
	y8jQUYzFyDrqgr7Vnt9Ew==
X-ME-Sender: <xms:i9DlaWiRAIUdmhE6CtLPeZJnP5Fue1ETRvHu3VcHUGOcSLg-arDplw>
    <xme:i9DladD4VDjlXrF7E3LSv0mWiQBe0kw8yLrg1Cv4zg86GbKjM_UTpfHUaQK36ngQl
    IV5OZQ074p7RMlnXma5mGRA0YrBhPSV8tqFlyODSTpDXBnuuxLtyg>
X-ME-Received: <xmr:i9DlabvGwUcI6Q-7aW3jghZoXd1PiU5Q4E0UtSHsVNs_mrDGhUxOaGYDXtx2Zu_nPf1u5Z6HkvsPEch5HtHMiF0S9PyObmYCVTC_DwMwbVZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i9DlaaboSyyXX9cCrIES8vvWTSClIBB_Qt0dTRh0zgNJRNqKE_Bzig>
    <xmx:i9DlaWWwJWZelUi0Hq3T9vX2f1fN8FtM2hJcGFPrqvj5_mR05-7_4g>
    <xmx:i9DlaW7EOisk9vpyjz0DcASb7jIsNi_m_y9F6ELaPrURE2XkYHTgAA>
    <xmx:i9DlaZgpfYlmi5suOR2Eeus2gNdQlP43kuHTpRr8mMudQbWxg_lgKQ>
    <xmx:i9DlaeRiXFGhmTLKFbjYjrWoW6_BiONxR3X1KqOdxCGa5Wf89BW9k3Xa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:06:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcde9af8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:06:49 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:06:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/18] setup: stop using `the_repository` in
 `check_repository_format()`
Message-ID: <aeXQhgwlXMfUOQ86@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
 <20260330-pks-setup-wo-the-repository-v1-15-0d2e822837aa@pks.im>
 <CABPp-BGHvWxX=g6hT_PKwAwjCAhiz3xOGh9vnWstWcEtyf4sHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGHvWxX=g6hT_PKwAwjCAhiz3xOGh9vnWstWcEtyf4sHA@mail.gmail.com>

On Fri, Apr 17, 2026 at 06:23:13PM -0700, Elijah Newren wrote:
> On Mon, Mar 30, 2026 at 6:19 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/setup.c b/setup.c
> > index 6dbd096f20..c32d6e96bb 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1755,6 +1755,37 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
> >         return result;
> >  }
> >
> > +/*
> > + * Check the repository format version in the path found in repo_get_git_dir(the_repository),
> 
> Can we make the code comment match the code below, i.e.
>    the_repository -> repo
> ?

Good eyes, will adapt.

Patrick
