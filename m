From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t4059: test 'diff --cc' with a change from only
 few parents
Date: Sat, 11 Apr 2015 14:20:03 -0700
Message-ID: <CAPc5daVkhEGQRhCjVpV4wh+cNyfz5yFrAaBrc9re0YM=rtSw+g@mail.gmail.com>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net> <1428076716-4449-2-git-send-email-max@max630.net>
 <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yh2pJ-0003U8-Eb
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 23:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbbDKVUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2015 17:20:25 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35806 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933007AbbDKVUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 17:20:24 -0400
Received: by qkhg7 with SMTP id g7so95995422qkh.2
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l7B9Hn5vJ1ZQSsqQ0mGbiarLi5ncebzDk2x6m+tN7h0=;
        b=uMDsxqBY2R2MgZAm+HChoDbIRgPZhrIqQLpRjnIGYkecEYoaFk8WwPJLlIT7xnk6AU
         gj5vVIQ9yX1qwshBdUpzrqwqKdr9djBsUklCHSf9yGo4VWfigPxQcgJlihUUZDr+u1kU
         P2BHAZ9OEbNxYPRwnwwE9X2b9piNVxdbQFYpAFF82zCQNTk4/drEo3mxLP/vcezesL9e
         Y1FQ6/mm3DLGnh6GmCrwqLOXIjnVFpSdrUKJkpmEed4rICU2iZ3J2fsyPG1IoO4yVhEz
         FSd2vgpMANXABqMIfq7g6NJTNGdmGXbHpNmdYNmb+QWi+TSGZRjv6LrYH/xavhtaUj3l
         Uikg==
X-Received: by 10.182.39.195 with SMTP id r3mr7321048obk.44.1428787223639;
 Sat, 11 Apr 2015 14:20:23 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Sat, 11 Apr 2015 14:20:03 -0700 (PDT)
In-Reply-To: <xmqqa8ye5q7m.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: af0bndi0bCHMQHxieRRSFfi2iNY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267034>

On Sat, Apr 11, 2015 at 2:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Especially, we need to pay close attention to the discussion that
> germinated the current behaviour:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15519
>
> I recall that the "diff --cc" before that change was not discarding
> uninteresting merges sufficiently and the two commits were a
> deliberate attempt to reject what your series wants to show as
> uninteresting hunks.
>
> Two suggestions.
>
>  - This is primarily for 2/4, but can we make it more clear in the

Eh, sorry, I obviously meant 3/4. And let me half-retract this suggestion
and put it on hold; the code-flow has become sufficiently different that
special-casing two-way merge may not be worth it after all.

>    code that we do this "include more" change only on Octopus
>    merges?  This change should not make any difference for two-way
>    merges and I'd prefer to avoid extra processing of finding
>    matching hunks and combining, only to discard the result.
>
>  - Can you run "diff --cc" with and without your patches to the
>    "merge from hell" commit mentioned in the original thread and see
>    if we show more hunks with your patches, and make sure what are
>    shown additionally looked really "interesting"?

This one still stands. We'd be interested to see what difference this
makes in the real world project history.

Thanks.
