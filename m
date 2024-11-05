Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4433080
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819148; cv=none; b=RfV3b6sVeMwlpu2THJWfA4oikMUos0sv/XFBdWSmA6VEn7cWPlN2ntn+zQ7Jgufd4cg40R9px5q3l/NHlsSRyFgbhUOX/0tiAw6w97eBIkZuxiZhCTr3BghqDQNb3l6pXYoED21OCUwwAFyFeMVYnBWweqz5HhszFU4SaquZzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819148; c=relaxed/simple;
	bh=METvBhAifPVSQqQRtToS/S6YSDnmIQkkyyrCeI+ezec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/UtCUGo8S1NddEBVDCazNgdoQ8yBWRfFQwwu9zhJQ5H37lTT3x+uTDdNfeUQJr4oGTYndoTZ7EE2mAt3p4alOPGcB0N6tidYNIcCMBty9TBm4hJ6IZE53SZkK/sZyC+uBkyOL/HoQQa/qbHHiaPHT/ZYxugjrx6loH72P+158A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=chE+y/om; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="chE+y/om"
Received: (qmail 25545 invoked by uid 109); 5 Nov 2024 15:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=METvBhAifPVSQqQRtToS/S6YSDnmIQkkyyrCeI+ezec=; b=chE+y/omPfL3/Lba2qL7oqbvFvG6Y2KE6GcaDrjo+Xd0DiDGUKGYAtJ4KRJonZsW9/2PKbtwcOpottaNSfpO2KIiYVZyY0ExLvMOeAXjcqn+F6kBCI5KWEg3bEXHiYDeP2+/JsEi3S2vwlaizt7Kt1+emSBCTW3kckaGEROYa9v4F/idqfHSh5J2T5rtMd6ZyAP+QrlKF9RjiouiHsnqhSr9yZNuLPVyVg3fWdAQvQAk35BDYfArnoxaBcAFRn3vGD5aiugUbA9Hb8DxQ7+ejw4RXEjY1KWV6BoI2jfI7u2Aof4r7DYpkz7wTJueHCYFMPMQafDfF9yyt+z/QhX4TQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Nov 2024 15:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25687 invoked by uid 111); 5 Nov 2024 15:05:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2024 10:05:41 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Nov 2024 10:05:40 -0500
From: Jeff King <peff@peff.net>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: git format-patch escaping issues in the patch format
Message-ID: <20241105150540.GA3043294@coredump.intra.peff.net>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
 <20241104235432.GB3017597@coredump.intra.peff.net>
 <3a96888e76e4dd26a3b0a81a19cda8ec7de72662.camel@scientia.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a96888e76e4dd26a3b0a81a19cda8ec7de72662.camel@scientia.org>

On Tue, Nov 05, 2024 at 02:03:21AM +0100, Christoph Anton Mitterer wrote:

> On Mon, 2024-11-04 at 18:54 -0500, Jeff King wrote:
> > As you note, the mbox format is not well defined. :) The variant with
> > ">"-quoting of "From" lines is often called "mboxrd", and you can get
> > it
> > with the "--format=mboxrd" option.
> 
> But as you've said below, here too, the receiving side most likely
> doesn’t know that and then a wrong commit message would be applied
> (with no unescaping being performed or it would simply break again when
> the magic From is used).

I think there are two differences between ">From" and quote "---":

  1. There are already mbox parsers that understand and unquote ">From".
     If you know you are feeding your patches to such a parser (e.g.,
     the one in mutt) then using "mboxrd" makes sense.

  2. The consumer of the mbox format is much "closer" than the consumer
     of the "---" line.

     If you produce some patches with format-patch, you might feed them
     to your MUA or another local tool, and you know how that tool will
     unquote them. Once you email the patches, that ">From" quoting is
     irrelevant, because the receiver will get individual emails without
     the quoting. They may themselves choose to store them in an mbox,
     of course, but the details are up to them.

     Whereas the "---" line is inside the email, and will be interpreted
     on the other end by a tool like "git am". So if we introduce
     quoting in format-patch and unquoting in git-am, then correctly
     unquoting will depend on the version that the other side is using.

IMHO that is not necessarily a reason to avoid implementing quoting. If
you do accidentally put "---" in a commit message, the current outcome
is for your commit message to get silently cut off by "git am". But in a
world where we quote it and the other side is too old to unquote, then
they may end up with an extra quoting character in the result. But that
is probably a less bad outcome overall.

  There's also another flip-side mistake, which is somebody who doesn't
  quote sends to somebody who unquotes, and the result is similarly
  slightly corrupted. The mbox equivalent is that you meant to say
  ">From" with the ">", but the receiver turned it into just "From".

So I don't think it's a totally wrong direction to go. But like I said,
it doesn't seem to happen often enough in practice that anybody has been
motivated to add the feature.

-Peff
