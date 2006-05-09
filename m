From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 9 May 2006 12:18:03 -0700
Message-ID: <20060509191803.GA3676@localdomain>
References: <1147151209168-git-send-email-normalperson@yhbt.net> <11471512103526-git-send-email-normalperson@yhbt.net> <20060509120809.4d9494b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 21:18:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdXik-0003AT-PI
	for gcvg-git@gmane.org; Tue, 09 May 2006 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWEITSH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEITSH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 15:18:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:22756 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750804AbWEITSG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 15:18:06 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E9B6E2DC034;
	Tue,  9 May 2006 12:18:03 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  9 May 2006 12:18:03 -0700
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060509120809.4d9494b9.tihirvon@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19842>

Timo Hirvonen <tihirvon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> 
> >  * unbundling of short options: -uC20n20z => -u -C20 -n20 -z
> 
> Does anyone ever use this?  I think this makes sense only for flags that
> don't have parameters but that would create an ugly special case. Is it
> too hard to type "-u -C=20 -n=20 -z"?

It is more for me.  Many programs that I use already accept bundled
switches, and '=' and '-' are relatively far away and requires me
to stretch my hand uncomfortably (I have very small hands, and have
limited mobility in several fingers).

> >  * optional argument handling (-C<num>, -M<num>)
> >    -C <num> (with a space between them) has not changed,
> >    however, <num> can be a sha1, or a path
> 
> IMO optional arguments are usually bad idea.
> 
>     -C 2 (is "2" argument?)
>     -C2  (-C=2 or -C -2?)
> 
> Better to make it obvious there's an argument
> 
>     -C=2
> 
> or not support optional arguments at all and "-C 2" becomes unambiguous.

git has always supported optional argument handling like this.

I'm striving for backwards compatibility with existing usage.  That
means as a diff option, -C alone works, as does -C20.  I've made -C 20
_not_ work because it breaks existing usage (where 20 could be a
filename, or a tree-ish).  -C=20 would mean something
else, since I wanted to make pickaxe work exactly as it did before:
-S=var would search for '=var', not 'var'.

-- 
Eric Wong
