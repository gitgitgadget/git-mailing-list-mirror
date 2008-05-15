From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 10:23:57 -0700
Message-ID: <7vlk2bh45u.fsf@gitster.siamese.dyndns.org>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net>
 <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
 <20080515101523.GA31719@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu May 15 19:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwhCS-0006Yr-Pe
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 19:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbYEORYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYEORYO
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 13:24:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYEORYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 13:24:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C02F5A50;
	Thu, 15 May 2008 13:24:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6AB615A4F; Thu, 15 May 2008 13:24:07 -0400 (EDT)
In-Reply-To: <20080515101523.GA31719@lapse.madduck.net> (martin f. krafft's
 message of "Thu, 15 May 2008 11:15:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB6B2708-22A3-11DD-868F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82213>

"martin f. krafft" <madduck@madduck.net> writes:

> The only problem I see now is when an external command (or the shell
> script) can't properly deal with GIT_DIR being set, but then that's
> a whole different bug.

One thing that we did not have to worry about when git-sh-setup was
invented is GIT_WORK_TREE and its cousin core.worktree.  When the user
uses GIT_DIR _but_ wants to work from a subdirectory of the checked out
work tree, the user _must_ tell git where the top of the work tree is; in
other words, setting and exporting only GIT_DIR is a misconfiguration.

I have a suspicion that "the whole different bug" is what bit you --
perhaps some places need to also set and export GIT_WORK_TREE as well when
the do GIT_DIR.
