Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3753243369
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739091252; cv=none; b=sHC82q/IGH1/qXs7tXRadYt2HOiUwgbt/yXRvJvafE9HtJKk50WSrLobH4T7S3Qia/h5Mgt2K6r/us4LW/E9lbIzEDZa6mXzkycrWd51064Qr8Y9Yp5VIIYuO+74lQRoe/iXR/K+eDs0RKI2SuXWidHqXwkKn+mFQc4sXfRR0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739091252; c=relaxed/simple;
	bh=snHTmrZpO7kY9X6FzavXxVA74Dr0//6YGH73khuA2lQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSTwI0VF3YmMiN5lbCjajLz5orN3mvJ50wudkYiNi4JznydfSy4WBRpwPEoYW5fh38adJ6hDWdZr/iH3+xfS3NrkGm4bfa/z1DvHhsaERPmlu/kcKCBYO8+fVPGa6mqYSXeKojnjQhlONKwx7eueDOn8Eg/50wUT8ZxEGeKwwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1th34n-005G7B-9V; Sun, 09 Feb 2025 09:54:05 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id A35AE60117; Sun,  9 Feb 2025 09:53:32 +0100 (CET)
Date: Sun, 9 Feb 2025 09:53:32 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209085332.GK30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
 <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
 <20250208232651.GJ30202@raven.inka.de>
 <CALnO6CCUYSM69V4CRiFV=EvQLCC7LCdzuY2gqryj_G_nAWqj-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCUYSM69V4CRiFV=EvQLCC7LCdzuY2gqryj_G_nAWqj-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 08, 2025 at 09:33:05PM -0500, D. Ben Knoble wrote:

> > So no, I don't see why using any of the older variants of this .gitattributes
> > would make any sense.
> 
> The original question said
> 
> > Why on earth would one want a changing filter setting during a rebase?
> > Can anybody outline a use-case for changing filter during operaion? [sic]
> 
> But I'll answer this one—general operations on older history can't use
> a newer gitattributes declaration without explicit instruction because
> they'd have to know from which future to pull. Remember Git can
> branch, so (even assuming we had a fast way to calculate this, which
> AIUI we don't) from a single commit there can be multiple valid future
> commits with different gitattributes.

Yes, this is the way .gitattributes work. And to be honest, I always found it
strange that this setting travels along the history.

But there is also ~/.giconfig, which has the drawback that in won't travel
with the repo.

IMHO, it would make more sense to have some sort of global storage which
travels along with the repo.

-- 
Josef Wolf
jw@raven.inka.de
