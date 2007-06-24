From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: round down similarity index
Date: Mon, 25 Jun 2007 00:27:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706250026400.4059@racer.site>
References: <467EEEE6.3090100@lsrfire.ath.cx> <Pine.LNX.4.64.0706250021250.4059@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-192707198-1182727637=:4059"
Cc: Junio C Hamano <junkio@cox.net>, David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2bUJ-0003PB-QQ
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXFXX1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXFXX1W
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:27:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:58100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751282AbXFXX1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 19:27:21 -0400
Received: (qmail invoked by alias); 24 Jun 2007 23:27:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 25 Jun 2007 01:27:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wW6Unl0Gwsw5vZn3cpLlP33voxSTKEktDmJP7Ph
	lFNqFcDVtwrPgM
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706250021250.4059@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50844>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-192707198-1182727637=:4059
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 25 Jun 2007, Johannes Schindelin wrote:

> On Mon, 25 Jun 2007, René Scharfe wrote:
> 
> > Rounding down the printed (dis)similarity index allows us to use
> > "100%" as a special value that indicates complete rewrites and
> > fully equal file contents, respectively.
> >
> > [...]
> > 
> > +static int similarity_index(struct diff_filepair *p)
> > +{
> > +	int result = p->score * 100.0 / MAX_SCORE;
> > +
> > +	/* Paranoia: guard against floating point rounding errors. */
> > +	if (p->score == MAX_SCORE)
> > +		result = 100;
> > +	else if (result == 100)
> > +		result = 99;
> > +
> > +	return result;
> > +}
> 
> That's not even properly rounding down. The correct formula (correct in 
> the sense for "what you want") would be
> 
> 	p->score * 100.0 / MAX_SCORE
> 
> if p->score == MAX_SCORE, iff the files are identical. And yes, that is 
> the old formula.

Just ignore that, please.

> Besides, AFAIR p->score is not even calculated if the files are identical, 
> because that hits a different code path.

But this still holds true.

Ciao,
Dscho

--8323584-192707198-1182727637=:4059--
