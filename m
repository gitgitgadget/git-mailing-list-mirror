From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-format-patch builtin isn't using git-cherry?
Date: Fri, 23 Jun 2006 14:05:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231357420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 14:05:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtkPf-0003Bl-R8
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFWMFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWFWMFP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:05:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:14242 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964773AbWFWMFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 08:05:13 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9D47E23AF;
	Fri, 23 Jun 2006 14:05:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 90B9523D9;
	Fri, 23 Jun 2006 14:05:12 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 74F972383;
	Fri, 23 Jun 2006 14:05:12 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22411>

Hi,

On Fri, 23 Jun 2006, Martin Langhoff wrote:

> Reading cmd_format_patch() in builtin-log.c, it seems to have lost that 
> magic that made it so useful... :( Can a kind soul that speaks C 
> fluently help me out here?

My fault. But note that it is much faster now, too! I think I can trick it 
back into doing something like the old script, but I'll do that only with 
an option (in order to not slow down the now-common case). And it will 
take a while. So if anybody wants to give it a try...

Basically, it will involve the following recipe:

	- add a DIFF_FORMAT_PATCH_ID
	- calculate _all_ the patch ids in upstream since branch point
	- in cmd_format_patch, in the get_revision() loop, skip those
	  commits which have the same patch id

Ciao,
Dscho
