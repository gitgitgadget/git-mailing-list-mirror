Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48792C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24025613CD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhHWUyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:54:53 -0400
Received: from tilde.club (unknown [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF490C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 13:54:10 -0700 (PDT)
Received: from tilde.club (unknown [185.220.101.138])
        by tilde.club (Postfix) with ESMTPSA id 5C5B3220477A7;
        Mon, 23 Aug 2021 20:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 5C5B3220477A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1629752047; bh=8VY2k1RSElsMqjyB+V6jNZJmm8WkZAw5roVxs3SifMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0k+AaAscQ0J6xnQFmZHcj9Z70OacbxiZbUWfLP6diyYPStQ2rVnYCvjIZSxB2++W
         VKr3+mpUW3htKELhIs6IZkMDAqRFxjoaHiE+/xhmc+so6Ie/lK13UE85J/9+zVi/f0
         CQW7qqG+BqXTmMTn7yV+Sx/N8J2zCc3nv3m+DEUw=
Date:   Mon, 23 Aug 2021 20:53:36 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [filter-repo PATCH] filter-repo: add new --replace-message option
Message-ID: <YSQK0JeaXtKWPgU2@tilde.club>
References: <20210818043749.85274-1-gwymor@tilde.club>
 <CABPp-BF3EopyXGtKomnVjuavg2dX+79qLwkPjjyX+PO5JBSXtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BF3EopyXGtKomnVjuavg2dX+79qLwkPjjyX+PO5JBSXtg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-23 10:34:07-0700, Elijah Newren wrote:
> Hi,
> 
> On Tue, Aug 17, 2021 at 9:38 PM Gwyneth Morgan <gwymor@tilde.club> wrote:
> >
> > Like --replace-text, add an option --replace-message which replaces text
> > in commit message bodies, so that users can easily replace text without
> > constructing a --message-callback.
> 
> Interesting idea.
> 
> Missing a Signed-off-by trailer.

Will fix.

> > @@ -894,7 +898,20 @@ YYYY-MM-DD.  In the expressions file, there are a few things to note:
> >      beginning and ends of lines rather than the beginning and end of file.
> >      See https://docs.python.org/3/library/re.html for details.
> >
> > -See also the `--blob-callback` from <<CALLBACKS>>.
> > +See also the `--blob-callback` from <<CALLBACKS>>.  Similarly, if you
> > +want to modify commit messages, you can do so with the same syntax.  For
> > +example, with a file named expressions.txt containing
> > +
> > +--------------------------------------------------
> > +foo==>bar
> > +--------------------------------------------------
> > +
> > +then running
> > +--------------------------------------------------
> > +git filter-repo --replace-message expressions.txt
> > +--------------------------------------------------
> > +
> > +will replace `foo` in commit messages with `bar`.
> 
> You've added this text to the "Content based filtering" section of the
> manual, which doesn't make sense.  It should go in a section about
> updating commit/tag messages.

Ah, got it. I'll move that into a new section.

> >      if self._message_callback:
> >        commit.message = self._message_callback(commit.message)
> > -
> 
> Why this stray line removal?

That was accidental. Will fix.

> >      # Change the author & committer according to mailmap rules
> >      args = self._args
> >      if args.mailmap:
> 
> As noted above, just as --message-callback affects both commit and tag
> messages, shouldn't this option affect both (i.e. should there also be
> a section in tweak_tag() similar to the one you added to
> tweak_commit())?

Yes, it should. I'll change that.
