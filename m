Received: from cache69.mydevil.net (cache69.mydevil.net [213.189.54.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344830BF73
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.189.54.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354053; cv=none; b=FCRRCGwmKns3KkaPrJfq1dYNYQYCjvt94hNSYXhR2t5+8upEWE/9jOyi0sxNxtktjndsX4tXGcDkjQSwNlswEXT1G8BIRlSDBteR/uszO2vPkeoGqT1+OFjhaHNs6DmVU++uyXSt3M4KQ6yDVqsEzRoUKnYiWYVNuSA1+fDKrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354053; c=relaxed/simple;
	bh=NwVVYjU4SHLK4435aHtMwZZ6VvMrHD897djciJQok2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4zVUhV+YnPNgKuZb2PKCkLKDbNk5lBmwG4/h4PgJGPzITt2wxds37rNpNcDPF3FREcU3pGv6RoQRbrm7+jFwpyqodZdDuJ0Bw7txWUTWVBkl/pxdr04YDtmHc33IK7Sf8lN9Uwslr/Zzn3thDBaR+pf3rp+xgkeUHJv+NObY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jcubic.pl; spf=pass smtp.mailfrom=jcubic.pl; arc=none smtp.client-ip=213.189.54.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jcubic.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jcubic.pl
Date: Wed, 1 Oct 2025 23:27:18 +0200
From: "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sergey Organov <sorganov@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jason Cho
 <jason11choca@proton.me>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <20251001232718.7218e852@jcubic>
In-Reply-To: <xmqqa52a1h6x.fsf@gitster.g>
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g>
	<875xcyfk3k.fsf@osv.gnss.ru>
	<xmqqa52a1h6x.fsf@gitster.g>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-System-Sender: jcubic@jcubic.pl
X-System-UID: 1444



On Wed, 01 Oct 2025 13:48:54 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Sergey Organov <sorganov@gmail.com> writes:
> 
> > Also, I'm almost sure that the first thing almost every worktree novice
> > does (I did), quite naturally, is:
> >
> > $ git wotktree add <branch>
> >
> > that happily succeeds /anywhere/ inside primary worktree without any
> > warning for me. It probably should either have created $top/../<branch>
> > instead, or refuse to proceed without confirmation in the first place.  
> 
> Yeah, I almost never type 'git worktree add <directory>' without
> "../" at the beginning of the directory, and every time I do so, I
> do wonder if this is a UI pitfall that we should warn the users
> about.  Perhaps we should start from documentation updates and
> possibly a new warning or two?

I discovered work trees recently, even that they are supported for years.
And I though that the only way you use them is:

git worktree add branch

It just didn't occur to me, that you suppose to have them out outside the
root directory. The way I think about git is:

directory/
         .git
         and all the stuff that belong that repo

You don't create submodules outside of your root directory. Didn't you?

--
Jakub T. Jankiewicz, Senior Front-End Developer
https://jakub.jankiewicz.org
https://lips.js.org
https://koduj.org
