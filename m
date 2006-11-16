X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 09:57:00 -0800
Message-ID: <f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	 <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	 <87velgs9hx.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	 <87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
	 <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
	 <87fycjs5yg.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 17:57:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ry1KPm7R95jaasfymq6nqzlBtJjnEw79cboW+Ve01ogc8LyVyziM/YBj5T96Y2+tQgH21kCJPLso4/haGxJ2MN/d1Cir+O3VRYJF3Hmqy7G3lAdBq+J6lHsA6jJTPnPbDXBBejTgaIscics1DUkTdgqhCysAsirZmBGDN7481UM=
In-Reply-To: <87fycjs5yg.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31606>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GklU5-0006pD-UR for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162055AbWKPR5E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031152AbWKPR5D
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:57:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:47740 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1031188AbWKPR5B
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:57:01 -0500
Received: by wx-out-0506.google.com with SMTP id s7so668120wxc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 09:57:00 -0800 (PST)
Received: by 10.90.52.18 with SMTP id z18mr688523agz.1163699820680; Thu, 16
 Nov 2006 09:57:00 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Thu, 16 Nov 2006 09:57:00 -0800 (PST)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On 11/16/06, Carl Worth <cworth@cworth.org> wrote:
> First, the pull may just fast-forward in which case there's no message
> at all. And we've been through that topic enough recently that we all
> know that no important information is lost by not doing any separate
> recording in that case.
>
> So you can't turn around and argue that the remote URL information is
> suddenly important when it just so happens that it's not a fast
> forward.

When it's a fast forward, the puller hasn't had to make any judgment
calls, so there's no editorial history to record.  When it's not, but
the puller chooses to retain the result on a persistent branch, that
_is_ an editorial decision (even if the result of the auto-merge is
clean); I like having that in the history.

> > And in a truly distributed situation, "pull" is strictly more powerful
> > than a separate "fetch" + separate "merge".
>
> I don't buy it. In my usage, I have several different remote
> repositories I'm interested in tracking, each with any number of
> branches. What I really want is an easy command that fetches all of
> those branches, (even new ones that I've never heard about---but never
> any of their "tracking branches" that wouldn't be of interest to
> me). And I want to do that once, to get the online-access-required
> part over with and get all the data into my local repository where I
> can start working with it.

What do you want all of those branches for?  They haven't been
published to you (that's a human interaction that doesn't go through
git), so for all you know they're just upstream experiments, and doing
things with them is probably shooting yourself in the foot.

I do agree that a robust form of "for b in .git/remotes/*; do git
fetch `basename $b`; done" would be a nice bit of porcelain.  The
entries in .git/remotes would probably need to grow a "Fetch-options:"
field so that you could choose whether or not to follow tags, etc.
Patch to follow.

Cheers,
