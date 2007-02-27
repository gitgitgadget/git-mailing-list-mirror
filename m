From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Wed, 28 Feb 2007 00:13:45 +0100
Organization: Dewire
Message-ID: <200702280013.45598.robin.rosenberg.lists@dewire.com>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBUX-0000N4-W2
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbXB0XMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXB0XMO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:12:14 -0500
Received: from [83.140.172.130] ([83.140.172.130]:22314 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbXB0XMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:12:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5E2B680339E;
	Wed, 28 Feb 2007 00:07:08 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05504-05; Wed, 28 Feb 2007 00:07:08 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 10EE4802809;
	Wed, 28 Feb 2007 00:07:06 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <11726125012895-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40839>

tisdag 27 februari 2007 22:41 skrev Johannes Sixt:
> 
> Here is a small patch series that adds a configuration variable 
core.symlinks.
> From the manual:
> 
> core.symlinks::
> 	If false, symbolic links are checked out as small plain files that
> 	contain the link text. gitlink:git-update-index[1] and
> 	gitlink:git-add[1] will not change the recorded type to regular
> 	file. Useful on filesystems like FAT that do not support
> 	symbolic links. True by default.

How useful is that? The problem is that those links won't work so the checkout 
will be broken. Creating copies would be less broken since the "links" could 
still be used. It should be possible to use the index to see which file is an 
original and which is a symblink, provided both are in the same repository.
Then maybe fall back to this approach if the symlink target cannot be 
resolved.

I'm not sure how people use symbolic links in git, but I'd imagine they 
typically point to a file  in the same repository.

-- robin
