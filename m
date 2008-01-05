From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Sat, 05 Jan 2008 01:06:23 -0800
Message-ID: <7v7iiod4kw.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	<7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 10:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4zs-0004nF-8V
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYAEJGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYAEJGi
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:06:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbYAEJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:06:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C326850;
	Sat,  5 Jan 2008 04:06:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D75684E;
	Sat,  5 Jan 2008 04:06:29 -0500 (EST)
In-Reply-To: <e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
	(Marco Costalba's message of "Sat, 5 Jan 2008 09:25:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69656>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I understand your point. The problem is that in git there isn't an
> unique way to test success/fail for any command, as example, regarding
> checking the exit status:
>
> $ git status; echo $?
> # On branch master
> nothing to commit (working directory clean)
> 1

That is a bad example, with a slight historical background.

When you say "git status $args", you are asking the command this
question.

	I am contemplating to issue "git commit $args", but will
	there actually be changes if I issued that command?

When there will be no changes staged with the given $args (in
your case that happens to be empty), there won't be anything to
be committed if you issued "git commit $args" at that point.
The command answers "Eh, by issuing 'git commit' you will get
an 'Nothing to commit', which is an error" --- and that is
reported with its exit status.
