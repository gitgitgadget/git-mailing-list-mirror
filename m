From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Tue, 17 Jul 2012 22:52:38 +0200
Message-ID: <1571690.jxJy5HzrPO@flobuntu>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1948960.GdZ6fLVixa@flobuntu> <20120717134820.GE3071@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrElE-0002zT-G2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 22:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab2GQUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 16:52:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52015 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab2GQUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 16:52:43 -0400
Received: by bkwj10 with SMTP id j10so855344bkw.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=9ulrkW56crXMV+5Hk8xGWgueubPlvtBaE1uOnzU+Ezk=;
        b=N6gbKBvGvzFc/tHZlzz9DtP8P5Zj6LUrZdMz7WBit1WyLw/9mOCPkRjNgg7vEhHqlA
         De6Fu9sgw0lH5PZckpTzX5Z/cRHNHP++qR2Qresbg5+YgUTWSZ+jT5AHT3vF5YYdmHpd
         rNhDOjSNRHamcbUoJZIEux5HGLAbdqzKSstCuMDGroRiiMfSm65t7/ku04NyD0LzPZgX
         BVow+0ERK9338ChsIfOQ4q/Qb4WMVaoXcgmWMGUgLo75tHM661WztWgyFFVMaJlbDai7
         E5xA0MmIh/ycbjsTtJYi/kNNE6NwStFBuzxLxrgO7M3jOkT72C/HOuy34E7Lx8uv0AFi
         xZKw==
Received: by 10.204.154.214 with SMTP id p22mr163309bkw.111.1342558361784;
        Tue, 17 Jul 2012 13:52:41 -0700 (PDT)
Received: from flobuntu.localnet (93-82-150-64.adsl.highway.telekom.at. [93.82.150.64])
        by mx.google.com with ESMTPS id t23sm10702903bks.4.2012.07.17.13.52.39
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 13:52:40 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120717134820.GE3071@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201621>

On Tuesday 17 July 2012 08:48:20 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > On Monday 16 July 2012 22:27:25 Jonathan Nieder wrote:
> >> Hm, that still doesn't look right.  The RHS of the refspec is supposed to
> >> be a _private_ namespace for the remote helper, and refs/remotes/ is
> >> not private.
> 
> [...]
> 
> > remote-svn now uses get_fetch_map to retrieve the local refs. So it
> > respects the fetch refspec in the config.
> 
> No no no no no.  That's transport-helper's job.
> 
> The RHS of the remote helper's refspec really is supposed to be
> _private_.  Improvements to the documentation to clarify this would be
> welcome.

So we want the transport-helper to touch only private refs, i.e. some subdir 
of refs/, ok.
On the other hand I thought we expect git-fetch to update the RHS of the 
passed refspec (or the default one ). How?

Btw, whats FETCH_HEAD for?

> 
> Thanks,
> Jonathan

Thanks,
Florian
