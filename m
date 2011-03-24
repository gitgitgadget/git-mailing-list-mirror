From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] show: turn on rename progress
Date: Thu, 24 Mar 2011 16:03:16 -0700
Message-ID: <7v4o6s86kr.fsf@alter.siamese.dyndns.org>
References: <20110323181756.GA17415@sigill.intra.peff.net>
 <20110323181915.GC17533@sigill.intra.peff.net>
 <7vvcz9cyxd.fsf@alter.siamese.dyndns.org>
 <20110324145047.GB16484@sigill.intra.peff.net>
 <7v39mca7hl.fsf@alter.siamese.dyndns.org>
 <20110324174556.GA30661@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:03:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2tZ0-0000Lg-R1
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934329Ab1CXXD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 19:03:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933783Ab1CXXD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:03:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B9C84BD7;
	Thu, 24 Mar 2011 19:05:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0yDbA4hBAHRnq+RpsjtMfjCJzDc=; b=jsJiDu
	imozZsROFtwP5O2rM4DOzerZg2XuQlLh6/pD+fCDXtXruFLz1rN3R7bRKQWQSWjV
	RCCpOVgeOKE9J5ukuLIg++7FjYILr/JfhP3p5iYV80TOCVCKk07nDl0jHVwFMDMb
	Ge6sgMYNL3xbpT04Zv1G3W+2aGxKbHRWt1zw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nhrkdBW/Z6caEqcNA3tzXbYIDLwizvpf
	SDY8E//MWqT+djkAj5WMvT4jvbXB8zCOt5Y+7TarukStOD7ant1YVb5UsPGiB6h8
	r3PlHoljKoObHPvL/Z9DYz+1UOTKYl/mbpHLecXMkTiDvyS3sD7becTyvbp4UuWS
	oJUEX0iFAEQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05CFE4BD6;
	Thu, 24 Mar 2011 19:05:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE9984BD5; Thu, 24 Mar 2011
 19:04:59 -0400 (EDT)
In-Reply-To: <20110324174556.GA30661@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Mar 2011 13:45:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2726B022-566B-11E0-AE16-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169951>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 24, 2011 at 08:00:38AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Wed, Mar 23, 2011 at 02:25:02PM -0700, Junio C Hamano wrote:
>> >
>> > We could also turn it on for "git log" in that case, though it is only
>> > useful if the first commit happens to be the one that is slow.
>> >
>> > I should also turn it on for "git diff". I'll prepare a cleaner series
>> > with that in it, too.
>> 
>> Sounds good, thanks.
>
> Here it is:
>
>   [1/4]: pager: save the original stderr when redirecting to pager
>   [2/4]: progress: use pager's original_stderr if available
>   [3/4]: show: turn on rename detection progress reporting
>   [4/4]: diff: turn on rename detection progress reporting

Thanks, but why does it affect t0101 and many others...?


t/jk/progress-with-pager$ sh t0101-at-syntax.sh -i -v
Initialized empty Git repository in /git/git.git/t/trash
directory.t0101-at-syntax/.git/
expecting success: 
        test_commit one &&
        test_commit two

[master (root-commit) d79ce16] one
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 one.t
[master 139b20d] two
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 two.t
ok 1 - setup

expecting success: 
        check_at @{0} two

--- expect      2011-03-24 22:59:09.000000000 +0000
+++ actual      2011-03-24 22:59:09.000000000 +0000
@@ -1 +1,2 @@
 two
+one
not ok - 2 @{0} shows current
#
#               check_at @{0} two
#
