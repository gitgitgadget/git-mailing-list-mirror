From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] off-by-one bugs found by valgrind
Date: Wed, 21 Dec 2005 12:59:14 -0800
Message-ID: <7vr7865fq5.fsf@assigned-by-dhcp.cox.net>
References: <1135197348.3046.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 21:59:33 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpB3R-0001LU-3i
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 21:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVLUU7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVLUU7S
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 15:59:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:231 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbVLUU7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 15:59:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221205727.JWEO17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 15:57:27 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1135197348.3046.7.camel@dv> (Pavel Roskin's message of "Wed, 21
	Dec 2005 15:35:48 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13898>

Pavel Roskin <proski@gnu.org> writes:

> Insufficient memory is allocated in index-pack.c to hold the *.idx name.
> One more byte should be allocated to hold the terminating 0.

Thanks.

> quote_c_style_counted() in quote.c uses a dangerous construct, when a
> variable is incremented once and used twice in the same expression.

Sorry, I do not follow you.  Isn't && a sequence point?

> -	for (sp = name; (ch = *sp++) && (sp - name) <= namelen; ) {
> -
> +	for (sp = name; sp < name + namelen; sp++) {
