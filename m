From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] basic threaded delta search
Date: Thu, 06 Sep 2007 08:19:42 +0200
Message-ID: <85ps0wfh8h.fsf@lola.goethe.zz>
References: <11890591912193-git-send-email-nico@cam.org>
	<11890591923123-git-send-email-nico@cam.org>
	<11890591923270-git-send-email-nico@cam.org>
	<1189059193250-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAiT-0002xg-B8
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197AbXIFGTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757080AbXIFGTo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:19:44 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43223 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754897AbXIFGTo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 02:19:44 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 1C9D917F915;
	Thu,  6 Sep 2007 08:19:43 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 1067C114459;
	Thu,  6 Sep 2007 08:19:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id E43DC35E6AB;
	Thu,  6 Sep 2007 08:19:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 76AB41CAD71B; Thu,  6 Sep 2007 08:19:42 +0200 (CEST)
In-Reply-To: <1189059193250-git-send-email-nico@cam.org> (Nicolas Pitre's message of "Thu\, 06 Sep 2007 02\:13\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57830>

Nicolas Pitre <nico@cam.org> writes:

> this is still rough, hence it is disabled by default.  You need to compile
> with "make THREADED_DELTA_SEARCH=1 ..." at the moment.
>
> Threading is done on different portions of the object list to be
> deltified. This is currently done by spliting the list into n parts and
> then a thread is spawned for each of them.  A better method would consist
> of spliting the list into more smaller parts and have the n threads
> pick the next part available.

In my experience, the worst performance hit happens when the real
memory is exhausted and things start paging.  Threading on different
portions of the object list is going to exacerbate the problem in the
areas where it hits worst.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
