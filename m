Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F46BB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE35DE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 23:11:22 -0700 (PDT)
Received: (qmail 6760 invoked by uid 109); 25 Oct 2023 06:11:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Oct 2023 06:11:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32339 invoked by uid 111); 25 Oct 2023 06:11:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Oct 2023 02:11:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Oct 2023 02:11:20 -0400
From: Jeff King <peff@peff.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <20231025061120.GA2094463@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <ZTJaVzt75r0iHPzR@ugly>
 <20231023184010.GA1537181@coredump.intra.peff.net>
 <ZTbOnsxBFERPLN3F@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTbOnsxBFERPLN3F@ugly>

On Mon, Oct 23, 2023 at 09:50:54PM +0200, Oswald Buddenhagen wrote:

> > The "//" one would
> > work, but we support perl versions old enough that they don't have it.
> > 
> according to my grepping, that ship has sailed.
> also, why _would_ you support such ancient perl versions? that makes even
> less sense to me than supporting ancient c compilers.

It may be reasonable to bump the default perl version for the script.
But that would require somebody digging into what tends to ship these
days (which can be sometimes be surprising; witness macos using old
versions of bash due to license issues), and then updating the "use
5.008" in the script.

The "//" operator was added in perl 5.10. I'm not sure what you found
that makes you think the ship has sailed. The only hits for "//" I see
look like the end of substitution regexes ("s/foo//" and similar). But
if we are not consistent with the "use" claim, that is worth fixing.

-Peff
