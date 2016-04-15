From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 07:16:03 +0700
Message-ID: <CACsJy8C9wA=Yig6n4evqYnpOTqOWKbH4kXH5OaYTRvS_5a+a8A@mail.gmail.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
 <1460153784.5540.19.camel@twopensource.com> <1460417232.5540.53.camel@twopensource.com>
 <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
 <1460482108.5540.59.camel@twopensource.com> <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
 <CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com> <xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w6Z2YXIgw77Ds3I=?= <aevarb@gmail.com>,
	jeffhost@microsoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:16:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrR9-0000M6-H4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcDOAQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:16:36 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34569 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcDOAQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:16:34 -0400
Received: by mail-lf0-f54.google.com with SMTP id j11so127542620lfb.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ntGdM8+1nwme0CHZbDIIgHcMnH7x/8mdrjTPqw4je+8=;
        b=ljam1DtMt89d5JLc2et+Dzv1jRSo38nX1f+db5btAu62UeOYnm3hH46eXPnWZNg2Si
         zKiPPiaS5JIR+GMdl4r+8DpTU+NpHtKyJWv4JGMZICcYmEhvWBdqFz1T5NhQ+Arxm3/U
         lBJv4AdTnsfWSU4euwcGRIXFpFWDuR9+9ToIR39J52+mIRewYxwGwMI8v/XR80ZycU80
         cER/5yHqSm+fyJCP5ntcP9+et0Pfx5O2tpDWQxscna/fDncid2D//iAqCIR8SmnW1G8q
         t9oUxn509IAOOhQheHnsRx/ugOBmUk1npCFyfpJCAqUolmxZkytmOt1SRW1f8RHUfnp2
         fWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ntGdM8+1nwme0CHZbDIIgHcMnH7x/8mdrjTPqw4je+8=;
        b=lVPSMNrQkjkPwuEl2ODz+txQULHn1O2I+mgNw2/QPpvJWtkWcm1dn4TYOwwcLVwzWx
         +viBhpZcCOnZqdSPvsHigA/kyTn8BGgDaeOZLYtWMmy5+PjZrgQTZeDYW3yog+UfGy+F
         JVIehNC0anU1NmHWTKMGJh4UNQv9yhN62NjEguhQ6EjW/MjduTCZHyOPHp3qkRjmGaAV
         KebHbqdD6mYbklPCzifXKszRL78o5IU9ftYQnFKwjL96K4ooJoHxIkFpI53U2VxN05cr
         TLlZOTlA0FMzurwV+IJoMSSiJM36DoLjCDRaLizvNcmOkt/tqlNQze6h9S5rUet21iuW
         ShLg==
X-Gm-Message-State: AOPr4FUjqsDBl1dA4iza7/jsuCCdBbAYG5CrxLeBvdAYtVvzc09gC1hY3ajyYHy5mUvH41DBy20O4fcLxw8xvw==
X-Received: by 10.25.42.1 with SMTP id q1mr7407534lfq.94.1460679393217; Thu,
 14 Apr 2016 17:16:33 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 14 Apr 2016 17:16:03 -0700 (PDT)
In-Reply-To: <xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291582>

On Fri, Apr 15, 2016 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Apr 13, 2016 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>>  - access is slow (unless cached, but we can't be sure)
>>>>
>>>> We could solve this (and the other problem) with mlock.
>>>
>>> Probably you meant madvise(2)?
>>>
>>> For something of a size comparable to the index file held by
>>> index-helper-daemon in-core, I'd expect we wouldn't page too
>>> badly.
>>
>> I had a look at linux implementation of madvise(MADV_WILLNEED). All it
>> does is force populating the entire memory region, which is good. But
>> I suspect when memory is under pressure, some pages may be reclaimed.
>
> I share that suspicion.  Why is such a reclamation bad thing, though?

Because the index is read entirely in memory in the next git process,
it will be slowed down a bit (and the disk error factor creeps in),
but the next one would be fast again. So no, not so bad.

>> index files in monster repo case can go up to a few hundred megabytes,
>> chances of being reclaimed rise accordingly. But we can reconsider
>> mlock() later when/if real problems happen.
>
> Holding onto "a few hundred megabytes" just so that occasional Git
> operations will not stall with the daemon and slowing down the
> overall work of the user by panalizing other elements in the user's
> workflow does not sound like a good trade-off to me.  Wouldn't the
> user better off by not using the daemon at that point, which would
> give the few hundred megabytes back to the system for better uses?

In an ideal world, I would go with multiple index backends and use
something else, maybe lmdb again, more suitable for indexes this size.
But that touches many many places.

We don't hold this memory forever though. If the daemon is idle for a
while, it exits, releasing memory back to system. And not using
mlock() already gives the OS more freedom in memory usage.
-- 
Duy
