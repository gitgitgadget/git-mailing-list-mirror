Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1632BF38
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519343; cv=none; b=NkRsrieSXzgOUCDbUQ1K0F68DoIXc+rTFAWtMJuhQHG0gBfsYkD2issrS1B6qD64PjJOt9ykVz5eY1nsTk7ri+4m/hLP+ttq0z9tjMI8MQaprZfv0D4P4OR0jo7fSVRFdYAv9x7O/eNxAOC8rbQFe121zHpctpJTD+0sa9HurW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519343; c=relaxed/simple;
	bh=0Z3MkPovAMJ0+A02DKaZeZZn8qYzU5zMUlDxHkX06Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czP/lFJw37azx3tctK9nen60faOyhMqYh1BRgUsLrMXXPO9Dd7Mt7pwIo2HQHJIam8sK4qAI5QHqTCnMS3JkcY0NgWz3H2I6kg/IiLqvJmJoD8Wbbx+84TkPH2YoE2R5P+UW/laMUfVplPNigu1PkHyyxxurW7f/SA50WjnfrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nw3CEycX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nw3CEycX"
Received: (qmail 41711 invoked by uid 109); 10 Sep 2025 15:49:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0Z3MkPovAMJ0+A02DKaZeZZn8qYzU5zMUlDxHkX06Z0=; b=Nw3CEycX4j+IhDZDwOvedfDz2TDUHsqR0rgzKYJk+9jaqcbarFjocPQUysNDjfCQRdfNNkLqHSVE3tvhOZ+Kn2/4Db81K+GjgM569YQ5uwvsrn3PI8q/zrOUjb7zUmRLImHliZ+8QZRt4Cm3A/cKVTuu/r1aHBFWpfiTyG2CId6vcRlFo3Ddqmr+/E1cuYosJUjaFIsvCb/Nduw1wIzkpXAJNfI9J3/hwO5hvRkBTUH2MMhl6RbgslZroXFcJ0ir+76IyXJXgxFQkjXJNNq9lam48/r8CkhImAWMnU6w/KUyDpFCvIi5WMMjkk9hLVbpyLpghs4O8tPAz0dvNyfF2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 15:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67858 invoked by uid 111); 10 Sep 2025 15:48:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 11:48:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 11:48:59 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/7] git: allow alias-shadowing deprecated builtins
Message-ID: <20250910154859.GB562601@coredump.intra.peff.net>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <672253e0e7167c40290d1fef6d5076adfbe25d80.1757446619.git.code@khaugsbakk.name>
 <20250910051347.GA556174@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910051347.GA556174@coredump.intra.peff.net>

On Wed, Sep 10, 2025 at 01:13:47AM -0400, Jeff King wrote:

> On Tue, Sep 09, 2025 at 09:45:52PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> 
> > +		if (is_deprecated_command(args->v[0]) &&
> > +		    alias_lookup(args->v[0])) {
> > +			if (!handle_alias(args))
> > +				break;
> > +			done_alias = 1;
> > +			continue;
> > +		}
> 
> I think this is failing the SANITIZE=leak jobs, because alias_lookup()
> returns an allocated string with the alias. You need to capture and free
> it, or introduce an alias_exists() wrapper to do so.
> 
> There might also be a way to do it just by calling handle_alias() and
> checking its return value (it seems to indicate whether an alias was
> found, but I didn't look through the whole function carefully, or think
> about the implications of how the done_alias flag works).

I _think_ this is correct:

diff --git a/git.c b/git.c
index 47857d280f..ea9ec77a88 100644
--- a/git.c
+++ b/git.c
@@ -823,9 +823,7 @@ static int run_argv(struct strvec *args)
 		 * deprecation complaint in the meantime.
 		 */
 		if (is_deprecated_command(args->v[0]) &&
-		    alias_lookup(args->v[0])) {
-			if (!handle_alias(args))
-				break;
+		    handle_alias(args)) {
 			done_alias = 1;
 			continue;
 		}

The handle_alias() function will either:

  - return 0 if it does not find an alias

  - return 1 if it finds an alias and we should loop again to run that
    command (but set done_alias so we know to suppress in-process
    builtins below). The "args" array will have been updated with the
    new command name.

  - exit itself if it's a "!" shell alias that we exec

So we just need to loop again when it told us that it found an alias (it
is tempting to just continue in the loop body, but that would miss the
case of a deprecated alias that resolves to another deprecated alias).

Anyway, I believe that is correct and solves the leak issue (because
handle_alias() does the lookup and takes care of cleanup itself).

-Peff
