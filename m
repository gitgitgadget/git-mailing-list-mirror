From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 10:43:57 +0200
Message-ID: <87vbtt6dyq.fsf@fencepost.gnu.org>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, d9ba@mailtor.net,
	jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:44:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehAX-00056Z-Nj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbaD1IoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:44:01 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:58254 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaD1In7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:43:59 -0400
Received: from localhost ([127.0.0.1]:57294 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WehAM-000202-8c; Mon, 28 Apr 2014 04:43:58 -0400
Received: by lola (Postfix, from userid 1000)
	id CAE79E05FE; Mon, 28 Apr 2014 10:43:57 +0200 (CEST)
In-Reply-To: <1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 28 Apr 2014 10:34:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247246>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> By default, Git used to set $LESS to -FRSX if $LESS was not set by the
> user. The FRX flags actually make sense for Git (F and X because Git
> sometimes pipes short output to less, and R because Git pipes colored
> output). The S flag (chop long lines), on the other hand, is not related
> to Git and is a matter of user preference. Git should not decide for the
> user to change LESS's default.

>> We agree here.  So, does someone who actually wants this change want to
>> propose a patch? :)
>
> Here you are.
>
>  Documentation/config.txt | 13 ++++++++-----
>  Makefile                 |  6 +++---
>  perl/Git/SVN/Log.pm      |  2 +-
>  3 files changed, 12 insertions(+), 9 deletions(-)

There seem to be a few more occurences (git-sh-setup.sh and pager.c):

$ git grep FRSX
Documentation/RelNotes/1.6.5.txt: * mingw will also give FRSX as the default val
Documentation/config.txt:When the `LESS` environment variable is unset, Git sets
Documentation/config.txt:command to `LESS=FRSX less -+S`. The environment tells 
git-sh-setup.sh:        : ${LESS=-FRSX}
pager.c:                        env[i++] = "LESS=FRSX";
perl/Git/SVN/Log.pm:    $ENV{LESS} ||= 'FRSX';

Searching for LESS seems to implicate a few more possible candidates in
contrib/examples:

contrib/examples/git-log.sh:LESS=-S ${PAGER:-less}
contrib/examples/git-whatchanged.sh:LESS="$LESS -S" ${PAGER:-less}


-- 
David Kastrup
