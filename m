From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Fix up ugly open-coded "alloc_nr()" user in object.c
Date: Sun, 17 Jun 2007 00:15:06 +0200
Message-ID: <20070616221506.GA78651@dspnet.fr.eu.org>
References: <alpine.LFD.0.98.0706161024220.14121@woody.linux-foundation.org> <20070616182134.GA22003@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgY2-00025D-9T
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbXFPWPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbXFPWPI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:15:08 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1631 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664AbXFPWPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:15:07 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 1ED67A497E; Sun, 17 Jun 2007 00:15:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070616182134.GA22003@coredump.intra.peff.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50320>

On Sat, Jun 16, 2007 at 02:21:34PM -0400, Jeff King wrote:
> How about using the new ALLOC_GROW macro to make it even shorter? I also
> got rid of the aliased variables, which IMO just make it harder to see

> what's going on.
> +	ALLOC_GROW(array->objects, array->nr, array->alloc);
> +	array->objects[array->nr].item = obj;
> +	array->objects[array->nr].name = name;
> +	array->objects[array->nr].mode = mode;
> +	array->nr++;

Unless the ALLOC_GROW semantics are weird, shouldn't that be:
  ALLOC_GROW(array->objects, array->nr+1, array->alloc);

  OG.
