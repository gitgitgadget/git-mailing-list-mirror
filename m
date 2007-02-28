From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Wed, 28 Feb 2007 23:48:50 +0100
Organization: Dewire
Message-ID: <200702282348.51478.robin.rosenberg.lists@dewire.com>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <200702280013.45598.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.63.0702280101560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 23:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXam-0001OS-Aa
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXB1WrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbXB1WrP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:47:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1545 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbXB1WrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:47:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E039B80339F;
	Wed, 28 Feb 2007 23:42:07 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18453-06; Wed, 28 Feb 2007 23:42:07 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 8378D802E1C;
	Wed, 28 Feb 2007 23:42:07 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0702280101560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41022>

onsdag 28 februari 2007 01:07 skrev Johannes Schindelin:
>>
> Basically, there is no proper way to solve it (other than switching to 
> Linux, but that goes without saying).

> Your solution would fall short if one of the two files is changed. Since 
> they are supposed to be symlinks, the application expects them to be 
> identical, and weird sh*t happens.
As will it when the file contain something completly different than expected. 
Another SCM does copies instead and that works, though it's not very beautiful,
but the checkout "works" 99% of the time, rather than not at all. As you code 
Most apps won't care if the original and the copy are different, but the user may
notice (or not...).

> E.g. if you have a symlink "ln -s Makefile.host Makefile", and a script 
> which changes "Makefile.host", and a subdirectory Makefile accessing the 
> root Makefile, you will not be happy.
If...

> So, any way you go, if you have a repository containing symlinks, and you 
> have an OS which does not support symlinks, you are screwed.
As I said, I've seen the scheme sort of work. I can still work with the checkout, though
not entirely as I would like to work (but that includes the platform too). All tools can 
use a copy, none can use a textfile containing the pointed to file.

> But since we already have a symlink in git.git, and _want_ to compile git 
> on MinGW nevertheless, we should support symlinks _somehow_. Even if that 
> means that advanced usage of symlinks will fail.
> 
> I agree with Johannes here how to go about this partial "support" of 
> symlinks, since I cannot think of any sane way to retain the information 
> (where the symlink points to) in the index.
Don't update the symblink. We know it's a link. You don't want to anyway in your 
non-symlink supporting environment, or add git-ln.

-- robin
