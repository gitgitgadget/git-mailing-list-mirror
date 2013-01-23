From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug in EOL conversion?
Date: Wed, 23 Jan 2013 23:46:55 +0100
Message-ID: <87ehhb5xgg.fsf@pctrast.inf.ethz.ch>
References: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Stefan Norgren <stefan.norgren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 23:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty96G-0005YD-BA
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 23:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab3AWWrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 17:47:00 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:4700 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab3AWWq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 17:46:58 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 23 Jan
 2013 23:46:49 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 23 Jan
 2013 23:46:55 +0100
In-Reply-To: <CANrZfmGXtKcB+i_xhNJELftRc1pC2TJKKhOieHm=5Qkni9OKrA@mail.gmail.com>
	(Stefan Norgren's message of "Wed, 23 Jan 2013 03:44:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214375>

Stefan Norgren <stefan.norgren@gmail.com> writes:

> $ git add *
> warning: LF will be replaced by CRLF in withlf.txt.
> The file will have its original line endings in your working directory.
[...]
> $ ls -la
> total 10
> d---------+ 1 Stefan None 0 Jan 23 02:12 .
> d---------+ 1 Stefan None 0 Jan 23 02:10 ..
> d---------+ 1 Stefan None 0 Jan 23 02:22 .git
> ----------+ 1 Stefan None 3 Jan 23 01:55 withcrlf.txt
> ----------+ 1 Stefan None 2 Jan 23 01:55 withlf.txt
[...]
> $ git ls-tree -l HEAD withcrlf.txt
> 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2    withcrlf.txt
> $ git ls-tree -l HEAD withlf.txt
> 100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d       2    withlf.txt

Isn't that what would be expected?  It's a combination of

- the canonical representation of a newline is LF, so the repository
  stores LF

- with safecrlf, checkout converts LF->CRLF and add converts CRLF->LF

So from the user's POV, running

  git add withlf.txt
  rm withlf.txt
  git checkout -- withlf.txt

would appear to replace LF with CRLF in the worktree.  That's what the
message says.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
