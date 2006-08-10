From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 23:47:18 +0200
Message-ID: <20060810214718.GD13446@c165.ib.student.liu.se>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx> <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx> <20060810182117.GA13446@c165.ib.student.liu.se> <44DB7E01.4000901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 23:47:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBINA-0000dq-Ia
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 23:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWHJVrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWHJVrU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 17:47:20 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:55728 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932112AbWHJVrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 17:47:20 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep02.bredband.com with ESMTP
          id <20060810214718.HOQG23359.mxfep02.bredband.com@c165>;
          Thu, 10 Aug 2006 23:47:18 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GBIN4-0004Zt-00; Thu, 10 Aug 2006 23:47:18 +0200
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <44DB7E01.4000901@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25214>

On Thu, Aug 10, 2006 at 08:42:09PM +0200, Rene Scharfe wrote:
> Fredrik Kuivinen schrieb:
> > On Thu, Aug 10, 2006 at 05:02:30PM +0200, Rene Scharfe wrote:
> >> +static inline int has_extension(const char *filename, int len,
> >> const char *ext) +{ +	int extlen = strlen(ext); +	return len >
> >> extlen && !memcmp(filename + len - extlen, ext, extlen); +} +
> > 
> > Wouldn't this function be much easier to use if len is computed from 
> > filename with strlen? (after a quick look through the other patches I
> >  couldn't find a call site where filename wasn't NUL-terminated)
> 
> Yes, it would be a bit easier, and my first version had only two
> arguments.  Then I found out that the length of the first string is
> already known at _all_ potential callsites, using this command to
> identify candidates:
> 
> 	$ grep 'cmp.*"\..*"' *.[ch]
> 
> We could add something like this:
> 
> 	#define has_ext(a, b) has_extension(a, strlen(a), b)
> 
> to make it easier to use for code that doesn't already determine the
> string length.  I think we should add it only after a user has been
> identified, though.
> 

IMHO the small speed-up isn't worth it. Drop the extra argument and
avoid a possible future bug.

- Fredrik
