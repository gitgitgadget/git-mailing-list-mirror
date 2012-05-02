From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: New NULL dereference in sequence.c
Date: Wed, 2 May 2012 15:38:19 -0400
Message-ID: <20120502193819.GB26732@hmsreliant.think-freely.org>
References: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
 <4FA12E42.201@lsrfire.ath.cx>
 <20120502173436.GA26732@hmsreliant.think-freely.org>
 <vpqd36mcwjc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Mueller <mmueller@vigilantsw.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 02 21:38:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfNs-0007sd-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab2EBTib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 15:38:31 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43063 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab2EBTi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 15:38:29 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SPfNU-0000lk-PC; Wed, 02 May 2012 15:38:22 -0400
Content-Disposition: inline
In-Reply-To: <vpqd36mcwjc.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -1.0 (-)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196854>

On Wed, May 02, 2012 at 07:39:19PM +0200, Matthieu Moy wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> >> >         if (!head_commit || parse_commit(head_commit))
> >> >             return error(_("could not parse commit %s\n"),
> >> >                      sha1_to_hex(head_commit->object.sha1));
> 
> [...]
> 
> > Have you actually seen this problem occur? It seems to me that the
> > only way head_commit could be NULL is in the event that HEAD wasn't a
> > commit object, whcih I don't think can be the case unless something
> > else is very wrong with your tree.
> 
> I don't know whether it can actually happen, but if it can't happen,
> then the if() condition should be rewritten. As it is, it explicitly
> allows head_commit to be NULL within the if body.
> 
You're right, it should be reduced to just if (parse_commit(head_commit)) {} and
we should call error with a different string dependent on weather head_commit is
null or not.

I'll make a patch shortly.
Neil

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> 
