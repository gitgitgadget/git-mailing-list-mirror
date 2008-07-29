From: "Benjamin Collins" <aggieben@gmail.com>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 00:51:31 -0500
Message-ID: <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	 <20080728205545.GB10409@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
	 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNi8f-0003hI-CQ
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYG2Fvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYG2Fvf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:51:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:61867 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbYG2Fvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:51:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1621288nfc.21
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CjWn+gh237bYWWGIcnEBmZlKjtlmxJzPRnBWjsLObow=;
        b=HYvRqslCUQVthNfSq0/6Kg4EroYW0oAP5lApQHWZJskzFB4tlopifNPEYRxQYNQ9e+
         wAqQ9jM1tW4BOy+w6QXFQ8R0GJ1iY7T8VhZVg80pzvbifBK8Df1N+5eVcKGCMmZoRX4N
         MvORWruuvk4pewDl597liJzsMo5d3Ex5SMOZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IyVZDHAIu13ce0uIwYPE2qwIIYIW5dWr7IfKl36tmTjVxoSFT4pr0Z0tONtenRwm8H
         4gSD7a2ZlEyLI/0nN4i9SxaTJU3BipGJbSn0Ek+SjQ1uRW8C2xOhI4gwWzYGkPuHLrkN
         w2pw3Snv2UcyfK7uphNxVaeGYxGbpgvfwfkAc=
Received: by 10.210.109.10 with SMTP id h10mr7005111ebc.194.1217310691134;
        Mon, 28 Jul 2008 22:51:31 -0700 (PDT)
Received: by 10.210.114.7 with HTTP; Mon, 28 Jul 2008 22:51:31 -0700 (PDT)
In-Reply-To: <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90583>

On Mon, Jul 28, 2008 at 4:40 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> Most importantly in my case, my submodules (libraries shared between
> apps) have a very different branching structure than my supermodules.
> It wouldn't be particularly meaningful to force them to use the same
> branch names.
>
> Further, if you don't have a separate .git directory for each
> submodule, you can't *switch* branches on the submodule independently
> of the supermodule in any obvious way.  This is also useful; I might
> want to test updating to the latest master of my submodule, see if it
> still works with my supermodule, and if so, commit the new gitlink in
> the supermodule.  This is a very common workflow for me.

I second this sentiment.  I happen to very much *like* the fact that
the coupling between submodules and their super-projects is minimal.
The flexibility this allows is very useful.  Of course, it brings to
mind the comment Stroustrup once made about C++ blowing off your whole
leg.

> On the other hand, your thought about combining the "git log" messages
> is quite interesting.  That *is* something I'd benefit from, along
> with being able to git-bisect across submodules.  If I'm in the
> supermodule, I want to see *all* the commits that might have changed
> in my application, not just the ones in the supermodule itself.  I
> suspect this isn't simple at all to implement, however, as you'd have
> to look inside the file tree of a given commit in order to find
> whether any submodule links have changed in that commit.  It's
> unfortunate that submodules involve a commit->tree->commit link
> structure.

Let my contrariness begin...
I can see how someone might find such a feature in "git log" useful,
but I don't think I would.  I have 3 submodules in my project right
now, and I don't always want to see the changes.  Most of the time, I
don't care, actually.  When I do care, I can search the output of "git
log" for commits that touch the path where my submodule lives (through
Gitk, usually), and I can open another Gitk for details.

As for "git bisect": I haven't done this and I'm too busy to try to
contrive something for the purposes of this email, but wouldn't it
basically already do what you want?  Seems that you'd just run "git
submodule update" after each step of the bisect.

>
> > One irritating problem with submodules, is
> > that when someone else commited, and that you git submodule update,
> > you're on a detached head. Absolutely horrible.
>
> I think that roughly everyone agrees with the above statement by now.
> It would also be trivial to fix it, if only we knew what "fix" means.
> So far, I haven't seen any good suggestions for what branch name to
> use automatically in a submodule, and believe me, I've been looking
> for one :)

I disagree with this completely.  I think the detached head is
actually fantastic because it tells you all the right things:
a) the branch your submodule is on is ultimately irrelevant
b) it reminds you that this is not your project.  It's part of your
project managed in a special way by Git, but your project is in ..
c) if you want to do work in this part of your project that comes from
somewhere else, you need to be thoughtful about how you manage its
branches.

I try to keep all my submodules on (no branch) as much as possible.
In a way, I feel like that kind of relieves me of the chore of keeping
mapping superproject branches to submodule branches in my head.

I pretty much support submodules as they are, with the exception of
wanting "git submodule update" to be executed automatically at times.
