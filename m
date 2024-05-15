Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1A38FA3
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753923; cv=none; b=Mn1QnOKMqvJlsFNC9jljJHr++3ui17HNsj7E+gKTEFy93rh+j7Lkib7pnY+CH4CQCy8SFPMa4ZKV/eutQ3mAyPQiOxLLpcE3mXUXbRS4D+g0L5rwas0NbbHVuZuSc+ds7OAwvC7EhMnVvaXjD8/6X7lSWbDpkPXdNxJ5u4kcS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753923; c=relaxed/simple;
	bh=vbjLnGkYqQK3OA8tilq4nER8v93h5EYNTz3Q7a8Ezro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTsWs+hnz3knmleqaqzvIFSOz0FAYnU/5swiapTMRwt1QDydr0W0/mt5MCApWfvVNRktgurVfcBzjncVkDs1TS4FL1iwDePDa0jPrEcA0rH0Z5icWFjltbx3IBTZyzWRdSCdUvne65d0yCfpu4tLGdJraHVNoz2b7br51kXUjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14902 invoked by uid 109); 15 May 2024 06:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30675 invoked by uid 111); 15 May 2024 06:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:18:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:18:32 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] pack-bitmap: various pack-bitmap-write cleanups
Message-ID: <20240515061832.GA110841@coredump.intra.peff.net>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

On Tue, May 14, 2024 at 03:56:46PM -0400, Taylor Blau wrote:

> This topic was born out of tb/pseudo-merge-bitmaps, which has a few
> quality-of-life improvements in the pack-bitmap machinery.
> 
> The main changes are to remove the static 'struct bitmap_writer', drop
> one unused fields, and start using another unused one (see "move
> commit_positions into commit_pos fields").
> 
> There are other smaller changes, too, like cleaning up the flag
> allocation table in object.h, as well as introducing a new
> bitmap_writer_free() function.
> 
> The next round of tb/pseudo-merge-bitmaps will be based on this branch.

These all look good to me. And I think it is nice to pull them out of
the larger series, to keep the independent steps to a more digestible
size.

-Peff
