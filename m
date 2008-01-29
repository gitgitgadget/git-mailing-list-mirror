From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 13:21:29 -0800
Message-ID: <7vr6g0mip2.fsf@gitster.siamese.dyndns.org>
References: <7v63xco0w5.fsf@gitster.siamese.dyndns.org>
	<790332.92389.qm@web45907.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Pollard <ajaxsupremo@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJxuR-0005Qu-FV
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 22:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbYA2VVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYA2VVt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 16:21:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYA2VVq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 16:21:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C973527B9;
	Tue, 29 Jan 2008 16:21:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4256E27B8;
	Tue, 29 Jan 2008 16:21:38 -0500 (EST)
In-Reply-To: <790332.92389.qm@web45907.mail.sp1.yahoo.com> (Max Pollard's
	message of "Tue, 29 Jan 2008 13:07:50 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71996>

Max Pollard <ajaxsupremo@yahoo.com> writes:

>> Max Pollard writes:
>> 
>> > I only see the log corresponding to the 2nd commit (v1.5.3.5).
>> 
>> That is what you are asking "git log" to show.  "git log b.txt"
>> means "please simplify the history by throwing away commits that
>> do not have changes to paths that match b.txt, and then show the
>> resulting log with the change pertaining to that path".  The
>> first commit does not change a path called b.txt (in other
>> words, "git show --stat HEAD^" will not give diffstat for "b.txt"),
>> so that commit is not shown.
>> 
>> $ git log --pretty=oneline --name-status -C -C
>> 
>
> ...  So -C -C is the answer, with --name-status or --stat to
> actually show the result.

The real "answer" part in that example is not -C -C.  Obviously,
you would need double-C aka --find-copies-harder, because you
did not change a.txt when creating b.txt, so it is still needed.

But the essential part of the answer is "not giving b.txt as the
pathspec, so that whatever _other_ file that could have been
copied into it is still visible when the command works".

If you say "git log --name-status -C -C -- b.txt", you would be
back to square one.
