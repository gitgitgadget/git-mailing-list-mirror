From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Wed, 24 Jul 2013 08:57:21 +0700
Message-ID: <CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
 <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com> <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 24 03:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1oKz-0000EJ-1G
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab3GXB5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 21:57:53 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41999 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GXB5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 21:57:52 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so12881597oag.4
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XyBeeYJwg6Pjx6a7ZK2DzYQKGgcICRnH7ERU42hi6uA=;
        b=vZ4j77OA2sFl/KGOyWM487xft39c0AONmy638wEFcTPD22Pw4EwetTAWZaerAEgyPV
         w3kvKtglLhy6tH44OLxnSSlfWs0vLzZ+tuoFknzr+z7Jov+MPiClujtSpUADE/So4ZjF
         cpDZqYoJo/pdaMkAIGBELXzFftCugjzP68daXjiaKlzKXnUlL9SYoVfVsnsMn5SRPJSa
         rDwkWgCqEOXaiXYAawRF81aCbGluCGmhI7it3L48bBk2XY4o5S78bxwIOA3hV370PT87
         ZdJhaM+6S/9v+HQDQKki/sfkMJTqVdfDqu1FLZrqimqrt5/yqMWFOdpLXrecf3+qULzm
         vqaQ==
X-Received: by 10.182.213.10 with SMTP id no10mr27582323obc.76.1374631072285;
 Tue, 23 Jul 2013 18:57:52 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Tue, 23 Jul 2013 18:57:21 -0700 (PDT)
In-Reply-To: <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231073>

On Wed, Jul 24, 2013 at 5:33 AM, Philip Oakley <philipoakley@iee.org> wrote:
> In some sense a project with a sub-module is a narrow clone, split at a
> 'commit' object.

Yes, except narrow clone is more flexible. You have to decide the
split boundary at commit time for sub-module, while you decide the
same at clone time for narrow clone.

> There have been comments on the git-user list about the
> problem of accidental adding of large files which then make the repo's foot
> print pretty large as one use case [Git is consuming very much RAM]. The
> bigFileThreshold being one way of spotting such files as separate objects,
> and 'trimming' them.

I think rewriting history to remove those accidents is better than
working around it (the same for accidentally committing password). We
might be able to spot problems early, maybe warn user at commit time
that they have added an exceptionally large blob, maybe before push
time..

The "Git is consuming very much RAM" part is not right. We try to keep
memory usage under a limit regardless of the size of a blob. There may
be some cases we haven't fixed yet. Reports are welcome.
-- 
Duy
