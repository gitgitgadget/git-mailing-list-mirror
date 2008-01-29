From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 12:03:06 -0800
Message-ID: <7v63xco0w5.fsf@gitster.siamese.dyndns.org>
References: <333479.13589.qm@web45901.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Pollard <ajaxsupremo@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwgs-0001YW-Cv
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 21:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYA2UDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 15:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbYA2UDP
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 15:03:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbYA2UDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 15:03:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C7F3168;
	Tue, 29 Jan 2008 15:03:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B31AF3166;
	Tue, 29 Jan 2008 15:03:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71991>

Max Pollard <ajaxsupremo@yahoo.com> writes:

> If I do the following:
>
>      $ git init
>      $ echo "The brown fox is getting old" > a.txt
>      $ git add a.txt
>      $ git commit -m "Commit a.txt"
>
>      $ cp a.txt b.txt
>      $ git add b.txt
>      $ git commit -m "Copy a.txt to b.txt"
>
>      $ git log b.txt
>
> I only see the log corresponding to the 2nd commit (v1.5.3.5).

That is what you are asking "git log" to show.  "git log b.txt"
means "please simplify the history by throwing away commits that
do not have changes to paths that match b.txt, and then show the
resulting log with the change pertaining to that path".  The
first commit does not change a path called b.txt (in other
words, "git show --stat HEAD^" will not give diffstat for "b.txt"),
so that commit is not shown.

$ git log --pretty=oneline --name-status -C -C
