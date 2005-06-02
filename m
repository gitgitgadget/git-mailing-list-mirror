From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Thu, 02 Jun 2005 17:36:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506021733520.17354@localhost.localdomain>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
 <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
 <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
 <7v3bs07fmu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:38:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdxNS-00055M-8z
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFBVkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFBVkF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:40:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35288 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261439AbVFBVgk
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:36:40 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHH00B47811CR@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Jun 2005 17:36:37 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jun 2005, Nicolas Pitre wrote:

> Here you don't need to call unpack_sha1_rest() at all which would call 
> xmalloc and another memcpy needlessly.  Instead, just use:
> 
> 	memcpy(base_sha1, hdr + strlen(hdr) + 1, 20);
> 
> and you're done.  No need to call an extra free() either.
> 
> And maybe this function should live in delta.c instead?

Forget about my suggestion of moving it to delta.c.  Since it assumes 
knowledge of the object header format it better stay close to the other 
functions in sha1_file.c.


Nicolas
