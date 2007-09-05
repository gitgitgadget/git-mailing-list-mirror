From: Jonas Berlin <xkr47@outerspace.dyndns.org>
Subject: Re: [PATCH] Fix "cvs log" to use UTC timezone instead of local
Date: Wed, 05 Sep 2007 21:32:08 +0000
Organization: Helsinki University of Technology
Message-ID: <46DF2058.7060405@outerspace.dyndns.org>
References: <11889090932256-git-send-email-xkr47@outerspace.dyndns.org> <alpine.LFD.0.999.0709040612260.3088@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2Tt-0006u9-I8
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbXIEVcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXIEVcI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:32:08 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:51936 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbXIEVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:32:06 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 9DD31C8B1A;
	Thu,  6 Sep 2007 00:32:03 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A028099AAA2; Thu, 06 Sep 2007 00:32:03 +0300
Received: from outerspace.dyndns.org (a88-112-29-101.elisa-laajakaista.fi [88.112.29.101])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 699AA41BFB;
	Thu,  6 Sep 2007 00:32:00 +0300 (EEST)
Received: from [IPv6:2001:14b8:141::] (outerspace [IPv6:2001:14b8:141::])
	by outerspace.dyndns.org (Postfix) with ESMTP id 8148770F57;
	Thu,  6 Sep 2007 00:32:09 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <alpine.LFD.0.999.0709040612260.3088@evo.linux-foundation.org>
X-Enigmail-Version: 0.95.3
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57767>

Quoting Linus Torvalds on 09/04/2007 01:22 PM UTC:
> So instead of turning it back into UTC here, I think git-cvsserver should 
> be changed to ask for the date in the native git format in the first 
> place.

I agree.

My first patch was a minimal-intrusion one to avoid unnecessarily breaking stuff.

I guess at this point it's good to mention that current cvs implementations (at least 1.12.12) produce timestamps of format "yyyy-mm-dd HH:MM:SS +ZZZZ" (i.e. they do include timezone information) while older versions (at least 1.11.22) produce the UTC-only format "yyyy/mm/dd HH:MM:SS" which is currently used by git-cvsserver. Backwards compatibility generally being a good thing, while at the expense of timezone information, I chose to keep the older UTC-only format. Should you prefer to keep the timezone information, I'll update the cvs log format instead. Heck, I could even support both through some configuration option if you really wanted :)

> That can be done various ways:
> 
>  - use the "raw log format" which has dates as seconds-since-UTC (and with 
>    an *informational* timezone thing that should then just be ignored).
> 
>    This is likely the best approach, since anything but this will 

This seems straightforward to implement, so I will go with this.

> For example, I think your patch may fix "cvs log", but I'm seeing some 
> suspiciously similar code in the "cvs annotate" handling, so I suspect 
> that would need it too.

I will make sure this works as well.

-- 
- xkr47
