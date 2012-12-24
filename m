From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: GIT get corrupted on lustre
Date: Mon, 24 Dec 2012 09:08:46 -0500
Message-ID: <50D861EE.6020105@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 15:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn8xS-0001Gf-JA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 15:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab2LXOYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 09:24:21 -0500
Received: from outboundmta02.oricom.ca ([64.18.160.77]:55715 "EHLO
	outboundmta02.oricom.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2LXOYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 09:24:19 -0500
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Dec 2012 09:24:19 EST
X-ASG-Debug-ID: 1356358129-054b990f383dc540001-QuoKaX
Received: from [192.168.0.33] (092.9.modemcable.oricom.ca [69.67.9.92]) by outboundmta02.oricom.ca with ESMTP id tdk1PG4mCLdar0BM for <git@vger.kernel.org>; Mon, 24 Dec 2012 09:08:49 -0500 (EST)
X-Barracuda-Envelope-From: Eric.Chamberland@giref.ulaval.ca
X-Barracuda-Apparent-Source-IP: 69.67.9.92
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-ASG-Orig-Subj: GIT get corrupted on lustre
X-Barracuda-Connect: 092.9.modemcable.oricom.ca[69.67.9.92]
X-Barracuda-Start-Time: 1356358129
X-Barracuda-URL: http://64.18.160.77:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at oricom.ca
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=BSF_RULE_7582B
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.117931
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE_7582B         Custom Rule 7582B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212109>

Hi,

we are using git since may and all is working fine for all of us (almost 
20 people) on our workstations.  However, when we clone our repositories 
to the cluster, only and only there
we are having many problems similiar to this post:

http://thread.gmane.org/gmane.comp.file-systems.lustre.user/12093

Doing a "git clone" always work fine, but when we "git pull" or "git gc" 
or "git fsck", often (1/5) the local repository get corrupted.
for example, I got this error two days ago while doing "git gc":

error: index file .git/objects/pack/pack-7b43b1c613a851392aaf4f66916dff2577931576.idx is too small
error: refs/heads/mail_seekable does not point to a valid object!

also, I got this error 5 days ago:

error: index file .git/objects/pack/pack-ef9b5bbff1ebc1af63ef4262ade3e18b439c58af.idx is too small
error: refs/heads/mail_seekable does not point to a valid object!
Removing stale temporary file .git/objects/pack/tmp_pack_lO7aw2

and this one some time ago:

Removing stale temporary file .git/objects/pack/tmp_pack_5CHb2F
Removing stale temporary file .git/objects/pack/tmp_pack_GY159g
Removing stale temporary file .git/objects/pack/tmp_pack_aKkXTS

We are using git 1.8.0.1 on CentOS release 5.8 (Final).

We think it could be related to the fact that we are on a *Lustre* 
filesystem, which I think doesn't fully support file locking.

Questions:

#1) However, how can we *test* the filesystem (lustre) compatibility 
with git? (Is there a unit test we can run?)

#2) Is there a way to compile GIT to be compatible with lustre? (ex: no 
threads?)

#3) If you *know* your filesystem doesn't allow file locking, how would 
you configure/compile GIT to work on it?

#4) Anyone has another idea on how to solve this?

Thanks,

Eric
