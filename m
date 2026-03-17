Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75153E9F93
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759349; cv=none; b=ZAgRwG102+REGs42k5AkdeVoxFgZRO3N9p8dFNtEDtCJwVLld2nSZVOm69tEKXCD+KYYrwtRkAWU0UMrVJCW7MiBXM0vUnWApRizR4FVDnvxUu4h4pkOpjxyOrjU//6a75TVPsCkHU2RG7PwxfER/cXIUCxTg6n3/lF9WeCFZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759349; c=relaxed/simple;
	bh=Kaj88K9cyVhqnpahNmPlRX/d7X1IktgQbXniM7+q3g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBdW4cWGiK2JXl+fUYTtcpXS3jztCyfHHRjqob9yNxdnsLGbLtW+GGNhcH/2pZojSVmE/ZcdwX39dbzBL4a54DbPcPdqIzXOcS5H8LBGVoGf+Ft1GuCVsPsjMDsXhJmEObF0MZwBdbew2xZrkPqbkotKLXx95Il1E6pIATrj/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GCHiUdJW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GCHiUdJW"
Received: (qmail 30749 invoked by uid 106); 17 Mar 2026 14:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Kaj88K9cyVhqnpahNmPlRX/d7X1IktgQbXniM7+q3g8=; b=GCHiUdJWubKrRgXgooenGOYzeJ6naUogWs11aOMtcHCwoBcpvdLQORu1pFKs9ZZpB6JkOb7F/ls1bXiVo4rdBnvSRy/YBFcwY7FSHWx6QXdhn0N+J63KZen1RQR0pPy7TyjcYOArdnPDrtswBsbDGOlusZzJfNEaAeEEe6Da6Fv0eoSLk4sBvKkn8EaMWd7homfVsI0evOPaLm5uZYXHEBDBI5qJHtTDVVSFJwZ4BcjJe8u1FnO33DplG2tXHwwRCa51Rjoaz1o/qzYr6GBTT5YJeweTacMse1tEHQvG6tEoDQJKIiwRj4PwtDFX2j7OzjgczZOWIxH/wvRnoN+IhA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Mar 2026 14:55:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46638 invoked by uid 111); 17 Mar 2026 14:55:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 10:55:43 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 10:55:43 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <20260317145543.GA1828@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
 <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>

On Tue, Mar 17, 2026 at 11:59:02AM +0000, brian m. carlson wrote:

> On 2026-03-17 at 00:47:19, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > > ---
> > >  parse-options.c               | 2 +-
> > >  t/t1502-rev-parse-parseopt.sh | 9 +++++++--
> > >  t/t1502/optionspec-neg.help   | 1 +
> > >  t/t1502/optionspec.help       | 1 +
> > >  4 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > Has t1517 passed for you?
> > 
> > Queued directly on top of v2.53.0, I am seeing:
> > 
> > >>>>>
> > expecting success of 1517.169 ''git instaweb -h' outside a repository':
> >                 test_expect_code 129 nongit git $cmd -h >usage &&
> >                 test_grep "[Uu]sage: git $cmd " usage
> > 
> > test_expect_code: command exited with 0, we wanted 129 nongit git instaweb -h
> > not ok 169 - 'git instaweb -h' outside a repository
> > <<<<<
> 
> I thought the tests passed, but I may have neglected to run them on the
> latest revision.  Go ahead and drop this for now and I'll send out a v2
> either tonight or later this week.  My apologies.

Hmm. Is this just a matter of tweaking the tests, or is there something
bigger going on?

These tests are _expecting_ the 129 exit code from most commands. And
indeed, "git log -h" produces 129 for example. So it is not just shell
scripts using "rev-parse --parseopt" that do this, and those scripts are
(currently) consistent with the rest of Git.

You'd need something like this (untested) to hit the non-shell commands:

diff --git a/parse-options.c b/parse-options.c
index 85e2f0ea7c..0ad43ca278 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1197,6 +1197,7 @@ int parse_options(int argc, const char **argv,
 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
+		exit(0);
 	case PARSE_OPT_ERROR:
 		exit(129);
 	case PARSE_OPT_COMPLETE:
@@ -1495,11 +1496,11 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 		if (!strcmp(av[1], "-h")) {
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_NORMAL, USAGE_TO_STDOUT);
-			exit(129);
+			exit(0);
 		} else if (!strcmp(av[1], "--help-all")) {
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
-			exit(129);
+			exit(0);
 		}
 	}
 }

I agree with the general idea that "-h" usually should exit 0. But this
is not just a bug fix for --parseopt, but a change in overall intent. It
might be worth digging in the commit history or list archive to see if
there's any discussion on why we are using 129 in the first place.

-Peff
