From: Timur Tabi <timur@freescale.com>
Subject: Re: git-send-email --suppress-from option doesn't work.
Date: Thu, 25 Jan 2007 10:47:32 -0600
Organization: Freescale
Message-ID: <45B8DF24.6080001@freescale.com>
References: <45AFE18C.2020303@freescale.com> <45B01DD4.7000204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7ll-0002LJ-3S
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbXAYQsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbXAYQsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:48:09 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:64965 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030351AbXAYQsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:48:08 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l0PGldxh015440;
	Thu, 25 Jan 2007 09:47:39 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0PGlWE6006975;
	Thu, 25 Jan 2007 10:47:38 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
In-Reply-To: <45B01DD4.7000204@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37738>

Andreas Ericsson wrote:

> 
> I believe
> 
> 	(/^(Cc|From):[^<]+<([^>])+>.*$/)
> 
> would do the trick for your case. It would however fail when specifying a proper
> --from address in the 'git commit --author="Foo Barson <foo@barson.com>"' style.

Even so, it would still be very picky about the layout.  --suppress-from should 
just compare the actual email addresses, not the names or any other characters.

> Are you sure you need to specify --from for those patches though?

Yes.  If I don't specify --from, then git-send-email will prompt me for the 
From: address.  I want git-send-email to be completely non-interactive.

>> Some of you might say at this point, "Why don't you  just specify --from
>> "Timur Tabi <timur@freescale.com>"?  I tried that, and it still doesn't
>> work.
> 
> That sounds extremely odd indeed. Could this have to do with character
> conversion?

Actually, I figured out the problem is that I can't do this:

FROM='--from "Foo Barson <foo@barson.com>"'
git-send-email $FROM ...

I got all sorts of weird messages about unbalanced > or something.  Instead, I 
need to do this:

FROM="Foo Barson <foo@barson.com>"
git-send-email --from $FROM ...

This is probably a shell issue instead of a git-send-email issue, but it is 
annoying.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
