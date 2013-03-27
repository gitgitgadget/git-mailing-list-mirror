From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] attr.c::path_matches(): the basename is part of the pathname
Date: Wed, 27 Mar 2013 08:40:16 +0700
Message-ID: <CACsJy8B63yeC2jTqq9aYU9ajvnaNBey1viQkw=aDJqnTwGn+1g@mail.gmail.com>
References: <20130323083927.GA25600@sigill.intra.peff.net> <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-2-git-send-email-gitster@pobox.com> <20130326184921.GA26462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKfMY-0003al-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab3C0Bkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:40:47 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60713 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab3C0Bkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:40:47 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so8106485oag.25
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jG1LbNdsYffBsIOO/nfeUYTMmIsQgli5UTwrBE1D2mQ=;
        b=Z+siPA/JM4xeinZ+8OqpIAYIwhMkcyJgOYIahraKajoahd5BdZ2mFkjk6GbkUr9Az3
         qYvnKaeJw+dyBbnakMCnklnc2/gGGHKeh0s7cb6j3w5Vjx7noyrs18B8jFwAHvDp9Hd6
         DDHxOmvPttvz91ETZdOY0WQleUCQ7cIUuPlQVflZYXc+qRG1m0rEn3UvaCoO90UsCZCr
         E197Gogi9SfjTXyVlthEmb+I8ZviHtmbCPFElAT/ew0y7nypAGzAAa5UXcG+w7MgUzkf
         8Tf0yaX7DIyaZDRvFYAM+5zqg8ljW77l344MFMuo4IXO+LBXozg8mQT3lg/AKphKX85O
         8aTw==
X-Received: by 10.60.99.68 with SMTP id eo4mr1613952oeb.126.1364348446482;
 Tue, 26 Mar 2013 18:40:46 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Tue, 26 Mar 2013 18:40:16 -0700 (PDT)
In-Reply-To: <20130326184921.GA26462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219234>

On Wed, Mar 27, 2013 at 1:49 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 26, 2013 at 11:39:28AM -0700, Junio C Hamano wrote:
>
>> The function takes two strings (pathname and basename) as if they
>> are independent strings, but in reality, the latter is always
>> pointing into a substring in the former.
>>
>> Clarify this relationship by expressing the latter as an offset into
>> the former.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> This is a huge improvement in maintainability. My initial fix attempt
> was to just xstrdup() the strings (knowing that the performance would be
> horrible, but I was still investigating correctness issues at that
> point). And of course I ran into this same issue as I tried to make a
> copy of pathname.
>
> So even without the rest of the fix, this is definitely a good idea. :)

match_{base,path}name and their exclude callers do the same thing. I
guess I'm used to it and did not see the maintainability issue. Maybe
we should do the same there too.
-- 
Duy
