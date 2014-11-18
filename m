From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Mon, 17 Nov 2014 18:30:00 -0800
Message-ID: <CAGZ79kZ=1qekoKfY5cwdmDp68oU-poTcc6A4Fa7u5LhwCB5HyQ@mail.gmail.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 03:30:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqYYW-0001vY-E6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaKRCaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:30:02 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:53977 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaKRCaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:30:00 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so1209944ier.27
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=int6h8xIJEF4CGRUsAugXFcdfcIDVkI11nyz0STCOrg=;
        b=gD94sSAMQ6M8w11Fk61EHCnK8YkiSKf4aKSju6QQL0fZ3ztZIJZPkdEbSTNSoO55vx
         nbHNyV3oh/6f7dMh6E/cjR4+d+YbFNd2LqSb5Z7BHWlzQ+X36bMI6mW3otsm4+GFRGsj
         7DL5sGnNZqNV9PmmL6H+EQvu6HAjLpMBT/JMXBegfGt6h8UnNWUzBUQ5sTZJif7atBJt
         OqOv8Gckn/zAvLzcsZsBAkT8dTT97FaQIB43hyS4JCPEzhtArrUbjBkOsF9ONw6bOHUg
         1ZFzNsg8U3PPXBXxHcsyuJ0FQoQj6ZGhpNaItP3ZBx4LlPdPS2hPjTzv01PESkMDhyKD
         /Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=int6h8xIJEF4CGRUsAugXFcdfcIDVkI11nyz0STCOrg=;
        b=Jb1aE0mgl43PH5qkQKiRgErwaD4l9FETViyib+e1839j+J76eaq2pfXowP/3wEnn9I
         mlYW+KG/ZfUQvLtZn0YWbD9N/OdQbWfre5qtUGJNQktwyR8KMepUvcKWs3RE7IfU5oy8
         hPx4o0ug9zl95FA4K8/fe49cAyjRyANYvVVL29iMBYQvCSkR3FrEDCjE8RIAgJm9fiaC
         d+SQLHXnzN55QxxQv6LhKFvhhV9YVu6YJ1Q9FkH/mtg2bFpm7mJAAXxPAT5BEqIa+mXy
         vnjWRrLGlUDQvh+8gYwG81YlkhH1S4/G0cPpOg1r/vALtxzBhjRWptWH7cgsN8IX+fdo
         916Q==
X-Gm-Message-State: ALoCoQla3QRTSil62neDluFYPCD0RYucR705i2T+NT7Ph2NXORj+4ODkirX0pAfx5unIKPxkRS9X
X-Received: by 10.50.79.229 with SMTP id m5mr29850685igx.10.1416277800212;
 Mon, 17 Nov 2014 18:30:00 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Mon, 17 Nov 2014 18:30:00 -0800 (PST)
In-Reply-To: <xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

thanks for pointing out, why my patch doesn't make sense here.

Do we have similar filters somewhere in place already,
so I could have a look at the code architecture,
the api, and how the user would operate that?

The way you're proposing, doesn't sound as if a hook would be the right
thing for such filtering.

The one big thing I liked over the first patch in this thread was the
'maintainability',
i.e. if it were a hook, I could set that up and forget about it.
No need to change my behavior in using git, but still I have the
desired postprocessed
results.
A command line option for such filtering is inconvenient because of
having it type
all the time and not just having it setup and forgetting about it.
Sure we can have a command line option to specify such a filter,
but I'd be more interested in having an option in maybe the git config file like

[format-patch]
  external-commit-message-stream-processor = $(GIT_DIR)/../foo/bar.sh

The command line option would rather only be used to override that
config in non-default cases.

Thanks for your thoughts,
Stefan











On Mon, Nov 17, 2014 at 11:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +post-format-patch
>>> +~~~~~~~~~~~~
>>> +
>>> +This hook is called after format-patch created a patch and it is
>>> +invoked with the filename of the patch as the first parameter.
>>
>> Such an interface would not work well with --stdout mode, would it?
>>
>> And if this only works with output generated into the files, then
>>
>>     $ git format-patch $range | xargs -n1 $your_post_processing_script
>>
>> would do the same without any change to Git, I would imagine.
>>
>> So I would have to say that I am fairly negative on this change in
>> the presented form.
>>
>> An alternative design to implement this as a post-processing filter
>> to work for both "to individual files" and "to standard output
>> stream" output filter may be possible, but even in that case I am
>> not sure if it is worth the churn.
>>
>> In general I'd look at post-anything hook that works locally with a
>> great suspicion, so that may partly be where my comment above is
>> coming from.  I dunno.
>
> Another reason, in addition to that this only works on the already
> created output files, why I find this particular design distasteful
> (I am not saying that there should be an easy way to drop cruft left
> by third-party systems such as "Change-id:" line) is because the
> mechanism the patch adds does not attempt to take advantage of being
> inside Git, so the "xargs -n1" above is strictly an equivalent.  You
> have a chance to make the life better for users, but not you are not
> doing so.
>
> The design of this feature could be made to allow the user to
> specify a filter to munge _ONLY_ the log message part.  For example,
> just after logmsg_reencode() returns the proposed commit log message
> to msg in pretty.c::pretty_print_commit(), you can detect a request
> to use some external filter program and let the program munge the
> message.  With such a design:
>
>  * The external filter your users would write does not have to worry
>    about limiting its damage only to the log message part, as it
>    will never see the patch text part; and
>
>  * The same mechanism would work just as well for --stdout mode.
>
> The former is what I mean by "to take advantage of being inside".
> Incidentally, it falls into #2 of "5 valid reasons to admit a new
> hook" [*1*].
>
>
> [Reference]
>
> *1* http://thread.gmane.org/gmane.comp.version-control.git/232809/focus=71069
