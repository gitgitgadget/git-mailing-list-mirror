From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Newbie question:  equiv of:  cvs co -p <filename>  ?
Date: Wed, 10 Aug 2005 00:18:42 +0200
Message-ID: <42F92BC2.20406@lsrfire.ath.cx>
References: <ddb8vl$ifq$1@sea.gmane.org> <Pine.LNX.4.63.0508100009210.10311@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Ellson <ellson@research.att.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 00:20:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2cQi-0007Vq-SP
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 00:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVHIWSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVHIWSi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 18:18:38 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:20905 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S965003AbVHIWSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 18:18:37 -0400
Received: from [10.0.1.3] (p508E758F.dip.t-dialin.net [80.142.117.143])
	by neapel230.server4you.de (Postfix) with ESMTP id AB9C1327;
	Wed, 10 Aug 2005 00:18:35 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508100009210.10311@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Tue, 9 Aug 2005, John Ellson wrote:
>>How can we cat the latest committed state of a file to stdout?
>>
>>I hacked this:
>>
>>	#!/bin/bash
>>	ID=`git-ls-files -s | grep $1 | cut -d ' ' -f 2`
> 
> 
> and now:
> 
> 	git-cat-file blob $ID

Still not pretty.  How about this?

	#!/bin/sh
	git-ls-tree HEAD "$@" | while read mode type hash filename; do
		[ "$type" = "blob" ] && git-cat-file blob "$hash"
	done

Rene
