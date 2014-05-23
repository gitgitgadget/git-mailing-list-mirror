From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Fri, 23 May 2014 07:59:21 -0700
Message-ID: <CAL=YDWnRkwX3dCv9dyZmBdh2ZV7aSUCS=F6w67gJuBmCzGGBwQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-42-git-send-email-sahlberg@google.com>
	<20140522181722.GT12314@google.com>
	<CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
	<CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
	<20140522234440.GA12314@google.com>
	<20140522235351.GB12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 16:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnqwQ-0007M8-Je
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 16:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaEWO7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 10:59:22 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:60668 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaEWO7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 10:59:22 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so6374508veb.36
        for <git@vger.kernel.org>; Fri, 23 May 2014 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wTC1NhbPXDBUHTCaXht5Ngq21GvtnO1UCW165ErmAwk=;
        b=pAfaLgr3r1124NeQJh4uvaLPWOc5YW9Xvm7fdlKILMCIIj6NyiQw1px5JyqM9qFOvz
         myIhmlwjEpheUf3GkL5R5F5nZNVWqycaChrQ9v3eA4OYQE20bA/gmnUh7QEyMd4Folnm
         wzJMF4M3NeR0S091imZco+RgwlEKetUxRcXItr/umgjyGS9Lme4wKr7c1oPA5OCO+8y4
         IKon1/kqnqE+zFWoUxm9TZWf1ZeNJf+ADrXUGgUB3CuNYEeOC5CA2bT1yPmTP830RPVw
         bd555QUsR7H9jGcZUOXXdRNkVfUase4FueU38OZiZTOIiMhb8u6RJk9DfgOT2b0VZCjJ
         /cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wTC1NhbPXDBUHTCaXht5Ngq21GvtnO1UCW165ErmAwk=;
        b=VPNyhmI/w4Dh3jGALOfNTWe9HfiGVSwrbysvENQX8G7wNcECpLqAoC8FFxHZtV/3lE
         C6mdtt/bKfHccdIANUmjJ/beh67TZnDGEpq+sNMS14wOh140F4zsc+tO/IQe5xrEWodr
         VjLFXfwM6BkLonkvcrrrrtFGlbkdG8jU6lj5G1ROBVBIDvlv+VDs+5wf394M8OFbYhZc
         KWlUIgvl1q0hx9em0wqOZj3kcIWt0aXxmM4HI91pUA9IQlT4c2+UDptG3mOOF6twytA4
         0qhHM63YWaLHcm7HtoZLtdOoJ6rF6f3YcPRquFrraQr6UbwHLmoN0WL1Hse43QUZHh6g
         JQLQ==
X-Gm-Message-State: ALoCoQlctg857iXTF7Xb9eFrdjydKd4aiUciyL6Lp7Xy8ySdv4rTbCqh4RUSGg/lYVl4buUUCQmr
X-Received: by 10.58.66.195 with SMTP id h3mr963639vet.57.1400857161389; Fri,
 23 May 2014 07:59:21 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 23 May 2014 07:59:21 -0700 (PDT)
In-Reply-To: <20140522235351.GB12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249990>

On Thu, May 22, 2014 at 4:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>> Ronnie Sahlberg wrote:
>
>>> I hate rename_ref :-)
>>>
>>> I have reworked the transaction code to special case the deletion of
>>> the old ref for n/n -> n  and n -> n/n renames
>>> so that we can carefully avoid n/n.lock files to exist or prevent the
>>> directory <-> file transition for n during these renames.
> [...]
>>       Unlink the corresponding loose refs so packed-refs
>>               becomes authoritative for them.
>>       Lock packed-refs.
>>       Perform updates and removals in the packed-refs cache.
>>       Commit packed-refs.
>
> ... or is the problem that the reflogs conflict?
>
> How does rename_ref handle propagating the reflog from the old
> name to the new name, by the way?

I haven't touched that yet, but we can fix it after the next series
when we have transaction support for reflogs.

It still renames the reflog via the magic name
#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"

and thus, if you run two renames at the same time there is a race that
might make you end up with the wrong reflog after the rename.



>
> Thanks,
> Jonathan
