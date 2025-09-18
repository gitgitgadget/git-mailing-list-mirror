Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFF22D7A1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227961; cv=none; b=gspP0kGkMHeRmXQlwfAccifZzJlWtco2mMS4ZLne6YzZYGwvsHB6aJl6zd/S5oCt3aVIJge17IftM7AqGt4Eik7FnDy1AQDY7cT71F0rvaDSkfxsJMI4mA94oNuIFg64nuGpsFaRXSNcRHpuVpU76kdImetXdxb1DcY2FJf/RCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227961; c=relaxed/simple;
	bh=+U5+VcSbVgz5wnuS9ddTVAaH5Tu3Ll+J1P71FWS4uWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKYpXnloU6hhLlOIuF38LhnExEAZ4cHv0Y6o+4Tm+2yTIThz4DEDlo8HJscPuLEIg3lP1pl/mLI06cZz3XOHIDEUlvqJ5rnUbkTUWZkVwWg1U8tZsNLdZVI2gqBdqaw081KJCA2+26Tf18CCJa/HDQ3BkgDK42I3pDLwV+t2eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WGAh9k3y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WGAh9k3y"
Received: (qmail 122530 invoked by uid 109); 18 Sep 2025 20:39:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+U5+VcSbVgz5wnuS9ddTVAaH5Tu3Ll+J1P71FWS4uWw=; b=WGAh9k3ybg/x2zIzV/nfGp22u/FJx6yq1dWAWfWJyTV9+go6V4vjfdpMLl0JoH9MdlMJF83eM8WjIWaG+tJO0rUAmySyJVjSCsaL448A2t5U+O6y3aS/kyUPPK+yNYSM2kevSfgpOdaGmc53Faao6tYxiN+BqbAbjnzB3Dg2O5fkt0HO71qg0pInpyrKDmMcC0S+e8unJDUDWOpZnY42uIK2pGwoYGMbRRuvPay5VQPJvnzJOm5roFh+Qo1AR/AMm8+bLM8fcNu53Hxx5hzR/sBgT/CMfZ9hDsrpjPUqf+6bVx3mfqYqGKg5dCr7UmkoUPd8ib70DBxKv05YVBRFIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 20:39:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 196029 invoked by uid 111); 18 Sep 2025 20:39:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Sep 2025 16:39:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Sep 2025 16:39:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kevin Puetz <PuetzKevinA@johndeere.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Bug] git fetch --dry-run --filter makes changes to .git/config
Message-ID: <20250918203916.GA1199728@coredump.intra.peff.net>
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
 <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
 <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
 <20250918192045.GA1187769@coredump.intra.peff.net>
 <xmqqms6r7bf7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms6r7bf7.fsf@gitster.g>

On Thu, Sep 18, 2025 at 01:28:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would probably be better if it established a separate tmp-objdir area
> > (like we do for pushes before we commit to storing them), fetched the
> > objects into that, and then threw away the result. That technique did
> > not exist back when "fetch --dry-run" was added, but it probably
> > wouldn't be too hard to do now.
> 
> It is true that the quarantine mechanism did not exist.  But I am
> not sure if a true dryness is actually better.  We do verify that
> the incoming objects thrown at us by the other side are healthy, so
> the only difference is that our object database will have extra
> unreachable objects that are known to be healthy between the time
> you run a dry fetch and the time you then run a real one.  And these
> extra objects that are healthy will help your real fetch go faster
> if the dry fetch and real fetch are run back to back thanks to "do
> we have all the necessary objects already, just that they may not be
> connected to the refs yet?" check.
> 
> So it may not be hard with the building blocks, but I am not sure if
> it is a good idea to do so in the first place.

Yeah, I see how the current behavior could be useful. In this particular
case the objects _aren't_ really healthy. They are promisor cruft that
violates all the usual everything_local() rules (but at least we set up
the config to mark them as such). But I take your point that we probably
shouldn't change anything here.

You _can_ do the tmp-objdir thing yourself with GIT_OBJECT_DIRECTORY, as
I showed earlier. It is unfortunate that doing so updates the repo
config, though. That may show a mismatch in how the promisor information
is stored (it is really a property of the packfile in the object
directory, but the config mechanism stores it in the main repo). But it
is probably not worth trying to revisit at this point. It is only when
you start to play weird games like "this repo's object directory is not
$GIT_DIR/objects" that you run into these distinctions.

-Peff
