From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Archiving tags/branches?
Date: Mon, 20 Oct 2008 19:53:43 -0700
Message-ID: <48FD4437.1080504@pcharlan.com>
References: <48F93F52.4070506@pcharlan.com> <200810181532.59883.johan@herland.net> <48FC26DA.10508@pcharlan.com> <200810200953.45339.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 04:54:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks7Ob-0005m4-VH
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 04:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYJUCxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 22:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYJUCxq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 22:53:46 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:38562 "EHLO
	swarthymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752256AbYJUCxp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 22:53:45 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a7.g.dreamhost.com (Postfix) with ESMTP id 8A014DE573;
	Mon, 20 Oct 2008 19:53:44 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <200810200953.45339.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98755>

Johan Herland wrote:
> On Monday 20 October 2008, Pete Harlan wrote:
>> Johan Herland wrote:
>>> BTW, the best way IMHO to archive old refs is to clone your repo (with
>>> all tags/branches) to a backup disk, and then regularly push (git push
>>> --all && git push --tags) your new tags/branches to this backup. You
>>> are now free to delete these tags/branches from your work repo (they
>>> will not be deleted from the backup unless you use "git push
>>> --mirror"). And if you ever need to retrieve an old tag/branch, it's
>>> just a matter of pulling it from the backup repo. Nice, clean,
>>> flexible, and requires no changes to git.
>>>
>>>
>>> Have fun! :)
>>>
>>> ...Johan
>> Hi,
>>
>> Thank you; that indeed seems to work and solves the problem of managing
>> refs/archived-tags manually.
>>
>> Using a secondary repo solely to overcome a flat tag/branch namespace
>> feels hackish.  Perhaps git will benefit someday from work in this area,
>> but until I come up with a patch your suggestion should work fine.  Just
>> knowing I didn't overlook an existing feature helps a lot.
> 
> From reading your other emails, I get the feeling that I'm in a similar 
> situation at $dayjob (i.e. converting ~9 years of development history from 
> CVS to Git). We have literally tens of thousands of tags (mostly build and 
> release tags) in some of our repos, and keeping all these tags in our daily 
> work repos is simply unwieldy and impractical. We therefore plan to have 
> official reps which only contain the most important tags, and 
> have "archive" repos in a different location that contain all the other 
> tags.

Another solution that may work for me is to bind the old lines of
development together using the merge strategy "ours" to link them in a
chain.  When I first read about "ours" I thought it only has evil
applications, but it seems to be created for just this sort of tying
together development that is actually, but was not historically, linked.
 Making those tags reachable from current heads would allow stashing
them in a versioned file somewhere without cluttering up the real
tags/branches or requiring a separate repo.

> You seem to want to keep all your tags in the work repo, but in a 
> separate/hidden namespace, so that they don't clutter the default tag 
> listings. IMHO, once you get into thousands of tags, cloning and other 
> operations where all refs are synchronized become annoyingly slow (although 
> things are certainly somewhat better in v1.6). At that point, my only 
> advice is to keep the lesser-used tags in separate repos, and pull each ref 
> into your work repos on-demand, especially when most of these tags will 
> probably never be referenced.

The efficiency issue is one I hadn't considered; thanks.

--Pete
