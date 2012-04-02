From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 2 Apr 2012 17:16:22 -0600
Organization: CAF
Message-ID: <201204021716.22842.mfick@codeaurora.org>
References: <201203291818.49933.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com> <20120402203728.GB26503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	=?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqUG-0007f0-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2DBXQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:16:31 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:17749 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab2DBXQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 19:16:30 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6668"; a="175944021"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Apr 2012 16:16:23 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 705D410004AA;
	Mon,  2 Apr 2012 16:16:23 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20120402203728.GB26503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194578>

On Monday, April 02, 2012 02:37:28 pm Jeff King wrote:
> On Mon, Apr 02, 2012 at 09:51:21AM -0700, Shawn O. Pearce 
wrote:
> > Probably. But we tend to hate caches in Git because
> > they can get stale and need to be rebuilt, and are
> > redundant with the base data. The mythical "pack v4"
> > work was going to approach this problem by storing the
> > commit timestamps uncompressed in a more machine
> > friendly format. Unfortunately the work has been
> > stalled for years.
...

> So it's sort-of a cache, in that it's redundant with the
> actual data. But staleness and writing issues are a lot
> simpler, since it only gets updated when we index the
> pack (and the pack index in general is a similar
> concept; 
...
except that in the case of timestamps, it never even gets 
stale, it simply misses some entries or keeps entries around 
which should go away.  So even if the pack files are rebuilt 
and someone forgets to update the timestamp index, it 
shouldn't cause any problems:  the timestamps which are 
there should still work and likely will still be useful,

-Martin



-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
