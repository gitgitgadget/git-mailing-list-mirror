From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 12:58:35 +0400
Message-ID: <20070329085834.GJ59098@codelabs.ru>
References: <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru> <7vwt107a3g.fsf@assigned-by-dhcp.cox.net> <20070329082908.GH59098@codelabs.ru> <7v7it04fbo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 10:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWqTJ-0006JZ-5j
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXC2I6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbXC2I6p
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:58:45 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:53515 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbXC2I6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:58:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=nMvcRtPE6thRfu4oHn7Mc0T6J7MDynZFLmtLGBF00kTAQCYfhjRJVr93MAyDL3CYxT7B/CxLTcxDz5mw3BVazkTiVcprJK0YTCP8XeNHKmBfiOROyXaQNxhulrgE4XSWbrpeFwPQ1PXgcFv2RygPSHoh2+hqd+Sp2CJTwjgQSu4=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWqSv-000Dpq-O6; Thu, 29 Mar 2007 12:58:42 +0400
Content-Disposition: inline
In-Reply-To: <7v7it04fbo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-3.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43420>

Thu, Mar 29, 2007 at 01:35:55AM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > Or you meant something different? I am little confused with
> > the '$PATH' in your example. Was it intended?
> 
> Yes, the dollar-sign-in-pathname is pretty much a part of my
> pathological example. 

Got it. So you mean that the '$' sign should be escaped as well? ;))
Or we can get another _SQ substitution to the script and the
string will look like
exec 'whatever you'\''d written here' "$0" -- "$@"

> >> But come to think of it, it lets shell handle $PATH to find wish
> >> anyway, so *unless* we have specific version dependency to wish
> >> that wish binary normally found on user's $PATH is inadequate,
> >> we probably should not even need to be doing any of this path
> >> munging.  You might end up discovering the path to wish binary
> >> in your autoconf script, we do not have to use it.  ./configure
> >> can just see if there is wish, and set NO_TCLTK appropriately
> >> without any of the path business.
> >> 
> >> What do you think?
> >
> > There are problems at least with FreeBSD: it just installs the
> > wish8.4, wish8.3, wish8.2, etc. It does not provide the bare 'wish'
> > as the link to one of those.
> 
> Then sed -e 's/wish/$(WISH_NAME)/', still letting the shell to
> handle the path part, could be a simpler option.  I dunno.

Ah, you mean that './configure --with-tcltk=wish8.4' should also
do the trick? It seems to be easy to achieve by just skipping
the 'test -x' part in the configure.ac. So the semantics of
'--with-tcltk=PATH' will be:
"If you're telling me about the path to the interpreter, it is
you who should take care of it. I do not mind if you will give
me something unexecutable, unexistent and so on.". Comments?
-- 
Eygene
