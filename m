From: David Reiss <dreiss@facebook.com>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 12:40:45 -0700
Message-ID: <482C91BD.5070504@facebook.com>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 21:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjKx-00081C-Pz
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbYEOTk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbYEOTk5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:40:57 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:3119 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYEOTk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 15:40:56 -0400
Received: from SF2PMXF01.TheFacebook.com (sf2pmxf01.thefacebook.com [192.168.16.11])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4FJeoWd019645;
	Thu, 15 May 2008 12:40:50 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by SF2PMXF01.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 May 2008 12:37:58 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.DEB.1.00.0805151958180.30431@racer>
X-OriginalArrivalTime: 15 May 2008 19:37:58.0312 (UTC) FILETIME=[2DC98A80:01C8B6C3]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_04:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=7 spamscore=7 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805150166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82222>

> By now, I strongly believe that these changes are too large.  I am
> convinced that what you desire can be expressed much simpler, and thus
> less error-prone.
Most of the code is in the one function to parse out the colon-separated
environment variable value and compute the longest directory prefix.
I'm not convinced this can be made much simpler.  (Using strtok_r could
help, but would require an allocation.)  Most of the rest of the changes
are test code and indentation.
 
> Also, I think that your test cases are too extensive.  While it is usually
> good to have exhaustive tests, running them takes time.  And if it takes
> so much time that hardly anybody bothers with running the test suite,
> there are _too_ many tests.
I am more than happy to remove most of them, leaving only basic sanity
checks.  However, I would prefer to leave them in but comment them out,
so that if I or someone else wants to modify this code later, they would
be able to run a more extensive test suite.  I'll submit a modified
patch with this change.

> You know, I wonder why I even bothered writing those responses, if you
> just ignore them.
I must say that I am very confused.  I thought I followed all of your
responses to the letter.  Could you please be more specific about the
ones I missed?  I'm happy to make further changes.

> This has _no_ place in the Git source code.  Have you looked around, and
> found similar dead code?  No?  That's because Git's source code is not a
> graveyard of useless code bits, but it is a collection of elegant code. 
> Mostly, at least.
As I stated in "PATCH v2", I was unsure what the convention was for unit
tests like this.  Most of the git code is (obviously) functional tests,
but it is impossible to test how this code would behave with a git
directory under "/" using a functional test, unless it was run as root.
Someone just pointed out to me that there are some C-based tests (like
test-sha1) that are run from "make test".  I guess I can move the test
function to a new one of those, but it will require making
longest_ancestor_length extern.

> Instead of wasting my time further, I will try to come up with a better
> implementation, as is the way of Open Source.
I am sorry if this has wasted your time.  I really have been trying to
incorporate your feedback into my patch, and the code has definitely
improved as a result.  However, my main goal is simply to get this
feature working (I have already patched it into my own git build, and it
has saved me a lot of time), so if you come up with a better
implementation, that would be great!

--David
