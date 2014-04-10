From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: [PATCH v5] Verify index file before we opportunistically update
 it
Date: Thu, 10 Apr 2014 14:57:43 +0300
Message-ID: <20140410115743.GA1446@abyss.utx.wifi>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397108075-30891-1-git-send-email-yiannis.marangos@gmail.com>
 <CACsJy8D9dsxOA6xVmhxa7N20OxEQ1a63rQm6QCtwq9ThG6E3RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 13:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYDcE-0005mT-NC
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 13:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935572AbaDJL5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 07:57:54 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:40790 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935524AbaDJL5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 07:57:53 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so2994450eek.10
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y6zxLdgxdpCGiijxnp0RyNAtprf5NdBtNyzFnTRG2UA=;
        b=irYQy7dVdpIOJ1opDCdbw1iRqMsW1yYYETc8q4HyI2wd201v2bPt+8za0A5M9eO0Vf
         bwqHVA8rW/C6QI70oGg4eYuXeDBgoD1kk1eUwRURFBONM1vRaOnD5zEG9rYY4OUkPhji
         UKV6Zy6tzBOg8QimWEaq3HIfHMit61yCizyh4zoKosSAM3jeOVK2YIefFVlluWV2bfpF
         Zr7Kk6JY3oJNhEpz2e0O4CqX8bpCRSttZdxCQJXk0k2kJ8uHrOGxzj6+o2ngT1u7PKck
         O+ugWoLtJkGqdmgLEudOzEYzCSP3UYhGBdVOUlvYLwFSJGRTsHQYQwJDptwnEynNSRV9
         2yAw==
X-Received: by 10.14.6.1 with SMTP id 1mr2770463eem.71.1397131072296;
        Thu, 10 Apr 2014 04:57:52 -0700 (PDT)
Received: from abyss.utx.wifi ([212.50.123.194])
        by mx.google.com with ESMTPSA id o4sm9430520eef.20.2014.04.10.04.57.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 04:57:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8D9dsxOA6xVmhxa7N20OxEQ1a63rQm6QCtwq9ThG6E3RA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246016>

On Thu, Apr 10, 2014 at 05:40:55PM +0700, Duy Nguyen wrote:
> verify_hdr() is a bit expensive because you need to digest the whole
> index file (could big as big as 14MB on webkit). Could we get away
> without it? I mean, is it enough that we pick the last 20 bytes and
> compare it with istate->sha1? If we only need 20 bytes, pread() may be
> better than mmap().
> 
> The chance of SHA-1 collision is small enough for us to ignore, I
> think. And if a client updates the index without updating the trailing
> sha-1, the index is broken and we don't have to worry about
> overwriting it.

That's true, I will commit version 6 in a bit.
