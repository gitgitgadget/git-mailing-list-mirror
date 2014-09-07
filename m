From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 1/2] Makefile: add check-headers target
Date: Sat, 6 Sep 2014 17:24:48 -0700
Message-ID: <20140907002447.GB15039@gmail.com>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
 <540B7AA0.4050208@web.de>
 <20140906225738.GA15039@gmail.com>
 <20140906235808.GA20625@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 02:25:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQQIH-0002as-2W
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 02:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbaIGAZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 20:25:03 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49264 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaIGAZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 20:25:01 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so18364128pdb.27
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ShR/ual7/bWDzgEAh2Xe5iFumm1XsjOC9f2DpeLxkuI=;
        b=V2j7cm4MMBc/Zx99cm6qFwEYm6PaPiSFJzUZzkRWzkDb6kE5XislPZMFYf+WN6ivRj
         PohirsT21XcaO6TwbYZRCOm0ZZWBpoIZ5QtIRSoldqnY3JEtZ2TxbwDKkfOFZ1S6vBaU
         u4HmvtiCodz9+t5PO1/jasQI+/XyldWizhmYXV3OLoygop/pztcwx1r0oDmzkvYJ3UAW
         EDoBaB6O9j/+3GAG8cEONOyEhUkXTXgu+RvJlGEcxAnRgK2lZwAxhGqGfUYliYh7KTim
         kCv/JnOVBXNWx9cPwQt9uMMbzIaFf13hFnt7TDv6M5d+q1ZxpEeLhJIm1a99vcIfBuPc
         usNA==
X-Received: by 10.70.34.136 with SMTP id z8mr35026892pdi.39.1410049500736;
        Sat, 06 Sep 2014 17:25:00 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm5292727pdh.56.2014.09.06.17.24.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Sep 2014 17:25:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140906235808.GA20625@peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256607>

On Sat, Sep 06, 2014 at 07:58:09PM -0400, Jeff King wrote:
> On Sat, Sep 06, 2014 at 03:57:39PM -0700, David Aguilar wrote:
> 
> > > This checks all .h files in the top directory.  Would it be better
> > > to check all files in LIB_H instead?  Or even all .h files in the
> > > tree (using "git ls-files '*.h'")?  The latter might be difficult
> > > because some of the files in compat/ #include system-specific
> > > headers.
> > 
> > Ah, I hadn't thought of using LIB_H; that might be the most
> > practical solution.
> 
> Maybe not; see d85b0dff7297fb43a57a0c1e697417bb7723247c, which is in
> 'next'.

Thanks for the heads-up. I'll send v2 now which will basically use
the original approach plus a few extra paths so that we catch xdiff/,
vcs-svn, and ewah/.

Widening any more (e.g. it would be nice to say compat/*.h too) breaks
it due to platform-specific includes so it seems good enough for catching
the main cross-platform headers.
-- 
David
