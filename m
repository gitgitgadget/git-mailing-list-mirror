From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 16 Sep 2008 00:21:48 +1200
Message-ID: <1221481308.29145.21.camel@maia.lan>
References: <20080909132212.GA25476@cuci.nl>
	 <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org>
	 <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org>
	 <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net>
	 <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
	 <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu>
	 <20080912155427.GB2915@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 15 14:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfD6g-0002MB-KP
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 14:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbYIOMV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 08:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYIOMV5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 08:21:57 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47584 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbYIOMV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 08:21:56 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E7A3321C837; Tue, 16 Sep 2008 00:21:54 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 5400121C716;
	Tue, 16 Sep 2008 00:21:47 +1200 (NZST)
In-Reply-To: <20080912155427.GB2915@cuci.nl>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95902>

On Fri, 2008-09-12 at 17:54 +0200, Stephen R. van den Berg wrote:
> Theodore Tso wrote:
> >Nope, as Sam suggested in his original message (but which got clipped
> >by Linus when he was replying) all you have to do is to have a
> >separate local database which ties commits and patch-id's together as
> >a cache/index.
> 
> True.  But repopulating this cache after cloning means that you have to
> calculate the patch-id of *every* commit in the repository.  It sounds
> like something to avoid, but maybe I'm overly concerned, I have only a
> vague idea on how computationally intensive this is.

You don't necessarily need to do that.  If the tool decides that the
sha1 it finds in the message is a patch-id reference, well it can just
start hunting around, caching the patch-ids it calculates as it finds
them, until it either finds one that matches, or determines you don't
have it.  You can probably find it first try just based on the author
name and date 90% of the time anyway.

Maybe the machinery could be adequately tilted such that if someone is
really desperate to make sure they are found quickly they can put the
information at refs/patches/PATCHID/COMMITID, but that sounds a bit
abusive.

Sam.
