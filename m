From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare repositories
Date: Wed, 23 Jul 2008 15:29:12 -0700
Message-ID: <7vk5fc9qvb.fsf@gitster.siamese.dyndns.org>
References: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org>
 <20080723215509.32438.49155.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmqi-00053e-4X
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYGWW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbYGWW3S
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:29:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbYGWW3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:29:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D340731CB9;
	Wed, 23 Jul 2008 18:29:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 28BB431CB4; Wed, 23 Jul 2008 18:29:13 -0400 (EDT)
In-Reply-To: <20080723215509.32438.49155.stgit@localhost> (Petr Baudis's
 message of "Wed, 23 Jul 2008 23:55:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9099D6A-5906-11DD-9CD1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89795>

Petr Baudis <pasky@suse.cz> writes:

> Commit 46eb449c restricted git-filter-branch to non-bare repositories
> unnecessarily; git-filter-branch can work on bare repositories just
> fine.
>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>
>   I have my own opinion about the readability-fork ratio in this particular
> case, but there's no use arguing about this. ;-)

Grouping commands is perfectly fine when you think the readers may find it
easlier to follow the logic if you grouped them.  Use { } for that kind of
grouping; I do not have any problem with that.

Use of subshell ( ) is often done by inexperienced people or by careless
people without thinking.  Sometimes you would explicitly want to have a
subshell (e.g. when you want to chdir to do something there but do not
want to affect the main program), and sometimes you don't (e.g. you are
grouping just for precedence, and want assignments and side effects done
inside the group visible by the main program).

Careless uses of ( ) wastes reviewer's time because the code inside has to
be studied to find out if the writer really wanted to have an isolated
separate process that subshell gives, or just being plain careless.
