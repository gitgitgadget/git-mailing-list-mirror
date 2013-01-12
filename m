From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Sat, 12 Jan 2013 16:13:52 +0100
Message-ID: <50F17DB0.2050802@alum.mit.edu>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Rorvick <chris@rorvick.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu2tk-0006P8-34
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 16:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3ALPU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 10:20:59 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:50138 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760Ab3ALPU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 10:20:58 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2013 10:20:58 EST
X-AuditID: 12074412-b7f216d0000008e3-07-50f17db4ce19
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E3.DD.02275.4BD71F05; Sat, 12 Jan 2013 10:13:56 -0500 (EST)
Received: from [192.168.69.140] (p57A24728.dip.t-dialin.net [87.162.71.40])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0CFDr1L003485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jan 2013 10:13:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1357875152-19899-1-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqLul9mOAwYFWOYudc/exWlzd4mPR
	daWbyaKh9wqzA4vHxUvKHrtPs3os+9rJ4vF5k1wASxS3TVJiSVlwZnqevl0Cd8bzI33sBX/k
	KmbM7mJsYPwu0cXIySEhYCKx4FU/E4QtJnHh3nq2LkYuDiGBy4wSTRsWMkI4p5kkZi/bAVbF
	K6At8ePKDkYQm0VAVWL+9KdsIDabgK7Eop5msBpRgQCJxUvOsUPUC0qcnPmEBcQWEVCX+HDk
	KDOIzSyQLvGw9TJYjbCAl8Tn9/2sILaQgKPEon33weZzCjhJ/L99jwWiXkfiXd8DqF55ie1v
	5zBPYBSYhWTFLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokR
	EsxCOxjXn5Q7xCjAwajEw3s64EOAEGtiWXFl7iFGSQ4mJVHenJqPAUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeH+UAOV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4
	F4MMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFanwxMFpBUjxAeyNB2nmLCxJz
	gaIQracYjTn2P2l/zsix/TeQFGLJy89LlRLnbQEpFQApzSjNg1sES2OvGMWB/hbmXQFSxQNM
	gXDzXgGtYgJadfbCe5BVJYkIKakGxoQuP4Nt57z9Dkd7KX96r7HxRNW9J48zU/R9GFp+eXuJ
	993UvH3CYlGjzdtuDeunFxKeSp7ZKT81VyJI6Lmu9cWieUmTn/F5eVtc26SZINOc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213287>

On 01/11/2013 04:32 AM, Junio C Hamano wrote:
> From: "Eric S. Raymond" <esr@thyrsus.com>
> 
> The combination of git-cvsimport and cvsps had serious problems.

Agreed.

> [...]
> This patch also removes Michael Haggerty's git-cvsimport tests
> (t960[123]) from the git tree.  These are actually conversion-engine
> tests and have been merged into a larger cvsps test suite, which I
> intend to spin out into a general CVS-lifting test that can also be
> applied to utilities such as cvs2git and parsecvs.  The t9604 test
> will move in a future patch, when I likewise have it integrated
> into the general test suite.
> 
> The following known bug has not been fixed: "If any files were ever
> "cvs import"ed more than once (e.g., import of more than one vendor
> release) the HEAD contains the wrong content." However, cvsps now
> emits a warning in this case. There is also one pathological tagging
> case that was successful in the former t9602 test that now fails
> (with a warning).
> 
> I plan to address these problems. This patch at least gets the
> cvsps-3.x/git-cvsimport combination to a state that is not too
> broken to ship - that is, in all failure cases known to me it
> now emits useful warnings rather than silently botching the
> import.

I don't understand the logic of removing the cvsimport tests, at least
not at this time.  It is true that the tests mostly ensure that the
conversion engine is working correctly, especially with your new version
of cvsps.  But I think the git project, by implicitly endorsing the use
of cvsps, has some responsibility to verify that the combination cvsps +
git-cvsimport continues to work and to document any known breakages via
its test suite.

Otherwise, how do we know that cvsps currently works with git-cvsimport?
 (OK, you claim that it does, but in the next breath you admit that
there is a new failure in "one pathological tagging case".)  How can we
understand its strengths/weaknesses?  How can we gain confidence that it
works on different platforms?  How will we find out if a future versions
of cvsps stops working (e.g., because of a breakage or a
non-backwards-compatible change)?

Normally one would expect an improvement like this to be combined with
patches that turn test expected failures into expected successes, not to
rip out the very tests that establish the correctness of the change that
is being proposed!


Let me describe what I would consider to be the optimum state of the
test suite.  Maybe your idea of "optimum" differs from mine, or maybe
the optimum is unrealistic due to lack of resources or for some other
reason.  But if so, let's explicitly spell out why we are deviating from
whatever optimum we define.

* The old tests should be retained (and possibly new tests added to show
off your improvements).

* There should be a way for users to choose which cvsps executable to
use when running test suite.  (In the future, the selection might be
expanded to cover altogether different conversion engines.)

* The tests should determine which version of cvsps has been selected
(e.g., by running "cvsps --version").

* The individual tests should be marked expected success/expected
failure based on the selected version of cvsps; in other words, some
tests might be marked "expected failure" if cvsps 2.x is being used but
"expected success" if cvsps 3.x is being used.


Regarding your claim that "within a few months the Perl git-cvsimport is
going to cease even pretending to work": It might be that the old
git-cvsimport will stop working *for people who upgrade to cvsps 3.x*.
But it is not realistic to expect people to synchronize their git and
cvsps version upgrades.  It is even quite possible that this or that
Linux distribution will package incompatible versions of the two packages.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
