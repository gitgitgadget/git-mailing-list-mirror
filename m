Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6621364
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789191; cv=none; b=H5/3T4XcE0GZvK/wnqEu4ATnRo4bYx9w/cEjd4GzsvVYWBHNmpKQpCl85gMojzEvP9R9qqt8bSb6EAOE3a/NC+3GvCIr2kI9d342LmdP+IuCA4zsmwPsUWHQhg5NJww4z/M3Ykxuwtr6hcXutRR4wHNTV1Iq/62Ne95Mle1NH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789191; c=relaxed/simple;
	bh=wNeIv7Xhgr3wX6POo64HJx9qccy47scI8pgwCXTgMQQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iJ8TM8R9sFYrVp0I3Xd190kffbFi8epH3GVH5Lti736NG8SVvU5+n0EboelyzRETo/87CcZLKJrcGBRu/okXaQZsV/srv3BBROAaiVbDxwKtBs0/QAsFkDRqvTS2e4B3urtLFmdgIkBHXEz1r4BNtg7sGM6VcY2EU1aUvDzr01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Received: by silly.haxx.se (Postfix, from userid 1001)
	id A0CBC656D0; Sat, 30 Mar 2024 09:54:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id A04FB7F25E;
	Sat, 30 Mar 2024 09:54:02 +0100 (CET)
Date: Sat, 30 Mar 2024 09:54:02 +0100 (CET)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: tests broken with curl-8.7.0
In-Reply-To: <20240330000212.GA1261238@coredump.intra.peff.net>
Message-ID: <2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>
References: <20240330000212.GA1261238@coredump.intra.peff.net>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Mar 2024, Jeff King wrote:

> I noticed some http-related failures in the test suite on my Debian unstable 
> system, which recently got an upgraded curl package. It looks like it's 
> related to cases where we use the remote-curl helper in "connect" mode 
> (i.e., protocol v2) and the http buffer is small (requiring us to stream the 
> data to curl). Besides just running t5551, an easy reproduction is:

This smells like a libcurl regression to me. I "imported" this into our issue 
tracker here: https://github.com/curl/curl/issues/13229

-- 

  / daniel.haxx.se
