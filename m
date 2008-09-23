From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff funcname_pattern: Allow HTML header tags without
 attributes
Date: Mon, 22 Sep 2008 18:46:11 -0700
Message-ID: <7v7i93ws64.fsf@gitster.siamese.dyndns.org>
References: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil> <CTXDOuN2-1v4gLJ9IqQwhgSzVh_BwEQIV70MoNH_beVI1QE7-TLy7g@cipher.nrlssc.navy.mil> <200809230249.23298.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 03:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khx01-0002Xu-7K
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 03:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbYIWBqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 21:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbYIWBqY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 21:46:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbYIWBqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 21:46:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E37BA644C7;
	Mon, 22 Sep 2008 21:46:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 250D1644C4; Mon, 22 Sep 2008 21:46:14 -0400 (EDT)
In-Reply-To: <200809230249.23298.johan@herland.net> (Johan Herland's message
 of "Tue, 23 Sep 2008 02:49:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B557BEA-8911-11DD-98BB-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96519>

Johan Herland <johan@herland.net> writes:

> After looking over this once more, I think the HTML regexp should be
> changed as follows. This fixes a buglet that was part of my original
> HTML pattern, and although this patch textually depends on Brandon's
> work, it is conceptually independent of his refactorization.
> ...
> -	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
> +	{ "html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$", REG_EXTENDED },

I do not think these two particularly would make much difference.  Why
isn't it simply...

	"<[Hh][1-6].*"

without even any capture or anchor?

It would falsely hit oddball cases like <h1foo> which is not <h1>, but
anybody who uses such a nonstandard thing deserves it, imnvho ;-).
