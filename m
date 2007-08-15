From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 15:14:02 -0700
Message-ID: <86k5rwcuol.fsf@blue.stonehenge.com>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILR84-00043J-Nw
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759559AbXHOWOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759556AbXHOWOF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:14:05 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:10173 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396AbXHOWOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:14:04 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B2B001DE334; Wed, 15 Aug 2007 15:14:02 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.10.5; tzolkin = 12 Chicchan; haab = 13 Yaxkin
In-Reply-To: <600399.61066.qm@web52807.mail.re2.yahoo.com> (Perrin Meyer's message of "Wed, 15 Aug 2007 14:19:47 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55959>

>>>>> "Perrin" == Perrin Meyer <perrinmeyer@yahoo.com> writes:

Perrin> Hi,

Perrin> When I try to build and test 1.5.3-rc5 on my OS X box, I get a failure on "make test"

My t1000 test succeeded on modern OSX.  But "t1301-shared-repo" failed:

*** t1301-shared-repo.sh ***
* FAIL 1: shared=all

                mkdir sub &&
                cd sub &&
                git init --shared=all &&
                test 2 = $(git config core.sharedrepository)

* FAIL 2: update-server-info honors core.sharedRepository

                : > a1 &&
                git add a1 &&
                test_tick &&
                git commit -m a1 &&
                umask 0277 &&
                git update-server-info &&
                test 444 = $(stat -c %a .git/info/refs)

* failed 2 among 2 test(s)
make[1]: *** [t1301-shared-repo.sh] Error 1

This is on 1467b5fec376b6c43a5fa54bffd356e458a8d57c.

Oh... I notice "stat -c" there.  My stat doesn't know -c:

    localhost.local:~/MIRROR/git-GIT % stat -c %a /
    stat: illegal option -- c
    usage: stat [-FlLnqrsx] [-f format] [-t timefmt] [file ...]

Gotta stop using those non-portable options, I guess. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
