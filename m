Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A3243365
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739057303; cv=none; b=lKvNyTbdwZNQZEOGthnMEPFz7lYHfe6UjgnlFV+LgifQg1nAMdimhnsGuq1LHZ6R/8prlrNn5CXzRH89pElWodxYQC/nBiByveQkIsESTM4EBKRECholcqvIdhcqnLE9QP2GeOmQXY0nyGN88XtKqjOl80Kse4WchAEoBDwz5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739057303; c=relaxed/simple;
	bh=pDpv9GykBkHS2Ygk804L/c5+pGZDUZK00eyEyUH/QE4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orf01x9wRrVYYfjW2EPyaIPw94SyhvyDfTIgCw2TZ/38SalhKgFOX3/72XGu2vNfY2lQQ3/tNLm5Rv7rRIrTmaNkX52xqEqkedXir7tLz+2sUqPWoBJgdNMeVFGMkrbBLyP5X2ds3BHVwq0HgrQOJ4hTDvs1ksYYB1Xp7iuSo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tguFF-0055fn-6a; Sun, 09 Feb 2025 00:28:17 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id E49C760117; Sun,  9 Feb 2025 00:26:51 +0100 (CET)
Date: Sun, 9 Feb 2025 00:26:51 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250208232651.GJ30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <ba65ce17-8768-4d60-aec6-badd12930b81@gmail.com>
 <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGwZ029Y8Kfr2kkGiUDZ613kxS81JXzk36V85=77KcYfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Elijah,

On Sat, Feb 08, 2025 at 01:43:05PM -0800, Elijah Newren wrote:

> Ooh, nice catch.  If folks had an appropriate .gitattributes file in
> place in older versions of history, they probably wouldn't have gotten
> into the mess.

Well, you can't assume that paople get it right from the very start. An
important use case of git is fixing errors made in the past, right?

In my case, I had no choice. I HAD to commit those propritary data files
as-is, because I had no clue how they are structured and how those hashes are
calculated. As time passed, I learned what I need to do to smudge+clean those
files. But at that time a whole bunch of commits were already done.

On this roadtrip, I had to modify those .gitattributes files in various ways.

The only variant of those .gitattributes file which will work properly is the
newest one. And this is also the variant wich will work for all the olter
commits.

So no, I don't see why using any of the older variants of this .gitattributes
would make any sense.

> ahah, so it is passed via environment variable to the subprocess.

I find this to be confusing: the primary call should not need this parameter,
since it is invoked from HEAD anyway. Everything else gets it via env-vars.
I'd assume this variable will also be passed to the commands which are invoked
by the -x switch?

-- 
Josef Wolf
jw@raven.inka.de
