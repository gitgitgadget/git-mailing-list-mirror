From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 03 Feb 2008 23:24:29 -0800
Message-ID: <7vwsplkwuq.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	<402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvhi-0007HA-5g
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYBDHYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbYBDHYo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:24:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYBDHYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:24:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8C517AA;
	Mon,  4 Feb 2008 02:24:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 828F717A7;
	Mon,  4 Feb 2008 02:24:38 -0500 (EST)
In-Reply-To: <402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Sun, 3 Feb 2008 22:51:30
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72469>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> I intend to also submit a patch that does fast forward in combination
> with a real merge.

Please make the next round an in-line patch.  Attachments cannot
be commented on, and an RFC patch is all about getting comments,
not about being included.  Whitespace breakages do not matter as
much as the final submissions; readability and commentability
matters more.

Instead of adding many new sub-strategies at once, I think it
would make it easier to review to split the patch into (1) code
movement without adding any functionality changes to make your
further changes easier, if such a change is needed in your work
(I did not really look at the attachment carefully), (2) add
logic to find out the set of independent parents to remove
redundant parents (perhaps using show-branch --independent? I
dunno) and conditionally use it, (3) add infrastructure to allow
adding different --ff=<what-to-do>, and then finally (4) a
separate patch for each of <what-to-do>.

I suspect (2) is controversial if made unconditional.  Some
people do not even like the fast-forward "merges" we have
traditionally done.
