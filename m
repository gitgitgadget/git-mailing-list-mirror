From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mark 'git stash [message...]' as deprecated
Date: Wed, 07 Nov 2007 00:02:11 -0800
Message-ID: <7vve8ecwl8.fsf@gitster.siamese.dyndns.org>
References: <20071106085134.GD4435@artemis.corp>
	<1194395205-27905-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tsuna@lrde.epita.fr, aghilesk@gmail.com, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipfrt-0005YG-VK
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbXKGICT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756465AbXKGICT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:02:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55367 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbXKGICS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:02:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 51DF22F0;
	Wed,  7 Nov 2007 03:02:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B8F9E9122E;
	Wed,  7 Nov 2007 03:02:34 -0500 (EST)
In-Reply-To: <1194395205-27905-1-git-send-email-bdowning@lavos.net> (Brian
	Downing's message of "Tue, 6 Nov 2007 18:26:44 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63781>

Brian Downing <bdowning@lavos.net> writes:

> Complain to STDERR unless 'git stash save' is explicitly used.
> This is in preparation for completely disabling the "default save"
> behavior of the command in the future.

Ok, but I would prefer to see this made into at least a
three-step process to ease the migration on users.  I do not
have any issue with a deprecation warning before the next big
release (1.5.4?).

The next step after this patch should not be the removal of
"defalut save".  Instead, introduce a boolean configuration,
stash.defaultsave, that defaults to false.  Without the
configuration, disable the "default save" (and do not even
mention the configuration variable, but do give the usage
message listing the commands).  But allow people to use the
"default save" behaviour with the configuration to help existing
users.  You can do this in the same release as above if you
want.

Then you would finally drop the "default save" in the next
big release after that "deprecation release".  But not before
that.

BTW, I've been quietly rewriting git-stash in C.  Be warned ;-)
