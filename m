Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81976186E27
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986080; cv=none; b=OsIOcjBFndWCNqJQnhIGBJUzUFuswxiuW/E+EVILndaKeRTk0ibBeTK7HwTYeH64svLUHKudZCUYXUhWQD12FwAfqYBanxMimcZTAETMBpy6vcPeWb3t71eJI1RjQ0edzkZliRWFrYpxda3V6YEJsrp/YnBo5D0bN4f6WovdOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986080; c=relaxed/simple;
	bh=+DK+g34nouX+gOWa6duHurKMUuOnKkFZKggMRJG5ROY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDQK4CuRwgTk4RokDLDVxCXVt9KemDqeZQMvyQUNpzeHOxrWYdv5siwkTG0N6c6sdV1c8uvS5NPztYfcdOWf2b51HcLwflQ+/jgq2+4R13G72Cg6g+fZ8W7ZzCGt0Rx5yHmCUAnqQCrH41zS8Czus/s544TD31JpFt2WkjCb/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OM4LI1ke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5oY3HWJv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OM4LI1ke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5oY3HWJv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BB691383FE5;
	Thu, 12 Dec 2024 01:47:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 01:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733986077; x=1734072477; bh=ZqYSktQKR8
	CP1hRsWvnISm5nd/v5aXjDLiP9gpWH/Yo=; b=OM4LI1key+lKo0Tu5DYSJjZJRf
	9RplE693dEOBsaWv6ob7rKrHti3WQZWfvf4u4mb8nJv79EaGi6CCDfe1/XUvDA2g
	BLK0ZH4jOhH/zI0l/wy70994+3ANR59V2SNwnSCpzAmamfLOau5Yi3Nzay5myZMH
	XbtXS3+XWnVGqBZfrIVK7xs403+o0gvXnP1WdU0dxFJw+39HiJgIl2tGcPhMvapa
	Clr3XhwDwPEyk4FkvzJDOccjvBKpEgxMGiXb08ElE+UMljC6BBXFFMo1/Wy9HBfs
	al3I3QDnQCkdgyUNEPc3caqO60BHtE/7hNupJVb9NipvuoaY1PvzbqQcPxXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733986077; x=1734072477; bh=ZqYSktQKR8CP1hRsWvnISm5nd/v5aXjDLiP
	9gpWH/Yo=; b=5oY3HWJv8oIUSUDsu5ltosiT9yws+6yvAmEVCby2w5E+LzzBRus
	Dsu9JviaW6aUWMpwTRe10JjrLTtwuH1X3+JO3ukbCgpyruUl/VMtQc1/pp+g/mQv
	HdX4xCcxP3UTbSAcCQWgqBMAHFOxk8/oqkWfU8kE6u8Vjfnru0EO6b/YG+BqhyaZ
	KxptfXNC0U1Y41Ut4jVHhP8+d3WSUHZQOmDFgQBwYEn65bA9POlGbJ4SjppzYWpe
	C7CzLSPK3EU05V+pAeNY4rCV9kxb4r7wthAAeBn9NErROLzqyZs+RnE6IW1vsNHN
	WgVtA8llaFE29iUXCJoA/X4k+q9qqo4GJAw==
X-ME-Sender: <xms:HYdaZwRZ5larQd9tS6xRlaBK9n1gf1dnqi2fHQPjVIAYbD7IyAycRQ>
    <xme:HYdaZ9yas8OCkVrKo_N1Njmf-oMtcj9H37jx2x78e-r5z79kfYR978NmWpN90V28F
    JuUNA9353NQQnzm8w>
X-ME-Received: <xmr:HYdaZ93vyjKeCUPl9ehfbR8VE52knfb3vxI1pbJ1KVqhYH_FOfr-7ysyheROHi1LgpYHjckksmGy_o0aVGy2WgmRQ5yliaTKLXMWqMYVaPcOrpMV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HYdaZ0AbiP7MhZmWskU3ui1ousDp3NzUSvdYsJSbdsnnyHY066dg8g>
    <xmx:HYdaZ5jesoNYjJpot_AhX35NZQQMvbB4o-d26JoWNizhfNfOPM4y5w>
    <xmx:HYdaZwrzK0zedNOk3CZ0QLgBRrPxrzc91gNB9XYRTmGSBgFILVWNJQ>
    <xmx:HYdaZ8gI5xbVS2sFBL27pVRY0_t3_1UmUEVuZzJ3eF-sMrKgPbulnQ>
    <xmx:HYdaZ5foFURCHiJ6D1cmC07ubK_csO3bPePMLLXlX01M8qJ7G9TEZyKN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f01dbd96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:46:19 +0000 (UTC)
Date: Thu, 12 Dec 2024 07:47:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ci/lib: do not interpret escape sequences in
 `group ()` arguments
Message-ID: <Z1qGmp4NC21XYC4a@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
 <20241210-pks-ci-section-fixes-v2-3-e087cfd174f4@pks.im>
 <874j3ajsym.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j3ajsym.fsf@iotcl.com>

On Wed, Dec 11, 2024 at 01:37:53PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We use printf to set up sections with GitLab CI, which requires us to
> > print a bunch of escape sequences via printf. The group name is
> > controlled by the user and is expanded directly into the formatting
> > string, which may cause problems in case the argument controls escape
> > sequences or formatting directives.
> 
> Could it be you mean "contains" instead of "controls"?

Oh, yeah.

> > Fix this potential issue by using formatting directives to pass variable
> > data.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/lib.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index a54601be923bf475ba1a9cafd98bb1cb71a10255..f15f77f03a06120afbee438cee76ddc2683e1fa2 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
> >  then
> >  	begin_group () {
> >  		need_to_end_group=t
> > -		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
> > +		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
> 
> Personally I find this line rather lengthy and hard to read with all the
> single and double quotes. So I would suggest to split the line with a
> backslash and put the arguments on a separate line. But I don't think
> there's a general guideline on this, so feel free to ignore.

Fair, will do.

> >  		trap "end_group '$1'" EXIT
> >  		set -x
> >  	}
> > @@ -27,7 +27,7 @@ then
> >  		test -n "$need_to_end_group" || return 0
> >  		set +x
> >  		need_to_end_group=
> > -		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
> > +		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)"
> 
> Same here.
> 
> But that's all I've got on this patch series. Looking good!

Thanks!

Patrick
