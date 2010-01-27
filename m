From: Frans Pop <elendil@planet.nl>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 16:27:44 +0100
Message-ID: <201001271627.45715.elendil@planet.nl>
References: <201001270819.39819.elendil@planet.nl> <201001270936.14935.elendil@planet.nl> <20100127150834.GG9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaA1t-0004ZA-Iy
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 16:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab0A0Pl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481Ab0A0Pl7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 10:41:59 -0500
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:57416 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848Ab0A0Pl6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 10:41:58 -0500
X-Greylist: delayed 850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2010 10:41:58 EST
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML105.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 16:27:46 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20100127150834.GG9553@machine.or.cz>
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 15:27:46.0593 (UTC) FILETIME=[470B8110:01CA9F65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138160>

On Wednesday 27 January 2010, Petr Baudis wrote:
> > Great! If the commit ID is not present that only takes 1 sec versus 11
> > secs for my test. (If the commit _is_ present and fairly recent my
> > test can be faster, but 11 secs delay when it's not present hurts
> > more.)
>
> Isn't something very wrong if grepping the log output is faster than
> simple merge-base call? Can you post exact numbers?

It's only faster if the commit is present very early in the log.
The reason is probably that because of the '-q' option it does not actually 
read the full log, but breaks out as soon as it's found a match.

In my test I had an elapsed time of ~0.5 sec (versus 1 sec for Junio's 
test). And here's a grep for the very first commit:

$ time git log --pretty=format:%H | grep -q 48404cb50b0b547

real    0m0.010s
user    0m0.000s
sys     0m0.012s
