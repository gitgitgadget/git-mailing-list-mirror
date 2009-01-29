From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Thu, 29 Jan 2009 22:57:43 +0200
Message-ID: <a891e1bd0901291257t774af061s84497cde8f4bf61c@mail.gmail.com>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
	 <7vk58fm8x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 21:59:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSdyh-0001ce-C0
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 21:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZA2U5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 15:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZA2U5q
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 15:57:46 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:50388 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZA2U5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 15:57:45 -0500
Received: by ey-out-2122.google.com with SMTP id 25so42513eya.37
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 12:57:43 -0800 (PST)
Received: by 10.86.92.4 with SMTP id p4mr289391fgb.36.1233262663167; Thu, 29 
	Jan 2009 12:57:43 -0800 (PST)
In-Reply-To: <7vk58fm8x2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107729>

Hi,

I started incorperating your feedback but before I send a new patch I
have several questions about the trickier bits:

2009/1/28 Junio C Hamano <gitster@pobox.com>:

>  * The placement of this misses the case where a merge of two unrelated
>   histories is attempted.  You would need to also have a check at "No
>   common ancestors found. We need a real merge." part.

Won't that fall through? The if (!common) is above, and this is
eventually an else if for it (see line 978)

> The octopus
>   codepath could also end up with a fast forward or up-to-date.

So this case is obviously more convoluted... If an octopus merge is
chosen should it just pass --ff-only to git-merge-octopus? Or maybe it
should always pass --ff-only and the various different strategies
would just die unconditionally?
