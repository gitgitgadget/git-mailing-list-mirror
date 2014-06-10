From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Tue, 10 Jun 2014 12:17:44 +0200
Message-ID: <20140610101744.GA23370@t2784.greatnet.de>
References: <20140605060425.GA23874@sandbox-ub>
 <20140605060640.GB23874@sandbox-ub>
 <5391FFC3.5010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:18:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuJ7u-00018p-UR
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 12:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbaFJKRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 06:17:54 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:39256 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaFJKRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 06:17:53 -0400
Received: from [83.133.105.219] (helo=t2784.greatnet.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WuJ7k-0006Os-Re; Tue, 10 Jun 2014 12:17:48 +0200
Content-Disposition: inline
In-Reply-To: <5391FFC3.5010001@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251175>

On Fri, Jun 06, 2014 at 07:52:03PM +0200, Karsten Blees wrote:
> Am 05.06.2014 08:06, schrieb Heiko Voigt:
> > This allows a reader to immediately know which options can be used and
> > what this parameter is about.
> > 
> [...]
> > -void hashmap_free(struct hashmap *map, int free_entries)
> > +void hashmap_free(struct hashmap *map, enum hashmap_free_options free_entries)
> [...]
> >  
> > +enum hashmap_free_options {
> > +	HASHMAP_NO_FREE_ENTRIES = 0,
> > +	HASHMAP_FREE_ENTRIES = 1,
> > +};
> 
> This was meant as a boolean parameter. Would it make sense to have
> 
> enum boolean {
> 	false,
> 	true
> };
> 
> or similar in some central place?

The intention of Jonathans critique here[1] was that you do not see what
this parameter does on the callsite. I.e.:

	hashmap_free(&map, 1);

compared to

	hashmap_free(&map, HASHMAP_FREE_ENTRIES);

A boolean basically transfers the same information and would not help
the reader here.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/243917
