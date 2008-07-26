From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] archive: allow --exec and --remote without equal sign
Date: Fri, 25 Jul 2008 17:31:57 -0700
Message-ID: <7vmyk5pjsy.fsf@gitster.siamese.dyndns.org>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMXib-0000ml-2L
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbYGZAcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYGZAcE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:32:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYGZAcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:32:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9075641C8F;
	Fri, 25 Jul 2008 20:32:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E9B0D41C8E; Fri, 25 Jul 2008 20:31:59 -0400 (EDT)
In-Reply-To: <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
 (Rene Scharfe's message of "Fri, 25 Jul 2008 12:41:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 442DFD48-5AAA-11DD-8227-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90137>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Convert git archive to parse_options().  The parameters --remote and --exec
> are still handled by their special parser.  Define them anyway in order for
> them to show up in the usage notice.
>
> Note: in a command like "git archive --prefix --remote=a/ HEAD", the string
> "--remote=a/" will be interpreted as a remote option, not a prefix, because
> that special parser sees it first.  If one needs such a strange prefix, it
> needs to be specified like this: "git archive --prefix=--remote=a/ HEAD"
> (with an equal sign).
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  archive.c |  110 +++++++++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 68 insertions(+), 42 deletions(-)

Hmph, somewhat dubious.

The real point of parse-options was to make the code smaller, easier to
maintain and command line handling more consistent.  At least this patch
seems to fail on the two out of three counts.

All of the other patches made obvious sense to me and are queued for -rc1
but I'd like to backburner this one.
