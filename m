From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Sun, 13 Jul 2008 11:01:29 +0200
Message-ID: <4879C469.4080101@arcor.de>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se> <alpine.DEB.1.00.0807111443280.8950@racer> <4878A442.6020405@arcor.de> <alpine.DEB.1.00.0807121546590.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 11:37:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHy0r-0001US-3o
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 11:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbYGMJgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 05:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYGMJgB
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 05:36:01 -0400
Received: from main.gmane.org ([80.91.229.2]:41911 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbYGMJgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 05:36:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHxzr-0004WB-4U
	for git@vger.kernel.org; Sun, 13 Jul 2008 09:35:59 +0000
Received: from dialin-212-144-219-217.pools.arcor-ip.net ([212.144.219.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 09:35:59 +0000
Received: from mailing_list by dialin-212-144-219-217.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 09:35:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-212-144-219-217.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <alpine.DEB.1.00.0807121546590.8950@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88294>

Johannes Schindelin schrieb:

> I suspected that you run out of space for the cache holding some 
> reconstructed blobs (to prevent reconstructing all of them from scratch).
> 
> [...]
> 
> Okay, "valgrind --tool=massif" to the rescue:
> 
> -- snip --
> MB
> 555.9^                                                            ,  #
> |                                                                 @..#
> ~
> | . :::: ::: ::::: @:: : : :: : :: :@ :@: :@@::@:: :::: @: : @@: :@::# ::
> 0----------------------------------------------------------------------->Gi
>                                                                    32.83
> -- snap --
> 
> [...]
> 
> Now, I do not know the internals of index-pack enough to know if there is 
> a way to cut the memory usage (by throwing out earlier reconstructed 
> blobs, for example, and reconstructing them _again_ if need be), so I 
> Cc:ed Nico and hand the problem off to him.
> 
> I expect this to touch the resolve_delta() function of index-pack.c in a 
> major way, though.

Thank you for the analysis!  As a workaround, I think about splitting
the file.  Can you suggest a proper file size?

Best regards,
Stephan Hennig
