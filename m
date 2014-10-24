From: Robert de Bath <robert@tvisiontech.co.uk>
Subject: Re: [PATCH] Expand on impact of threads on memory consumption.
Date: Fri, 24 Oct 2014 17:51:15 +0000
Message-ID: <3F70E0BBE32F764BA89060B84135BD471850D9E1@TVTEX10.tvt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 20:12:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhjLD-0006iD-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 20:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbaJXSLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 14:11:54 -0400
Received: from mail.tvisiontech.co.uk ([81.143.168.209]:39510 "EHLO
	mail.tvisiontech.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653AbaJXSLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 14:11:53 -0400
X-Greylist: delayed 1234 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Oct 2014 14:11:53 EDT
Received: from mail by mail.tvisiontech.co.uk with filter-scanned (Exim 4.72 #1 (Debian))
	id 1Xhj1B-0004WI-Jy; Fri, 24 Oct 2014 18:51:17 +0100
Received: from tvtex10.local (TVTEX10.tvt.local) [10.13.74.10]:47430 
	by mail.tvisiontech.co.uk with esmtp (Exim 4.72 #1 (Debian))
	id 1Xhj1A-0004VP-CH; Fri, 24 Oct 2014 18:51:16 +0100
Received: from TVTEX10.tvt.local ([fe80::688d:a43c:5f53:abf2]) by
 TVTEX10.tvt.local ([fe80::688d:a43c:5f53:abf2%11]) with mapi id
 14.03.0210.002; Fri, 24 Oct 2014 18:51:16 +0100
Thread-Topic: [PATCH] Expand on impact of threads on memory consumption.
Thread-Index: AQHP77Mb3jwumaeqbEiG7Hv3OKa2Zg==
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.74.1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ... text unnecessarily opaque ...
Yes, that's quite likely. 
However, I think you should continue to have a similar form to the previous 'pack.window' and 
'pack.depth' descriptions... perhaps:

    The maximum size of memory that is consumed by each
    thread in linkgit:git-pack-objects[1] for pack window memory
    when no limit is given on the command line.
    The value can be suffixed with "k", "m", or "g".  When left
    unconfigured, there will be no limit.

Though, I suspect the existing wording is trying to avoid saying there's a 'default' and 
another 'default' which would be covered by your rewording.

So I have no real problem either way.

Robert.
 
________________________________________
From: Junio C Hamano [gitster@pobox.com]
Sent: 24 October 2014 18:27
To: Robert de Bath
Cc: git@vger.kernel.org
Subject: [NOTWHITELIST] Re: [PATCH] Expand on impact of threads on memory consumption.

Robert de Bath <rdebath@tvisiontech.co.uk> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..6384038 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1828,7 +1828,10 @@ pack.depth::
>
>  pack.windowMemory::
>       The window memory size limit used by linkgit:git-pack-objects[1]
> -     when no limit is given on the command line.  The value can be
> +     when no limit is given on the command line.  This limit may be
> +     allocated individually by each thread doing delta compression
> +     so the total memory allocated by linkgit:git-pack-objects[1] can
> +     be this multiplied by the number of threads.  The value can be
>       suffixed with "k", "m", or "g".  Defaults to 0, meaning no
>       limit.

I sense that this change makes the resulting text unnecessarily
opaque by avoiding touching the first sentence.  Wouldn't something
more concise like this sufficient?

    The default maximum size of memory that is consumed by each
    thread in linkgit:git-pack-objects[1] for pack window memory.
    The value can be suffixed with "k", "m", or "g".  When left
    unconfigured, there will be no limit.
