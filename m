From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 20 Jun 2012 12:51:05 -0700
Message-ID: <7v62alvk2e.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
 <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQvp-0000As-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930Ab2FTTvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:51:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757901Ab2FTTvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:51:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7343A9E34;
	Wed, 20 Jun 2012 15:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrXX9Ab76xbL0R2xcN/bxZHWAhc=; b=bNpe27
	HCOihgXpPH5M3/Fl+mEZtOvzYxbqVQNYf+49ziICurj1yZ2kmf4liqEhsGnyJuY9
	07jmOOvtjTB2b/4Z9CUAAlwxx+5rS2W79gES1ikuSQySK9QgWY3bT4735CiAGt7X
	Zfw84ur8EBf4mJaPc/SyXFEXqh7XtyKqvVbwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ipH/X131UJ4HZ1Xh5RI/Vnr8e8YYHOTI
	XL1c0wdWLbKIdMoIOLufU29g3L9VOb6hP0XQqFLUYchSu5Eesfdx6wJT4XkS1sE4
	iMrhdyiC4cjZ1YH3v+JhNP8ycLw9wk6Uo9VXVx51eutQprZ8xE5q7uHO/ynoYyGF
	59OkEVLBXxE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F969E33;
	Wed, 20 Jun 2012 15:51:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD11B9E32; Wed, 20 Jun 2012
 15:51:06 -0400 (EDT)
In-Reply-To: <7va9zxvkyp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Jun 2012 12:31:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4667A174-BB11-11E1-BD38-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200348>

Junio C Hamano <gitster@pobox.com> writes:

> Telling somebody who would blindly follow what was suggested to use
> 'current' is what bothers me.

That is (quoting the difference between the previous round and this
one),

 static char warn_unspecified_push_default_msg[] =
 N_("push.default is unset; its implicit value is changing in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
    "and maintain the current behavior after the default changes, use:\n"
    "\n"
    "  git config --global push.default matching\n"
    "\n"
    "To squelch this message and adopt the new behavior now, use:\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
-   "See 'git help config' and search for 'push.default' for further information.");
+   "See 'git help config' and search for 'push.default' for further information.\n"
+   "(the 'simple' mode was introduced in Git 1.7.11. Use 'current' instead if\n"
+   "you sometimes use older versions of Git)");

The latter half of the message is "To *adopt* the *new behaviour
now*" but setting it to 'current' is not adopting the new behaviour.

Perhaps we should say more to help people decide which one to choose
in this message.

    ... changing in Git 2.0 from 'matching' to 'simple'.
    'matching', which is the current default, pushes all branches
    that exist at the remote.  'simple', which will be the new
    default, pushes only the current branch to update the branch at
    the remote of the same name (the 'simple' mode is only available
    in Git 1.7.11 or newer; older versions of Git has a similar mode
    called 'current').

    You can squelch this message by picking your preferred default now,
    e.g. running one of these:

            git config push.default matching
            git config push.default simple
            git config push.default current

or something?
