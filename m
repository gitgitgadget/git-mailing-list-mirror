From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Thu, 9 Feb 2012 20:24:42 +0100
Message-ID: <201202092024.43381.jnareb@gmail.com>
References: <20120206062713.GA9699@sigill.intra.peff.net> <m31uq63143.fsf@localhost.localdomain> <20120209033059.GA4347@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 20:24:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZbq-00048o-KP
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365Ab2BITYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:24:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49000 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab2BITYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:24:41 -0500
Received: by eaah12 with SMTP id h12so676101eaa.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=p7fNqrwoSxn0UuLuzAcexJj0Z69TP7GtW0RwQXOy2F4=;
        b=AHoeSIz6lESsiDjoFSMQcvKzqg271p+t4lPF90ohrEIVO3KS5DsbtIWK4UKiwXEBPI
         uvhtdRkRmKNrL0Z8u9A4reKEOdmsSryD7EZZq5Iikgv/SYxzjjcfo6K36xk3EiFXU4mf
         MQrD2B+Pzmf2bhQcEnnEUc+odd61hEJbYDHis=
Received: by 10.14.33.218 with SMTP id q66mr1001315eea.67.1328815480581;
        Thu, 09 Feb 2012 11:24:40 -0800 (PST)
Received: from [192.168.1.13] (abvq91.neoplus.adsl.tpnet.pl. [83.8.214.91])
        by mx.google.com with ESMTPS id o49sm12793232eeb.7.2012.02.09.11.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 11:24:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120209033059.GA4347@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190308>

On Thu, 9 Feb 2012, Jeff King wrote:
> On Tue, Feb 07, 2012 at 11:16:47AM -0800, Jakub Narebski wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > [...]
> > > Git-config could potentially help with that (and even simplify the
> > > current code) by allowing something like:
> > > 
> > >   $ git config --list-with-sources
> > >   /home/peff/.gitconfig user.name=Jeff King
> > >   /home/peff/.gitconfig user.email=peff@peff.net
> > >   .git/config core.repositoryformatversion=0
> > >   .git/config core.bare=false
> > >   [etc]
> > > 
> > > (you would use the "-z" form, of course, and the filenames would be
> > > NUL-separated, but I made up a human-readable output format above for
> > > illustration purposes).
> > 
> > That would be _very_ nice to have (even without includes support).
> > 
> > Filenames would be git-quoted like in ls-tree / diff-tree output without -z,
> > isn't it?  And is that TAB or SPC as a separator?
> 
> So the patch would look something like this. However, is the actual
> filename really what callers want? It seems like in David's case, an
> annotation of "repo", "global", or "system" (possibly in addition to the
> filename) would be the most useful (because in the git-cola UI, it is
> still nice to list things as "repo" or "global" instead of spewing the
> whole filename at the user -- but you would still want the individual
> filename for handling updates of includes).

I'm not sure if "system" / "global" / "local" or "repo" would be a good
idea.

First, in the case of includes you would have to provide pathnames of
included files.  This would introduce inconsistency.  Is "system"
the '/etc/gitconfig' file, or 'system' file in '.git' directory?

Second, people can have different build configuration, e.g. the prefix
might differ, so that "system" is not always '/etc/gitconfig'.  If you
want to edit config you would want to know which file to edit... and though
there is "git config --system --edit" it depends on having editor
configured correctly.


Just my two cents.
-- 
Jakub Narebski
Poland
