From: greened@obbligato.org (David A. Greene)
Subject: Re: Detecting redundant commits
Date: Thu, 07 Jan 2016 21:14:22 -0600
Message-ID: <87d1tcyd81.fsf@waller.obbligato.org>
References: <nngtwmtwd2q.fsf@lnx-dag.us.cray.com>
	<20160105040026.GB22620@sigill.intra.peff.net>
	<49661552-EBD9-4F45-9F31-54B217AE3350@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 04:14:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHNVb-0001nt-OB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 04:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbcAHDOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 22:14:31 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51228 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753939AbcAHDOa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 22:14:30 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aHNWT-0007tN-0H; Thu, 07 Jan 2016 21:15:29 -0600
In-Reply-To: <49661552-EBD9-4F45-9F31-54B217AE3350@obbligato.org> (David
	Greene's message of "Tue, 05 Jan 2016 10:31:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283526>

David Greene <greened@obbligato.org> writes:

> On January 4, 2016 10:00:26 PM CST, Jeff King <peff@peff.net> wrote:
>
>>Or do you mean commits that, when applied, we find turn out to have
>>empty changes (e.g., because we have a set of commits that have
>>different patch-ids, but do roughly the same thing)? I don't think you
>>can find that with a straight end-to-end diff. You have try to apply
>>and then look at the result. I think we already catch that case (see
>>--allow-empty), though I think the only options are "preserve" or
>>"abort", not "silently skip" (and it sounds like the latter is what
>>you would want).
>
> This.  I see where --allow-empty is handled in prepare_to_commit but
> it is not so easy to skip the commit at that point due to state
> changes.  I was trying to avoid going into commit at all by
> determining ahead of time whether the commit would become empty.  Any
> ideas?

I ended up trying index_differs_from("HEAD", 0) and that actually seems
to work.  Unfortunately, it caused a regression and I'm having trouble
figuring out why.  The code should not even activate without a new
option specified.  If I get it working I'll send a patchset for comment.
Point me another direction if I'm way off track.  :)

                       -David
