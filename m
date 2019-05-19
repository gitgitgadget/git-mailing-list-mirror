Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F791F461
	for <e@80x24.org>; Sun, 19 May 2019 17:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfESREl (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:04:41 -0400
Received: from thyrsus.com ([71.162.243.5]:56288 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfESREl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:04:41 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 360E04703049; Sun, 19 May 2019 00:09:02 -0400 (EDT)
Date:   Sun, 19 May 2019 00:09:02 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        'Derrick Stolee' <stolee@gmail.com>
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190519040902.GA32780@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <20190515234034.GB124956@thyrsus.com>
 <b4b151ba-ab43-445f-6e49-ee8e28b30859@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b151ba-ab43-445f-6e49-ee8e28b30859@iee.org>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org>:
> > But I don't quite understand your claim that there's no format
> > breakage here, unless you're implying to me that timestamps are already
> > stored in the git file system as variable-length strings.  Do they
> > really never get translated into time_t?  Good news if so.
> Maybe just take some of the object ID bits as being the fractional time
> timestamp. They are effectively random, so should do a reasonable job of
> distinguishing commits in a repeatable manner, even with full round tripping
> via older git versions (as long as the sha1 replicates...)

Huh.  That's an interesting idea.  Doesn't absolutely guarantee uniqueness,
but even with birthday effect the probability of collisions could be pulled
arbitrarily low.

> As I understand it the commit timestamp is actually free text within the
> commit object (try `git cat-file -p <commit_object>), so the issue is
> whether the particular git version is ready to accept the additional 'dot'
> factional time notation (future versions could be extended, but I think old
> ones would reject them if I understand the test up thread - which would
> compromise backward compatibility and round tripping).

Nobody seems to want to grapple with the fact that changing hash formats is
as large or larger a problem in exactly the same way.

I'm not saying that changing the timestamp granularity justifies a format
break.  I'm saying that *since you're going to have one anyway*, the option
to increase timestamp precision at the same time should not be missed.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


