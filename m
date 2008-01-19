From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Fri, 18 Jan 2008 23:06:42 -0800
Message-ID: <7vr6ge9tvh.fsf@gitster.siamese.dyndns.org>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 08:07:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG7nZ-0002VP-HT
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 08:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYASHGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 02:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYASHGz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 02:06:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYASHGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 02:06:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28355315E;
	Sat, 19 Jan 2008 02:06:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F9F9315D;
	Sat, 19 Jan 2008 02:06:49 -0500 (EST)
In-Reply-To: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
	(Ping Yin's message of "Sat, 19 Jan 2008 13:22:31 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71082>

"Ping Yin" <pkufranky@gmail.com> writes:

> I often encounter the case that the origin reposotory is rebased and i
> make sure i want to use the origin head as my master
> Now I have to do
> $ git fetch origin && git reset --hard origin/master

The fact you are resetting means you do not have anything
interesting in your own branch yourself (--hard will lose your
changes and you are willing to lose it), which makes the use
case much less interesting, but I can understand a workflow that
is based around rebases, as in:

	$ git fetch origin && git rebase origin/master

which would be an equivalent to the resetting --hard when you do
not have anything interesting in your branch but if you do have
interesting commits they will be transplanted on top of the
rebased upstream head.

Upcoming 1.5.4 will have "git pull --rebase origin", which is a
short-hand for the above command.  That is a parallel for rebase
based workflow, just like "git pull origin" is a short-hand for

	$ git fetch origin && git merge origin/master

to help merge based workflow.
