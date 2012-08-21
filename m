From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Tue, 21 Aug 2012 07:24:41 -0700
Message-ID: <20120821142441.GA56154@mannheim-rule.local>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-6-git-send-email-pclouds@gmail.com>
 <20120821051706.GA55686@mannheim-rule.local>
 <CACsJy8DHdj61sH8DjLsUfKdb4yzbnACWdCsgmFDtjJqq08c2TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 16:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3pNQ-0007Bc-J7
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 16:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab2HUOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 10:24:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43408 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2HUOYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 10:24:09 -0400
Received: by dady13 with SMTP id y13so3035442dad.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BM6ky0mSfXG9RjMxDmO33pb28V2scu48WZgyzOeHGBA=;
        b=I9IMwNbslPDJIlwSi2bICEovH7XxCstwEGwtqM2qWtGHGCwKEl2RH3j0BsZN5sr9Oo
         Y3Rx7NUCxEnlusNVPLnzvB06TB2XXCzWwRW7nyYaoLLXORascyKiUeoBdhRz9zqWuQpj
         Ion83cX9VU5XKgrfEexsUB6YWA5ZegcQAt42dRooG2M+l2JIlxbOnjK/9Pc8ZgkbkgJj
         BtwAsHt2DWUZWZVJCSOeQ7nt2qFuinG36mNBOx9dNxkCw6Wl9SCzCZvytrZfFFFHfJEw
         7kC7mW1E2t5N26h6eQdCVczg5XsXvv2rBcjSjmNG6RFIGu1lzJbWU4JQ7VUnaPn/w28V
         daFw==
Received: by 10.66.78.196 with SMTP id d4mr38170635pax.76.1345559048396;
        Tue, 21 Aug 2012 07:24:08 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pn4sm1542159pbb.50.2012.08.21.07.24.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 07:24:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DHdj61sH8DjLsUfKdb4yzbnACWdCsgmFDtjJqq08c2TQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203966>

Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 21, 2012 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> @@ -35,7 +35,7 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
>>>       printf "0032want %s\n00000009done\n0000" \
>>>               $(git rev-parse HEAD) >input &&
>>>       test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
>>> -     grep "unable to read" output.err &&
>>> +     test_i18ngrep "unable to read" output.err &&
>>>       grep "pack-objects died" output.err
>>
>> Wouldn't it make sense to change the second "grep" of output intended
>> for humans to test_i18ngrep while at it?
>
> This comes from error("git upload-pack: git-pack-objects died with
> error.") in unpack-trees.c, which is not i18n-ized yet. There's
> another test in t5530 that does the same grep. I think we should leave
> it as is until we mark the string for translation, then gettext poison
> will spot it (verified) and we can fix it.

I don't understand the distinction you're making.  Isn't the message
intended for humans, and wouldn't changing that one line to
test_i18ngrep now save trouble later?  Tests are meant to check git's
intended behavior, not to exactly match its current behavior.

Jonathan
