From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 02 Apr 2015 16:18:22 -0600
Message-ID: <1935847.zk75T7vt7M@mfick1-lnx>
References: <20150302092136.GA30278@lanh> <xmqqr3szql9r.fsf@gitster.dls.corp.google.com> <xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:18:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdnRs-0003rk-HR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 00:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbDBWSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 18:18:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39218 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbDBWSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 18:18:24 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3A35140D3E;
	Thu,  2 Apr 2015 22:18:23 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id A3223140D40; Thu,  2 Apr 2015 22:18:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick1-lnx.localnet (unknown [129.46.10.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BAEA140D3E;
	Thu,  2 Apr 2015 22:18:23 +0000 (UTC)
User-Agent: KMail/4.8.5 (Linux/3.2.0-75-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266689>

> The current protocol has the following problems that limit
> us:
> 
>  - It is not easy to make it resumable, because we
> recompute every time.  This is especially problematic for
> the initial fetch aka "clone" as we will be talking about
> a large transfer. Redirection to a bundle hosted on CDN
> might be something we could do transparently.
> 
>  - The protocol extension has a fairly low length limit.
> 
>  - Because the protocol exchange starts by the server side
> advertising all its refs, even when the fetcher is
> interested in a single ref, the initial overhead is
> nontrivial, especially when you are doing a small
> incremental update.  The worst case is an auto-builder
> that polls every five minutes, even when there is no new
> commits to be fetched.

A lot of focus about the problems with ref advertisement is 
about the obvious problem mentioned above (a bad problem 
indeed).  I would like to add that there is another related 
problem that all potential solutions to the above problem do 
not neccessarily improve.   When polling regularly there is 
also no current efficient way to check on the current state of 
all refs.  It would be nice to also be able to get an 
incremental update on large refs spaces.

Thanks,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
