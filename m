From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Mon, 21 Jan 2013 09:07:19 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130121140719.GA1409@thyrsus.com>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130121093658.GD7498@serenity.lan>
 <20130121112853.GA31693@thyrsus.com>
 <20130121120010.GE7498@serenity.lan>
 <20130121124340.GA32219@thyrsus.com>
 <20130121132706.GF7498@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 21 15:08:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxI2u-00050s-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 15:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab3AUOHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 09:07:51 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:38370
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab3AUOHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 09:07:50 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id B966844130; Mon, 21 Jan 2013 09:07:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130121132706.GF7498@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214120>

John Keeping <john@keeping.me.uk>:
> > Ah.  OK, that is yet another bug inherited from 2.x - the code doesn't
> > match the documented (and correct) behavior.  Please send me a patch
> > against the cvsps repo, I'll merge it.
> 
> Should now be in your inbox.

Received, merged, tested, and cvsps-3.10 has shipped.
 
> I think the only way to do it without needing to save local state in the
> Git repository would be to teach cvsps to read a table of refs and times
> from its stdin so that we could do something like:
> 
>     git for-each-ref --format='%(refname)%09%(*authordate:raw)' refs/heads/ |
>     cvsps -i --branch-times-from-stdin |
>     git fast-import
> 
> Then cvsps could create a hash table from this and use that to decide
> whether a patch set is interesting or not.

Agreed.  I considered implementing something quite this before thinking of
the ^0 hack.  But an out-of-band timestamp file is much simpler.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
