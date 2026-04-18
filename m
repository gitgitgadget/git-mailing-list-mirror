Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E941DED40
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534290; cv=none; b=jmMKsmt/L3CFISZdpBwb8L4Yy9aMLjJFXE8D08btusYNmli4Q6gGfw6WfyzF9gOIZmpwhSFEU58KE7ePHmcJ6R/W5Yn/Y5Q+cz2mXKTqtJQGH0Hsqnk/S0cPX4HIFF4o+e3oCtQ9WUFC1gwBSxq2td0lOnV8UJyFwbOoVZ9g2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534290; c=relaxed/simple;
	bh=1ne2SjT8f17Bo+JhfCZUtGZtomaDAqudAwYPb6OCX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI4NWLfCsPOy8v56s9+6VsleqSmI7CSF7ml8APqeG83FF+2/Izg+ho2pNTJETjjkz9WjZeC34nsaCxYSP7vhvUEkV6P7rJd3v5xEylbqbJ9QHRFdvBwFFOIY2JbwA+KmMEwNIx8vY1ZaVpuOvT29flN6O94rqkFdqLpeAImchHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QgZxRnjH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QgZxRnjH"
Received: (qmail 392134 invoked by uid 106); 18 Apr 2026 17:44:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1ne2SjT8f17Bo+JhfCZUtGZtomaDAqudAwYPb6OCX8Q=; b=QgZxRnjHvpddkp067B0k5dptoboBX+Gts3h0Bypvbk/GPqLwwxlPdrhJiUbTbVsTYpT+0klqC/nJOTr7RP3h0iEuUQN6NLEsvd44GSBiSyiys//X5UZPM2l0WyXhnGhjGt5PMAfseO9iMJ4sDf1NDURJA4RTnZ6u/mUYMxfzufBj08l0pcArWGrTGop8EOqin/q7CUfkeyqSXmbo4TN7Sptcq1sT6s1veCXmTf1CI079ROm0VyaWQ/9hKRglIUcwpbjwzidauxT1JIvbNXvTIK6Yej6nYhoLSFcGj8lPPjRKik4io+x/bJx3iT5ogXmtAl4IleFZGJqS02yMaQCR4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Apr 2026 17:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 657539 invoked by uid 111); 18 Apr 2026 17:44:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 13:44:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 13:44:46 -0400
From: Jeff King <peff@peff.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <20260418174446.GA1695@coredump.intra.peff.net>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>

On Sat, Apr 18, 2026 at 08:17:10AM -0400, Ben Knoble wrote:

> > +if test "$GIT_TEST_USE_SET_E" = 1 && test "${BASH_VERSINFO:=0}" -ge 5
> > then
> >    set -e
> > fi
> 
> I guess that should be || instead of &&?

Oops, yeah. I wrote it correctly and tested it once, and then started to
rewrite it to support setting it to 0, like:

  if test -z "$GIT_TEST_USE_SET_E" && test "${BASH_VERSINFO:=0}" -ge 5
  then
	GIT_TEST_USE_SET_E=1
  fi
  case "$GIT_TEST_USE_SET_E" in
  1|on|true)
	set -e
	;;
  esac

But I didn't want to get too much into details of the patch, so I went
back to the original, but obviously screwed that up. ;)

-Peff
