From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Thu, 24 Mar 2016 00:16:24 +0530
Message-ID: <CAFZEwPP7DFH=Te3pSdPjNEnVPJ2gVQgtMozQ1W8wdzWDtWi9iQ@mail.gmail.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603231238180.4690@virtualbox>
	<xmqqy499cgrb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:46:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ainna-0001rF-VK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 19:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbcCWSq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 14:46:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34191 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbcCWSqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 14:46:25 -0400
Received: by mail-yw0-f193.google.com with SMTP id f6so2751490ywa.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8WgygY0P6tRmsfcKhpRYPecAIIwWQe19WFaH7e9zI1Y=;
        b=TceeiUsAIPVBFhTDyPmtfRcmdTyiXchLUVRtK0bmMglLYQkgQZGxjDqK165Py5PE70
         mgTiUshs/XpdhNKvWJgQZVpbNPLY9dVeJnc8ja9ZyOQVIGJ6Z7cmuTGod2FAM9CJ6mgZ
         M89i3G4dQY7lNfruDs8ava+2mRb1rAJbkh9gno8zYVasHLfwmvdDnpxDK73Mq1WtZ1Pk
         GH+B7qS9nDoDkT6QH+1l7DBCg3VErhQSodLbD3kDOCZChPiGPuEOPC3oFHto7xzxiBdW
         Cs3W6FuAG7SYNhS8I3/kbM/pCPBcBJo4+qm1wWD6Pza0z2SVn5XWpNN13B2Z+h20M0mq
         tWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8WgygY0P6tRmsfcKhpRYPecAIIwWQe19WFaH7e9zI1Y=;
        b=G1qsXHgJkmI3GhE8bD+1KCN4z+v1ngs8KuNhn+kg3I5E/Cei1alm+t1Rf64wYWRma4
         qQoCc13kKtDcpJ+uIxD5K32ph1kKBCFplmdZTeq9n1YdmRQ7/G+aqNcAbhrErHuOpwyM
         MqD71pIqCFPfWiYEEKCF7wTI8EbnTspsIFGaVcdOCJTbBFXjiZ0dXJM/y1Ui7rKov4Nb
         OnAxCmY0G64F+EPM9luhS8ToHL5nDLFsC2hjO3CutN4juSjxIbKFjk4nGI3cPHQ6iGsO
         eFBqeo9nLNr7oi4/5AgiMVbrLt3hQnpwUDHvLUg4jxQdWu2B7zBP/JnimMdXfHa8fuS+
         BZ4w==
X-Gm-Message-State: AD7BkJKHLjPg8aUdIYGHjBFiIipw3SQrns6Z2QrOaGZE8NabLduqC4Gk/sx+Dz5fSyT01syUqlFmFe6d6VRraw==
X-Received: by 10.129.77.135 with SMTP id a129mr2086354ywb.243.1458758784914;
 Wed, 23 Mar 2016 11:46:24 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 11:46:24 -0700 (PDT)
In-Reply-To: <xmqqy499cgrb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289675>

On Wed, Mar 23, 2016 at 9:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> +    if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
>>> +        "replay", "log", "run", NULL))
>>
>> If I understood Junio correctly, he meant to line up the second line with
>> the corresponding level. In this case, as "replay" is a parameter of the
>> one_of() function, the indentation would look like this instead:
>>
>>       if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
>>                  "replay", "log", "run", NULL))
>
> Thanks for clarification.  It may also make sense to wrap the first
> line one word earlier.
>
>>> +            die("can't use the builtin command '%s' as a term", term);
>>> +
>>> +    /* In theory, nothing prevents swapping
>>> +     * completely good and bad, but this situation
>>> +     * could be confusing and hasn't been tested
>>> +     * enough. Forbid it for now.
>>> +     */
>>
>> I see quite a few comments that put the closing "*/" on its own line, but
>> do not award the same pleasure to the opening "/*". Personally, I much
>> prefer the opening "/*" to have an entire line to itself, too, but I guess
>> that there is enough precendence in Git's source code to accept both
>> forms.
>
> We do want to see "/*" and "*/" on their own lines, and new code
> should definitely do so.

I also think it is better to promote one format and try and reduce the
other one.

>>> +    if (!strcmp(term, "bad") || !strcmp(term, "new"))
>>> +            if (strcmp(revision, "bad"))
>>> +                    die("can't change the meaning of term '%s'", term);
>>> +
>>> +    if(!strcmp(term, "good") || !strcmp(term, "old"))
>>> +            if (strcmp(revision, "good"))
>>> +                    die("can't change the meaning of term '%s'", term);
>>
>> I am still convinced that
>>
>>       if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
>>           (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
>>               die("can't change the meaning of term '%s'", term);
>>
>> looks so much nicer.
>
> ... and more importantly, easier to understand what is going on.

I will take care about this next time.
