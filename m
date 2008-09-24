From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 13:25:06 +0200
Message-ID: <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
	 <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
	 <20080923165247.GO21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 13:26:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiSVh-0007NU-3L
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 13:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYIXLZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 07:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYIXLZL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 07:25:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:51555 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYIXLZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 07:25:09 -0400
Received: by wr-out-0506.google.com with SMTP id 69so935925wri.5
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9mIrqrQgFSRFCRQ+NKrpoCkl9hfURDQ7S1qIbRBTX7w=;
        b=SC7HXSp8Y0/hAi3YF2xJyMgyqlTacuxaVvnAsWGzI0Bft2SXKjSVXO4XRv1HuualIk
         p/Go0JbEa1XGd+YM0IsNS/HUebEIr4U7TPzkvXFcsMSbjBIFYrkgGVN3LAl7VHiSJGy3
         46ac6mCXA3PvVya7jIItX4E+Jz8w/slmdbrXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ULb4KlY8erVK7ppDIZBal2TMTl4JR+nzRppPI8kCVxoWuEn3TAa3DofAl6d1qVLBVJ
         SPmnAPhz6O8vOw3k0Qh3hGOJM9Grzf4zWihZhV4dQ3JGf8wgCY3KjwUVoOlOIA4lr9NR
         eBTWCihd32iHIN0Q09iZWNlzyX31hwIGDHEcA=
Received: by 10.151.141.16 with SMTP id t16mr10849633ybn.167.1222255506281;
        Wed, 24 Sep 2008 04:25:06 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 04:25:06 -0700 (PDT)
In-Reply-To: <20080923165247.GO21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96630>

2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:
> On Tue, Sep 23, 2008 at 04:37:14PM +0200, Alex Riesen wrote:
>> 2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:
>> >
>> > This fast mode works only for relative paths. It is assumed that the
>> > whole repository is located inside one directory without using Cygwin
>> > mount to bind external paths inside of the current tree.
>>
>> Why runtime conditional? Why conditional at all?
>
> I thought that in rather unusual circumstances (such as using Cygwin
> mount to connect separately directories in one tree), this fast version
> may not work. So, I made it conditional. It is runtime conditional,
> because most users do not build Git themselves but install a ready
> Cygwin package.

So? How about make the fast version _always_ work? We don't seem
to fallback to copy+unlink everytime the POSIX rename fails.

Besides it will remove your setup code, which looks bigger and provoked
more discussion than the real subject itself.
