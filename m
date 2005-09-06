From: "H. Peter Anvin" <hpa@zytor.com>
Subject: cg-update (cogito-0.13) bug: changed heads
Date: Tue, 06 Sep 2005 14:01:25 -0700
Message-ID: <431E03A5.6060709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 06 23:03:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECkZi-0001AD-7N
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 23:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVIFVBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 17:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVIFVBr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 17:01:47 -0400
Received: from terminus.zytor.com ([209.128.68.124]:38554 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750935AbVIFVBr
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 17:01:47 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j86L1UMc019647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2005 14:01:31 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8146>

I just found a bug in cogito-0.13, at least to the best of my 
understanding of the situation.

Simplified, the problem looks like this: two sides, A and B, pull from 
repository C.  The head of this pull we call 0.

Now commit 1 is added to A.  B pulls commit 1 from A, not though C. 
Later, A pushes commit 1 to C.

Next time B tries to pull from C, cg-update will not advance 
refs/heads/origin, even though C now has a new head.  Thus, B will think 
that C is in a different state than it actually is.

This has, for me, broken safeguards of the form "make sure you're merged 
before you pull."

	-hpa
