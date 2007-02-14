From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-unbundle - unbundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 15:57:12 -0500
Message-ID: <45D377A8.1080404@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <11714622293142-git-send-email-mdl123@verizon.net>
 <20070214194537.GD28290@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRDb-00016B-KR
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXBNU7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXBNU7G
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:59:06 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:36992 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXBNU7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:59:04 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00A6E0VCEC12@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 14:57:14 -0600 (CST)
In-reply-to: <20070214194537.GD28290@spearce.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39744>

Shawn O. Pearce wrote:
> Mark Levedahl <mdl123@verizon.net> wrote:
>   
>> +# get the objects
>> +unzip -p "$bfile" .gitBundlePack | git-unpack-objects
>>     
>
> Since you are transporting a packfile by sneakernet it might
> be reasonable to assume this transfer happens infrequently.
> Consequently we might assume its object count exceeds
> transfer.unpackLimit, which means a standard fetch or push would
> have kept the packfile rather than unpacking it to loose objects.
>
> So maybe use git-index-pack here to index the packfile and
> retain it as-is, rather than unpacking it?
>
>   
Many of my uses of this result in 10-20 objects being transferred, so 
I'm not sure keeping each pack is a real benefit. In particular, one use 
is for daily updates between two sites via email where we tend to have a 
lot of extra objects in the packs as we assume that not every bundle 
actually gets applied, while the number of real new objects tends to be 
small. On the other hand, given the manual nature of this operation, we 
could always just follow up with repack -a -d, possibly guarded by a git 
count. Thoughts?

Mark
