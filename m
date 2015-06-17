From: KK <horizn@wp.pl>
Subject: slash in branch name
Date: Wed, 17 Jun 2015 20:16:10 +0100
Message-ID: <5581C77A.3040703@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:16:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IpA-0004iY-5V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906AbbFQTQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:16:32 -0400
Received: from mx4.wp.pl ([212.77.101.12]:35654 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756894AbbFQTQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:16:30 -0400
Received: (wp-smtpd smtp.wp.pl 2230 invoked from network); 17 Jun 2015 21:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1434568588; bh=ydRo3fAJ5D1Ont65E9cYm+AHQoakXck83Tkg1HnXYxU=;
          h=From:To:Subject;
          b=Jf9WVNZavGD3KgTCqWReP3K0QZ0JmXMLsp2JXYNn6Y2JImIjIpL8UZuTeugHYZdus
           EiubGOYjs54r5PTyy4j/9zH/6Qk2axHzIIQcVE5D/QuYlJMkw2/6aJQaw2BYLAX9l0
           dy+T209Kr1TMSvrioYULfDGszjcaTgtEl+ng56bY=
Received: from host109-148-13-186.range109-148.btcentralplus.com (HELO [192.168.1.79]) (horizn@[109.148.13.186])
          (envelope-sender <horizn@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 17 Jun 2015 21:16:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-WP-MailID: 6c3f3d08d11c25a3f0a3696063d48ac1
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [sbMU]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271884>

Hi,

After upgrade GIT from 1.7.2.5-3.1 to 1.7.10.4-1+wheezy1 following error 
appear:

git push central versions/4.3.2
Counting objects: 45, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (28/28), done.
Writing objects: 100% (28/28), 13.01 KiB, done.
Total 28 (delta 22), reused 0 (delta 0)
remote: Update script started: Tue Jun 9 13:25:34 BST 2015
remote: Arguments: refs/heads/versions/4.3.2
2e5233728aecc6ac337f4d3a9f32281e7c786e27
ae25cc33f6cf745cfa1061cbdfaf445344a60d13
remote: Warning: using temporary hooks
remote: error: invalid key: hooks.denypush.branch.versions/4.3.2
remote: error: invalid key: hooks.allowmerge.versions/4.3.2
remote: Packages changed by this update:
remote:   think_3
remote:   hls_plugin_1
remote:   hal_av_1
remote:   rtsp_plugin_1
remote: Notifying the following package owners of this update:

hooks were downloaded from:
git://git.et.redhat.com/ovirt-server.git

My colleague did some research about that and it seems that this commit 
has stopped update hook working:

commit b09c53a3e331211fc0154de8ebb271e48f8c7ee5
Author: Libor Pechacek <lpechacek@suse.cz>
Date:   Sun Jan 30 20:40:41 2011 +0100

     Sanity-check config variable names

     Sanity-check config variable names when adding and retrieving them. 
  As a side
     effect code duplication between git_config_set_multivar and 
get_value (in
     builtin/config.c) was removed and the common functionality was 
placed in
     git_config_parse_key.

     This breaks a test in t1300 which used invalid section-less keys in 
the tests
     for "git -c". However, allowing such names there was useless, since 
there was
     no way to set them via config file, and no part of git actually 
tried to use
     section-less keys. This patch updates the test to use more 
realistic examples
     as well as adding its own test.

     Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
     Acked-by: Jeff King <peff@peff.net>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>


Could you please advise how to fix/revert this?

brgds,
