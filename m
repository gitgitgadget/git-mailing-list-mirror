From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Handle the errors from chdir in set_work_tree
Date: Fri, 3 Aug 2007 00:15:18 +0200
Message-ID: <20070802221518.GC2829@steel.home>
References: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com> <7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGix2-0004Se-Mk
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbXHBWPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXHBWPW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:15:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:34127 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbXHBWPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:15:21 -0400
Received: from tigra.home (Fac1b.f.strato-dslnet.de [195.4.172.27])
	by post.webmailer.de (fruni mo46) (RZmta 10.3)
	with ESMTP id D01bcaj72K6Cqp ; Fri, 3 Aug 2007 00:15:19 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E8DC7277BD;
	Fri,  3 Aug 2007 00:15:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CD0A0C21D; Fri,  3 Aug 2007 00:15:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9thg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54628>

Junio C Hamano, Thu, Aug 02, 2007 23:58:41 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> > +		if (chdir(dir))
> > +			rel = NULL;
...
> 
> Shouldn't it die() instead, though?

Dunno. Don't like dying.

> Consolidating two of your patches, would this be Ok?

Yes, but you may consider replacing strncpy with strlcpy:

> +		memcpy(dir_buffer, dir, len - suffix_len);
> +		dir_buffer[len - suffix_len] = '\0';

strlcpy(dir_buffer, dir, len - suffix_len + 1);
