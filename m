Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6494266A4
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029396; cv=none; b=kT2Z8ISUdwNMAjmjvhfbSuLGbsDmIAEq5i3Zrx8Mqg3r+fAP8hcnjZmY7fOLTMCl5xXagicMnuC6I5lBd6mAaQRnGY+KByvWuJ1e03G05WaHt7V0KHJWmcM9IB5w3sBipGTD/R6vZob11r6YzrT8/SVawsqfjCiaAasChkApCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029396; c=relaxed/simple;
	bh=ukVntq79rB+uew4nfMY335IiyvdA12ElLcuzaMEn69M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyI0fu3a8qN0sbrQLLNxcTjOFkEbFWxyWA/k/RAfTBzy/mNmBYgOjVHh+MjmU3Mf5H6P10tzimsjHB6BiZ/FcznpowaDiYZHj97yIeRkgIyEr6KWKaINfEFp0y9XzidkRC7uL4eG2EBJO7n1eLoiOhcj9dAcq6fRC5W88u6BSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VGcgWrR/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VGcgWrR/"
Received: (qmail 123731 invoked by uid 109); 21 Jan 2026 21:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ukVntq79rB+uew4nfMY335IiyvdA12ElLcuzaMEn69M=; b=VGcgWrR/ntH3fOQQ2pfxhWrF8QvIaotLaaDFnDIQhP82DpYE83K5XVFTUBoF8pyidzDakYB8ROyugne5Jj4EzqVAiupO2icjJe1erpIKkdlK4cWCrBmpNSEguXYh4um1gJWLMTd1h5lLcRRx4WD1m1SF4vzMVu4qaLlF8HV7GQ51ZxtbHHMXD9UK6FihI7darBIKEUDfpkAWk1XM3l8vLQSkcWZWp+y3UFFpCafjisasn2XTWpft5U2guFjidYEswmO79D+i12u0otS541Z1+RVeIED88VwCCJFhEorB21qo5XrEHz2vIM3NkCCxDH6B7HJfwoH6RaUjdadmWjNScg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 21:03:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210495 invoked by uid 111); 21 Jan 2026 21:03:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 16:03:14 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 16:03:12 -0500
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: "alf.clement@gmail.com" <alf.clement@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: .gitignore issue
Message-ID: <20260121210312.GA723458@coredump.intra.peff.net>
References: <SL2P216MB1885CE309BDBA65860D8762FA296A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2P216MB1885CE309BDBA65860D8762FA296A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>

On Wed, Jan 21, 2026 at 06:51:02PM +0000, Pushkar Singh wrote:

> This is expected behavior.
> When a directory matches an ignore rule, Git stops descending into it entirely. The pattern
> 
>         backup_STOCKS*/
> 
> matches directories starting with backup_STOCKS, and once Git prunes traversal at that level, similarly prefixed paths can disappear from git status, which is why backups/ no longer shows up.
> 
> This isn’t a bug, but a result of how ignore patterns and directory pruning work.

I found this explanation confusing: surely we would never match
"backups/" itself via a pattern like "backup_STOCKS*". And I'm not sure
what you mean by "similarly prefixed paths".

But what I suspect is happening here (and what you were trying to get
at) is that Git will not report an empty directory as untracked. And one
that consists only of ignored files is considered empty.

So a simpler example:

  git init
  mkdir subdir
  git status

At this point "git status" will report nothing, because there are no
files at all.

If we add a file:

  echo foo >subdir/file
  git status

Now "subdir/" is untracked (unless you use --untracked-files=all, in
which case we actually list "subdir/file" itself).

And if we ignore it like this:

  echo subdir/file >.gitignore
  git status

Now subdir/ is no longer reported. And we get the same effect with an
un-anchored top-level pattern, which also matches in subdirectories:

  echo file >.gitignore
  git status

We can't know for certain this is what's going on because Alf didn't
show us what's in the backups/ directory, but one imagines it is also
full of backup_STOCKS_* directories.

> If you want to ignore only those directories and nothing else, anchoring the pattern helps:
> 
>         /backup_STOCKS_*/
> 
> You can also verify which rule is responsible with:
> 
>         git check-ignore -v backups/

So yes, both of these are very good advice.

-Peff
