From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 00:07:39 +0100
Message-ID: <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	 <20070107163112.GA9336@steel.home>
	 <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 00:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4mYF-0006fL-3V
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 00:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbXAJXHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 18:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbXAJXHm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 18:07:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:25397 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226AbXAJXHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 18:07:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so259497uga
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 15:07:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VkdCYOacpX+m+IFHB+Ic26yTjBZnKLNPy6RGOMlZ9dVEWMgLiaF/mEbetVI1pdEjhJ5SeCqGMQYKk8FqM6N5ABJGhibL5WGoHt+eBKaBiMlNT/owzG/0WFCYlwp3dddIsguWiCFTIe9zuku+O4mLm+EyEDMnprnepsk8MlzLqD0=
Received: by 10.78.171.20 with SMTP id t20mr291139hue.1168470459927;
        Wed, 10 Jan 2007 15:07:39 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 15:07:39 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36536>

On 1/10/07, Junio C Hamano <junkio@cox.net> wrote:
> This comes on top of yours.
>
> I'm reproducing all the merges in linux-2.6 history to make sure
> the base one, yours and this produce the same result (the same
> clean merge, or the same unmerged index and the same diff from
> HEAD).  So far it is looking good.

Yep. Tried the monster merge on it: 1m15sec on that small laptop.

For whatever reason your patch left an "if (cache_dirty) flush_cache()",
that's after my patch + yours. Had it removed.
