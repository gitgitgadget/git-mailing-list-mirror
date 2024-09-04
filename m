Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A11E133F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473702; cv=none; b=YMFIQs/AHVH5HGS6SfBOfCnH1wNX/zTjeDWn3KyPUxVFzBbI40g9yDk17i4bf/o4rG/UwI8BryDI+q/IQixRNoJdMbE/WYyo7qx1BjG75+mbnTPQbj9K1C1N7iLh0wEMXMrtrEGImdhwCba/Q/sTPK8xlDmL/JrstE3SdOMRgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473702; c=relaxed/simple;
	bh=fIEQ7tuN2DRwg5XCd5JIMiwHMY/hbCb0emumumOhRFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmMUaCo9XccvfFJkzENLt+TlxLoMR5e/FcZpYviVKqo9w6CeB1ZbWqqR1zfeikDD2FlMx8nWWmS3lgpNnYjFHnQuPwHqv/7mSm39BxmUna5hACkozyM2fmw3td1MsL193YSe1cnBm0nMYnHn+KpAW59yUiREMI4gv1JxHNLGIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de; spf=pass smtp.mailfrom=rkta.de; arc=none smtp.client-ip=217.11.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rkta.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rkta.de
Date: Wed, 4 Sep 2024 20:08:26 +0200
From: Rene Kita <mail@rkta.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: git log alias with --all and --exclude
Message-ID: <20240904180826.GB15670@t480>
References: <20240904090614.GZ15670@t480>
 <0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0fb1c3-d4f7-413b-9985-d71cb1c300df@kdbg.org>

On Wed, Sep 04, 2024 at 06:49:12PM +0200, Johannes Sixt wrote:
> Am 04.09.24 um 11:06 schrieb Rene Kita:
> > I have an alias
> > 'gr = log --oneline --abbrev-commit --all --graph --decorate --color'
> > and I would like to be able to sometimes exclude a branch, so call it
> > with:
> > $ git gr --exclude=pattern
> > 
> > This does not work, though. Also does not work without the alias and
> > typing the complete command by hand. Apparently the --exclude must be
> > put before the --all to take effect.
> 
> That is very much by design, so that you can express "branches except
> the wip and preview branches and remotes except those from the remote
> archive" with
> 
> --exclude=wip/* --exclude=preview* --branches --exclude=archive/* --remotes
> 
> These collective branch options --branches, --remotes, and --all clear
> the exclude patterns after having them applied. Therefore, in this example,
> the first two --exclude do not affect --remotes.

OK, certainly not the answer I hoped for, but something I still
expected. Thanks for the explanation.

> -- Hannes
> 
