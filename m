From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 07 Sep 2008 16:53:12 -0700
Message-ID: <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org>
References: <20080907103415.GA3139@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:54:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcU5P-0001y7-3I
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYIGXxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYIGXxY
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:53:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYIGXxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:53:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CCD15E5CC;
	Sun,  7 Sep 2008 19:53:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5ECB85E5CB; Sun,  7 Sep 2008 19:53:20 -0400 (EDT)
In-Reply-To: <20080907103415.GA3139@cuci.nl> (Stephen R. van den Berg's
 message of "Sun, 7 Sep 2008 12:34:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27CD77F4-7D38-11DD-86C1-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95197>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> - And depending on an affirmative on the previous question, would it be
>   acceptable to teach the gitk preceding/following tag listing to deal
>   with these backport/forwardports ?

Even though the answer to "the previous question" is a solid no, it is not
just acceptable but it would be very useful to teach gitk that the commit
you cherry-picked from is somehow related to the resulting commit from the
cherry-picking, and teach it to give you an easy access (and even a visual
cue about their relationship) to the other commit when it is showing the
cherry-picked commit.

I think the commit object name -x records in the commit message of the
cherry-picked one is noticed by gitweb to give you an easy access.  You
could teach gitk a similar trick, and that would not just help cherry
picking but also reverts, and a fix-up commit that says "This fixes the
regression introduced by commit 90ff09a5".

You could further draw _different_ kind of line on the upper "graph" pane,
to show that a commit is _related_ to another commit.  Because cherry-pick
relation is about the resulting commit and the _single_ commit that was
cherry-picked (in other words, the parent of the cherry-picked original
does not have _any_ relation to the commit that results from the
cherry-pick), such a line should be visually very distinct from the usual
parent-child relationship, which is the gitk graph (or any other commit
ancestry graph) is about.  But if it can be represented clearly, I'd
imagine that it would be interesting to see.
