From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can Git push only first parent history commits?
Date: Sun, 07 Dec 2008 19:00:25 -0800
Message-ID: <7v7i6bbcc6.fsf@gitster.siamese.dyndns.org>
References: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Li Frank" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 04:01:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WNZ-0004Cv-IG
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 04:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbYLHDAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 22:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbYLHDAc
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 22:00:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbYLHDAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 22:00:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5048C185A6;
	Sun,  7 Dec 2008 22:00:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D394E185AD; Sun, 
 7 Dec 2008 22:00:27 -0500 (EST)
In-Reply-To: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net> (Li
 Frank's message of "Mon, 8 Dec 2008 10:52:38 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5FF7A35A-C4D4-11DD-901C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102522>

Your drawing nor explanation unfortunately does not make much sense to me,
so I'll respond only to the subject.

Pushing only first parent history would mean that the commits you will be
transferring will still record their true parents, but you are not sending
any parents but the first ones.  The repository that receives such a push
would not pass fsck, in other words, you are deliberately corrupting the
repository.

Naturally we won't support such an operation by default.

It is plausible that you can implement an option to do so, but it would
make it hard at the receiving end to tell between a true repository
corruption and a corruption you are deliberately introducing by such a
push, so it won't be useful unless accompanied by a corresponding option
to fsck to make it not complain when parent commits and associated objects
that are not necessary for first parent history.
