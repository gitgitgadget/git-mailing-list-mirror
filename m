Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CE7203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbcG0ORm (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 10:17:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36846 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753991AbcG0ORm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 10:17:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0FBC620791;
	Wed, 27 Jul 2016 10:17:41 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute1.internal (MEProxy); Wed, 27 Jul 2016 10:17:41 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=pennock-tech.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=MbJi5uj5b/yzDL7SRNvY9hcJum8
	=; b=beUKoSsXMEO3wRMEIwhWQXYL8baXZuMdMcmd/G2WTNN1kkAQzYnIAM/qV1K
	pz9ekNin3/IadQB/2qdi6GJVJAeZeKkAkTOOmEnyGzpPCgVrG2aUf+ff5txXv+DA
	JN38agKGja7BG19LZG/52uHpP+lSVtfcYsK4c18zirCytmEg=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MbJi5uj5b/yzDL7
	SRNvY9hcJum8=; b=XALBfJq9yQxDeLC/R8WCn048CA7ky63rJ77VKc9E/y3ZM60
	S74uhD5wvFAHbSFd0KPz/IHa3etWUS4kXamSpznAwP/bS8+7nLqKk5io/Nb+N1od
	JRWtj+v8nSXATP1sAQ+lbjbgXR61jtpvpav5KmIxPylEaRHR5HCeqXkwS36U=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
	id CFD9FD0214; Wed, 27 Jul 2016 10:17:40 -0400 (EDT)
Message-Id: <1469629060.2278222.678276953.09D0768E@webmail.messagingengine.com>
X-Sasl-Enc: AbhZqzdUt5BzduuMCJKmrtdzh0xZiuBzzHHi0nuHayZL 1469629060
From:	Phil Pennock <phil@pennock-tech.com>
To:	Jeff King <peff@peff.net>
Cc:	"Theodore Ts'o" <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailer: MessagingEngine.com Webmail Interface - ajax-217db728
In-Reply-To: <20160727135820.GC14928@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727135820.GC14928@sigill.intra.peff.net>
Subject: Re: [PATCH] pretty format string support for reflog times
Date:	Wed, 27 Jul 2016 10:17:40 -0400
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016, at 09:58, Jeff King wrote:
> On Wed, Jul 27, 2016 at 04:14:14AM -0400, Phil Pennock wrote:
> > The reflog contains timestamp information, but these were not exposed to
> > `--pretty`.  Four of the six author/committer format string
> > second-letters were still available and copied, but `d`/`D` are taken
> > for reflog selector formatting.  So use `%gT` for "time" instead of
> > "date" mnemonic for using `--date=...` formatting.
> 
> Hrm. Since Ted was not cc'd, it is not clear to me whether this is
> coincidental or in response to the thread over in
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/299201

Coincidental, I was unaware of that.  Sorry for the duplication.  Please
ignore my patch, I'm not going to even try to compete with Mr Ts'o.

I asked a friend who is a git developer why this wasn't available, he
said it would be fairly easy to do, I asked if he was trying to suck me
into contributing patches to git, he said yes.  I neglected to search
archives for myself.

Besides "two independent submissions in short space of time" as evidence
that this functionality is wanted, my real-world motivator was: `go get
$something` failed, until I told the Golang tooling to update
dependencies too; after that I wanted to easily see when the dependency
was last updated on my local system and ended up having to look at the
reflog on disk and manually convert timestamps.

> To summarize, I think the conclusion there was that we would go with at
> least the 't' and 'r' formatters in the short term.

'r' and one of the non-relative renderers are the ones I put into a
`[pretty]` item for my use.

> to get "HEAD@{0} ...rfc-date...", because the presence of "--date" is
> the trigger to switch the meaning of "%gd".

Yes, I went for completeness even though it led to some duplication, and
tested them all. Though it looks like I didn't include the --date
modifications into the test-suite example.  Oops.

Thanks for the review and the cluebat.
-Phil
