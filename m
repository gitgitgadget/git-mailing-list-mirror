From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 14:45:16 -0500
Message-ID: <20120328194516.GD8982@burratino>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:45:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyoD-0004qr-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab2C1TpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:45:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59841 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2C1TpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:45:23 -0400
Received: by iagz16 with SMTP id z16so1897865iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IcyfAie/DOtAufsXxUQqrIJQGKwbN07YR9xEKccub10=;
        b=ZdBPvTwrzx/ylvuRhs8yuBH96Uct0m+st/Pm6OhWoSJdhpCj/buabeGwE0wkH75WJQ
         shb1JKtCShrP6msW5kZG3ur1JQquQ+r3jBvV7yWMOSUbmujL8gD/gfo1LIre8OY1VJUp
         DCgD6GKX3k4+oDRxty4uhtsLNC5l4cf3XrwyYPR7GKSIeZui6y1mUnYLdv+ak1L4YrsI
         vSJstZYorvu0KZb4q/wz8jC53nmen7DCxIsrocIJnju2+WAMFv/0dew4a+ofSaQ9wh5a
         T0UTz/cAnd01kH5H7S6/Y0WJc0OeV6+xiXF/0+KPl0eAj8dcG9OgxoWeQcdDhpWL1hrX
         Gx2Q==
Received: by 10.50.192.134 with SMTP id hg6mr247667igc.59.1332963923125;
        Wed, 28 Mar 2012 12:45:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq4sm3869118igc.5.2012.03.28.12.45.22
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 12:45:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120328193909.GB29019@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194174>

Jeff King wrote:

> That's what the patch I posted earlier does. But it means we _also_
> report "permission denied" for inaccessible directories, which is
> needlessly confusing (and much more common, I would think).

So the message could say

	$ nosuch
	nosuch: Permission denied
	hint: A permissions problem was encountered searching for or
	hint: executing that command on the $PATH.
	hint: Check your PATH setting and permissions.

or even

	$ nosuch
	nosuch: No such file or directory or permission denied
