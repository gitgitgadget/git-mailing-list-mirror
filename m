Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4ED50F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933AA7
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:13:28 -0700 (PDT)
Received: (qmail 1618 invoked by uid 109); 30 Oct 2023 09:13:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:13:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9406 invoked by uid 111); 30 Oct 2023 09:13:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:13:32 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:13:27 -0400
From: Jeff King <peff@peff.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <20231030091327.GC84866@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <ZTJaVzt75r0iHPzR@ugly>
 <20231023184010.GA1537181@coredump.intra.peff.net>
 <ZTbOnsxBFERPLN3F@ugly>
 <20231025061120.GA2094463@coredump.intra.peff.net>
 <ZTjedSluwyrVY+L9@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTjedSluwyrVY+L9@ugly>

On Wed, Oct 25, 2023 at 11:23:01AM +0200, Oswald Buddenhagen wrote:

> On Wed, Oct 25, 2023 at 02:11:20AM -0400, Jeff King wrote:
> > The "//" operator was added in perl 5.10. I'm not sure what you found
> > that makes you think the ship has sailed. The only hits for "//" I see
> > look like the end of substitution regexes ("s/foo//" and similar).
> > 
> grep with spaces around the operator, then you can see the instance in
> git-credential-netrc.perl easily.

Ah, yeah, there is one instance there. That script does not have a "use"
marker, though, and we do not necessarily need or want to be as strict
with contrib/ scripts, which are quite optional compared to core
functionality like send-email.

That said, I do suspect that requiring 5.10 or later would not be too
burdensome these days. If we want to do so, then the first step would be
updating the text in INSTALL, along with the "use" directives in most
files.  Probably d48b284183 (perl: bump the required Perl version to 5.8
from 5.6.[21], 2010-09-24) could serve as a template.

-Peff
