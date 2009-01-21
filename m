From: Anders Waldenborg <anders@0x63.nu>
Subject: Re: What about allowing multiple hooks?
Date: Wed, 21 Jan 2009 22:30:13 +0100
Message-ID: <497793E5.7090107@0x63.nu>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost> <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org> <4977872E.70901@0x63.nu> <alpine.DEB.1.00.0901212206430.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkgI-0005nG-Ij
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbZAUVav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbZAUVau
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:30:50 -0500
Received: from phlox.netintact.se ([217.73.97.18]:60966 "EHLO
	phlox.netintact.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZAUVat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:30:49 -0500
Received: by phlox.netintact.se (Postfix, from userid 56643)
	id 8D008DE063A; Wed, 21 Jan 2009 22:30:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on phlox
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=5.0 tests=none autolearn=failed 
	version=3.1.7-deb
Received: from hoth.proceranetworks.com (hoth.proceranetworks.com [194.153.91.41])
	by phlox.netintact.se (Postfix) with ESMTP id 2E304DE0660;
	Wed, 21 Jan 2009 22:30:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by hoth.proceranetworks.com (Postfix) with ESMTP id 1068845F0005;
	Wed, 21 Jan 2009 22:30:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at hoth.proceranetworks.com
Received: from hoth.proceranetworks.com ([127.0.0.1])
	by localhost (hoth.proceranetworks.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2kzrahNqbdH; Wed, 21 Jan 2009 22:30:43 +0100 (CET)
Received: from [10.13.37.146] (81-233-4-40-no34.tbcn.telia.com [81.233.4.40])
	by hoth.proceranetworks.com (Postfix) with ESMTP id 6A3DD45F0003;
	Wed, 21 Jan 2009 22:30:43 +0100 (CET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <alpine.DEB.1.00.0901212206430.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106679>

Johannes Schindelin wrote:
>> I currently use configvalues to specify which hooks to run. For example 
>> this is how my post-receive looks:
>>
>> data=$(cat)
>> git config --get-all hooks.post-receive.hook | while read hook; do
>>         $hook <<__EOF__
>> "$data"
>> __EOF__
>> done
> 
> I wonder why you don't do the obvious thing:


Because I wanted to be able to do things like this:

git config -add hooks.post-receive.hook \
  "sh hooks/buildbot 192.168.99.9:9989"
git config -add hooks.post-receive.hook \
  "sh hooks/buildbot 192.168.99.9:9988"

So, the thing I initially wanted to solve was "multiple instances" of 
the same hook.

Then when I found this thread I saw that the richer meta information 
needed to implement multiple hooks with sane semantics could be done 
with the config values.

  anders
