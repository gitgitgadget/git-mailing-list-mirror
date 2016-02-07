From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sun, 7 Feb 2016 14:31:59 +0530
Message-ID: <CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-6-git-send-email-Karthik.188@gmail.com> <CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
 <CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 10:02:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSLEq-0007vv-Ff
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 10:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbcBGJCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 04:02:31 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33887 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcBGJC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 04:02:29 -0500
Received: by mail-vk0-f49.google.com with SMTP id e185so79640821vkb.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 01:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Psw9BLIj2rsTrYUlXvQ/1Aysi0unHjaHhd2Fo9ypQsc=;
        b=Z+huhKTgxoudrl274AthPA2NzvhU/+sdyn+ycdvoPBc8pgfhIamiutTtLV1mKurRXF
         pKXrLI6lVO6BXugw7FJYAo6S3FINKnc3I9NQW5kggVfO4Ope2wNFmI3Q6vnAuYZ7zFNx
         hLNE3P8d8cwflZytdZx+n9ItN+n57NsTjRTTfqKz+o6hZ8E/4x73yEHPUaXft1Nr9Ryi
         y9EuHuP9W1rpWf38GcoKBkMz/plven9PlQfSBeWN9l9l0Xw9JXlNoXt+4RMbB8TJTcnY
         ouXcm9Y/K6uWQojaWpBdAMXUdrle+QiNBSGYMJ0/QqG9/egWEs9gGrPJcpTqMqwDtspn
         UvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Psw9BLIj2rsTrYUlXvQ/1Aysi0unHjaHhd2Fo9ypQsc=;
        b=Jj98IQWbY3oAY2ixOFBSicfhUaR9RJGb/WyDrgKTUAlVyZNTR/cpeS0Jgqwcv0T2OH
         /JeG11xsIeGGF5Wy6rDHkVOVabc9JOlsLdLPFARmPslOlG6PJ6t0COHWl3kbs1BsA/gc
         X0DKu+68bYiRanP00Jscwt4Q8PYC2P7pzaaPwsqixdzGkuaICk83XCVtyjETh6aLxR5q
         r//D/7UQ7NqM/URUptpY68O1mmnBWBMi6FudREafyfCXdzQvcoPYlSuxg21qT5ZOcXaT
         USK9eZDYvBJkFa14KrPIzmPCPIXPW1W3/8n8ZYpO+J/vmMeKq/suVbH0VzJoIdqeFNHP
         Naxg==
X-Gm-Message-State: AG10YOQmtKPLzVnNL4uXiNvX13kylJFbKCxOturSBJ7Jo21vg1etKCBslgBAeyNhK1xRl79vQX1nhfM9fMe18Q==
X-Received: by 10.31.16.37 with SMTP id g37mr15165742vki.97.1454835748757;
 Sun, 07 Feb 2016 01:02:28 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sun, 7 Feb 2016 01:01:59 -0800 (PST)
In-Reply-To: <CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285722>

On Sun, Feb 7, 2016 at 12:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Feb 6, 2016 at 10:15 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Jan 31, 2016 at 11:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>>                  * shouldn't be used for checking against the valid_atom
>>>                  * table.
>>>                  */
>>> -               const char *formatp = strchr(sp, ':');
>>> -               if (!formatp || ep < formatp)
>>> -                       formatp = ep;
>>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>>> +               arg = memchr(sp, ':', ep - sp);
>>> +               if ((!arg || len == arg - sp) &&
>>> +                   !memcmp(valid_atom[i].name, sp, len))
>>>                         break;
>>>         }
>>
>> Also having a look at this, this breaks the previous error checking we
>> had at parse_ref_filter_atom().
>> e.g: git for-each-ref --format="%(refnameboo)" would not throw an error.
>>
>> I think the code needs to be changed to:
>>
>> -               if ((!arg || len == arg - sp) &&
>> +               if ((arg || len == ep - sp) &&
>> +                   (!arg || len == arg - sp) &&
>
> For completeness, for people reading the mailing list archive, a
> couple alternate fixes were presented elsewhere[1], with a personal
> bias toward:
>
>     arg = memchr(...);
>     if (!arg)
>         arg = ep;
>     if (len == arg - sp && !memcmp(...))
>         ...
>
> [1]: http://git.661346.n2.nabble.com/PATCH-ref-filter-c-don-t-stomp-on-memory-tp7647432p7647433.html

There is a slight issue with this solution though, as you see 'arg'
gets modified
here, hence 'arg' passed to parser functions will never will null.

We could do something like
if (arg ==ep)
    arg = NULL;
if (arg)
    arg = used_atom[at].name + (arg - atom) + 1;
if (valid_atom[i].parser)
    valid_atom[i].parser(&used_atom[at], arg);

Else we could avoid this assignment and re-assignment by letting 'arg'
hold the value it gets from memcmp(...) and use the solution provided
by me or Ramsay (preferably)

Ramsay's solution being

 ref-filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index d48e2a3..c98065e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -260,7 +260,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
                 * table.
                 */
                arg = memchr(sp, ':', ep - sp);
-               if ((!arg || len == arg - sp) &&
+               if ((( arg && len == arg - sp)  ||
+                    (!arg && len == ep - sp )) &&
                    !memcmp(valid_atom[i].name, sp, len))
                        break;
        }

-- 
Regards,
Karthik Nayak
