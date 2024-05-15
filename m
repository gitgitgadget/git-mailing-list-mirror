Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8D5E093
	for <git@vger.kernel.org>; Wed, 15 May 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769721; cv=none; b=QfTA4IWr79nuFbhab+FtwLo+8q0SVygiTEV0bCXylQAq5zTprTkTijrEZiN3djbI0HTGkwz19fIUw1XBELkuGAqbPd5wqPfLqzVUe6fALmadyS1H5ffgTV+NW/BBQ6c5N0vBUx4xakdgpgXIywAZ+VlhzmfCQOjVsvuODD4s7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769721; c=relaxed/simple;
	bh=R6vzhyToJ7r4zEZwwjG2WH5ymfeEc2jB6IKm4bMim0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCiG2GFdF+e7jig7O4eCxKEAam+n7Jd0abVgv0GbKestZ76f3+65CVAYoy0ALobdQL1adMnjcURycjGhRgICf5Idrcfb+Ag2HfCWasRrwzi9DqyZZm+gvApZ0lbAbHg9mdMODOXwSpwMsWp3eKLo9ZtL+zneVZOCutLfkVENKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bGxVsupR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bGxVsupR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=1nWx4qr9D/rYWEOondKKuXUjEvFWm3BzBN2CXEf3gik=; b=bGxVsupR6KYm5WSV
	tQ2ybQj4ELEDYI6MAuSzWFz7cPpUJusyPfisjy5snjUacPP8sp8WiMkO6v4/OiZpa161NJfezzf1d
	KDD0CfpG9grCKlbZAZj5zFIaOLohQmEQ1uqvStAg2NNoIg08gPxcyDxVscE2DVDM8+BTtdbXOwpWG
	+iEiZj//VKQgtNMlfK3tEASJWuxFGkHtz4TbkvMiMset/Xp0b3pRewkHPSzZ6GSbECm653fFU8vEc
	2m3tn+aL7ndRKZ5XR5OdrPp34WUW0UNP+Dh5RmHWrbz1yUi+VqjXU1iN+tkagzlawTAlKu+8XACWi
	waUZQjT2Fqbby48+Sg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7C4z-0012GI-1r;
	Wed, 15 May 2024 10:41:49 +0000
Date: Wed, 15 May 2024 10:41:49 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH] fetch-pack: Remove unused struct 'loose_object_iter'
Message-ID: <ZkSRbSgQ-whUdms-@gallifrey>
References: <20240512005913.342287-1-dave@treblig.org>
 <20240515064658.GE110841@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240515064658.GE110841@coredump.intra.peff.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:39:39 up 6 days, 21:53,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jeff King (peff@peff.net) wrote:
> On Sun, May 12, 2024 at 01:59:13AM +0100, Dr. David Alan Gilbert wrote:
> 
> > 'loose_object_iter' in fetch-pack.c is unused since
> > commit 97b2fa08b6b9ee3e ("fetch-pack: drop custom loose object cache")
> > Remove it.
> 
> Thanks, this was my fault for leaving it in. The patch looks obviously
> good.

Thanks.
Most projects I've looked at seem to have one or more.

> I wish there was a good way to get the compiler to report on unused
> types, but I don't think there is (it's a complicated problem in
> general, but file-local ones like this feel like they should be easy to
> spot).

Alas not.

> Here's a really hacky (and quadratic) attempt to find defined structs
> that aren't mentioned elsewhere:
> 
>   for i in $(git grep -ho '^struct [a-z_]* {' | cut -d' ' -f2)
>   do
> 	used=$(git grep -Phc "\b$i\b" |
> 	       perl -ne '$x += $_; END { print $x }')
> 	echo "$used $i"
>   done |
>   sort -n
> 
> which finds exactly one unused struct, the one in this patch.

My similarly hacky script was:
  
  grep -r '^struct [^(=]* {'| tr ':' ' ' |
  while read FNAME STRUCT NAME TAIL
  do
    echo "$FNAME" | grep -q '[.]c$' || continue
  echo ">>>" $FNAME ' : ' $NAME
  echo -n "Count: "
  grep $NAME $FNAME | wc -l 
  #grep $VARNAME $FNAME
  done

(A count of 1 being the unused ones).

Dave


> 
> -Peff
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
