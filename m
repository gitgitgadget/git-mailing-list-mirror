From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 17:51:29 -0600
Message-ID: <20080214235129.GU27535@lavos.net>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com> <alpine.LSU.1.00.0802142334480.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnsS-0000XC-3O
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934803AbYBNXvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbYBNXvf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:51:35 -0500
Received: from mxsf06.insightbb.com ([74.128.0.76]:38170 "EHLO
	mxsf06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760547AbYBNXvd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:51:33 -0500
X-IronPort-AV: E=Sophos;i="4.25,355,1199682000"; 
   d="scan'208";a="235205211"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.124])
  by mxsf06.insightbb.com with ESMTP; 14 Feb 2008 18:51:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAHditEdKhvkY/2dsb2JhbACBWa1a
X-IronPort-AV: E=Sophos;i="4.25,355,1199682000"; 
   d="scan'208";a="156113424"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav00.insightbb.com with ESMTP; 14 Feb 2008 18:51:30 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 2D4B9309F23; Thu, 14 Feb 2008 17:51:30 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802142334480.30505@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73929>

On Thu, Feb 14, 2008 at 11:38:24PM +0000, Johannes Schindelin wrote:
> Heh.  I was too lazy to look up the usage, so I just did what I thought 
> would make sense...
> 
> So here it goes:
> 
> $ git verify-pack -v 
> objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack | 
> ~/git/contrib/stats/packinfo.pl | tee packinfo.txt
>       all sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> 4748.05 median 232 std_dev 221254.37
>  all path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> 4748.05 median 232 std_dev 221254.37
>      tree sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> 4748.05 median 232 std_dev 221254.37
> tree path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
> 4748.05 median 232 std_dev 221254.37
>          depths: count 2477715 total 70336238 min 0 max 250 mean 28.39 
> median 4 std_dev 55.49
> 
> Something in my gut tells me that those four repetitive lines are not 
> meant to look like they do...

Do you by chance have repack.usedeltabaseoffset turned on?  That has the
unfortunate side effect of changing the output of verify-pack -v to be
almost useless for my packinfo script (specifically, it no longer
reports the parent SHA1 hash for deltas, and the script is basically all
about deltra tree statistics.)  I suppose that should probably be fixed,
but I never looked into it.

-bcd
