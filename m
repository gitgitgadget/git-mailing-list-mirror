Received: from out.smtp-auth.no-ip.com (smtp-auth.no-ip.com [8.23.224.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D54AEF4
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.23.224.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180425; cv=none; b=pkzvwPZb0T0e6cnmWbQuuMnf+iYMec+UR+HDzROr+3ZE+8tbSELpyrwzWNnPGYvypswzEtWxY+H96ff9A+PrQkRIEfxx4f7hKiNNPaD9lLAJOXBpeLr98Zd7TP6hGM4hAqWMtdZy8DU3BUOD/B80RYek7TV3Srzyp8X95EhLDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180425; c=relaxed/simple;
	bh=zX6N+FncVOUZT1X98ss28jiDLKEUOvICAiRAfq65J+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slG2xqQzpQrax+quZGHtbjNoC7UIjCh/Aio2LSX9EMjPKmyaIgomYcmkuXcSfM1sPm864n6Z501QFPNE4YQja5iGBxQxqTIFR7FV7sCL4GvQyo10GiRtEgeaa1FONzx5oFYm8LXOGHRuDLi6xJruECZrae14XBMqkwKUYI2uREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org; spf=pass smtp.mailfrom=flyn.org; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=dfbol23p; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=dfbol23p; arc=none smtp.client-ip=8.23.224.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="dfbol23p";
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="dfbol23p"
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
	(Authenticated sender: flyn.org@noip-smtp)
	by smtp-auth.no-ip.com (Postfix) with ESMTPA id 4WX52F3631z7mnb
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 15:27:01 +0000 (UTC)
Received: by www.flyn.org (Postfix, from userid 1001)
	id 662171EE002F; Sun, 28 Jul 2024 10:27:00 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722180420; bh=z9zu7Sv+fryLDkxfRdsC2WVIfA7U9AmpHts5yUDZT0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dfbol23poWOQN8orFWPBNk1bNC5pAPH2K2mvFGtKbL4Ztv9jcGPE928gJYor1ursX
	 geDhf42cj3VzoB1HDIUy10nX8i7MljuqE2ldUKbBH+O3mZ8X1IHoypBBZpOdB4D6P1
	 We6fF3kTMfBdjpZvoahAG8/IhvXF26gxsfuiVYESv0cXQ1bZh6kowl3DUQYkPA35AU
	 toa0kQICckrDPIUtLVTL+16K+5SIGe6qKfk3eg/cfRDH2InmrCwEi1g0T/+9AkHWA3
	 5iSkmKBLs6d9ojTwXyi7YWkNHwrDk8Za4tXoDXB5INDTx0DyfUAMRHc7ti97AB4OwD
	 ixQDjI4eHJIis2gkCZ+/bhgjmiB+lJNLcMuZubnfNqkuNH9wEgtWJ2nWcADRFAmQoB
	 OS5YRggLYqG3NXT5fjZPKjbShCbhvksY+vPfx/E5RicLlDttYNnXzK8e0D9PCqNwBR
	 c1xaxVXOYSS6fNx8lkTx2IndyyAmPgISU5SNEEeGfiVw0OdISVK
Received: from imp.flyn.org (guardian.flyn.org [137.26.240.242])
	by www.flyn.org (Postfix) with ESMTPSA id 47E6A1EE0029;
	Sun, 28 Jul 2024 10:27:00 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722180420; bh=z9zu7Sv+fryLDkxfRdsC2WVIfA7U9AmpHts5yUDZT0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dfbol23poWOQN8orFWPBNk1bNC5pAPH2K2mvFGtKbL4Ztv9jcGPE928gJYor1ursX
	 geDhf42cj3VzoB1HDIUy10nX8i7MljuqE2ldUKbBH+O3mZ8X1IHoypBBZpOdB4D6P1
	 We6fF3kTMfBdjpZvoahAG8/IhvXF26gxsfuiVYESv0cXQ1bZh6kowl3DUQYkPA35AU
	 toa0kQICckrDPIUtLVTL+16K+5SIGe6qKfk3eg/cfRDH2InmrCwEi1g0T/+9AkHWA3
	 5iSkmKBLs6d9ojTwXyi7YWkNHwrDk8Za4tXoDXB5INDTx0DyfUAMRHc7ti97AB4OwD
	 ixQDjI4eHJIis2gkCZ+/bhgjmiB+lJNLcMuZubnfNqkuNH9wEgtWJ2nWcADRFAmQoB
	 OS5YRggLYqG3NXT5fjZPKjbShCbhvksY+vPfx/E5RicLlDttYNnXzK8e0D9PCqNwBR
	 c1xaxVXOYSS6fNx8lkTx2IndyyAmPgISU5SNEEeGfiVw0OdISVK
Received: by imp.flyn.org (Postfix, from userid 1101)
	id 37D342D8D7CE; Sun, 28 Jul 2024 10:27:00 -0500 (CDT)
Date: Sun, 28 Jul 2024 10:27:00 -0500
From: "W. Michael Petullo" <mike@flyn.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <ZqZjRMqpEV_3WIkD@imp.flyn.org>
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727215845.GA1263246@coredump.intra.peff.net>
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.5

>> Glen Choo's commit 6061601d modified Git so that safe.directory could
>> be set on the command line using "-c". It seems most sub-commands work
>> this way, but not "clone". Here is an example:
> 
> This is because upload-pack, the server half of a fetch/clone, is run as
> a separate process which does not accept the client-side "-c" options.
> See this email for more details and a workaround:
> 
>   https://lore.kernel.org/git/20240529102307.GF1098944@coredump.intra.peff.net/

Thank you, Jeff! This works and makes sense, although I can see how users
would be confused by the edge case.

For completeness, I investigated how to do the same over SSH. Imagine a
repository user-owned by Bob, but group-owned with r/w/x permissions by
a group containing Alice. It seems the same trick fails because git-shell
rejects the custom upload-pack command:

	git -c safe.directory="*" clone -u 'git -c safe.directory="*" upload-pack' alice@git.example.com:/shared/repository
	Cloning into 'git'...
	fatal: unrecognized command 'git -c safe.directory="*" upload-pack '/shared/repository''
	fatal: Could not read from remote repository.

	Please make sure you have the correct access rights
	and the repository exists.

I was able to overcome this by creating /home/alice/git-shell-commands/upload-pack-safe,
placing the following there

	#!/bin/sh

	git -c safe.directory="$1" upload-pack $1

and running:

	git -c safe.directory="*" clone -u upload-pack-safe alice@git.example.com:/shared/repository

This seems to be another interface edge case. Is my solution reasonable,
or is there something else that would be more consistent?

Related: Would anyone be interested in working on an academic paper
about safe.directory? It seems like people who write Git forge-type
software or other collaborative systems based on Git would benefit from
a rigorous description of the conditions and operations under which the
use of safe.directory is indeed safe. I am not sure I have this worked
out in my own mind yet. Something like "Setuid Demystified" from USENIX
2002 might help.

-- 
Mike

:wq
