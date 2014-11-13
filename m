From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: mac test failure -- 2gb clone
Date: Thu, 13 Nov 2014 06:05:40 +0100
Message-ID: <54643C24.20201@web.de>
References: <CAO2U3QjFCBqJ+_E-nyxGnm3GdwB1zJgK6d8SJ4QULQHY1D6bUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 06:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XombL-0007vm-4C
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 06:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbaKMFFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 00:05:43 -0500
Received: from mout.web.de ([212.227.15.4]:61945 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbaKMFFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 00:05:43 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MBCcv-1Xf7Y00gQn-00ABrC; Thu, 13 Nov 2014 06:05:41
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAO2U3QjFCBqJ+_E-nyxGnm3GdwB1zJgK6d8SJ4QULQHY1D6bUw@mail.gmail.com>
X-Provags-ID: V03:K0:ppd0O5iXT7JnCATE96NQ/I0DlMoeJWHxOMhI58W41zfc/sptZfN
 5EaWH9L4ZqwT1FqyrvKnkGZ636EldcpCZlaXsx8ZON6HGvLDCxgLDTIHuw13VGMNUPEJDI2
 8+FdF0pUt+sCKq8S4xarZsqrHBBQxjDMl0X9P1SKKwFENeIZUKgQylc+yrKO1txeoJr9slz
 b3VV2pEBMIr+Uh81CBxew==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-12 22.57, Michael Blume wrote:

[t5705-clone-2gb.sh broken on Mac OS]

It is most probably even broken on every platform,
since we renovated the URL parser in 2013.
(More info can be found here:)
 git log t/t5601-clone.sh


I missed t5705-clone-2gb.sh,
because it has its own enabler variable  GIT_TEST_CLONE_2GB instead
of using EXPENSIVE as other tests do.

We can say that it as a regression that the URL
file://. 
is no longer supported, and change it like this: 

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index e9783c3..a713118 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -46,7 +46,7 @@ test_expect_success CLONE_2GB 'clone - bare' '
 
 test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol' '
 
-       git clone file://. clone-wt
+       git clone "file://$(pwd)" clone-wt
 
 '

Thanks for reporting.
Does someone wants to send a patch for t5705-clone-2gb.sh ? 
