From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Sat, 6 Feb 2016 20:06:59 +0530
Message-ID: <CAOLa=ZT6aHxT6C5jc9x=YT+AaeTq7=WCcsWHjAYeg3pWF9sVVA@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:37:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS3zS-0004bN-HE
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 15:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbcBFOha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 09:37:30 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35786 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbcBFOh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 09:37:29 -0500
Received: by mail-vk0-f65.google.com with SMTP id e185so3308881vkb.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lEQj6jd2zIZzYqT9NOx/uFkWRjKAG+uItqMGDsMl3+A=;
        b=WYf0j8LESZmtggZmSf9XWR5kfm+aYmcykXtczwpOtPIxoMS9yvSii0aKeLsYjBqvlM
         FvZpMg1APdartXqWCFtT8zP3Oz2+AVV/GKInC0Mooquxx4WmIvzOpNM+57LuiRAuhzVq
         em90FOJnB0qTlljtxCB76V1wvnQQ2OMKK3rd7jpGjN6BnglBYWIXJU414JSado/pkBwn
         +T9aBlg/e7SWliGqpQg5b3+jw/JwvNGs6dL9xLEGR/tLH1X7sLfyYWnMmRlGDlrJZT0n
         LfleAmrQyciAxusmcNfTZOAY7EOlMGB0mGAgLdZxaYXUN9tFK38bjk6QM29l7bs4VLlU
         CLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lEQj6jd2zIZzYqT9NOx/uFkWRjKAG+uItqMGDsMl3+A=;
        b=CA9OXloBkLzD6C2mxbedUiCVe73C4sN3m+9+DifojgCRotsOID/9P0K3igHDzIAA79
         ft6vW4z+UdtIFzQx9KRAHiTeRYLmCVk5qf2xzH7R0D7q54DL/r/+TGXx6hfp9TfKFbPx
         hILLTb06TPxE3yip5dvrUsO5oZt8OQtKeKr32ZrD6a8efyIi0Scm1OUJKuD/b29BTV3m
         XeJPqNSFI2DWFiv9Gt0mmXqSVEjD1QoiwIv4eWKJoxg9cBhAUUF8Ga5726NOsX/crEO9
         T2Hpm0M/JGuwL4hhMTR5FRiZfnTook8Q4zGknVZ6edghRPVCeeC6OC9JynSEzh8SjVyI
         gC+w==
X-Gm-Message-State: AG10YOSzLyri8Xm+B+inmnrDK6BQC/nuNfeqQS4N8WotMiMANOOZjG1E6dK1DIdMD7400I4oWJAvOZ73KT744A==
X-Received: by 10.31.155.131 with SMTP id d125mr11683000vke.146.1454769448682;
 Sat, 06 Feb 2016 06:37:28 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 06:36:59 -0800 (PST)
In-Reply-To: <CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285691>

On Thu, Feb 4, 2016 at 3:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Parsing atoms is done in populate_value(), this is repetitive and
>> hence expensive. Introduce a parsing function which would let us parse
>> atoms beforehand and store the required details into the 'used_atom'
>> structure for further usage.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
>>  static struct {
>>         const char *name;
>>         cmp_type cmp_type;
>> +       void (*parser)(struct used_atom *atom, const char *arg);
>
> It's a little bit weird to pass in 'arg' as an additional argument
> considering that the parser already has access to the same information
> via the atom's 'name' field. I guess you're doing it as a convenience
> so that parsers don't have to do the strchr(':') or memchr(':')
> themselves (and because parse_ref_filter_atom() already has the
> information at hand), right? A typical parser interested in a
> (possibly optional) argument currently looks like this:
>
>     void parse_foo(struct used_atom *a, const char *arg) {
>         if (!arg)
>             /* default behavior: arg absent */
>         else
>             /* process arg */
>     }
>
> That doesn't change much if you drop the 'arg' argument:
>
>     void parse_foo(struct used_atom *a) {
>         const char *arg = strchr(a->name, ':')
>         if (!arg)
>             /* default behavior: arg absent */
>         else
>             /* process arg */
>     }
>
> It does mean a very minimal amount of duplicated code (the single
> strchr() line per parser), but it also would remove a bit of the
> complexity which this patch adds to parse_ref_filter_atom(). So, I
> dunno...
>

This change is introduced as a result of he suggestion given from Junio[1].
Although we're adding a little complexity to parse_ref_filter_atom() I feel its
justified by the interface provided as you mentioned. This ensures that parser
functions don't need to implement their own methods for getting the arguments
and can rely on being provided the arguments to them.

1: http://article.gmane.org/gmane.comp.version-control.git/283499

>>  } valid_atom[] = {
>>         { "refname" },
>>         { "objecttype" },
>> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>                  * shouldn't be used for checking against the valid_atom
>>                  * table.
>>                  */
>> -               const char *formatp = strchr(sp, ':');
>> -               if (!formatp || ep < formatp)
>> -                       formatp = ep;
>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>> +               arg = memchr(sp, ':', ep - sp);
>
> Why this change from strchr() to memchr()? I understand that you're
> taking advantage of the fact that you know the extent of the string
> via 'sp' and 'ep', however, was the original strchr() doing extra
> work? Even if this change is desirable, it seems somewhat unrelated to
> the overall purpose of this patch, thus might deserves its own.
>

I'm thinking I'll make a patch for that separately. i.e remove strchr()
and introduce memchr() outside the loop.

> Aside from that, although the "expensive" strchr() / memchr() resides
> within the loop, it will always return the same value since it doesn't
> depend upon any condition local to the loop. This implies that it
> ought to be hoisted out of the loop. (This problem is not new to this
> patch; it's already present in the existing code.)
>

Yes, makes sense.

>> +               if ((!arg || len == arg - sp) &&
>> +                   !memcmp(valid_atom[i].name, sp, len))
>>                         break;
>>         }
>>
>> @@ -154,6 +155,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>>         used_atom[at].name = xmemdupz(atom, ep - atom);
>>         used_atom[at].type = valid_atom[i].cmp_type;
>> +       if (arg)
>> +               arg = used_atom[at].name + (arg - atom) + 1;
>
> This is a harder to understand than it ought to be because it's
> difficult to tell at first glance that you don't actually care about
> 'arg' in relation to the original incoming string, but instead use it
> only to compute an offset into the string which is ultimately stored
> in the newly allocated used_atom[]. Re-using 'arg' for a different
> purpose (in a manner of speaking) confuses the issue further.
>
> The intention might be easier to follow if you made it clear that you
> were interested in the *offset* of the argument in the string, rather
> than a pointer into the incoming string which you ultimately don't
> use. A variable named 'arg_offset' might go a long way toward
> clarifying this intention.
>

I hope you mean something like this.

if (arg) {
    int arg_offset;

    arg_offset = (arg - atom) + 1;
    arg = used_atom[at].name + arg_offset;
}


-- 
Regards,
Karthik Nayak
