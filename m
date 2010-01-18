From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] builtin-apply.c: Skip filenames without enough components
Date: Mon, 18 Jan 2010 19:22:35 +0900
Message-ID: <20100118192235.6117@nanako3.lavabit.com>
References: <201001170305.10793.agruen@suse.de> <7vr5ppa2st.fsf@alter.siamese.dyndns.org> <201001170344.34525.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Mon Jan 18 11:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWosn-0003Ei-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 11:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab0ARKXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 05:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434Ab0ARKXH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 05:23:07 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59619 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab0ARKXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 05:23:06 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 76E4011B92F;
	Mon, 18 Jan 2010 04:23:04 -0600 (CST)
Received: from 8810.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id GGODCMNP83RX; Mon, 18 Jan 2010 04:23:04 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KQW3QiQ46qZARAIFl4H1Oe63r23S2pf1mtH0jR5SeyNOP8Z+OooixCEvSgDyk19C+xNBHTXfVKtoYKIXAb3We+5u5LCjCtB4JDWd7VdcVC2y1WF3yF7T4Y6SNy3WIVHoJVlY6jbuztUFq9DhZmJMpbzIE+7JLq3Q3iAYG21dfHM=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <201001170344.34525.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137381>

Quoting Andreas Gruenbacher <agruen@suse.de>

> On Sunday 17 January 2010 03:22:10 am Junio C Hamano wrote:
>> Tests?
>
> Sure if you think it's worth a regression test ...

Of course you must have a test when you are fixing things. Tests aren't to prove that your patch is correct. They are to prevent other people from breaking your change long after you leave the project.

> Sure if you think it's worth a regression test ... "git apply -p2" of the 
> following patch fails...

You do so by sending a patch to add your new test in t/; adding to an existing related test is preferred if the test is small.

Junio, in case you don't want to wait for Andreas, you can squash this test in.

diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 83d4ba6..b463b4f 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -22,4 +22,9 @@ test_expect_success 'apply git diff with -p2' '
 	git apply -p2 patch.file
 '
 
+test_expect_success 'apply with too large -p' '
+	test_must_fail git apply --stat -p3 patch.file 2>err &&
+	grep "removing 3 leading" err
+'
+
 test_done

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
