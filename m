From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are
 checking
Date: Tue, 23 Sep 2014 16:23:43 +0000
Message-ID: <20140923162343.GA20379@debian>
References: <20140923154751.GA19319@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSsd-0001M3-DK
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbaIWQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:23:51 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40986 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbaIWQXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:23:51 -0400
Received: by mail-pd0-f180.google.com with SMTP id r10so6705065pdi.39
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 09:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=28VP8NSMBZMkm0D1uwMCWFAlh/Yk8N2jc1rNVZXpB+k=;
        b=iZW+lkbqxnO0Hu2p9qnvsSpkIek65RZ4lKBm4s2Xg7pw1FfLtjVEs4vMFpgo73C2y+
         7UGVof0wImJFKxVNUU03mjanYKnAb/G8L8Rh3votAFxf+SlAe8U7R7VmKWkTbP31reIK
         N5yjgu71/0NhDhEpRmIlMqfl4gSVjAjF7cFogD/aNz5IqgFCfk/rqmR9v/xprZrX5LaI
         EiIKyCnFz93WyvafNemJb6eADwgL6ODAoI5rwaEb7MryVimfvyNsOWDO+iiYqPlbjfcZ
         jJgRWkBJCO1mAXpSCMDpnevmtTLgzSKI48/m8XRZT4V3q4f4B7S33nqPL7Wq7F8c6mH+
         j/DQ==
X-Gm-Message-State: ALoCoQkpM1dMz50jdWcLJlvZT+Tu/Fc1ufLcJJ/wpX/laP1jNzslQ1vOheGve+uxPQ9C7FwLS9sw
X-Received: by 10.70.127.131 with SMTP id ng3mr1085952pdb.31.1411489430589;
        Tue, 23 Sep 2014 09:23:50 -0700 (PDT)
Received: from debian ([2600:3c01::f03c:91ff:fe73:b980])
        by mx.google.com with ESMTPSA id ou6sm12456784pbb.88.2014.09.23.09.23.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Sep 2014 09:23:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140923154751.GA19319@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257426>

On Tue, Sep 23, 2014 at 11:47:51AM -0400, Jeff King wrote:
> As far as I can tell, fsck's mode-checking has been totally broken
> basically forever. Which makes me a little nervous to fix it. :)
> linux.git does have some bogus modes, but they are 100664, which is
> specifically ignored here unless "fsck --strict" is in effect.

I'm in favor of checking the mode in fsck, at least when --strict.  
But I would suggest we be lax (by default) about other likely-to-exist
but strictly invalid modes to prevent peoples previously workable
repositories from being now broken.

I have, for example, encountered 100775 in the wild, and would argue that
like 100644, it should probably not fail unless we are in --strict mode.

Thanks-
-ed
