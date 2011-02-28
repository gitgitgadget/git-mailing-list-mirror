From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 09:25:32 -0800
Message-ID: <20110228172455.GA17278@spearce.org>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
 <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
 <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
 <20110228165827.GB24915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 18:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6qr-0003dR-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 18:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab1B1RZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 12:25:36 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34947 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab1B1RZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 12:25:36 -0500
Received: by iwn34 with SMTP id 34so3278879iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 09:25:35 -0800 (PST)
Received: by 10.42.230.137 with SMTP id jm9mr5289748icb.317.1298913935447;
        Mon, 28 Feb 2011 09:25:35 -0800 (PST)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id xi12sm1846266icb.18.2011.02.28.09.25.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 09:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110228165827.GB24915@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168124>

Jeff King <peff@peff.net> wrote:
>   $ cd linux-2.6
> 
>   $ time git verify-pack \
>       .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.idx
>   real    2m37.338s
>   user    2m35.874s
>   sys     0m1.348s
> 
>   $ time git index-pack --verify \
>       .git/objects/pack/pack-36c50f6082df404c26a699f2702946e0cce6208f.pack
>   real    1m37.208s
>   user    1m36.106s
>   sys     0m1.048s

Not the improvement I had hoped. Your verify-pack ran much more
quickly than the fsck I was seeing that led me to suggest this to
Junio a few weeks ago. But saving a minute is still pretty good.

That index-pack run is basically what we get during clone, so
I don't really expect to improve on that. (However I have been
contemplating that the locality within the pack isn't optimal and
we can do better placement.)

-- 
Shawn.
