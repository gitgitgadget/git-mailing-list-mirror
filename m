From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3 v2] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 21:22:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804232122260.20267@eeepc-johanness>
References: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness> <1208981890-758-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:23:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JolVL-0005Ms-8W
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYDWUXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 16:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYDWUXA
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 16:23:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752211AbYDWUW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 16:22:59 -0400
Received: (qmail invoked by alias); 23 Apr 2008 20:22:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 23 Apr 2008 22:22:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183pIQUtLc3ED0v/rDW7n3U2s7R+TbFuKA6MtuHXg
	mHedzHBHCCCaor
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1208981890-758-1-git-send-email-apenwarr@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80259>

Hi,

On Wed, 23 Apr 2008, Avery Pennarun wrote:

> From: Jeff King <peff@peff.net>
> 
> This patch allows
> 
>   git filter-branch --blob-filter 'tr a-z A-Z'
> 
> However, it's _still_ horribly slow. Shell script is nice and flexible,
> but running a tight loop like this is just painful. I suspect
> filter-branch in something like perl would be a lot faster and just as
> flexible.
> 
> It is still much better performance than a tree filter, though:
> 
>   $ cd git && time git filter-branch --tree-filter '
>       find . -type f | while read f; do
>         tr a-z A-Z <"$f" >tmp
>         mv tmp "$f"
>       done
>     ' HEAD~10..HEAD
> 
>   real    4m38.626s
>   user    1m32.726s
>   sys     2m51.163s
> 
>   $ cd git && git filter-branch --blob-filter 'tr a-z A-Z' HEAD~10..HEAD
>   real    1m40.809s
>   user    0m36.822s
>   sys     1m14.273s
> 
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks, I really appreciate it.

Ciao,
Dscho
