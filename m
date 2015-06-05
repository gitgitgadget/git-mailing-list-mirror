From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 16/56] add_branch_for_removal(): don't set "util" field
 of string_list entries
Date: Fri, 05 Jun 2015 16:48:20 +0200
Message-ID: <5571B6B4.10006@alum.mit.edu>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net> <1432579162-411464-17-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	=?windows-1252?Q?Jens_Lindstr=F6m?= <jl@opera.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 16:48:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0svQ-00073T-5R
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423054AbbFEOsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 10:48:38 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63170 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030222AbbFEOsg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 10:48:36 -0400
X-AuditID: 12074413-f79386d000000d23-92-5571b6b7d4a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 88.B1.03363.7B6B1755; Fri,  5 Jun 2015 10:48:23 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741B.dip0.t-ipconnect.de [79.201.116.27])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t55EmKZj008939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Jun 2015 10:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1432579162-411464-17-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqLt9W2GoQftNMYuuK91MFh+m/WO2
	+NHSw2zRNvMHk8Xmze0sDqwey2/+ZfJYsKnUY+r906wez3r3MHp83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xYXJ1QQNPxdcrkxgbGM9zdjFyckgImEjsnHWVCcIWk7hwbz1bFyMXh5DAZUaJCRsn
	sEM455gkPi5YwwpSxSugKTFp43F2EJtFQFWif9NRMJtNQFdiUU8z0CQODlGBIInXL3MhygUl
	Ts58wgJiiwh4Scx/NANsDLNAncSGV5fBFgsLpEv0H1jGBLFrAqPE3OUTwBKcAv4SR/ruskE0
	6EnsuP4LqlleonnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0
	zfVyM0v0UlNKNzFCQlx4B+Ouk3KHGAU4GJV4eBsMC0OFWBPLiitzDzFKcjApifKWTgEK8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuHt3AqU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0t
	SC2CycpwcChJ8M4EaRQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8
	QHtXg+0tLkjMBYpCtJ5iVJQS520DSQiAJDJK8+DGwhLXK0ZxoC+FeeVAqniASQ+u+xXQYCag
	wddZC0AGlyQipKQaGC2vfAtUP63Y9i7uU4aIhKbXyc9Bxuc2MWzkMZqm/Pzo3pTNn18sl76W
	Fd/AXuTVE9rDf3BZacURm5nnyxiY/VM/3+RbN01Euub+9Hvbb7e/bJzIEs/qdIpf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270839>

On 05/25/2015 08:38 PM, brian m. carlson wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> They were never used.
> [...]

I happened to dig into the background of this change a little more, and
this is what I found out.

When deleting remote-tracking references, we used to record the old_sha1
of each reference we found, and when deleting it verify that the
recorded old_sha1 still agrees with the current value.

Later,

    c9e768b remote: repack packed-refs once when deleting multiple refs
(2014-05-23)

optimized this code to delete all of the packed refs at once, then
delete the loose references one by one. That patch changed how
delete_ref() was called, no longer passing it the old_sha1 value (and
thus removing the verification step).

That commit doesn't give a justification for the change, but I can
imagine what it would have been:

* Now that the packed refs and loose refs disappear at different times,
it would be awkward to check the old_sha1s
* We want to delete the references anyway, and they are remote-tracking
references (which shouldn't have any interesting local modifications),
so the protection is not really useful anyway.

I think that the change in c9e768b was OK, but I wanted to get this
backstory out there in case anybody thinks that instead of removing the
code to set "util", we should be re-adding the code that made use of
"util" to verify the references' old values before deleting them.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
