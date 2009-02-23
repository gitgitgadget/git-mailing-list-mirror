From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting diff in commit-msg hook?
Date: Sun, 22 Feb 2009 18:35:07 -0800
Message-ID: <7vhc2lx4mc.fsf@gitster.siamese.dyndns.org>
References: <loom.20090222T205429-30@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerd Knops <gerti-git@bitart.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 03:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbQgV-0008U1-9U
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 03:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZBWCfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 21:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZBWCfO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 21:35:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbZBWCfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 21:35:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 169FB9C850;
	Sun, 22 Feb 2009 21:35:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1691B9C84F; Sun,
 22 Feb 2009 21:35:08 -0500 (EST)
In-Reply-To: <loom.20090222T205429-30@post.gmane.org> (Gerd Knops's message
 of "Sun, 22 Feb 2009 21:03:45 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 983BCE52-0152-11DE-8D4F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111074>

Gerd Knops <gerti-git@bitart.com> writes:

> When I commit certain files, I would like to send a diff via email to
> interested parties.
>
> So I added a commit-msg hook, which checks the list of files for that commit.
> That part works fine. However in the email I would like to include a
> diff of the file(s) in question.
>
> Now when I run "git diff -- '$file'", I get no output, probably because the
> file is in some semi-committed state.
>
> So how can I obtain a diff for a file in a commit-msg hook?

How are you getting the list of files for the commit in that commit-msg
hook?  I think you are doing something like

	"git diff --cached --name-only"

The new state you are committing is in the index, and "the diff for the
commit" is "what is the difference between the state of the previous
commit and the state of this commit records", so

	" git diff --cached"

should give you what you want (and you do not need to do that per path.

Having said all that, I imagine you would realize that you do not want to
do this inside any of the hooks triggered by "git commit", as you learn to
work with git more.  I suspect you would probably find a hook triggered
when you push into another repository is more appropriate place for doing
this kind of thing.
