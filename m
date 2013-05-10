From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 4/5] teach config --blob option to parse config
 from database
Date: Fri, 10 May 2013 17:47:35 +0200
Message-ID: <20130510154735.GA3850@book-mint>
References: <20130509154020.GA26423@book-mint>
 <20130509162018.GF3526@book-mint>
 <20130509223038.GB30774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 10 17:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UapY0-00031V-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab3EJPrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:47:48 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:39227 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab3EJPrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:47:47 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UapXo-0003CF-AE; Fri, 10 May 2013 17:47:40 +0200
Content-Disposition: inline
In-Reply-To: <20130509223038.GB30774@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223875>

On Fri, May 10, 2013 at 12:30:39AM +0200, Jeff King wrote:
> On Thu, May 09, 2013 at 06:20:18PM +0200, Heiko Voigt wrote:
> 
> > +static int config_buf_fgetc(struct config_source *conf)
> > +{
> > +	if (conf->buf.pos < conf->buf.len && conf->buf.buf[conf->buf.pos])
> > +		return conf->buf.buf[conf->buf.pos++];
> > +
> > +	return EOF;
> > +}
> 
> It probably would not matter for config reading, but is there any reason
> not to make your fgetc replacement 8-bit clean (i.e., to check only len,
> and not worry about NUL characters)?

I got a NULL character here and by mistake thought that somehow the len
would include the ending character. But that was a bug introduced by me
when I refactored to buffer and length instead of strbuf. I missed to
transport the len properly. So I will removed this check again.

Cheers Heiko
