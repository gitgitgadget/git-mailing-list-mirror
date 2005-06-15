From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [COGITO PATCH] Optimized print_help()
Date: Wed, 15 Jun 2005 20:58:55 +0200
Message-ID: <42B07A6F.3000001@lsrfire.ath.cx>
References: <1118791576.3890.4.camel@dv>  <20050615000001.GB17152@diku.dk> <1118795583.3890.27.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 20:55:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Did1W-0004an-MJ
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 20:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFOS7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFOS7G
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 14:59:06 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:36793 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261276AbVFOS7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 14:59:02 -0400
Received: from [10.0.1.3] (p508E365A.dip.t-dialin.net [80.142.54.90])
	by neapel230.server4you.de (Postfix) with ESMTP id 584021A6;
	Wed, 15 Jun 2005 20:59:00 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1118795583.3890.27.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin schrieb:
>>> +	cat $toolpath | sed -n '3,/^$/s/^# *//p'
>> 
>> What about also removing UUOC from this line ...
> 
> 
> UUOC?  I had too look it up :-)
> 
> It's not just "useless use of cat", but also useless use of
> redirection in both cases.  I guess sed can exit after it finishes
> processing the range (I don't know if it actually does), so feeding
> it the whole file is not need.

It doesn't matter if the shell opens the file or if sed does it itself,
sed's ability to close the file and quit when done doesn't depend on
that.  So this call is equivalent and has the advantage of being
resistant against filenames starting with a "-":

   sed -n '3,/^$/s/^# *//p' <"$toolpath"

Rene
