Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37678C2BA16
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 03:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C7C206B8
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 03:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDGDqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:46:47 -0400
Received: from aibo.runbox.com ([91.220.196.211]:60498 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDGDqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 23:46:47 -0400
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jLfCF-0008RC-V5; Tue, 07 Apr 2020 05:46:44 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jLfC5-0001ES-W1; Tue, 07 Apr 2020 05:46:34 +0200
Date:   Tue, 7 Apr 2020 03:46:22 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200407034622.GA42812@pluvano.com>
References: <20200405231109.8249-1-me@pluvano.com>
 <xmqqd08lwatm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd08lwatm.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-05 20:29:57-0700, Junio C Hamano wrote:
> Is the RFC2047 the only thing we do to message headers?  What I am
> trying is to figure out if "encode-headers - yes/no?" would be a
> stable (iow, would we be gaining other kinds of encoding over time?)
> and well-defined (iow, is there a case where one kind of 'encoding'
> is still desirable while disabling other kinds of 'encoding' is
> wanted?) question.  If there is any doubt in your answers to the
> above question, we may have to make sure the name of the option
> makes it clear to users what kind of encoding we're talking about.

It's also too vague and it's not entirely clear from the option itself
what sort of encoding it refers to. I will change it to
--[no-]q-encode-headers and format.qEncodeHeaders in v2 unless there are
other suggestions.

> > +--[no-]encode-headers::
> 
> I think we'd want to standadize on writing these out, i.e.
> 
>         --encode-headers::
>         --no-encode-headers::
> 
> so let's follow that when adding a new option.

OK.

> > +	Encode email headers that have non-ASCII characters with
> > +	"Q-encoding", instead of outputting the headers verbatim. The
> 
> I wonder if calling RFC2047 out helps readers here, when they wonder
> what Q is and how they can decipher it.

I'll reference the RFC directly in v2.

> > +	default is `--encode-headers` unless the `format.encodeHeaders`
> > +	configuration variable is set.
> 
> I am wondering if we can go even shorter, e.g.
> 
> 	The default is set to the value of `format.encodeHeaders`
> 	configuration variable.

OK, I'll go with that.

> > -		if (needs_rfc2047_encoding(namebuf, namelen)) {
> > +		if (pp->encode_headers &&
> > +				needs_rfc2047_encoding(namebuf, namelen)) {
> 
> Don't overly indent the second line like this.  The same comment
> applies to the next hunk (not quoted).
> 
> Thanks.

OK.
