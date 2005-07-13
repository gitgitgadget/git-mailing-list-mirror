From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 14:54:35 -0700
Message-ID: <20050713215435.GB12882@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org> <Pine.LNX.4.58.0507131410430.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 11:04:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DszdZ-0000sU-0H
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 11:04:09 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j6DM9sSL014986
	for <gcvg-git@gmane.org>; Thu, 14 Jul 2005 00:09:54 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVGMVyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVGMVyv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:54:51 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:59836 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261535AbVGMVyi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 17:54:38 -0400
Received: from pimout4-ext.prodigy.net (pimout4-int.prodigy.net [207.115.4.203])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DLsBgd006621
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 17:54:12 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout4-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DLsZXE295600;
	Wed, 13 Jul 2005 17:54:36 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 1FEEE529BBC; Wed, 13 Jul 2005 14:54:35 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131410430.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 02:23:18PM -0700, Linus Torvalds wrote:

> If you really want to do something like this, then you should do it like
> this:
>
> 	update_head() {

except there are a number of places I need to frob things in Cogito
and they are not all for the head.  If the head is special and the
only candidate sure, that works for me.

>  - following multiple links is _wrong_, since the next-level link could
>    actually be a symlink to another tree entirely (if somebody is crazy
>    enough to use "cp -Rl" to copy trees, then why not "cp -Rs"?)

I already stated that wasn't supposed to work.  If you have symlinks
outside of your tree with cogito I think there is a *lot* more code
that probably needs to be checked.

Remember I used cogito here, not git directly.  That probably means
things are invoked very differently for me?

>  - you got relative links wrong.

Possibly, I was more for RFC/concept reasons I posted the patch.  I'm
clueless when it comes to writing decent or reliable bash sh/bash
scripts.
