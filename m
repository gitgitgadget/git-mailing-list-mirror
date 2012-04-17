From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: test-mergesort conflict with stdlib.h
Date: Tue, 17 Apr 2012 13:25:48 -0400
Message-ID: <E6D295C2-C35E-4ECF-990D-FCF8407C2429@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCFt-00055x-AK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822Ab2DQRbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 13:31:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48757 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab2DQRbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 13:31:48 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Apr 2012 13:31:48 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C59661FFC0EB; Tue, 17 Apr 2012 17:25:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from bcg2784.student.rit.edu (bcg2784.student.rit.edu [129.21.210.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 19BD81FFC015
	for <git@vger.kernel.org>; Tue, 17 Apr 2012 17:25:44 +0000 (UTC)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195773>

On OS X 10.7.3, I get the following error attempting to build next:

    CC test-mergesort.o
In file included from test-mergesort.c:2:
./mergesort.h:4:7: error: conflicting types for 'mergesort'
void *mergesort(void *list,
      ^
/usr/include/stdlib.h:306:6: note: previous declaration is here
int      mergesort(void *, size_t, size_t,
         ^

This appears to be due to the fact that 0db71e0: "add mergesort() for linked lists" added a mergesort implementation with a different signature than a mergesort implemented by OS X's standard library.  Perhaps git could use a less generic name like 'llist_mergesort'?

~~ Brian Gernhardt
