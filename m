Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B08148820
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325084; cv=none; b=XnUKJxe+h88zzjMWFl3g3LCh/yeKAGzaP57WH+YVROZISezbUiIpnELPxVcUR5HUe36a5X/TzM0nRCLf+2P04ICBlNJjza1MfbbV4amkgF055ZX248VMTfzfitoQZnhsYQIglvSJI4ihjgPnZakD3t/NPYSsPl/moq5CHGQ4XkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325084; c=relaxed/simple;
	bh=XgTXEfM0C4YW7GmHocfUxJEry/5qe/+uN3XHm1THTAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnhypRpqk5V3QrJxQPx+MkosPTWLRKe0Dok+lX1K3kS4rEIAWQt5vdWDGu7QFMVVdYW4cmUWm2O08ljhxDuQdmJGvSsBqNjEltWlP6AyKe6LSiicHrn3lgOmCPPs+mhB1oGDyS8WyWKAy03a9g0rrCfdeDF0VC1I7Rf9M7hbtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=CTSkXlo1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="CTSkXlo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716325071; x=1716929871; i=tboegi@web.de;
	bh=Yb+7AXIjb/BYdJ3xgngBZbZrxlz1jvw3hLpJNyaXQ2s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CTSkXlo1bW47xaZxWhT2mVeEO7auFE0uGm8E3wtbTTAgXvlLkFTbju3vfHi2iOhm
	 zf7eYtG+NuWLT2MC/BQ6RbZqE7XPLA0c6+k1zkrmE50ZPCauVAm1QER7mQOyxQPtl
	 thKWgzy02nVXgH8Kwd253rDzqMwLuJmw3RVgT+MwiZyJHxbCP34HzuOCdsh3TaLbb
	 YsiS/Dob7+PxRWnJi3DIHKIWL0YSZVdDonPV9Qk/c2nZSCMfjPOjmKQDJNp7otwU8
	 crToNn8COcNcNmZr4ULmS+9GRNBWcQf/dO8z+UhG5HL/NOk39if47qRAovTlkkH5z
	 SI0W3zr8+MavFe54Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MovjW-1stLyC45BW-00fy6O; Tue, 21
 May 2024 22:57:51 +0200
Date: Tue, 21 May 2024 22:57:49 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is
 NFD
Message-ID: <20240521205749.GA8165@tb-raspi4>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240521141452.26210-1-tboegi@web.de>
 <xmqqttir9hr2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttir9hr2.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:9GIGM3GTmY5/yy2ULY75i9v0yYl6NeCaEPqxcgRO3HzxacqSIXy
 fJthwzEkugjwrrmFOTOb8U5xPiQ2lR0TmLfgxxaEEIutFoNGm9TGmvI4E1dymbAbvZjTlJS
 8KBpc5Oymd+1VNH/lAnY3RtkHgU0QJf+GVSHe4MKmOOv4YeWjgpQBSQvrFW5+i7XhSSpLRf
 IKNaWsjUzwUwvIM1RM0+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KPDa9S33NZU=;dRZd4UFb7q5k/C7iTaupgUTlpX3
 G9+K+qP0rLlSzTxjlO26WOizJRKGkBTAP2JaIN0BrtCLZWu/XReYdcGilF3vXdjP8uvZhgIR8
 ebiveJwhxT1NweqU8C0FG14FaOAuTbXufdak6zFKtlHyyo0UHyrSVY9hpsskXiWQiYmq/5Nn8
 p04xaEiftIAZrlkj0HH1T/DkzMiWikaMnuU0lxjdZKYQzYFC95m2OSZFUibfoy5qdsYYLg7+Y
 6VSscMIGvyuxvwngRwYFu3tHwGX6wMEE1o5ju5SiduxrktlVGYiERJs1eANoB/Qujk2rubnB3
 IOWS3+odwfVzbw1imMz0SbZnB8TgZoKa9W4of15BnubcKbIFszatTY4Kn6tkf90A1eTSdXY4n
 XsZFXOTYQ1NEEmaFiUrOKi/kL+8NWMM2KmMXk2f8ONwrT0K9MYArPj5tKD1n3nXL6eQHMGhBP
 zrU+aF/hYTcAPzdj0LHEmGHwv5KQG3WJ8WO1ZayiNRXRYNySYBcmpFV2jp2OMvzS6crkrm+Lg
 BC6871d4l1G9qDTlW0/TJhVfp0CwhDU+DrdlIiAvDPDtzYPPTphl4H1ftyU9KiHBLI1Hys126
 YqLSUiPnOb3GNeYCsdWuZ/JKnZxFExxg0ikPJCnqJQRUisPU4dfvrbYcUPlz+YTtUNTuYrOca
 4o+R9QJBLf7TZG9d2vpy7YO8uds58UCbfFkIN3s/ytFAepsRnolGfD2jQjYa4UuQ41ATbVYWT
 k7r6o5RqTIumEWChX3aru5jPWw3QKBL3kV8uIzgxiIlAv4VYe9oCwAcL4OujzUzGUZLCrcYGd
 agHhKT+9HHgBryHOMAQcwji2vcbsbRwDTagrpGDL3ECiI=
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:50:25AM -0700, Junio C Hamano wrote:
> tboegi@web.de writes:
>
> > Add a missing call to precompose_string_if_needed() to this code
> > in setup.c :
> > `work_tree =3D precompose_string_if_needed(get_git_work_tree());`
>
> This is new in this iteration, I presume?  The old one did the
> precompose only in strbuf_getcwd().  We now precompose also the
> result of get_git_work_tree().
>
> Two questions.
>
>  * It is unclear to me why this makes a difference only when the
>    precompuse configuration is set only in the local configuration.
>
>  * As the leading part of the value placed in get_git_work_tree()
>    comes from strbuf_getcwd() called by abspath.c:real_pathdup()
>    that is called by repository.c:repo_set_worktree(), doesn't this
>    potentially call precompse twice on the already precomposed early
>    parth of the get_git_work_tree() result?
>
> I suspect that with the arrangement in your test, the argument given
> to set_git_work_tree() from setup.c:setup_discovered_git_dir() is
> always ".", and that dot is passed to repository.c:repo_set_worktree()
> which calls abspath.c:real_pathdup() to turn it into an absolute,
> where it has a call to strbuf_getcwd().
>
> So with the provided test, I suspect there is no difference between
> the previous and this iteration in behaviour, as what is fed to
> precompose should be identical?
>
> What this iteration does differently is that inside real_pathdup(),
> if the string given to repo_set_worktree() is more than the trivial
> ".", it is appended to the result of strbuf_getcwd(), and the new
> code precomposes after such appending in real_pathdup() happens.  It
> will convert the leading part twice [*] and more importantly the
> appended part is now converted, unlike the previous one?
>
> 	Side note: [*] hopefully precompose is idempotent?  Relying
> 	on that property somewhat feels yucky, though.
>
> Puzzled...
>
> Will replace and queue, but I couldn't figure out what is going on
> with the help by the proposed log message, so...

Acknowledge.
The commit message deserves an update, for sure.
My suggestion would be too keep it in seen, until I have managed
to write a better commit message.
At the same time, I would ask Jun-ichi Takimoto to do a re-test
of the new version.
