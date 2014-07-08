From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 00/48] Use ref transactions
Date: Tue, 08 Jul 2014 18:29:07 +0200
Message-ID: <53BC1C53.9030203@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 18:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4YNQ-0003O7-87
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 18:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbaGHQgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 12:36:13 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50318 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754485AbaGHQgM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 12:36:12 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2014 12:36:11 EDT
X-AuditID: 12074412-f792e6d000005517-5e-53bc1c556cfa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.96.21783.55C1CB35; Tue,  8 Jul 2014 12:29:09 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68GT8qN009554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 12:29:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1A2V2RNssHmerkXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvjwvcLzAXnhCoWbl/I3sD4jK+LkZNDQsBE4s+2
	xYwQtpjEhXvr2UBsIYHLjBKfzwpD2OeZJOZMLwOxeQW0JQ533gOq5+BgEVCVODAHrJxNQFdi
	UU8zE4gtKhAkMfvzPHaIckGJkzOfsIDYIgJ2EutvLWQGsYUFjCVm/3/ICDHeWaLrz36wOZwC
	LhL/b35hARkvISAu0dMYBGIyC6hLrJ8nBFLBLCAvsf3tHOYJjAKzkCyYhVA1C0nVAkbmVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghoSm0g3H9SblDjAIcjEo8vAo8e4KF
	WBPLiitzDzFKcjApifJOYAIK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFdLgiU401JrKxKLcqH
	SUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4FWVBmoULEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB8VnfDEwQkFSPEB7eUDaeYsLEnOBohCtpxgVpcR570oBJQRAEhmleXBj
	YQnnFaM40JfCvDIg7TzAZAXX/QpoMBPQ4M/vd4AMLklESEk1MGYwH3qiZibfxdzRoTGfa++6
	nNIJ+6ttuiInfLxzrnLprEkfZtxYoqrKca42LUxcfIGdkl2BbJHwt/k/7wv/cJT/Wnzza6Ss
	jVz3Te0lLbl8x6cp/TzJYHTsm43cslccac+n7rklf1Eu/C+vmdnJ9IflL368XdV2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253033>

On 06/20/2014 04:42 PM, Ronnie Sahlberg wrote:
> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions
> 
> This patch series is based on current master and expands on the transaction
> API. It converts all ref updates, inside refs.c as well as external, to use the
> transaction API for updates. This makes most of the ref updates to become
> atomic when there are failures locking or writing to a ref.
> 
> This version completes the work to convert all ref updates to use transactions.
> Now that all updates are through transactions I will start working on
> cleaning up the reading of refs and to create an api for managing reflogs but
> all that will go in a different patch series.
> 
> Version 20:
>  - Whitespace and style changes suggested by Jun.

I spent most of the day on reviewing this patch series, but now I'm out
of time again.  Here is a summary from my point of view:

Patches 01-19 -- ACK mhagger
Patches 20-42 -- I sent various comments, small to large, concerning
these patches
Patch 43 -- Needs more justification if it is to be acceptable
Patch 44 -- Depends on 43
Patches 45-48 -- I didn't quite get to these, but...

Perhaps it would be more appropriate for the rules about reference name
conflicts to be enforced by the backend, since it is the limitations of
the current backend that impose the restrictions.  Would that make sense?

On the other hand, removing the restrictions isn't simply a matter of
picking a different backend, because all Git repositories have to be
able to interact with each other.

So, I don't yet have a considered opinion on the matter.


I think it would be good to try to merge the first part of this patch
series to lock in some progress while we continue iterating on the
remainder.  I'm satisfied that it is all going in the right direction
and I am thankful to Ronnie for pushing it forward.  But handling
48-patch series is very daunting and I would welcome a split.

I'm not sure whether patches 01-19 are necessarily the right split
between merge-now/iterate-more; it is more or less an accident that I
stopped after patch 19 on an earlier review.  Maybe Ronnie could propose
a logical subset of the commits as being ready to be merged to next in
the nearish term?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
