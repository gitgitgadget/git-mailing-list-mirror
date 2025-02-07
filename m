Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62E2B9B9
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925174; cv=none; b=WofoDR8vlaJIb5+foHH0ZZlBTgrMDvZrac/2x+HMxq95jj1bbNNE24/3aDlutpK1n+c/io2EdVf3Y9fFxL1PKAAXJ6h+iiWrDEGMVRNbuoVMeSi0ZcjHMPlJbexZQTaYBleKRQlJLO5YtQGM+nol7tKvvMU3eAgrOq0UJWYjGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925174; c=relaxed/simple;
	bh=l8GyVtTdFNk71lRrW/iXtkY/fUohjz+NsuPMbbip/j8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0SHLrANmhr5MJrqElkIUn6pORHUu1nQib5jlrnyg7wclmhhakDHXzR1D1SuJqcwHHtHEdUJBiT5NlsNHHpqlAOzWHyka2n+UuChwvS2v1k3LacufZ4JLdYfsE27Lb2yg13Z8I8llVNXCvb2xJv04MvKmhltqFayHvCOtaLgHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tgLs6-004EBq-Sy; Fri, 07 Feb 2025 11:46:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 2782A60117; Fri,  7 Feb 2025 11:45:10 +0100 (CET)
Date: Fri, 7 Feb 2025 11:45:10 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250207104510.GE30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 10:10:26PM -0800, Chris Torek wrote:
> [First]
> 
> > On Thu, Feb 06, 2025 at 02:40:06PM +0100, Josef Wolf wrote:
> >
> > >    foreach $commit original-branch-commits
> > >        git cherry-pick $commit
> 
> [then]
> 
> >On Thu, Feb 6, 2025 at 12:07 PM Josef Wolf <jw@raven.inka.de> wrote:
> > I've done a lot of try and error with this approach and have come to the
> > conclusion, that cherry-pick totally mis-behaves in the presence of
> > clean/smudge filters.
> 
> I suspect, actually, that the biggest problem here is that cherry-pick
> defaults to working by using merge. Given that you want to create
> a new linear set of "cleaned" commits, you don't want to use
> `git cherry-pick` at all. Just restore the files from the original
> commit, then add and commit.

Ummm... That's far beyond my git expertise...

I completely fail to understand why git insists to operate on smudged files in
many situations.

IIUC, once clean/smudge are installed, all internal operations should be done
on clean files. So why do I need this "git add --renormalize ." at all and (in
the case of cherry-pick) there is not even any way to renormalize before
picking.

But maybe my understanding is too simplicistic here...

-- 
Josef Wolf
jw@raven.inka.de
