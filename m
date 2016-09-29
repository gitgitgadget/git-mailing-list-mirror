Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5A371F4F8
	for <e@80x24.org>; Thu, 29 Sep 2016 05:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbcI2Fdr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 29 Sep 2016 01:33:47 -0400
Received: from elnino.lfos.de ([46.165.227.75]:37937 "EHLO elnino.lfos.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbcI2Fdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 01:33:45 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Sep 2016 01:33:45 EDT
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id a9cdd700 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 29 Sep 2016 07:27:02 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     git@vger.kernel.org
From:   Lukas Fleischer <lfleischer@lfos.de>
In-Reply-To: <20160929024400.22605-1-szeder@ira.uka.de>
Cc:     =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>, peff@peff.net,
        torvalds@linux-foundation.org, git@vger.kernel.org
References: <20160928233047.14313-5-gitster@pobox.com>
 <20160929024400.22605-1-szeder@ira.uka.de>
Message-ID: <147512682170.7989.11263315726387435240@typhoon>
User-Agent: alot/0.3.7
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
Date:   Thu, 29 Sep 2016 07:27:01 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Sep 2016 at 04:44:00, SZEDER Gábor wrote:
> I for one raise my hand in protest...
> 
> "few extra bytes" is not the only downside, and it's not at all about
> how many characters are copy-and-pasted.  In my opinion it's much more
> important that this change wastes 5 columns worth of valuable screen
> real estate e.g. for 'git blame' or 'git log --oneline' in projects
> that don't need it and certainly won't ever need it.
> 
> Sure, users working on smaller repos are free to reset core.abbrev to
> its original value.  I don't have any numbers, of course, but I
> suspect that there are many more smaller repos out there that this
> change will affect disadvantageously, than there are large repos for
> which it's beneficial.

I know this suggestion comes a bit late but would it make sense to let
the repository owner overwrite the core.abbrev setting?

One possible way to implement this would be adding .gitconfig support to
repositories with a very limited set of whitelisted variables allowed in
there (could be core.abbrev only to begin with). Or some entirely
separate mechanism like .gitignore.

With such a mechanism, we could keep the default of 7 which works fine
for most projects. Linus could bump the default to 12 for linux.git. If
some users are not happy with that, they can still overwrite it in their
local Git config. Anybody starting a project could change the initial
value to a suitable value in one of the first commits -- provided they
already have an idea how much the project will grow. That way, hashes
will be "long enough" even for early commits, before any heuristics
could guess that the project would become large.

Opinions?

Regards,
Lukas
