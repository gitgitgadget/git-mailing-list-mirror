From: "Imran M Yousuf" <imran@smartitengineering.com>
Subject: Re: [JGIT PATCH 1/2] Issue 23: Resolve tag^0 as tag^{commit}
Date: Fri, 12 Sep 2008 07:51:05 +0600
Message-ID: <9e85b2570809111851y756fdb3en2c17c69bf5ac444e@mail.gmail.com>
References: <20080911213927.GA20238@diku.dk>
	 <200809120047.58484.robin.rosenberg.lists@dewire.com>
	 <20080912000007.GA31931@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 12 03:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdxpb-0004bp-5m
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 03:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbYILBvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYILBvK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 21:51:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:31599 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbYILBvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 21:51:09 -0400
Received: by ey-out-2122.google.com with SMTP id 6so259848eyi.37
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 18:51:05 -0700 (PDT)
Received: by 10.210.36.8 with SMTP id j8mr4241898ebj.168.1221184265171;
        Thu, 11 Sep 2008 18:51:05 -0700 (PDT)
Received: by 10.210.113.7 with HTTP; Thu, 11 Sep 2008 18:51:05 -0700 (PDT)
In-Reply-To: <20080912000007.GA31931@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95678>

On Fri, Sep 12, 2008 at 6:00 AM, Jonas Fonseca <fonseca@diku.dk> wrote:
>> Second, the testcase in the second patch fails on my machine.
>>
>> testDerefTaggedTagTree(org.spearce.jgit.lib.T0008_testparserev)
>> junit.framework.ComparisonFailure: expected:<[269e1253bad5c247c6bde37aa48ae1e03138206c]> but was:<[be83157b4ffe650d728ba4f98ad47b623b0d0c20]>
>>       at junit.framework.Assert.assertEquals(Assert.java:81)
>>       at junit.framework.Assert.assertEquals(Assert.java:87)
>>       at org.spearce.jgit.lib.T0008_testparserev.testDerefTaggedTagTree(T0008_testparserev.java:123)
>
> I reran all the test before formatting the patch, but after doing some
> last minut changes. When I run all the tests using maven (inside
> NetBeans or from the command line) it tells me:
>
>        Tests run: 428, Failures: 0, Errors: 0, Skipped: 0
>
> From the output it looks like the tests in the files named T000* are
> never run. However, where the breakage is (could be my setup) I don't
> know. Imran?
>

Hmm, I will have to check it. Will come back with some feedback after
checking. Usually if a class is a TestCase then it should have run.

> Anyway, for now I will just run the single test specifically. Perhaps I
> should just put this into the same patch. Anyway, the following should
> fix it.
>
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
> index 2a1a4ad..1fc73b4 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
> @@ -117,7 +117,7 @@ public void testDerefTagIssue23() throws IOException {
>        }
>
>        public void testDerefTaggedTagTree() throws IOException {
> -               assertEquals("269e1253bad5c247c6bde37aa48ae1e03138206c",db.resolve("refs/tags/C").name());
> +               assertEquals("be83157b4ffe650d728ba4f98ad47b623b0d0c20",db.resolve("refs/tags/C").name());
>                assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/C^{commit}").name());
>                assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve("refs/tags/C^{tree}").name());
>        }
>
> --
> Jonas Fonseca
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
