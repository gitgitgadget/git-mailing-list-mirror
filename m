Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B7C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811FD23129
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sigkill.com header.i=@sigkill.com header.b="Kax44FYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YORnjiCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgELUmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 16:42:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45127 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgELUmi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 16:42:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 379125C00D7;
        Tue, 12 May 2020 16:42:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 May 2020 16:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigkill.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=2
        Aotp3Vy6S9+Zql0671Pq4OdsTc0tmusXbSmY5vnf0w=; b=Kax44FYXw1kPzKA2P
        jmX5+WKLMlQZGmmL/fCGY9q/U1aU4QSXWVsSjI1saPgUaQT6tXr0QXn6GjFiNbdX
        6yBPZvagzaQhi8T1U6T5XbWL2zjGvuokV3egWS0luGzwHnoOOsTnUMfBbVjIHdqt
        gWulhKnJrfdYtswYeEGWmJJ5uiIs1UsFOVrPAYRQaw3nYDM9voh/rF/9uepX29kp
        ndbRHAVWsmBD6v6KThQ3ITpb7M657XC3CXJqbP8oDxQAJ+IXbTowq4iMZwEQGIIt
        dzyvvdHX3pk+qJNmBG0esexv7jgBNzhoeHsMYqSw4Kr6G9sBaFzIqSw/Zn/VCTi2
        80JRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=2Aotp3Vy6S9+Zql0671Pq4OdsTc0tmusXbSmY5vnf
        0w=; b=YORnjiCaIvmWAph25AY+PX98nsZmfqQmr5BEeDmIG/ZGaRwlYbdHIYG9s
        /Veu7e8jiBfdHo10VuKOgm5g0QGQCQ+W0hrDTzGSuCRMaBYQniLuatP6/19Z4mRg
        WFIskMfsDm6zFj8CS9EkcS0j8g3nJj3nLjDZ84YR0V2KzFWoq7xsQO8Lyb7oc+EL
        xFS4x9z0zQyOso5Q4pOsZX4hiKnJVz4FhgBw1eWllQuvL1qvzVDBbgkD++IT+V1B
        EC9jACHWqt94hc9KIFmC70zCZP2v/mYJbrxHy9UnZphnCOOYZz6PWj0dhKsTxq4L
        TDiPLY4qzCNw2fsyjgn+oyoE7CWjg==
X-ME-Sender: <xms:Owq7XiQhaURYzY0uVDmAyK8RprnPrUuWmHkAyUeQ_Wgne-xS_kqZfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrledvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpedflfdr
    ucfrrghulhcutfgvvggufdcuoehprhgvvggusehsihhgkhhilhhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevtdfgteduueelvefhffekheelhfdvgeeludfgtdevfedvvdetkeff
    udffvedtteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhjphgruhhlrhgvvggurd
    gtohhmnecukfhppeeiledrudekuddrfeegrddvfeegnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepphhrvggvugesshhighhkihhllhdrtghomh
X-ME-Proxy: <xmx:Owq7XnyQr6FBA4RM7q7RuVY8wGw-FcRnyxEI7Dzmgieqb3Dm8cgsHw>
    <xmx:Owq7Xv1EQEWpq_gXTkeN1OkrktuGtxqV8yVNh0M48XpMjOuBZZZj5w>
    <xmx:Owq7XuAZeH5eujHcfo34n0L3lp62kKWjGA86p58fXHFMv6FZX5ie7A>
    <xmx:PAq7Xut0tOJd0x6mBK0cIuWIft_8Y9HbA_9KbhEFJ0bmG4e1hf0eSg>
Received: from sigkill.com (c-69-181-34-234.hsd1.ca.comcast.net [69.181.34.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CE7630662DB;
        Tue, 12 May 2020 16:42:35 -0400 (EDT)
Date:   Tue, 12 May 2020 13:42:33 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: git-gui patch staging errors
Message-ID: <20200512204233.GA31807@sigkill.com>
References: <20200512010750.GA7127@sigkill.com>
 <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
 <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.13.5 (2020-03-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hey Richard,

Using your test case, I still get the error (which is, specifically an
error dialog saying:

   Failed to stage selected line.

   error: patch failed: glacierupload.sh:55
   error:glacierupload.sh: patch does not apply

Note that I'm highlighting the change in the source code, then
right-clicking it and selecting "Stage lines for commit." ("Stage hunk for
commit" also results in the error.)

If I stage the entire file by clicking on it in the upper-lefthand pane,
things work fine.

This is a Gentoo box, so I wonder I happened to build Tcl without the
appropriate unicode support (that one would find in most package-based
distros)?

In briefly digging a bit more, it would seem that git gui is foisting the
work onto "git apply" to create a patch and stage it? (If I'm reading the
source correctly, It looks like the error dialog title is from
https://github.com/prati0100/git-gui/blob/master/lib/diff.tcl#L700

and then the error strings that populate the dialog are bubbled up from git
apply.

Any ideas on what would make "git apply" potentially choke? I wonder if it
has to do with a mixed file encoding?

I tried setting both:

core.checkRoundTripEncoding true 
gui.encoding utf-8

on that repo; git gui still errored out in the same way. 

I also tried changing gui.encoding to utf-16; no dice...

To reiterate, git add -i worked fine...

best,
preed
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0xDF8708F8

On 12 May 2020 at 14:27:22, Kerry, Richard arranged the bits on my disk to say:

> 
> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of Pratyush Yadav
> Sent: 12 May 2020 13:15
> To: J. Paul Reed <preed@sigkill.com>
> Cc: git@vger.kernel.org
> Subject: Re: git-gui patch staging errors
> 
> Hi,
> 
> On 11/05/20 06:07PM, J. Paul Reed wrote:
> > 
> > Hey all,
> > 
> > I ran into an interesting problem this week where git gui was erroring 
> > out on staging partial patches in a particular file I was working on.
> > 
> > I worked around it with "git add -i," which worked like a champ.
> > 
> > I later realized the source file has some special characters (Unicode,
> > probably) in it to print emojis (or colors or whatever fun animations 
> > the kids want on their terminals these days).
> > 
> > Interestingly, lines/hunks before the first Unicode character will 
> > partial-stage appropriately, but attempting to stage any hunks/lines 
> > after the characters produces a "Failed to stage selected line. error: 
> > patch failed ... error: ... patch does not apply" error dialog.
> > 
> > This can be reproduced by cloning
> I can't reproduce it. I cloned the repo and then edited the file at line
> 60 with a diff that looks something like:
> 
>   diff --git a/glacierupload.sh b/glacierupload.sh
>   index 3b956c7..265349b 100755
>   --- a/glacierupload.sh
>   +++ b/glacierupload.sh
>   @@ -57,7 +57,9 @@ fi
>    
>    # count the number of files that begin with "$prefix"
>    fileCount=$(ls -1 | grep "^$prefix" | wc -l)
>   -echo "📦 Glacier Upload with $AWS_PROFILE"
>   +bar
>   +echo "📦 Glacier s Upload with $AWS_PROFILE"
>   +foo
>    echo "Total parts to upload: " $fileCount
>    
>    # get the list of part files to upload.  Edit this if you chose a different prefix in the split command
> 
> I tried a bunch of combinations if partially staging parts of this diff, but everything worked fine without any error message. The emoji didn't render properly (though that might be my font's problem), but there were no problems in partial staging or unstaging.
> 
> Does this example work fine on your system or does it error out? Could you give an example diff where git-gui has problems while staging? Maybe something in your config is different?
>  
> > Removing these control characters seems to calm git gui's indigestion 
> > on this file.
> > 
> > [preed@underworld ~]$ git --version
> > git version 2.26.2
> > [preed@underworld ~]$ git gui --version git-gui version 
> > 0.21.0.66.ga5728
> > 
> > best,
> > preed
> 
> -----------------------
> 
> I've recently found  something very similar to this using the Fork Gui.  I am tempted to report it to that project, but on seeing something similar here perhaps both Fork and Gut-Gui have a similar issue relating to Gui applications for Git?
> If the chunk I want to stage includes characters  in some category [1], then an attempt to Stage that chunk will fail with a similar fault to what is described here.  (I don't have one available to me at the moment to check whether it is exactly this failure)
> I have recently found myself cutting and pasting some chunks of text from a PDF into my C++ source, and in particular that includes "handed" quotes, rather than the usual use of the usual single quote character (ie the apostrophe).  If I then use Fork's ability to Stage chunks of text containing these (or possibly not containing, but close after) I get this failure reported.
> The work-around is to do it from the command line using "git add --patch", which works fine.
> 
> Regards,
> Richard.
> 
> [1] 
> I can't be entirely sure of the category as I haven't looked for the codes yet, but it is presumably some group of characters outside the basic ASCII page.
> 
> PS Sorry about posting style, I'm using Outlook and I've yet to find a way of getting it to help out by indenting everything using ">".
> 
> 
