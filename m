From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Tue, 24 Jun 2008 15:31:31 -0700
Message-ID: <7vwskea2ik.fsf@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte>
 <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jeske@google.com
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBH4T-0002ys-LW
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYFXWbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbYFXWbv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:31:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbYFXWbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:31:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 61C028C3C;
	Tue, 24 Jun 2008 18:31:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B95B78C39; Tue, 24 Jun 2008 18:31:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51CDFFB4-423D-11DD-81C2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86162>

Steven Walter <stevenrwalter@gmail.com> writes:

> @@ -225,6 +243,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (reset_type == HARD && is_bare_repository())
>  		die("hard reset makes no sense in a bare repository");
>  
> +        if (reset_type == HARD && !force && index_is_dirty()) {
> +                die("Uncommitted changes; re-run with -f to trash them");
> +        }
> +

Please don't.  With your change, does the testsuite even pass?

"reset --hard" has *ALWAYS* meant to be destructive --- discarding
potential local cruft is the whole point of the operation.

Learn the lingo, and get over it.
