From: bdowning@lavos.net (Brian Downing)
Subject: Re: Reducing the memory footprint
Date: Fri, 9 Nov 2007 18:53:27 -0600
Message-ID: <20071110005327.GH6212@lavos.net>
References: <9e4733910711091538h260fbcd2s5783f01e7db4b19a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqeba-0000sn-9R
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbXKJAxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbXKJAxa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:53:30 -0500
Received: from mxsf05.insightbb.com ([74.128.0.75]:20855 "EHLO
	mxsf05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbXKJAx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:53:29 -0500
X-IronPort-AV: E=Sophos;i="4.21,397,1188792000"; 
   d="scan'208";a="108983016"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf05.insightbb.com with ESMTP; 09 Nov 2007 19:53:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAH+PNEdKhvkY/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,397,1188792000"; 
   d="scan'208";a="157401158"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 09 Nov 2007 19:53:28 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id BDD8D309F22; Fri,  9 Nov 2007 18:53:27 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <9e4733910711091538h260fbcd2s5783f01e7db4b19a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64293>

On Fri, Nov 09, 2007 at 06:38:00PM -0500, Jon Smirl wrote:
> I'm using this config file:
> 
> [pack]
>         windowMemory = 1M
>         deltaCacheSize = 1M
> 
> And I have NO_MMAP compiled in.
> 
> git is still using over 200MB of memory or address space, my process
> gets killed either way.

I'm assuming it's dying on repacking since you included the pack
parameters.

How big is your biggest object?  Even with pack.windowMemory, it still
keeps the last object around to try and delta against (in other words,
the window only shrinks to size 1), which means you have to have room
for it and its delta index.

-bcd
