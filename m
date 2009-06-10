From: Junio C Hamano <gitster@pobox.com>
Subject: [RF sanity check] send-email threading fixes (was Re: [PATCH 3/6] send-email: fix threaded mails without chain-reply-to)
Date: Wed, 10 Jun 2009 00:15:54 -0700
Message-ID: <7v63f4v9sl.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI2W-0007W0-45
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbZFJHPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZFJHPy
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:15:54 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50888 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbZFJHPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:15:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071556.VVRC20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 03:15:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 27Fv1c0014aMwMQ047FvCJ; Wed, 10 Jun 2009 03:15:55 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=okmswUP8I-0A:10 a=zQesWvPjZfwA:10
 a=ybZZDoGAAAAA:8 a=IUIff1Sz7zhXu16Ynx8A:9 a=nqtX7zQO1WNMiXj3y4Q-iwefJe0A:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121253>

Junio C Hamano <gitster@pobox.com> writes:

> You were too polite to say "by a hidden code style change", instead of
> saying something stronger,...

Erm, I meant "you were very polite and said"...

In any case, here is what I came up with by reshuffling your six patches.

[PATCH 1/6] add a test for git-send-email for non-threaded mails
[PATCH 2/6] send-email: fix non-threaded mails
[PATCH 3/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
[PATCH 4/6] send-email: fix threaded mails without chain-reply-to
[PATCH 5/6] add a test for git-send-email for threaded mails without chain-reply-to
[PATCH 6/6] send-email: fix a typo in a comment

The first three patches apply to the tip of 'maint', which is currently at
802f9c9 (diff.c: plug a memory leak in an error path, 2009-06-08).  The
first one exposes breakage introduced by 3e0c4ff and then the second one
fixes it.

Patch 4/6 applies on top of 15da108 to fix a breakage introduced by that
commit.  Together with the result of applying the first three patches to
maint, they fix --no-thread and --thread (without --chain-reply-to) cases.
The result can be verified by applying Patch 5/6 on top of them.

They will appear in tonight's 'pu'; the overall tip for the topic would be
at 479ad6b (unless I find breakages during the final testing).

Thanks.
