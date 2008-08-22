From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] discard revindex data when pack list changes
Date: Fri, 22 Aug 2008 23:57:04 +0200
Message-ID: <200808222357.04912.johan@herland.net>
References: <200808221439.31219.johan@herland.net>
 <200808221527.21971.johan@herland.net>
 <alpine.LFD.1.10.0808221540290.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:59:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeep-0007rL-EK
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459AbYHVV5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbYHVV5k
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:57:40 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55836 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459AbYHVV5j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:57:39 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6000G1PVNTXC00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 22 Aug 2008 23:57:29 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K600021VVN5O7C0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 22 Aug 2008 23:57:05 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K600091KVN5HK31@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 22 Aug 2008 23:57:05 +0200 (CEST)
In-reply-to: <alpine.LFD.1.10.0808221540290.1624@xanadu.home>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93382>

On Friday 22 August 2008, Nicolas Pitre wrote:
> This is needed to fix verify-pack -v with multiple pack arguments.
>
> Also, in theory, revindex data (if any) must be discarded whenever
> reprepare_packed_git() is called. In practice this is hard to trigger
> though.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Tested-by: Johan Herland <johan@herland.net>

Thanks. Works for me :)

Junio: if you added the my testcase, please squash the following into this 
patch before applying:

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 339375a..83abe5f 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -186,7 +186,7 @@ test_expect_success \
 			test-2-${packname_2}.idx \
 			test-3-${packname_3}.idx'
 
-test_expect_failure \
+test_expect_success \
     'verify pack -v' \
     'git verify-pack -v	test-1-${packname_1}.idx \
 			test-2-${packname_2}.idx \
-- 
1.6.0.96.g2fad1


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
