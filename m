From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 17:58:36 +0100
Message-ID: <1361811516.3212.14.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 18:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA1Vk-0006Nt-GW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 18:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab3BYRGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 12:06:19 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:54612 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3BYRGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 12:06:18 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 12:06:18 EST
Received: from [192.168.1.2] (p57A1F6E7.dip.t-dialin.net [87.161.246.231])
	by hessy.dwim.me (Postfix) with ESMTPSA id BBFA18020A
	for <git@vger.kernel.org>; Mon, 25 Feb 2013 17:58:16 +0100 (CET)
X-Mailer: Evolution 3.4.4-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217065>

Hi all,

When testing to see if a different implementation was in shape, I came
across something odd where newer git doesn't advertise one of the refs
in the git repo.

Running `git ls-remote .` or `git-upload-pack` in my git repo, newer git
versions omit peeling the v1.8.0-rc3 tag.

The diff between the command above when ran with 1.7.10.4 (from Debian)
and current 'master'

--- old 2013-02-25 17:31:29.583526606 +0100
+++ new 2013-02-25 17:31:36.783526559 +0100
@@ -1379,7 +1379,6 @@
 c15295d7477ccec489953299bd03a8e62f86e611       refs/tags/v1.8.0-rc2
 cd46259ebf2e624bcee2aaae05c36663d414e1a2       refs/tags/v1.8.0-rc2^{}
 22ed067acc84eac8a0a72d20478a18aee4e25571       refs/tags/v1.8.0-rc3
-87a5461fa7b30f7b7baf27204f10219d61500fbf       refs/tags/v1.8.0-rc3^{}
 bfeb8b9ae0012cb61e026cbcd29664876abf5389       refs/tags/v1.8.0.1
 ed9fe755130891fc878bb2433204faffb534697b       refs/tags/v1.8.0.1^{}
 63add1fb45e1ab7a76bb38bbb9467c91fdfaaa7e       refs/tags/v1.8.0.2

Diffing with the output from next, diff tells me it's binary for some
reason, but looking manually, the peeled v1.8.0-rc3 tag isn't there
either. I haven't had time to bisect this, so I'm putting it out there
in case anybody wants to investigate before I have time to dig into it.


   cmn
