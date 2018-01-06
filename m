Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45491F406
	for <e@80x24.org>; Sat,  6 Jan 2018 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeAFVix (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 16:38:53 -0500
Received: from imap.thunk.org ([74.207.234.97]:59298 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753183AbeAFViu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 16:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AyIKwEdE18pC5+o6yOxK4ILXI5+3TfaGE5DROEw1M10=; b=B9MofwXJ/Zu7dI40p4A9l/J5e0
        6wd+Cb16vFroLc+vYV5kZPGDEScmnaSe3BbNlLZ29ntKm55W/fkZa91IhtFQvKvEcWGG92d/YZdnR
        w6Lqv62cz2MKmTS/2pUvtwgpc3N4l4NTEne6Nix+8gTMbgXGEVXvhCJQH9o44z7SbpNA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1eXwAw-0002Df-HQ; Sat, 06 Jan 2018 21:38:46 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 83EAEC00508; Sat,  6 Jan 2018 16:38:45 -0500 (EST)
Date:   Sat, 6 Jan 2018 16:38:45 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180106213845.GD2404@thunk.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <3447055.jsE6nH3DQt@mfick-lnx>
 <xmqq4lo0cbbv.fsf@gitster.mtv.corp.google.com>
 <20180106172919.GA17272@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180106172919.GA17272@Carl-MBP.ecbaldwin.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 06, 2018 at 10:29:21AM -0700, Carl Baldwin wrote:
> > When n==m==1, "amended" pointer from X1 to A1 may allow you to
> > answer "Is this the first attempt?  If this is refined, what did the
> > earlier one look like?" when given X1, but you would also want to
> > answer a related question "This was a good start, but did the effort
> > result in a refined patch, and if so what is it?" when given A1, and
> > "amended" pointer won't help at all.  Needless to say, the "pointer"
> > approach breaks down when !(n==m==1).
> 
> It doesn't break down. It merely presents more sophisticated situations
> that may be more work for the tool to help out with. This is where I
> think a prototype will help see these situations and develop the tool to
> manage them.

That's another way of saying "break down".

And if the goal is a prototype, may I gently suggest that the way
forward is trailers in the commit body, ala:

	Change-Id: I0b793feac9664bcc8935d8ec04ca16d5

or

	Upstream-4.15-SHA1: 73875fc2b3934e45b4b9a94eb57ca8cd

Making changes in the commit header is complex, and has all *sorts* of
forward and backwards compatibility challenges, especially when it's
not clear what the proper data model should be.

Cheers,

						 -Ted
