From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Test results for v1.7.11-rc2 on Cygwin
Date: Tue, 12 Jun 2012 19:07:54 +0100
Message-ID: <4FD7857A.1090601@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, wking@drexel.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVYt-0002tr-Bk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab2FLSLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:11:23 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:48834 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908Ab2FLSLW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 14:11:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SeVYm-0003vb-iN; Tue, 12 Jun 2012 18:11:21 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199826>

Hi Junio,

The test results for v1.7.11-rc2 look like:

    $ time $(GIT_SKIP_TESTS='t0061.3 t0070.3 t9501 t9010 t9300' \
    make test >test-out 2>&1)

    real    158m12.781s
    user    114m37.892s
    sys     54m54.986s
    $ 

Note that the only new failure is t9501-gitweb-standalone-http-status.sh
tests #13 and #16. These tests are new with commits 8745db6 ("gitweb: add
If-Modified-Since handling to git_snapshot()", 29-03-2012) and b7d565ea
("gitweb: refactor If-Modified-Since handling", 29-03-2012).

The reason for the failure is that I don't have either HTTP::Date or
Time::ParseDate modules available. When these modules are not available,
gitweb effectively disables the If-Modified-Since support. (ie gitweb
*correctly* handles the lack of a date parser by gracefully dropping
this capability).

I have a patch (coming soon) which skips these tests if a date parser
isn't available.

ATB,
Ramsay Jones
