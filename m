From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reformat "your branch has diverged..." lines to reduce
 line length.
Date: Wed, 16 Jul 2008 12:48:36 -0700
Message-ID: <7v4p6pr4ob.fsf@gitster.siamese.dyndns.org>
References: <1216235967-9510-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJD0R-0001Cl-U8
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbYGPTsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbYGPTsp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:48:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbYGPTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:48:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C627624834;
	Wed, 16 Jul 2008 15:48:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 213FA24832; Wed, 16 Jul 2008 15:48:38 -0400 (EDT)
In-Reply-To: <1216235967-9510-1-git-send-email-apenwarr@gmail.com> (Avery
 Pennarun's message of "Wed, 16 Jul 2008 15:19:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31351212-5370-11DD-8B53-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88737>

Avery Pennarun <apenwarr@gmail.com> writes:

>  	if (!num_theirs)
> -		strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s' "
> +		strbuf_addf(sb, "Your branch is ahead of the tracked%s branch '%s'\n"
>  			    "by %d commit%s.\n",

I wonder if a simple "s/of the tracked%s branch //" is better for this
kind of thing.  If the message says 'origin/master', you know it is a
tracked remote branch anyway, don't you?

Too wide is bad, but too tall is worse.  Some of us still work in 80x24
;-) and I prefer to make the message succinct when possible, rather than
keeping it long and spread over multiple lines.

>  	else
> -		strbuf_addf(sb, "Your branch and the tracked%s branch '%s' "
> -			    "have diverged,\nand respectively "
> +		strbuf_addf(sb, "Your branch and the tracked%s branch '%s'\n"
> +			    "have diverged, and respectively "
>  			    "have %d and %d different commit(s) each.\n",

This does not make the message taller, but if we were to make the "only
one side advanced" cases shorter, we would need to reword this to be
consistent.  Perhaps something like this would be just as easy to read and
more compact?

	Your branch is ahead of 'origin/add-chickens2' by 21 commits.

        Your branch is behind 'origin/add-chickens2' by 1 commit.

        Your branch and 'origin/add-chickens2' have diverged, and have
        21 and 1 different commit(s) each, respectively.

I moved "respectively" so that the variable parts will come close to the
beginning of physical line.
