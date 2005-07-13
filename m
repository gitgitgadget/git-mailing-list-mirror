From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 14:50:39 -0700
Message-ID: <20050713215039.GA12882@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org> <Pine.LNX.4.58.0507131256490.17536@g5.osdl.org> <20050713204458.GB11403@taniwha.stupidest.org> <Pine.LNX.4.58.0507131402210.17536@g5.osdl.org> <20050713211106.GA12047@taniwha.stupidest.org> <Pine.LNX.4.58.0507131425080.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DspBt-00019V-Fm
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVGMVxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGMVw3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:52:29 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:29105 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261535AbVGMVun
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 17:50:43 -0400
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DLoFgd024149
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 17:50:18 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout3-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DLoddw297570;
	Wed, 13 Jul 2005 17:50:40 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id A4908529BBC; Wed, 13 Jul 2005 14:50:39 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131425080.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 02:33:43PM -0700, Linus Torvalds wrote:

> Hmm.. I don't think it's necessarily wrong, although as you say,
> your editor had better DTRT.

It does.  I assume probably everything does but I never really
checked.

> That said, even if your editor doesn't, at least you won't corrupt
> your git archive, although you might have surprising changes creep
> into the other side..

Well, with hard-linked trees and the nastyness I posted I would test
with

	cp -Rl tree1 tree2
	cd tree2
	<hack hack hack>
	find ../tree1 -mmin -<n> ... # make sure we didn't mess up original tree

So far this seems to work for me.

> Search-search-search.. Indeed: at least "git-apply" seems to modify
> the file in place.

I probably just luckily never hit this.
