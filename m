From: "Lyons, Roy" <Roy.Lyons@cmegroup.com>
Subject: Re: deletion of branch seems to modify tag as well?
Date: Wed, 5 Jun 2013 15:53:47 +0000
Message-ID: <58EAA08AF8232344ADDB2E31D4996BFD39F27291@SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com>
References: <20130605155124.GB8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 18:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkG8A-0006Ar-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 18:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433Ab3FEQAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 12:00:04 -0400
Received: from hygiene3b.cmegroup.com ([216.255.89.56]:61662 "EHLO
	Hygiene3b.cmegroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab3FEQAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jun 2013 12:00:02 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2013 12:00:02 EDT
X-SBRS-none: None
X-IronPort-AV: E=Sophos;i="4.87,807,1363150800"; 
   d="scan'208";a="14310312"
Received: from unknown (HELO SMAPEXCHIDAG2.prod.ad.merc.chicago.cme.com) ([192.168.13.68])
  by Hygiene3b.cmegroup.com with ESMTP; 05 Jun 2013 10:53:45 -0500
Received: from SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com
 ([fe80::d06:7f7a:9be4:af24]) by SMAPEXCHIDAG2.prod.ad.merc.chicago.cme.com
 ([fe80::3066:ef19:5c4a:594b%18]) with mapi id 14.02.0309.002; Wed, 5 Jun 2013
 10:53:48 -0500
Thread-Topic: deletion of branch seems to modify tag as well?
Thread-Index: AQHOYgEGfMPxR06mwk+XS6sOjmk3WJknmN8A//+s1QA=
In-Reply-To: <20130605155124.GB8664@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.2.130206
x-originating-ip: [10.191.27.15]
Content-ID: <EC41336858D6D94D87FD3C6E0EF36090@cme.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226456>

Excellent response.  I had not even considered that the hook for creating
these tags would be in the mix.

I withdraw my bug report happily :)


Thanks,

Roy Lyons





On 6/5/13 10:51 AM, "Jeff King" <peff@peff.net> wrote:

>On Wed, Jun 05, 2013 at 03:26:18PM +0000, Lyons, Roy wrote:
>
>> $ git push origin :ABRANCHNAME
>> remote: Firing Pre - receive hook
>> remote:
>> remote:
>> remote: Firing Post receive hook
>> remote:
>> remote: Branch is ABRANCHNAME -- not creating Trigger file since this
>>is not _int branch
>> remote: error: Trying to write ref
>>refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363 with nonexistent
>>object 0000000000000000000000000000000000000000
>> remote: fatal: refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363:
>>cannot update the ref
>> To ssh://git@ourgitserver/repositoryname.git
>> - [deleted] ABRANCHNAME
>> 
>> I would not expect this behavior.  Is git attempting to modify the
>> tags associated to the HEAD commit on the branch in addition to the
>> branch?   If so, I would like to consider this a bug report...
>
>I do not think git is doing anything of the sort. The output you see
>above comes from custom hooks on the server. We cannot say for certain
>without seeing the hook's code, but it looks like the post-receive hook
>is trying to create a tag to point to the tip of every push, but whoever
>wrote the hook did not take into account branch deletions (and the fact
>that you cannot create a tag pointing at a deletion).
>
>-Peff
