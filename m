Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F537469
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1872 invoked by uid 109); 28 Dec 2023 11:43:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Dec 2023 11:43:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2708 invoked by uid 111); 28 Dec 2023 11:43:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Dec 2023 06:43:26 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Dec 2023 06:43:25 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout: be consistent with end of options
 markers
Message-ID: <20231228114325.GA627960@coredump.intra.peff.net>
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
 <20231224083206.GA2053380@coredump.intra.peff.net>
 <xmqqfrzoj31l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrzoj31l.fsf@gitster.g>

On Tue, Dec 26, 2023 at 09:18:14AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Dec 24, 2023 at 01:00:11AM +0000, Elijah Newren via GitGitGadget wrote:
> >
> >> Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
> >> bug.  Note that this does mean that anyone who might have been using
> >> [...]
> >
> > Thanks for wrapping this up in patch form. It looks good to me,
> > including the reasoning. You didn't add any tests, but I find it rather
> > unlikely that we'd later regress here.
> 
> Surely.  I am certainly OK with just dropping KEEP_UNKNOWN but I
> would strongly prefer to document what we "fixed" (your "misspelt
> option name" example) and what (mis|ab)use the people may have been
> relying on we have "broken" (the same "misspelt" behaviour that can
> be intentional is now forbidden, and we document that this change in
> behaviour is intentional) with a new test.

Yeah, thank you for talking some sense into me. I do not foresee us
regressing "--sikp-checks", but certainly covering --end-of-options in
more places is worthwhile. As it's handled centrally, it can have
unexpected consequences for various commands.

Elijah's latest version looks good to me.

-Peff
