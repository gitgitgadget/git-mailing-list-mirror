Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD22E92BB
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053558; cv=none; b=Tljf1ZdbV3FP0HcFNul6qq/gT8QpmmhcnqlggZjaaTisOBjUH1bcwGm3DB1dIWJfr8lNjdMBeJpnFQKqptjtPWVfd2mdHCaobYPw9lZurbmWByFTLqjmc5ETL8Y2gFdjdT7WRYOOoIm4P41FUho+U34nvkUtruKHIocWfCya4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053558; c=relaxed/simple;
	bh=5rCXDO97+WpOa0OLiqLhRTgJi9QKR57Q7/9qzC0G0qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQC5MW9iqqMUZyAYFcLxte56N8ALlRXxK+uYEeNe5G+noHFZMvcMdgtEkNwynA+rbjYAR4wjYB7S5qeeOJJj2508kOlV4Wn84d9pZ3HP8lWez8JEE7pZjGqi0Infyvw5EtJzomsKn7KUZ/3x6oUrc8+7ACyBYXVrIZT9asCzQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ajslkcfB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ajslkcfB"
Received: (qmail 102250 invoked by uid 109); 16 Sep 2025 20:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5rCXDO97+WpOa0OLiqLhRTgJi9QKR57Q7/9qzC0G0qI=; b=ajslkcfBAYFkZv70OeDBZBwe+64FLXjzEoFy8PlVyNv+Szcn69i5YXCWT4qHXKFElqTsPbkL32JjIEDueZIwhzLs5jdeieTWFbxS+yQodmy0azoRAogYpqaQGehuhphhGZ+4usH3yq34JKSDhjXCzOLZ4bmevEtpdAcNoExB9Pfzqf8xzRJVkgCxWgGc6FrZwML3uXlyud/h0Pr/SB/jkuE+QL/VmzhJNwrDZxYdiPVeBtXKZYSRDkkkcv9ttXMMjSqIdWc1S376UthUdakObGi4LqTRQEqf3nToT1WWOgugxru1mLfzOOiP3ZvJEhIvqTtzBK8BcwsQJP3zL5hJiw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:12:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166078 invoked by uid 111); 16 Sep 2025 20:12:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:12:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:12:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/13] unraveling the mysteries of color variables
Message-ID: <20250916201235.GA612811@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

On Tue, Sep 16, 2025 at 04:10:37PM -0400, Jeff King wrote:

>   [01/13]: color: use GIT_COLOR_* instead of numeric constants
>   [02/13]: color: return enum from git_config_colorbool()
>   [03/13]: grep: don't treat grep_opt.color as a strict bool
>   [04/13]: diff: simplify color_moved check when flushing
>   [05/13]: diff: don't use diff_options.use_color as a strict bool
>   [06/13]: diff: pass o->use_color directly to fill_metainfo()
>   [07/13]: diff: stop passing ecbdata->use_color as boolean
>   [08/13]: pretty: use format_commit_context.auto_color as colorbool
>   [09/13]: color: use git_colorbool enum to type to store colorbools
>   [10/13]: color: return bool from want_color()
>   [11/13]: add-interactive: retain colorbool values longer
>   [12/13]: config: store want_color() result in a separate bool
>   [13/13]: color: convert git_colorbool into a struct

I forgot to mention that these should be applied on top of
jk/add-i-color. Patch 11 touches the same spot in a way that creates
lots of conflicts (the problems there pre-date that recent topic, but it
was expanded from one color variable to two).

-Peff
