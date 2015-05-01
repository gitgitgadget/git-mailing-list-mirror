From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Test Failure] t5570 - not cloned
Date: Fri, 1 May 2015 11:04:48 -0400
Message-ID: <003901d08420$2b9fd7a0$82df86e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 01 17:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCUs-00033p-NB
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbbEAPEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:04:54 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46506 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbEAPEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:04:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([70.25.22.42])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t41F4pfp094111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 May 2015 11:04:52 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdCEHV7MxP3eRO+0R66IhYi0i+ZlYg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268142>

Greetings - and asking for a bit of help resolving test failures.

I'm having an issue with t5570 at 2.3.7 which seems to be a regression from
2.3.3 (currently installed), but I cannot be sure. This test failed prior to
2.3.0 in the box, worked from 2.3.0 to 2.3.3 - suggesting that it may be
environmental, not actually in git. Making some assumptions, it looks like
the URL for the test repository is not correct and may depend on localhost
resolving properly - which DNS does not do well on this box (outside my
control, we are multi-home, and localhost does not resolve to 127.0.0.1 or
[::1]). Only t5570 #'s 3-5 fail and I found a strange message in the output
of the test seemingly referring to a bad repo name. I would really
appreciate some pointers on where to look next and how to go about resolving
this. I am happy to try to work through this on 2.4.0 if that would be more
efficient for the team. Anything relating to git-daemon makes me nervous in
terms of installing the code.

Platform is HP NonStop (Posix-esque environment):

In the test output:
*** t5570-git-daemon.sh ***
<snip>
not ok 3 - clone git repository
#
#               git clone "$GIT_DAEMON_URL/repo.git" clone &&
#               test_cmp file clone/file
#
not ok 4 - fetch changes via git protocol
#
#               echo content >>file &&
#               git commit -a -m two &&
#               git push public &&
#               (cd clone && git pull) &&
#               test_cmp file clone/file
#
not ok 5 - remote detects correct HEAD
#
#               git push public master:other &&
#               (cd clone &&
#                git remote set-head -d origin &&
#                git remote set-head -a origin &&

And

../git/t/trash directory.t5570-git-daemon: cat output
fatal: remote error: repository not exported: /repo.git

Additional context: t0025, t0301, t3900, t9001, t9020 are not 100% but the
issues are acceptable - we can discuss separately.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
