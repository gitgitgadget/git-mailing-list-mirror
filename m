Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5478E1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 08:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfAaI3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 03:29:06 -0500
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:45782
        "EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfAaI3G (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 31 Jan 2019 03:29:06 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 03:29:06 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id p7bRgmxQQwsznp7bWgFDYR; Thu, 31 Jan 2019 01:21:47 -0700
Date:   Thu, 31 Jan 2019 10:21:41 +0200
From:   Max Kirillov <max@max630.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190131082140.GA24787@jessie.local>
References: <20190130231359.23978-1-max@max630.net>
 <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfIwZ195g7ueq8H2e07FIM2vEZCAYG3GKz0ppKaBfGLWx8H0ei7NkHnrsG7n4duGKq5B3iv0Tk+GB3cVsuuQ5WF43vCXGZlFilCNauAFs7EW3cm+B/9Tu
 uUbPGj4xEQzv5Qe+LylzgzfAyN1Q1m4uVtVIHiXVHG+cXcc6fUEOf0YDnDcXzXixA4hBeTb2TutztLHgQbW83Uve8qSZxqwJXmUG8OnypJKhIJzqfbXvbMeK
 d5f/R5dCmahigmGHGIYhrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 06:31:34PM -0500, Eric Sunshine wrote:
> On Wed, Jan 30, 2019 at 6:21 PM Max Kirillov <max@max630.net> wrote:
>> +                               strbuf_addf(err, "broken sorting in packed-refs: '%s' > '%s'",
>> +                                           prev_ref.buf,
>> +                                           iter->refname);

> strbuf_release(&prev_ref) either here or after the "error" label.

Thanks! I seem to forget about it.

> > +               git branch b$(printf "%02d" $num) || break

> This should probably be "|| return 1" rather than "|| break" in order
> to fail the test immediately.

I've been looking for the correct way, and have seen the
break somewhere. Now I see the "return 1" is mostly user.
Thanks, will fix.

> Use test_must_fail() rather than '!' when expecting a Git command to fail.

Will fix in both places
