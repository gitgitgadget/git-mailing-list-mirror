From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during checkout.
Date: Thu, 12 Mar 2009 11:23:24 +0100
Message-ID: <49B8E29C.5080107@nokia.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: ext Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhi5v-0003n1-Qq
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZCLKX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbZCLKX2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:23:28 -0400
Received: from hoat.troll.no ([62.70.27.150]:36221 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbZCLKX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:23:27 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1540620FE7;
	Thu, 12 Mar 2009 11:23:25 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 061CD21197;
	Thu, 12 Mar 2009 11:23:25 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2CANOJT019672;
	Thu, 12 Mar 2009 11:23:24 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 12 Mar 2009 11:23:24 +0100 (CET)
In-Reply-To: <49B8DD1D.3060908@viscovery.net>
References: <1236850575-27973-3-git-send-email-kristian.amlie@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113037>

ext Johannes Sixt wrote:
> Kristian Amlie schrieb:
>> We do this by popping off elements on the attribute stack, until we
>> reach the level where a new .gitattributes was checked out. The next
>> time someone calls git_checkattr(), it will reconstruct the
>> attributes from that point.
> ...
>> +	gitattrlen = strlen(GITATTRIBUTES_FILE);
>> +	pathlen = strlen(path);
>> +	if (!strncmp(path + pathlen - gitattrlen, GITATTRIBUTES_FILE, gitattrlen)) {
>> +		/* Invalidate attributes if a new .gitattributes file was checked out. */
> 
> But if there was file .abc.txt that was checked out before .gitattributes
> was checked out, then the new .gitattributes won't have been used for
> .abc.txt, yet, right?

You're right, that fails.

I'm guessing my initial patch (and testcase) works because the sorting
is alphabetical and .gitattributes happens to be checked out before
files with letters. I would need to make sure that .gitattributes gets
checked out first.

--
Kristian
