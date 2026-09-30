Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC63BB100
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779221; cv=none; b=c6gVzsmOyiK3svHOd3Oak7OLRA3QFEa/Xt3YFpN3vd6lO6qLk753BAq+dKF1i9I0eVl/z1qVdiva3x0e5/F60hVcIebuEN1RySigqVj2a4ISFObErV52R9f1Mu8OT8kUvz13Ioj8guwTUV5wzInD34NaGZViLXdCtJuO7O89rLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779221; c=relaxed/simple;
	bh=HMKdqrqj6e5K6mnWHp1cQfqpW0/bKYu4blMFE0joIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adIMk4qMp6qOvQyfVNTCSQa2rb0mjvg1utP+OUc9OZqtwkNZTjP0bcN4J4E7qQfODBtZSTkdaC6zRhCheTAWerJKndfFXP6CDsRkenOfFnn9pTFNhXqAAIyRqqhFGghfcY12JcL5YNWUy583xEj8u6L0ehVBSd/f8ACn0tPlDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=clTc/mRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bFEbmnbQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="clTc/mRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bFEbmnbQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75D861400281;
	Wed, 30 Sep 2026 10:40:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 10:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790779211; x=1790865611; bh=49uY+gELI9
	NIive4cuk/o4XjMeRfWaXMogtFyGxM3o0=; b=clTc/mRB+jl+GH2uupV0/BhFgL
	UqxdcGzPGBwhPOibN13nb5FpX/pjebgNt6WWBrpX5MfkKfdYqFC8GPGFKWAqoG5g
	lK1ehrsXK2p4anJPG0ltIK5PayAy1C4RmWbips0abCrusroUeQlId+wVqYDv9QF9
	fEH+4cZLPi6PsgEnaaU2YFuifvm02xZSNgRhfKe/SKybB5rVUeSff080UH/wKICK
	f4tJNfJ1xFN4a35idmChghh1RiqjK9+30tIbeBWkAmF3sSDoVSRcacNTQNadUxmx
	YjATSmdTZmHbOyTD1Rx7w2k/zGHJ+KfWjkVZwp6FglBnCdzF0yVdYDyKqUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790779211; x=1790865611; bh=49uY+gELI9NIive4cuk/o4XjMeRfWaXMogt
	FyGxM3o0=; b=bFEbmnbQiwGneo7Y6Ih2gNcFPovU9iFt1dNIjhZuA5TBkShVN98
	Wkvf5cBVrmZ+rtPQX05NR1GP3zuDLK7eXiMTEC344nqYP1dc+CSmAEKrbPHfYWKZ
	F8bjDLppHFvjMdbewPHHkfXyKOZAx80zsWKVZwdLsOxx2fxSPIruMQkpHuoJb+hX
	jqSHoDYeCyqsit9NYoak2QvVBeFxvJx4oDF1onoDnIRgvu0ecjXSZDECOPTbSXQ7
	jiiRAhfwoWj44dPZ1ZPm0bOzY5b8/78Tq6Iyf1Zi8V8FqEe4om/dmnO5XgUdSVFF
	2d9E1dg2bw5/8WeLKlMWADGx82YGh0XAvUA==
X-ME-Sender: <xms:Sh-9arGRlgfy94FMZuTSYaeZwYIHMY6lNhJbca5hWhK1JPUwiTW1nA>
    <xme:Sh-9avwF_wCIGjDBfh8gJsbxoBgNwIU3mYif7WIYZmqKNg5_7230Kn31kNrta0e8D
    p9rXW5H2OLxNOY-PZi_yPHqP5_z2JnSxZZwnGahG7RNwNH0ZGyeKw>
X-ME-Received: <xmr:Sh-9aqj8w8wl42IH5lOeyfNG1UJqv0FSmKZ6HJllNoejpTVg2NSglA>
X-ME-Proxy-Cause: dmFkZTGMDL9vQkUjQmlH/vPjGNOUS1Zd3lH45oob/jpkstbErSOBXnD3pI8ECKmHJuazSl
    oe2mBOnWtYxQrLIdA4XIS1J3ipnB3Ss9cmzEC101Qd87y30xXSrLxtOZNaLLxi728pA7NH
    B33JcNV+s5tJzpMdhppxn8b35nTAM8x7eaNYd8zAqZx88DTTheuxfT24Npq+sKD1m27FvN
    34Ld8mHt1qLAqETwPfQDGAZctbOWx9/w/aMjBcINsIF8wBTQ+jNbBXuEn1FtMua8+1p7El
    f2mY8ANqI+dhukoh3BBvLWFDTJI+HiDC+z08z8ZDh/I9/drUBIry3INQjg2MjgKwe+oLHH
    eGFZ3m8MdgHCKmTYmoI+mglGBDIuq3XBV0h4QaPDjVjkH2g8BVsPTcQa6dICE0Pj7Gy8ch
    cIGEsFC3bNxWq4EpfZMBgDiY/qdAC4SA9wnGHP3Vx3dISbPtBTDsAIc7SeUnUibsNCcKLm
    4wXMUZWyk3gdRJyHOfTEJktNgaGp4vvbJi/lPupv9abphthUT/jxrjHyo7k3BDvrNbrqZF
    glvrStsPq3VI5Te+juN778PxPV7eT4pxGw+zzuQA7rPLenKdDZvljGn3pwTD3pscV+S3/f
    Pok6hyKzSOYt09gIJzIBTJsi0Sik3Nf9kEg8Rz/rq8X/m9E8K3pLH80+ti2Q
X-ME-Proxy: <xmx:Sh-9aiwHHMiBphHnxdsxF3bCPISbczgF_iJMbGAhT4-W24JGmFabHg>
    <xmx:Sh-9alIRUpEIp23eCrTZs65kAgChs6u4mw0JhBYVC4ne5KBh83V1Hw>
    <xmx:Sh-9ahSNqrlVlfuLBBHfejwUeNJmcaZHQKS6mZksNdV099Pb3TVcdg>
    <xmx:Sh-9aloToRwWOw_tpFKWSkdXPcMKkPGau0HclzGWCQwacK34-z6Gsg>
    <xmx:Sx-9atfDxQntAuv6l6WvbCam-iFOrDj9LlvT6zzf8NqZMF4N1lGkhQQE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:40:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bb1bca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:40:08 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:40:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Grant Moyer <dev@grantmoyer.com>
Cc: git@vger.kernel.org, Michele Locati <michele@locati.it>
Subject: Re: [PATCH] fiter-branch: fix commit map init from state branch
Message-ID: <ar0fRtN8XMG-fyis@pks.im>
References: <20260801033127.10606-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801033127.10606-1-dev@grantmoyer.com>

On Fri, Jul 31, 2026 at 11:31:27PM -0400, Grant Moyer wrote:

Sorry, this slipped may radar. Thanks for bumping this thread, Michele.

Nit: pointed out by Michele: the subject has a typo in "fiter-branch".

> The commit map dir is populated from the state branch assuming a
> "to_commit:from_commit" format, but the state branch is written with a
> "from_commit:to_commit" format, resulting in an inverted mapping when the
> map is populated from the state branch. This is especially evident when
> --prune-empty is used and creates commits which map to nothing; when the
> map dir is populated from this state on subsequent runs, git-filter-branch
> outputs many errors while trying to create files with empty names, like:
> 
> > /usr/lib/git-core/git-filter-branch: line 305: ../map/: Is a directory
> 
> This change corrects the population of the commit map dir to match the
> "from_commit:to_commit" format.

So... does this mean that we don't have test coverage for this case at
all?

It might make sense to also mention f6d855091e (filter-branch: stop
depending on Perl, 2025-04-16) for context, as this is where the issue
was introduced.

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 24fa317aaa..9aa07be6e1 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -302,7 +302,9 @@ then
>  		do
>  			case "$line" in
>  			*:*)
> -				echo "${line%:*}" >../map/"${line#*:}";;
> +				from_commit=${line%:*}
> +				to_commit=${line#*:}
> +				echo "$to_commit" >../map/"$from_commit";;
>  			*)
>  				die "Unable to load state from $state_branch:filter.map";;
>  			esac

Okay. A simpler fix could've been the following diff:

-				echo "${line%:*}" >../map/"${line#*:}";;
+				echo "${line#*:}" >../map/"${line%:*}";;

But I guess it doesn't hurt to have proper naming here.

> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 86011e7b1f..3934cc4a11 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -121,7 +121,7 @@ W=$(git rev-parse HEAD)
>  test_expect_success 'using --state-branch to skip already rewritten commits' '
>  	test_when_finished git reset --hard $V &&
>  	git reset --hard $V &&
> -	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
> +	git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
>  	test_cmp_rev $W HEAD
>  '

So does this now detect the issue? If so, it feels somewhat roundabout.

Michele, it seems like you have already invested some time into
reproducing the issue. Can this maybe be put into a proper test case
that directly exercises your issues (that is, the swapped entries and
such)?

Thanks!

Patrick
