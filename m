From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv3] git-fetch: Split fetch and merge logic
Date: Sat, 24 Feb 2007 04:32:11 -0800
Message-ID: <7v1wkfzqgk.fsf@assigned-by-dhcp.cox.net>
References: <87wt29i7hg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 13:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKw5E-0006SY-67
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 13:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXBXMcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 07:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbXBXMcO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 07:32:14 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37690 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbXBXMcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 07:32:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224123214.XKAP2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 07:32:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TQYC1W0021kojtg0000000; Sat, 24 Feb 2007 07:32:12 -0500
In-Reply-To: <87wt29i7hg.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Fri, 23
	Feb 2007 09:49:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40514>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> It makes git-parse-remote.sh and almost all git-fetch independent
> of the merge logic.
>
> git-fetch fetches the branches from the remote and saves this
> information in .git/FETCH_FETCHED, and at the end it generates
> the file .git/FETCH_HEAD.
>
> The current merge behaviour is unchanged.

I overlooked your earlier huge testcase patch, but I noticed it
does not include any test that fetches an annotated tag that
points at a commit or a non-commit, nor an unannotated tag that
is a tree or a blob.  I am too tired to check them right now,
but are you sure you are not regressing with them?

It is sometimes handy to be able to say:

	$ git fetch git-gui tag spearce-gpg-pub
        $ git cat-file -p FETCH_HEAD
