From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 14:11:06 -0700
Message-ID: <20050713211106.GA12047@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org> <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org> <20050713204458.GB11403@taniwha.stupidest.org> <Pine.LNX.4.58.0507131402210.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsoWk-00039k-4t
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVGMVLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVGMVLZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:11:25 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:24019 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261420AbVGMVLR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 17:11:17 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DLBBeE023794
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 17:11:15 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout2-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DLB7RF417890;
	Wed, 13 Jul 2005 17:11:07 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id E8DA6529BBC; Wed, 13 Jul 2005 14:11:06 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131402210.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 02:05:35PM -0700, Linus Torvalds wrote:

> >   and .git/refs/head/master is hardlinked between both trees.
>
> AND THAT IS WRONG.

OK, I was more-or-less assuming that 'cp -Rl tree1 tree2' was always a
valid thing to do.

Clearly if it's not then all of this is somewhat moot.

> You shouldn't hardlink whole trees. Git will not guarantee that it
> breaks the links.

I can live with that, until now though I wasn't aware that hardlinked
trees were a bad-thing.

> Your script was tens of lines of code, and it was BUGGY.

Yeah well, I'm a retard.

> Hardlink git _object_ directories. That's a totally different thing.

I was under the misconception that hardlink entire trees was
permissible.

I would however like to be able to hardlink more than just the
_object_ directory --- hardlinking the source is quite nice too.
Might that be considered safe?  (I'm of course assuming that editors
do write + rename when saving their buffers).
