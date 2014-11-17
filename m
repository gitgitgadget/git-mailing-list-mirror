From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 15:13:27 -0800
Message-ID: <CAGZ79kYHzd8ODEXoZyGSb7dkZfXHAoWoiPEUqhsjedMSAjTiXg@mail.gmail.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<xmqq4mtxxw5z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 00:13:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqVUE-0001Pv-T2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 00:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbaKQXNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 18:13:30 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49657 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaKQXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:13:28 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so7609404iec.20
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Km3KrItkGH3iGIIjozWjQD1BufXj4HYLrc5yd4BCIJI=;
        b=UWCV4Lqqnbph/7YTG3bW4jy0w5zq27Ch3UEZ7o+8e2cjW9KNZBYYI3xH3u4QVU8uNV
         r8jIwsIWdJJIRF2CNboKq/nEqyc3/WfaGXg6Lni0tmtanDX789HS82HDs66QqbFH6y9m
         q7W1Zj+IqYQu5f/E11/HksHoidj/KXCiewZd2rLJoJHQhjvJF+ahlyUB9BE7x3ZH05os
         o2yT9FyFHVjQ9nsjDcGfw+SbVFTmT0GC3+QJasOfksmbsqFcMdd5uH3O4+MjDZwe+rCd
         2T4yXtHuwhJR//AY3FxXUi+wpFde6PcM2Nz/fA9I5+RTvfiJV2yosvXrB6BZNoNm7ADA
         OO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Km3KrItkGH3iGIIjozWjQD1BufXj4HYLrc5yd4BCIJI=;
        b=CUdDep1rUDKzeOkDzeGZRjkPZcgMSPqwPVXo1yAxB5dh5ZH+dGqcyu/XESS0tl461r
         BReyU1NxU96723Nd9ymR+k00wnX1xFh7dZP1I0CuiQqKU3p8HUmqWZCBsK8ewTZGbGHQ
         AMW1WcWbJlKRPHpAq8E9XF7LLYvvhJbm1S30KE3iSxWAje8OmjRWqmJu8l9ldPY9prhd
         uhZp9Qk1CtpAC8hPnw92yszlqH7xnjUUig8M3BPr2a+B4vXs4HmXyTn1RjdX0uM3eHi2
         AlWsdiYMRM8DZ5Vjq8idwFzY9b3yJdsV+cY5dMw8AbB9c38UqnS37pQh5aWpMhW4QaGN
         4Gqw==
X-Gm-Message-State: ALoCoQmSFKOQ+cpWe+G4w9do0yFwqz6o+f+NhJvX7jrO+mwETIfNFaYSlv8Oasmrxg/r0ETIXCjz
X-Received: by 10.50.111.8 with SMTP id ie8mr29211155igb.37.1416266007795;
 Mon, 17 Nov 2014 15:13:27 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Mon, 17 Nov 2014 15:13:27 -0800 (PST)
In-Reply-To: <xmqq4mtxxw5z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am reviewing the series and about to resend it with very minor nits
fixed. I just want to point out this fix is orthogonal to the series
and can be picked up no matter how long the reviewing/discussion of
the series goes.

Thanks,
Stefan

On Mon, Nov 17, 2014 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This patch was sent previously to the list as part of
>> that series[2], but it seems to be unrelated to me.
>
> I am fine to queue obvious and trivial bits first before the larger
> main course.  For now I'll queue this one and also the series that
> has been queued for a while, but at some point I suspect we would
> have to drop the latter.
>
> Thanks.
>
>
>> [1] http://www.mail-archive.com/git@vger.kernel.org/msg61051.html
>> [2] http://www.spinics.net/lists/git/msg240784.html
>>  copy.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/copy.c b/copy.c
>> index f2970ec..a8d366e 100644
>> --- a/copy.c
>> +++ b/copy.c
>> @@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
>>               if (!len)
>>                       break;
>>               if (len < 0) {
>> -                     return error("copy-fd: read returned %s",
>> -                                  strerror(errno));
>> +                     int save_errno = errno;
>> +                     error("copy-fd: read returned %s", strerror(errno));
>> +                     errno = save_errno;
>> +                     return -1;
>> +             }
>> +             if (write_in_full(ofd, buffer, len) < 0) {
>> +                     int save_errno = errno;
>> +                     error("copy-fd: write returned %s", strerror(errno));
>> +                     errno = save_errno;
>> +                     return -1;
>>               }
>> -             if (write_in_full(ofd, buffer, len) < 0)
>> -                     return error("copy-fd: write returned %s",
>> -                                  strerror(errno));
>>       }
>>       return 0;
>>  }
