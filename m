From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sun, 21 Dec 2008 02:59:30 -0800
Message-ID: <7v8wq9rdyl.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <7viqpetfs3.fsf@gitster.siamese.dyndns.org>
 <200812202111.17831.bss@iguanasuicide.net>
 <200812211109.36788.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 12:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEM3O-00007y-5z
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 12:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbYLUK7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 05:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYLUK7j
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 05:59:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbYLUK7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 05:59:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F2C01A568;
	Sun, 21 Dec 2008 05:59:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3707D1A533; Sun,
 21 Dec 2008 05:59:31 -0500 (EST)
In-Reply-To: <200812211109.36788.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sun, 21 Dec 2008 11:09:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 756C53AA-CF4E-11DD-A005-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103696>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> One could consider keeping the contributions from ^1 a special case and not
> mention the parent, making it look like any revert commit. I guess most merge
> reverts are like this in practice.

I think that makes sense.  There are cases where the mainline maintainer
punts a merge and pass the baton to a subsystem maintainer, saying "Your
tree has many conflicts with my tip, and I'd rather ask you to resolve it"
(and after such a merge, the mainline maintainer will fast forward to the
result), in which case the merge will be in the reverse direction, but
that should be rare.  Reverting such a merge later from the mainline's
point of view would involve "revert -m 2".

So if your patch is tightened a bit to record extra information only in
such a case, I think that would be an acceptable approach to the issue.
