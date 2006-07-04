From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Mon, 03 Jul 2006 22:47:09 -0700
Message-ID: <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Jul 04 07:47:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxdkh-0006PA-2w
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWGDFrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWGDFrM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:47:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47565 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751114AbWGDFrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 01:47:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704054710.ZCRT19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 01:47:10 -0400
To: gitzilla@gmail.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23253>

A Large Angry SCM <gitzilla@gmail.com> writes:

> This demonstrates a problem with git-merge-base.
>  
> +# Setup for second test set
> +#
> +#   PL  PR
> +#  /  \/  \
> +# L2  C2  R2
> +# |   |   |
> +# L1  C1  R1
> +# |   |   |
> +# L0  C0  R0
> +#   \ |  /
> +#     S

Cute.

This is a good demonstration that merge-base may not give you
minimal set for pathological cases.  If you want to be through
you could traverse everything to make sure we do not say 'S' is
relevant, but that is quite expensive, so I think there will
always be artifacts of horizon effect like this no matter how
you try to catch it (didn't I keep saying that already?).

However, I do not think it is really a "problem".  At least what
"merge-base --all" did not miss any, that should be OK.

I think the practical way to proceed is to say that the test
condition should really check that we do not _omit_ C2 in the
merge-base --all output.
