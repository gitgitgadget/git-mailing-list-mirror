From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v4 3/5] config: make parsing stack struct independent
 from actual data source
Date: Mon, 13 May 2013 16:04:35 +0200
Message-ID: <20130513140435.GC3561@book-mint>
References: <20130511131721.GA17991@book-mint>
 <20130511132013.GD17991@book-mint>
 <7vfvxrscjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtN0-0004zJ-CM
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3EMOEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:04:49 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:46498 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3EMOEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:04:49 -0400
Received: from [77.23.112.173] (helo=book-mint)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UbtMn-0002rW-9n; Mon, 13 May 2013 16:04:42 +0200
Content-Disposition: inline
In-Reply-To: <7vfvxrscjc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224149>

On Sun, May 12, 2013 at 09:56:39PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >  /*
> > - * The fields f and name of top need to be initialized before calling
> > + * All source specific fields in the union, name and the callbacks
> > + * fgetc, ungetc, ftell of top need to be initialized before calling
> >   * this function.
> >   */
> > -static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> > +static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
> 
> This renaming may have made sense if we were to have many different
> do_config_from_$type functions for different types of source, but as
> this patch introduces a nice "config_source" abstraction, I do not
> think it is unnecessary. Shortening do_config_from() to do_config()
> may make more sense, if anything.
> 
> But that is a very minor point, as this is entirely internal with a
> single caller.

Did you really intent this double negation: "..., I do not think it
is unnecessary." ? The rest of the paragraph sounds like you would
think the rename is actually "not necessary". I thought I recalled that
Jeff asked me to change the name but I can not find the email, so maybe
its just my wrong memory. I am happy to drop the rename here, if thats
what you meant.

Cheers Heiko
