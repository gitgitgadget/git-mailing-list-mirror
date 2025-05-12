Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7F134D4
	for <git@vger.kernel.org>; Mon, 12 May 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065418; cv=none; b=RN8xenZede9EpFU/4N7842beg1m7OB5LYJYXol9WGX82TBSok+iMNCwpzrg85pt7UrWZhR1B2KUS98Q2t4g8qUItNHNMjCdkwZ3vGE/l0hJh9BeqKLwj83xnsz8ubdq5z7avTMJF1n6EcQ3oldWzb/9SofDKk0tYiFCTzSKwPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065418; c=relaxed/simple;
	bh=y/LH/TCkr+uu7yOLpV3OkgXopftzxRoXL9dZy/7OBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHJI2OcFmS70TTa4fAQPfv5q/fwT7JZWW1hDCZjmT9S4wAS61tT2J8swzB6Jafd3z+oAjG58WZ9lqJ93YULFn8NXEVu+1JxT+a6ydqsARyRDlIuSkA0+Ovf0K0adc6MgoYt/hELTI+7ZU0HNRQOBlbXsXgo4MRA81FSMVbWsh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FKAFIAjb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FKAFIAjb"
Received: (qmail 2556 invoked by uid 109); 12 May 2025 15:56:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y/LH/TCkr+uu7yOLpV3OkgXopftzxRoXL9dZy/7OBvE=; b=FKAFIAjbWbEX+X8+UqmPuga1zquYAIqpErVscIvrcQsCk4X8JpqDeWU2BZlsQ0yV0wav1ZpB+kkea4rv+IYupzgaWFmtwIbwuG8IWOo1sMrOFxifSv6gJP/D2eW27nu8tEesKMf+Jp3GUMrp6EM7WEM2NRO+uxb3GKgRtzMz7y9ZUCcmSKNFACE23dePl833CTmD+Mx0VFqBWTFoEiKnLcmIPZhuBNgKTzckL1SQBaFmML1/aIhLhikGXWsK4N5isNBZo3dBEWd/BYicShaKNDJNPreKd0Jqhmjh8UT3BmQvdzxfuR+J+XyhfMTie1fDZ1l4RgbXXxOCftOo9A4Cew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 15:56:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8072 invoked by uid 111); 12 May 2025 15:56:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 11:56:56 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 11:56:54 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <20250512155654.GA1219668@coredump.intra.peff.net>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
 <aCGzIlLH_ESNg6-v@pks.im>
 <aCHoovrKiSUemBCL@ArchLinux>
 <aCIIL6IWiiWiGbFd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCIIL6IWiiWiGbFd@pks.im>

On Mon, May 12, 2025 at 04:39:43PM +0200, Patrick Steinhardt wrote:

> > And header is introduced in 694b7a1999 (repack_without_ref(): write peeled
> > refs in the rewritten file, 2013-04-22). At this commit, we would always
> > write the header into the "packed-refs" file.
> 
> So what happened before this commit? Would we end up writing a
> completely empty file?

Yeah, prior to that if you delete the final entry, you'd get an empty
file. Reproducible with:

  # you can use modern git for this part
  git init
  git commit --allow-empty -m foo
  git checkout --detach
  git pack-refs --all

  # old git writes empty file during deletion
  git.v1.8.4 branch -D main
  ls -l .git/packed-refs

Going back even further, we'd also write an empty file via pack-refs.
With git v1.4.4, doing "git init && git pack-refs" will get you an empty
file. I didn't bisect completely, but presumably that changed in
f4204ab9f6 (Store peeled refs in packed-refs (take 2)., 2006-11-21).

> I think it depends. If we can prove that Git (and other, third-party
> implementations thereof) wouldn't have ever written such "packed-refs"
> files then we should start warning now already, even if we accept such
> files at runtime. Otherwise, if there were versions of Git that could
> have ended up writing such files I agree that we have to accept this for
> now.

So we definitely did write those files. Those are pretty old versions of
Git, but something we should continue to support.

It may be useful for fsck to detect this, though, even if the default
message severity is set to "info" or even "ignore. That would allow
people who know they are using modern Git to increase it themselves (I
don't expect normal users to do this, but it would probably be useful
for forges which run automated "fsck" across a lot of repos).

And then the backwards-incompatible Git 3.0 thing would just be tweaking
the severity of the config (and in the meantime, it would help flush out
any unexpected instances people run into).

-Peff
