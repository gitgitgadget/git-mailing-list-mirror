From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 9 Dec 2013 11:06:35 -0800
Message-ID: <20131209190635.GQ29959@google.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
 <20131209151609.GA14841@google.com>
 <52A5FD7A.9030801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	Alexey Borzenkov <snaury@gmail.com>,
	Ren?? Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6AN-0003Y8-VB
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902Ab3LITGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:06:47 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:41697 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab3LITGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:06:42 -0500
Received: by mail-yh0-f46.google.com with SMTP id l109so3013030yhq.19
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DcIzuo04dhg7ptw8mKobtacfXb3BkuniHjtlGN/b+QE=;
        b=WFQLeeInLpZZzxUIaD8Rj1RU6IyuT0kIplJVEM1N25Zryu/xFw+lx4yZRD6uRySiX3
         wCmfL8JCUHhnzF0WkMGhsXlfNlmF2W/aSZ/TrHoNmFf0bVCCkngY0DTQtqIwpzr2/2fm
         RSkfJecR6hmhc+C1Oh+XFAM4gieoSp/r1dUHS47z+0A1EvONOq25VMWTtXdoLSpt7MKZ
         vwdkdiV/R6Tx0zxb3mEiXnbr6ym2Rt6nN6psTAR7RE1zLMxBWVZN8PVucCIjGwVQ++XG
         YrIGihc/VGxR7HUgiKtkTlWC092BIYZPWHy3UM7Mr1Wm1fwgwOi7sRHbBWVMB3WOQ62V
         ytiw==
X-Received: by 10.236.38.74 with SMTP id z50mr8579yha.134.1386615999480;
        Mon, 09 Dec 2013 11:06:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id n48sm17932319yho.24.2013.12.09.11.06.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 11:06:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52A5FD7A.9030801@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239077>

Jens Lehmann wrote:
> Am 09.12.2013 16:16, schrieb Jonathan Nieder:
>> Thomas Gummerer wrote:

>>> git diff --no-index ... currently reads the index, during setup, when
>>> calling gitmodules_config().  In the usual case this gives us some
>>> performance drawbacks,
>>
>> Makes sense.
>
> Hmm, but this will disable the submodule specific ignore configuration
> options defined in the .gitmodules file, no? (E.g. when diffing two
> directories containing submodules)

Yes.  That seems like a good behavior.

"git diff --no-index" was invented as just a fancy version of 'diff
-uR", without any awareness of the current git repository.  That means
that at least in principle, .gitmodules and .gitignore should not
affect it.

[...]
>                               Wouldn't adding a "gently" option (which
> could then warn instead of dying) to gitmodules_config() be a better
> solution here?

I don't think so.

Thanks and hope that helps,
Jonathan
