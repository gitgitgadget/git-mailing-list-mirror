From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH v2] Git.pm: Use File::Temp->tempfile instead of ->new
Date: Tue, 9 Sep 2008 09:41:30 +0200
Message-ID: <48C628AA.4020100@statsbiblioteket.dk>
References: <1220889063-20387-1-git-send-email-marcus@griep.us> <1220892781-24343-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Abhijit Menon-Sen <ams@toroid.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Sep 09 09:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcxs1-0001LF-U8
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 09:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbYIIHle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 03:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYIIHle
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 03:41:34 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:16760 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753743AbYIIHld (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 03:41:33 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Tue, 9 Sep 2008 09:41:31 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <1220892781-24343-1-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95347>

Marcus Griep wrote:
> Perl 5.8.0 ships with File::Temp 0.13, which does not have the new()
> interface introduced in 0.14, as pointed out by Tom G. Christensen.
> 
> This modifies Git.pm to use the more established tempfile() interface
> and updates 'git svn' to match.
> 
> Signed-off-by: Marcus Griep <marcus@griep.us>
> ---
> 
>  This patch v2 cleans up a few code items, corrects a misspelling,
>  and ensures that the temp file gets unlinked when we exit, now
>  that we are requesting the filename.  Otherwise, the previous
>  comments stand:
> 
>  Per the earlier patch versions by Abhijit Menon-Sen and Tom G. Christensen.
>  Both of you may want to run a test and add your 'Tested-by' to the thread
>  if everything works out before Eric Wong adds his 'Acked-by'.
> 
The testsuite now passes t9100-git-svn-basic.sh and instead fails at 
t9108-git-svn-glob.sh but this appears to be unrelated to the File::Temp 
issue.

--- expect.three        2008-09-09 07:34:39.000000000 +0000
+++ stderr.three        2008-09-09 07:34:42.000000000 +0000
@@ -1,2 +1,3 @@
+Parentheses missing around "my" list at 
/home/tgc/projects/git/t/../git-svn line 4429.
  Only one set of wildcard directories (e.g. '*' or '*/*/*') is 
supported: 'branches/*/t/*'

* FAIL 3: test disallow multi-globs

Tested-by: Tom G. Christensen <tgc@statsbiblioteket.dk>

-tgc
