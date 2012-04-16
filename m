From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Test results for v1.7.10 on cygwin
Date: Mon, 16 Apr 2012 20:08:28 +0100
Message-ID: <4F8C6E2C.5000101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:52:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDVR-0006Fa-55
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab2DQSvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:51:44 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37829 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab2DQSvV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:51:21 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SKDUl-0007W4-hK; Tue, 17 Apr 2012 18:51:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195793>

Hi Junio,

I had intended to run the complete test suite on cygwin before v1.7.10 was
released, but just didn't find the time. (I don't run all the tests very
often because it simply takes too long!)

Having found a spare evening, the results look like this:

    $ time $(GIT_SKIP_TESTS='t0061.3 t0070.3 t4130 t7400 t7406 t7407 t9010
    t9300' make test >test-out 2>&1)

    real    149m46.437s
    user    104m16.540s
    sys     50m52.053s
    $ 

Note that t9010 and t9300 have been added to the skipped test list since I last
ran the full test on v1.7.8-rc2. These tests have passed before, but on this
occasion they caused a hang (process deadlock). However, when running them from
the command line they (mostly) complete successfully. I guess I'm not too
surprised, given the unusual process plumbing used with svn-fe/fast-import.

[Note the time! :( This is 10m slower than v1.7.8-rc2. v1.6.0 was 47m. On Linux
the time is about 13m and that includes all the svn and cvs tests (which the
above does not)!]

The test failures in t7400, t7406 and t7407 are due to the use of $path in the
i18n functions used in git-submodule.sh. I sent an RFC patch to fix this during
the v1.7.8 rc period. I didn't get any comments at the time. I will be sending
an updated version soon, without the RFC, since it also fixes t7400 on MinGW
for me.

I have been including t4130 in the skipped test list for a couple of years.
The test fails intermittently, due to a 'racy-git' issue. I haven't found time
to fix this up, but it's not a big problem in practice.

[I don't remember what the remaining skipped tests are about, but again I have
been skipping them for ages! Hmm, I remember that one of them should have the
SANITY prerequisite applied because it fails on Linux if you run it as root.]

ATB,
Ramsay Jones
