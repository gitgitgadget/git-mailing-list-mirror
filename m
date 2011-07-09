From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Fri, 8 Jul 2011 17:42:38 -0700
Message-ID: <CAJo=hJv3_-G3w+jREONFJyXp1HtDfNcUv17RfGvzziNJUZ=_pA@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com> <7vfwmgfkzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 09 02:43:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfLdT-0004TH-MR
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 02:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab1GIAnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 20:43:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55162 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1GIAm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 20:42:59 -0400
Received: by bwd5 with SMTP id 5so2101281bwd.19
        for <git@vger.kernel.org>; Fri, 08 Jul 2011 17:42:58 -0700 (PDT)
Received: by 10.205.65.200 with SMTP id xn8mr605001bkb.316.1310172178179; Fri,
 08 Jul 2011 17:42:58 -0700 (PDT)
Received: by 10.204.165.130 with HTTP; Fri, 8 Jul 2011 17:42:38 -0700 (PDT)
In-Reply-To: <7vfwmgfkzo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176813>

On Fri, Jul 8, 2011 at 15:47, Junio C Hamano <gitster@pobox.com> wrote:
> This updates the codepath to write commit objects so that when a commit is
> emitted, its parents are scheduled to be output next (but this does not go
> recursively), in the hope that it may help a typical "rev-list" traversal.
>
> I've tried various workloads from the previous message; while this patch
> does not regress any of them significantly, it does not seem to improve
> them significantly, either.

I'll have to do some more testing then... I feel like this improves
things when the underlying storage has higher latency than 0 (aka cold
cache, or NFS). But its good to hear this didn't make the workloads
worse. :-)

-- 
Shawn.
