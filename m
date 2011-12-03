From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Evaluation of ref-api branch status
Date: Sun, 04 Dec 2011 00:52:14 +0100
Message-ID: <4EDAB62E.5070204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 04 00:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWzNZ-00027l-FB
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 00:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab1LCXwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 18:52:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:40998 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab1LCXwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 18:52:19 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED25F.dip.t-dialin.net [84.190.210.95])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pB3NqERT016405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Dec 2011 00:52:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186262>

Junio,

Now that 1.7.8 is out, I wanted to figure out the status of the
remaining ref-api changes that are in flight, including the differences
between between my tree and yours.

I understand that "next" will soon be re-rolled.  Will the re-roll be
based on the current "pu", or will you start from scratch?


AFAIK there are three groups of ref-api patch series in flight, some of
which have gone through multiple iterations:

ref-api-B == mh/ref-api-2
    [PATCH v3 00/14] Tidying up references code

ref-api-C == mh/ref-api-3
    [PATCH v2 00/12] Use refs API more consistently

ref-api-D == mh/ref-api-take-2
    [PATCH 00/28] Store references hierarchically in cache

On 2011-10-28 I sent re-rolled versions of ref-api-B and ref-api-C to
the list followed by the first version of ref-api-D.  You committed
these three patch series to your repository as a single branch,
"mh/ref-api-take-2".  The mh/ref-api-take-2 branch thus includes the
logical equivalent of all three of the patch series listed above.

Additionally, on 2011-11-15 I sent a fix to patch 26/28 of ref-api-D:

    [PATCH] Fix "is_refname_available(): query only possibly-conflicting
 references"

I don't see this patch in your tree at all.


Meanwhile, you added the following fix on top of master, mh/ref-api-2,
and ref-api-3:

    refs: loosen over-strict "format" check

[Aside: I don't understand why you created three independent commits
rather than create an ur-commit on $(git merge-base master mh/ref-api-2
mh/ref-api-3) then merging it to each of the branches.]


Both mh/ref-api-2 (including your fix) and mh/ref-api-3 (including your
fix) have been merged into "next".  You have never merged
mh/ref-api-take-2 anywhere.  On the mh/ref-api-take-2 branch:

* ce766d41fa corresponds to mh/ref-api-2 (without your fix)
* 633ebc45c0 corresponds to mh/ref-api-3 (without your fix)

Therefore, your 633ebc45c0..mh/ref-api-take-2 corresponds to my newest
"ref-api-D" patch series.  It does not include my fix from 2011-11-15.
Nor does it include any form of your fix "refs: loosen over-strict
"format" check".


What is the difference between the beginning of mh/ref-api-take-2 as
compared to mh/ref-api-2 + mh/ref-api-3?  Equivalently, what is the
difference between the last versions of ref-api-B and ref-api-C vs.
earlier versions of those patch series?  The differences are relatively
minor:

* A whitespace problem in the earlier version of the series was fixed.
This whitespace problem was introduced in caa80697 and has gotten into
"pu" (in refs.c starting at line 1093).

* resolve_gitlink_packed_ref() was simplified a bit and got a docstring.

* A function do_for_each_ref_in_arrays() was extracted.

* The series were rebased.  The changes made to rebase them are roughly
equivalent to the work that you did in merges bea03b2455 and 773b817986.
 (BTW, your merges look correct to me.)

* It does *not* include your fix "refs: loosen over-strict "format" check".

SUMMARY:

The patches from mh/ref-api-take-2 through 633ebc45c0 plus your fix are
slightly preferable to the patches in mh/ref-api-2 and mh/ref-api-3, in
the ways listed in the bullet-points above.  If you are rewinding "next"
anyway, I suggest that you take the former instead of the latter.  If
you prefer to stick with the latter, let me know and I will submit the
remaining differences as patches to be applied on top of mh/ref-api-3.


I hope that this summary is helpful to you.  (It certainly helped me
figure out where things stand.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
