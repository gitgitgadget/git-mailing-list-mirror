Received: from mailproxy02.manitu.net (mailproxy02.manitu.net [217.11.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61E18891B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514187; cv=none; b=bJOSLybn2QVmjCsEdDP3/TrVmoql4RxstCHgQRhGf8Vvtr54e1XU47FqvPoWeslpZR0YxCQ4+dCjEA4JN94V3v1JmostDHxcWIsPm96wpMorh4io+TdkBWRiSdX/b4nofN4y1LfV7zdtfVDpIh+yEUnu8o1e9gvdlBZnaaF+NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514187; c=relaxed/simple;
	bh=i+lea6U+ijWWLVaJJxJho2hYCQJsb2Xo3leAY10uKCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEkAYGm2gGkzdH7xAW+gsW+4SACyaaBy3IwX/iyUvP6QJRrfrvolzTpEmrr5VGM6HqC2as230SANHRdtdOVWvIFlmy590PI8HLyU6gnYT03kURfwMz6XxmjPweGrdSLyi+MPJPVS9DUg+7oTacKXAsIgij46l3RqeH7B3lw7i9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de; spf=pass smtp.mailfrom=rkta.de; arc=none smtp.client-ip=217.11.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rkta.de
Date: Thu, 5 Sep 2024 07:23:10 +0200
From: Rene Kita <mail@rkta.de>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: git log alias with --all and --exclude
Message-ID: <20240905052310.GC15670@t480>
References: <20240904090614.GZ15670@t480>
 <0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>
 <20240904180826.GB15670@t480>
 <CA+P7+xo9DnTitgVjHzpW1ODwRdFruDf+g+isg5pSHT8f27ASvg@mail.gmail.com>
 <xmqqjzfr87wh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzfr87wh.fsf@gitster.g>

On Wed, Sep 04, 2024 at 01:45:50PM -0700, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> >> > > 'gr = log --oneline --abbrev-commit --all --graph --decorate --color'
> >
> > You could implement this as a shell alias so that your options get
> > included before the --all. I'm not sure how trivial that would be to
> > do, but thats how I would go about implementing this alias.
> 
> True.  If I were doing this, I would at least do something like
> 
>     [alias]
> 	rg = "!sh -c 'git log --oneline --abbrev-commit --graph \
> 		--decorate --color ${1-\"--all\"} \"$@\"' -"
> 
> so that
> 
>  (1) "git rg" without any argument will default to "--all"
>  (2) "git rg --exclude 'wip*' --branches" would work as expected,
>      just like "git rg --first-parent master..seen" would.
> 
> Thanks.

Thanks for the ideas, I will adjust my alias.
